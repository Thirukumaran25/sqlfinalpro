create database online_exam;
use online_exam;


CREATE TABLE exams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    date DATE NOT NULL
);


CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    exam_id INT NOT NULL,
    text TEXT NOT NULL,
    correct_option CHAR(1) NOT NULL,
    FOREIGN KEY (exam_id) REFERENCES exams(id) ON DELETE CASCADE
);


CREATE TABLE student_answers (
    student_id INT NOT NULL,
    question_id INT NOT NULL,
    selected_option CHAR(1) NOT NULL,
    PRIMARY KEY (student_id, question_id),
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);



INSERT INTO exams (course_id, date) VALUES
(101, '2025-08-01');


INSERT INTO questions (exam_id, text, correct_option) VALUES
(1, 'What is the capital of France?', 'B'),
(1, '2 + 2 = ?', 'A'),
(1, 'Which is a programming language?', 'C');


INSERT INTO student_answers (student_id, question_id, selected_option) VALUES
(1, 1, 'B'),  
(1, 2, 'A'),  
(1, 3, 'B');  



SELECT 
    e.id AS exam_id,
    q.id AS question_id,
    q.text AS question,
    q.correct_option,
    sa.selected_option
FROM exams e
JOIN questions q ON e.id = q.exam_id
LEFT JOIN student_answers sa ON q.id = sa.question_id AND sa.student_id = 1
WHERE e.id = 1;



SELECT 
    sa.student_id,
    e.id AS exam_id,
    COUNT(*) AS total_questions,
    SUM(CASE WHEN sa.selected_option = q.correct_option THEN 1 ELSE 0 END) AS correct_answers,
    ROUND(
        SUM(CASE WHEN sa.selected_option = q.correct_option THEN 1 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS percentage_score
FROM exams e
JOIN questions q ON e.id = q.exam_id
JOIN student_answers sa ON q.id = sa.question_id
WHERE e.id = 1 AND sa.student_id = 1
GROUP BY sa.student_id, e.id;



