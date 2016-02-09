class Image < ActiveRecord::Base
  belongs_to :user
  has_attached_file :attachment
  validates_attachment :attachment, presence: true,
    content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] },
    size: { less_than: 5.megabytes },
    styles: {
    	icon:  "64x64>",
    	thumb: "150x150>"
    },
    :convert_options => {
        :icon  => "-quality 75 -strip", 
        :thumb => "-quality 75 -strip" 
    }
end
