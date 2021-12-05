class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :ad
      t.integer :ap
      t.integer :hp

      t.timestamps
    end
  end
end
