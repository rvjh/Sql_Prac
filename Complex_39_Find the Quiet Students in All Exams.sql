select * from students_v2;
select * from exams_v2;

-- find the quite students
-- "quite" - atleast taken one exam and didnt score nither hign nor low. return order by student_id

-- students who have taken exam
select students_v2.student_id, students_v2.student_name,exams_v2.exam_id, exams_v2.score  from
students_v2 inner join exams_v2 on students_v2.student_id = exams_v2.student_id;


-- min max score in exam
select exam_id, min(score) min_sc, max(score) max_sc from exams_v2
group by exam_id;

with cte as(
select exam_id, min(score) min_sc, max(score) max_sc from exams_v2
group by exam_id),
cte2 as(
select exams_v2.*, min_sc, max_sc
from exams_v2 inner join cte on exams_v2.exam_id = cte.exam_id),
cte3 as(
select * from cte2 
where score > min_sc and score < max_sc)
select students_v2.student_id, students_v2.student_name
from cte3 join students_v2 on cte3.student_id = students_v2.student_id