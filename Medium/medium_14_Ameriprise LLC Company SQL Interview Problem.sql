select * from ameriprise_llc;


with cte as(
select teamID, count(1) no_of_mem
from ameriprise_llc
where Criteria1='Y' and Criteria2='Y'
group by teamID
having count(1)>=2)
select l.*, cte.*,
case when Criteria1='Y' and Criteria2='Y' and cte.no_of_mem is not null then 'Y' else 'N' end as Q1
from ameriprise_llc l left join cte on l.teamID = cte.teamID