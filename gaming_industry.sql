-- ========================================================
-- SQL GAMING PROJECT
-- Projet d'analyse de l'industrie des jeux vidéo
-- Auteur: BEN OUATTARA
-- Date: Octobre 2025
-- ========================================================

-- Création de la base de données
-- DROP DATABASE IF EXISTS gaming_industry;
CREATE DATABASE gaming_industry CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gaming_industry;

-- ========================================================
-- TABLE 1: STUDIOS DE DÉVELOPPEMENT
-- ========================================================
CREATE TABLE studios (
    studio_id INT PRIMARY KEY AUTO_INCREMENT,
    studio_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    founded_year YEAR NOT NULL,
    employees_count INT,
    headquarters_city VARCHAR(100),
    INDEX idx_country (country),
    INDEX idx_founded_year (founded_year)
) ENGINE=InnoDB;

-- ========================================================
-- TABLE 2: ÉDITEURS DE JEUX
-- ========================================================

CREATE TABLE publishers (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(50) NOT NULL,
    founded_year SMALLINT NOT NULL,
    market_value_millions DECIMAL(10,2),
    INDEX idx_publisher_country (country)
) ENGINE=InnoDB;

-- ========================================================
-- TABLE 3: PLATEFORMES DE JEU
-- ========================================================
CREATE TABLE platforms (
    platform_id INT PRIMARY KEY AUTO_INCREMENT,
    platform_name VARCHAR(50) NOT NULL UNIQUE,
    manufacturer VARCHAR(50) NOT NULL,
    release_year YEAR NOT NULL,
    generation INT,
    platform_type ENUM('Console', 'PC', 'Mobile', 'Handheld') NOT NULL,
    INDEX idx_platform_type (platform_type)
) ENGINE=InnoDB;

-- ========================================================
-- TABLE 4: GENRES DE JEUX
-- ========================================================
CREATE TABLE genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
) ENGINE=InnoDB;

-- ========================================================
-- TABLE 5: JEUX VIDÉO (TABLE PRINCIPALE)
-- ========================================================
CREATE TABLE games (
    game_id INT PRIMARY KEY AUTO_INCREMENT,
    game_title VARCHAR(150) NOT NULL,
    studio_id INT NOT NULL,
    publisher_id INT NOT NULL,
    release_date DATE NOT NULL,
    genre_id INT NOT NULL,
    development_budget_millions DECIMAL(8,2),
    metacritic_score DECIMAL(3,1) CHECK (metacritic_score BETWEEN 0 AND 100),
    esrb_rating ENUM('E', 'E10+', 'T', 'M', 'AO', 'RP') NOT NULL,
    is_multiplayer BOOLEAN DEFAULT FALSE,
    is_free_to_play BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (studio_id) REFERENCES studios(studio_id),
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
    INDEX idx_release_date (release_date),
    INDEX idx_metacritic (metacritic_score)
) ENGINE=InnoDB;

-- ========================================================
-- TABLE 6: VENTES PAR PLATEFORME
-- ========================================================
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    game_id INT NOT NULL,
    platform_id INT NOT NULL,
    units_sold_millions DECIMAL(8,2) NOT NULL,
    revenue_millions DECIMAL(10,2) NOT NULL,
    region ENUM('North America', 'Europe', 'Asia', 'Other') NOT NULL,
    sale_year YEAR NOT NULL,
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    FOREIGN KEY (platform_id) REFERENCES platforms(platform_id),
    INDEX idx_sale_year (sale_year),
    INDEX idx_region (region)
) ENGINE=InnoDB;

-- ========================================================
-- TABLE 7: AVIS DES JOUEURS
-- ========================================================
CREATE TABLE user_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    game_id INT NOT NULL,
    platform_id INT NOT NULL,
    user_score DECIMAL(3,1) CHECK (user_score BETWEEN 0 AND 10),
    review_count INT NOT NULL,
    positive_reviews INT NOT NULL,
    negative_reviews INT NOT NULL,
    review_date DATE NOT NULL,
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    FOREIGN KEY (platform_id) REFERENCES platforms(platform_id),
    INDEX idx_user_score (user_score)
) ENGINE=InnoDB;

-- ========================================================
-- TABLE 8: RÉCOMPENSES ET NOMINATIONS
-- ========================================================
CREATE TABLE awards (
    award_id INT PRIMARY KEY AUTO_INCREMENT,
    game_id INT NOT NULL,
    award_name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    award_year YEAR NOT NULL,
    is_winner BOOLEAN NOT NULL,
    ceremony_name VARCHAR(100),
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    INDEX idx_award_year (award_year),
    INDEX idx_is_winner (is_winner)
) ENGINE=InnoDB;

-- ========================================================
-- TABLE 9: MISES À JOUR ET DLC
-- ========================================================
CREATE TABLE dlc_updates (
    dlc_id INT PRIMARY KEY AUTO_INCREMENT,
    game_id INT NOT NULL,
    dlc_name VARCHAR(150) NOT NULL,
    release_date DATE NOT NULL,
    price_usd DECIMAL(6,2),
    content_type ENUM('DLC', 'Expansion', 'Season Pass', 'Free Update') NOT NULL,
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    INDEX idx_content_type (content_type)
) ENGINE=InnoDB;

-- ========================================================
-- TABLE 10: COMMUNAUTÉ ET ENGAGEMENT
-- ========================================================
CREATE TABLE community_metrics (
    metric_id INT PRIMARY KEY AUTO_INCREMENT,
    game_id INT NOT NULL,
    platform_id INT NOT NULL,
    active_players_millions DECIMAL(8,2),
    peak_concurrent_players INT,
    twitch_avg_viewers INT,
    reddit_subscribers INT,
    measurement_date DATE NOT NULL,
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    FOREIGN KEY (platform_id) REFERENCES platforms(platform_id),
    INDEX idx_measurement_date (measurement_date)
) ENGINE=InnoDB;

