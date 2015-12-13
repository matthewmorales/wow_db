class CreateMounts < ActiveRecord::Migration
  def change
    create_table :mounts do |t|
      t.string :name
      t.boolean :flying
      t.boolean :ground
      t.boolean :aquatic
      t.boolean :jumping

      t.timestamps null: false
    end
  end
end
