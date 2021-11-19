class CreateChampions < ActiveRecord::Migration[6.1]
  def change
    create_table :champions do |t|
      t.string :name
      t.string :description
      t.integer :base_hp
      t.integer :base_ad
      t.integer :base_ap
      t.integer :base_mr
      t.integer :base_armor
      t.integer :hp_scaling
      t.float :ad_scaling
      t.float :ap_scaling
      t.float :mr_scaling
      t.float :armor_scaling
      t.integer :champion_abilities_id
      t.timestamps
    end
  end
end
