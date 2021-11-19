class CreateCalculations < ActiveRecord::Migration[6.1]
  def change
    create_table :calculations do |t|
      t.integer :champion_id_one
      t.integer :champion_id_two
      t.integer :ability_id

      t.timestamps
    end
  end
end
