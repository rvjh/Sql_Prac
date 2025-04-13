CREATE TABLE Politician (
    pname VARCHAR(10) PRIMARY KEY,
    party CHAR(1)
);

CREATE TABLE Company (
    cname VARCHAR(10) PRIMARY KEY,
    revenue INT
);

CREATE TABLE Invested (
    pname VARCHAR(10),
    cname VARCHAR(10)
);

CREATE TABLE Subsidiary (
    parent VARCHAR(10),
    child VARCHAR(10)
);

-- Politicians
INSERT INTO Politician (pname, party) VALUES
('Don', 'R'),
('Ron', 'R'),
('Hil', 'D'),
('Bill', 'D');

-- Companies
INSERT INTO Company (cname, revenue) VALUES
('C1', 110),
('C2', 30),
('C3', 50),
('C4', 250),
('C5', 75),
('C6', 15);

-- Investments
INSERT INTO Invested (pname, cname) VALUES
('Don', 'C1'),
('Don', 'C4'),
('Ron', 'C1'),
('Hil', 'C3');

-- Subsidiary relationships
INSERT INTO Subsidiary (parent, child) VALUES
('C1', 'C2'),
('C2', 'C3'),
('C2', 'C5'),
('C4', 'C6'),
('C6', 'C8'),
('C5', 'C9');


select * from Politician;
select * from Company;



select * from Invested;
select * from Subsidiary;



with recursive cte as(
select parent, child  from Subsidiary
union all
select cte.parent, s.child
from cte 
inner join Subsidiary s on cte.child=s.parent 
) 
select * from cte
inner join invested p on cte.parent = p.cname
inner join invested c on cte.child = c.cname
order by 1
