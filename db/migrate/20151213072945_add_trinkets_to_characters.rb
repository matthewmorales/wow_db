class AddTrinketsToCharacters < ActiveRecord::Migration
  def change
  	  	add_column :characters, :trinket_id, :integer
  		add_foreign_key :characters, :trinkets
  end
end
