CREATE TABLE projects_sequesnce (
id INTEGER PRIMARY KEY,
title VARCHAR(100),
start_date DATETIME,
end_date DATETIME,
budget FLOAT
);

INSERT INTO projects_sequesnce (id, title, start_date, end_date, budget) VALUES
(1, 'Website Redesign', '2024-01-01', '2024-02-15', 50000),
(2, 'Mobile App Phase 1', '2024-02-15', '2024-04-01', 75000),
(3, 'Database Migration', '2024-04-01', '2024-05-15', 60000),
(4, 'Cloud Integration', '2024-03-01', '2024-04-15', 45000),
(5, 'Security Audit', '2024-05-15', '2024-06-30', 30000);

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

select * from projects_sequesnce;

-- Write a query to return pairs of projects where the end date of one project matches 
-- the start date of another project.

with  cte as(
select A.title M, A.end_date end_Date, B.title N, B.start_date from
(select title, end_date from projects_sequesnce) A
join
(select title, start_date from projects_sequesnce) B on B.start_date = A.end_date)
select M as project_title_end, N as project_title_start, end_Date as date from cte 
