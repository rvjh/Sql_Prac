select * from tickets_1;


select origin, destination, sum(ticket_count) tc
from tickets_1
group by origin, destination
order by tc desc;


select 1,origin, destination, oneway_round, ticket_count
from tickets_1
union all
select 2, destination, origin, oneway_round, ticket_count
from tickets_1
where oneway_round='R';


with cte as(
select origin, destination, ticket_count
from tickets_1
union all
select destination, origin, ticket_count
from tickets_1
where oneway_round='R')
select origin, destination, sum(ticket_count) tc
from cte
group by origin, destination
order by tc desc;
