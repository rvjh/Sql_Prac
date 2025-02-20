select * from booking_table;
select * from user_table;

-- segmrnt count_users flight_booked_april_2022


select u.Segment, count(distinct u.User_id) cnt_user,
count(distinct (case when b.line_of_business = 'Flight' and b.Booking_date between '2022-04-01' and '2022-04-30' then b.User_id end)) user_flight
from user_table u left join booking_table b on u.user_id = b.user_id
group by u.Segment;

-- identify users whose first booking is hotel

with cte as(
select *,
rank() over(partition by User_id order by Booking_date asc) rn
from booking_table)
select * from cte where Line_of_business='Hotel' and rn=1;

-- calculate days b/w first and last booking of each user

SELECT 
    User_id,
    MIN(Booking_date) AS First_Book, 
    MAX(Booking_date) AS Last_Book,
    DATEDIFF(MAX(Booking_date), MIN(Booking_date)) AS days_btw_first_last_booking
FROM 
    booking_table
GROUP BY 
    User_id;
    

-- for year 2022 for each segment count of flights and hotel bookings


select u.Segment, 
sum(case when b.Line_of_business = 'Flight' then 1 else 0 end) Flight_cnt,
sum(case when b.Line_of_business = 'Hotel' then 1 else 0 end) Hotel_cnt
from user_table u left join booking_table b on u.user_id = b.user_id
where year(b.Booking_date)=2022
group by u.Segment



