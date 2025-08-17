SELECT user_id, tweet_date, 
round(avg(tweet_count) over(PARTITION by user_id 
                      order by tweet_date 
                      rows BETWEEN 2 PRECEDING and CURRENT row),2) r_sum
FROM tweets;