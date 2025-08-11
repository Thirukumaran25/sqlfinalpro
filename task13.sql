create database Library_management;
use Library_management;



CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL
);


CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE borrows (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE, 
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);




INSERT INTO books (title, author) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald'),
('1984', 'George Orwell'),
('To Kill a Mockingbird', 'Harper Lee');


INSERT INTO members (name) VALUES
('Alice'),
('Bob');


INSERT INTO borrows (member_id, book_id, borrow_date, return_date) VALUES
(1, 1, '2025-07-20', '2025-07-28'), 
(1, 2, '2025-07-25', NULL),         
(2, 3, '2025-07-22', '2025-08-01'); 


SELECT b.id AS borrow_id, m.name AS member_name, bo.title AS book_title, br.borrow_date
FROM borrows br
JOIN members m ON br.member_id = m.id
JOIN books bo ON br.book_id = bo.id
WHERE br.return_date IS NULL;



SELECT 
    br.id AS borrow_id,
    m.name AS member_name,
    bo.title AS book_title,
    br.borrow_date,
    IFNULL(br.return_date, CURDATE()) AS actual_return_date,
    DATEDIFF(IFNULL(br.return_date, CURDATE()), br.borrow_date) AS days_borrowed,
    GREATEST(DATEDIFF(IFNULL(br.return_date, CURDATE()), br.borrow_date) - 14, 0) AS overdue_days,
    GREATEST(DATEDIFF(IFNULL(br.return_date, CURDATE()), br.borrow_date) - 14, 0) * 1 AS fine_amount
FROM borrows br
JOIN members m ON br.member_id = m.id
JOIN books bo ON br.book_id = bo.id;



SELECT 
    br.id AS borrow_id,
    bo.title,
    br.borrow_date,
    br.return_date
FROM borrows br
JOIN books bo ON br.book_id = bo.id
WHERE br.member_id = 1;



