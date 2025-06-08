select * from sales_1;

with recursive cte as(
select min(period_start) dates, max(period_end) max_dates from sales_1
union all
select date_add( dates, interval 1 day), max_dates from cte
where dates<max_dates)
select product_id, year(dates) report_year, sum(average_daily_sales) total_amt  
from cte
inner join sales_1 on dates between dates and max_dates
group by product_id, year(dates)
order by product_id;







