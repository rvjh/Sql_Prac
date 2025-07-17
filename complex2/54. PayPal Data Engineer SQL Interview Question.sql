select * from employee_checkin_details;
select * from employee_details;

-- empployeeid, totalentry, totallogin, totallogout, latest_login latestlogout, employee_fefault_phn_number

select * from employee_details;


with cte as(
select employeeid, count(*) totallogin, max(timestamp_details) latest_login
from employee_checkin_details
where entry_details = 'login'
group by employeeid)
, cte1 as(
select employeeid, count(*) totallogout, max(timestamp_details) latest_logout
from employee_checkin_details
where entry_details = 'logout'
group by employeeid)
, cte2 as(
select cte.employeeid, cte.totallogin + cte1.totallogout as totalentry, 
cte.totallogin, cte1.totallogout,
cte.latest_login, cte1.latest_logout
from
cte inner join cte1 on cte.employeeid = cte1.employeeid)
select cte2.*, A.phone_number default_phn_num
from cte2 left join 
(select employeeid, phone_number from employee_details where isdefault = 1) A 
on cte2.employeeid = A.employeeid;


-- 

with cte as(
select employeeid,
count(case when entry_details = 'login' then timestamp_details else null end) as logins,
count(case when entry_details = 'logout' then timestamp_details else null end) as logouts,
max(case when entry_details = 'login' then timestamp_details else null end) as latest_logins,
max(case when entry_details = 'logout' then timestamp_details else null end) as latest_logouts
from employee_checkin_details
group by employeeid)
select cte.*, cte.logins + cte.logouts as totalentries, A.phone_number default_phn_num
from cte left join 
(select employeeid, phone_number from employee_details where isdefault = 1) A 
on cte.employeeid = A.employeeid;



