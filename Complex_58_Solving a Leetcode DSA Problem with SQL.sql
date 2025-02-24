CREATE TABLE travel_data (
    customer VARCHAR(10),
    start_loc VARCHAR(50),
    end_loc VARCHAR(50)
);

INSERT INTO travel_data (customer, start_loc, end_loc) VALUES
    ('c1', 'New York', 'Lima'),
    ('c1', 'London', 'New York'),
    ('c1', 'Lima', 'Sao Paulo'),
    ('c1', 'Sao Paulo', 'New Delhi'),
    ('c2', 'Mumbai', 'Hyderabad'),
    ('c2', 'Surat', 'Pune'),
    ('c2', 'Hyderabad', 'Surat'),
    ('c3', 'Kochi', 'Kurnool'),
    ('c3', 'Lucknow', 'Agra'),
    ('c3', 'Agra', 'Jaipur'),
    ('c3', 'Jaipur', 'Kochi');
    
select * from travel_data;

-- cust initial_loc last_loc
-- which is actual first which is actual last

with cte as(
select *,
case when start_loc not in (select end_loc from travel_data) then start_loc end S,
case when end_loc not in (select start_loc from travel_data) then end_loc end E
from travel_data)
select customer, max(S) start_loc, min(E) end_loc
from cte group by customer;




