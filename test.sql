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
-- 12|Kraig_Mosciski
-- 14|Selena_Will

-- USERS:
-- id, username

-- FRIENDSHIPS
-- id, user_id, friend_id

--select users.username from users join friendships on friend_id=users.id where user_id=14 order by username;
select users.username from users join friendships on friend_id=users.id where user_id=14
INTERSECT
select users.username from users join friendships on friend_id=users.id where user_id=12;

-- (User.find(12).friends & User.find(14).friends).count
