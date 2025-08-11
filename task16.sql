create database Expense_tracker;
use Expense_tracker;



CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);



CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);



CREATE TABLE expenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    category_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);




INSERT INTO users (name) VALUES
('Alice'), ('Bob');


INSERT INTO categories (name) VALUES
('Food'), ('Transport'), ('Entertainment'), ('Utilities');


INSERT INTO expenses (user_id, category_id, amount, date) VALUES
(1, 1, 25.50, '2025-08-01'),
(1, 2, 15.00, '2025-08-02'),
(1, 1, 30.00, '2025-08-15'),
(2, 3, 50.00, '2025-08-03'),
(2, 4, 75.00, '2025-08-04'),
(1, 3, 40.00, '2025-07-28');



SELECT 
    c.name AS category,
    SUM(e.amount) AS total_spent
FROM expenses e
JOIN categories c ON e.category_id = c.id
WHERE e.user_id = 1
GROUP BY c.name;



SELECT 
    u.name AS user,
    DATE_FORMAT(e.date, '%Y-%m') AS month,
    SUM(e.amount) AS total_spent
FROM expenses e
JOIN users u ON e.user_id = u.id
GROUP BY u.id, month
ORDER BY month;



SELECT 
    u.name AS user,
    c.name AS category,
    e.amount,
    e.date
FROM expenses e
JOIN users u ON e.user_id = u.id
JOIN categories c ON e.category_id = c.id
WHERE e.amount BETWEEN 20 AND 50;



SELECT 
    e.date,
    c.name AS category,
    e.amount
FROM expenses e
JOIN categories c ON e.category_id = c.id
WHERE e.user_id = 1
ORDER BY e.date;



