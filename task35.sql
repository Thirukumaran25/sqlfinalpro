create database Survey_Collection;
use Survey_Collection;



CREATE TABLE surveys (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);


CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    survey_id INT NOT NULL,
    question_text TEXT NOT NULL,
    FOREIGN KEY (survey_id) REFERENCES surveys(id) ON DELETE CASCADE
);


CREATE TABLE responses (
    user_id INT NOT NULL,
    question_id INT NOT NULL,
    answer_text VARCHAR(255) NOT NULL,
    PRIMARY KEY (user_id, question_id),
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);




INSERT INTO surveys (title) VALUES ('Product Feedback Survey');


INSERT INTO questions (survey_id, question_text) VALUES
(1, 'How satisfied are you with our product?'),
(1, 'Would you recommend us to others?');


INSERT INTO responses (user_id, question_id, answer_text) VALUES
(1, 1, 'Very Satisfied'),
(1, 2, 'Yes'),
(2, 1, 'Satisfied'),
(2, 2, 'Yes'),
(3, 1, 'Neutral'),
(3, 2, 'No');



SELECT 
    q.question_text,
    r.answer_text,
    COUNT(*) AS response_count
FROM responses r
JOIN questions q ON r.question_id = q.id
GROUP BY r.question_id, r.answer_text
ORDER BY q.id, response_count DESC;



SELECT
    r.user_id,
    MAX(CASE WHEN q.question_text = 'How satisfied are you with our product?' THEN r.answer_text END) AS satisfaction,
    MAX(CASE WHEN q.question_text = 'Would you recommend us to others?' THEN r.answer_text END) AS recommendation
FROM responses r
JOIN questions q ON r.question_id = q.id
GROUP BY r.user_id;



SELECT 
    s.title AS survey_title,
    q.question_text,
    r.user_id,
    r.answer_text
FROM responses r
JOIN questions q ON r.question_id = q.id
JOIN surveys s ON q.survey_id = s.id
WHERE s.id = 1
ORDER BY r.user_id, q.id;



SELECT 
    q.question_text,
    COUNT(r.user_id) AS total_responses
FROM questions q
LEFT JOIN responses r ON q.id = r.question_id
GROUP BY q.id;


