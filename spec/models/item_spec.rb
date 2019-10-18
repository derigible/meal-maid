# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Item, type: :model do
  describe '#validations' do
    subject { build(:item) }

    it { is_expected.to be_valid }
  end
end
