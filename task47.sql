CREATE DATABASE complaint_system;
USE complaint_system;


CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);



CREATE TABLE complaints (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    department_id INT,
    status ENUM('open', 'in_progress', 'resolved', 'closed') DEFAULT 'open',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);



CREATE TABLE responses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id INT NOT NULL,
    responder_id INT,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id)
);



INSERT INTO departments (name) VALUES
('Customer Service'),
('Technical Support');


INSERT INTO complaints (title, department_id, status) VALUES
('Slow internet speed', 2, 'in_progress'),
('Billing inquiry for recent charge', 1, 'resolved'),
('Cannot log in to my account', 2, 'open'),
('General question about service', 1, 'closed');


INSERT INTO responses (complaint_id, responder_id, message) VALUES
(1, 201, 'We are looking into the network issue.'),
(2, 101, 'The charge was a one-time setup fee. We have attached the invoice.'),
(3, 202, 'Please try resetting your password through the link provided.');



SELECT
    status,
    COUNT(*) AS complaint_count
FROM
    complaints
GROUP BY
    status
ORDER BY
    status;
    
    
    
SELECT
    d.name AS department_name,
    c.status,
    COUNT(c.id) AS complaint_count
FROM
    departments d
LEFT JOIN
    complaints c ON d.id = c.department_id
GROUP BY
    d.name, c.status
ORDER BY
    d.name, c.status;
    
