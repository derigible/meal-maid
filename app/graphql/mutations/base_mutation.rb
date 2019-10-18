# frozen_string_literal: true

class Mutations::BaseMutation < GraphQL::Schema::RelayClassicMutation
  object_class Types::BaseObject
  field_class Types::BaseField
  input_object_class Types::BaseInputObject

  def current_user
    context[:current_user]
  end

  delegate :account, to: :current_user
end
