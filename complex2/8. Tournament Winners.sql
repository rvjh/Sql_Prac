select * from players;
select * from matches;

-- find winner in each grp
-- winner max total point within each group in case of tie, lower player id wins

with cte as(
select winner, sum(score) total_score from(
select first_player as winner, first_score as score from matches
union all
select second_player as winner, second_score as score from matches) A
group by winner
order by total_score desc),
cte2 as(
select players.player_id, players.group_id,cte.total_score,
rank() over(partition by group_id order by total_score desc) rn
from players inner join cte on players.player_id = cte.winner)
select min(player_id), group_id, total_score 
from cte2 
where rn=1
group by group_id, total_score;



with cte as(
select winner, sum(score) total_score from(
select first_player as winner, first_score as score from matches
union all
select second_player as winner, second_score as score from matches) A
group by winner
order by total_score desc),
cte2 as(
select players.player_id, players.group_id,cte.total_score,
rank() over(partition by group_id order by total_score desc, player_id asc) rn
from players inner join cte on players.player_id = cte.winner)
select * from cte2 where rn=1;