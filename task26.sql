create database Donation_Management;
use Donation_Management;




CREATE TABLE donors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE causes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);


CREATE TABLE donations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    donor_id INT NOT NULL,
    cause_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    donated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (donor_id) REFERENCES donors(id) ON DELETE CASCADE,
    FOREIGN KEY (cause_id) REFERENCES causes(id) ON DELETE CASCADE
);




INSERT INTO donors (name) VALUES ('Alice'), ('Bob'), ('Charlie');

INSERT INTO causes (title) VALUES ('Education Fund'), ('Disaster Relief'), ('Health Initiative');

INSERT INTO donations (donor_id, cause_id, amount) VALUES
(1, 1, 100.00), 
(2, 1, 50.00), 
(1, 2, 75.00),  
(3, 3, 200.00),   
(2, 3, 150.00);  



SELECT 
    c.title AS cause,
    SUM(d.amount) AS total_donated
FROM donations d
JOIN causes c ON d.cause_id = c.id
GROUP BY c.id, c.title;



SELECT 
    c.title AS cause,
    SUM(d.amount) AS total_donated
FROM donations d
JOIN causes c ON d.cause_id = c.id
GROUP BY c.id
ORDER BY total_donated DESC;



SELECT 
    d.name AS donor,
    c.title AS cause,
    dn.amount,
    dn.donated_at
FROM donations dn
JOIN donors d ON dn.donor_id = d.id
JOIN causes c ON dn.cause_id = c.id
WHERE d.name = 'Alice'
ORDER BY dn.donated_at DESC;



SELECT 
    c.title AS cause,
    SUM(d.amount) AS total_donated
FROM donations d
JOIN causes c ON d.cause_id = c.id
WHERE MONTH(d.donated_at) = 8 AND YEAR(d.donated_at) = 2025
GROUP BY c.id;



