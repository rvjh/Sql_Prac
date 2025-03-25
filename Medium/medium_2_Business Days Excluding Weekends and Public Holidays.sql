-- workday excluding holidays and weekends b/w create and resolve date

select * from tickets;
select * from holidays;

select *,
datediff(resolved_date, create_date) date_diff,
week(create_date) create_week,
week( resolved_date) res_week,
week( resolved_date) - week( create_date) week_diff,
(datediff(resolved_date, create_date) - 2*(week( resolved_date) - week( create_date))) business_days
from tickets;


select *,
(datediff(resolved_date, create_date) - 2*(week( resolved_date) - week( create_date))) - no_of_holidays as  business_days
from (
select ticket_id, create_date, resolved_date, count(*) no_of_holidays
from tickets left join holidays on holiday_date between create_date and resolved_date 
group by ticket_id, create_date, resolved_date) A