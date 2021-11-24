class AddsAbilityLevelToCalculations < ActiveRecord::Migration[6.1]
  def change
    add_column :calculations, :ability_level, :integer
  end
end
