# frozen_string_literal: true

module Types
  class AccountType < Types::BaseObject
    description 'The account under which the user interacts. Basically a shell to capture the user\'s data.'

    field :inventory_items_connection, Types::InventoryItemType.connection_type, null: false

    field :recipes_connection, Types::RecipeType.connection_type, null: false

    field :weekly_plans_connection, Types::WeeklyPlanType.connection_type, null: false

    def inventory_items_connection
      AssociationLoader.for(Account, :inventory_items).load(obj)
    end

    def recipes_connection
      AssociationLoader.for(Account, :recipes).load(obj)
    end

    def weekly_plans_connection
      AssociationLoader.for(Account, :weekly_plans).load(obj)
    end
  end
end
