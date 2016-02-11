class Album < ActiveRecord::Base
  belongs_to :user
  has_many :images, through: :album_entries
end
