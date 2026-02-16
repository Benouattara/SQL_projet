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
('Destiny 2', 16, 16, '2017-09-06', 3, 140.00, 85.0, 'T', TRUE, FALSE),
('Apex Legends', 17, 4, '2019-02-04', 10, 90.00, 89.0, 'T', TRUE, TRUE),
('The Outer Worlds', 18, 15, '2019-10-25', 2, 50.00, 85.0, 'M', FALSE, FALSE),
('Baldur''s Gate 3', 19, 19, '2023-08-03', 2, 100.00, 96.0, 'M', TRUE, FALSE),
('League of Legends', 20, 14, '2009-10-27', 9, 80.00, NULL, 'T', TRUE, TRUE),
('Minecraft', 21, 2, '2011-11-18', 14, 10.00, 93.0, 'E10+', TRUE, FALSE),
('Death Stranding', 22, 1, '2019-11-08', 1, 80.00, 82.0, 'M', TRUE, FALSE),
('Control', 23, 15, '2019-08-27', 1, 30.00, 85.0, 'M', FALSE, FALSE),
('Hades', 24, 24, '2020-09-17', 15, 3.50, 93.0, 'T', FALSE, FALSE),
('Hollow Knight', 25, 25, '2017-02-24', 5, 0.40, 90.0, 'E10+', FALSE, FALSE),
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
(1, 2, 4.2, 251.00, 'North America', 2020),
(1, 2, 3.8, 227.00, 'Europe', 2020),
(1, 2, 2.1, 125.00, 'Asia', 2020),
-- Cyberpunk 2077
(2, 6, 8.5, 425.00, 'North America', 2020),
(2, 6, 6.2, 310.00, 'Europe', 2020),
(2, 2, 3.1, 155.00, 'North America', 2020),
(2, 4, 2.8, 140.00, 'North America', 2020),
-- Elden Ring
(3, 1, 5.2, 312.00, 'North America', 2022),
(3, 6, 7.8, 468.00, 'North America', 2022),
(3, 1, 4.5, 270.00, 'Europe', 2022),
(3, 1, 3.2, 192.00, 'Asia', 2022),
-- GTA V
(4, 2, 25.3, 1518.00, 'North America', 2015),
(4, 9, 18.7, 1122.00, 'North America', 2013),
(4, 6, 32.5, 1950.00, 'North America', 2016),
(4, 4, 20.1, 1206.00, 'North America', 2015),
(4, 2, 19.8, 1188.00, 'Europe', 2015),
(4, 6, 28.3, 1698.00, 'Europe', 2016),
-- Horizon Forbidden West
(5, 1, 4.8, 336.00, 'North America', 2022),
(5, 2, 2.3, 161.00, 'North America', 2022),
(5, 1, 4.1, 287.00, 'Europe', 2022),
-- Spider-Man: Miles Morales
(6, 1, 3.9, 195.00, 'North America', 2021),
(6, 2, 2.8, 140.00, 'North America', 2021),
(6, 1, 3.2, 160.00, 'Europe', 2021),
-- God of War Ragnarök
(7, 1, 5.1, 357.00, 'North America', 2022),
(7, 2, 3.4, 238.00, 'North America', 2022),
(7, 1, 4.3, 301.00, 'Europe', 2022),
(7, 1, 1.8, 126.00, 'Asia', 2022),
-- Starfield
(8, 6, 4.2, 294.00, 'North America', 2023),
(8, 3, 2.8, 196.00, 'North America', 2023),
-- Fortnite (Free-to-play revenue)
(9, 6, 350.0, 5600.00, 'North America', 2022),
(9, 1, 125.0, 2000.00, 'North America', 2022),
(9, 5, 85.0, 1360.00, 'North America', 2022),
(9, 7, 210.0, 3360.00, 'North America', 2022),
-- Counter-Strike 2
(10, 6, 27.5, 1100.00, 'North America', 2023),
(10, 6, 32.1, 1284.00, 'Europe', 2023),
(10, 6, 18.7, 748.00, 'Asia', 2023),
-- Zelda: Tears of the Kingdom
(13, 5, 12.8, 768.00, 'North America', 2023),
(13, 5, 9.5, 570.00, 'Europe', 2023),
(13, 5, 8.2, 492.00, 'Asia', 2023),
-- Resident Evil 4 Remake
(14, 1, 3.2, 192.00, 'North America', 2023),
(14, 6, 2.8, 168.00, 'North America', 2023),
(14, 1, 2.5, 150.00, 'Europe', 2023),
-- Baldur's Gate 3
(19, 6, 8.5, 510.00, 'North America', 2023),
(19, 6, 6.8, 408.00, 'Europe', 2023),
(19, 1, 2.1, 126.00, 'North America', 2023),
-- Minecraft
(21, 6, 45.0, 1350.00, 'North America', 2020),
(21, 5, 23.5, 705.00, 'North America', 2020),
(21, 7, 38.2, 573.00, 'North America', 2020),
(21, 8, 42.5, 637.50, 'North America', 2020),
-- Red Dead Redemption 2
(26, 2, 17.5, 1050.00, 'North America', 2018),
(26, 4, 14.2, 852.00, 'North America', 2018),
(26, 6, 12.8, 768.00, 'North America', 2019),
(26, 2, 15.3, 918.00, 'Europe', 2018),
-- The Witcher 3
(27, 6, 15.2, 456.00, 'North America', 2016),
(27, 2, 8.5, 255.00, 'Europe', 2015),
(27, 5, 4.3, 129.00, 'North America', 2019),
-- Call of Duty MW II
(30, 1, 8.2, 574.00, 'North America', 2022),
(30, 6, 6.5, 455.00, 'North America', 2022),
(30, 3, 5.8, 406.00, 'North America', 2022);

