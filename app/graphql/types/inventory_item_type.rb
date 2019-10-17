# frozen_string_literal: true

module Types
  class InventoryItemType < Types::BaseObject
    field :amount, Float, null: true
    field :exipration, Types::Scalars::DateTimeType, null: true
    field :used, Boolean, null: true
    field :created_at, Types::Scalars::DateTimeType, null: true
    field :updated_at, Types::Scalars::DateTimeType, null: true

    field :item, Types::ItemType, null: true do
      argument :id, ID, required: true
    end

    field :account, Types::AccountType, null: true do
      argument :id, ID, required: true
    end

    def account(id:)
      RecordLoader.for(Account).load(id)
    end

    def item(id:)
      RecordLoader.for(Item).load(id)
    end
  end
end
