# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

fake_user_count = 50
fake_user_count.times do
  user = User.new
  user.first_name = Faker::Person.firstName($gender = null|'male'|'female')
  user.last_name = Faker::Person.lastName
  user.username = name.gsub(/\s/, '_')
  user.email = Faker::Internet.email(user.username)
  user.phone_number = Faker::PhoneNumber.phoneNumber
  user.location = Faker::Address.city + ' ' + Faker::Address.state
  user.about_me = Faker::Lorem.sentence(10)
 # user.profile_avatar = Faker::Avatar.image("my-own-slug")
  user.password = 'testtest'
  user.password_confirmation = 'testtest'

  puts user.save
end

users_count = User.all.count
if users_count > fake_user_count
  users_count = fake_user_count
end
User.all.each do |user|
  friend_count = rand(0..users_count)
  random_users = User.limit(friend_count).order('random()').all
  random_users.each do |rand_user|
      user.friendships.create(friend_id: rand_user.id).save
  end
end
