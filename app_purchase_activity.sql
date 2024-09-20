CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);

insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

select * from activity;

-- total active users each date i.e. consider both app-installed or app-purchase

select event_date, count(distinct user_id) from activity
group by event_date;

-- total active users each week

select count(distinct user_id) active_users, week(event_date) week_num from activity
group by week(event_date);

-- datewise total users who purchased and installed on same day

select * from activity where event_name = 'app-installed';
select * from activity where event_name = 'app-purchase';

select event_date, count(user_id) as no_of_users from(
select user_id, event_date, count(distinct event_name) as no_of_events from activity
group by user_id, event_date having count(distinct event_name) =2) a
group by event_date;

select event_date, count(new_user) as no_of_users from(
select user_id, event_date, case when count(distinct event_name) =2 then user_id else null end as new_user from activity
group by user_id, event_date
) a
group by event_date;

-- percent of paid users of india, usa and for any other tagged others

with cte as(
select 
case when country in ('India','USA') then country else 'Others' end country_modified, 
count(distinct user_id) as num_users from activity
where event_name = 'app-purchase'
group by country_modified
), total_users as (select sum(num_users) total_users from cte)
select country_modified, round((num_users/total_users)*100,2) as percent from cte,total_users;

