-- delete from friendships;
-- DELETE FROM users;

SELECT
  users.id,
  username,
  count(friendships.user_id) as 'following_count',
  (SELECT count(*)
   FROM friendships
   WHERE friendships.friend_id = users.id) as 'followers_count'
FROM users
  JOIN friendships ON friendships.user_id = users.id
GROUP BY users.id;

