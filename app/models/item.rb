# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :inventory_items, inverse_of: :item, dependent: :destroy
  has_many :recipe_items, inverse_of: :item, dependent: :destroy
  belongs_to :account

  delegate :access?, to: :account
end
