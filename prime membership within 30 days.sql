CREATE TABLE users_2 (
    user_id INT NOT NULL PRIMARY KEY,  -- Set user_id as primary key
    name VARCHAR(20) NOT NULL,
    join_date DATE NOT NULL
);

INSERT INTO users_2 (user_id, name, join_date) VALUES 
(1, 'Jon', CAST('2020-02-14' AS DATE)), 
(2, 'Jane', CAST('2020-02-14' AS DATE)), 
(3, 'Jill', CAST('2020-02-15' AS DATE)), 
(4, 'Josh', CAST('2020-02-15' AS DATE)), 
(5, 'Jean', CAST('2020-02-16' AS DATE)), 
(6, 'Justin', CAST('2020-02-17' AS DATE)),
(7, 'Jeremy', CAST('2020-02-18' AS DATE));

CREATE TABLE events_2 (
    user_id INT NOT NULL,
    type VARCHAR(10) NOT NULL,
    access_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users_2(user_id)  -- Add foreign key constraint
);

INSERT INTO events_2 (user_id, type, access_date) VALUES
(1, 'Pay', CAST('2020-03-01' AS DATE)), 
(2, 'Music', CAST('2020-03-02' AS DATE)), 
(2, 'P', CAST('2020-03-12' AS DATE)),
(3, 'Music', CAST('2020-03-15' AS DATE)), 
(4, 'Music', CAST('2020-03-15' AS DATE)), 
(1, 'P', CAST('2020-03-16' AS DATE)), 
(3, 'P', CAST('2020-03-22' AS DATE));


select * from users_2;
select * from events_2;

-- fraction of users who has upgraded from amazon music to prime membership within 30 days of signup

-- prime membership

with cte as
(select users_2.user_id, 
	   datediff(events_2.access_date,users_2.join_date) datediff, 
       events_2.type,
       count(case when events_2.type='Music' then 1 end) count_music,
       count(case when events_2.type='P' then 1 end) count_P
from events_2
inner join users_2 on users_2.user_id = events_2.user_id
where events_2.type='Music' or events_2.type='P'
group by users_2.user_id, datediff, events_2.type
having datediff < 30
)
select round(sum(count_P)/sum(count_music),2) as fraction_of_member
from cte
