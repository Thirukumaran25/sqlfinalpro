create database Health_Record;
use Health_Record;


CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL
);


CREATE TABLE medications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE prescriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);



CREATE TABLE prescription_details (
    prescription_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(id) ON DELETE CASCADE,
    FOREIGN KEY (medication_id) REFERENCES medications(id)
);




INSERT INTO patients (name, dob) VALUES
('Alice Green', '1992-06-12'),
('Bob White', '1980-11-03');


INSERT INTO medications (name) VALUES
('Paracetamol'),
('Ibuprofen'),
('Amoxicillin');


INSERT INTO prescriptions (patient_id, date) VALUES
(1, '2025-08-01'),
(2, '2025-08-05');



INSERT INTO prescription_details (prescription_id, medication_id, dosage) VALUES
(1, 1, '500mg twice daily'),
(1, 3, '250mg three times daily'),
(2, 2, '200mg once daily');




SELECT 
    p.name AS patient_name,
    pr.date AS prescription_date,
    m.name AS medication,
    pd.dosage
FROM prescriptions pr
JOIN prescription_details pd ON pr.id = pd.prescription_id
JOIN medications m ON pd.medication_id = m.id
JOIN patients p ON pr.patient_id = p.id
WHERE p.name = 'Alice Green';




SELECT 
    p.name AS patient_name,
    pr.date AS prescription_date,
    m.name AS medication,
    pd.dosage
FROM prescriptions pr
JOIN prescription_details pd ON pr.id = pd.prescription_id
JOIN medications m ON pd.medication_id = m.id
JOIN patients p ON pr.patient_id = p.id
WHERE pr.date BETWEEN '2025-08-01' AND '2025-08-31';



SELECT 
    pr.id AS prescription_id,
    pr.date AS prescription_date,
    m.name AS medication,
    pd.dosage
FROM prescriptions pr
JOIN prescription_details pd ON pr.id = pd.prescription_id
JOIN medications m ON pd.medication_id = m.id
WHERE pr.patient_id = 1;




