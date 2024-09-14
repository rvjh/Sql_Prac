CREATE TABLE city_population (
    state VARCHAR(50),
    city VARCHAR(50),
    population INT
);

-- Insert the data
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'ambala', 100);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'panipat', 200);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'gurgaon', 300);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'amritsar', 150);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'ludhiana', 400);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'jalandhar', 250);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'mumbai', 1000);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'pune', 600);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'nagpur', 300);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'bangalore', 900);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mysore', 400);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mangalore', 200);

select * from city_population

-- state for which city is highest and lowest populated

WITH cte AS (
    SELECT
        state,
        city,
        population,
        MAX(population) OVER (PARTITION BY state) AS max_pop,
        MIN(population) OVER (PARTITION BY state) AS min_pop
    FROM city_population
)
SELECT *,
    CASE WHEN population = max_pop THEN city END AS max_populated_city,
    CASE WHEN population = min_pop THEN city END AS min_populated_city
FROM cte;

WITH cte AS (
    SELECT
        state,
        city,
        population,
        MAX(population) OVER (PARTITION BY state) AS max_pop,
        MIN(population) OVER (PARTITION BY state) AS min_pop
    FROM city_population
)
SELECT state,
    max(CASE WHEN population = max_pop THEN city END) AS max_populated_city,
    max(CASE WHEN population = min_pop THEN city END) AS min_populated_city
FROM cte
group by state;

with cte as(
select *
, row_number() over(partition by state order by population desc) as max_p
, row_number() over(partition by state order by population) as min_p
from city_population
)
SELECT state,
    max(CASE WHEN max_p = 1 THEN city END) AS max_populated_city,
    max(CASE WHEN min_p = 1 THEN city END) AS min_populated_city
FROM cte
group by state;


