CREATE TABLE events_3 (
user_id INT,
created_at DATETIME,
action VARCHAR(20)
);

INSERT INTO events_3 VALUES
(1, '2020-01-01 10:00:00', 'post_enter'),
(1, '2020-01-01 10:05:00', 'post_submit'),
(2, '2020-01-01 11:00:00', 'post_enter'),
(2, '2020-01-01 11:10:00', 'post_canceled'),
(3, '2020-01-01 15:00:00', 'post_enter'),
(3, '2020-01-01 15:30:00', 'post_submit'),
(4, '2020-01-02 09:00:00', 'post_enter'),
(4, '2020-01-02 09:15:00', 'post_canceled'),
(5, '2020-01-02 10:00:00', 'post_enter'),
(5, '2020-01-02 10:10:00', 'post_canceled'),
(10, '2020-01-15 14:00:00', 'post_enter'),
(10, '2020-01-15 14:30:00', 'post_submit'),
(6, '2019-12-31 23:55:00', 'post_enter'),
(6, '2020-01-01 00:05:00', 'post_submit'),
(7, '2020-02-01 00:00:00', 'post_enter'),
(7, '2020-02-01 00:10:00', 'post_submit'),
(8, '2019-01-15 10:00:00', 'post_enter'),
(8, '2019-01-15 10:30:00', 'post_submit'),
(9, '2021-01-01 09:00:00', 'post_enter'),
(9, '2021-01-01 09:10:00', 'post_canceled');

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

-- post success rate

select * from events_3;

with cte as(
select date(created_at) date,
sum(case when action='post_enter' then 1 else 0 end) as total_enters,
sum(case when action='post_submit' then 1 else 0 end) as total_submits
from events_3
group by date(created_at))
select * 
, (total_submits/total_enters) as success_rate
from cte



