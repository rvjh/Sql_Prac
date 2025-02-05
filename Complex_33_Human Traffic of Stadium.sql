select * from stadium;

-- records which have 3 or more consecutive rows
-- with amount of people more than 100(inclusive) each day

select *,
row_number() over(order by visit_date) rn
from stadium
where no_of_people>=100
;

with cte as(
select *,
row_number() over(order by visit_date) rn
from stadium
where no_of_people>=100
)
select * from cte where id-rn=2

