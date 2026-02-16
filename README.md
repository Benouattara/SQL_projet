# 🎮 SQL Gaming Project

## Analyse de l'industrie des jeux vidéo avec SQL

**Auteur:** BEN OUATTARA  
**Date:** Octobre 2025  
**Technologies:** MySQL, SQL Workbench

---

## 📋 Table des matières

- [À propos du projet](#à-propos-du-projet)
- [Architecture de la base de données](#architecture-de-la-base-de-données)
- [Analyses réalisées](#analyses-réalisées)
- [Installation et utilisation](#installation-et-utilisation)
- [Structure des fichiers](#structure-des-fichiers)
- [Compétences démontrées](#compétences-démontrées)
- [Résultats clés](#résultats-clés)

---

## 🎯 À propos du projet

Ce projet d'analyse SQL explore l'industrie mondiale des jeux vidéo à travers une base de données complète et des requêtes SQL avancées. L'objectif est d'extraire des insights significatifs sur les ventes, les tendances du marché, les performances des studios et l'engagement des joueurs.

### Objectifs principaux:
- 📊 Analyser les performances commerciales de l'industrie du jeu vidéo
- 🎲 Identifier les tendances par genre, plateforme et région
- 💰 Calculer le retour sur investissement (ROI) des jeux
- 🏆 Évaluer l'impact des récompenses sur les ventes
- 👥 Mesurer l'engagement communautaire et la longévité des jeux

---

## 🗄️ Architecture de la base de données

La base de données `gaming_industry` comprend **10 tables interconnectées**:

### Tables principales:

1. **`studios`** - Studios de développement (25 entrées)
   - Informations sur les développeurs de jeux
   - Pays, année de fondation, nombre d'employés

2. **`publishers`** - Éditeurs de jeux (15 entrées)
   - Entreprises qui financent et distribuent les jeux
   - Valeur de marché et localisation

3. **`platforms`** - Plateformes de jeu (12 entrées)
   - Consoles, PC, mobile
   - Type et génération de plateforme

4. **`genres`** - Genres de jeux (15 entrées)
   - Action-Adventure, RPG, FPS, etc.

5. **`games`** - Jeux vidéo (30 entrées)
   - **Table centrale** avec toutes les informations sur les jeux
   - Budget, score Metacritic, date de sortie

6. **`sales`** - Ventes par plateforme (50+ entrées)
   - Unités vendues et revenus par région
   - Données par année et plateforme

7. **`user_reviews`** - Avis des joueurs
   - Notes des utilisateurs
   - Avis positifs/négatifs

8. **`awards`** - Récompenses et nominations
   - Game Awards, BAFTA, etc.
   - Catégories et années

9. **`dlc_updates`** - DLC et mises à jour
   - Contenu additionnel
   - Prix et type de contenu

10. **`community_metrics`** - Métriques d'engagement
    - Joueurs actifs, spectateurs Twitch
    - Abonnés Reddit, pics de concurrence

### Schéma relationnel:

```
studios ──┐
          ├──→ games ──┬──→ sales
publishers┘            ├──→ user_reviews
                       ├──→ awards
genres ────────────────┤
                       ├──→ dlc_updates
platforms ─────────────┴──→ community_metrics
```

---

## 📊 Analyses réalisées

Le fichier `03_analyses.sql` contient **15 analyses SQL** détaillées:

### 1. 🏆 Top 10 des jeux les plus vendus
- Identifie les blockbusters de l'industrie
- Corrélation entre budget et ventes

### 2. 🎮 Performance des genres par revenus
- Quels types de jeux rapportent le plus?
- Analyse de la rentabilité par genre

### 3. 🖥️ Comparaison des plateformes
- PC vs Console vs Mobile
- Part de marché et revenus

### 4. 🏢 Studios les plus performants
- Classement des développeurs par revenus
- Efficacité par employé

### 5. 💵 Retour sur investissement (ROI)
- Calcul du ROI pour chaque jeu
- Identification des meilleurs investissements

### 6. 📈 Évolution des ventes par année
- Tendances de l'industrie 2013-2023
- Croissance annuelle du marché

### 7. 🌍 Performance régionale
- Analyse par région (Amérique du Nord, Europe, Asie)
- Prix moyens par marché

### 8. ⭐ Corrélation notes critiques vs ventes
- Les bons scores garantissent-ils le succès?
- Analyse statistique

### 9. 🎯 Multijoueur vs Solo
- Comparaison des modèles économiques
- Free-to-play vs Premium

### 10. 🏅 Impact des récompenses
- Effet des Game Awards sur les ventes
- Valeur du "GOTY" (Game of the Year)

### 11. 🌐 Pays des studios dominants
- Géographie de l'industrie
- USA, Japon, Europe

### 12. 👥 Engagement de la communauté
- Joueurs actifs, Twitch, Reddit
- Longévité des jeux service

### 13. 💰 Prix moyen par plateforme
- Stratégies de tarification
- Différences mobile/console/PC

### 14. 🎖️ Meilleur rapport qualité/budget
- Jeux les plus efficients
- Réussite des jeux indépendants

### 15. 🤝 Critiques vs Joueurs
- Consensus ou division?
- Analyse des controverses

---

## 🚀 Installation et utilisation

### Prérequis:
- MySQL 8.0 ou supérieur
- MySQL Workbench (recommandé)
- Ou tout client MySQL compatible

### Installation:

1. **Cloner le repository:**
```bash
git clone https://github.com/VOTRE_USERNAME/SQL_gaming_projet.git
cd SQL_gaming_projet
```

2. **Créer la base de données:**
```sql
SOURCE 01_create_database.sql;
```

3. **Insérer les données:**
```sql
SOURCE 02_insert_data.sql;
```

4. **Exécuter les analyses:**
```sql
SOURCE 03_analyses.sql;
```

### Utilisation avec MySQL Workbench:

1. Ouvrir MySQL Workbench
2. Se connecter à votre serveur MySQL
3. File → Open SQL Script
4. Exécuter les scripts dans l'ordre (01, 02, 03)
5. Consulter les résultats dans l'onglet "Result Grid"

---

## 📁 Structure des fichiers

```
SQL_gaming_projet/
│
├── 01_create_database.sql      # Création des tables et structure
├── 02_insert_data.sql          # Insertion de toutes les données
├── 03_analyses.sql             # 15 analyses SQL complètes
├── README.md                   # Documentation du projet
├── schema_diagram.png          # (optionnel) Diagramme ERD
└── LICENSE                     # Licence du projet
```

---

## 💡 Compétences démontrées

### SQL Avancé:
- ✅ Création de bases de données et tables avec contraintes
- ✅ Clés primaires et étrangères (relations)
- ✅ Index pour optimisation des requêtes
- ✅ Requêtes JOIN complexes (INNER, LEFT)
- ✅ Agrégations (SUM, AVG, COUNT)
- ✅ Regroupements (GROUP BY, HAVING)
- ✅ Sous-requêtes et CTEs
- ✅ CASE statements pour logique conditionnelle
- ✅ Calculs mathématiques avancés
- ✅ Formatage et présentation des résultats

### Analyse de données:
- ✅ KPIs et métriques métier
- ✅ Analyse de performance
- ✅ Segmentation de marché
- ✅ Analyse de ROI
- ✅ Tendances temporelles

### Business Intelligence:
- ✅ Insights actionnables
- ✅ Storytelling avec les données
- ✅ Visualisation conceptuelle
- ✅ Documentation claire

---

## 📈 Résultats clés

### Découvertes principales:

1. **GTA V** reste le jeu le plus vendu avec plus de **180 millions d'unités**

2. Les jeux **free-to-play** génèrent des revenus colossaux grâce aux microtransactions
   - Fortnite: 12+ milliards de revenus

3. Le **ROI moyen** des jeux indépendants dépasse celui des AAA
   - Hollow Knight: 22,000% de ROI (400k$ → 90M$)

4. Le **PC** domine en revenus totaux, suivi de PlayStation

5. Les **récompenses GOTY** augmentent les ventes de **25-40%** en moyenne

6. L'**Amérique du Nord** représente 45% des revenus mondiaux

7. Corrélation faible entre **score Metacritic** et ventes
   - Marketing > Qualité dans certains cas

8. Les jeux **service** (live games) maintiennent des millions de joueurs pendant 5+ ans

---

## 🎓 Apprentissages

Ce projet démontre:
- La capacité à concevoir une base de données normalisée
- L'extraction d'insights business à partir de données brutes
- La communication de résultats techniques à des non-experts
- La rigueur dans l'analyse de données complexes

---

## 📞 Contact

**BEN OUATTARA**

- GitHub: https://github.com/Benouattara 
- LinkedIn: https://www.linkedin.com/in/ben-youssouf-ouattara-a9b912193/
- Email: benouattara3@gmail.com

---

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

---

## 🙏 Remerciements

Données inspirées de:
- VGChartz
- Metacritic
- Steam Charts
- The Game Awards
- Diverses sources de l'industrie du jeu vidéo

---

⭐ **Si ce projet vous a plu, n'hésitez pas à lui donner une étoile!** ⭐
