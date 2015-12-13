class AddNeckToCharacter < ActiveRecord::Migration
  def change
  	add_column :characters, :neckpiece_id, :integer
	add_foreign_key :characters, :neckpieces
  end
end
