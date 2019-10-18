# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    sequence(:title) { |n| "recipe title #{n}" }
    account
    time { rand(0..45) }
    rating { rand(1..5) }
    directions { 'This is my aweomse directions' }
    notes { 'Some awesome notes' }

    factory :recipe_with_items do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        items_count { 5 }
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |recipe, evaluator|
        evaluator.items_count.times do
          item = create(:item, account: recipe.account)
          create(:recipe_item, recipe: recipe, item: item)
        end
      end
    end
  end
end
