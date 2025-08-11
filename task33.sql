create database Asset_Management;
use Asset_Management;



CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE assets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);


CREATE TABLE assignments (
    asset_id INT NOT NULL,
    user_id INT NOT NULL,
    assigned_date DATE NOT NULL,
    returned_date DATE DEFAULT NULL,
    PRIMARY KEY (asset_id, assigned_date),
    FOREIGN KEY (asset_id) REFERENCES assets(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);



INSERT INTO users (name) VALUES ('Alice'), ('Bob');


INSERT INTO assets (name, category) VALUES
('Dell Laptop', 'Laptop'),
('iPhone 13', 'Phone'),
('HP Printer', 'Printer');


INSERT INTO assignments (asset_id, user_id, assigned_date, returned_date) VALUES
(1, 1, '2025-08-01', NULL), 
(2, 2, '2025-07-20', '2025-08-05'),  
(3, 2, '2025-08-07', NULL);



SELECT 
    a.name AS asset_name,
    a.category,
    u.name AS assigned_to,
    ass.assigned_date
FROM assignments ass
JOIN assets a ON ass.asset_id = a.id
JOIN users u ON ass.user_id = u.id
WHERE ass.returned_date IS NULL;



SELECT a.id, a.name, a.category
FROM assets a
WHERE a.id NOT IN (
    SELECT asset_id FROM assignments WHERE returned_date IS NULL
);



SELECT 
    a.name AS asset_name,
    u.name AS assigned_to,
    ass.assigned_date,
    ass.returned_date
FROM assignments ass
JOIN assets a ON ass.asset_id = a.id
JOIN users u ON ass.user_id = u.id
ORDER BY ass.assigned_date DESC;



SELECT 
    u.name AS user,
    a.name AS asset,
    a.category,
    ass.assigned_date
FROM assignments ass
JOIN users u ON ass.user_id = u.id
JOIN assets a ON ass.asset_id = a.id
WHERE ass.returned_date IS NULL
ORDER BY u.name;



SELECT 
    a.name AS asset_name,
    COUNT(*) AS total_times_assigned
FROM assignments ass
JOIN assets a ON ass.asset_id = a.id
GROUP BY a.id;


