class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, through: :friendships

  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id'
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :images, :dependent => :destroy
  has_many :albums, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy

  has_attached_file :avatar,
                    styles: {
                        icon: "64x64>",
                        thumb: "200x200"
                    },
                    :convert_options => {
                        :icon => "-quality 75 -strip",
                        :thumb => "-strip"
                    },
                    :path => "public/system/:class/:id/:style.:extension",
                    :url => "/system/:class/:id/:style.:extension",
                    :default_url => "default_avatar.png",
                    :use_timestamp => false
  validates_attachment :avatar,
                       content_type: {content_type: ["image/jpeg", "image/png", "image/gif"]},
                       size: {less_than: 5.megabytes}


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username,
            :presence => true,
            :uniqueness => true
  validates_format_of :username, with: /^[a-zA-Z0-9_-]{3,20}$/, :multiline => true

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_authentication(conditions)
    login = conditions.delete(:login)
    where(conditions).where(["username = :value OR email = :value", {:value => login}]).first
  end

  def is_following?(friend)
    self.friendships.exists?(friend_id: friend.id)
  end

  def mutual_friends(other_user)
    self.friends & other_user.friends
  end
end
