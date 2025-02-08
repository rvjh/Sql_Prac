select * from phonelog;

with cte as(
select Callerid, date(Datecalled) CallDate, 
min(Datecalled) first_call, max(Datecalled) last_call from phonelog
group by Callerid, date(Datecalled)
)
select cte.*,p1.Recipientid, p2.Recipientid from cte
inner join phonelog p1 on cte.Callerid = p1.Callerid and cte.first_call = p1.Datecalled
inner join phonelog p2 on cte.Callerid = p2.Callerid and cte.last_call = p2.Datecalled
where p1.Recipientid = p2.Recipientid