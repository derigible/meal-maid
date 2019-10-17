# frozen_string_literal: true

module Types
  class RecipeType < Types::BaseObject
    global_id_field :id

    description 'A recipe.'

    field :title, String, null: true
    field :time, Float, null: true
    field :rating, Integer, null: true
    field :directions, String, null: true
    field :notes, String, null: true
    field(
      :ingredients_connection,
      Types::RecipeItemType.connection_type,
      null: true,
      description: 'The ingredients in the recipe.'
    )
    field :account, Types::AccountType, null: true

    def account
      AssociationLoader.for(Recipe, :account).load(obj)
    end

    def ingredients_connection
      AssociationLoader.for(Recipe, :recipe_items).load(obj)
    end
  end
end
