# frozen_string_literal: true

class GraphqlController < ApplicationController
  prepend_before_action :authenticate_user!
  after_action :set_csrf_cookie

  # rubocop:disable Metrics/AbcSize
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user
    }
    result = nil
    Timeout.timeout(300) do
      result = MealMaidSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    end
    render json: result
  rescue => e # rubocop:disable Style/RescueStandardError
    error_render e, :internal_server_error unless Rails.env.development?

    handle_error_in_development e
  end
  # rubocop:enable Metrics/AbcSize

  def graphiql
    @page_title = 'GraphiQL'
    render :graphiql, layout: 'bare'
  end

  private

  def authenticate_user!
    @_current_user = User.find_by(id: session['current_user_id'])
    error_render Exception.new('User is not authenticated.'), :unauthorized if current_user.blank?
  end

  def current_user
    @_current_user
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { error: { message: e.message, backtrace: e.backtrace }, data: {} }, status: :internal_server_error
  end

  def error_render(error, status)
    render json: { error: error.message }, status: status
  end
end
