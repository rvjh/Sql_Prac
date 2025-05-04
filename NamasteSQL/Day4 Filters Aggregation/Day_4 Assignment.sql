select * from orders3;

CREATE TABLE orders3cpyto4 AS
SELECT order_id, city
FROM orders3;

select * from orders3cpyto4;

-- 1. write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909

SHOW INDEXES FROM orders3cpyto4;

ALTER TABLE orders3cpyto4 ADD INDEX (order_id);
SHOW INDEXES FROM orders3cpyto4;

update orders3cpyto4 set city=null where order_id in ('CA-2020-161389' , 'US-2021-156909');
select * from orders3cpyto4 where order_id in ('CA-2020-161389' , 'US-2021-156909');

-- 2. write a query to find orders where city is null (2 rows)

select * from orders3cpyto4 where city is null;

-- 3. write a query to get total profit, first order date and latest order date for each category

select category, 
	   min(order_date) as first_order_date,  
       max(order_date) as latest_order_date,
       round(sum(profit),2) total_profit
from orders3
group by category;


-- 4- write a query to find sub-categories where average profit is more than the half 
-- of the max profit in that sub-category

select * from orders3;

select sub_category from orders3
group by sub_category
having avg(profit) > max(profit)/2;

-- 5. write a query to find students who have got same marks in Physics and Chemistry.

select * from exams;

with cte as(
select student_id,
max(case when subject="Chemistry" then marks end) as Chemistry_Marks,
max(case when subject="Physics" then marks end) as Physics_Marks
from exams
group by student_id)
select * from cte where Chemistry_Marks = Physics_Marks;

-- 6. write a query to find total number of products in each category.
select * from orders3;

select category, count(distinct product_name) product_cnt 
from orders3
group by category;

-- 7- write a query to find top 5 sub categories in west region by total quantity sold

select sub_category, sum(quantity) total_quantity
from orders3
where region='West'
group by sub_category
order by total_quantity desc limit 5;

-- 8- write a query to find total sales for each region and ship mode 
-- combination for orders in year 2020

select * from orders3;

select region, ship_mode, round(sum(sales),2) total_sales
from orders3
where year(order_date)=2020
group by region, ship_mode;













