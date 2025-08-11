CREATE DATABASE inventory_tracker;
USE inventory_tracker;



CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);



CREATE TABLE batches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    expiry_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);




INSERT INTO products (name) VALUES
('Milk'),
('Bread'),
('Yogurt');



INSERT INTO batches (product_id, quantity, expiry_date) VALUES
(1, 50, '2025-08-10'),
(1, 75, '2025-08-25'), 
(2, 20, '2025-08-12'),
(3, 100, '2025-08-09'), 
(3, 150, '2025-09-01'); 



SELECT
    p.name AS product_name,
    b.id AS batch_id,
    b.quantity,
    b.expiry_date
FROM
    products p
JOIN
    batches b ON p.id = b.product_id
WHERE
    b.expiry_date < CURDATE()
ORDER BY
    b.expiry_date;
    
    

SELECT
    p.name AS product_name,
    SUM(b.quantity) AS remaining_stock
FROM
    products p
JOIN
    batches b ON p.id = b.product_id
WHERE
    b.expiry_date >= CURDATE()
GROUP BY
    p.name
ORDER BY
    p.name;
    

