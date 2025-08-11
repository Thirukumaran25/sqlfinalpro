create database Product_Wishlist;
use Product_Wishlist;



CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);



CREATE TABLE wishlist (
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);



INSERT INTO users (name) VALUES ('Alice'), ('Bob'), ('Charlie');

INSERT INTO products (name) VALUES ('Laptop'), ('Headphones'), ('Smartphone'), ('Camera');

INSERT INTO wishlist (user_id, product_id) VALUES
(1, 1), 
(1, 2), 
(2, 1), 
(2, 3), 
(3, 1), 
(3, 4); 



SELECT 
    u.name AS user,
    p.name AS product,
    w.added_at
FROM wishlist w
JOIN users u ON w.user_id = u.id
JOIN products p ON w.product_id = p.id
WHERE u.id = 1;



SELECT 
    p.name AS product,
    COUNT(w.user_id) AS wishlist_count
FROM wishlist w
JOIN products p ON w.product_id = p.id
GROUP BY w.product_id, p.name
ORDER BY wishlist_count DESC;



DELETE FROM wishlist
WHERE user_id = 1 AND product_id = 2;


