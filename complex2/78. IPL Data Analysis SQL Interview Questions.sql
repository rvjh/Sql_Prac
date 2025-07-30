select * from cricket_match;



with all_matches as(
select player, count(match_id) total_matches_played
from(
select match_id, batsman player from cricket_match
union
select match_id, bowler player from cricket_match) A
group by player)
, total_bat as(
select batsman, count(distinct match_id) batting_match from cricket_match
group by batsman)
, total_bowl as(
select bowler, count(distinct match_id) bowl_match from cricket_match
group by bowler)
select all_matches.player, all_matches.total_matches_played ,total_bat.batting_match, total_bowl.bowl_match
from all_matches
left join total_bat on all_matches.player = total_bat.batsman
left join total_bowl on all_matches.player = total_bowl.bowler
order by all_matches.total_matches_played desc;

