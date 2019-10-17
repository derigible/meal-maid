# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    implements GraphQL::Types::Relay::Node

    def current_user
      context[:current_user]
    end
  end
end
