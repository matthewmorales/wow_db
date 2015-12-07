class AddArmorToCharacters < ActiveRecord::Migration
  def change
  	add_column :characters, :armor_id, :integer
  	add_foreign_key :characters, :armors
  end
end
