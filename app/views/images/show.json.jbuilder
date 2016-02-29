json.extract! @image, :id, :user_id, :title, :description, :created_at, :updated_at, :image_width, :image_height, :latitude, :longitude, :parent_id
json.content_type @image.attachment_content_type
json.file_size @image.attachment_file_size
json.image_url asset_url(@image.attachment.url(:original))
json.thumbnail_url asset_url(@image.attachment.url(:thumb))
json.icon_url asset_url(@image.attachment.url(:icon))
json.url image_url(@image)
json.albums @image.albums do |album|
    json.title album.title
    json.id album.id
end
