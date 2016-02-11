-- delete from friendships;
-- DELETE FROM users;

-- SELECT
  -- users.id,
  -- username,
  -- count(friendships.user_id) as 'following_count',
  -- (SELECT count(*)
   -- FROM friendships
   -- WHERE friendships.friend_id = users.id) as 'followers_count'
-- FROM users
  -- JOIN friendships ON friendships.user_id = users.id
-- GROUP BY users.id;

-- select id, username from users order by random() limit 2;

-- USERS:
-- id, username

-- FRIENDSHIPS
-- id, user_id, friend_id

--select users.username from users join friendships on friend_id=users.id where user_id=14 order by username;
SELECT users.username
FROM users
  JOIN friendships ON friend_id = users.id
WHERE user_id = 14
INTERSECT
SELECT users.username
FROM users
  JOIN friendships ON friend_id = users.id
WHERE user_id = 12;

-- (User.find(12).friends & User.find(14).friends).count

SELECT
  f1.username as 'source',
  f2.username as 'target'
FROM friendships
  JOIN users f1 ON user_id = f1.id
  JOIN users f2 ON friend_id = f2.id;
