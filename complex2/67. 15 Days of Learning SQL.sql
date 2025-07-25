select * from submissions;


-- unique hackers each day

with cte as(
select submission_date, hacker_id, count(*) no_of_submissions,
dense_rank() over(order by submission_date) day_num
from submissions
group by submission_date, hacker_id
), cte2 as(
select * 
, count(*) over(partition by hacker_id order by submission_date) till_date_sub
from cte
), cte3 as(
select * 
, case when day_num = till_date_sub then 1 else 0 end unique_flag
from cte2)
, cte4 as(
select *, sum(unique_flag) over(partition by submission_date) cnt,
row_number() over(partition by submission_date order by no_of_submissions desc, hacker_id) r
from cte3)
select submission_date, cnt, hacker_id from cte4 where r=1
order by submission_date
