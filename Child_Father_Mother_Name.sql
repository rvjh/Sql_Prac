use test1;
create table people
(id int primary key not null,
 name varchar(20),
 gender char(2));

create table relations
(
    c_id int,
    p_id int,
    FOREIGN KEY (c_id) REFERENCES people(id),
    foreign key (p_id) references people(id)
);

insert into people (id, name, gender)
values
    (107,'Days','F'),
    (145,'Hawbaker','M'),
    (155,'Hansel','F'),
    (202,'Blackston','M'),
    (227,'Criss','F'),
    (278,'Keffer','M'),
    (305,'Canty','M'),
    (329,'Mozingo','M'),
    (425,'Nolf','M'),
    (534,'Waugh','M'),
    (586,'Tong','M'),
    (618,'Dimartino','M'),
    (747,'Beane','M'),
    (878,'Chatmon','F'),
    (904,'Hansard','F');

insert into relations(c_id, p_id)
values
    (145, 202),
    (145, 107),
    (278,305),
    (278,155),
    (329, 425),
    (329,227),
    (534,586),
    (534,878),
    (618,747),
    (618,904);
    
select * from people;
select * from relations;

-- name of child with fathers name, mothers name order by child

with m as(
	select 
		relations.c_id, 
        people.name as mother_name
	from people inner join relations
	on people.id = relations.p_id and people.gender = 'F'
),
f as(
	select 
		relations.c_id, 
        people.name as fathers_name
	from people inner join relations
	on people.id = relations.p_id and people.gender = 'M'
)
select f.c_id,people.name, f.fathers_name, m.mother_name
from f inner join m on f.c_id = m.c_id
inner join people on people.id = f.c_id



