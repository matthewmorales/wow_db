json.array!(@tabards) do |tabard|
  json.extract! tabard, :id, :name, :quality, :itemLevel, :context, :armor
  json.url tabard_url(tabard, format: :json)
end
