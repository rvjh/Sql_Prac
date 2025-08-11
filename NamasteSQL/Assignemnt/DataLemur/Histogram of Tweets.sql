with cte as(
SELECT user_id, count(tweet_id) tweet_count_per_user
FROM tweets
where year(tweet_date)=2022
group by user_id)
select tweet_count_per_user as  tweet_bucket,
count(user_id) users_num 
from cte
GROUP BY tweet_count_per_user;