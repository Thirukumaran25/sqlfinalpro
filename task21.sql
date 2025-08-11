create database Blog_Management;
use Blog_Management;



CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    published_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);



CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    commented_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);




INSERT INTO users (name) VALUES ('Alice'), ('Bob'), ('Charlie');

INSERT INTO posts (user_id, title, content, published_date) VALUES
(1, 'My First Blog Post', 'This is the content of the first blog.', '2025-08-01'),
(2, 'Bob’s Tech Tips', 'Useful tips on technology.', '2025-08-02');


INSERT INTO comments (post_id, user_id, comment_text) VALUES
(1, 2, 'Great post! Thanks for sharing.'),
(1, 3, 'Really helpful, I enjoyed reading.'),
(2, 1, 'Nice tips Bob!');




SELECT 
    c.id AS comment_id,
    c.comment_text,
    c.commented_at,
    p.title AS post_title,
    u.name AS commenter_name
FROM comments c
JOIN posts p ON c.post_id = p.id
JOIN users u ON c.user_id = u.id
ORDER BY c.commented_at DESC;




SELECT 
    p.id AS post_id,
    p.title,
    u.name AS author,
    p.published_date,
    COUNT(c.id) AS comment_count
FROM posts p
JOIN users u ON p.user_id = u.id
LEFT JOIN comments c ON p.id = c.post_id
GROUP BY p.id, p.title, u.name, p.published_date
ORDER BY p.published_date DESC;




SELECT 
    p.id,
    p.title,
    p.published_date
FROM posts p
JOIN users u ON p.user_id = u.id
WHERE u.name = 'Alice';




SELECT 
    p.id,
    p.title,
    u.name AS author,
    p.published_date
FROM posts p
JOIN users u ON p.user_id = u.id
WHERE p.published_date BETWEEN '2025-08-01' AND '2025-08-31';




