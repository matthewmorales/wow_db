json.array!(@offhands) do |offhand|
  json.extract! offhand, :id, :name, :quality, :itemLevel, :armor, :context
  json.url offhand_url(offhand, format: :json)
end
