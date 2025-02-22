select * from employee_checkin_details;
select * from employee_details;

-- find
-- empid, emp_default_phn no, total_entry, total_logins, total_logouts, last_login, last_logout


with cte as(
select employeeid, count(*) total_entry
, sum(case when entry_details='login' then 1 else 0 end) total_login
, sum(case when entry_details='logout' then 1 else 0 end) total_logout
, max(case when entry_details='login' then timestamp_details end) last_login 
, max(case when entry_details='logout' then timestamp_details end) last_logout
from employee_checkin_details
group by employeeid)
select cte.*,employee_details.phone_number primary_phn_no  from cte
left join employee_details on cte.employeeid = employee_details.employeeid
where employee_details.isdefault = 1 or employee_details.isdefault is null