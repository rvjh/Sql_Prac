select * from covid_case_data;



with cte as(
select month(record_date) mon, sum(new_cases) case_cnt 
from covid_case_data
group by month(record_date))
, cte2 as(
select * 
, lag(case_cnt,1,0) over(order by mon) prev_mon_cnt
from cte)
, cte3 as(
select * 
, sum(prev_mon_cnt) over(order by mon) cumulative_sum
from cte2)
select * 
, (case_cnt / cumulative_sum)*100 percentage_inc
from cte3;


-- 


with cte as(
select month(record_date) mon, sum(new_cases) case_cnt 
from covid_case_data
group by month(record_date))
, cte2 as(
select c1.mon current_month, c2.mon prev_mon, 
c1.case_cnt current_cnt, c2.case_cnt prev_cnt
from  cte c1 left join cte c2 on c2.mon < c1.mon),
cte3 as(
select current_month, current_cnt, sum(prev_cnt) c_sum 
from cte2 group by current_month, current_cnt)
select *
, (current_cnt / c_sum)*100 per_cng
from cte3;


