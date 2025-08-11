create database Sports_Tournament;
use Sports_Tournament;



CREATE TABLE teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE matches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team1_id INT NOT NULL,
    team2_id INT NOT NULL,
    match_date DATE NOT NULL,
    FOREIGN KEY (team1_id) REFERENCES teams(id),
    FOREIGN KEY (team2_id) REFERENCES teams(id)
);


CREATE TABLE scores (
    match_id INT NOT NULL,
    team_id INT NOT NULL,
    score INT NOT NULL,
    PRIMARY KEY (match_id, team_id),
    FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE CASCADE,
    FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE
);




INSERT INTO teams (name) VALUES ('Falcons'), ('Tigers'), ('Wolves'), ('Eagles');


INSERT INTO matches (team1_id, team2_id, match_date) VALUES
(1, 2, '2025-08-01'),
(3, 4, '2025-08-02'),
(1, 3, '2025-08-05');


INSERT INTO scores VALUES
(1, 1, 3), 
(1, 2, 2), 

(2, 3, 1), 
(2, 4, 4), 

(3, 1, 2), 
(3, 3, 2); 




SELECT
    t.id,
    t.name,
    SUM(CASE 
        WHEN s.score > opp.score THEN 1
        ELSE 0
    END) AS wins,
    SUM(CASE 
        WHEN s.score < opp.score THEN 1
        ELSE 0
    END) AS losses,
    SUM(CASE 
        WHEN s.score = opp.score THEN 1
        ELSE 0
    END) AS draws
FROM scores s
JOIN teams t ON s.team_id = t.id
JOIN scores opp ON 
    s.match_id = opp.match_id AND s.team_id != opp.team_id
GROUP BY t.id, t.name;




SELECT 
    t.name AS team,
    COUNT(*) AS matches_played,
    SUM(CASE WHEN s.score > opp.score THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN s.score < opp.score THEN 1 ELSE 0 END) AS losses,
    SUM(CASE WHEN s.score = opp.score THEN 1 ELSE 0 END) AS draws,
    SUM(s.score) AS goals_for,
    SUM(opp.score) AS goals_against,
    SUM(CASE 
        WHEN s.score > opp.score THEN 3
        WHEN s.score = opp.score THEN 1
        ELSE 0
    END) AS points
FROM scores s
JOIN teams t ON s.team_id = t.id
JOIN scores opp ON s.match_id = opp.match_id AND s.team_id != opp.team_id
GROUP BY t.id
ORDER BY points DESC, wins DESC, draws DESC;



SELECT 
    m.id AS match_id,
    m.match_date,
    t1.name AS team1,
    s1.score AS score1,
    t2.name AS team2,
    s2.score AS score2
FROM matches m
JOIN teams t1 ON m.team1_id = t1.id
JOIN teams t2 ON m.team2_id = t2.id
JOIN scores s1 ON m.id = s1.match_id AND s1.team_id = m.team1_id
JOIN scores s2 ON m.id = s2.match_id AND s2.team_id = m.team2_id
ORDER BY m.match_date;