-- Message de confirmation
SELECT 'Base de données créée avec succès!' AS Status;




-- ========================================================
-- INSERTION DES DONNÉES - SQL GAMING PROJECT
-- Auteur: BEN OUATTARA
-- ========================================================

USE gaming_industry;

-- ========================================================
-- INSERTION: STUDIOS DE DÉVELOPPEMENT
-- ========================================================
INSERT INTO studios (studio_name, country, founded_year, employees_count, headquarters_city) VALUES
('Naughty Dog', 'USA', 1984, 400, 'Santa Monica'),
('CD Projekt Red', 'Poland', 1994, 1200, 'Warsaw'),
('FromSoftware', 'Japan', 1986, 350, 'Tokyo'),
('Rockstar North', 'UK', 1988, 650, 'Edinburgh'),
('Guerrilla Games', 'Netherlands', 1997, 500, 'Amsterdam'),
('Insomniac Games', 'USA', 1994, 450, 'Burbank'),
('Santa Monica Studio', 'USA', 1999, 350, 'Los Angeles'),
('Bethesda Game Studios', 'USA', 2001, 450, 'Rockville'),
('Epic Games', 'USA', 1991, 1000, 'Cary'),
('Valve Corporation', 'USA', 1996, 360, 'Bellevue'),
('BioWare', 'Canada', 1995, 800, 'Edmonton'),
('Ubisoft Montreal', 'Canada', 1997, 4000, 'Montreal'),
('Nintendo EPD', 'Japan', 2015, 1500, 'Kyoto'),
('Capcom', 'Japan', 1979, 3000, 'Osaka'),
('Square Enix', 'Japan', 1986, 5000, 'Tokyo'),
('Bungie', 'USA', 1991, 900, 'Bellevue'),
('Respawn Entertainment', 'USA', 2010, 450, 'Los Angeles'),
('Obsidian Entertainment', 'USA', 2003, 250, 'Irvine'),
('Larian Studios', 'Belgium', 1996, 450, 'Ghent'),
('Riot Games', 'USA', 2006, 3000, 'Los Angeles'),
('Mojang Studios', 'Sweden', 2009, 600, 'Stockholm'),
('Kojima Productions', 'Japan', 2015, 100, 'Tokyo'),
('Remedy Entertainment', 'Finland', 1995, 300, 'Espoo'),
('Supergiant Games', 'USA', 2009, 25, 'San Francisco'),
('Team Cherry', 'Australia', 2014, 3, 'Adelaide');

-- ========================================================
-- INSERTION: ÉDITEURS
-- ========================================================
INSERT INTO publishers (publisher_name, country, founded_year, market_value_millions) VALUES
('Sony Interactive Entertainment', 'USA', 1993, 45000.00),
('Microsoft Gaming', 'USA', 2001, 68000.00),
('Nintendo', 'Japan', 1889, 55000.00),
('Electronic Arts', 'USA', 1982, 38000.00),
('Activision Blizzard', 'USA', 1979, 60000.00),
('Take-Two Interactive', 'USA', 1993, 28000.00),
('Ubisoft', 'France', 1986, 12000.00),
('CD Projekt', 'Poland', 1994, 8000.00),
('Bandai Namco', 'Japan', 2005, 22000.00),
('Capcom', 'Japan', 1979, 9500.00),
('Square Enix', 'Japan', 2003, 7200.00),
('Valve', 'USA', 1996, 10000.00),
('Epic Games', 'USA', 1991, 32000.00),
('Riot Games', 'USA', 2006, 21000.00),
('Private Division', 'USA', 2017, 500.00);

-- ========================================================
-- INSERTION: PLATEFORMES
-- ========================================================
INSERT INTO platforms (platform_name, manufacturer, release_year, generation, platform_type) VALUES
('PlayStation 5', 'Sony', 2020, 9, 'Console'),
('PlayStation 4', 'Sony', 2013, 8, 'Console'),
('Xbox Series X/S', 'Microsoft', 2020, 9, 'Console'),
('Xbox One', 'Microsoft', 2013, 8, 'Console'),
('Nintendo Switch', 'Nintendo', 2017, 8, 'Console'),
('PC', 'Various', 1980, NULL, 'PC'),
('iOS', 'Apple', 2007, NULL, 'Mobile'),
('Android', 'Google', 2008, NULL, 'Mobile'),
('PlayStation 3', 'Sony', 2006, 7, 'Console'),
('Xbox 360', 'Microsoft', 2005, 7, 'Console'),
('Nintendo Wii', 'Nintendo', 2006, 7, 'Console'),
('Steam Deck', 'Valve', 2022, 9, 'Handheld');

-- ========================================================
-- INSERTION: GENRES
-- ========================================================
INSERT INTO genres (genre_name, description) VALUES
('Action-Adventure', 'Mélange d''action et d''exploration avec une histoire narrative'),
('RPG', 'Jeu de rôle avec progression de personnage et choix narratifs'),
('First-Person Shooter', 'Jeu de tir à la première personne'),
('Open World', 'Monde ouvert avec exploration libre'),
('Platformer', 'Jeu de plateforme avec sauts et obstacles'),
('Fighting', 'Jeu de combat entre personnages'),
('Strategy', 'Jeu de stratégie et tactique'),
('Survival Horror', 'Jeu d''horreur avec gestion de ressources'),
('MOBA', 'Arène de bataille multijoueur en ligne'),
('Battle Royale', 'Dernier survivant dans un environnement fermé'),
('Sports', 'Simulation sportive'),
('Racing', 'Jeu de course automobile'),
('Puzzle', 'Jeu de réflexion et énigmes'),
('Simulation', 'Simulation réaliste d''activités'),
('Roguelike', 'Jeu avec mort permanente et niveaux procéduraux');

