create database Vehicle_Rental;
use Vehicle_Rental;



CREATE TABLE vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL, 
    plate_number VARCHAR(20) NOT NULL UNIQUE
);



CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE rentals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    customer_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);





INSERT INTO vehicles (type, plate_number) VALUES
('Car', 'ABC-1234'),
('Bike', 'XYZ-5678');


INSERT INTO customers (name) VALUES
('Alice'), ('Bob');


INSERT INTO rentals (vehicle_id, customer_id, start_date, end_date) VALUES
(1, 1, '2025-08-01', '2025-08-05'),
(2, 2, '2025-08-03', '2025-08-04');



SELECT
    r.id AS rental_id,
    c.name AS customer,
    v.plate_number,
    DATEDIFF(r.end_date, r.start_date) + 1 AS rental_days,
    (DATEDIFF(r.end_date, r.start_date) + 1) * 50 AS total_charge
FROM rentals r
JOIN vehicles v ON r.vehicle_id = v.id
JOIN customers c ON r.customer_id = c.id;



SELECT *
FROM rentals
WHERE vehicle_id = 1
  AND (
    start_date <= '2025-08-06' AND
    end_date >= '2025-08-04'
  );



SELECT
    v.plate_number,
    c.name AS rented_by,
    r.start_date,
    r.end_date
FROM rentals r
JOIN vehicles v ON r.vehicle_id = v.id
JOIN customers c ON r.customer_id = c.id
WHERE CURDATE() BETWEEN r.start_date AND r.end_date;




SELECT *
FROM vehicles
WHERE id NOT IN (
    SELECT vehicle_id
    FROM rentals
    WHERE '2025-08-05' BETWEEN start_date AND end_date
);




