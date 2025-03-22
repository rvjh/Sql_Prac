CREATE TABLE transactions_goo (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    amount INT,
    tran_Date datetime
);

INSERT INTO transactions_goo VALUES (1, 101, 500, '2025-01-01 10:00:01');
INSERT INTO transactions_goo VALUES (2, 201, 500, '2025-01-01 10:00:01');
INSERT INTO transactions_goo VALUES (3, 102, 300, '2025-01-02 00:50:01');
INSERT INTO transactions_goo VALUES (4, 202, 300, '2025-01-02 00:50:01');
INSERT INTO transactions_goo VALUES (5, 101, 700, '2025-01-03 06:00:01');
INSERT INTO transactions_goo VALUES (6, 202, 700, '2025-01-03 06:00:01');
INSERT INTO transactions_goo VALUES (7, 103, 200, '2025-01-04 03:00:01');
INSERT INTO transactions_goo VALUES (8, 203, 200, '2025-01-04 03:00:01');
INSERT INTO transactions_goo VALUES (9, 101, 400, '2025-01-05 00:10:01');
INSERT INTO transactions_goo VALUES (10, 201, 400, '2025-01-05 00:10:01');
INSERT INTO transactions_goo VALUES (11, 101, 500, '2025-01-07 10:10:01');
INSERT INTO transactions_goo VALUES (12, 201, 500, '2025-01-07 10:10:01');
INSERT INTO transactions_goo VALUES (13, 102, 200, '2025-01-03 10:50:01');
INSERT INTO transactions_goo VALUES (14, 202, 200, '2025-01-03 10:50:01');
INSERT INTO transactions_goo VALUES (15, 103, 500, '2025-01-01 11:00:01');
INSERT INTO transactions_goo VALUES (16, 101, 500, '2025-01-01 11:00:01');
INSERT INTO transactions_goo VALUES (17, 203, 200, '2025-11-01 11:00:01');
INSERT INTO transactions_goo VALUES (18, 201, 200, '2025-11-01 11:00:01');

select * from transactions_goo;

with cte as(
select transaction_id, customer_id as seller_id, amount, tran_Date,
lead(customer_id,1) over(order by transaction_id) buyer_id
from transactions_goo)
select seller_id, buyer_id, count(*) no_of_transaction
from cte
where transaction_id %2 = 1
group by seller_id, buyer_id
order by no_of_transaction desc;


with cte as(
select transaction_id, customer_id as seller_id, amount, tran_Date,
lead(customer_id,1) over(order by transaction_id) buyer_id
from transactions_goo)
, cte2 as(
select seller_id, buyer_id, count(*) no_of_transaction
from cte
where transaction_id %2 = 1
group by seller_id, buyer_id
order by no_of_transaction desc)
,cte3 as(
select *,
case when seller_id in (select buyer_id from cte2) then 1 else 0 end as seller_dup,
case when buyer_id in (select seller_id from cte2) then 1 else 0 end as buyer_dup
from cte2)
select seller_id, buyer_id, no_of_transaction
from cte3
where seller_dup !=1 and buyer_id!=1