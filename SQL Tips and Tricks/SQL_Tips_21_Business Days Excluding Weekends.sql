select * from tickets; 

-- business day b/w create day, resolve day

select *,
datediff(resolved_date, create_date) actual_days,
week(create_date) crea_week, week(resolved_date) res_week,
(week(resolved_date) - week(create_date)) week_diff,
datediff(resolved_date, create_date) - 2*((week(resolved_date) - week(create_date))) business_day
from tickets;

with cte as(
select *,
datediff(resolved_date, create_date) actual_days,
week(create_date) crea_week, week(resolved_date) res_week,
(week(resolved_date) - week(create_date)) week_diff,
datediff(resolved_date, create_date) - 2*((week(resolved_date) - week(create_date))) business_day
from tickets),
cte2 as(
select cte.ticket_id, cte.create_date, cte.resolved_date, cte.business_day, count(holidays.reason) cnt 
from cte
left join holidays 
on holidays.holiday_date between cte.create_date and cte.resolved_date
group by cte.ticket_id, cte.create_date, cte.resolved_date, cte.business_day)
select ticket_id, create_date, resolved_date,
(business_day - cnt) actual_business_days
from cte2;
