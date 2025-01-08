CREATE TABLE amz_users (
    user_id INT,
    name VARCHAR(20),
    join_date DATE
);

INSERT INTO amz_users (user_id, name, join_date) VALUES
(1, 'Jon', STR_TO_DATE('2-14-20', '%m-%d-%y')), 
(2, 'Jane', STR_TO_DATE('2-14-20', '%m-%d-%y')), 
(3, 'Jill', STR_TO_DATE('2-15-20', '%m-%d-%y')), 
(4, 'Josh', STR_TO_DATE('2-15-20', '%m-%d-%y')), 
(5, 'Jean', STR_TO_DATE('2-16-20', '%m-%d-%y')), 
(6, 'Justin', STR_TO_DATE('2-17-20', '%m-%d-%y')),
(7, 'Jeremy', STR_TO_DATE('2-18-20', '%m-%d-%y'));

CREATE TABLE amz_events (
    user_id INT,
    type VARCHAR(10),
    access_date DATE
);

INSERT INTO amz_events (user_id, type, access_date) VALUES
(1, 'Pay', STR_TO_DATE('3-1-20', '%m-%d-%y')), 
(2, 'Music', STR_TO_DATE('3-2-20', '%m-%d-%y')), 
(2, 'P', STR_TO_DATE('3-12-20', '%m-%d-%y')),
(3, 'Music', STR_TO_DATE('3-15-20', '%m-%d-%y')), 
(4, 'Music', STR_TO_DATE('3-15-20', '%m-%d-%y')), 
(1, 'P', STR_TO_DATE('3-16-20', '%m-%d-%y')), 
(3, 'P', STR_TO_DATE('3-22-20', '%m-%d-%y'));

select * from amz_users;
select * from amz_events;

-- fraction of users who whave amazon music but upgradrd to within 30 days of signing

select * from amz_users
where user_id in(select user_id from amz_events where type='Music');

SELECT -- amz_users.*, amz_events.type, amz_events.access_date, 
    -- DATEDIFF(amz_events.access_date, amz_users.join_date) AS days_difference
count(1) no_if_users, 
count(distinct case when DATEDIFF(amz_events.access_date, amz_users.join_date)<=30 then amz_users.user_id end)
FROM amz_users 
LEFT JOIN amz_events 
ON amz_users.user_id = amz_events.user_id AND amz_events.type = 'P'
WHERE amz_users.user_id IN (SELECT user_id FROM amz_events WHERE type = 'Music');

SELECT count(distinct case when DATEDIFF(amz_events.access_date, amz_users.join_date)<=30 then amz_users.user_id end)/count(1) fraction 
FROM amz_users 
LEFT JOIN amz_events 
ON amz_users.user_id = amz_events.user_id AND amz_events.type = 'P'
WHERE amz_users.user_id IN (SELECT user_id FROM amz_events WHERE type = 'Music')




