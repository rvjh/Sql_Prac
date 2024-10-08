create table transactions(
order_id int,
cust_id int,
order_date date,
amount int
);

insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)
;

select * from transactions;

SELECT month(this_month.order_date) month_date, count(distinct last_month.cust_id)
FROM transactions AS this_month
LEFT JOIN transactions AS last_month 
    ON this_month.cust_id = last_month.cust_id 
    AND (MONTH(this_month.order_date) - MONTH(last_month.order_date)) =1 
group by month(this_month.order_date)
