class Image < ActiveRecord::Base
  belongs_to :user
  has_attached_file :attachment,
                    styles: {
                        icon: "64x64>",
                        thumb: "150x150>"
                    },
                    :convert_options => {
                        :icon => "-quality 75 -strip",
                        :thumb => "-quality 75 -strip"
                    },
                    :path => "public/system/:class/:id/:style.:extension",
                    :url => "/system/:class/:id/:style.:extension",
  :use_timestamp => false

  validates_attachment :attachment, presence: true,
                       size: {less_than: 5.megabytes}
  validates_attachment_content_type :attachment, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
end
