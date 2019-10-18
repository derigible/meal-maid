# frozen_string_literal: true

require 'spec_helper'

RSpec.describe WeeklyPlan, type: :model do
  describe '#validations' do
    subject { weekly_plan }

    let_once(:account) { create :account }
    let(:params) { {} }
    let(:weekly_plan) { build(:weekly_plan, account: account, **params) }

    it { is_expected.to be_valid }

    context 'with transition into new year' do
      let(:params) { { year: 2020, week_number: 4 } }

      it do
        new_time = Time.zone.local(2019, 12, 21, 12, 0, 0)
        Timecop.freeze(new_time) do
          is_expected.to be_valid
        end
      end
    end

    context 'with duplicate year, week, and account' do
      let(:params) do
        { week_number: other_plan.week_number, account: other_plan.account, year: other_plan.year }
      end
      let(:other_plan) { create :weekly_plan }

      it { is_expected.to_not be_valid }
    end

    context 'with duplicate year and week but separate account' do
      let(:params) do
        { week_number: other_plan.week_number, year: other_plan.year }
      end
      let(:other_plan) { create :weekly_plan }

      it { is_expected.to be_valid }
    end

    context 'with last year' do
      let(:params) { { year: 1.year.ago.year } }

      it { is_expected.to_not be_valid }
    end

    context 'with last week' do
      let(:params) { { week_number: 1.week.ago.to_date.cweek } }

      it { is_expected.to_not be_valid }
    end

    context 'with impossible week' do
      let(:params) { { week_number: 53 } }

      it { is_expected.to_not be_valid }

      context 'when week is below 1' do
        let(:params) { { week_number: 0 } }

        it { is_expected.to_not be_valid }
      end
    end

    context 'with week on edge of limit' do
      let(:params) { { week_number: 52 } }

      it do
        new_time = Time.zone.local(2019, 12, 14, 12, 0, 0)
        Timecop.freeze(new_time) do
          is_expected.to be_valid
        end
      end
    end

    context 'with week too far in future' do
      let(:params) { { week_number: 7 } }

      it do
        new_time = Time.zone.local(2019, 1, 1, 12, 0, 0)
        Timecop.freeze(new_time) do
          is_expected.to_not be_valid
        end
      end

      context 'with transition between years' do
        let(:params) { { year: 2020, week_number: 5 } }

        it do
          new_time = Time.zone.local(2019, 12, 21, 12, 0, 0)
          Timecop.freeze(new_time) do
            is_expected.to_not be_valid
          end
        end
      end
    end

    context 'when updating' do
      let(:params) { { monday_morning: recipe } }
      let(:recipe) { create :recipe, account: account }
      let(:other_recipe) { create :recipe, account: account }
      let(:new_time) { Time.zone.local(2020, 1, 1, 12, 0, 0) }

      before do
        Timecop.freeze(new_time) do
          weekly_plan.save!
        end
      end

      it 'updates with a new time_slot being added' do
        expect(weekly_plan.update(tuesday_morning: recipe)).to eq true
      end

      it 'updates with chaning time_slot recipe' do
        expect(weekly_plan.update(monday_morning: other_recipe)).to eq true
      end

      context 'and changes week' do
        it 'will not be valid' do
          expect(weekly_plan.update(week_number: 5)).to eq false
        end
      end

      context 'and changes year' do
        it 'will not be valid' do
          expect(weekly_plan.update(year: 2019)).to eq false
        end
      end
    end
  end

  describe 'updating planned_items on recipe attach' do
    pending 'will be done when i come to implement inventory features in the ui'
  end
end
