class CreateChampionAbilities < ActiveRecord::Migration[6.1]
  def change
    create_table :champion_abilities do |t|
      t.integer :champion_id
      t.integer :ability_id
      t.timestamps
    end
  end
end
