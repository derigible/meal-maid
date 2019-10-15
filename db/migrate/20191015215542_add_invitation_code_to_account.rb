class AddInvitationCodeToAccount < ActiveRecord::Migration[6.0]
  def change
    create_table :account_invitations, id: :serial do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.belongs_to :account, index: true, foreign_key: true, null: false
      t.string :invitation_code, null: false
      t.timestamps null: false

      t.index :invitation_code
    end
  end
end
