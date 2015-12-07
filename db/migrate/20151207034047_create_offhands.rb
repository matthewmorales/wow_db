class CreateOffhands < ActiveRecord::Migration
  def change
    create_table :offhands do |t|
      t.string :name
      t.integer :quality
      t.integer :itemLevel
      t.integer :armor
      t.string :context

      t.timestamps null: false
    end
  end
end
