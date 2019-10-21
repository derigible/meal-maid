# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    graphql_name 'Query'

    add_field GraphQL::Types::Relay::NodeField

    field :account, Types::AccountType, null: true

    delegate :account, to: :current_user

    field(
      :weekly_plans,
      [Types::WeeklyPlanType],
      description: 'All available weeklyplans. Can be filtered by id.',
      null: true
    ) do
      argument :id, ID, required: false, prepare: GraphqlHelpers.relay_or_legacy_id_prepare_func('WeeklyPlan')
    end

    field(
      :current_weekly_plan,
      Types::WeeklyPlanType,
      description: 'Weekly plan for the current week.',
      null: true
    )

    field(
      :recipes, [Types::RecipeType], description: 'All available recipes. Can be filtered by id.', null: true
    ) do
      argument :id, ID, required: false, prepare: GraphqlHelpers.relay_or_legacy_id_prepare_func('Recipe')
    end

    field(
      :user,
      Types::UserType,
      description: 'The user that is currently logged in.',
      null: false
    )

    def current_weekly_plan
      year = Time.zone.now.year
      week = Time.zone.now.to_date.cweek
      current_user.account.weekly_plans.find_by(year: year, week_number: week)
    end

    def weekly_plans(id: nil)
      scope = current_user.account.weekly_plans
      return scope unless id

      scope.where(id: id)
    end

    def recipes(id: nil)
      scope = current_user.account.recipes
      return scope unless id

      scope.where(id: id)
    end

    def user
      current_user
    end
  end
end
