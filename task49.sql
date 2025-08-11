CREATE DATABASE subscription_tracker;
USE subscription_tracker;



CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE subscriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    plan_name VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    renewal_cycle ENUM('monthly', 'quarterly', 'yearly') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);



INSERT INTO users (name) VALUES
('Alice Johnson'),
('Bob Smith'),
('Charlie Brown');


INSERT INTO subscriptions (user_id, plan_name, start_date, renewal_cycle) VALUES
(1, 'Basic Plan', '2025-07-15', 'monthly');


INSERT INTO subscriptions (user_id, plan_name, start_date, renewal_cycle) VALUES
(2, 'Premium Plan', '2024-08-11', 'yearly');


INSERT INTO subscriptions (user_id, plan_name, start_date, renewal_cycle) VALUES
(3, 'Standard Plan', '2024-11-01', 'quarterly');



SELECT
    u.name AS user_name,
    s.plan_name,
    s.start_date,
    s.renewal_cycle,
    CASE s.renewal_cycle
        WHEN 'monthly' THEN DATE_ADD(s.start_date, INTERVAL 1 MONTH)
        WHEN 'quarterly' THEN DATE_ADD(s.start_date, INTERVAL 3 MONTH)
        WHEN 'yearly' THEN DATE_ADD(s.start_date, INTERVAL 1 YEAR)
        ELSE NULL
    END AS next_renewal_date
FROM
    subscriptions s
JOIN
    users u ON s.user_id = u.id;
    
    


SELECT
    u.name AS user_name,
    s.plan_name,
    s.start_date,
    s.renewal_cycle,
    CASE s.renewal_cycle
        WHEN 'monthly' THEN DATE_ADD(s.start_date, INTERVAL 1 MONTH)
        WHEN 'quarterly' THEN DATE_ADD(s.start_date, INTERVAL 3 MONTH)
        WHEN 'yearly' THEN DATE_ADD(s.start_date, INTERVAL 1 YEAR)
        ELSE NULL
    END AS expired_on
FROM
    subscriptions s
JOIN
    users u ON s.user_id = u.id
WHERE
    CASE s.renewal_cycle
        WHEN 'monthly' THEN DATE_ADD(s.start_date, INTERVAL 1 MONTH)
        WHEN 'quarterly' THEN DATE_ADD(s.start_date, INTERVAL 3 MONTH)
        WHEN 'yearly' THEN DATE_ADD(s.start_date, INTERVAL 1 YEAR)
        ELSE NULL
    END < CURDATE();
    


