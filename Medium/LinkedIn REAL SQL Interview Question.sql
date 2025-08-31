CREATE TABLE emp_details_linkedin (
    emp_name VARCHAR(10),
    city VARCHAR(15)
);

-- Insert sample data
INSERT INTO emp_details_linkedin (emp_name, city) VALUES
('Sam', 'New York'),
('David', 'New York'),
('Peter', 'New York'),
('Chris', 'New York'),
('John', 'New York'),
('Steve', 'San Francisco'),
('Rachel', 'San Francisco'),
('Robert', 'Los Angeles');


WITH cte AS (
SELECT *, ROW_NUMBER() OVER (PARTITION BY city ORDER BY city) AS rn
FROM emp_details_linkedin),
cte2 AS (
SELECT *, CEIL(rn / 3.0) AS team_grp
FROM cte), 
cte3 as(
SELECT city,team_grp,GROUP_CONCAT(emp_name ORDER BY emp_name) AS team
FROM cte2
GROUP BY city, team_grp)
select city, team, concat('Team', row_number() over(order by city)) team_no
from cte3
