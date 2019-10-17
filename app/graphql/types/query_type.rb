# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    graphql_name 'Query'

    add_field GraphQL::Types::Relay::NodeField

    field :weekly_plan, Types::WeeklyPlanType, null: true do
      argument :id, ID, required: true
    end
    def weekly_plan(id:)
      RecordLoader.for(WeeklyPlan).load(id)
    end

    field :weekly_plans, [Types::WeeklyPlanType], description: 'All available weeklyplans', null: true

    def weekly_plans
      current_user.account.weekly_plans
    end
  end
end
