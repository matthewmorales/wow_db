class CreateGuilds < ActiveRecord::Migration
  def change
    create_table :guilds do |t|
      t.string :name
      t.string :realm
      t.string :battlegroup
      t.integer :members
      t.integer :achievement_points

      t.timestamps null: false
    end
  end
end
