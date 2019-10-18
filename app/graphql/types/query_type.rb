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
