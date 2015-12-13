json.array!(@mounts) do |mount|
  json.extract! mount, :id, :name, :flying, :ground, :aquatic, :jumping
  json.url mount_url(mount, format: :json)
end
