create database QR_Code;
use QR_Code;



CREATE TABLE locations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE entry_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    location_id INT NOT NULL,
    entry_time DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(id) ON DELETE CASCADE
);



INSERT INTO locations (name) VALUES ('Main Entrance'), ('Back Door');

INSERT INTO users (name) VALUES ('John Doe'), ('Jane Smith');

INSERT INTO entry_logs (user_id, location_id, entry_time) VALUES
(1, 1, '2025-08-10 08:00:00'),
(2, 1, '2025-08-10 08:15:00'),
(1, 2, '2025-08-10 12:30:00');



SELECT
    l.name AS location,
    COUNT(*) AS total_entries
FROM entry_logs el
JOIN locations l ON el.location_id = l.id
GROUP BY el.location_id;



SELECT
    u.name AS user,
    l.name AS location,
    el.entry_time
FROM entry_logs el
JOIN users u ON el.user_id = u.id
JOIN locations l ON el.location_id = l.id
WHERE el.entry_time BETWEEN '2025-08-10 00:00:00' AND '2025-08-10 23:59:59'
ORDER BY el.entry_time;




SELECT
    u.name AS user,
    COUNT(*) AS entries_count
FROM entry_logs el
JOIN users u ON el.user_id = u.id
WHERE el.location_id = 1
AND el.entry_time >= '2025-08-01'
AND el.entry_time < '2025-09-01'
GROUP BY el.user_id;


