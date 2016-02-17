class Comment < ActiveRecord::Base
  belongs_to :image
  belongs_to :user
  validates_presence_of :body
  default_scope { order('created_at DESC') }
end
