class CreateAbilities < ActiveRecord::Migration[6.1]
  def change
    create_table :abilities do |t|
      t.string :name
      t.string :description
      t.string :damage_type
      t.integer :base_ad
      t.integer :base_ap
      t.float :ad_scaling
      t.float :ap_scaling

      t.timestamps
    end
  end
end
