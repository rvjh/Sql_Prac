select * from purchase_history;

-- users purchased diff products of diff date
-- product purchased on any given date are not repeated on any other day

select userid, count(distinct purchasedate) no_of_dates
from purchase_history
group by userid;

with cte as(
select userid, count(distinct purchasedate) no_of_dates,
count(productid) cnt_prod, count(distinct productid) cnt_distinct_prod
from purchase_history
group by userid)
select * from cte where cnt_prod = cnt_distinct_prod and no_of_dates>1