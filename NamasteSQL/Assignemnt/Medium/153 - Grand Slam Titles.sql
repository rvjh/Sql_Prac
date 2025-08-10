-- select * from players;

with all_winners as(
select wimbledon as player_id from championships
union all 
select fr_open as player_id from championships
union all
select us_open as player_id from championships
union all 
select au_open as player_id from championships)
select players.player_id,players.player_name, 
COALESCE(COUNT(all_winners.player_id), 0) grand_slams_count 
from players 
left join all_winners on all_winners.player_id = players.player_id
group by player_id,player_name
order by grand_slams_count desc