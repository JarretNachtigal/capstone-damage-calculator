class AddNameAndDescriptionToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :name, :string
    add_column :items, :description, :string
  end
end
