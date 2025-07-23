select * from emp_v2;


-- top 3 emp by sal, dept wise

select * from(
select emp_id, emp_name, salary, department_id
, row_number() over(partition by department_id order by salary desc) rn
, dense_rank() over(partition by department_id order by salary desc) rn2
, rank() over(partition by department_id order by salary desc) rn3
from emp_v2) A;
-- where rn<=3


-- dept wisw total sal

select department_id,
sum(salary) s
from emp_v2
group by department_id;


-- yoy growth over current month vs prev month

with cte as(
select product_id, year(order_date) y ,sum(sales) sales
from orders3
group by product_id, year(order_date))
, cte2 as(
select * 
, lead(sales,1) over(order by y) next_sales
from cte),
cte3 as(
select * , 
(next_sales - sales)/sales *100 profit_loss
from cte2)
select * from cte3 where profit_loss is not null and profit_loss > 100;

-- cumulative sales monthwise

with cte as(
select category, year(order_date) y, sum(sales) sales
from orders3 group by category,year(order_date))
select *,
sum(sales) over(partition by category order by y) s
from cte;


-- rolling 3 months sales  current month + prev 2 months

with cte as(
select year(order_date) y, month(order_date) m, sum(sales) sales
from orders3 group by year(order_date), month(order_date))
, cte2 as(
select * 
, sum(sales) over(order by y,m rows between 2 preceding and current row) r_s
from cte)
-- pivoting -- convert roes into volumns
select * from cte2;


with cte as(
select category, year(order_date) y, sum(sales) sales
from orders3 
group by category, year(order_date)
order by category, year(order_date))
select y,
sum(case when category = 'Furniture' then sales end) Furniture_sales,
sum(case when category = 'Office Supplies' then sales end) Office_Supplies_sales,
sum(case when category = 'Technology' then sales end) Technology_sales
from cte
group by y;






