create database Hotel_Room;
use Hotel_Room;



CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    number VARCHAR(10) NOT NULL UNIQUE,
    type ENUM('single', 'double', 'suite') NOT NULL
);


CREATE TABLE guests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT NOT NULL,
    guest_id INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES guests(id) ON DELETE CASCADE,
    CHECK (from_date < to_date)
);



INSERT INTO rooms (number, type) VALUES 
('101', 'single'), 
('102', 'double'), 
('201', 'suite');


INSERT INTO guests (name) VALUES ('Alice'), ('Bob');

INSERT INTO bookings (room_id, guest_id, from_date, to_date) VALUES
(1, 1, '2025-08-10', '2025-08-12'), 
(2, 2, '2025-08-11', '2025-08-13'); 



SELECT * FROM rooms r
WHERE r.id NOT IN (
    SELECT b.room_id
    FROM bookings b
    WHERE
        '2025-08-11' < b.to_date AND
        '2025-08-13' > b.from_date
);



SELECT 
    r.number AS room_number,
    g.name AS guest_name,
    b.from_date,
    b.to_date
FROM bookings b
JOIN rooms r ON b.room_id = r.id
JOIN guests g ON b.guest_id = g.id
WHERE '2025-08-11' BETWEEN b.from_date AND DATE_SUB(b.to_date, INTERVAL 1 DAY);



SELECT 
    r.number AS room_number,
    COUNT(b.id) AS total_bookings
FROM rooms r
LEFT JOIN bookings b ON r.id = b.room_id
GROUP BY r.id;



SELECT * FROM bookings
WHERE room_id = 1
  AND '2025-08-11' < to_date
  AND '2025-08-13' > from_date;



