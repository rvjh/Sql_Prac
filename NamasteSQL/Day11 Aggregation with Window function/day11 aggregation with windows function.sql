-- 1- write a sql to find top 3 products in each category by highest rolling 3 months total sales for Jan 2020.

select * from orders3;


with cte as(
select product_id, category, year(order_date) y, month(order_date) m, sum(sales) total_sales 
from orders3
group by product_id, category, year(order_date), month(order_date))
, cte2 as(
select *,
sum(total_sales) over(partition by product_id, category order by y,m rows between 2 preceding and current row) as roll_sales
from cte)
select * from(
select *,
rank() over(partition by category order by roll_sales desc) rn
from cte2 where y=2020 and m=1) A
where rn<=3;

-- 2- write a query to find products for which month over month sales has never declined.

select * from orders3;

with cte as(
select product_id, year(order_date) y, month(order_date) m, sum(sales) total_sales
from orders3
group by product_id, year(order_date), month(order_date))
, cte2 as(
select *,
lag(total_sales,1,0) over(partition by product_id order by y,m) prev_sales
from cte)
select distinct product_id from cte2 where product_id not in
(select product_id from cte2 where total_sales < prev_sales group by product_id);


-- 3- write a query to find month wise sales for each category for months where sales is 
-- more than the combined sales of previous 2 months for that category.

with xxx as (select category, year(order_date) as yo,month(order_date) as mo, sum(sales) as sales
from orders3 
group by category,year(order_date),month(order_date))
,yyyy as (
select *,sum(sales) over(partition by category order by yo,mo rows between 2 preceding and 1 preceding ) as prev2_sales
from xxx)
select * from yyyy where  sales>prev2_sales;


