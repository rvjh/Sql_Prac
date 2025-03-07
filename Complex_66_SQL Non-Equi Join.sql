CREATE TABLE covid_case_data (
    record_date DATE,
    new_cases DECIMAL(10, 2)
);

INSERT INTO covid_case_data (record_date, new_cases) VALUES 
('2025-01-01', 500),
('2025-01-02', 750),
('2025-01-03', 300),
('2025-01-04', 250),
('2025-01-05', 125),
('2025-01-06', 300),
('2025-01-07', 950),
('2025-01-08', 220),
('2025-01-09', 780),
('2025-01-10', 420),
('2025-01-11', 590),
('2025-01-12', 660),
('2025-01-13', 830),
('2025-01-14', 990),
('2025-01-15', 550),
('2025-01-16', 715),

('2025-02-01', 600),
('2025-02-02', 1100),
('2025-02-03', 900),
('2025-02-04', 400),
('2025-02-05', 310),
('2025-02-06', 625),
('2025-02-07', 470),
('2025-02-08', 360),
('2025-02-09', 505),
('2025-02-10', 780),
('2025-02-11', 900),
('2025-02-12', 620),
('2025-02-13', 815),
('2025-02-14', 770),
('2025-02-15', 450),
('2025-02-16', 615),

('2025-03-01', 650),
('2025-03-02', 300),
('2025-03-03', 750),
('2025-03-04', 1000),
('2025-03-05', 410),
('2025-03-06', 325),
('2025-03-07', 570),
('2025-03-08', 460),
('2025-03-09', 705),
('2025-03-10', 980),
('2025-03-11', 620),
('2025-03-12', 820),
('2025-03-13', 515),
('2025-03-14', 770),
('2025-03-15', 660),
('2025-03-16', 615),

('2025-04-01', 1200),
('2025-04-02', 400),
('2025-04-03', 850),
('2025-04-04', 1300),
('2025-04-05', 1010),
('2025-04-06', 425),
('2025-04-07', 670),
('2025-04-08', 860),
('2025-04-09', 305),
('2025-04-10', 480),
('2025-04-11', 600),
('2025-04-12', 520),
('2025-04-13', 815),
('2025-04-14', 670),
('2025-04-15', 550),
('2025-04-16', 815);

select * from covid_case_data;

select month(record_date) as Month, round(sum(new_cases),0) month_cnt
from covid_case_data
group by month(record_date);


with cte as(
select month(record_date) as record_month, round(sum(new_cases),0) monthly_cases
from covid_case_data
group by month(record_date))
select * from cte;


-- using non-equi join

with cte as(
select month(record_date) as record_month, round(sum(new_cases),0) monthly_cases
from covid_case_data
group by month(record_date))
, cte2 as(
select 
current_month.record_month current_month, prev_month.record_month prior_months,
current_month.monthly_cases current_count, prev_month.monthly_cases prior_count
from cte current_month left join cte prev_month 
on prev_month.record_month < current_month.record_month)
select current_month, current_count, sum(prior_count) cum_sum, current_count*100/sum(prior_count) per_cnt
from cte2
group by current_month, current_count;

-- using adv aggregation 

with cte as(
select month(record_date) as record_month, round(sum(new_cases),0) monthly_cases
from covid_case_data
group by month(record_date))
, cte2 as(
select *,
sum(monthly_cases) over(order by record_month rows between unbounded preceding and 1 preceding) cum_sum 
from cte)
select *, monthly_cases*100/cum_sum per_cnt from cte2;

