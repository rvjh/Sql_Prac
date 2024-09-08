use test1;

create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);

insert into tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');

select * from tickets;

create table holidays
(
holiday_date date
,reason varchar(100)
);

insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');

select * from holidays;

select * from tickets;

SELECT *, DATEDIFF(resolved_date, create_date) AS actual_days,
(week(resolved_date) - week(create_date)) as week_diff,
(DATEDIFF(resolved_date, create_date) - 2*(week(resolved_date) - week(create_date))) as business_days
FROM tickets;

select ticket_id, create_date, resolved_date, count(holiday_date) from
tickets left join holidays on holiday_date between create_date and resolved_date
group by ticket_id, create_date, resolved_date;

-- number of business days excluding holidays

select ticket_id, create_date, resolved_date,
datediff(resolved_date, create_date) as actual_days,
(week(resolved_date) - week(create_date)) as no_of_weeks,
(datediff(resolved_date, create_date) - 2*(week(resolved_date) - week(create_date))) as business,
count(holiday_date),
((datediff(resolved_date, create_date) - 2*(week(resolved_date) - week(create_date))) - count(holiday_date)) as actual_business_days
from tickets left join holidays on holiday_date between create_date and resolved_date
group by ticket_id, create_date, resolved_date

