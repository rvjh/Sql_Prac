select * from useractivity;

-- get second most recent activity 
-- username, activity, start, end

with cte as(
select *,
count(1) over(partition by username) total_Activity,
rank() over(partition by username order by startdate desc) rn
from  useractivity)
select * from cte where total_Activity = 1 or rn=2;