# frozen_string_literal: true

class MealMaidSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
