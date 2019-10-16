class AddAppTables < ActiveRecord::Migration[6.0]
  def change
    create_table :items, id: :serial do |t|
      t.string :name, null: false
      t.belongs_to :account, index: true, foreign_key: true, null: false
      t.index [:name, :account_id], unique: true
    end

    create_table :inventory_items, id: :serial do |t|
      t.float :amount, null: false
      t.date :expiration
      t.boolean :used, default: false
      t.timestamps null: false
      t.belongs_to :item, index: true, foreign_key: true, null: false
      t.belongs_to :account, index: true, foreign_key: true, null: false
    end

    create_table :recipes, id: :serial do |t|
      t.string :title, null: false
      t.float :time
      t.integer :rating
      t.text :directions
      t.text :notes
      t.belongs_to :account, index: true, foreign_key: true, null: false
    end

    create_table :recipe_items, id: :serial do |t|
      t.float :amount, null: false
      t.belongs_to :item, index: true, foreign_key: true, null: false
      t.belongs_to :recipe, index: true, foreign_key: true, null: false
    end

    create_table :weekly_plans, id: :serial do |t|
      t.references :monday_morning, foreign_key: {to_table: :recipes}, null: true
      t.references :monday_midday, foreign_key: {to_table: :recipes}, null: true
      t.references :monday_evening, foreign_key: {to_table: :recipes}, null: true

      t.references :tuesday_morning, foreign_key: {to_table: :recipes}, null: true
      t.references :tuesday_midday, foreign_key: {to_table: :recipes}, null: true
      t.references :tuesday_evening, foreign_key: {to_table: :recipes}, null: true

      t.references :wednesday_morning, foreign_key: {to_table: :recipes}, null: true
      t.references :wednesday_midday, foreign_key: {to_table: :recipes}, null: true
      t.references :wednesday_evening, foreign_key: {to_table: :recipes}, null: true

      t.references :thursday_morning, foreign_key: {to_table: :recipes}, null: true
      t.references :thursday_midday, foreign_key: {to_table: :recipes}, null: true
      t.references :thursday_evening, foreign_key: {to_table: :recipes}, null: true

      t.references :friday_morning, foreign_key: {to_table: :recipes}, null: true
      t.references :friday_midday, foreign_key: {to_table: :recipes}, null: true
      t.references :friday_evening, foreign_key: {to_table: :recipes}, null: true

      t.references :saturday_morning, foreign_key: {to_table: :recipes}, null: true
      t.references :saturday_midday, foreign_key: {to_table: :recipes}, null: true
      t.references :saturday_evening, foreign_key: {to_table: :recipes}, null: true

      t.references :sunday_morning, foreign_key: {to_table: :recipes}, null: true
      t.references :sunday_midday, foreign_key: {to_table: :recipes}, null: true
      t.references :sunday_evening, foreign_key: {to_table: :recipes}, null: true

      t.belongs_to :account, index: true, foreign_key: true, null: false
    end

    create_table :planned_items, id: :serial do |t|
      t.belongs_to :weekly_plan, index: true, foreign_key: true, null: false
      t.belongs_to :recipe_item, index: true, foreign_key: true, null: false
      t.belongs_to :inventory_item, index: true, foreign_key: true, null: true
    end
  end
end
