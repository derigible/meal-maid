class RecipeItem < ApplicationRecord
  belongs_to :item
  has_many :planned_items, inverse_of: :planned_item, dependent: :destroy
  belongs_to :recipe
end
