class AddFactionToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :faction, :string
  end
end
