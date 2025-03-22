use test1;
create table assessments
(
id int,
experience int,
sql_test int,
algo int,
bug_fixing int
);

insert into assessments values 
(1,3,100,null,50),
(2,5,null,100,100),
(3,1,100,100,100),
(4,5,100,50,null),
(5,5,100,100,100);

select * from assessments;

select experience as experience_level,
count(id) total_students,
sum(case when sql_test is null or algo is null or bug_fixing is null then 0 else 1 end) rn
from assessments 
group by experience
order by experience;

with cte as(
select *, 
case when sql_test is null or sql_test<100 then 0 else 1 end sql_perfect_score,
case when algo is null or algo<100 then 0 else 1 end algo_perfect_score,
case when bug_fixing is null or bug_fixing<100 then 0 else 1 end bug_fixing_perfect_score
from assessments)
select experience as experience_level, count(id) as total_students,
sum(case when sql_perfect_score+algo_perfect_score+bug_fixing_perfect_score >= 2 then 1 else 0 end ) max_score_students
from cte
group by experience
order by experience;

