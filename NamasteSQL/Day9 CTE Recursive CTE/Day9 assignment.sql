select * from customer_orders;


-- 1- write a query to find premium customers from orders data. Premium customers are those 
-- who have done more orders than average no of orders per customer.

with cust_ord as(
select customer_id, count(distinct order_id) no_of_orders
from customer_orders
group by customer_id)
select * from cust_ord
where no_of_orders > (select avg(no_of_orders) from cust_ord) ;

-- 2- write a query to find employees whose salary is more than average salary of 
-- employees in their department

select * from emp_salary;

with cte as(
select dept_id, avg(salary) avg_sal
from emp_salary
group by dept_id)
select emp_salary.name, emp_salary.salary
from emp_salary inner join cte on emp_salary.dept_id = cte.dept_id
where emp_salary.salary > cte.avg_sal;

select e.* from emp_salary e
inner join (select dept_id,avg(salary) as avg_sal from emp_salary group by dept_id)  d
on e.dept_id=d.dept_id
where salary>avg_sal;

-- 3- write a query to find employees whose age is more than average age of all the employees.


select emp_id, emp_name, emp_age from emp_v2
where emp_age>(Select avg(emp_age) from emp_v2);

-- 4- write a query to print emp name, salary and dep id of highest salaried employee in 
-- each department 


with cte as(
select *,
dense_rank() over(partition by dept_id order by salary desc, emp_id) rn
from emp_salary)
select * from cte where rn=1;

-- 5- write a query to print emp name, salary and dep id of highest salaried employee overall
with cte as(
select *, rank() over(order by salary desc) rn from emp_salary)
select * from cte where rn=1;

-- 6- write a query to print product id and total sales of highest selling products 
-- (by no of units sold) in each category

with product_quantity as(
select category, product_id, sum(quantity) total_quantity 
from orders3
group by category, product_id)
, max_quantity as(
select category, max(quantity) max_quant from orders3
group by category)
select * from
product_quantity left join max_quantity
on product_quantity.category = max_quantity.category
where product_quantity.total_quantity = max_quantity.max_quant;






