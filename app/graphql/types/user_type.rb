# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    global_id_field :id

    description 'A user.'

    field :display_name, String, null: true
    field :email, String, null: true
    field :preferred_name, String, null: true

    def display_name
      object.display_name || object.preferred_name
    end
  end
end
