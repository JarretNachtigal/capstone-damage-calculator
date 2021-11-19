class CreateAbilities < ActiveRecord::Migration[6.1]
  def change
    create_table :abilities do |t|
      t.string :name
      t.string :description
      t.string :damage_type
      t.integer :base_ad
      t.integer :base_ap
      t.integer :base_ad_scaling
      t.integer :base_ap_scaling
      t.integer :ad_scaling
      t.integer :ap_scaling
      t.integer :ad_scaling_per_level
      t.integer :ap_scaling_per_level

      t.timestamps
    end
  end
end
