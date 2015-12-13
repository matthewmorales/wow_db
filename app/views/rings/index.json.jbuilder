json.array!(@rings) do |ring|
  json.extract! ring, :id, :name, :icon, :quality, :itemLevel, :armor, :context
  json.url ring_url(ring, format: :json)
end
