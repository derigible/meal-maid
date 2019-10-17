# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_weekly_plan, mutation: Mutations::CreateWeeklyPlan
  end
end
