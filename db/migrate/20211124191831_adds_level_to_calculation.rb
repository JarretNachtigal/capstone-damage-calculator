class AddsLevelToCalculation < ActiveRecord::Migration[6.1]
  def change
    add_column :calculations, :champ_one_level, :integer
    add_column :calculations, :champ_two_level, :integer
  end
end
