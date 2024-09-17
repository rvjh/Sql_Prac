create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);

select * from spending;

-- total number of users and total amount spend using mobile only, desktop only and 
-- mobile and desktop both together 


with all_spend as(
select spend_date, user_id, max(platform) as platform, sum(amount) as amount
from spending
group by spend_date, user_id having count(distinct platform) = 1
union all
select spend_date, user_id, 'both' as platform, sum(amount) as amount
from spending
group by spend_date, user_id having count(distinct platform) = 2
)
select spend_date, platform, sum(amount) as total_amount, count(distinct user_id) as total_users
from all_spend
group by spend_date, platform