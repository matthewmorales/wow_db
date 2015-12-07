class AddDpsToOffhand < ActiveRecord::Migration
  def change
  	add_column :offhands, :dps, :float
  end
end
