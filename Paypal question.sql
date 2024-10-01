CREATE TABLE employee_checkin_details (
    employeeid INT,
    entry_details VARCHAR(10),
    timestamp_details DATETIME(3),
    PRIMARY KEY (employeeid, timestamp_details)
);

CREATE TABLE employee_details (
    employeeid INT,
    phone_number VARCHAR(10),
    isdefault BOOLEAN,
    PRIMARY KEY (employeeid, phone_number)
);

INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES
(1000, 'login', '2023-06-16 01:00:15.340'),
(1000, 'login', '2023-06-16 02:00:15.340'),
(1000, 'login', '2023-06-16 03:00:15.340'),
(1000, 'logout', '2023-06-16 12:00:15.340'),
(1001, 'login', '2023-06-16 01:00:15.340'),
(1001, 'login', '2023-06-16 02:00:15.340'),
(1001, 'login', '2023-06-16 03:00:15.340'),
(1001, 'logout', '2023-06-16 12:00:15.340');

INSERT INTO employee_details (employeeid, phone_number, isdefault) VALUES
(1001, '9999', false),
(1001, '1111', false),
(1001, '2222', true),
(1003, '3333', false);

select * from employee_checkin_details;
select * from employee_details;

-- emp id , default_phone, total entry, total login, total logout
-- latest login, latest logout


select * from employee_details;


with login as(
select employeeid, count(*) total_login, max(timestamp_details) latestlogin
from employee_checkin_details 
where entry_details = 'login'
group by employeeid
),logout as(
select employeeid, count(*) total_logout, max(timestamp_details) latestlogout
from employee_checkin_details 
where entry_details = 'logout'
group by employeeid
)
select a.employeeid, a.total_login, 
	   b.total_logout, a.latestlogin, 
       b.latestlogout, (a.total_login + b.total_logout) total_entry,
       c.phone_number, c.isdefault
from login a inner join logout b on a.employeeid = b.employeeid
left join employee_details c on a.employeeid = c.employeeid and c.isdefault=1;



select A.employeeid, B.phone_number, B.isdefault,
count(entry_details) total_entry,
sum(case when entry_details = 'login' then 1 else 0 end) as total_login,
sum(case when entry_details = 'logout' then 1 else 0 end) as total_logout,
max(case when entry_details = 'login' then timestamp_details end) latestlogin, 
max(case when entry_details = 'logout' then timestamp_details end) latestlogout
from employee_checkin_details A left join employee_details B
on A.employeeid = B.employeeid  and B.isdefault = 1
group by A.employeeid, B.phone_number
 