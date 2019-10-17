# frozen_string_literal: true

module Types
  class ItemType < Types::BaseObject
    field :name, String, null: true
    field :account, Types::AccountType, null: true do
      argument :id, ID, required: true
    end

    def account(id:)
      RecordLoader.for(Account).load(id)
    end
  end
end
