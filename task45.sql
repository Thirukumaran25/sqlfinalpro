CREATE DATABASE job_scheduler;
USE job_scheduler;

CREATE TABLE jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    frequency VARCHAR(50) NOT NULL
);

CREATE TABLE job_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT NOT NULL,
    run_time DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (job_id) REFERENCES jobs(id)
);



INSERT INTO jobs (name, frequency) VALUES
('daily_report_generation', 'daily'),
('hourly_data_sync', 'hourly'),
('monthly_backup', 'monthly');


INSERT INTO job_logs (job_id, run_time, status) VALUES
(1, '2025-08-10 01:00:00', 'success'),
(1, '2025-08-10 01:05:00', 'failed'),
(1, '2025-08-11 01:00:00', 'success'),
(2, '2025-08-11 06:00:00', 'success'),
(2, '2025-08-11 07:00:00', 'success'),
(3, '2025-07-01 02:00:00', 'success');



SELECT
    j.name,
    (
        SELECT run_time
        FROM job_logs
        WHERE job_id = j.id
        ORDER BY run_time DESC
        LIMIT 1
    ) AS last_run,
    (
        SELECT
            CASE j.frequency
                WHEN 'daily' THEN DATE_ADD(MAX(run_time), INTERVAL 1 DAY)
                WHEN 'hourly' THEN DATE_ADD(MAX(run_time), INTERVAL 1 HOUR)
                WHEN 'monthly' THEN DATE_ADD(MAX(run_time), INTERVAL 1 MONTH)
                ELSE NULL
            END
        FROM job_logs
        WHERE job_id = j.id
    ) AS next_run
FROM
    jobs j;
    
    
    
    
SELECT
    j.name,
    jl.status,
    COUNT(*) AS status_count
FROM
    jobs j
JOIN
    job_logs jl ON j.id = jl.job_id
GROUP BY
    j.name, jl.status
ORDER BY
    j.name, jl.status;
    
    
    









