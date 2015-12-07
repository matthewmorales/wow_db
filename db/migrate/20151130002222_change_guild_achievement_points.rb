class ChangeGuildAchievementPoints < ActiveRecord::Migration
  def change
  	rename_column :guilds, :achievement_points, :achievementPoints
  end
end
