class AddTitleToCharacter < ActiveRecord::Migration
  def change
  	  	add_column :characters, :title_id, :integer
  		add_foreign_key :characters, :titles
  end
end
