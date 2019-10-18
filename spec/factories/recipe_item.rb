# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_item do
    amount { rand(1.0..10.5) }
    item
    recipe
  end
end
