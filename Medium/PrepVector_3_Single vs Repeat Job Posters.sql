CREATE TABLE job_postings (
    id INT PRIMARY KEY,
    user_id INT,
    job_id INT,
    posted_date DATETIME
);

INSERT INTO job_postings (id, user_id, job_id, posted_date) VALUES
    (1, 1, 101, '2024-01-01'),
    (2, 1, 102, '2024-01-02'),
    (3, 2, 201, '2024-01-01'),
    (4, 2, 201, '2024-01-15'),
    (5, 2, 202, '2024-01-03'),
    (6, 3, 301, '2024-01-01'),
    (7, 4, 401, '2024-01-01'),
    (8, 4, 401, '2024-01-15'),
    (9, 4, 402, '2024-01-02'),
    (10, 4, 402, '2024-01-16'),
    (11, 5, 501, '2024-01-05'),
    (12, 5, 502, '2024-01-10');
    
-- Given a table of job postings, write a query to retrieve the number of users that have 
-- posted each job only once and the number of users that have posted at least one job 
-- multiple times.

with job_post_count as(
select user_id, job_id, count(*) a
from job_postings
group by user_id, job_id)
, multiple_job_post as(
select DISTINCT user_id 
from job_post_count 
where a>1)
, single_job_post as(
select DISTINCT user_id 
from job_post_count
where a=1 and user_id not in (select user_id from multiple_job_post))
select
(select count(*) from single_job_post) as single_post_users,
(select count(*) from multiple_job_post) as multiple_post_users


