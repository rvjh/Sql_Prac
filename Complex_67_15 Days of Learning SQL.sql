CREATE TABLE Submissions (
    submission_date DATE,
    submission_id INT PRIMARY KEY,
    hacker_id INT,
    score INT
);

INSERT INTO Submissions (submission_date, submission_id, hacker_id, score) VALUES
('2016-03-01', 8494, 20703, 0),
('2016-03-01', 22403, 53473, 15),
('2016-03-01', 23965, 79722, 60),
('2016-03-01', 30173, 36396, 70),
('2016-03-02', 34928, 20703, 0),
('2016-03-02', 38740, 15758, 60),
('2016-03-02', 42769, 79722, 25),
('2016-03-02', 44364, 79722, 60),
('2016-03-03', 45440, 20703, 0),
('2016-03-03', 49050, 36396, 70),
('2016-03-03', 50273, 79722, 5),
('2016-03-04', 50344, 20703, 0),
('2016-03-04', 51360, 44065, 90),
('2016-03-04', 54404, 53473, 65),
('2016-03-04', 61533, 79722, 15),
('2016-03-05', 72852, 20703, 0),
('2016-03-05', 74546, 38289, 0),
('2016-03-05', 76487, 62529, 0),
('2016-03-05', 82439, 36396, 10),
('2016-03-05', 90006, 36396, 40),
('2016-03-06', 90404, 20703, 0);


select * from Submissions;

with cte as(
select submission_date, hacker_id, count(*) no_of_submissions 
, dense_rank() over(order by submission_date) day_num
from Submissions
group by submission_date, hacker_id)
, cte2 as(
select * 
, count(*) over(partition by hacker_id order by submission_date) till_date_submission
, case when day_num = count(*) over(partition by hacker_id order by submission_date) then 1 else 0 end unique_flag
from cte)
, cte3 as(
select *, sum(unique_flag) over(partition by submission_date) unique_cnt,
row_number() over(partition by submission_date order by no_of_submissions desc, hacker_id) rn
from cte2)
select * from cte3 where rn=1