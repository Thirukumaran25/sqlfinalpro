CREATE DATABASE event_management;
USE event_management;


CREATE TABLE events (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    max_capacity INT NOT NULL CHECK (max_capacity >= 0)
);



CREATE TABLE attendees (
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (event_id, user_id),
    FOREIGN KEY (event_id) REFERENCES events(id)
);



INSERT INTO events (title, max_capacity) VALUES
('Tech Conference 2025', 1000),
('Product Launch Workshop', 50);



INSERT INTO attendees (event_id, user_id) VALUES
(1, 101),
(1, 102),
(1, 103);



INSERT INTO attendees (event_id, user_id) VALUES
(2, 201),
(2, 202),
(2, 203),
(2, 204),
(2, 205),
(2, 206),
(2, 207),
(2, 208),
(2, 209),
(2, 210);



SELECT
    e.title,
    e.max_capacity,
    COUNT(a.user_id) AS registered_attendees
FROM
    events e
LEFT JOIN
    attendees a ON e.id = a.event_id
GROUP BY
    e.id
ORDER BY
    e.id;
    
 
 
SELECT
    e.title,
    e.max_capacity,
    COUNT(a.user_id) AS registered_attendees,
    (COUNT(a.user_id) / e.max_capacity) * 100 AS occupancy_percentage
FROM
    events e
LEFT JOIN
    attendees a ON e.id = a.event_id
GROUP BY
    e.id
HAVING
    (COUNT(a.user_id) / e.max_capacity) * 100 >= 90;
    
    

