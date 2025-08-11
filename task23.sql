create database Messaging_System;
use Messaging_System;



CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE conversations (
    id INT AUTO_INCREMENT PRIMARY KEY
);


CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    conversation_id INT NOT NULL,
    sender_id INT NOT NULL,
    message_text TEXT NOT NULL,
    sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES users(id)
);


CREATE TABLE conversation_users (
    conversation_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (conversation_id, user_id),
    FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);



INSERT INTO users (name) VALUES ('Alice'), ('Bob'), ('Charlie');


INSERT INTO conversations () VALUES (); 
INSERT INTO conversation_users (conversation_id, user_id) VALUES (1, 1), (1, 2);


INSERT INTO messages (conversation_id, sender_id, message_text) VALUES
(1, 1, 'Hey Bob!'),
(1, 2, 'Hi Alice! How are you?'),
(1, 1, 'Doing great, thanks!');



SELECT 
    m.id AS message_id,
    u.name AS sender,
    m.message_text,
    m.sent_at
FROM messages m
JOIN users u ON m.sender_id = u.id
WHERE m.conversation_id = 1
ORDER BY m.sent_at ASC;



SELECT 
    c.id AS conversation_id,
    GROUP_CONCAT(u.name SEPARATOR ', ') AS participants,
    m.message_text AS last_message,
    m.sent_at
FROM conversations c
JOIN conversation_users cu ON c.id = cu.conversation_id
JOIN users u ON cu.user_id = u.id
JOIN (
    SELECT m1.*
    FROM messages m1
    INNER JOIN (
        SELECT conversation_id, MAX(sent_at) AS max_sent
        FROM messages
        GROUP BY conversation_id
    ) m2 ON m1.conversation_id = m2.conversation_id AND m1.sent_at = m2.max_sent
) m ON c.id = m.conversation_id
GROUP BY c.id, m.message_text, m.sent_at
ORDER BY m.sent_at DESC;



SELECT DISTINCT c.id AS conversation_id
FROM conversation_users cu
JOIN conversations c ON c.id = cu.conversation_id
WHERE cu.user_id = 1;



