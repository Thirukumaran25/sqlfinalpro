create database Product_Return;
use Product_Return;


CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL
);



CREATE TABLE returns (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    reason TEXT NOT NULL,
    status ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending',
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);



INSERT INTO orders (user_id, product_id) VALUES
(1, 101),
(2, 102),
(3, 103);


INSERT INTO returns (order_id, reason, status) VALUES
(1, 'Damaged item', 'pending'),
(2, 'Wrong size', 'approved');




SELECT
    o.id AS order_id,
    o.user_id,
    o.product_id,
    r.reason,
    r.status
FROM orders o
LEFT JOIN returns r ON o.id = r.order_id;



SELECT
    status,
    COUNT(*) AS total_returns
FROM returns
GROUP BY status;




SELECT *
FROM orders
WHERE id NOT IN (SELECT order_id FROM returns);



SELECT
    o.id AS order_id,
    o.user_id,
    o.product_id,
    r.reason,
    r.status
FROM returns r
JOIN orders o ON r.order_id = o.id
WHERE r.status = 'approved';