-- ========================================================
-- INSERTION: JEUX VIDÉO
-- ========================================================
INSERT INTO games (game_title, studio_id, publisher_id, release_date, genre_id, development_budget_millions, metacritic_score, esrb_rating, is_multiplayer, is_free_to_play) VALUES
('The Last of Us Part II', 1, 1, '2020-06-19', 1, 100.00, 93.0, 'M', FALSE, FALSE),
('Cyberpunk 2077', 2, 8, '2020-12-10', 2, 316.00, 86.0, 'M', TRUE, FALSE),
('Elden Ring', 3, 9, '2022-02-25', 2, 200.00, 96.0, 'M', TRUE, FALSE),
('Grand Theft Auto V', 4, 6, '2013-09-17', 4, 265.00, 97.0, 'M', TRUE, FALSE),
('Horizon Forbidden West', 5, 1, '2022-02-18', 1, 212.00, 88.0, 'T', FALSE, FALSE),
('Spider-Man: Miles Morales', 6, 1, '2020-11-12', 1, 156.00, 85.0, 'T', FALSE, FALSE),
('God of War Ragnarök', 7, 1, '2022-11-09', 1, 200.00, 94.0, 'M', FALSE, FALSE),
('Starfield', 8, 2, '2023-09-06', 2, 200.00, 83.0, 'M', FALSE, FALSE),
('Fortnite', 9, 13, '2017-07-25', 10, 125.00, 81.0, 'T', TRUE, TRUE),
('Counter-Strike 2', 10, 12, '2023-09-27', 3, 50.00, 87.0, 'M', TRUE, TRUE),
('Mass Effect Legendary Edition', 11, 4, '2021-05-14', 2, 100.00, 90.0, 'M', FALSE, FALSE),
('Assassin''s Creed Valhalla', 12, 7, '2020-11-10', 1, 450.00, 81.0, 'M', FALSE, FALSE),
('The Legend of Zelda: Tears of the Kingdom', 13, 3, '2023-05-12', 1, 150.00, 96.0, 'E10+', FALSE, FALSE),
('Resident Evil 4 Remake', 14, 10, '2023-03-24', 8, 112.00, 93.0, 'M', FALSE, FALSE),
('Final Fantasy XVI', 15, 11, '2023-06-22', 2, 200.00, 87.0, 'M', FALSE, FALSE),
('Destiny 2', 16, 1, '2017-09-06', 3, 140.00, 85.0, 'T', TRUE, FALSE),
('Apex Legends', 17, 4, '2019-02-04', 10, 90.00, 89.0, 'T', TRUE, TRUE),
('The Outer Worlds', 18, 15, '2019-10-25', 2, 50.00, 85.0, 'M', FALSE, FALSE),
('Baldur''s Gate 3', 19, 14, '2023-08-03', 2, 100.00, 96.0, 'M', TRUE, FALSE),
('League of Legends', 20, 14, '2009-10-27', 9, 80.00, NULL, 'T', TRUE, TRUE),
('Minecraft', 21, 2, '2011-11-18', 14, 10.00, 93.0, 'E10+', TRUE, FALSE),
('Death Stranding', 22, 1, '2019-11-08', 1, 80.00, 82.0, 'M', TRUE, FALSE),
('Control', 23, 15, '2019-08-27', 1, 30.00, 85.0, 'M', FALSE, FALSE),
('Hades', 24, 15, '2020-09-17', 15, 3.50, 93.0, 'T', FALSE, FALSE),
('Hollow Knight', 25, 15, '2017-02-24', 5, 0.40, 90.0, 'E10+', FALSE, FALSE),
('Red Dead Redemption 2', 4, 6, '2018-10-26', 1, 540.00, 97.0, 'M', TRUE, FALSE),
('The Witcher 3: Wild Hunt', 2, 8, '2015-05-19', 2, 81.00, 92.0, 'M', FALSE, FALSE),
('Dark Souls III', 3, 9, '2016-04-12', 2, 75.00, 89.0, 'M', TRUE, FALSE),
('Overwatch 2', 5, 5, '2022-10-04', 3, 165.00, 79.0, 'T', TRUE, TRUE),
('Call of Duty: Modern Warfare II', 6, 5, '2022-10-28', 3, 250.00, 75.0, 'M', TRUE, FALSE);

