class ModifyArmor < ActiveRecord::Migration
  def change
  	rename_column :armors, :level, :itemLevel
  end
end
