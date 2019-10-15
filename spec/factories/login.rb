# frozen_string_literal: true

FactoryBot.define do
  factory :login do
    user
    sequence(:identifier) { |n| "person_#{n}@example.com" }
    sequence(:name) { |n| "My Name #{n}" }
    provider { 'identity' }
    sequence(:uid)

    trait :confirmed do
      confirmed_at { 1.day.ago }
      confirmation_sent_at { 2.days.ago }
    end
  end
end
