CREATE TABLE orders_rollup_cube_groupingset (
    Id INT PRIMARY KEY AUTO_INCREMENT, -- Added AUTO_INCREMENT for ease of inserting IDs
    Continent NVARCHAR(50),
    Country NVARCHAR(50),
    City NVARCHAR(50),
    Amount INT
);

-- Insert statements with corrected syntax for MySQL
INSERT INTO orders_rollup_cube_groupingset (Continent, Country, City, Amount) VALUES
('Asia', 'India', 'Bangalore', 1000),
('Asia', 'India', 'Chennai', 2000),
('Asia', 'Japan', 'Tokyo', 4000),
('Asia', 'Japan', 'Hiroshima', 5000),
('Europe', 'United Kingdom', 'London', 1000),
('Europe', 'United Kingdom', 'Manchester', 2000),
('Europe', 'France', 'Paris', 4000),
('Europe', 'France', 'Cannes', 5000);

select * from orders_rollup_cube_groupingset;

select continent, sum(amount)
from orders_rollup_cube_groupingset
group by continent;

select continent, country, city ,sum(amount) total_amt
from orders_rollup_cube_groupingset
group by continent,country, city;


select continent, null country, null city ,sum(amount) total_amt
from orders_rollup_cube_groupingset
group by continent;  -- ,country, city


select continent, country, city ,sum(amount) total_amt
from orders_rollup_cube_groupingset
group by continent,country, city
union all
select continent, null country, null city ,sum(amount) total_amt
from orders_rollup_cube_groupingset
group by continent
union all
select continent, country, null city ,sum(amount) total_amt
from orders_rollup_cube_groupingset
group by continent, country;


select continent, country,  city ,sum(amount) total_amt
from orders_rollup_cube_groupingset
group by continent, country,city with rollup;

SELECT continent, 
       country, 
       city, 
       SUM(amount) AS total_amt
FROM orders_rollup_cube_groupingset
GROUP BY continent, country, city WITH ROLLUP;