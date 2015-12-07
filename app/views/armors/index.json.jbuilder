json.array!(@armors) do |armor|
  json.extract! armor, :id, :name, :quality, :level, :armor
  json.url armor_url(armor, format: :json)
end
