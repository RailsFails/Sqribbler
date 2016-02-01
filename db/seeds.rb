# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

user_count = 100
user_count.times do
  name = Faker.Name.name
  username = name.gsub(/\s/, '_')
end