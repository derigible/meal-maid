# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Recipe, type: :model do
  describe '#validations' do
    subject { build(:recipe) }

    it { is_expected.to be_valid }
  end
end
