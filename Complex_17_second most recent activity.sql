-- Get the second most recent activity, if there is only one activity then retun that

select * from useractivity;



with cte as(
select * ,
count(1) over(partition by username) total_activities,
rank() over(partition by username order by startDate desc) rnk
from useractivity)

select * from cte where total_activities=1 or rnk=2



