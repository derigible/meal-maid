# frozen_string_literal: true

class AccountInvitation < ApplicationRecord
  belongs_to :user, inverse_of: :account_invitations
  belongs_to :account, inverse_of: :account_invitations
end
