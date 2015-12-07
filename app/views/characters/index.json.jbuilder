json.array!(@characters) do |character|
  json.extract! character, :id, :name, :locale, :realm
  json.url character_url(character, format: :json)
end
