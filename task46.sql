CREATE DATABASE saas_multi_tenant;
USE saas_multi_tenant;



CREATE TABLE tenants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    tenant_id INT NOT NULL,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);


CREATE TABLE data (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tenant_id INT NOT NULL,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);



INSERT INTO tenants (name) VALUES
('Alpha Corp'),
('Beta Inc');


INSERT INTO users (name, email, tenant_id) VALUES
('Alice', 'alice@alphacorp.com', 1),
('Bob', 'bob@alphacorp.com', 1);


INSERT INTO users (name, email, tenant_id) VALUES
('Charlie', 'charlie@betainc.com', 2),
('Diana', 'diana@betainc.com', 2);


INSERT INTO data (tenant_id, content) VALUES
(1, 'Alpha Corp private document 1'),
(1, 'Alpha Corp private document 2');


INSERT INTO data (tenant_id, content) VALUES
(2, 'Beta Inc confidential file A'),
(2, 'Beta Inc confidential file B');



SELECT
    u.id,
    u.name,
    u.email,
    t.name AS tenant_name
FROM
    users u
JOIN
    tenants t ON u.tenant_id = t.id
WHERE
    u.tenant_id = 1;
    
    
    
SELECT
    d.id,
    d.content,
    t.name AS tenant_name
FROM
    data d
JOIN
    tenants t ON d.tenant_id = t.id
WHERE
    d.tenant_id = 2;