-- ========================================================
-- INSERTION: VENTES PAR PLATEFORME
-- ========================================================
INSERT INTO sales (game_id, platform_id, units_sold_millions, revenue_millions, region, sale_year) VALUES
-- The Last of Us Part II
(91, 2, 4.2, 251.00, 'North America', 2020),
(91, 2, 3.8, 227.00, 'Europe', 2020),
(91, 2, 2.1, 125.00, 'Asia', 2020),
-- Cyberpunk 2077
(92, 6, 8.5, 425.00, 'North America', 2020),
(92, 6, 6.2, 310.00, 'Europe', 2020),
(92, 2, 3.1, 155.00, 'North America', 2020),
(92, 4, 2.8, 140.00, 'North America', 2020),
-- Elden Ring
(93, 1, 5.2, 312.00, 'North America', 2022),
(93, 6, 7.8, 468.00, 'North America', 2022),
(93, 1, 4.5, 270.00, 'Europe', 2022),
(93, 1, 3.2, 192.00, 'Asia', 2022),
-- GTA V
(94, 2, 25.3, 1518.00, 'North America', 2015),
(94, 9, 18.7, 1122.00, 'North America', 2013),
(94, 6, 32.5, 1950.00, 'North America', 2016),
(94, 4, 20.1, 1206.00, 'North America', 2015),
(94, 2, 19.8, 1188.00, 'Europe', 2015),
(94, 6, 28.3, 1698.00, 'Europe', 2016),
-- Horizon Forbidden West
(95, 1, 4.8, 336.00, 'North America', 2022),
(95, 2, 2.3, 161.00, 'North America', 2022),
(95, 1, 4.1, 287.00, 'Europe', 2022),
-- Spider-Man: Miles Morales
(96, 1, 3.9, 195.00, 'North America', 2021),
(96, 2, 2.8, 140.00, 'North America', 2021),
(96, 1, 3.2, 160.00, 'Europe', 2021),
-- God of War Ragnarök
(97, 1, 5.1, 357.00, 'North America', 2022),
(97, 2, 3.4, 238.00, 'North America', 2022),
(97, 1, 4.3, 301.00, 'Europe', 2022),
(97, 1, 1.8, 126.00, 'Asia', 2022),
-- Starfield
(98, 6, 4.2, 294.00, 'North America', 2023),
(98, 3, 2.8, 196.00, 'North America', 2023),
-- Fortnite (Free-to-play revenue)
(99, 6, 350.0, 5600.00, 'North America', 2022),
(99, 1, 125.0, 2000.00, 'North America', 2022),
(99, 5, 85.0, 1360.00, 'North America', 2022),
(99, 7, 210.0, 3360.00, 'North America', 2022),
-- Counter-Strike 2
(100, 6, 27.5, 1100.00, 'North America', 2023),
(100, 6, 32.1, 1284.00, 'Europe', 2023),
(100, 6, 18.7, 748.00, 'Asia', 2023),
-- Zelda: Tears of the Kingdom
(103, 5, 12.8, 768.00, 'North America', 2023),
(103, 5, 9.5, 570.00, 'Europe', 2023),
(103, 5, 8.2, 492.00, 'Asia', 2023),
-- Resident Evil 4 Remake
(104, 1, 3.2, 192.00, 'North America', 2023),
(104, 6, 2.8, 168.00, 'North America', 2023),
(104, 1, 2.5, 150.00, 'Europe', 2023),
-- Baldur's Gate 3
(109, 6, 8.5, 510.00, 'North America', 2023),
(109, 6, 6.8, 408.00, 'Europe', 2023),
(109, 1, 2.1, 126.00, 'North America', 2023),
-- Minecraft
(111, 6, 45.0, 1350.00, 'North America', 2020),
(111, 5, 23.5, 705.00, 'North America', 2020),
(111, 7, 38.2, 573.00, 'North America', 2020),
(111, 8, 42.5, 637.50, 'North America', 2020),
-- Red Dead Redemption 2
(116, 2, 17.5, 1050.00, 'North America', 2018),
(116, 4, 14.2, 852.00, 'North America', 2018),
(116, 6, 12.8, 768.00, 'North America', 2019),
(116, 2, 15.3, 918.00, 'Europe', 2018),
-- The Witcher 3
(117, 6, 15.2, 456.00, 'North America', 2016),
(117, 2, 8.5, 255.00, 'Europe', 2015),
(117, 5, 4.3, 129.00, 'North America', 2019),
-- Call of Duty MW II
(120, 1, 8.2, 574.00, 'North America', 2022),
(120, 6, 6.5, 455.00, 'North America', 2022),
(120, 3, 5.8, 406.00, 'North America', 2022);

-- ========================================================
-- INSERTION: AVIS DES JOUEURS
-- ========================================================
INSERT INTO user_reviews (game_id, platform_id, user_score, review_count, positive_reviews, negative_reviews, review_date) VALUES
(91, 2, 5.7, 152000, 75000, 77000, '2020-12-31'),
(92, 6, 7.1, 98000, 65000, 33000, '2021-06-30'),
(93, 6, 9.2, 125000, 118000, 7000, '2022-12-31'),
(94, 6, 8.8, 342000, 310000, 32000, '2021-12-31'),
(97, 1, 9.1, 87000, 82000, 5000, '2023-03-31'),
(103, 5, 9.4, 145000, 139000, 6000, '2023-12-31'),
(109, 6, 9.3, 156000, 148000, 8000, '2023-12-31'),
(111, 6, 8.5, 425000, 375000, 50000, '2022-12-31'),
(116, 6, 9.0, 198000, 185000, 13000, '2019-12-31'),
(117, 6, 9.3, 287000, 272000, 15000, '2020-12-31');

-- ========================================================
-- INSERTION: RÉCOMPENSES
-- ========================================================
INSERT INTO awards (game_id, award_name, category, award_year, is_winner, ceremony_name) VALUES
(91, 'Game of the Year', 'GOTY', 2020, TRUE, 'The Game Awards'),
(91, 'Best Narrative', 'Story', 2020, TRUE, 'The Game Awards'),
(91, 'Best Performance', 'Acting', 2020, TRUE, 'The Game Awards'),
(93, 'Game of the Year', 'GOTY', 2022, TRUE, 'The Game Awards'),
(93, 'Best RPG', 'Genre', 2022, TRUE, 'The Game Awards'),
(93, 'Best Art Direction', 'Visual', 2022, TRUE, 'The Game Awards'),
(97, 'Game of the Year', 'GOTY', 2022, FALSE, 'The Game Awards'),
(97, 'Best Narrative', 'Story', 2022, TRUE, 'The Game Awards'),
(103, 'Game of the Year', 'GOTY', 2023, TRUE, 'The Game Awards'),
(103, 'Best Action/Adventure', 'Genre', 2023, TRUE, 'The Game Awards'),
(109, 'Game of the Year', 'GOTY', 2023, FALSE, 'The Game Awards'),
(109, 'Best RPG', 'Genre', 2023, TRUE, 'The Game Awards'),
(109, 'Best Multiplayer', 'Feature', 2023, TRUE, 'The Game Awards'),
(114, 'Best Indie Game', 'Indie', 2020, TRUE, 'The Game Awards'),
(114, 'Best Action Game', 'Genre', 2020, TRUE, 'The Game Awards'),
(116, 'Game of the Year', 'GOTY', 2018, FALSE, 'The Game Awards'),
(116, 'Best Narrative', 'Story', 2018, TRUE, 'The Game Awards'),
(116, 'Best Audio Design', 'Technical', 2018, TRUE, 'The Game Awards');

