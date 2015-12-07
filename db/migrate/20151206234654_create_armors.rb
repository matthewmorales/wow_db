class CreateArmors < ActiveRecord::Migration
  def change
    create_table :armors do |t|
      t.string :name
      t.integer :quality
      t.integer :level
      t.integer :armor

      t.timestamps null: false
    end
  end
end