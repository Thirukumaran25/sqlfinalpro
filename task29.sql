create database Recruitment_Portal;
use Recruitment_Portal;



CREATE TABLE jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    company VARCHAR(100) NOT NULL
);


CREATE TABLE candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE applications (
    job_id INT NOT NULL,
    candidate_id INT NOT NULL,
    status ENUM('applied', 'interviewed', 'hired', 'rejected') NOT NULL DEFAULT 'applied',
    applied_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (job_id, candidate_id),
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE
);




INSERT INTO jobs (title, company) VALUES
('Software Engineer', 'TechCorp'),
('Data Analyst', 'DataWorks');


INSERT INTO candidates (name) VALUES
('Alice'),
('Bob'),
('Charlie');


INSERT INTO applications (job_id, candidate_id, status) VALUES
(1, 1, 'applied'),    
(1, 2, 'interviewed'),  
(2, 1, 'hired'),  
(2, 3, 'rejected');    



SELECT 
    c.name AS candidate,
    j.title AS job_title,
    j.company,
    a.status,
    a.applied_at
FROM applications a
JOIN candidates c ON a.candidate_id = c.id
JOIN jobs j ON a.job_id = j.id
WHERE a.status = 'interviewed';



SELECT 
    j.title AS job_title,
    j.company,
    COUNT(*) AS applicant_count
FROM applications a
JOIN jobs j ON a.job_id = j.id
GROUP BY a.job_id;



SELECT 
    j.title AS job,
    j.company,
    a.status,
    a.applied_at
FROM applications a
JOIN jobs j ON a.job_id = j.id
WHERE a.candidate_id = 1; 



SELECT 
    j.title,
    j.company,
    COUNT(*) AS hired_count
FROM applications a
JOIN jobs j ON a.job_id = j.id
WHERE a.status = 'hired'
GROUP BY a.job_id;



