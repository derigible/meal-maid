# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RecipeItem, type: :model do
  describe '#validations' do
    subject { build(:recipe_item) }

    it { is_expected.to be_valid }
  end
end
