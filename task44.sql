create database Course_Feedback;
use Course_Feedback;



CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);


CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);




INSERT INTO courses (title) VALUES
('Introduction to SQL'),
('Web Development Basics');


INSERT INTO feedback (course_id, user_id, rating, comments) VALUES
(1, 101, 5, 'Excellent course! Very helpful.'),
(1, 102, 4, 'Good explanations, but a bit fast.'),
(2, 103, 3, 'Okay content, but needs more examples.');



SELECT
    c.title,
    ROUND(AVG(f.rating), 2) AS avg_rating,
    COUNT(f.id) AS feedback_count
FROM courses c
LEFT JOIN feedback f ON c.id = f.course_id
GROUP BY c.id;



SELECT
    c.title AS course,
    f.user_id,
    f.rating,
    f.comments
FROM feedback f
JOIN courses c ON f.course_id = c.id
ORDER BY c.title, f.rating DESC;



SELECT
    c.title,
    AVG(f.rating) AS avg_rating
FROM feedback f
JOIN courses c ON f.course_id = c.id
GROUP BY c.id
HAVING AVG(f.rating) < 4;




