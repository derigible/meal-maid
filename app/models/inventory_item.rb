class InventoryItem < ApplicationRecord
  belongs_to :item
  belongs_to :account
  has_one :planned_item, optional: true, dependent: :nullify
end
