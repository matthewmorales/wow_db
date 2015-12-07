class ChangeCharacterGenderLimit < ActiveRecord::Migration
  def change
  	  	change_column :characters, :gender, :string, limit: 1
  end
end
