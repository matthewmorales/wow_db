class AddOffhandToCharacter < ActiveRecord::Migration
  def change
  	  	add_column :characters, :offhand_id, :integer
  		add_foreign_key :characters, :offhands
  end
end
