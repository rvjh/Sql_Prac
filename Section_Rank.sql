create table section_data
(
section varchar(5),
number integer
);

insert into section_data
values ('A',5),('A',7),('A',10) ,('B',7),('B',9),('B',10) ,('C',9),('C',7),('C',9) ,('D',10),('D',3),('D',8);

select * from section_data;

--

with cte as(
select * 
, row_number() over(partition by section order by number desc) rn
from section_data),
cte2 as(
select * 
,sum(number) over(partition by section) as total
, max(number) over(partition by section) as sec_max
from cte where rn<=2)
select * from(
select *
, dense_rank() over(order by total desc, sec_max desc) as rnk
from cte2) A where rnk<=2








