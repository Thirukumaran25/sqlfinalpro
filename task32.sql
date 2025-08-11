create database Online_Forum;
use Online_Forum;



CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE threads (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);


CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    thread_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    parent_post_id INT DEFAULT NULL, 
    posted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (thread_id) REFERENCES threads(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_post_id) REFERENCES posts(id) ON DELETE CASCADE
);



INSERT INTO users (name) VALUES ('Alice'), ('Bob'), ('Charlie');


INSERT INTO threads (title, user_id) VALUES 
('How to learn SQL?', 1),
('Best programming language in 2025?', 2);


INSERT INTO posts (thread_id, user_id, content, parent_post_id) VALUES
(1, 1, 'Start with SELECT queries and JOINs.', NULL),
(1, 2, 'Also try hands-on practice.', 1), 
(1, 3, 'Check out W3Schools and LeetCode.', 1), 
(2, 2, 'I think Python is still the best.', NULL),     
(2, 3, 'Rust is gaining popularity too.', 4);               



SELECT 
    p.id AS post_id,
    u.name AS author,
    p.content,
    p.parent_post_id,
    p.posted_at
FROM posts p
JOIN users u ON p.user_id = u.id
WHERE p.thread_id = 1
ORDER BY p.posted_at;


SELECT 
    child.id AS reply_id,
    child.content AS reply_content,
    parent.id AS parent_id,
    parent.content AS parent_content
FROM posts child
JOIN posts parent ON child.parent_post_id = parent.id
WHERE child.thread_id = 1;


SELECT 
    t.title,
    COUNT(p.id) AS post_count
FROM threads t
LEFT JOIN posts p ON t.id = p.thread_id
GROUP BY t.id;



SELECT 
    t.id AS thread_id,
    t.title,
    u.name AS created_by,
    t.created_at
FROM threads t
JOIN users u ON t.user_id = u.id
ORDER BY t.created_at DESC;





