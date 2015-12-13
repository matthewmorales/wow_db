class ChangeMountColumns < ActiveRecord::Migration
  def change
  	rename_column :mounts, :flying, :isFlying
  	rename_column :mounts, :ground, :isGround
  	rename_column :mounts, :aquatic, :isAquatic
  	rename_column :mounts, :jumping, :isJumping
  end
end
