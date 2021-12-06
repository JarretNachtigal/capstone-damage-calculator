class ChangeCritDamageMultiplierToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :champions, :crit_damage_multiplier, :float
  end
end
