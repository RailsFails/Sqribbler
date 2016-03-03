class Album < ActiveRecord::Base
  belongs_to :user
  has_many :album_entries, :dependent => :destroy
  has_many :images, through: :album_entries
  has_many :votes, as: :item
  has_many :reports, as: :item
  validates_presence_of :title
  validates_uniqueness_of :title, :scope => :user_id
end
