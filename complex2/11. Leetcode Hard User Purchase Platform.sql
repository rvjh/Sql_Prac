select * from spending;

-- for each date, no_of_total_users, total_amount spent for mobile, desktop as well as both

select * from spending;

with all_spend as(
select spend_date, user_id,max(platform) platform, sum(amount) amount
from spending
group by spend_date, user_id having count(distinct platform)=1
union all
select spend_date, user_id,'both' as platform, sum(amount) amount
from spending
group by spend_date, user_id having count(distinct platform)=2
union all
select distinct spend_date, null user_id,'both' as platform, 0 as amount
from spending
)
select spend_date, platform, sum(amount) total_amount, count(distinct user_id) as no_of_users
from all_spend
group by spend_date, platform;
