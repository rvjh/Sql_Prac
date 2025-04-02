select * from company_revenue;

-- revenue increasing every year

with cte as(
select company, year, revenue,
lag(revenue, 1, 0) over(partition by company order by year) prev_rev,
revenue - lag(revenue, 1, 0) over(partition by company order by year) rev_diff,
count(1) over(partition by company) cnt
from company_revenue)
, cte2 as(
select company,cnt, count(1) sales_increase_years 
from cte where rev_diff >0
group by company,cnt)
select company from cte2 where cnt = sales_increase_years;

-- or 

with recursive cte as(
select company, year, revenue,
lag(revenue, 1, 0) over(partition by company order by year) prev_rev,
revenue - lag(revenue, 1, 0) over(partition by company order by year) rev_diff,
count(1) over(partition by company) cnt
from company_revenue)
select distinct company 
from cte where company not in(select company from cte where rev_diff<0)