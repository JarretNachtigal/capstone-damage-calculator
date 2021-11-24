class CreateChampions < ActiveRecord::Migration[6.1]
  def change
    create_table :champions do |t|
      t.string :name
      t.string :description
      t.integer :base_hp
      t.float :base_ad
      t.float :base_ap
      t.float :base_mr
      t.float :base_armor
      t.integer :hp_scaling
      t.float :ad_scaling
      t.float :mr_scaling
      t.float :armor_scaling
      t.timestamps
    end
  end
end
