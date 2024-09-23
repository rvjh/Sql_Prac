CREATE TABLE students (
    studentid INT NULL,
    studentname VARCHAR(255) NULL,
    subject VARCHAR(255) NULL,
    marks INT NULL,
    testid INT NULL,
    testdate DATE NULL
);

INSERT INTO students VALUES (2, 'Max Ruin', 'Subject1', 63, 1, '2022-01-02');
INSERT INTO students VALUES (3, 'Arnold', 'Subject1', 95, 1, '2022-01-02');
INSERT INTO students VALUES (4, 'Krish Star', 'Subject1', 61, 1, '2022-01-02');
INSERT INTO students VALUES (5, 'John Mike', 'Subject1', 91, 1, '2022-01-02');
INSERT INTO students VALUES (4, 'Krish Star', 'Subject2', 71, 1, '2022-01-02');
INSERT INTO students VALUES (3, 'Arnold', 'Subject2', 32, 1, '2022-01-02');
INSERT INTO students VALUES (5, 'John Mike', 'Subject2', 61, 2, '2022-11-02');
INSERT INTO students VALUES (1, 'John Deo', 'Subject2', 60, 1, '2022-01-02');
INSERT INTO students VALUES (2, 'Max Ruin', 'Subject2', 84, 1, '2022-01-02');
INSERT INTO students VALUES (2, 'Max Ruin', 'Subject3', 29, 3, '2022-01-03');
INSERT INTO students VALUES (5, 'John Mike', 'Subject3', 98, 2, '2022-11-02');

select * from students;

-- list of students who scored above average marks in each subject

with cte as(
select subject, avg(marks) avg_marks 
from students
group by subject)
select * from 
students inner join cte on students.subject = cte.subject
where students.marks > cte.avg_marks;

-- percentage of students who score more than 90 in any subject amongst the total students

select
round((count(distinct case when marks>90 then studentid else null end) / count(distinct studentid))*100, 2) students_more_90
from students;

-- get the secound highest and second lowest for each subject

select subject,
max(marks) max_marks, min(marks) min_marks
from students
group by subject;

select subject,
sum(case when rnk_desc=2 then marks else null end) as sec_high_marks,
sum(case when rnk_asc=2 then marks else null end) as sec_low_marks
from(
select subject, marks,
rank() over(partition by subject order by marks asc) rnk_asc,
rank() over(partition by subject order by marks desc) rnk_desc
from students) A
group by subject;

-- for each students and test identify their marks increased/ decrease from previous test

select *
, case when marks > prev_marks then 'inc' else 'dec' end as marks_inc_dec
from (
SELECT *,
    LAG(marks, 1) OVER (PARTITION BY studentid ORDER BY testdate, subject) AS prev_marks
    -- LEAD(marks, 1) OVER (PARTITION BY studentid ORDER BY testdate, subject) AS next_marks
FROM students) A



