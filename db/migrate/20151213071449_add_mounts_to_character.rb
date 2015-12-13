class AddMountsToCharacter < ActiveRecord::Migration
  def change
  	  	add_column :characters, :mount_id, :integer
  		add_foreign_key :characters, :mounts
  end
end
