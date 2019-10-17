# frozen_string_literal: true

module Types
  class RecipeItemType < Types::BaseObject
    global_id_field :id

    field :amount, Float, null: true
    field :item, Types::ItemType, null: true
    field :recipe, Types::RecipeType, null: true

    def item
      AssociationLoader.for(RecipeItem, :item).load(obj)
    end

    def recipe
      AssociationLoader.for(RecipeItem, :recipe).load(obj)
    end
  end
end
