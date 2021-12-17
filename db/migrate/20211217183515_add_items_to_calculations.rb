class AddItemsToCalculations < ActiveRecord::Migration[6.1]
  def change
    add_column :calculations, :attacking_item_id_one, :integer
    add_column :calculations, :attacking_item_id_two, :integer
    add_column :calculations, :attacking_item_id_three, :integer
    add_column :calculations, :attacking_item_id_four, :integer
    add_column :calculations, :attacking_item_id_five, :integer
    add_column :calculations, :attacking_item_id_six, :integer
    add_column :calculations, :defending_item_id_one, :integer
    add_column :calculations, :defending_item_id_two, :integer
    add_column :calculations, :defending_item_id_three, :integer
    add_column :calculations, :defending_item_id_four, :integer
    add_column :calculations, :defending_item_id_five, :integer
    add_column :calculations, :defending_item_id_six, :integer
  end
end
