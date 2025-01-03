select * from players;
select * from matches;

-- which player has the maximum score in each group, incase ite lowest player id wins

with player_score as(
select first_player player_id, first_score score from matches
union all
select second_player player_id, second_score score from matches),
player_grp as(
select player_score.player_id, players.group_id, sum(score) score from player_score
inner join players on player_score.player_id = players.player_id
group by player_score.player_id, players.group_id),
final_rnk as(
select *, rank() over(partition by group_id order by score desc, player_id asc) rn 
from player_grp)
select * from final_rnk where rn=1

