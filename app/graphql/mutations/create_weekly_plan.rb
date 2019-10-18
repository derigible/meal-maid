# frozen_string_literal: true

class Mutations::CreateWeeklyPlan < Mutations::BaseMutation
  graphql_name 'CreateWeeklyPlan'
  null true

  WeeklyPlan::TIME_SLOTS.each do |time_slot|
    argument time_slot.to_sym, ID, required: false, prepare: GraphqlHelpers.relay_or_legacy_id_prepare_func('Recipe')
  end

  field :weekly_plan, Types::WeeklyPlanType, null: true
  field :errors, [String], null: false

  def resolve(**time_slots)
    weekly_plan = account.weekly_plans.new(added_time_slots(time_slots))

    if weekly_plan.save
      {
        weekly_plan: weekly_plan,
        errors: []
      }
    else
      {
        weekly_plan: nil,
        errors: weekly_plan.errors.full_messages
      }
    end
  end

  private

  def added_time_slots(time_slots)
    added_recipes = {}
    time_slots.each do |time_slot, recipe_id|
      next unless WeeklyPlan::TIME_SLOTS.include?(time_slot)

      added_recipes["#{time_slot.to_sym}_id"] = recipe_id
    end
    added_recipes
  end
end
