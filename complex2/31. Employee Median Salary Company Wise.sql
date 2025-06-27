select * from employee;

-- find the median salary of each company

with cte as(
select *,
row_number() over(partition by company order by salary desc) rn,
count(1) over(partition by company) total_cnt
from employee
)
select company, avg(salary) median
from cte where rn between total_cnt/2 and total_cnt/2+1
group by company