create database Restaurant_Reservation;
use Restaurant_Reservation;



CREATE TABLE tables (
    id INT AUTO_INCREMENT PRIMARY KEY,
    table_number INT NOT NULL UNIQUE,
    capacity INT NOT NULL
);


CREATE TABLE guests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    guest_id INT NOT NULL,
    table_id INT NOT NULL,
    date DATE NOT NULL,
    time_slot TIME NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guests(id),
    FOREIGN KEY (table_id) REFERENCES tables(id)
);



INSERT INTO tables (table_number, capacity) VALUES
(1, 2), (2, 4), (3, 6);

INSERT INTO guests (name) VALUES
('Alice'), ('Bob'), ('Charlie');

INSERT INTO reservations (guest_id, table_id, date, time_slot) VALUES
(1, 1, '2025-08-10', '18:00:00'),
(2, 2, '2025-08-10', '18:00:00'),
(3, 1, '2025-08-10', '19:00:00');



SELECT *
FROM reservations
WHERE table_id = 1
  AND date = '2025-08-10'
  AND time_slot = '18:00:00';



SELECT
    t.table_number,
    r.date,
    COUNT(*) AS total_reservations
FROM reservations r
JOIN tables t ON r.table_id = t.id
WHERE r.date = '2025-08-10'
GROUP BY r.table_id, r.date
ORDER BY t.table_number;




SELECT
    g.name AS guest,
    t.table_number,
    r.date,
    r.time_slot
FROM reservations r
JOIN guests g ON r.guest_id = g.id
JOIN tables t ON r.table_id = t.id
WHERE g.name = 'Alice';



