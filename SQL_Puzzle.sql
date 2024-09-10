use test1;
create table input (
id int,
formula varchar(10),
value int
)
insert into input values (1,'1+4',10),(2,'2+1',5),(3,'3-2',40),(4,'4-1',20);

select * from input

select *,
left(formula,1) as d1, right(formula,1) as d3, substring(formula,2,1) as op
from input;

with cte as(
select *,
left(formula,1) as d1, right(formula,1) as d2, substring(formula,2,1) as op from input)
select cte.id, cte.value, cte.formula, cte.op, ip1.value as d1_value, ip2.value as d2_value
, case when cte.op = "+" then ip1.value + ip2.value else ip1.value - ip2.value end as new_value
from cte
inner join input as ip1 on cte.d1 = ip1.id
inner join input as ip2 on cte.d2 = ip2.id