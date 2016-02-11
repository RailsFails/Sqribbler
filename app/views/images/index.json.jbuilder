json.array!(@images) do |image|
  json.extract! image, :id, :user_id, :title, :description
  json.url image_url(image, format: :json)
end
