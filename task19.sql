create database Loan_Repayment;
use Loan_Repayment;


CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);



CREATE TABLE loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    principal DECIMAL(12,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    start_date DATE NOT NULL,
    term_months INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    paid_on DATE NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES loans(id) ON DELETE CASCADE
);



INSERT INTO users (name) VALUES ('Alice'), ('Bob');


INSERT INTO loans (user_id, principal, interest_rate, start_date, term_months) VALUES
(1, 10000.00, 12.0, '2025-01-01', 12),
(2, 5000.00, 10.0, '2025-06-01', 6);


INSERT INTO payments (loan_id, amount, paid_on) VALUES
(1, 900.00, '2025-02-01'),
(1, 900.00, '2025-03-01'),
(2, 850.00, '2025-07-01');



SELECT 
    l.id AS loan_id,
    u.name AS borrower,
    l.principal,
    l.interest_rate,
    l.term_months,
    
    ROUND(l.principal * (1 + (l.interest_rate / 100) * (l.term_months / 12)), 2) AS total_due,

    COALESCE(SUM(p.amount), 0) AS total_paid,

    ROUND(
        (l.principal * (1 + (l.interest_rate / 100) * (l.term_months / 12))) - COALESCE(SUM(p.amount), 0),
        2
    ) AS remaining_balance

FROM loans l
JOIN users u ON l.user_id = u.id
LEFT JOIN payments p ON l.id = p.loan_id
GROUP BY l.id, u.name, l.principal, l.interest_rate, l.term_months;




WITH months_due AS (
    SELECT
        l.id AS loan_id,
        u.name AS borrower,
        DATE_ADD(l.start_date, INTERVAL seq MONTH) AS due_date
    FROM loans l
    JOIN users u ON l.user_id = u.id
    JOIN (
        SELECT 0 AS seq UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
        UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11
    ) AS numbers
    WHERE l.id = 1 
    AND numbers.seq < l.term_months
),
paid_months AS (
    SELECT DISTINCT DATE_FORMAT(p.paid_on, '%Y-%m') AS paid_month
    FROM payments p
    WHERE p.loan_id = 1
)
SELECT 
    md.due_date,
    DATE_FORMAT(md.due_date, '%Y-%m') AS due_month,
    CASE 
        WHEN DATE_FORMAT(md.due_date, '%Y-%m') IN (SELECT paid_month FROM paid_months) 
        THEN 'Paid'
        ELSE 'Missed'
    END AS status
FROM months_due md
ORDER BY md.due_date;



