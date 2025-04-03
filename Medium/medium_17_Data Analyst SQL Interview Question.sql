select * from people;
select * from relations;

-- child, father, mother


with father as(
select relations.c_id, people.name father_name
from people inner join relations on people.id = relations.p_id
where people.gender = 'M')
,mother as(
select relations.c_id, people.name mother_name
from people inner join relations on people.id = relations.p_id
where people.gender = 'F')
, cte as(
select father.c_id, father.father_name, mother.mother_name from
father inner join mother on father.c_id = mother.c_id)
select people.name child, cte.father_name, cte.mother_name
from cte join people on cte.c_id = people.id;


