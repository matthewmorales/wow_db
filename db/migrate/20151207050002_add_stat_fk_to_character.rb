class AddStatFkToCharacter < ActiveRecord::Migration
  def change
  	  	add_column :characters, :stat_id, :integer
  		add_foreign_key :characters, :stats
  end
end
