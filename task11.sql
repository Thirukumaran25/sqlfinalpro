create database course_enroll;
use course_enroll;



CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    instructor VARCHAR(100) NOT NULL
);


CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE enrollments (
    course_id INT,
    student_id INT,
    enroll_date DATE,
    PRIMARY KEY (course_id, student_id),
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);




INSERT INTO courses (title, instructor) VALUES
('Database Systems', 'Dr. Smith'),
('Data Structures', 'Prof. Johnson'),
('Web Development', 'Ms. Lee');


INSERT INTO students (name, email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Brown', 'bob@example.com'),
('Charlie Smith', 'charlie@example.com');


INSERT INTO enrollments (course_id, student_id, enroll_date) VALUES
(1, 1, '2025-08-01'),
(1, 2, '2025-08-02'),
(2, 1, '2025-08-03'),
(3, 3, '2025-08-04');



SELECT s.id, s.name, s.email
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON c.id = e.course_id
WHERE c.title = 'Database Systems';


SELECT c.title, COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.title;



SELECT s.name AS student_name, c.title AS course_title, e.enroll_date
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON c.id = e.course_id
WHERE s.name = 'Alice Johnson';




