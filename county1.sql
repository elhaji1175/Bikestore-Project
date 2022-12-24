CREATE DATABASE moha_training;
SHOW DATABASES;

SHOW TABLES;

SHOW TABLES;
DESCRIBE persons;
INSERT INTO persons (lastname, firstname, adress, city)
VALUES("Muller","Thomas","0100","Munich")
INSERT INTO persons (person_id, lastname, firstname, adress, city)
VALUES(1,"Doe","Jane","0234","Nairobi"),
(2,"james","Joe","1234","Thika")
SELECT COUNT(*) FROM persons;
SELECT * FROM persons;
SELECT city FROM persons;
SELECT DISTINCT city FROM persons;

CREATE TABLE notified_birth_census(id INT NOT NULL AUTO_INCREMENT,
county_name VARCHAR(155),
total_births INT,
notified_births INT,
dont_know INT,
not_stated INT,
percent_notified DECIMAL(5,2),
PRIMARY KEY(id)
);
DESCRIBE notified_birth_census;
INSERT INTO notified_birth_census (county_name, total_births, notified_births, dont_know, not_stated, percent_notified)
VALUES
('MOMBASA', 134567, 234563, 435671, 35, 90.4),
('GARISSA', 234567, 435621, 234567, 20, 87.5),
('NAIROBI', 654321, 345673, 34567, 15, 82.6),
('TANARIVER', 45321, 23456, 12345, 10, 76.5),
('LAMU', 12354, 43568, 34521, NULL, 73.1);
SELECT county_name, total_births
FROM notified_birth_census
ORDER BY total_births;
SELECT county_name, total_births
FROM notified_birth_census
ORDER BY county_name;
SELECT county_name, total_births FROM notified_birth_census WHERE county_name = "NAIROBI";
SELECT county_name, total_births FROM notified_birth_census WHERE not_stated = 15;