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

  has_many :albums, through: :album_entries

  validates_attachment :attachment, presence: true,
                       size: {less_than: 5.megabytes}
  validates_attachment_content_type :attachment, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']


  def album_titles=(album_titles_str)
    #self.albums = []
    # album_titles_str.each do |album_title|
    #   #a = Album.where(user_id: self.user.id, title: album_title.strip).first_or_create!
    #   #AlbumEntry.first_or_create!(image_id: self.id, album_id: a.id)
    #   self.user.albums.where(title: album_title.strip).first_or_create!
    # end
    self.albums = album_titles_str.map do |name|
      Album.where(user_id: self.user.id, title: name.strip).first_or_create!
    end
  end
  def album_titles(album_titles_str)
    album_titles=(album_titles_str)
  end
end
