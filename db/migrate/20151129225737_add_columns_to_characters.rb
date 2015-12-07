class AddColumnsToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :gender, :integer
    add_column :characters, :char_class, :integer
    add_column :characters, :race, :integer
    add_column :characters, :achievements_points, :integer
    add_column :characters, :honorable_kills, :integer
    add_column :characters, :battle_group, :string
  end
end
