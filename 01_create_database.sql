-- ========================================================
-- SQL GAMING PROJECT
-- Projet d'analyse de l'industrie des jeux vidéo
-- Auteur: BEN OUATTARA
-- Date: Février 2026
-- ========================================================

-- Création de la base de données
DROP DATABASE IF EXISTS gaming_industry;
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
    founded_year YEAR NOT NULL,
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
