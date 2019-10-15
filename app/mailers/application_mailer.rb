# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@meal-maid.com'
  layout 'mailer'
end
