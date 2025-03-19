create table polls
(
user_id varchar(4),
poll_id varchar(3),
poll_option_id varchar(3),
amount int,
created_date date
);
-- Insert sample data into the investments table
INSERT INTO polls (user_id, poll_id, poll_option_id, amount, created_date) VALUES
('id1', 'p1', 'A', 200, '2021-12-01'),
('id2', 'p1', 'C', 250, '2021-12-01'),
('id3', 'p1', 'A', 200, '2021-12-01'),
('id4', 'p1', 'B', 500, '2021-12-01'),
('id5', 'p1', 'C', 50, '2021-12-01'),
('id6', 'p1', 'D', 500, '2021-12-01'),
('id7', 'p1', 'C', 200, '2021-12-01'),
('id8', 'p1', 'A', 100, '2021-12-01'),
('id9', 'p2', 'A', 300, '2023-01-10'),
('id10', 'p2', 'C', 400, '2023-01-11'),
('id11', 'p2', 'B', 250, '2023-01-12'),
('id12', 'p2', 'D', 600, '2023-01-13'),
('id13', 'p2', 'C', 150, '2023-01-14'),
('id14', 'p2', 'A', 100, '2023-01-15'),
('id15', 'p2', 'C', 200, '2023-01-16');

create table poll_answers
(
poll_id varchar(3),
correct_option_id varchar(3)
);

-- Insert sample data into the poll_answers table
INSERT INTO poll_answers (poll_id, correct_option_id) VALUES
('p1', 'C'),('p2', 'A');

select * from polls;
select * from poll_answers;


-- 

with cte1 as(
select p.poll_id, sum(amount) amount_to_be_distributed 
from polls p inner join poll_answers pa on p.poll_id = pa.poll_id
where p.poll_option_id != pa.correct_option_id
group by p.poll_id)
, cte2 as(
select p.poll_id,p.user_id, amount/sum(amount) over(partition by p.poll_id) proportion  
from polls p inner join poll_answers pa on p.poll_id = pa.poll_id
where p.poll_option_id = pa.correct_option_id)
select *, cte2.proportion * cte1.amount_to_be_distributed winning_amount
from cte2 inner join cte1 on cte1.poll_id = cte2.poll_id;


