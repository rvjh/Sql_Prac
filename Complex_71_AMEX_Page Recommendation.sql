CREATE TABLE friends (
    user_id INT,
    friend_id INT
);

-- Insert data into friends table
INSERT INTO friends VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(3, 1),
(3, 4),
(4, 1),
(4, 3);

-- Create likes table
CREATE TABLE likes (
    user_id INT,
    page_id CHAR(1)
);

-- Insert data into likes table
INSERT INTO likes VALUES
(1, 'A'),
(1, 'B'),
(1, 'C'),
(2, 'A'),
(3, 'B'),
(3, 'C'),
(4, 'B');

select * from friends;
select * from likes;

-- user ids corresponding page_ids likes by their friends but users not yet

with user_pages as(
select distinct friends.user_id, likes.page_id
from friends join likes on friends.user_id = likes.user_id
order by friends.user_id)
, friend_pages as(
select distinct friends.user_id, friends.friend_id, likes.page_id
from friends join likes on friends.friend_id = likes.user_id)
select distinct fp.user_id as user_id, fp.page_id as recommended_page_id
from friend_pages fp left join user_pages up 
on fp.user_id = up.user_id and fp.page_id = up.page_id
where up.page_id is null;
