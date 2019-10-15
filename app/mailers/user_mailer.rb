# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'noreply@meal-maid.com'
  PINKAIRSHIP = Rails.configuration.x.meal_maid
  UNLOCK_TIME = Rails.configuration.x.meal_maid.unlock_after_time

  def welcome_email
    @user = params[:user]
    @url  = params[:url]
    mail(to: @user.email, subject: 'Welcome to Meal Maid!')
  end

  def reset_password
    @user = params[:user]
    @url = params[:reset_url]
    mail(to: @user.email, subject: 'Reset Password to Meal Maid!')
  end

  def contact_invitation
    @user = params[:user]
    @url = params[:url]
    mail(to: params[:invitation_email], subject: 'You have been invited to make a connection')
  end

  def join_invitation
    @invitee_email = params[:invitee_email]
    @url = params[:register_url]
    mail(to: params[:invitation_email], subject: 'You have been invited to join Meal Maid!')
  end

  def unlock
    @user = params[:user]
    @url = params[:url]
    @unlock_time = UNLOCK_TIME / 1.hour
    mail(to: @user.email, subject: 'Your account has been locked')
  end
end
