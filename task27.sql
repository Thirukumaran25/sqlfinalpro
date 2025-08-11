create database Notification_System;
use Notification_System;


CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    status ENUM('unread', 'read') DEFAULT 'unread',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);




INSERT INTO users (name) VALUES ('Alice'), ('Bob');


INSERT INTO notifications (user_id, message) VALUES
(1, 'Welcome to the app!'),
(1, 'You have a new message.'),
(2, 'Your profile is 90% complete.'),
(1, 'Reminder: Check out new features.');



SELECT id, message, created_at
FROM notifications
WHERE user_id = 1 AND status = 'unread'
ORDER BY created_at DESC;



SELECT COUNT(*) AS unread_count
FROM notifications
WHERE user_id = 1 AND status = 'unread';



UPDATE notifications
SET status = 'read'
WHERE user_id = 1 AND status = 'unread';


SELECT message, status, created_at
FROM notifications
WHERE user_id = 1
ORDER BY created_at DESC;


