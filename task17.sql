create database invoice_generator;
use invoice_generator;


CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);



CREATE TABLE invoices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);


CREATE TABLE invoice_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL,
    description VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    rate DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE
);




INSERT INTO clients (name) VALUES
('Acme Corp'), ('Beta Ltd');


INSERT INTO invoices (client_id, date) VALUES
(1, '2025-08-01'),
(2, '2025-08-02');



INSERT INTO invoice_items (invoice_id, description, quantity, rate) VALUES
(1, 'Web Design Services', 10, 50.00),
(1, 'Logo Design', 1, 150.00),
(2, 'Hosting Fee', 12, 10.00),
(2, 'Domain Registration', 1, 15.00);



SELECT 
    i.id AS invoice_id,
    c.name AS client_name,
    i.date,
    ii.description,
    ii.quantity,
    ii.rate,
    (ii.quantity * ii.rate) AS subtotal
FROM invoices i
JOIN clients c ON i.client_id = c.id
JOIN invoice_items ii ON i.id = ii.invoice_id
WHERE i.id = 1;



SELECT 
    i.id AS invoice_id,
    c.name AS client_name,
    i.date,
    SUM(ii.quantity * ii.rate) AS total_amount
FROM invoices i
JOIN clients c ON i.client_id = c.id
JOIN invoice_items ii ON i.id = ii.invoice_id
WHERE i.id = 1
GROUP BY i.id, c.name, i.date;



SELECT 
    i.id AS invoice_id,
    c.name AS client_name,
    i.date,
    SUM(ii.quantity * ii.rate) AS total_amount
FROM invoices i
JOIN clients c ON i.client_id = c.id
JOIN invoice_items ii ON i.id = ii.invoice_id
GROUP BY i.id, c.name, i.date
ORDER BY i.date DESC;



