create database IT_Support;
use IT_Support;



CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE support_staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    issue TEXT NOT NULL,
    status ENUM('Open', 'In Progress', 'Resolved', 'Closed') DEFAULT 'Open',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    resolved_at DATETIME DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);


CREATE TABLE assignments (
    ticket_id INT PRIMARY KEY,
    staff_id INT NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES support_staff(id) ON DELETE CASCADE
);



INSERT INTO users (name) VALUES ('Alice'), ('Bob');


INSERT INTO support_staff (name) VALUES ('Tech1'), ('Tech2');


INSERT INTO tickets (user_id, issue, status, created_at, resolved_at) VALUES
(1, 'Cannot connect to VPN', 'Resolved', '2025-08-01 08:00:00', '2025-08-01 10:00:00'),
(2, 'Forgot password', 'Resolved', '2025-08-02 09:00:00', '2025-08-02 09:30:00'),
(1, 'Laptop won’t start', 'In Progress', '2025-08-03 11:00:00', NULL);


INSERT INTO assignments (ticket_id, staff_id) VALUES
(1, 1),
(2, 2),
(3, 1);



SELECT 
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, created_at, resolved_at)) / 60, 2) AS avg_resolution_hours
FROM tickets
WHERE resolved_at IS NOT NULL;



SELECT 
    status,
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY status;



SELECT 
    s.name AS support_staff,
    COUNT(a.ticket_id) AS tickets_assigned
FROM support_staff s
LEFT JOIN assignments a ON s.id = a.staff_id
GROUP BY s.id;



SELECT 
    t.id AS ticket_id,
    u.name AS user,
    s.name AS support_staff,
    t.issue,
    t.status,
    t.created_at,
    t.resolved_at,
    TIMESTAMPDIFF(MINUTE, t.created_at, t.resolved_at) AS resolution_minutes
FROM tickets t
JOIN users u ON t.user_id = u.id
LEFT JOIN assignments a ON t.id = a.ticket_id
LEFT JOIN support_staff s ON a.staff_id = s.id
WHERE t.resolved_at IS NOT NULL;



SELECT 
    t.id,
    u.name AS user,
    t.issue,
    t.status,
    t.created_at
FROM tickets t
JOIN users u ON t.user_id = u.id
WHERE t.resolved_at IS NULL;



