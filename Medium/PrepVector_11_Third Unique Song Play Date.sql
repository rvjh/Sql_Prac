CREATE TABLE users7 (
id INTEGER PRIMARY KEY,
username VARCHAR(50)
);

INSERT INTO users7 (id, username) VALUES
(1, 'john_doe'),
(2, 'jane_smith'),
(3, 'bob_wilson');

CREATE TABLE song_plays7 (
id INTEGER PRIMARY KEY,
played_at DATETIME,
user_id INTEGER,
song_id INTEGER
);

INSERT INTO song_plays7 (id, played_at, user_id, song_id) VALUES
(1, '2024-01-01 10:00:00', 1, 101),
(2, '2024-01-01 14:00:00', 1, 101),
(3, '2024-01-02 09:00:00', 1, 102),
(4, '2024-01-03 16:00:00', 1, 103),
(5, '2024-01-04 11:00:00', 1, 104),
(6, '2024-01-01 09:00:00', 2, 201),
(7, '2024-01-01 15:00:00', 2, 202),
(8, '2024-01-02 10:00:00', 2, 203),
(9, '2024-01-02 14:00:00', 2, 203),
(10, '2024-01-01 12:00:00', 3, 301),
(11, '2024-01-02 13:00:00', 3, 302);

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

select * from users7;
select * from song_plays7;

-- Given a table of song_plays and a table of users, write a query to extract the 
-- earliest date each user played their third unique song and order by date played.

WITH song_rank AS (
    SELECT 
        user_id, 
        played_at, 
        song_id, 
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY played_at) AS rn,
        DENSE_RANK() OVER (PARTITION BY user_id ORDER BY song_id) AS song_rank
    FROM song_plays7
    GROUP BY user_id, played_at, song_id
),
rank_3 AS (
    SELECT user_id, played_at, song_id
    FROM song_rank
    WHERE song_rank = 3
)
SELECT users7.username, rank_3.song_id, rank_3.played_at
FROM users7 
INNER JOIN rank_3 ON users7.id = rank_3.user_id
ORDER BY rank_3.played_at;




