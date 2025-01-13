-- total charges as per billing rates

select * from billings;
select * from hoursworked;

with date_range as(
SELECT *, 
    LEAD(DATE_SUB(bill_date, INTERVAL 1 DAY), 1, '9999-12-31') OVER (PARTITION BY emp_name ORDER BY bill_date ASC) AS bill_date_end
FROM billings)
select hw.*, dr.bill_date from date_range dr
inner join hoursworked hw on hw.emp_name = dr.emp_name and hw.work_date between dr.bill_date and dr.bill_date_end;


with date_range as(
SELECT *, 
    LEAD(DATE_SUB(bill_date, INTERVAL 1 DAY), 1, '9999-12-31') OVER (PARTITION BY emp_name ORDER BY bill_date ASC) AS bill_date_end
FROM billings)
select hw.emp_name, sum(dr.bill_rate*hw.bill_hrs) billing_rate from date_range dr
inner join hoursworked hw on hw.emp_name = dr.emp_name and hw.work_date between dr.bill_date and dr.bill_date_end
group by hw.emp_name