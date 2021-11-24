class AddKeywordsToAbilities < ActiveRecord::Migration[6.1]
  def change
    add_column :abilities, :keywords, :string
  end
end
