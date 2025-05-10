select *
from emp_v2;

-- 1- write a query to print emp name , their manager name and diffrence in their age (in days) 
-- for employees whose year of birth is before their managers year of birth


select v1.emp_name emp_name, v2.emp_name manager_name,v1.emp_age emp_age, v2.emp_age manager_age
from emp_v2 v1 join emp_v2 v2
on v1.manager_id = v2.emp_id
where v1.emp_age > v2.emp_age; 

-- 2- write a query to find subcategories who never had any return orders in 
-- the month of november (irrespective of years)

select * from orders3;

-- 3- orders table can have multiple rows for a particular order_id when customers buys 
-- more than 1 product in an order.
-- write a query to find order ids where there is only 1 product bought by the customer.

select order_id from orders3
group by order_id
having count(order_id)=1;

-- 4- write a query to print manager names along with the comma separated 
-- list(order by emp salary) of all employees directly reporting to him.


select *
from emp_v2;

WITH cte AS (
    SELECT v1.emp_name AS emp_name, v2.emp_name AS manager_name
    FROM emp_v2 v1 
    INNER JOIN emp_v2 v2 ON v1.manager_id = v2.emp_id
)
SELECT manager_name, GROUP_CONCAT(emp_name SEPARATOR ', ') AS employees
FROM cte
GROUP BY manager_name;

-- 5- write a query to get number of business days between order_date and ship_date (exclude weekends). 
-- Assume that all order date and ship date are on weekdays only
select * from orders3;

SELECT 
    order_date,
    ship_date,
    DATEDIFF(ship_date, order_date) - 2 * (DATEDIFF(ship_date, order_date) DIV 7) AS no_of_business_days
FROM orders3;


-- 6- write a query to print 3 columns : category, total_sales and total_profit
select * from orders3;

select category, sum(sales) total_sales, sum(profit) total_profit from orders3
group by category;

-- 7. write a query to print below 3 columns
-- category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)

select category, 
sum(case when year(order_date)=2019 then sales end) total_sales_2019,
sum(case when year(order_date)=2020 then sales end) total_sales_2020
from orders3
group by category;

-- 8- write a query print top 5 cities in west region by average no of days between order date and ship date.

select * from orders3;

select city, 
avg(datediff(ship_date, order_date)) avg_day_diff
from orders3
where region='West'
group by city
limit 5;

-- 9. write a query to print emp name, manager name and senior manager name (senior manager is manager's manager)

WITH cte AS (
    SELECT v1.emp_name AS emp_name, v2.emp_name AS manager_name, v3.emp_name senior_manager_name
    FROM emp_v2 v1 
    INNER JOIN emp_v2 v2 
    inner join emp_v2 v3
    ON v1.manager_id = v2.emp_id and v2.manager_id = v3.emp_id
)
select * from cte;

select e1.emp_name,e2.emp_name as manager_name,e3.emp_name as senior_manager_name
from emp_v2 e1
inner join emp_v2 e2 on e1.manager_id=e2.emp_id
inner join emp_v2 e3 on e2.manager_id=e3.emp_id;

