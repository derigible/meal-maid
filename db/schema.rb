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

ActiveRecord::Schema.define(version: 2019_10_17_192318) do

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

  create_table "inventory_items", id: :serial, force: :cascade do |t|
    t.float "amount", null: false
    t.date "expiration"
    t.boolean "used", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "item_id", null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_inventory_items_on_account_id"
    t.index ["item_id"], name: "index_inventory_items_on_item_id"
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_items_on_account_id"
    t.index ["name", "account_id"], name: "index_items_on_name_and_account_id", unique: true
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

  create_table "planned_items", id: :serial, force: :cascade do |t|
    t.bigint "weekly_plan_id", null: false
    t.bigint "recipe_item_id", null: false
    t.bigint "inventory_item_id"
    t.string "time_slot"
    t.index ["inventory_item_id"], name: "index_planned_items_on_inventory_item_id"
    t.index ["recipe_item_id"], name: "index_planned_items_on_recipe_item_id"
    t.index ["weekly_plan_id"], name: "index_planned_items_on_weekly_plan_id"
  end

  create_table "recipe_items", id: :serial, force: :cascade do |t|
    t.float "amount", null: false
    t.bigint "item_id", null: false
    t.bigint "recipe_id", null: false
    t.index ["item_id"], name: "index_recipe_items_on_item_id"
    t.index ["recipe_id"], name: "index_recipe_items_on_recipe_id"
  end

  create_table "recipes", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.float "time"
    t.integer "rating"
    t.text "directions"
    t.text "notes"
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_recipes_on_account_id"
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

  create_table "weekly_plans", id: :serial, force: :cascade do |t|
    t.bigint "monday_morning_id"
    t.bigint "monday_midday_id"
    t.bigint "monday_evening_id"
    t.bigint "tuesday_morning_id"
    t.bigint "tuesday_midday_id"
    t.bigint "tuesday_evening_id"
    t.bigint "wednesday_morning_id"
    t.bigint "wednesday_midday_id"
    t.bigint "wednesday_evening_id"
    t.bigint "thursday_morning_id"
    t.bigint "thursday_midday_id"
    t.bigint "thursday_evening_id"
    t.bigint "friday_morning_id"
    t.bigint "friday_midday_id"
    t.bigint "friday_evening_id"
    t.bigint "saturday_morning_id"
    t.bigint "saturday_midday_id"
    t.bigint "saturday_evening_id"
    t.bigint "sunday_morning_id"
    t.bigint "sunday_midday_id"
    t.bigint "sunday_evening_id"
    t.bigint "account_id", null: false
    t.integer "week_number"
    t.integer "year"
    t.index ["account_id"], name: "index_weekly_plans_on_account_id"
    t.index ["friday_evening_id"], name: "index_weekly_plans_on_friday_evening_id"
    t.index ["friday_midday_id"], name: "index_weekly_plans_on_friday_midday_id"
    t.index ["friday_morning_id"], name: "index_weekly_plans_on_friday_morning_id"
    t.index ["monday_evening_id"], name: "index_weekly_plans_on_monday_evening_id"
    t.index ["monday_midday_id"], name: "index_weekly_plans_on_monday_midday_id"
    t.index ["monday_morning_id"], name: "index_weekly_plans_on_monday_morning_id"
    t.index ["saturday_evening_id"], name: "index_weekly_plans_on_saturday_evening_id"
    t.index ["saturday_midday_id"], name: "index_weekly_plans_on_saturday_midday_id"
    t.index ["saturday_morning_id"], name: "index_weekly_plans_on_saturday_morning_id"
    t.index ["sunday_evening_id"], name: "index_weekly_plans_on_sunday_evening_id"
    t.index ["sunday_midday_id"], name: "index_weekly_plans_on_sunday_midday_id"
    t.index ["sunday_morning_id"], name: "index_weekly_plans_on_sunday_morning_id"
    t.index ["thursday_evening_id"], name: "index_weekly_plans_on_thursday_evening_id"
    t.index ["thursday_midday_id"], name: "index_weekly_plans_on_thursday_midday_id"
    t.index ["thursday_morning_id"], name: "index_weekly_plans_on_thursday_morning_id"
    t.index ["tuesday_evening_id"], name: "index_weekly_plans_on_tuesday_evening_id"
    t.index ["tuesday_midday_id"], name: "index_weekly_plans_on_tuesday_midday_id"
    t.index ["tuesday_morning_id"], name: "index_weekly_plans_on_tuesday_morning_id"
    t.index ["wednesday_evening_id"], name: "index_weekly_plans_on_wednesday_evening_id"
    t.index ["wednesday_midday_id"], name: "index_weekly_plans_on_wednesday_midday_id"
    t.index ["wednesday_morning_id"], name: "index_weekly_plans_on_wednesday_morning_id"
    t.index ["week_number", "year", "account_id"], name: "index_weekly_plans_on_week_number_and_year_and_account_id", unique: true
  end

  add_foreign_key "account_invitations", "accounts"
  add_foreign_key "account_invitations", "users"
  add_foreign_key "inventory_items", "accounts"
  add_foreign_key "inventory_items", "items"
  add_foreign_key "items", "accounts"
  add_foreign_key "logins", "users"
  add_foreign_key "planned_items", "inventory_items"
  add_foreign_key "planned_items", "recipe_items"
  add_foreign_key "planned_items", "weekly_plans"
  add_foreign_key "recipe_items", "items"
  add_foreign_key "recipe_items", "recipes"
  add_foreign_key "recipes", "accounts"
  add_foreign_key "users", "accounts"
  add_foreign_key "weekly_plans", "accounts"
  add_foreign_key "weekly_plans", "recipes", column: "friday_evening_id"
  add_foreign_key "weekly_plans", "recipes", column: "friday_midday_id"
  add_foreign_key "weekly_plans", "recipes", column: "friday_morning_id"
  add_foreign_key "weekly_plans", "recipes", column: "monday_evening_id"
  add_foreign_key "weekly_plans", "recipes", column: "monday_midday_id"
  add_foreign_key "weekly_plans", "recipes", column: "monday_morning_id"
  add_foreign_key "weekly_plans", "recipes", column: "saturday_evening_id"
  add_foreign_key "weekly_plans", "recipes", column: "saturday_midday_id"
  add_foreign_key "weekly_plans", "recipes", column: "saturday_morning_id"
  add_foreign_key "weekly_plans", "recipes", column: "sunday_evening_id"
  add_foreign_key "weekly_plans", "recipes", column: "sunday_midday_id"
  add_foreign_key "weekly_plans", "recipes", column: "sunday_morning_id"
  add_foreign_key "weekly_plans", "recipes", column: "thursday_evening_id"
  add_foreign_key "weekly_plans", "recipes", column: "thursday_midday_id"
  add_foreign_key "weekly_plans", "recipes", column: "thursday_morning_id"
  add_foreign_key "weekly_plans", "recipes", column: "tuesday_evening_id"
  add_foreign_key "weekly_plans", "recipes", column: "tuesday_midday_id"
  add_foreign_key "weekly_plans", "recipes", column: "tuesday_morning_id"
  add_foreign_key "weekly_plans", "recipes", column: "wednesday_evening_id"
  add_foreign_key "weekly_plans", "recipes", column: "wednesday_midday_id"
  add_foreign_key "weekly_plans", "recipes", column: "wednesday_morning_id"
end
