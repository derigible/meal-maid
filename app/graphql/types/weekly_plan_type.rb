# frozen_string_literal: true

module Types
  class WeeklyPlanType < Types::BaseObject
    description 'The weekly meal plan. A null value means that day\'s timeslot has no planned recipe.'

    %i[
      monday_morning monday_midday monday_evening
      tuesday_morning tuesday_midday tuesday_evening
      wednesday_morning wednesday_midday wednesday_evening
      thursday_morning thursday_midday thursday_evening
      friday_morning friday_midday friday_evening
      saturday_morning saturday_midday saturday_evening
      sunday_morning sunday_midday sunday_evening
    ].each do |time_slot|
      field(time_slot, Types::RecipeType, null: true) do
        argument :id, ID, required: true
      end
      alias_method time_slot, :load_recipe
    end

    field :account, Types::AccountType, null: false, description: 'The account the meal plan is under.' do
      argument :id, ID, required: True
    end

    field(
      :planned_items_connection,
      Types::PlannedItemType.connection_type,
      null: true,
      description: 'The ingredients planned for the week'
    )

    def planned_items
      AssociationLoader.for(WeeklyPlan, :planned_items).load(object)
    end

    def account(id:)
      RecordLoader.for(Account).load(id)
    end

    def load_recipe(id:)
      RecordLoader.for(Recipe).load(id)
    end
  end
end
