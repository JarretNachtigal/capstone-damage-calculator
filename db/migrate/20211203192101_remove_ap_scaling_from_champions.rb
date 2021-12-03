class RemoveApScalingFromChampions < ActiveRecord::Migration[6.1]
  def change
    remove_column :champions, :ap_scaling
  end
end
