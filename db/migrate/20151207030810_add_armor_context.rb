class AddArmorContext < ActiveRecord::Migration
  def change
  	add_column :armors, :context, :string
  end
end
