create table sku 
(
sku_id int,
price_date date ,
price int
);

insert into sku values 
(1,'2023-01-01',10)
,(1,'2023-02-15',15)
,(1,'2023-03-03',18)
,(1,'2023-03-27',15)
,(1,'2023-04-06',20);

select * from sku;

-- find price at the start date of the month and difference
-- SELECT *, EXTRACT(DAY FROM price_date) AS day_of_price_date FROM sku;

with cte as(
select *,
row_number() over(partition by sku_id, month(price_date), year(price_date) order by price_date desc) rn
from sku)
SELECT *, DATE_FORMAT(DATE_ADD(price_date, INTERVAL 1 MONTH), '%Y-%m-01') AS new_price_date
FROM cte WHERE rn = 1;


with cte as(
select *,
row_number() over(partition by sku_id, month(price_date), year(price_date) order by price_date desc) rn
from sku)
SELECT sku_id, price_date, price FROM sku where EXTRACT(DAY FROM price_date)=1
union all
SELECT sku_id, DATE_FORMAT(DATE_ADD(price_date, INTERVAL 1 MONTH), '%Y-%m-01') AS price_date, price
FROM cte WHERE rn = 1




