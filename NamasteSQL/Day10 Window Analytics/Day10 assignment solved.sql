-- 1- write a query to print 3rd highest salaried employee details for each department 
-- (give preferece to younger employee in case of a tie). 
-- In case a department has less than 3 employees then print the details of highest salaried 
-- employee in that department.

select * from emp;

with cte as(
select *,
dense_rank() over(partition by dep_id order by salary desc) rn 
from emp)
, cnt as(select dep_id, count(1) no_of_emp from emp group by dep_id)
select cte.* from cte inner join cnt on cte.dep_id = cnt.dep_id
where cte.rn = 3 or (cnt.no_of_emp <3 and cte.rn = 1);


-- 2- write a query to find top 3 and bottom 3 products by sales in each region.

select * from orders3;


WITH cte AS (
    SELECT product_id, region, SUM(sales) AS total_sales 
    FROM orders3 
    GROUP BY product_id, region
), 
cte2 AS (
    SELECT product_id, region, total_sales,
        RANK() OVER(PARTITION BY region ORDER BY total_sales DESC) AS top_products,
        RANK() OVER(PARTITION BY region ORDER BY total_sales ASC) AS below_products
    FROM cte
)
SELECT * FROM cte2 
WHERE top_products <= 3 OR below_products <= 3;


-- 3- Among all the sub categories..which sub category had highest month over month 
-- growth by sales in Jan 2020.

select * from orders3;

WITH sub_cat_sales AS (
    SELECT 
        sub_category, 
        DATE_FORMAT(order_date, '%Y-%m') AS yearmonth, 
        SUM(sales) AS total_sales
    FROM orders3
    GROUP BY sub_category, DATE_FORMAT(order_date, '%Y-%m')
), 
prev_sub_cat_sales AS (
    SELECT *,
        LAG(total_sales) OVER(PARTITION BY sub_category ORDER BY yearmonth) AS prev_sales
    FROM sub_cat_sales
)
SELECT *,  
    (total_sales - prev_sales) / prev_sales AS MoM_Sales
FROM prev_sub_cat_sales
WHERE yearmonth = '2020-01'
ORDER BY MoM_Sales;


-- 4- write a query to print top 3 products in each category by year over year
--  sales growth in year 2020.


with cat_sales as (
select category,product_id,year(order_date) as order_year, sum(sales) as sales
from orders3
group by category,product_id,year(order_date)
)
, prev_year_sales as (select *,lag(sales) over(partition by category,product_id order by order_year) as prev_year_sales
from cat_sales)
,rnk as (
select   * ,rank() over(partition by category order by (sales-prev_year_sales)/prev_year_sales desc) as rn
from prev_year_sales
where order_year='2020'
)
select * from rnk where rn<=3;


-- write a query to get start time and end time of each call from above 2 tables.
-- Also create a column of call duration in minutes.  Please do take into account that
-- there will be multiple calls from one phone number and each entry in start table has
-- a corresponding entry in end table.


select * from call_start_logs;
select * from call_end_logs;


WITH start_table AS (
    SELECT *, 
           RANK() OVER(PARTITION BY phone_number ORDER BY start_time) AS s
    FROM call_start_logs
), 
end_table AS (
    SELECT *, 
           RANK() OVER(PARTITION BY phone_number ORDER BY end_time) AS e
    FROM call_end_logs
)
SELECT 
    start_table.phone_number, 
    start_table.start_time, 
    end_table.end_time,
    TIMESTAMPDIFF(MINUTE, start_table.start_time, end_table.end_time) AS time_diff
FROM start_table 
INNER JOIN end_table  
ON start_table.phone_number = end_table.phone_number 
AND start_table.s = end_table.e;








