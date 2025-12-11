CREATE DATABASE IF NOT EXISTS ctf;
USE ctf;

CREATE TABLE ctf.users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

INSERT INTO users (username, password) VALUES 
('Eleven', 'Waffles@011'),
('Hopper', 'CoffeeAndContemplation'),
('Mike', 'DungeonMaster83'),
('Dustin', 'CompassGenius'),
('Lucas', 'WristRocketMaster'),
('Nancy', 'NancyWheeler1983'),
('Jonathan', 'Photographer1983'),
('Steve', 'HairSpray&Bat!1984'),
('Max', 'KateBush&Headphones!1986'),
('Will', 'WizardWill#CastleByers');
