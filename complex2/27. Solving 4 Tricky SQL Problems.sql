select * from students;


-- students who scored above average marks in each subject

with cte as(
select subject, avg(marks) avg_marks
from students 
group by subject)
select * from 
students inner join cte on students.subject = cte.subject and students.marks > cte.avg_marks;


-- % of students who scored more than 90 in any subject amongst the total students

select 
count(case when marks > 90 then studentid else null end)/count(distinct studentid) * 100 p
from students;


-- get the second highest and second lowest marks in each sub

with cte as(
select subject, marks,
rank() over(partition by subject order by marks desc) rn_high,
rank() over(partition by subject order by marks asc) rn_low
from students)
select subject,
max(case when rn_high =2 then marks end) as sec_high,
max(case when rn_low =2 then marks end) as sec_low
from cte
group by subject;


--  for each students check if theith marks increase/decrease from prev test

select *, 
case when marks > m_prev then "Inc" 
	 when marks < m_prev then "Dec" 
     else null
     end I_D
from(
select * ,
lag(marks,1) over(partition by studentid order by testdate,subject) m_prev
from students) A;










