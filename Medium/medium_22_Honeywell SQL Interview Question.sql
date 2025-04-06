select * from movies;
select * from reviews;


with cte as(
select movies.genre, movies.title, avg(reviews.rating) average_rating ,
row_number() over(partition by movies.genre order by avg(reviews.rating) desc) rn
from movies join reviews on movies.id = reviews.movie_id
group by movies.genre, movies.title
order by movies.genre, average_rating desc)
select genre, title, ceil(average_rating), repeat('*',ceil(average_rating))  
from cte where rn=1;