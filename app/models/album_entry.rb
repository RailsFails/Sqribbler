class AlbumEntry < ActiveRecord::Base
  belongs_to :image
  belongs_to :album
end
