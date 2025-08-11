create database Voting_System;
use Voting_System;



CREATE TABLE polls (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question VARCHAR(255) NOT NULL
);


CREATE TABLE options (
    id INT AUTO_INCREMENT PRIMARY KEY,
    poll_id INT NOT NULL,
    option_text VARCHAR(255) NOT NULL,
    FOREIGN KEY (poll_id) REFERENCES polls(id) ON DELETE CASCADE
);



CREATE TABLE votes (
    user_id INT NOT NULL,
    option_id INT NOT NULL,
    voted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, option_id),
    FOREIGN KEY (option_id) REFERENCES options(id) ON DELETE CASCADE
);




INSERT INTO polls (question) VALUES 
('What is your favorite programming language?');


INSERT INTO options (poll_id, option_text) VALUES
(1, 'Python'),
(1, 'JavaScript'),
(1, 'Java'),
(1, 'C++');


INSERT INTO votes (user_id, option_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3);


SELECT 
    o.option_text,
    COUNT(v.user_id) AS vote_count
FROM options o
LEFT JOIN votes v ON o.id = v.option_id
WHERE o.poll_id = 1
GROUP BY o.id, o.option_text
ORDER BY vote_count DESC;



SELECT 1
FROM votes v
JOIN options o ON v.option_id = o.id
WHERE v.user_id = 1 AND o.poll_id = 1;



INSERT INTO votes (user_id, option_id)
SELECT 5, 2
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM votes v
    JOIN options o ON v.option_id = o.id
    WHERE v.user_id = 5 AND o.poll_id = 1
);




