class ChangeFieldsInChampionsToFloats < ActiveRecord::Migration[6.1]
  def change
    change_column :champions, :base_hp, :float
    change_column :champions, :base_ad, :float
    change_column :champions, :base_mr, :float
    change_column :champions, :base_armor, :float
    change_column :champions, :hp_scaling, :float
    remove_column :champions, :base_ap

  end
end
