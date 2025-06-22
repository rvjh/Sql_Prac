select * from subscriber;


-- total msg exchanged for each user  per day


select *,
case when sender < receiver then sender else receiver end p1,
case when sender > receiver then sender else receiver end p2
from subscriber;



select sms_date,
case when sender < receiver then sender else receiver end p1,
case when sender > receiver then sender else receiver end p2,
sum(sms_no) total_sms
from subscriber
group by sms_date, p1,p2;


