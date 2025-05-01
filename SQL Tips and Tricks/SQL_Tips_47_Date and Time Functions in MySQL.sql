CREATE TABLE date_functions_demo (
    id INT ,
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
 system_date varchar(10)
);

INSERT INTO date_functions_demo (id,start_date, end_date, created_at, updated_at,system_date) VALUES 
(1,'2024-01-01', '2024-12-31', '2024-01-01 10:00:00', '2024-12-31 23:59:59','12/30/2024'),
(2,'2023-06-15', '2024-06-15', '2023-06-15 08:30:00', '2024-06-15 17:45:00','08/15/2024'),
(3,'2022-05-20', '2023-05-20', '2022-05-20 12:15:00', '2023-05-20 18:00:00','10/21/2024');

select * from date_functions_demo;

-- 1. current timestamp
select current_timestamp();
select now();

-- 2. current date
select current_date();

-- 3. current time

select current_time();

select *, current_time() from date_functions_demo;

-- 4. convert timestamp column to date

select * from date_functions_demo;

select id, date(created_at), date(updated_at) from date_functions_demo;
-- or 
select id, cast(created_at as date), cast(updated_at as date) from date_functions_demo;

-- 5. dateformat(dd-mm-yy) or anything

select id, created_at, date_format(updated_at,'%d/%m/%y') from date_functions_demo;
select id, created_at, date_format(updated_at,'%y-%d-%m') from date_functions_demo;

-- 6. datediff

select id, date(created_at), date(updated_at) , datediff(date(updated_at),date(created_at)) diff from date_functions_demo;

-- 7. dateadd
select id, date(created_at), date_add(date(created_at),interval 1 day) cteate_1 
from date_functions_demo;

select id, date(created_at), date_add(date(created_at),interval 3 year) cteate_1 
from date_functions_demo;

select id, created_at, date_add(created_at,interval 5 hour) cteate_1 
from date_functions_demo;

-- 8. datesubstact 

select id, created_at, date_sub(created_at,interval 1 day) cteate_1 
from date_functions_demo;

select id, created_at, date_sub(created_at,interval 5 hour) cteate_1 
from date_functions_demo;

-- 9. day

select id, created_at, day(created_at) cteate_1 
from date_functions_demo;

-- 10. month
select id, created_at, month(created_at) cteate_1 
from date_functions_demo;

-- 11. year

select id, created_at, year(created_at) cteate_1 
from date_functions_demo;

-- 12. dayofweek

select id, created_at, dayofweek(created_at) cteate_1 
from date_functions_demo;

-- 13. dayofmonth

select id, created_at, dayofmonth(created_at) cteate_1 
from date_functions_demo;

-- 14. dayofyear

select id, created_at, dayofyear(created_at) cteate_1 
from date_functions_demo;

-- 15. monthname

select id, created_at, monthname(created_at) cteate_1 
from date_functions_demo;

-- 16. dayname

select id, created_at, dayname(created_at) cteate_1 
from date_functions_demo;

-- 17. str_to_date

select * from date_functions_demo;
select system_date,  str_to_date(system_date,'%m/%d/%y') cteate_1 
from date_functions_demo;

select system_date,  str_to_date(system_date,'%m-%d-%y') cteate_1 
from date_functions_demo; -- error dye to / 

-- 18. timestampdiff
select id, date(created_at), date(updated_at), 
timestampdiff(hour,created_at, updated_at) from date_functions_demo;

select id, date(created_at), date(updated_at), 
timestampdiff(second,created_at, updated_at) from date_functions_demo;

select id, date(created_at), date(updated_at), 
timestampdiff(month,created_at, updated_at) from date_functions_demo;

select id, date(created_at), date(updated_at), 
timestampdiff(year,created_at, updated_at) from date_functions_demo;

-- 19. last date -- end date of the last month

select id, date(created_at), last_day(created_at) ld
from date_functions_demo; 

-- 	20. extract date, hour, year

select id, date(created_at), extract(day from created_at) d, extract(month from created_at) m,
extract(hour from created_at) h, extract(second from created_at) s
from date_functions_demo; 














	






