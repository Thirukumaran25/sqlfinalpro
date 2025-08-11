create database Hospital_patient;
use Hospital_patient;



CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL
);



CREATE TABLE doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100)
);



CREATE TABLE visits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    visit_time DATETIME NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);




SELECT 
    d.name AS doctor,
    v1.visit_time AS time1,
    v2.visit_time AS time2
FROM visits v1
JOIN visits v2 ON v1.doctor_id = v2.doctor_id 
    AND v1.id <> v2.id
    AND ABS(TIMESTAMPDIFF(MINUTE, v1.visit_time, v2.visit_time)) < 60
JOIN doctors d ON v1.doctor_id = d.id;




INSERT INTO patients (name, dob) VALUES
('Alice Brown', '1990-05-10'),
('Bob Smith', '1985-09-23');


INSERT INTO doctors (name, specialization) VALUES
('Dr. Adams', 'Cardiology'),
('Dr. Baker', 'Neurology');


INSERT INTO visits (patient_id, doctor_id, visit_time) VALUES
(1, 1, '2025-08-10 09:00:00'),
(2, 1, '2025-08-10 10:00:00'),
(1, 2, '2025-08-11 14:00:00');



SELECT 
    p.name AS patient_name,
    d.name AS doctor_name,
    v.visit_time
FROM visits v
JOIN patients p ON v.patient_id = p.id
JOIN doctors d ON v.doctor_id = d.id
WHERE d.name = 'Dr. Adams' 
  AND DATE(v.visit_time) = '2025-08-10';




SELECT 
    v.id AS visit_id,
    p.name AS patient_name,
    v.visit_time
FROM visits v
JOIN patients p ON v.patient_id = p.id
WHERE v.doctor_id = 1
ORDER BY v.visit_time;



SELECT 
    p.name AS patient,
    v1.visit_time AS time1,
    v2.visit_time AS time2
FROM visits v1
JOIN visits v2 ON v1.patient_id = v2.patient_id 
    AND v1.id <> v2.id
    AND ABS(TIMESTAMPDIFF(MINUTE, v1.visit_time, v2.visit_time)) < 60
JOIN patients p ON v1.patient_id = p.id;



