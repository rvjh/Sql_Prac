select * from exams;

-- students with same marks in in physics and chemistruy

SELECT *
FROM (SELECT * FROM exams WHERE subject = 'Chemistry') A
INNER JOIN 
(SELECT * FROM exams WHERE subject = 'Physics') B
ON A.student_id = B.student_id AND A.marks = B.marks;

-- 

select student_id
from exams
where subject in('Chemistry','Physics')
group by student_id
having count(distinct subject)=2 and count(distinct marks)=1;

