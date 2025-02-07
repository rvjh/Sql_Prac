select * from brands;

-- populate category values to the last not null value

select *,
row_number() over(order by(select null)) rn
from brands;

with cte1 as(
select *,
row_number() over(order by(select null)) rn
from brands),
cte2 as(
select *,
lead(rn,1,9999) over(order by rn) next_rn
from cte1 
where category is not null)
select cte2.category, cte2.brand_name
from cte1 inner join cte2 on cte1.rn >= cte2.rn and cte1.rn <= cte2.next_rn -1