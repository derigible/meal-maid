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
  end
end
