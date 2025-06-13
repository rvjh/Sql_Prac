select * from users_2;
select * from events_2;

-- fraction of users who converted from music to prime

select * 
from users_2
where user_id in (select user_id from events_2 where type="Music");


select 
count(distinct case 
					when datediff(events_2.access_date, users_2.join_date) <= 30 
                    then events_2.user_id end) / count(1) fraction_of_people
-- users_2.*, events_2.type, events_2.access_date, datediff(events_2.access_date, users_2.join_date) d
from users_2 left join events_2 on events_2.user_id = users_2.user_id and events_2.type="P"
where users_2.user_id in (select user_id from events_2 where type="Music")



