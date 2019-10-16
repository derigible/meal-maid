class WeeklyPlan < ApplicationRecord
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
    belongs_to :recipe, foreign_key: time_slot, inverse_of: time_slot
  end
end
