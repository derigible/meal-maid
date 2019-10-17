# frozen_string_literal: true

class InventoryItem < ApplicationRecord
  belongs_to :item
  belongs_to :account
  has_one :planned_item, dependent: :nullify

  delegate :access?, to: :account
end
