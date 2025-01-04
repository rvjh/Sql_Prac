/* User purchase platform.
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/

select * from spending;

select spend_date, user_id, max(platform) platform, sum(amount) amount 
from spending 
group by spend_date, user_id having count(distinct platform)=1;

with all_spend as(
select spend_date, user_id, max(platform) platform, sum(amount) amount 
from spending 
group by spend_date, user_id having count(distinct platform)=1
union all
select spend_date, user_id, 'both' as platform, sum(amount) amount 
from spending 
group by spend_date, user_id having count(distinct platform)=2
union all
select distinct spend_date, null as user_id, 'both' as platform, 0 as amount
from spending 
)

select spend_date, platform, sum(amount) total_amount, count(distinct user_id) user_cnt
from all_spend
group by spend_date, platform