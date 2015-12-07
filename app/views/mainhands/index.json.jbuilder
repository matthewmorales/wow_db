json.array!(@mainhands) do |mainhand|
  json.extract! mainhand, :id, :name, :quality, :itemLevel, :context, :dps
  json.url mainhand_url(mainhand, format: :json)
end
