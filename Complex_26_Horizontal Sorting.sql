select * from subscriber;

-- find total no of messages exchanged b/w each person per day -- using horizontal sorting

select *,
case when sender < receiver then sender else receiver end p1,
case when sender > receiver then sender else receiver end p2
from subscriber;

select sms_date, 
case when sender < receiver then sender else receiver end p1,
case when sender > receiver then sender else receiver end p2,
sum(sms_no) no_of_msg
from subscriber
group by sms_date, p1,p2

