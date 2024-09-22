create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);

select * from exams;

-- students with same marks in physics and chemistry

with cte as(
select student_id,
sum(CASE when subject='Chemistry' then marks else 0 end) as chem_marks,
sum(CASE when subject='Physics' then marks else 0 end) as phy_marks
from exams group by student_id)
select * from cte where chem_marks=phy_marks;

select * from exams;

select student_id
from exams
where subject in ('Chemistry','Physics')
group by student_id
having count(distinct subject)=2 and count(distinct marks)=1








