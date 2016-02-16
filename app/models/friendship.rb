class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'
    has_many :conversations, :foreign_key => :sender_id

end