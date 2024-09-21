create table bms (seat_no int ,is_empty varchar(10));
insert into bms values
(1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y');

select * from bms;

-- find the seats where 3 or more consedutive seats are empty i.e. if previous and next, next two, previous two

-- using lead/lag

with cte as(
select *,
lag(is_empty,1) over(order by seat_no) prev_1,
lag(is_empty,2) over(order by seat_no) prev_2,
lead(is_empty,1) over(order by seat_no) next_1,
lead(is_empty,2) over(order by seat_no) next_2
from bms
)
select * from cte 
where ((is_empty='Y' and prev_1='Y' and prev_2='Y')
or (is_empty='Y' and prev_1='Y' and next_1='Y')
or (is_empty='Y' and next_1='Y' and next_2='Y'))
order by seat_no;

-- method 2 advance aggregation 

select * from (
select *,
sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between 2 preceding and current row) prev_2,
sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between 1 preceding and 1 following) prev_next_1,
sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between current row and 2 following) next_2
from bms) A
where prev_2=3 or prev_next_1=3 or next_2=3;

-- mrthod 3 

with cte as(
select *,
row_number() over(order by seat_no) rn,
(seat_no - row_number() over(order by seat_no)) consecutive_seat_diff
from bms
where is_empty='Y'
), cnt as(
select consecutive_seat_diff, count(1) as c from cte
group by consecutive_seat_diff having count(1)>=3)

select * from cte where consecutive_seat_diff in (select consecutive_seat_diff from cnt)

