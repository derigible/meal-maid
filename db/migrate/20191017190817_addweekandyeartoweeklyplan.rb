class Addweekandyeartoweeklyplan < ActiveRecord::Migration[6.0]
  def change
    add_column :weekly_plans, :week_number, :integer
    add_column :weekly_plans, :year, :integer

    add_index :weekly_plans, [:week_number, :year]
  end
end
