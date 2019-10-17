# frozen_string_literal: true

module Types
  class RecipeItemType < Types::BaseObject
    field :amount, Float, null: true
    field :item, Types::ItemType, null: true do
      argument :id, ID, required: true
    end
    field :recipe, Types::RecipeType, null: true do
      argument :id, ID, required: true
    end

    def item(id:)
      RecordLoader.for(Item).load(id)
    end

    def recipe(id:)
      RecordLoader.for(Recipe).load(id)
    end
  end
end
