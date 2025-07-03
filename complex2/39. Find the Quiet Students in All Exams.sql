select * from students_v2;
select * from exams_v2;


-- at least one exam and neither max score nor low score

with score_table as(
select exam_id, max(score) max_score, min(score) min_score
from exams_v2
group by exam_id)
, one_exam as(
select * 
, row_number() over(partition by student_id order by exam_id) rn
from exams_v2)
select * 
from one_exam inner join score_table on score_table.exam_id = one_exam.exam_id
where one_exam.score != score_table.max_score and one_exam.score !=score_table.min_score;
select exam_id, max(score) max_score, min(score) min_score
from exams_v2
group by exam_id;
select * 
, row_number() over(partition by student_id order by exam_id) rn
from exams_v2;

with all_exams as(
select exam_id, max(score) max_score, min(score) min_score
from exams_v2
group by exam_id)
select exams_v2.student_id
from exams_v2
inner join all_exams on exams_v2.exam_id = all_exams.exam_id
group by exams_v2.student_id
having max(case when score=min_score or score=max_score then 1 else 0 end)=0;

