select * from airbnb_searches;



SELECT 
    *,
    SUBSTRING_INDEX(filter_room_types, ',', 1) AS room_type_1, 
    SUBSTRING_INDEX(SUBSTRING_INDEX(filter_room_types, ',', 2), ',', -1) AS room_type_2
FROM airbnb_searches;

select room, count(*) from 
(select *,
SUBSTRING_INDEX(filter_room_types, ',', 1) room
from airbnb_searches
union all
select *,
SUBSTRING_INDEX(SUBSTRING_INDEX(filter_room_types, ',', 2), ',', -1) room
from airbnb_searches) A
group by room
order by count(*) desc;