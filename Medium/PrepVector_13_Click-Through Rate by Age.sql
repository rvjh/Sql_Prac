CREATE TABLE users8 (
id INTEGER PRIMARY KEY,
name VARCHAR(100),
birthdate DATETIME
);

INSERT INTO users8 (id, name, birthdate) VALUES
(1, 'Alice', '1995-05-15'),
(2, 'Bob', '1985-03-20'),
(3, 'Charlie', '2005-07-10'),
(4, 'David', '1955-11-30'),
(5, 'Eve', '2015-09-25'),
(6, 'Frank', '1935-02-14'),
(7, 'Grace', '1975-12-01');

CREATE TABLE search_events8 (
search_id INTEGER PRIMARY KEY,
query VARCHAR(255),
has_clicked BOOLEAN,
user_id INTEGER,
search_time DATETIME,
FOREIGN KEY (user_id) REFERENCES users8(id)
);

INSERT INTO search_events8 (search_id, query, has_clicked, user_id, search_time) VALUES

(1, 'travel', TRUE, 1, '2021-03-15 10:00:00'),
(2, 'books', FALSE, 1, '2021-03-15 11:00:00'),
(3, 'cars', TRUE, 2, '2021-05-20 14:30:00'),
(4, 'tech', TRUE, 2, '2021-05-20 15:00:00'),
(5, 'games', FALSE, 3, '2021-07-10 16:45:00'),
(6, 'music', FALSE, 3, '2021-07-10 17:00:00'),
(7, 'retirement', TRUE, 4, '2021-09-05 09:15:00'),
(8, 'health', FALSE, 4, '2021-09-05 10:00:00'),
(9, 'toys', FALSE, 5, '2021-11-25 13:20:00'),
(10, 'genealogy', TRUE, 6, '2021-12-01 11:30:00'),
(11, 'history', TRUE, 6, '2021-12-01 12:00:00'),
(12, 'finance', TRUE, 7, '2021-02-15 08:45:00'),
(13, 'investing', FALSE, 7, '2021-02-15 09:00:00');

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

select * from users8;
select * from search_events8;

WITH age_calculate AS (
    SELECT 
        users8.id, 
        users8.name, 
        users8.birthdate, 
        search_events8.has_clicked,
        search_events8.search_time,
        TIMESTAMPDIFF(YEAR, users8.birthdate, search_events8.search_time) as age
    FROM users8 
    INNER JOIN search_events8 
        ON users8.id = search_events8.user_id
), age_group AS (
    SELECT *,
        CASE 
            WHEN age BETWEEN 0 AND 9 THEN '0-9'
            WHEN age BETWEEN 10 AND 19 THEN '10-19'
            WHEN age BETWEEN 20 AND 29 THEN '20-29'
            WHEN age BETWEEN 30 AND 39 THEN '30-39'
            WHEN age BETWEEN 40 AND 49 THEN '40-49'
            WHEN age BETWEEN 50 AND 59 THEN '50-59'
            WHEN age BETWEEN 60 AND 69 THEN '60-69'
            WHEN age BETWEEN 70 AND 79 THEN '70-79'
            WHEN age BETWEEN 80 AND 89 THEN '80-89'
            WHEN age BETWEEN 90 AND 99 THEN '90-99'
            ELSE '100+' 
        END AS age_grp
    FROM age_calculate
), clicked_data as(
select age_grp, 
	count(*) total_search,
    sum(case when has_clicked then 1 else 0 end) total_clicks
    from age_group
    group by age_grp)
select age_grp, (total_clicks/total_search) ctr
from clicked_data 
order by age_grp DESC;