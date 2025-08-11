create database Movie_Database;
use Movie_Database;


CREATE TABLE genres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT,
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE SET NULL
);


CREATE TABLE ratings (
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    score DECIMAL(2,1) CHECK (score >= 0 AND score <= 10),
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);




INSERT INTO genres (name) VALUES ('Action'), ('Drama'), ('Comedy');


INSERT INTO movies (title, release_year, genre_id) VALUES
('Inception', 2010, 1),
('The Godfather', 1972, 2), 
('Superbad', 2007, 3);


INSERT INTO ratings VALUES
(1, 1, 9.0),  
(2, 1, 8.5),  
(1, 2, 9.5), 
(3, 3, 7.0); 





SELECT 
    m.title,
    ROUND(AVG(r.score), 2) AS avg_rating,
    COUNT(r.user_id) AS total_ratings
FROM movies m
LEFT JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id, m.title;



SELECT 
    m.title,
    g.name AS genre,
    m.release_year,
    ROUND(AVG(r.score), 2) AS avg_rating
FROM movies m
JOIN genres g ON m.genre_id = g.id
LEFT JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id, g.name, m.release_year;



SELECT 
    m.title,
    ROUND(AVG(r.score), 2) AS avg_rating,
    COUNT(*) AS rating_count
FROM movies m
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id
HAVING COUNT(*) >= 2
ORDER BY avg_rating DESC;



SELECT 
    r.user_id,
    r.score,
    m.title
FROM ratings r
JOIN movies m ON r.movie_id = m.id
WHERE m.title = 'Inception';


