class AddCritModifierToChampions < ActiveRecord::Migration[6.1]
  def change
    add_column :champions, :crit_damage_multiplier, :integer
  end
end
