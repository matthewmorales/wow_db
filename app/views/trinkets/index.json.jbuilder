json.array!(@trinkets) do |trinket|
  json.extract! trinket, :id, :name, :quality, :itemLevel, :armor, :context, :icon
  json.url trinket_url(trinket, format: :json)
end
