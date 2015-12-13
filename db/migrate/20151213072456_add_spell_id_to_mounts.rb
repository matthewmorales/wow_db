class AddSpellIdToMounts < ActiveRecord::Migration
  def change
  	add_column :mounts, :spellId, :integer
  end
end
