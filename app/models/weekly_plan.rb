# frozen_string_literal: true

class WeeklyPlan < ApplicationRecord
  TIME_SLOTS = %i[
    monday_morning monday_midday monday_evening
    tuesday_morning tuesday_midday tuesday_evening
    wednesday_morning wednesday_midday wednesday_evening
    thursday_morning thursday_midday thursday_evening
    friday_morning friday_midday friday_evening
    saturday_morning saturday_midday saturday_evening
    sunday_morning sunday_midday sunday_evening
  ].freeze

  belongs_to :account
  TIME_SLOTS.each do |time_slot|
    belongs_to time_slot.to_sym, class_name: 'Recipe', inverse_of: time_slot.to_s.pluralize.to_sym, optional: true
  end
  has_many :planned_items, dependent: :destroy, inverse_of: :weekly_plan

  validate :week_and_year, on: :create
  validate :week_and_year_unchanged, on: :update
  validates :week_number, uniqueness: { scope: %i[year account] }

  after_save :update_planned_items

  delegate :access?, to: :account

  private

  def week_and_year
    current_week, current_year = normalize_week_and_year
    return if past?(current_week, current_year)
    return if invalid_week?

    too_far_in_future?(current_week, current_year)
  end

  def invalid_week?
    errors.add(:week_number, "Week #{week_number} impossible.") and return true if week_number > 52 || week_number < 1
  end

  def past?(cweek, cyear)
    errors.add(:year, "Year #{year} in the past.") and return true if cyear > year
    errors.add(:week_number, "Week #{week_number} in the past.") and return true if cyear == year && week_number < cweek
  end

  def normalize_week_and_year
    now = Time.zone.now
    current_week = now.to_date.cweek
    current_year = now.year
    self.week_number ||= current_week
    self.year ||= current_year
    [current_week, current_year]
  end

  def too_far_in_future?(cweek, cyear)
    too_far = (year > cyear && cweek > 48 && (week_number + 52 - cweek) > 5) || week_number > cweek + 5
    errors.add(:week_number, "Week #{week_number} with year #{year} too far in future.") if too_far
  end

  def week_and_year_unchanged
    errors.add(:week_number, 'Week changed!') if week_number_changed?
    errors.add(:year, 'Year changed!') if year_changed?
  end

  def update_inventory
    # TODO: in a background job update the inventory (probably stored as jsonb on account)
  end

  def update_planned_items
    # TODO: kick this off with a background job
    destroy_planned_items(changed_time_slots)
    create_planned_items(changed_time_slots)
    update_inventory unless changed_time_slots.empty?
  end

  def changed_time_slots
    @changed_time_slots ||= changes.keys do |k|
      changed_time_slots << k if TIME_SLOTS.include?(k.to_sym)
    end
  end

  def destroy_planned_items(changed_time_slots)
    planned_items.where(time_slot: changed_time_slots).destroy_all
  end

  def create_planned_items(changed_time_slots)
    changed_time_slots.each do |ts|
      RecipeItems.where(recipe_id: changes[ts].last).find_each do |ri|
        planned_items.create recipe_item: ri, time_slot: ts
      end
    end
  end
end
