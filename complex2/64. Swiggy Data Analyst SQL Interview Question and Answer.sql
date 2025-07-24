select * from stock;


-- stockprice <50 2 or more consecutive days
-- supp_id, pro_id, stock_q, first_date, no_of_days

with cte as(
select *,
lag(record_date,1,record_date) over(partition by supplier_id, product_id order by record_date ) prev_date,
datediff(record_date, lag(record_date,1,record_date) over(order by supplier_id, product_id)) daysdiff
from stock 
where stock_quantity < 50
)
, cte2 as(
select * 
, case when daysdiff <= 1 then 0 else 1 end grp_flg
, sum(case when daysdiff <= 1 then 0 else 1 end) over(partition by supplier_id, product_id order by record_date) grp_id
from cte)
select supplier_id, product_id, grp_id, count(*) no_of_records, min(record_date) first_date
from cte2
group by supplier_id, product_id, grp_id;




