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


-- ========================================================
-- MESSAGE DE FIN
-- ========================================================
SELECT 
    '🎮 Analyses SQL terminées!' AS '',
    'Toutes les requêtes ont été exécutées avec succès.' AS 'Status',
    'Projet créé par BEN OUATTARA' AS 'Auteur';
