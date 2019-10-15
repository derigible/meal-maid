# frozen_string_literal: true

class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  validates :email, presence: true

  def locked?
    if locked_at.present?
      unlock! if Time.zone.now - locked_at > Rails.configuration.x.pinkairship.unlock_after_time
    end
    locked_at.present?
  end

  def unlock_time_elapsed?
    Rails.configuration.x.pinkairship.unlock_after_time > Time.zone.now - locked_at
  end

  def track_failed_attempt
    update!(failed_attempts: id)
  end

  def track_failed_attempt_and_check_if_should_lock
    track_failed_attempt
    failed_attempts > Rails.configuration.x.pinkairship.lock_after_attempts
  end

  def unlock!
    update!(locked_at: nil, failed_attempts: 0, unlock_token: nil)
  end

  def lock!
    update!(locked_at: Time.zone.now, unlock_token: SecureRandom.uuid)
    UserMailer.with(self, unlock_url).unlock.deliver_now
  end

  private

  def unlock_url
    "#{unlock_email_users_url}?unlock_token=#{unlock_token}"
  end
end
