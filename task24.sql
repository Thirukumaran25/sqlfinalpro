create database Attendance_Tracker;
use Attendance_Tracker;



CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);



CREATE TABLE attendance (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late', 'Excused') NOT NULL,
    PRIMARY KEY (student_id, course_id, date),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);



INSERT INTO students (name) VALUES ('Alice'), ('Bob'), ('Charlie');

INSERT INTO courses (name) VALUES ('Math'), ('Science');

INSERT INTO attendance (student_id, course_id, date, status) VALUES
(1, 1, '2025-08-10', 'Present'),
(2, 1, '2025-08-10', 'Absent'),
(3, 1, '2025-08-10', 'Late'),
(1, 2, '2025-08-10', 'Present'),
(2, 2, '2025-08-10', 'Excused');




SELECT 
    s.name AS student,
    c.name AS course,
    a.status
FROM attendance a
JOIN students s ON a.student_id = s.id
JOIN courses c ON a.course_id = c.id
WHERE a.date = '2025-08-10'
ORDER BY c.name, s.name;



SELECT 
    s.name AS student,
    c.name AS course,
    SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS days_present,
    SUM(CASE WHEN a.status = 'Absent' THEN 1 ELSE 0 END) AS days_absent,
    SUM(CASE WHEN a.status = 'Late' THEN 1 ELSE 0 END) AS days_late,
    SUM(CASE WHEN a.status = 'Excused' THEN 1 ELSE 0 END) AS days_excused,
    COUNT(*) AS total_days
FROM attendance a
JOIN students s ON a.student_id = s.id
JOIN courses c ON a.course_id = c.id
GROUP BY a.student_id, a.course_id
ORDER BY s.name, c.name;




SELECT 
    a.date,
    c.name AS course,
    a.status
FROM attendance a
JOIN courses c ON a.course_id = c.id
WHERE a.student_id = 1
ORDER BY a.date;



