# frozen_string_literal: true

class Login < ApplicationRecord
  belongs_to :user, inverse_of: :logins

  class << self
    def login(auth_hash)
      where(provider: auth_hash.provider, uid: auth_hash.uid).includes(:user).take
    end

    def confirm(confirmation_token)
      login = find_by(confirmation_token: confirmation_token)
      login.user.logins.each { |l| l.update! confirmed_at: Time.zone.now } if login&.waiting_confirmation?
      login
    end

    def reset_password(params)
      login = find_by(params[:reset_password_token])
      login&.update!(
        password: params[:password], password_confirmation: params[:password_confirmation]
      )
      login
    end
  end

  def waiting_confirmation?
    # this should not be true for all logins not made by identity
    confirmed_at.blank?
  end

  def set_reset_password_token
    token = SecureRandom.uuid
    update! reset_password_token: token, reset_password_sent_at: Time.zone.now
    token
  end
end
