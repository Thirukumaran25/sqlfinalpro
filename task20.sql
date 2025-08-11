create database Salary_Management;
use Salary_Management;



CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE salaries (
    emp_id INT NOT NULL,
    month DATE NOT NULL,
    base DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0.00,
    PRIMARY KEY (emp_id, month),
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);


CREATE TABLE deductions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    month DATE NOT NULL,
    reason VARCHAR(255),
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);




INSERT INTO employees (name) VALUES ('Alice'), ('Bob');


INSERT INTO salaries (emp_id, month, base, bonus) VALUES
(1, '2025-08-01', 5000.00, 500.00),
(2, '2025-08-01', 4500.00, 0.00);


INSERT INTO deductions (emp_id, month, reason, amount) VALUES
(1, '2025-08-01', 'Late coming', 100.00),
(1, '2025-08-01', 'Health Insurance', 200.00),
(2, '2025-08-01', 'Loan Repayment', 300.00);



SELECT 
    e.id AS emp_id,
    e.name,
    s.month,
    s.base,
    s.bonus,
    COALESCE(SUM(d.amount), 0) AS total_deductions,
    (s.base + s.bonus - COALESCE(SUM(d.amount), 0)) AS net_salary
FROM employees e
JOIN salaries s ON e.id = s.emp_id
LEFT JOIN deductions d ON e.id = d.emp_id AND s.month = d.month
GROUP BY e.id, s.month, s.base, s.bonus;




SELECT 
    s.month,
    s.base,
    s.bonus,
    COALESCE(SUM(d.amount), 0) AS total_deductions,
    (s.base + s.bonus - COALESCE(SUM(d.amount), 0)) AS net_salary
FROM salaries s
LEFT JOIN deductions d ON s.emp_id = d.emp_id AND s.month = d.month
WHERE s.emp_id = 1
GROUP BY s.month, s.base, s.bonus
ORDER BY s.month;




SELECT 
    e.name,
    s.month,
    s.base,
    CASE 
        WHEN s.base > 5000 THEN s.base * 0.10
        ELSE s.bonus
    END AS final_bonus,
    COALESCE(SUM(d.amount), 0) AS total_deductions,
    (s.base + 
        CASE 
            WHEN s.base > 5000 THEN s.base * 0.10
            ELSE s.bonus
        END - COALESCE(SUM(d.amount), 0)) AS net_salary
FROM employees e
JOIN salaries s ON e.id = s.emp_id
LEFT JOIN deductions d ON s.emp_id = d.emp_id AND s.month = d.month
GROUP BY e.id, s.month, s.base, s.bonus;




