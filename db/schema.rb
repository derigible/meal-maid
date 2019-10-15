# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_15_215542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_invitations", id: :serial, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "account_id", null: false
    t.string "invitation_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_invitations_on_account_id"
    t.index ["invitation_code"], name: "index_account_invitations_on_invitation_code"
    t.index ["user_id"], name: "index_account_invitations_on_user_id"
  end

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "logins", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "name", null: false
    t.string "email"
    t.string "nickname"
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.string "description"
    t.string "url"
    t.string "phone"
    t.jsonb "urls", default: {}
    t.jsonb "credentials", default: {}
    t.jsonb "extra", default: {}
    t.string "password_digest"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["confirmation_token"], name: "index_logins_on_confirmation_token", unique: true
    t.index ["identifier"], name: "index_logins_on_identifier", unique: true
    t.index ["reset_password_token"], name: "index_logins_on_reset_password_token", unique: true
    t.index ["user_id"], name: "index_logins_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "locked_at"
    t.integer "failed_attempts"
    t.string "unlock_token"
    t.string "preferred_name"
    t.string "display_name"
    t.bigint "account_id", null: false
    t.jsonb "metadata", default: {}
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "account_invitations", "accounts"
  add_foreign_key "account_invitations", "users"
  add_foreign_key "logins", "users"
  add_foreign_key "users", "accounts"
end
