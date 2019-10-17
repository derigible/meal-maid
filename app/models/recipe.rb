# frozen_string_literal: true

class Recipe < ApplicationRecord
  has_many :recipe_items, inverse_of: :recipe, dependent: :destroy
  belongs_to :account

  %i[
    monday_morning monday_midday monday_evening
    tuesday_morning tuesday_midday tuesday_evening
    wednesday_morning wednesday_midday wednesday_evening
    thursday_morning thursday_midday thursday_evening
    friday_morning friday_midday friday_evening
    saturday_morning saturday_midday saturday_evening
    sunday_morning sunday_midday sunday_evening
  ].each do |time_slot|
    has_many(
      time_slot.to_s.pluralize,
      inverse_of: time_slot,
      class_name: 'WeeklyPlan',
      primary_key: "#{time_slot}_id",
      dependent: :nullify
    )
  end

  delegate :access?, to: :account
end
