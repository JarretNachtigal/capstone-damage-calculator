class AddsOutputToCalculation < ActiveRecord::Migration[6.1]
  def change
    add_column :calculations, :output, :string
  end
end
