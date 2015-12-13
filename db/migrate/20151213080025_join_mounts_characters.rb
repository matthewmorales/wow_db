class JoinMountsCharacters < ActiveRecord::Migration
  def change
  	create_join_table :characters, :mounts do |t|
  	  t.index [:mount_id, :character_id]
  	  t.index [:character_id, :mount_id]
  	end
  end
end