-- ========================================================
-- INSERTION: DLC ET MISES À JOUR
-- ========================================================
INSERT INTO dlc_updates (game_id, dlc_name, release_date, price_usd, content_type) VALUES
(92, 'Phantom Liberty', '2023-09-26', 29.99, 'Expansion'),
(94, 'The Cayo Perico Heist', '2020-12-15', 0.00, 'Free Update'),
(97, 'Valhalla', '2023-04-20', 0.00, 'Free Update'),
(103, 'Master Mode', '2023-07-06', 0.00, 'Free Update'),
(109, 'Patch 1 - Expanded Content', '2023-09-21', 0.00, 'Free Update'),
(111, 'Caves & Cliffs Update', '2021-06-08', 0.00, 'Free Update'),
(116, 'Online Content Update', '2019-09-10', 0.00, 'Free Update'),
(117, 'Blood and Wine', '2016-05-31', 19.99, 'Expansion'),
(117, 'Hearts of Stone', '2015-10-13', 9.99, 'Expansion');

-- ========================================================
-- INSERTION: MÉTRIQUES COMMUNAUTÉ
-- ========================================================
INSERT INTO community_metrics (game_id, platform_id, active_players_millions, peak_concurrent_players, twitch_avg_viewers, reddit_subscribers, measurement_date) VALUES
(93, 6, 1.2, 953426, 45000, 1800000, '2023-12-01'),
(94, 6, 1.8, 364215, 85000, 4200000, '2023-12-01'),
(99, 6, 42.5, 6274000, 125000, 2500000, '2023-12-01'),
(100, 6, 28.3, 1818845, 310000, 1300000, '2023-12-01'),
(103, 5, 8.5, NULL, 52000, 1200000, '2023-12-01'),
(109, 6, 3.8, 875432, 98000, 950000, '2023-12-01'),
(110, 6, 150.0, 8000000, 185000, 7200000, '2023-12-01'),
(111, 6, 180.0, 2750000, 48000, 8500000, '2023-12-01');

SELECT 'Données insérées avec succès!' AS Status,
       (SELECT COUNT(*) FROM games) AS 'Nombre de jeux',
       (SELECT COUNT(*) FROM sales) AS 'Enregistrements de ventes',
       (SELECT COUNT(*) FROM studios) AS 'Studios';
       
       
       
       
       
-- ========================================================
-- ANALYSES SQL - SQL GAMING PROJECT
-- Auteur: BEN OUATTARA
-- 
-- Ce fichier contient des analyses approfondies de l'industrie
-- des jeux vidéo avec des requêtes SQL variées et complexes.
-- Chaque analyse est expliquée pour être compréhensible
-- par tous, même les novices du gaming.
-- ========================================================

USE gaming_industry;

-- ========================================================
-- ANALYSE 1: TOP 10 DES JEUX LES PLUS VENDUS
-- ========================================================
-- Cette requête identifie les jeux qui ont généré le plus de ventes
-- en termes d'unités vendues à travers toutes les plateformes

SELECT 
    g.game_title AS 'Nom du Jeu',
    s.studio_name AS 'Studio',
    SUM(sa.units_sold_millions) AS 'Ventes Totales (Millions)',
    SUM(sa.revenue_millions) AS 'Revenus Totaux (Millions $)',
    ROUND(AVG(g.metacritic_score), 1) AS 'Score Metacritic',
    YEAR(g.release_date) AS 'Année de Sortie'
FROM games g
JOIN studios s ON g.studio_id = s.studio_id
JOIN sales sa ON g.game_id = sa.game_id
GROUP BY g.game_id, g.game_title, s.studio_name, g.metacritic_score, g.release_date
ORDER BY SUM(sa.units_sold_millions) DESC
LIMIT 10;

-- INTERPRÉTATION:
-- Cette analyse montre les jeux qui ont le plus de succès commercial.
-- Un jeu qui vend beaucoup n'est pas toujours le mieux noté!


-- ========================================================
-- ANALYSE 2: PERFORMANCE DES GENRES PAR REVENUS
-- ========================================================
-- Analyse pour comprendre quels types de jeux rapportent le plus d'argent

SELECT 
    ge.genre_name AS 'Genre',
    COUNT(DISTINCT g.game_id) AS 'Nombre de Jeux',
    SUM(sa.revenue_millions) AS 'Revenus Totaux (Millions $)',
    ROUND(AVG(sa.revenue_millions), 2) AS 'Revenu Moyen par Jeu (Millions $)',
    ROUND(AVG(g.metacritic_score), 1) AS 'Score Moyen Metacritic',
    SUM(sa.units_sold_millions) AS 'Ventes Totales (Millions)'
FROM genres ge
JOIN games g ON ge.genre_id = g.genre_id
JOIN sales sa ON g.game_id = sa.game_id
GROUP BY ge.genre_id, ge.genre_name
ORDER BY SUM(sa.revenue_millions) DESC;

-- INTERPRÉTATION:
-- Certains genres comme les jeux "Open World" ou "Battle Royale" 
-- peuvent générer énormément de revenus grâce à leur rejouabilité
-- et leurs achats dans le jeu (microtransactions).


-- ========================================================
-- ANALYSE 3: COMPARAISON PLATEFORMES - QUELLE CONSOLE DOMINE?
-- ========================================================
-- Analyse des ventes par plateforme pour voir où les joueurs préfèrent jouer

