class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, through: :friendships

  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id'
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user


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
    where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
  end

  def is_following?(friend)
    self.friendships.exists?(friend_id: friend.id)
  end
end
