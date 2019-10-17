# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :users, inverse_of: :account, dependent: :destroy
  has_many :weekly_plans, inverse_of: :account, dependent: :destroy
  has_many :recipes, inverse_of: :account, dependent: :destroy
  has_many :inventory_items, inverse_of: :account, dependent: :destroy
  has_many :items, inverse_of: :account, dependent: :destroy

  def access?(user)
    users.include?(user)
  end
end
