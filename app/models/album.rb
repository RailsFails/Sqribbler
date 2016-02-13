class Album < ActiveRecord::Base
  belongs_to :user
  has_many :album_entries
  has_many :images, through: :album_entries
  validates_uniqueness_of :title, :scope => :user_id
end
