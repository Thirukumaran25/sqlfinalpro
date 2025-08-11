create database Fitness_Tracker;
use Fitness_Tracker;



CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE workouts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL 
);



CREATE TABLE workout_logs (
    user_id INT NOT NULL,
    workout_id INT NOT NULL,
    duration INT NOT NULL,
    log_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, workout_id, log_date)
);



INSERT INTO users (name) VALUES ('Alice'), ('Bob');

INSERT INTO workouts (name, type) VALUES 
('Running', 'Cardio'),
('Weight Lifting', 'Strength'),
('Yoga', 'Flexibility');

INSERT INTO workout_logs (user_id, workout_id, duration, log_date) VALUES
(1, 1, 30, '2025-08-01'),
(1, 2, 45, '2025-08-02'),
(2, 1, 25, '2025-08-01'),
(2, 3, 60, '2025-08-03'),
(1, 1, 20, '2025-08-08'); 




SELECT
    u.name AS user,
    YEARWEEK(wl.log_date, 1) AS year_week,
    SUM(wl.duration) AS total_duration_minutes
FROM workout_logs wl
JOIN users u ON wl.user_id = u.id
GROUP BY wl.user_id, YEARWEEK(wl.log_date, 1)
ORDER BY wl.user_id, year_week;




SELECT
    u.name AS user,
    w.name AS workout_name,
    w.type AS workout_type,
    wl.duration,
    wl.log_date
FROM workout_logs wl
JOIN users u ON wl.user_id = u.id
JOIN workouts w ON wl.workout_id = w.id
ORDER BY wl.log_date DESC;




SELECT
    u.name AS user,
    w.type AS workout_type,
    SUM(wl.duration) AS total_duration
FROM workout_logs wl
JOIN users u ON wl.user_id = u.id
JOIN workouts w ON wl.workout_id = w.id
GROUP BY wl.user_id, w.type
ORDER BY u.name, total_duration DESC;



