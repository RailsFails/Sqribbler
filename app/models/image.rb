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

  has_many :album_entries
  has_many :albums, through: :album_entries
  has_many :comments, :dependent => :destroy
  has_many :votes, as: :item

  validates_attachment :attachment, presence: true,
                       size: {less_than: 5.megabytes}
  validates_attachment_content_type :attachment, :content_type => %w(image/jpeg image/jpg image/png image/gif image/bmp)

  before_save :extract_dimensions


  def add_album_titles(album_titles_str)
    unless album_titles_str.is_a?Array
      return false
    end
    self.albums = album_titles_str.map do |name|
      self.user.albums.where(title: name.strip).first_or_create!
    end
  end

  def get_album_titles
    self.albums.pluck(:title)
  end
  
  def toggle_album(album_name)
    
  end

  private
  def extract_dimensions
    tempfile = attachment.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.image_width = geometry.width.to_i
      self.image_height = geometry.height.to_i
    end
  end
end
