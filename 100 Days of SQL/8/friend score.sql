select * from person;
select * from friend;

-- personid, name, no_of_frnd, sum of marks of a person who have friend who have total score
-- > 100

with cte as(
select f.PersonID, sum(p.Score) total_friend_score, count(1) no_of_frnds 
from friend f inner join person p on f.FriendID = p.PersonID
group by f.PersonID
having sum(p.Score) > 100
)
select p.PersonID, p.Name, cte.no_of_frnds, cte.total_friend_score
from person p inner join cte on p.PersonID = cte.PersonID;

