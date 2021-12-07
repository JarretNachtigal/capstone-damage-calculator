class ChangeFieldsToFloatInAbilities < ActiveRecord::Migration[6.1]
  def change
    change_column :abilities, :base_ad, :float
    change_column :abilities, :base_ap, :float
    change_column :abilities, :base_ad_scaling, :float
    change_column :abilities, :base_ap_scaling, :float
    change_column :abilities, :ad_scaling, :float
    change_column :abilities, :ap_scaling, :float
    change_column :abilities, :ad_scaling_per_level, :float
    change_column :abilities, :ap_scaling_per_level, :float
  end
end
