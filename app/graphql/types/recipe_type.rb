# frozen_string_literal: true

module Types
  class RecipeType < Types::BaseObject
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
    field :account, Types::AccountType, null: true do
      argument :id, ID, required: true
    end

    def account(id:)
      RecordLoader.for(Account).load(id)
    end

    def ingredients_connection
      AssociationLoader.for(Recipe, :recipe_items).load(obj)
    end
  end
end
