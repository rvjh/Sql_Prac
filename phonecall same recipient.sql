create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');
       
select * from phonelog;

-- callers whose first and last call was to the same person on the given date

with cte as(
select callerid,
cast(Datecalled as date) Dt,
min(Datecalled) as first_call,
max(Datecalled) as last_call
from phonelog
group by callerid, cast(Datecalled as date)
)
select c.*, p1.recipientid as first_rec, p2.recipientid as last_rec from cte c
inner join phonelog p1 on c.callerid = p1.callerid and c.first_call = p1.Datecalled
inner join phonelog p2 on c.callerid = p2.callerid and c.last_call = p2.Datecalled
where p1.recipientid = p2.recipientid
