CREATE TABLE PERSON (
    PersonID INT,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Score INT
);

INSERT INTO PERSON (PersonID, Name, Email, Score) VALUES
    (1, 'Alice', 'alice2018@hotmail.com', 88),
    (2, 'Bob', 'bob2018@hotmail.com', 11),
    (3, 'Davis', 'davis2018@hotmail.com', 27),
    (4, 'Tara', 'tara2018@hotmail.com', 45),
    (5, 'John', 'john2018@hotmail.com', 63);
    
CREATE TABLE Friend (
    PersonID INT,
    FriendID INT
);

INSERT INTO Friend (PersonID, FriendID) VALUES
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 3),
    (3, 5),
    (4, 2),
    (4, 3),
    (4, 5);

select * from person;
select * from friend;

-- find personid, name, friendid, sumofscore >100


with score_100 as(
select friend.PersonID, sum(person.Score) total_friend_score, count(1) no_of_friends from friend
inner join  person on person.PersonID=friend.FriendID
group by friend.PersonID
having sum(person.Score)>100)
select person.PersonID, person.Name, person.Email,score_100.no_of_friends,score_100.total_friend_score
from person join score_100 on person.PersonID = score_100.PersonID