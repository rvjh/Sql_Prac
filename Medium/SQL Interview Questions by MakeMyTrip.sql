create table makemytrip_booking_table (
    booking_id varchar(10),
    booking_date date,
    user_id varchar(10),
    line_of_business varchar(20)
);

insert into makemytrip_booking_table (booking_id, booking_date, user_id, line_of_business) values
('b1',  '2022-03-23', 'u1', 'Flight'),
('b2',  '2022-03-27', 'u2', 'Flight'),
('b3',  '2022-03-28', 'u1', 'Hotel'),
('b4',  '2022-03-31', 'u4', 'Flight'),
('b5',  '2022-04-02', 'u1', 'Hotel'),
('b6',  '2022-04-02', 'u2', 'Flight'),
('b7',  '2022-04-06', 'u5', 'Flight'),
('b8',  '2022-04-06', 'u6', 'Hotel'),
('b9',  '2022-04-06', 'u2', 'Flight'),
('b10', '2022-04-10', 'u1', 'Flight'),
('b11', '2022-04-12', 'u4', 'Flight'),
('b12', '2022-04-16', 'u1', 'Flight'),
('b13', '2022-04-19', 'u2', 'Flight'),
('b14', '2022-04-20', 'u5', 'Hotel'),
('b15', '2022-04-22', 'u6', 'Flight'),
('b16', '2022-04-26', 'u4', 'Hotel'),
('b17', '2022-04-28', 'u2', 'Hotel'),
('b18', '2022-04-30', 'u1', 'Hotel'),
('b19', '2022-05-04', 'u4', 'Hotel'),
('b20', '2022-05-06', 'u1', 'Flight');

create table makemytrip_user_table (
    user_id varchar(10),
    segment varchar(10)
);

insert into makemytrip_user_table (user_id, segment) values
('u1', 's1'),
('u2', 's1'),
('u3', 's1'),
('u4', 's2'),
('u5', 's2'),
('u6', 's3'),
('u7', 's3'),
('u8', 's3'),
('u9', 's3'),
('u10', 's3');


select * from makemytrip_booking_table;
select * from makemytrip_user_table;


-- q1 ---

select u.segment, count(distinct u.user_id) total_user_count,
count(distinct case when b.booking_date between '2022-04-01' and '2022-04-30' then u.user_id else null end) ap_2022
from makemytrip_user_table u
left join makemytrip_booking_table b on u.user_id = b.user_id
group by u.segment;

-- q3--
 -- users whose first booking is hotel 

with cte as(
select *,
row_number() over(partition by user_id order by booking_date asc) rn
from makemytrip_booking_table)
select user_id, booking_id, booking_date, line_of_business
from cte where rn=1 and line_of_business = 'Hotel';

-- q4--
-- days b/w first and last booking of user with user_id = u1

with cte as(
select *,
row_number() over(partition by user_id order by booking_date asc) rn
from makemytrip_booking_table)
select user_id, datediff(max(booking_date), min(booking_date)) datediff
from cte
where user_id='u1';

-- q5 -- 
-- count no of flights and hotel bookings in each of the user segment for the year 2022

select u.segment,
count(case when line_of_business = 'Flight' then u.user_id else null end) flight_cnt,
count(case when line_of_business = 'Hotel' then u.user_id else null end) HOtel_cnt
from makemytrip_user_table u
left join makemytrip_booking_table b on u.user_id = b.user_id
where year(b.booking_date) = 2022
group by u.segment;

-- q2--
-- for each segment user  who made the earliest booking in april 2024 and 
-- how many total bookings that user made on april 2024


with cte as(
select u.segment, b.*,
row_number() over(partition by u.segment order by booking_date asc) rn,
count(*) over(partition by u.segment,u.user_id) cnt_of_bookings
from makemytrip_user_table u
left join makemytrip_booking_table b on u.user_id = b.user_id
where b.booking_date between '2022-04-01' and '2022-04-30')
select segment,user_id, cnt_of_bookings
from cte where rn=1;



