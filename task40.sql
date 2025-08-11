create database Freelance_Project;
use Freelance_Project;



CREATE TABLE freelancers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    skill VARCHAR(100) NOT NULL
);

CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    title VARCHAR(200) NOT NULL
);

CREATE TABLE proposals (
    freelancer_id INT NOT NULL,
    project_id INT NOT NULL,
    bid_amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
    PRIMARY KEY (freelancer_id, project_id),
    FOREIGN KEY (freelancer_id) REFERENCES freelancers(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);



INSERT INTO freelancers (name, skill) VALUES
('Alice', 'Web Development'),
('Bob', 'Graphic Design');

INSERT INTO projects (client_name, title) VALUES
('Acme Corp', 'Website Redesign'),
('Beta LLC', 'Logo Creation');

INSERT INTO proposals (freelancer_id, project_id, bid_amount, status) VALUES
(1, 1, 1500.00, 'pending'),
(2, 1, 1400.00, 'accepted'),
(2, 2, 500.00, 'pending');




SELECT
    f.name AS freelancer,
    p.title AS project,
    pr.bid_amount,
    pr.status
FROM proposals pr
JOIN freelancers f ON pr.freelancer_id = f.id
JOIN projects p ON pr.project_id = p.id
ORDER BY pr.status = 'accepted' DESC, pr.bid_amount ASC;



SELECT
    f.name AS freelancer,
    COUNT(pr.project_id) AS accepted_projects_count
FROM freelancers f
LEFT JOIN proposals pr ON f.id = pr.freelancer_id AND pr.status = 'accepted'
GROUP BY f.id;



SELECT
    f.name AS freelancer,
    pr.bid_amount,
    pr.status
FROM proposals pr
JOIN freelancers f ON pr.freelancer_id = f.id
WHERE pr.project_id = 1;



