# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :users, inverse_of: :account, dependent: :destroy
end
