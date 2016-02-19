json.extract! @results, :total_count, :current_page, :total_pages
logged_in = !current_user.nil?

followers = []
following = []

if logged_in
  followers = current_user.inverse_friends.pluck(:id)
  following = current_user.friends.pluck(:id)
  json.current_user do
    json.extract! current_user, :id, :username
  end
end

json.results do
  json.array!(@results) do |user|
    json.extract! user, :id, :username, :first_name, :last_name
    json.profile_url user_profile_url(user.username)
    if logged_in
      json.follower followers.include?(user.id)
      json.following following.include?(user.id)
    end
  end
end
