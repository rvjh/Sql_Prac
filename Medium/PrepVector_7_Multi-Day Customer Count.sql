CREATE TABLE transactions_prod (
id INTEGER PRIMARY KEY,
user_id INTEGER,
created_at DATETIME,
product_id INTEGER,
quantity INTEGER
);

INSERT INTO transactions_prod (id, user_id, created_at, product_id, quantity) VALUES
(1, 101, '2024-01-01 10:00:00', 1, 1),  
(2, 101, '2024-01-01 14:00:00', 2, 1),
(3, 101, '2024-01-15 09:00:00', 3, 1), 
(4, 102, '2024-01-05 11:00:00', 1, 2),
(5, 102, '2024-01-05 11:30:00', 2, 1),
(6, 103, '2024-01-02 15:00:00', 1, 1),
(7, 104, '2024-01-01 09:00:00', 1, 1),
(8, 104, '2024-01-02 10:00:00', 2, 1),
(9, 104, '2024-01-03 11:00:00', 3, 1);

select * from transactions_prod;

-- Write a query to get the number of customers that 
-- were upsold by purchasing additional products.

-- If a customer purchased multiple products on the same day, it does not count as an upsell.
--  An upsell is considered only if they made purchases on separate days

with recursive customer_transaction as(
select
user_id, date(created_at) transaction_date,
count(distinct product_id) unique_products
from transactions_prod
group by user_id, date(created_at))
, upsells as(
select user_id
from customer_transaction
where unique_products>0
group by user_id
having count(transaction_date)>1)
select count(distinct user_id) as upsell_customers from upsells;


