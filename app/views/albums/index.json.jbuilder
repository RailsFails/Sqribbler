json.result_count @albums.count
json.items do
  json.array!(@albums) do |album|
    json.extract! album, :id, :user_id, :title, :access
    json.url album_url(album, format: :json)
    json.text album.title
  end
end
