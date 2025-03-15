CREATE TABLE swipe (
    employee_id INT,
    activity_type VARCHAR(10),
    activity_time datetime
);

-- Insert sample data
INSERT INTO swipe (employee_id, activity_type, activity_time) VALUES
(1, 'login', '2024-07-23 08:00:00'),
(1, 'logout', '2024-07-23 12:00:00'),
(1, 'login', '2024-07-23 13:00:00'),
(1, 'logout', '2024-07-23 17:00:00'),
(2, 'login', '2024-07-23 09:00:00'),
(2, 'logout', '2024-07-23 11:00:00'),
(2, 'login', '2024-07-23 12:00:00'),
(2, 'logout', '2024-07-23 15:00:00'),
(1, 'login', '2024-07-24 08:30:00'),
(1, 'logout', '2024-07-24 12:30:00'),
(2, 'login', '2024-07-24 09:30:00'),
(2, 'logout', '2024-07-24 10:30:00');

select * from swipe;

-- find total time spent in office -- total time = logout - login 

WITH cte AS (
    SELECT 
        *, 
        CAST(activity_time AS DATE) AS activity_date,
        LEAD(activity_time, 1) OVER (
            PARTITION BY employee_id, CAST(activity_time AS DATE) 
            ORDER BY activity_time ASC
        ) AS logout_time
    FROM 
        swipe
)
SELECT 
    employee_id,
    activity_date,
    TIMESTAMPDIFF(HOUR, MIN(activity_time), MAX(logout_time)) AS total_hours_worked,
    sum(TIMESTAMPDIFF(HOUR, activity_time, logout_time)) inside_hrs
FROM 
    cte
WHERE 
    activity_type = 'login'
GROUP BY 
    employee_id, activity_date;



