# frozen_string_literal: true

module Types
  class WeeklyPlanType < Types::BaseObject
    global_id_field :id

    description 'The weekly meal plan. A null value means that day\'s timeslot has no planned recipe.'

    WeeklyPlan::TIME_SLOTS.each do |time_slot|
      field(time_slot, Types::RecipeType, null: true)
      define_method(time_slot) do
        Loaders::AssociationLoader.for(WeeklyPlan, time_slot).load(object)
      end
    end

    field :account, Types::AccountType, null: false, description: 'The account the meal plan is under.'

    field(
      :planned_items_connection,
      Types::PlannedItemType.connection_type,
      null: true,
      description: 'The ingredients planned for the week'
    )

    def planned_items_connection
      Loaders::AssociationLoader.for(WeeklyPlan, :planned_items).load(object)
    end

    def account
      Loaders::AssociationLoader.for(WeeklyPlan, :account).load(object)
    end
  end
end
