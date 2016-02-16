json.extract! @image, :id, :user_id, :title, :description, :created_at, :updated_at, :image_width, :image_height
json.content_type @image.attachment_content_type
json.file_size @image.attachment_file_size
