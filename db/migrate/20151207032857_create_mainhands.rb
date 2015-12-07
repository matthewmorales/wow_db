class CreateMainhands < ActiveRecord::Migration
  def change
    create_table :mainhands do |t|
      t.string :name
      t.integer :quality
      t.integer :itemLevel
      t.string :context
      t.float :dps

      t.timestamps null: false
    end
  end
end
