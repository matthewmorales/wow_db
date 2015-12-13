class CreateNeckpieces < ActiveRecord::Migration
  def change
    create_table :neckpieces do |t|
      t.string :name
      t.string :icon
      t.integer :quality
      t.integer :itemLevel
      t.integer :armor
      t.string :context

      t.timestamps null: false
    end
  end
end
