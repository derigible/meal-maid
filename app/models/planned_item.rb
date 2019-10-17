# frozen_string_literal: true

class PlannedItem < ApplicationRecord
  belongs_to :inventory_item, optional: true
  belongs_to :weekly_plan
  belongs_to :recipe_item

  delegate :access?, to: :weekly_plan
end
