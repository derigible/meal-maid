# frozen_string_literal: true

module Types
  class ItemType < Types::BaseObject
    global_id_field :id

    field :name, String, null: true
    field :account, Types::AccountType, null: true

    def account
      AssociationLoader.for(Item, :account).load(obj)
    end
  end
end
