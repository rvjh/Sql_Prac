select * from orders3;

-- 1- write a query to get region wise count of return orders

select v1.region, count(distinct v1.order_id) returned_order
from orders3 v1 inner join orders3 v2 on v1.order_id = v2.order_id
group by region;

-- 2- write a query to get category wise sales of orders that were not returned

select v1.category, sum(v1.sales) returned_sales
from orders3 v1 left join orders3 v2 on v1.order_id = v2.order_id
where v1.order_id is not null
group by v1.category;

-- 3- write a query to print dep name and average salary of employees in that dep .

select * from emp;

select a.dep_name, avg(b.salary) avg_sal
from emp a inner join emp b
on a.dep_id = b.dep_id
group by a.dep_name;

-- 4- write a query to print dep names where none of the emplyees have same salary.

select a.dep_name
from emp a inner join emp b
on a.dep_id = b.dep_id 
where a.salary != b.salary
group by a.dep_name;

-- 5- write a query to print sub categories where we have all 3 kinds of returns 
-- (others,bad quality,wrong items)

select a.sub_category
from orders3 a inner join orders3 b on a.order_id = b.order_id
group by a.sub_category;

-- 6- write a query to find cities where not even a single order was returned.

select a.city
from orders3 a inner join orders3 b on a.order_id = b.order_id
group by a.city
having count(b.order_id) = 0;

-- 7- write a query to find top 3 subcategories by sales of returned orders in east region
select * from orders3;

select a.sub_category, max(a.sales) max_sales 
from orders3 a inner join orders3 b on a.order_id = b.order_id
where b.region = 'East'
group by a.sub_category
order by max(a.sales) desc limit 3;

-- 8- write a query to print dep name for which there is no employee

select a.dep_id, a.dep_name
from emp a left join emp b
on a.dep_id = b.dep_id 
group by a.dep_id, a.dep_name
having count(b.emp_id)=0;

-- 9- write a query to print employees name for which dep id is not avaiable in dept table

select a.emp_name
from emp a left join emp b
on a.dep_id = b.dep_id 
where b.dep_id is null;

 




