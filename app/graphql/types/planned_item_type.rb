# frozen_string_literal: true

module Types
  class PlannedItemType < Types::BaseObject
    field :weekly_plan, Types::WeeklyPlanType, null: true do
      argument :id, ID, required: true
    end

    field :ingredient, Types::RecipeItemType, null: true do
      argument :id, ID, required: true
    end

    field :inventory_item, Types::InventoryItemType, null: true do
      argument :id, ID, required: true
    end

    def weekly_plan(id:)
      RecordLoader.for(WeeklyPlan).load(id)
    end

    def ingredient(id:)
      RecordLoader.for(RecipeItem).load(id)
    end

    def inventory_item(id:)
      RecordLoader.for(InventoryItem).load(id)
    end
  end
end
