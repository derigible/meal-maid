# frozen_string_literal: true

module Types
  class InventoryItemType < Types::BaseObject
    global_id_field :id

    field :amount, Float, null: true
    field :exipration, Types::Scalars::DateTimeType, null: true
    field :used, Boolean, null: true
    field :created_at, Types::Scalars::DateTimeType, null: true
    field :updated_at, Types::Scalars::DateTimeType, null: true
    field :item, Types::ItemType, null: true
    field :account, Types::AccountType, null: true

    def account
      AssociationLoader.for(InventoryItem, :account).load(obj)
    end

    def item
      AssociationLoader.for(PlannedItem, :item).load(obj)
    end
  end
end
