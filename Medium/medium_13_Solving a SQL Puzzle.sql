select * from input;

with cte as(
select *,
left(formula,1) d1, right(formula,1) d2, substring(formula, 2,1) o
from input)
select cte.id, cte.formula,cte.o, ip1.value d1_value, ip2.value d2_value,
case when cte.o = '+' then (ip1.value + ip2.value) else  (ip1.value - ip2.value) end new_value
from cte 
join input ip1 on cte.d1 = ip1.id
join input ip2 on cte.d2 = ip2.id
order by cte.id


