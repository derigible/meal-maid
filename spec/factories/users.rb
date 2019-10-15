# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com" }
    account
  end
end
