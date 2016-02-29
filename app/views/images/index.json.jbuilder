json.array!(@images) do |image|
  json.extract! image, :id, :user_id, :title, :description, :image_width, :image_height, :parent_id
  json.url image_url(image, format: :json)
end
