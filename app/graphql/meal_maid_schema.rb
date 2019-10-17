# frozen_string_literal: true

class MealMaidSchema < GraphQL::Schema
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  mutation(Types::MutationType)
  query(Types::QueryType)

  def self.id_from_object(object, type_definition, _query_ctx)
    GraphQL::Schema::UniqueWithinType.encode(type_definition.graphql_name, object.id)
  end

  def self.object_from_id(id, query_ctx)
    type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    RecordLoader.for(type_name.constantize).load(item_id).then do |record|
      record&.access?(query_ctx[:current_user])
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def self.resolve_type(_type, obj, _ctx)
    case obj
    when Account then Types::AccountType
    when InventoryItem then Types::InventoryItemType
    when Item then Types::ItemType
    when PlannedItem then Types::PlannedItemType
    when RecipeItem then Types::RecipeItemType
    when Recipe then Types::RecipeType
    when WeeklyPlan then Types::WeeklyPlanType
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end
