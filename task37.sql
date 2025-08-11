create database Food_Delivery;
use Food_Delivery;


CREATE TABLE restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE delivery_agents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    user_id INT NOT NULL,
    placed_at DATETIME NOT NULL,
    delivered_at DATETIME DEFAULT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);


CREATE TABLE deliveries (
    order_id INT PRIMARY KEY,
    agent_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (agent_id) REFERENCES delivery_agents(id)
);



INSERT INTO restaurants (name) VALUES ('Pizza Palace'), ('Sushi Spot');

INSERT INTO delivery_agents (name) VALUES ('Alice'), ('Bob');

INSERT INTO orders (restaurant_id, user_id, placed_at, delivered_at) VALUES
(1, 101, '2025-08-01 12:00:00', '2025-08-01 12:45:00'),
(2, 102, '2025-08-01 13:15:00', '2025-08-01 14:00:00'),
(1, 103, '2025-08-01 13:45:00', NULL);

INSERT INTO deliveries (order_id, agent_id) VALUES
(1, 1),
(2, 2),
(3, 1);



SELECT 
    r.name AS restaurant,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, o.placed_at, o.delivered_at)), 2) AS avg_delivery_minutes
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.id
WHERE o.delivered_at IS NOT NULL
GROUP BY r.id;



SELECT 
    da.name AS agent,
    COUNT(o.id) AS total_orders,
    SUM(CASE WHEN o.delivered_at IS NULL THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN o.delivered_at IS NOT NULL THEN 1 ELSE 0 END) AS completed_orders
FROM delivery_agents da
LEFT JOIN deliveries d ON da.id = d.agent_id
LEFT JOIN orders o ON d.order_id = o.id
GROUP BY da.id;



SELECT
    o.id AS order_id,
    r.name AS restaurant,
    o.user_id,
    o.placed_at,
    o.delivered_at,
    TIMESTAMPDIFF(MINUTE, o.placed_at, o.delivered_at) AS delivery_time_minutes,
    da.name AS delivery_agent
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.id
LEFT JOIN deliveries d ON o.id = d.order_id
LEFT JOIN delivery_agents da ON d.agent_id = da.id
ORDER BY o.placed_at DESC;




SELECT 
    o.id,
    r.name AS restaurant,
    o.user_id,
    o.placed_at,
    TIMESTAMPDIFF(MINUTE, o.placed_at, NOW()) AS minutes_since_order,
    da.name AS delivery_agent
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.id
LEFT JOIN deliveries d ON o.id = d.order_id
LEFT JOIN delivery_agents da ON d.agent_id = da.id
WHERE o.delivered_at IS NULL
AND TIMESTAMPDIFF(MINUTE, o.placed_at, NOW()) > 30;



