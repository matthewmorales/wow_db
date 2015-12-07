class ChangeCharacterGender < ActiveRecord::Migration
  def change
  	change_column :characters, :gender, :string
  end
end
