class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.belongs_to :character, index:true
      t.integer :health
      t.string :powerType
      t.integer :power
      t.integer :str
      t.integer :agi
      t.integer :int
      t.integer :sta
      t.float :crit
      t.float :haste
      t.float :mastery
      t.integer :bonusArmor
      t.integer :spellPower
      t.integer :armor
      t.float :parry
      t.float :block
      t.integer :attackPower
      t.float :mainHandDps
      t.integer :rangedAttackPower

      t.timestamps null: false
    end
  end
end
