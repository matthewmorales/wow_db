class AddGuildToCharacters < ActiveRecord::Migration
  def change
  	add_column :characters, :guild_id, :integer
  	add_foreign_key :characters, :guilds
  end
end
