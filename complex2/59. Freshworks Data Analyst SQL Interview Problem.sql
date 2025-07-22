select * from sku;


-- need price at start of each month

with first_price as(
select * ,day(price_date) as n
from sku where day(price_date)=1),
cte as(
select *,
row_number() over(partition by sku_id, month(price_date) order by price desc) rn
from sku)
, cte2 as(
select * 
, date_add(price_date, interval 1 month) m
, date_format(date_add(price_date, interval 1 month), '%Y-%m-01') n
from cte where rn=1)
select price_date, price from first_price
union all
select n, price from cte2;


