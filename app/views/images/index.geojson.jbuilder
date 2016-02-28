json.type 'FeatureCollection'
json.features do
  json.array!(@images) do |image|
    json.type 'Feature'
    json.geometry do
      json.type 'Point'
      json.coordinates [image.longitude, image.latitude]
    end
    json.properties do
      json.name image.title
      json.extract! image, :id, :user_id, :title, :description, :created_at, :updated_at, :image_width, :image_height
      json.content_type image.attachment_content_type
      json.file_size image.attachment_file_size
      json.image_url asset_url(image.attachment.url(:original))
      json.thumbnail_url asset_url(image.attachment.url(:thumb))
      json.url image_url(image)
    end
  end
end