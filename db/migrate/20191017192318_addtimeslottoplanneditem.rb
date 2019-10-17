class Addtimeslottoplanneditem < ActiveRecord::Migration[6.0]
  def change
    add_column :planned_items, :time_slot, :string
  end
end
