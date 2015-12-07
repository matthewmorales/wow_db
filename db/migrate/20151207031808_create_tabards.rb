class CreateTabards < ActiveRecord::Migration
  def change
    create_table :tabards do |t|
      t.string :name
      t.integer :quality
      t.integer :itemLevel
      t.string :context
      t.integer :armor

      t.timestamps null: false
    end
  end
end
