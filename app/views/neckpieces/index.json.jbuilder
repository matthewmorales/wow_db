json.array!(@neckpieces) do |neckpiece|
  json.extract! neckpiece, :id, :name, :icon, :quality, :itemLevel, :armor, :context
  json.url neckpiece_url(neckpiece, format: :json)
end
