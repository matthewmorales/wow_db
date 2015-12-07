class DroppCharacterFromStats < ActiveRecord::Migration
  def change
  	remove_column :stats, :character_id
  end
end
