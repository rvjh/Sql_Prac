select * from friends;
select * from likes;

-- 


select * from friends;


-- 

with users_pages as(
select distinct f.user_id, l.page_id
from friends f 
inner join likes l on f.user_id = l.user_id)
, friends_pages as(
select distinct f.user_id, f.friend_id, l.page_id
from friends f 
inner join likes l on f.friend_id = l.user_id)
select distinct fp.user_id, fp.page_id recommend_pages
from friends_pages fp
left join users_pages up on fp.user_id = up.user_id and fp.page_id = up.page_id
where up.user_id is null
order by fp.user_id, fp.page_id;


-- 

select distinct f.user_id, fp.page_id
from friends f 
inner join likes fp on f.friend_id = fp.user_id
left join likes up on f.user_id = up.user_id and fp.page_id = up.page_id
where up.user_id is null
order by f.user_id, fp.page_id;


-- 







