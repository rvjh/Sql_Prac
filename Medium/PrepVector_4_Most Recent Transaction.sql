CREATE TABLE customer_sales (
id INT PRIMARY KEY,
transaction_value DECIMAL(10, 2),
created_at DATETIME
);

INSERT INTO customer_sales (id, transaction_value, created_at)
VALUES
(1, 50.00, '2025-01-23 10:15:00'),
(2, 30.00, '2025-01-23 15:45:00'),
(3, 20.00, '2025-01-23 18:30:00'),
(4, 45.00, '2025-01-24 09:20:00'),
(5, 60.00, '2025-01-24 22:10:00'),
(6, 25.00, '2025-01-25 11:30:00'),
(7, 35.00, '2025-01-25 14:50:00'),
(8, 55.00, '2025-01-25 19:05:00');


-- write a query to get the last transaction for each day.
-- The output should include the ID of the transaction, datetime of the transaction, 
-- and the transaction amount. Order the transactions by datetime.

with cte as(
select id,
transaction_value,
created_at,
date(created_at) transaction_date
from customer_sales 
where created_at in (select max(created_at) from customer_sales group by date(created_at)))
select id, created_at, transaction_value from cte;

--- 
with cte as(
select *,
date(created_at) a from customer_sales)
, cte2 as(
select *,
max(created_at) over(partition by a) rn
from cte)
select id,created_at, transaction_value from cte2
where created_at = rn
