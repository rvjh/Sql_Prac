CREATE TABLE input_table_1 (
    Market VARCHAR(50),
    Sales INT
);

INSERT INTO input_table_1 (Market, Sales) VALUES
('India', 100),
('Maharashtra', 20),
('Telangana', 18),
('Karnataka', 22),
('Gujarat', 25),
('Delhi', 12),
('Nagpur', 8),
('Mumbai', 10),
('Agra', 5),
('Hyderabad', 9),
('Bengaluru', 12),
('Hubli', 12),
('Bhopal', 5);

CREATE TABLE input_table_2 (
    Country VARCHAR(50),
    State VARCHAR(50),
    City VARCHAR(50)
);

INSERT INTO input_table_2 (Country, State, City) VALUES
('India', 'Maharashtra', 'Nagpur'),
('India', 'Maharashtra', 'Mumbai'),
('India', 'Maharashtra', 'Akola'),
('India', 'Telangana', 'Hyderabad'),
('India', 'Karnataka', 'Bengaluru'),
('India', 'Karnataka', 'Hubli'),
('India', 'Gujarat', 'Ahmedabad'),
('India', 'Gujarat', 'Vadodara'),
('India', 'UP', 'Agra'),
('India', 'UP', 'Mirzapur'),
('India', 'Delhi', NULL), 
('India', 'Orissa', NULL); 


select * from input_table_1;
select * from input_table_2;


with city_sales as(
select t2.country, t2.state, t2.city, t1.sales
from input_table_2 t2 inner join input_table_1 t1 on t2.city = t1.Market)
, city_level_state_sales as(
select state, sum(sales) sales
from city_sales
group by state)
, state_sales as(
select distinct t2.country, t2.state, ifnull(t1.sales,0) sales
from input_table_2 t2 left join input_table_1 t1 on t2.state = t1.market),
state_extra_sales as(
select ss.country, ss.state, (ss.sales - ifnull(css.sales,0)) sales
from state_sales ss left join city_level_state_sales css on ss.state = css.state
where ss.sales != ifnull(css.sales,0))
, city_and_sales_state as(
select * from city_sales
union all
select country, state, null as city, sales
from state_extra_sales
)
select * from city_and_sales_state
union all
(select a.country, null as state, null as city, a.sales - b.sales as sales
from(
select distinct t2.country, t1.sales
from input_table_2 t2 inner join input_table_1 t1 on t2.country = t1.Market) a
inner join (select country, sum(sales) sales from city_and_sales_state group by country) b
on a.country = b.country)


