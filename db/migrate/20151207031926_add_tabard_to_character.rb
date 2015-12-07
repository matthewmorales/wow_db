class AddTabardToCharacter < ActiveRecord::Migration
  def change
  	  	add_column :characters, :tabard_id, :integer
  		add_foreign_key :characters, :tabards
  end
end