SELECT 
    p.platform_name AS 'Plateforme',
    p.platform_type AS 'Type',
    COUNT(DISTINCT sa.game_id) AS 'Nombre de Jeux Disponibles',
    SUM(sa.units_sold_millions) AS 'Ventes Totales (Millions)',
    SUM(sa.revenue_millions) AS 'Revenus Totaux (Millions $)',
    ROUND(AVG(sa.revenue_millions), 2) AS 'Revenu Moyen (Millions $)'
FROM platforms p
JOIN sales sa ON p.platform_id = sa.platform_id
GROUP BY p.platform_id, p.platform_name, p.platform_type
ORDER BY SUM(sa.revenue_millions) DESC;

-- INTERPRÉTATION:
-- Le PC domine souvent grâce aux jeux free-to-play et à une large bibliothèque.
-- Les consoles PlayStation et Xbox se battent pour la deuxième place.
-- Le mobile peut surprendre avec des revenus élevés malgré des jeux moins chers!


-- ========================================================
-- ANALYSE 4: STUDIOS LES PLUS PERFORMANTS
-- ========================================================
-- Identifie les studios qui créent les jeux les plus rentables et les mieux notés

SELECT 
    s.studio_name AS 'Studio de Développement',
    s.country AS 'Pays',
    s.employees_count AS 'Nombre d''Employés',
    COUNT(DISTINCT g.game_id) AS 'Jeux Développés',
    SUM(sa.revenue_millions) AS 'Revenus Totaux (Millions $)',
    ROUND(AVG(g.metacritic_score), 1) AS 'Score Moyen Metacritic',
    SUM(sa.units_sold_millions) AS 'Ventes Totales (Millions)'
FROM studios s
JOIN games g ON s.studio_id = g.studio_id
JOIN sales sa ON g.game_id = sa.game_id
GROUP BY s.studio_id, s.studio_name, s.country, s.employees_count
HAVING COUNT(DISTINCT g.game_id) >= 1
ORDER BY SUM(sa.revenue_millions) DESC
LIMIT 15;

-- INTERPRÉTATION:
-- Les grands studios comme Rockstar peuvent générer des milliards avec peu de jeux
-- tandis que d'autres studios produisent plus mais gagnent moins par titre.


-- ========================================================
-- ANALYSE 5: RETOUR SUR INVESTISSEMENT (ROI)
-- ========================================================
-- Calcule le rapport entre budget de développement et revenus générés

SELECT 
    g.game_title AS 'Nom du Jeu',
    s.studio_name AS 'Studio',
    g.development_budget_millions AS 'Budget (Millions $)',
    SUM(sa.revenue_millions) AS 'Revenus (Millions $)',
    ROUND(
        (SUM(sa.revenue_millions) - g.development_budget_millions) / g.development_budget_millions * 100, 
        2
    ) AS 'ROI (%)',
    CASE 
        WHEN (SUM(sa.revenue_millions) - g.development_budget_millions) / g.development_budget_millions * 100 > 1000 
            THEN 'Énorme Succès 🚀'
        WHEN (SUM(sa.revenue_millions) - g.development_budget_millions) / g.development_budget_millions * 100 > 500 
            THEN 'Grand Succès ⭐'
        WHEN (SUM(sa.revenue_millions) - g.development_budget_millions) / g.development_budget_millions * 100 > 100 
            THEN 'Rentable ✓'
        ELSE 'Peu Rentable'
    END AS 'Évaluation'
FROM games g
JOIN studios s ON g.studio_id = s.studio_id
JOIN sales sa ON g.game_id = sa.game_id
WHERE g.development_budget_millions IS NOT NULL
GROUP BY g.game_id, g.game_title, s.studio_name, g.development_budget_millions
ORDER BY ROUND(
        (SUM(sa.revenue_millions) - g.development_budget_millions) / g.development_budget_millions * 100, 
        2
    ) DESC
LIMIT 15;

-- INTERPRÉTATION:
-- Le ROI montre quels jeux ont le mieux rentabilisé leur investissement.
-- Un petit jeu indépendant peut avoir un meilleur ROI qu'un AAA avec un énorme budget!


-- ========================================================
-- ANALYSE 6: ÉVOLUTION DES VENTES PAR ANNÉE
-- ========================================================
-- Tendances annuelles de l'industrie du jeu vidéo

SELECT 
    sa.sale_year AS 'Année',
    COUNT(DISTINCT g.game_id) AS 'Jeux Vendus',
    SUM(sa.units_sold_millions) AS 'Ventes Totales (Millions)',
    SUM(sa.revenue_millions) AS 'Revenus Totaux (Millions $)',
    ROUND(AVG(g.metacritic_score), 1) AS 'Score Moyen des Jeux',
    ROUND(SUM(sa.revenue_millions) / SUM(sa.units_sold_millions), 2) AS 'Prix Moyen par Unité ($)'
FROM sales sa
JOIN games g ON sa.game_id = g.game_id
WHERE g.metacritic_score IS NOT NULL
GROUP BY sa.sale_year
ORDER BY sa.sale_year DESC;

-- INTERPRÉTATION:
-- On peut voir si l'industrie est en croissance ou en baisse.
-- Le prix moyen par jeu peut augmenter avec les éditions deluxe et DLC.


-- ========================================================
-- ANALYSE 7: PERFORMANCE RÉGIONALE - OÙ LES JEUX SE VENDENT LE MIEUX?
-- ========================================================

SELECT 
    sa.region AS 'Région',
    COUNT(DISTINCT g.game_id) AS 'Jeux Vendus',
    SUM(sa.units_sold_millions) AS 'Ventes (Millions)',
    SUM(sa.revenue_millions) AS 'Revenus (Millions $)',
    ROUND(AVG(sa.revenue_millions), 2) AS 'Revenu Moyen (Millions $)',
    ROUND(SUM(sa.revenue_millions) / SUM(sa.units_sold_millions), 2) AS 'Prix Moyen ($)'
