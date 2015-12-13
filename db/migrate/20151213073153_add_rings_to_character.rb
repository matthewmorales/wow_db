class AddRingsToCharacter < ActiveRecord::Migration
  def change
  	add_column :characters, :ring_id, :integer
	add_foreign_key :characters, :rings
  end
end
