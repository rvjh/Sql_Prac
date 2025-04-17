create table strings (name varchar(50));
insert into strings values ('Ankit Bansal'),('Ram Kumar Verma'),('Akshay Kumar Ak k'),('Rahul');


select * from strings;

SELECT name, REPLACE(name, ' ', '') AS rep_name,
(length(name) - length(REPLACE(name, ' ', ''))) no_of_space
FROM strings;

SELECT name, 
       (LENGTH(name) - LENGTH(REPLACE(name, 'aK', ''))) / LENGTH('ak') AS count_Ak
FROM strings;