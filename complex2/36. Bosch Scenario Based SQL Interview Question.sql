select * from call_details;

-- find numbers : 
-- 1. numbers that have incoming and outgoing calls
-- 2. sum of durations of outgoing calls > sum of durations of incoming calls


with call_type_out as(
select *
from call_details
where call_type ='OUT')
, call_type_in as(
select *
from call_details
where call_type ='INC')
, numbers_call as(
select call_type_in.call_number, sum(call_type_out.call_duration) sum_out, sum(call_type_in.call_duration) sum_in
from call_type_out inner join call_type_in on call_type_in.call_number = call_type_out.call_number
group by call_type_in.call_number)
select * from numbers_call where sum_out>sum_in;


select * from (
select call_number
, sum(case when call_type ='OUT' then call_duration end) call_out
, sum(case when call_type ='INC' then call_duration end) call_in
from call_details
group by call_number) A
where call_out>call_in;



