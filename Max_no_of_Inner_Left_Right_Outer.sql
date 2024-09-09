use test1;

CREATE TABLE t1 (
    id INT
);

CREATE TABLE t2 (
    id INT
);

INSERT INTO t1 (id) VALUES (1), (1), (1), (1), (1);

INSERT INTO t2 (id) VALUES (1), (2), (2), (3),(1), (2), (3), (4), (5) ;

select * from t1
select * from t2

-- max no of inner, right, left, full outer

-- inner -> 10
select count(*) from
t1 join t2 on t1.id = t2.id

-- right -> 17
select count(*) from
t1 right join t2 on t1.id = t2.id

-- left 10
select count(*) from
t1 left join t2 on t1.id = t2.id

-- full outer - 45
select count(*) from
t1 full join t2


