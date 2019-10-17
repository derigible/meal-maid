# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

l = PasswordLogin.create(
  email: 'mphillips@outlook.com',
  password: 'password',
  password_confirmation: 'password'
)

a = l.user.account

items = []
%w(corn beans rice tortillas salsa cheese).each do |item|
  i = a.items.create! name: item
  items << i
  ii = a.inventory_items.create! amount: (1..100).to_a.sample, expiration: 1.week.from_now, item: i
end

recipes = []
20.times do |i|
  recipe = a.recipes.create!(
    title: "Recipe #{i}",
    time: i,
    rating: (0..6).to_a.sample,
    directions: 'Simple directions',
    notes: 'This is awesome!',

  )
  items.sample(3).each do |item|
    recipe.recipe_items.create!(amount: (0..20).to_a.sample, item: item)
  end
  recipes << recipe
end

a.weekly_plans.create!(
  monday_morning: recipes.sample,
  tuesday_morning: recipes.sample,
  wednesday_morning: recipes.sample,
  thursday_morning: recipes.sample,
  friday_morning: recipes.sample,
  saturday_morning: recipes.sample,
  sunday_morning: recipes.sample,
  week_number: Time.zone.now.to_date.cweek,
  year: Time.zone.now.year
)
a.weekly_plans.create!(
  monday_midday: recipes.sample,
  tuesday_midday: recipes.sample,
  wednesday_midday: recipes.sample,
  thursday_midday: recipes.sample,
  friday_midday: recipes.sample,
  saturday_midday: recipes.sample,
  sunday_midday: recipes.sample,
  week_number: 1.week.from_now.to_date.cweek,
  year: Time.zone.now.year
)
a.weekly_plans.create!(
  monday_evening: recipes.sample,
  tuesday_evening: recipes.sample,
  wednesday_evening: recipes.sample,
  thursday_evening: recipes.sample,
  friday_evening: recipes.sample,
  saturday_evening: recipes.sample,
  sunday_evening: recipes.sample,
  week_number: 2.week.from_now.to_date.cweek,
  year: Time.zone.now.year
)
