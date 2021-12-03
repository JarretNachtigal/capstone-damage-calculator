class AddDefendingChampionCurrentHpToCalculation < ActiveRecord::Migration[6.1]
  def change
    add_column :calculations, :defending_champion_current_hp, :integer
  end
end
