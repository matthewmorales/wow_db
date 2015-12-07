json.array!(@guilds) do |guild|
  json.extract! guild, :id, :name, :realm, :battlegroup, :members, :achievementPoints
  json.url guild_url(guild, format: :json)
end
