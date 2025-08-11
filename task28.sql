create database Course_Progress;
use Course_Progress;



CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE lessons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);


CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE progress (
    student_id INT NOT NULL,
    lesson_id INT NOT NULL,
    completed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (student_id, lesson_id),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE
);



INSERT INTO courses (name) VALUES ('Python Basics'), ('Web Development');

INSERT INTO lessons (course_id, title) VALUES
(1, 'Intro to Python'),
(1, 'Variables and Data Types'),
(1, 'Control Flow'),
(2, 'HTML Basics'),
(2, 'CSS Styling');


INSERT INTO students (name) VALUES ('Alice'), ('Bob');


INSERT INTO progress (student_id, lesson_id) VALUES
(1, 1),
(1, 2),
(2, 1), 
(2, 4);



SELECT
    s.name AS student,
    c.name AS course,
    COUNT(DISTINCT p.lesson_id) AS lessons_completed,
    COUNT(DISTINCT l.id) AS total_lessons,
    ROUND(
        COUNT(DISTINCT p.lesson_id) / COUNT(DISTINCT l.id) * 100, 2
    ) AS completion_percentage
FROM students s
CROSS JOIN courses c
JOIN lessons l ON l.course_id = c.id
LEFT JOIN progress p ON p.lesson_id = l.id AND p.student_id = s.id
GROUP BY s.id, c.id;



SELECT
    c.name AS course,
    l.title AS lesson,
    p.completed_at
FROM progress p
JOIN lessons l ON p.lesson_id = l.id
JOIN courses c ON l.course_id = c.id
WHERE p.student_id = 1 
ORDER BY p.completed_at;


SELECT 
    s.name AS student,
    COUNT(DISTINCT p.lesson_id) AS completed,
    COUNT(DISTINCT l.id) AS total,
    ROUND(COUNT(DISTINCT p.lesson_id) / COUNT(DISTINCT l.id) * 100, 2) AS completion_percent
FROM students s
JOIN lessons l ON l.course_id = 1
LEFT JOIN progress p ON p.lesson_id = l.id AND p.student_id = s.id
GROUP BY s.id;


