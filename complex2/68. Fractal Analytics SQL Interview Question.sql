select * from king;
select * from battle;


-- 

with wins as(
select attacker_king king_n, region 
from battle
where attacker_outcome=1
union all
select defender_king king_n, region 
from battle
where attacker_outcome=0)
select * from(
select w.region, k.house, count(1) no_of_wins,
rank() over(partition by w.region order by count(1) desc) rn
from wins w
inner join king k on w.king_n = k.k_no
group by w.region, k.house) A where rn=1 ; 


-- 

select * 
from battle b
inner join king k 
on k.k_no = case when attacker_outcome=1 then attacker_king else defender_king end;

select * from(
select b.region, k.house, count(1) no_of_wins,
rank() over(partition by b.region order by count(1) desc) rn
from battle b
inner join king k 
on k.k_no = case when attacker_outcome=1 then attacker_king else defender_king end
group by b.region, k.house) A where rn=1 ;





