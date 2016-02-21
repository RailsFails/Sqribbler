# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

class Generate
  def initialize
    @fake_user_count = 500
    @max_friend_count = 50
    make_fake_users
    make_friendships
    #make_random_images
    #make_random_image_comments
    #make_votes
  end
  
  def make_fake_users
    puts "making fake users"
    @fake_user_count.times do
      user = User.new
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name
      user.username = get_username
      user.email = Faker::Internet.email(user.username)
      user.phone_number = Faker::PhoneNumber.phone_number
      user.location = Faker::Address.city + ' ' + Faker::Address.state
      user.about_me = Faker::Lorem.sentence(10)
     # user.profile_avatar = Faker::Avatar.image("my-own-slug")
      user.password = 'testtest'
      user.password_confirmation = 'testtest'
      #user.avatar = URI.parse("https://robohash.org/#{user.username}.png")
      puts user.save
    end
    puts "done making fake users"
  end

  def make_friendships
    puts "making friendships"
    users_count = User.all.count
    if users_count > @fake_user_count
      users_count = @fake_user_count
    end
    friend_limit = users_count
    if users_count > @max_friend_count
      friend_limit = @max_friend_count
    end
    User.all.each_with_index  do |user, i|
      friend_count = rand(0..friend_limit)
      random_users = User.order('random()').limit(friend_count).all
      random_users.each do |rand_user|
          user.friendships.create(friend_id: rand_user.id).save
      end
      #puts sprintf('%3d%%', (i.to_f/friend_count)*100)
    end
    puts "done making friendships"
  end

  def make_random_images
    puts "making random images"
    User.order("random()").limit(25).each do |user|
      rand(1..5).times do
        width = rand(100..1000)
        height = rand(100..1000)
        image = user.images.create()
        image.attachment = URI.parse("https://robohash.org/#{rand(1..(2**16))}.jpg?size=#{width}x#{height}")
        image.description = Faker::Lorem.sentence(rand(1..10))
        image.save
      end
    end
    puts "done making random images"
  end
  
  def make_random_image_comments
    puts "making image comments"
    Image.all.each do |image|
      rand(1..10).times do
        rand_user = User.order('random()').first
        rand_text = Faker::Lorem.sentence(rand(1..15))
        comment = image.comments.create(user_id: rand_user.id, body: rand_text)
        comment.save
      end
    end
    puts "done making image comments"
  end
  
  def make_votes
    puts "making votes"
    User.order('random()').all.each do |user|
      puts "user #{user.username} is voting"
      Image.order('random()').limit(25).each do |image|
        vote_on(user, image)
      end
      Comment.order('random()').limit(25).each do |comment|
        vote_on(user, comment)
      end
    end
    puts "done making votes"    
  end
  
  private
  def vote_on(user, item)
    vote_value = 0
   
    case rand(100) + 1
      when  1..60   then vote_value = 1
      when 60..80   then vote_value = -1
      when 80..100  then vote_value = 0
    end
    
    if vote_value != 0
      vote = user.votes.create(item_id: item.id, item_type: item.class.to_s, value: vote_value)
      vote.save
    end
  end

  def get_username
    username = nil
    good_username = false
    until good_username
      username = Faker::Internet.user_name
      if (username =~ /^[a-zA-Z0-9_-]{3,20}$/) == 0
        good_username = true
      end
    end
    return username

  end
end

Generate.new