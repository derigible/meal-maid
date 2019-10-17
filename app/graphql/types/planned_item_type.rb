# frozen_string_literal: true

module Types
  class PlannedItemType < Types::BaseObject
    global_id_field :id

    field :weekly_plan, Types::WeeklyPlanType, null: true
    field :ingredient, Types::RecipeItemType, null: true
    field :inventory_item, Types::InventoryItemType, null: true

    def weekly_plan
      AssociationLoader.for(PlannedItem, :weekly_plan).load(obj)
    end

    def ingredient
      AssociationLoader.for(PlannedItem, :recipe_item).load(obj)
    end

    def inventory_item
      AssociationLoader.for(PlannedItem, :inventory_item).load(obj)
    end
  end
end
