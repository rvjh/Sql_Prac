select * from airbnb_searches;


with cte as(
select user_id, date_searched,
substring_index(filter_room_types,',',1) a
from airbnb_searches
union
select user_id, date_searched,
substring_index(filter_room_types,',',-1) a
from airbnb_searches)
select a room_type, count(1) cnt from cte
group by a
order by count(1) desc;