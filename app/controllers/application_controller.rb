# frozen_string_literal: true

class ApplicationController < ActionController::Base

  protected

  def set_csrf_cookie
    cookies['X-CSRF-Token'] = form_authenticity_token
  end
end