FROM sales sa
JOIN games g ON sa.game_id = g.game_id
GROUP BY sa.region
ORDER BY SUM(sa.revenue_millions) DESC;

-- INTERPRÉTATION:
-- L'Amérique du Nord domine souvent les ventes en valeur.
-- L'Asie peut avoir plus de joueurs mais avec des prix plus bas.
-- L'Europe est un marché très important et diversifié.


-- ========================================================
-- ANALYSE 8: CORRÉLATION NOTES CRITIQUES VS VENTES
-- ========================================================
-- Est-ce que les jeux bien notés se vendent mieux?

SELECT 
    CASE 
        WHEN g.metacritic_score >= 90 THEN '90-100 (Chef-d''œuvre)'
        WHEN g.metacritic_score >= 80 THEN '80-89 (Excellent)'
        WHEN g.metacritic_score >= 70 THEN '70-79 (Bon)'
        WHEN g.metacritic_score >= 60 THEN '60-69 (Moyen)'
        ELSE '0-59 (Faible)'
    END AS 'Tranche de Score',
    COUNT(DISTINCT g.game_id) AS 'Nombre de Jeux',
    ROUND(AVG(g.metacritic_score), 1) AS 'Score Moyen',
    SUM(sa.units_sold_millions) AS 'Ventes Totales (Millions)',
    ROUND(AVG(sa.units_sold_millions), 2) AS 'Ventes Moyennes par Jeu (Millions)',
    SUM(sa.revenue_millions) AS 'Revenus Totaux (Millions $)'
FROM games g
JOIN sales sa ON g.game_id = sa.game_id
WHERE g.metacritic_score IS NOT NULL
GROUP BY CASE 
        WHEN g.metacritic_score >= 90 THEN '90-100 (Chef-d''œuvre)'
        WHEN g.metacritic_score >= 80 THEN '80-89 (Excellent)'
        WHEN g.metacritic_score >= 70 THEN '70-79 (Bon)'
        WHEN g.metacritic_score >= 60 THEN '60-69 (Moyen)'
        ELSE '0-59 (Faible)'
    END
ORDER BY AVG(g.metacritic_score) DESC;

-- INTERPRÉTATION:
-- Attention! Un bon score aide, mais le marketing, la franchise 
-- et le bouche-à-oreille comptent aussi énormément.


-- ========================================================
-- ANALYSE 9: JEUX MULTIJOUEUR VS SOLO - QUI GAGNE?
-- ========================================================

SELECT 
    CASE 
        WHEN g.is_multiplayer = TRUE AND g.is_free_to_play = TRUE THEN 'Multijoueur Gratuit'
        WHEN g.is_multiplayer = TRUE AND g.is_free_to_play = FALSE THEN 'Multijoueur Payant'
        ELSE 'Solo / Story'
    END AS 'Catégorie',
    COUNT(DISTINCT g.game_id) AS 'Nombre de Jeux',
    SUM(sa.units_sold_millions) AS 'Ventes (Millions)',
    SUM(sa.revenue_millions) AS 'Revenus (Millions $)',
    ROUND(AVG(sa.revenue_millions), 2) AS 'Revenu Moyen par Jeu (Millions $)',
    ROUND(AVG(g.metacritic_score), 1) AS 'Score Moyen'
FROM games g
JOIN sales sa ON g.game_id = sa.game_id
GROUP BY CASE 
        WHEN g.is_multiplayer = TRUE AND g.is_free_to_play = TRUE THEN 'Multijoueur Gratuit'
        WHEN g.is_multiplayer = TRUE AND g.is_free_to_play = FALSE THEN 'Multijoueur Payant'
        ELSE 'Solo / Story'
    END
ORDER BY SUM(sa.revenue_millions) DESC;

-- INTERPRÉTATION:
-- Les jeux free-to-play multijoueur peuvent générer des revenus colossaux
-- grâce aux microtransactions (skins, battle pass, etc.).
-- Les jeux solo restent très rentables avec moins de coûts de maintenance.


-- ========================================================
-- ANALYSE 10: IMPACT DES RÉCOMPENSES SUR LES VENTES
-- ========================================================
-- Les Game of the Year Awards augmentent-ils vraiment les ventes?

SELECT 
    g.game_title AS 'Nom du Jeu',
    COUNT(DISTINCT a.award_id) AS 'Nombre de Récompenses',
    SUM(CASE WHEN a.is_winner = TRUE THEN 1 ELSE 0 END) AS 'Victoires',
    SUM(CASE WHEN a.is_winner = FALSE THEN 1 ELSE 0 END) AS 'Nominations',
    SUM(sa.units_sold_millions) AS 'Ventes (Millions)',
    SUM(sa.revenue_millions) AS 'Revenus (Millions $)',
    g.metacritic_score AS 'Score Metacritic'
FROM games g
LEFT JOIN awards a ON g.game_id = a.game_id
JOIN sales sa ON g.game_id = sa.game_id
GROUP BY g.game_id, g.game_title, g.metacritic_score
HAVING COUNT(DISTINCT a.award_id) > 0
ORDER BY COUNT(DISTINCT a.award_id) DESC;

-- INTERPRÉTATION:
-- Les récompenses donnent de la visibilité et peuvent relancer les ventes.
-- Un "GOTY" (Game of the Year) est le Saint Graal pour un développeur!


-- ========================================================
-- ANALYSE 11: PAYS DES STUDIOS LES PLUS PERFORMANTS
-- ========================================================

