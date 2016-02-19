json.extract! user, :id, :username, :first_name, :last_name
json.profile_url user_profile_url(user.username)