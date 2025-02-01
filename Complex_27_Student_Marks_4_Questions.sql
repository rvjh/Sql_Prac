select * from students;

-- 1. students who scored above average marks in each subject

with cte as(
select subject, avg(marks) avg_mrk
from students
group by subject)
select students.studentid, students.studentname, students.subject, students.marks, cte.avg_mrk from
students inner join cte on students.subject = cte.subject
where students.marks > cte.avg_mrk;


-- 2. percentage of students who score more than 90 in any subject amongst the total students

select * from students;

select
count(distinct case when marks>90 then studentid end), count(distinct studentid)
from students;

select
(count(distinct case when marks>90 then studentid end) / count(distinct studentid) *100) percentage_stu
from students;

-- 3. second highest and econd lowest marks in each subject

with cte as(
select subject, marks,
row_number() over(partition by subject order by marks asc) rn_asc,
row_number() over(partition by subject order by marks desc) rn_desc
from students)
select subject, 
case when  rn_desc=2 then marks end second_highest_marks,
case when  rn_asc=2 then marks end second_lowest_marks,
marks from cte;

WITH cte AS (
    SELECT subject, marks,
        ROW_NUMBER() OVER (PARTITION BY subject ORDER BY marks ASC) AS rn_asc,
        ROW_NUMBER() OVER (PARTITION BY subject ORDER BY marks DESC) AS rn_desc
    FROM students
)
SELECT subject, 
    SUM(CASE WHEN rn_desc = 2 THEN marks END) AS second_highest_marks,
    SUM(CASE WHEN rn_asc = 2 THEN marks END) AS second_lowest_marks
FROM cte
GROUP BY subject;


-- 4.  for each student identify if their score increase/ decreased from previous test

select * from students;

select *,
case when marks>pervious_marks then "inc" else "dec" end marks_inc_dec
from (
select *,
lag(marks,1) over(partition by studentid order by subject,marks) pervious_marks
from students) A




