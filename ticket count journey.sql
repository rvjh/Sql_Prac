CREATE TABLE tickets_1 (
    airline_number VARCHAR(10),
    origin VARCHAR(3),
    destination VARCHAR(3),
    oneway_round CHAR(1),
    ticket_count INT
);


INSERT INTO tickets_1 (airline_number, origin, destination, oneway_round, ticket_count)
VALUES
    ('DEF456', 'BOM', 'DEL', 'O', 150),
    ('GHI789', 'DEL', 'BOM', 'R', 50),
    ('JKL012', 'BOM', 'DEL', 'R', 75),
    ('MNO345', 'DEL', 'NYC', 'O', 200),
    ('PQR678', 'NYC', 'DEL', 'O', 180),
    ('STU901', 'NYC', 'DEL', 'R', 60),
    ('ABC123', 'DEL', 'BOM', 'O', 100),
    ('VWX234', 'DEL', 'NYC', 'R', 90);
    
select * from tickets_1;

-- route with the highest tickets

select origin, destination, sum(ticket_count) as tc
from tickets_1
group by origin, destination
order by sum(ticket_count) desc

select 1, origin, destination, oneway_round, ticket_count
from tickets_1
union all
select 2, destination, origin, oneway_round, ticket_count
from tickets_1 where oneway_round='R'


select M.origin, M.destination, sum(M.ticket_count) as tc
from
(select origin, destination, ticket_count
from tickets_1
union all
select destination, origin, ticket_count
from tickets_1 where oneway_round='R') as M
group by M.origin, M.destination
order by sum(M.ticket_count) desc
