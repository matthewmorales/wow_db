class AddWeaponToCharacter < ActiveRecord::Migration
  def change
  	  	add_column :characters, :mainhand_id, :integer
  		add_foreign_key :characters, :mainhands
  end
end
