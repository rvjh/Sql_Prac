select * from booking_table;
select * from user_table;


with cte as(
select User_id, month(Booking_Date) m, Line_of_business 
from booking_table
where month(Booking_Date) = 4 and Line_of_business='Flight')


-- 1

select u.Segment, count(distinct u.User_id) no_of_users,
count(distinct case when b.Line_of_business='Flight' and b.Booking_date between '2022-04-01' and '2022-04-29' then b.User_id else null end) a
from user_table u left join booking_table b on u.User_id = b.User_id
group by u.Segment;


-- 2

with cte as(
select *,
rank() over(partition by User_id  order by Booking_date asc) r
from booking_table)
select * from cte
where r=1 and Line_of_business='Hotel';


-- 3

select User_id, min(Booking_date) f_book, max(Booking_date) l_book, datediff(max(Booking_date),min(Booking_date)) no_of_days
from(
select *,
rank() over(partition by User_id  order by Booking_date asc) r
from booking_table) A
group by User_id;


-- 4 count flight, hotel booking for each segment in 2022

with cte as(
select u.Segment,
case when b.Line_of_business = 'Flight' then 1 else 0 end flight_c,
case when b.Line_of_business = 'Hotel' then 1 else 0 end Hotel_c
from
booking_table b inner join user_table u on b.User_id = u.User_id
where year(b.Booking_date)=2022
)
select Segment,
sum(flight_c) f, sum(Hotel_c) h
from cte
group by Segment;




















