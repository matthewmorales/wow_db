class JoinTitlesAndCharacters < ActiveRecord::Migration
  def change
  	create_join_table :characters, :titles do |t|
  	  t.index [:title_id, :character_id]
  	  t.index [:character_id, :title_id]
  	end
  end
end
