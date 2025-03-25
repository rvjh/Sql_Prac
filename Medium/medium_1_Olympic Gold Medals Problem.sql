use test1;

select * from events;

-- no of gold medals for swimmers who won only gold medals

select gold as player_name, count(*) from events
where gold not in(
select silver as player from events
union
select bronze as player from events)
group by gold

-- ----------------------------- 