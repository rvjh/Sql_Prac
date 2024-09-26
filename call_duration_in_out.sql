create table call_details  (
call_type varchar(10),
call_number varchar(12),
call_duration int
);

insert into call_details
values ('OUT','181868',13),('OUT','2159010',8)
,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);

select * from call_details;

-- the numbers should have incoming and outgoing calls
-- sum of duration of outgoing call > sum of duration of incoming call

select * from call_details;

-- cte and filter

with cte as(
select call_number 
, sum(case when call_type = 'OUT' then call_duration end) as out_duration
, sum(case when call_type = 'INC' then call_duration end) as in_duration
from call_details
group by call_number)
select * from cte
where out_duration is not null and in_duration is not null and out_duration>in_duration;

-- using having clause

select call_number 
, sum(case when call_type = 'OUT' then call_duration end) as out_duration
, sum(case when call_type = 'INC' then call_duration end) as in_duration
from call_details
group by call_number
having out_duration>in_duration and out_duration is not null and in_duration is not null;

-- using cte and join

with cte1 as(
select call_number
, sum(call_duration) as out_duration
from call_details
where call_type = 'OUT'
group by call_number
),cte2 as(
select call_number
, sum(call_duration) as in_duration
from call_details
where call_type = 'INC'
group by call_number)
select * from 
cte1 join cte2 on cte1.call_number=cte2.call_number
where cte1.out_duration > cte2.in_duration


