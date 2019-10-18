# frozen_string_literal: true

FactoryBot.define do
  factory :weekly_plan do
    account
    week_number { Time.zone.now.to_date.cweek }
    year { Time.zone.now.year }
  end
end