SELECT 
    s.country AS 'Pays',
    COUNT(DISTINCT s.studio_id) AS 'Nombre de Studios',
    COUNT(DISTINCT g.game_id) AS 'Jeux Produits',
    SUM(sa.revenue_millions) AS 'Revenus Totaux (Millions $)',
    ROUND(AVG(g.metacritic_score), 1) AS 'Score Moyen Metacritic',
    SUM(sa.units_sold_millions) AS 'Ventes Totales (Millions)'
FROM studios s
JOIN games g ON s.studio_id = g.studio_id
JOIN sales sa ON g.game_id = sa.game_id
GROUP BY s.country
ORDER BY SUM(sa.revenue_millions) DESC;

-- INTERPRÉTATION:
-- Les USA et le Japon dominent historiquement l'industrie.
-- La Pologne (CD Projekt) et d'autres pays européens montent en puissance!


-- ========================================================
-- ANALYSE 12: ANALYSE DE LA COMMUNAUTÉ - ENGAGEMENT DES JOUEURS
-- ========================================================

SELECT 
    g.game_title AS 'Nom du Jeu',
    cm.active_players_millions AS 'Joueurs Actifs (Millions)',
    cm.peak_concurrent_players AS 'Pic de Joueurs Simultanés',
    cm.twitch_avg_viewers AS 'Spectateurs Twitch Moyens',
    cm.reddit_subscribers AS 'Abonnés Reddit',
    g.is_free_to_play AS 'Gratuit?',
    YEAR(g.release_date) AS 'Année de Sortie'
FROM community_metrics cm
JOIN games g ON cm.game_id = g.game_id
ORDER BY cm.active_players_millions DESC;

-- INTERPRÉTATION:
-- L'engagement communautaire montre la longévité d'un jeu.
-- Twitch et Reddit sont des indicateurs clés de popularité actuelle.
-- Les jeux service (live games) maintiennent des millions de joueurs pendant des années!


-- ========================================================
-- ANALYSE 13: PRIX MOYEN DES JEUX PAR PLATEFORME
-- ========================================================

SELECT 
    p.platform_name AS 'Plateforme',
    p.platform_type AS 'Type',
    COUNT(DISTINCT sa.game_id) AS 'Jeux Analysés',
    ROUND(AVG(sa.revenue_millions / sa.units_sold_millions), 2) AS 'Prix Moyen par Copie ($)',
    MIN(sa.revenue_millions / sa.units_sold_millions) AS 'Prix Min ($)',
    MAX(sa.revenue_millions / sa.units_sold_millions) AS 'Prix Max ($)'
FROM platforms p
JOIN sales sa ON p.platform_id = sa.platform_id
WHERE sa.units_sold_millions > 0
GROUP BY p.platform_id, p.platform_name, p.platform_type
ORDER BY ROUND(AVG(sa.revenue_millions / sa.units_sold_millions), 2) DESC;

-- INTERPRÉTATION:
-- Le mobile a souvent un prix moyen bas (jeux gratuits avec achats intégrés).
-- Les consoles et PC ont des prix plus élevés pour les jeux AAA.


-- ========================================================
-- ANALYSE 14: JEUX AVEC LE MEILLEUR RAPPORT QUALITÉ/BUDGET
-- ========================================================

SELECT 
    g.game_title AS 'Nom du Jeu',
    s.studio_name AS 'Studio',
    g.development_budget_millions AS 'Budget (Millions $)',
    g.metacritic_score AS 'Score Metacritic',
    ROUND(g.metacritic_score / g.development_budget_millions, 2) AS 'Score par Million de Budget',
    SUM(sa.units_sold_millions) AS 'Ventes (Millions)'
FROM games g
JOIN studios s ON g.studio_id = s.studio_id
JOIN sales sa ON g.game_id = sa.game_id
WHERE g.development_budget_millions IS NOT NULL 
  AND g.metacritic_score IS NOT NULL
GROUP BY g.game_id, g.game_title, s.studio_name, g.development_budget_millions, g.metacritic_score
ORDER BY ROUND(g.metacritic_score / g.development_budget_millions, 2) DESC
LIMIT 10;

-- INTERPRÉTATION:
-- Les jeux indépendants (indie) excellent souvent ici!
-- Avec peu de moyens, ils créent des expériences de haute qualité.
-- Hollow Knight est un exemple parfait: 400k$ de budget, 90 de score!


-- ========================================================
-- ANALYSE 15: COMPARAISON AVIS CRITIQUES VS AVIS JOUEURS
-- ========================================================

SELECT 
    g.game_title AS 'Nom du Jeu',
    g.metacritic_score AS 'Note Critiques (100)',
    ur.user_score AS 'Note Joueurs (10)',
    ur.user_score * 10 AS 'Note Joueurs (100)',
    ROUND(g.metacritic_score - (ur.user_score * 10), 1) AS 'Différence',
    ur.positive_reviews AS 'Avis Positifs',
    ur.negative_reviews AS 'Avis Négatifs',
    ROUND(ur.positive_reviews / (ur.positive_reviews + ur.negative_reviews) * 100, 1) AS '% Positif',
    CASE 
        WHEN ABS(g.metacritic_score - (ur.user_score * 10)) < 5 THEN 'Accord Parfait ✓'
        WHEN g.metacritic_score - (ur.user_score * 10) > 10 THEN 'Critiques Plus Positifs'
        WHEN (ur.user_score * 10) - g.metacritic_score > 10 THEN 'Joueurs Plus Positifs'
        ELSE 'Léger Désaccord'
    END AS 'Consensus'
FROM games g
JOIN user_reviews ur ON g.game_id = ur.game_id
WHERE g.metacritic_score IS NOT NULL
ORDER BY ABS(g.metacritic_score - (ur.user_score * 10)) DESC;

-- INTERPRÉTATION:
-- Parfois, les critiques et joueurs ne sont pas d'accord!
-- The Last of Us Part II est un exemple célèbre de division d'opinions.
-- Un grand écart peut indiquer une controverse ou des attentes déçues.

