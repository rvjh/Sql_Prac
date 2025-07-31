select * from noon_orders;


--  1. top3 cusines tupe without using top / limit

WITH cte AS (
SELECT cuisine, restaurant_id, COUNT(*) AS c
FROM noon_orders
GROUP BY cuisine, restaurant_id
)
, cte2 as(
SELECT *,
ROW_NUMBER() OVER (partition by cuisine ORDER BY c DESC) AS rn FROM cte)
select * from cte2 where rn<=3;


-- 2. new customer count

with cte as(
select date(placed_at) d,
customer_code,
rank() over(partition by customer_code order by date(placed_at)) rn
from noon_orders
order by date(placed_at))
select d, count(*) new_customer 
from cte where rn=1
group by d;

-- 3. count of all customers acquired in jan 2025 and only placed one order in january
-- and did not place any other order

with cte as(
select distinct customer_code
from noon_orders
where not(month(placed_at)=1 and year(placed_at)=2025)
)
select customer_code, count(*) no_of_orders 
from noon_orders
where month(placed_at)=1 and year(placed_at)=2025 
and customer_code not in (select customer_code from cte)
group by customer_code
having count(*) = 1;

-- 4. cus with no order in last 7 days but were acquired one month ago with their first order
-- on promo

select * from noon_orders;

with cte as(
select customer_code, min(placed_at) first_order_date, max(placed_at) latest_order_date
from noon_orders
group by customer_code)
select cte.*, noon_orders.promo_code_name first_order_promo
from cte
inner join noon_orders 
on cte.customer_code = noon_orders.customer_code and cte.first_order_date = noon_orders.placed_at
where latest_order_date < '2025-03-24' and first_order_date < '2025-02-24'
and noon_orders.promo_code_name is not null;

-- 5.  target customers after therir every third order 3,6,9 etc

select * from noon_orders;

with cte as(
select date(placed_at) order_date,
customer_code, order_id,
row_number() over(partition by customer_code order by date(placed_at)) rn
from noon_orders)
select * 
from cte where rn%3=0 and order_date='2025-03-31';


-- 6. customers who placed more than 1 order and all their orders on promo code only

select * from noon_orders;


with cte as(
select customer_code, promo_code_name, order_id
from noon_orders
where promo_code_name is not null)
select customer_code, count(*) no_of_orders
from cte
group by customer_code
having count(*)>1;


-- 7. % of customers organically acquired in jan 2025 (organic - place first order without promo code)

select * from noon_orders;


with cte as(
select *
, row_number() over(partition by customer_code order by date(placed_at)) rn
from noon_orders
where month(placed_at)=1 and year(placed_at)=2025)
select 
count(case when rn=1 and promo_code_name is null 
		   then customer_code end)/count(distinct customer_code)*100 as organic_percentage
from cte;





