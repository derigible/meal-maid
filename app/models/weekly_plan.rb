# frozen_string_literal: true

TIME_SLOTS = %i[
  monday_morning monday_midday monday_evening
  tuesday_morning tuesday_midday tuesday_evening
  wednesday_morning wednesday_midday wednesday_evening
  thursday_morning thursday_midday thursday_evening
  friday_morning friday_midday friday_evening
  saturday_morning saturday_midday saturday_evening
  sunday_morning sunday_midday sunday_evening
].freeze

class WeeklyPlan < ApplicationRecord
  belongs_to :account
  TIME_SLOTS.each do |time_slot|
    belongs_to time_slot.to_sym, class_name: 'Recipe', inverse_of: time_slot.to_s.pluralize.to_sym, optional: true
  end
  has_many :planned_items, dependent: :destroy, inverse_of: :weekly_plan

  after_save :update_planned_items

  delegate :access?, to: :account

  private

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
