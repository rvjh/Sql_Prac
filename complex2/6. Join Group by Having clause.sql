select * from friend;
select * from person;

-- personid name no_of_friends total_frienscore


WITH cte AS (
    SELECT friend.PersonID, SUM(person.score) AS f_score
    FROM person 
    INNER JOIN friend ON person.PersonID = friend.FriendID
    GROUP BY friend.PersonID
    HAVING SUM(person.score) > 100
)
SELECT person.PersonID, person.name, COUNT(friend.FriendID) AS no_of_friends, cte.f_score
FROM person
LEFT JOIN friend ON person.PersonID = friend.PersonID
LEFT JOIN cte ON person.PersonID = cte.PersonID
where cte.f_score>100
GROUP BY person.PersonID, person.name, cte.f_score;

