# frozen_string_literal: true

class UsersController < ApplicationController
  respond_to :json, :html

  def unlock
    u = Users.find_by(unlock_token: params[:unlock_token])
    u&.unlock!
  end

  def info
    user = User.find_by(id: session['current_user_id'])
    if user.present?
      respond_with user, serializer: UserSerializer
    else
      render json: { error: 'User not authenticated' }, status: :unauthorized
    end
  end
end
