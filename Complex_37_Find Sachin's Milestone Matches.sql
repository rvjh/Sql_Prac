CREATE TABLE sachine_score (
    Match_No INT,
    Innings INT,
    match_date DATE,
    Versus VARCHAR(50),
    Ground VARCHAR(100),
    How_Dismissed VARCHAR(100),
    Runs INT,
    Balls_faced INT,
    strike_rate DECIMAL(5,2)
);

INSERT INTO sachine_score (Match_No, Innings, match_date, Versus, Ground, How_Dismissed, Runs, Balls_faced, strike_rate) VALUES
(1, 1, '1989-12-18', 'Pakistan', 'Jinnah Stadium (Gujwranwala)', 'c Wasim Akram b Waqar Younis', 0, 2, 0),
(2, 2, '1990-03-01', 'New Zealand', 'Carisbrook', 'c & b S A Thomson', 0, 2, 0),
(3, 3, '1990-03-06', 'New Zealand', 'Basin Reserve', 'c †I D S Smith b S A Thomson', 36, 39, 92.31),
(4, 4, '1990-04-25', 'Sri Lanka', 'Sharjah Cricket Stadium', 'run out', 10, 12, 83.33),
(5, 5, '1990-04-27', 'Pakistan', 'Sharjah Cricket Stadium', 'c Saeed Anwar b Imran Khan', 20, 25, 80),
(6, 6, '1990-07-18', 'England', 'Headingley', 'b D E Malcolm', 19, 35, 54.29),
(7, 7, '1990-07-20', 'England', 'Trent Bridge', 'b A R C Fraser', 31, 26, 119.23),
(8, 8, '1990-12-01', 'Sri Lanka', 'Vidarbha Cricket Association Ground', 'b R J Ratnayake', 36, 22, 163.64),
(9, 9, '1990-12-05', 'Sri Lanka', 'Nehru Stadium (Pune)', 'b G F Labrooy', 53, 41, 129.27),
(10, 10, '1990-12-08', 'Sri Lanka', 'Nehru Stadium (Margao)', 'c & b S D Anurasiri', 30, 29, 103.45),
(11, NULL, '1990-12-25', 'Bangladesh', 'Sector 16 Stadium', 'did not bat', NULL, NULL, NULL),
(12, 11, '1990-12-28', 'Sri Lanka', 'Barabati Stadium', 'lbw b A Ranatunga', 4, 11, 36.36),
(13, 12, '1991-01-04', 'Sri Lanka', 'Eden Gardens', 'lbw b R J Ratnayake', 53, 70, 75.71),
(14, 13, '1991-10-18', 'Pakistan', 'Sharjah Cricket Stadium', 'not out', 52, 40, 130),
(15, 14, '1991-10-19', 'West Indies', 'Sharjah Cricket Stadium', 'run out', 22, 27, 81.48),
(16, 15, '1991-10-22', 'West Indies', 'Sharjah Cricket Stadium', 'not out', 11, 27, 40.74),
(17, 16, '1991-10-23', 'Pakistan', 'Sharjah Cricket Stadium', 'c sub b Saleem Malik', 49, 38, 128.95),
(18, 17, '1991-10-25', 'Pakistan', 'Sharjah Cricket Stadium', 'lbw b Aaqib Javed', 0, 1, 0),
(19, 18, '1991-11-10', 'South Africa', 'Eden Gardens', 'c R P Snell b A A Donald', 62, 73, 84.93),
(20, 19, '1991-11-12', 'South Africa', 'Captain Roop Singh Stadium', 'c †D J Richardson b C R Matthews', 4, 8, 50),
(21, 20, '1991-11-14', 'South Africa', 'Jawaharlal Nehru Stadium (Delhi)', 'c S J Cook b A A Donald', 1, 3, 33.33),
(22, 21, '1991-12-06', 'West Indies', 'WACA Ground', 'c R B Richardson b A C Cummins', 1, 9, 11.11),
(23, 22, '1991-12-08', 'Australia', 'WACA Ground', 'c P L Taylor b T M Moody', 36, 65, 55.38),
(24, 23, '1991-12-10', 'Australia', 'Bellerive Oval', 'c S R Waugh b P L Taylor', 57, 107, 53.27),
(25, 24, '1991-12-14', 'West Indies', 'Adelaide Oval', 'c & b K L T Arthurton', 48, 57, 84.21),
(26, 25, '1991-12-15', 'Australia', 'Adelaide Oval', 'c D M Jones b S R Waugh', 21, 35, 60),
(27, 26, '1992-01-11', 'West Indies', 'Brisbane Cricket Ground', 'c sub b A C Cummins', 77, 127, 60.63),
(28, 27, '1992-01-14', 'Australia', 'Sydney Cricket Ground', 'run out', 31, 44, 70.45),
(29, 28, '1992-01-16', 'West Indies', 'Melbourne Cricket Ground', 'not out', 57, 88, 64.77),
(30, 29, '1992-01-18', 'Australia', 'Melbourne Cricket Ground', 'c M R Whitney b T M Moody', 4, 10, 40),
(31, 30, '1992-01-20', 'Australia', 'Sydney Cricket Ground', 'c M R Whitney b S R Waugh', 69, 100, 69),
(32, 31, '1992-02-22', 'England', 'WACA Ground', 'c †A J Stewart b I T Botham', 35, 44, 79.55),
(33, NULL, '1992-02-28', 'Sri Lanka', 'Harrup Park', 'did not bat', 35, 44, 78.3);


select * from sachine_score;

-- find sachins milestone matches/ innings

select Match_no, Innings, Runs,
sum(Runs) over(order by Match_No rows between unbounded preceding and current row) r_sum
from sachine_score;


with cte1 as(
select Match_no, Innings, Runs,
sum(Runs) over(order by Match_No rows between unbounded preceding and current row) r_sum
from sachine_score
), cte2 as(
select 1 as milestone_number, 100 as milestone_runs
union all
select 2 as milestone_number, 500 as milestone_runs
union all
select 3 as milestone_number, 900 as milestone_runs
)
select milestone_number, milestone_runs, min(Match_No) Milestone_Match,
min(Innings) Milestone_Innings
from cte2 inner join cte1 
on r_sum>milestone_runs
group by milestone_number, milestone_runs