-- ========================================================
-- INSERTION: AVIS DES JOUEURS
-- ========================================================
INSERT INTO user_reviews (game_id, platform_id, user_score, review_count, positive_reviews, negative_reviews, review_date) VALUES
(1, 2, 5.7, 152000, 75000, 77000, '2020-12-31'),
(2, 6, 7.1, 98000, 65000, 33000, '2021-06-30'),
(3, 6, 9.2, 125000, 118000, 7000, '2022-12-31'),
(4, 6, 8.8, 342000, 310000, 32000, '2021-12-31'),
(7, 1, 9.1, 87000, 82000, 5000, '2023-03-31'),
(13, 5, 9.4, 145000, 139000, 6000, '2023-12-31'),
(19, 6, 9.3, 156000, 148000, 8000, '2023-12-31'),
(21, 6, 8.5, 425000, 375000, 50000, '2022-12-31'),
(26, 6, 9.0, 198000, 185000, 13000, '2019-12-31'),
(27, 6, 9.3, 287000, 272000, 15000, '2020-12-31');

-- ========================================================
-- INSERTION: RÉCOMPENSES
-- ========================================================
INSERT INTO awards (game_id, award_name, category, award_year, is_winner, ceremony_name) VALUES
(1, 'Game of the Year', 'GOTY', 2020, TRUE, 'The Game Awards'),
(1, 'Best Narrative', 'Story', 2020, TRUE, 'The Game Awards'),
(1, 'Best Performance', 'Acting', 2020, TRUE, 'The Game Awards'),
(3, 'Game of the Year', 'GOTY', 2022, TRUE, 'The Game Awards'),
(3, 'Best RPG', 'Genre', 2022, TRUE, 'The Game Awards'),
(3, 'Best Art Direction', 'Visual', 2022, TRUE, 'The Game Awards'),
(7, 'Game of the Year', 'GOTY', 2022, FALSE, 'The Game Awards'),
(7, 'Best Narrative', 'Story', 2022, TRUE, 'The Game Awards'),
(13, 'Game of the Year', 'GOTY', 2023, TRUE, 'The Game Awards'),
(13, 'Best Action/Adventure', 'Genre', 2023, TRUE, 'The Game Awards'),
(19, 'Game of the Year', 'GOTY', 2023, FALSE, 'The Game Awards'),
(19, 'Best RPG', 'Genre', 2023, TRUE, 'The Game Awards'),
(19, 'Best Multiplayer', 'Feature', 2023, TRUE, 'The Game Awards'),
(24, 'Best Indie Game', 'Indie', 2020, TRUE, 'The Game Awards'),
(24, 'Best Action Game', 'Genre', 2020, TRUE, 'The Game Awards'),
(26, 'Game of the Year', 'GOTY', 2018, FALSE, 'The Game Awards'),
(26, 'Best Narrative', 'Story', 2018, TRUE, 'The Game Awards'),
(26, 'Best Audio Design', 'Technical', 2018, TRUE, 'The Game Awards');

-- ========================================================
-- INSERTION: DLC ET MISES À JOUR
-- ========================================================
INSERT INTO dlc_updates (game_id, dlc_name, release_date, price_usd, content_type) VALUES
(2, 'Phantom Liberty', '2023-09-26', 29.99, 'Expansion'),
(4, 'The Cayo Perico Heist', '2020-12-15', 0.00, 'Free Update'),
(7, 'Valhalla', '2023-04-20', 0.00, 'Free Update'),
(13, 'Master Mode', '2023-07-06', 0.00, 'Free Update'),
(19, 'Patch 1 - Expanded Content', '2023-09-21', 0.00, 'Free Update'),
(21, 'Caves & Cliffs Update', '2021-06-08', 0.00, 'Free Update'),
(26, 'Online Content Update', '2019-09-10', 0.00, 'Free Update'),
(27, 'Blood and Wine', '2016-05-31', 19.99, 'Expansion'),
(27, 'Hearts of Stone', '2015-10-13', 9.99, 'Expansion');

-- ========================================================
-- INSERTION: MÉTRIQUES COMMUNAUTÉ
-- ========================================================
INSERT INTO community_metrics (game_id, platform_id, active_players_millions, peak_concurrent_players, twitch_avg_viewers, reddit_subscribers, measurement_date) VALUES
(3, 6, 1.2, 953426, 45000, 1800000, '2023-12-01'),
(4, 6, 1.8, 364215, 85000, 4200000, '2023-12-01'),
(9, 6, 42.5, 6274000, 125000, 2500000, '2023-12-01'),
(10, 6, 28.3, 1818845, 310000, 1300000, '2023-12-01'),
(13, 5, 8.5, NULL, 52000, 1200000, '2023-12-01'),
(19, 6, 3.8, 875432, 98000, 950000, '2023-12-01'),
(20, 6, 150.0, 8000000, 185000, 7200000, '2023-12-01'),
(21, 6, 180.0, 2750000, 48000, 8500000, '2023-12-01');

SELECT 'Données insérées avec succès!' AS Status,
       (SELECT COUNT(*) FROM games) AS 'Nombre de jeux',
       (SELECT COUNT(*) FROM sales) AS 'Enregistrements de ventes',
       (SELECT COUNT(*) FROM studios) AS 'Studios';
