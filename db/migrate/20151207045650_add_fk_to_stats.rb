class AddFkToStats < ActiveRecord::Migration
  def change
  		add_foreign_key :stats, :characters
  end
end
