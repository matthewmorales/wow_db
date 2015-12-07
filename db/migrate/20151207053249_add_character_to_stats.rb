class AddCharacterToStats < ActiveRecord::Migration
  def change
  	add_column :stats, :character_id, :integer
  	add_foreign_key :stats, :characters
  end
end
