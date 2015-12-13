class CreateTrinkets < ActiveRecord::Migration
  def change
    create_table :trinkets do |t|
      t.string :name
      t.integer :quality
      t.integer :itemLevel
      t.integer :armor
      t.string :context
      t.string :icon

      t.timestamps null: false
    end
  end
end
