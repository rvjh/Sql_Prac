select * from user_interactions;


select game_id, 
case when count(interaction_type)=0 then "no social interaction" 
	 when count(distinct case when interaction_type is not null then user_id end)=1 then "one sided interaction"
    when count(distinct case when interaction_type is not null then user_id end)=2
    and count(distinct case when interaction_type = 'custom_typed' then user_id end)=0 then "both sided interaction without custom messages"
    when count(distinct case when interaction_type is not null then user_id end)=2
    and count(distinct case when interaction_type = 'custom_typed' then user_id end)>=1 then "both sided interaction with custom messages"
end game_type
from user_interactions
group by game_id;

