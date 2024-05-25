-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour morattel_bryan_expi1a_mpd
DROP DATABASE IF EXISTS `morattel_bryan_expi1a_mpd`;
CREATE DATABASE IF NOT EXISTS `morattel_bryan_expi1a_mpd` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `morattel_bryan_expi1a_mpd`;

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_compte
DROP TABLE IF EXISTS `t_compte`;
CREATE TABLE IF NOT EXISTS `t_compte` (
  `id_compte` int NOT NULL AUTO_INCREMENT,
  `mot_de_passe_compte` varchar(255) DEFAULT NULL,
  `date_creation_compte` date DEFAULT NULL,
  `pseudo_compte` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_compte`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_compte : ~3 rows (environ)
INSERT INTO `t_compte` (`id_compte`, `mot_de_passe_compte`, `date_creation_compte`, `pseudo_compte`) VALUES
	(1, '$2y$10$A37KDszAFRgxE5N4FTWwxeLeKTM6s/MPsU9yGdOH1mKa5oxSWSfRW', '2022-02-03', 'KevM123'),
	(2, '$2y$10$bSoXQyAFFEIucuqXA64rWuVq12c.tI/MXDBsEjvFJYZ/Olfyc7vrK', '2021-04-06', 'MigJ456'),
	(3, '$2y$10$.JhA9ModioYAGmHwdC4fP.mrSbRnmVRriEWtkYfjZeF.wELEZX.xq', '2020-03-01', 'Raph789');

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_compte_personne
DROP TABLE IF EXISTS `t_compte_personne`;
CREATE TABLE IF NOT EXISTS `t_compte_personne` (
  `id_compte_personne` int NOT NULL AUTO_INCREMENT,
  `fk_compte` int DEFAULT NULL,
  `fk_personne` int DEFAULT NULL,
  PRIMARY KEY (`id_compte_personne`),
  KEY `fk_compte` (`fk_compte`),
  KEY `fk_personne` (`fk_personne`),
  CONSTRAINT `t_compte_personne_ibfk_1` FOREIGN KEY (`fk_compte`) REFERENCES `t_compte` (`id_compte`),
  CONSTRAINT `t_compte_personne_ibfk_2` FOREIGN KEY (`fk_personne`) REFERENCES `t_personne` (`id_personne`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_compte_personne : ~3 rows (environ)
INSERT INTO `t_compte_personne` (`id_compte_personne`, `fk_compte`, `fk_personne`) VALUES
	(1, 1, 1),
	(2, 2, 2),
	(3, 3, 3);

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_compte_type_compte
DROP TABLE IF EXISTS `t_compte_type_compte`;
CREATE TABLE IF NOT EXISTS `t_compte_type_compte` (
  `id_compte_type_compte` int NOT NULL AUTO_INCREMENT,
  `fk_compte` int DEFAULT NULL,
  `fk_type_compte` int DEFAULT NULL,
  PRIMARY KEY (`id_compte_type_compte`),
  KEY `fk_compte` (`fk_compte`),
  KEY `fk_type_compte` (`fk_type_compte`),
  CONSTRAINT `t_compte_type_compte_ibfk_1` FOREIGN KEY (`fk_compte`) REFERENCES `t_compte` (`id_compte`),
  CONSTRAINT `t_compte_type_compte_ibfk_2` FOREIGN KEY (`fk_type_compte`) REFERENCES `t_type_compte` (`id_type_compte`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_compte_type_compte : ~3 rows (environ)
INSERT INTO `t_compte_type_compte` (`id_compte_type_compte`, `fk_compte`, `fk_type_compte`) VALUES
	(1, 1, 1),
	(2, 2, 2),
	(3, 3, 3);

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_etat_controle_technique
DROP TABLE IF EXISTS `t_etat_controle_technique`;
CREATE TABLE IF NOT EXISTS `t_etat_controle_technique` (
  `id_etat_controle_technique` int NOT NULL AUTO_INCREMENT,
  `nom_etat` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_etat_controle_technique`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_etat_controle_technique : ~4 rows (environ)
INSERT INTO `t_etat_controle_technique` (`id_etat_controle_technique`, `nom_etat`) VALUES
	(1, 'très mauvais état'),
	(2, 'mauvais état'),
	(3, 'Bonne état'),
	(4, 'Comme neuf');

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_garage
DROP TABLE IF EXISTS `t_garage`;
CREATE TABLE IF NOT EXISTS `t_garage` (
  `id_garage` int NOT NULL AUTO_INCREMENT,
  `adresse_garage` varchar(255) DEFAULT NULL,
  `nbr_place_total` int DEFAULT NULL,
  PRIMARY KEY (`id_garage`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_garage : ~5 rows (environ)
INSERT INTO `t_garage` (`id_garage`, `adresse_garage`, `nbr_place_total`) VALUES
	(1, 'Route Ducoin 12', 10),
	(2, 'Chemin rix 34', 15),
	(3, 'Chemin des Rochettes 39', 2),
	(6, 'skibidi toilette', 14);

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_louer
DROP TABLE IF EXISTS `t_louer`;
CREATE TABLE IF NOT EXISTS `t_louer` (
  `id_louer` int NOT NULL AUTO_INCREMENT,
  `fk_personne` int DEFAULT NULL,
  `fk_vehicule` int DEFAULT NULL,
  `fk_etat_controle_technique` int DEFAULT NULL,
  PRIMARY KEY (`id_louer`),
  KEY `fk_personne` (`fk_personne`),
  KEY `fk_vehicule` (`fk_vehicule`),
  KEY `fk_etat_controle_technique` (`fk_etat_controle_technique`),
  CONSTRAINT `t_louer_ibfk_1` FOREIGN KEY (`fk_personne`) REFERENCES `t_personne` (`id_personne`),
  CONSTRAINT `t_louer_ibfk_2` FOREIGN KEY (`fk_vehicule`) REFERENCES `t_vehicule` (`id_vehicule`),
  CONSTRAINT `t_louer_ibfk_3` FOREIGN KEY (`fk_etat_controle_technique`) REFERENCES `t_etat_controle_technique` (`id_etat_controle_technique`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_louer : ~3 rows (environ)
INSERT INTO `t_louer` (`id_louer`, `fk_personne`, `fk_vehicule`, `fk_etat_controle_technique`) VALUES
	(1, 2, 1, 3),
	(2, 1, 2, 1),
	(3, 3, 3, 4);

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_periode
DROP TABLE IF EXISTS `t_periode`;
CREATE TABLE IF NOT EXISTS `t_periode` (
  `id_periode` int NOT NULL AUTO_INCREMENT,
  `debut_periode` date DEFAULT NULL,
  `fin_periode` date DEFAULT NULL,
  PRIMARY KEY (`id_periode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_periode : ~3 rows (environ)
INSERT INTO `t_periode` (`id_periode`, `debut_periode`, `fin_periode`) VALUES
	(1, '2023-03-03', '2023-04-28'),
	(2, '2023-01-12', '2023-01-22'),
	(3, '2022-06-01', '2022-07-13');

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_personne
DROP TABLE IF EXISTS `t_personne`;
CREATE TABLE IF NOT EXISTS `t_personne` (
  `id_personne` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_personne`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_personne : ~3 rows (environ)
INSERT INTO `t_personne` (`id_personne`, `nom`, `prenom`, `mail`, `telephone`) VALUES
	(1, 'Morattel', 'Kevin', 'kev.morattel@example.com', '0796644337'),
	(2, 'Durif', 'Miguel', 'mig.durif@example.com', '0796783453'),
	(3, 'Dupont', 'Raphael', 'raph.dupont@example.com', '0794763473');

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_retourner
DROP TABLE IF EXISTS `t_retourner`;
CREATE TABLE IF NOT EXISTS `t_retourner` (
  `id_retourner` int NOT NULL AUTO_INCREMENT,
  `fk_personne` int DEFAULT NULL,
  `fk_vehicule` int DEFAULT NULL,
  `fk_etat_controle_technique` int DEFAULT NULL,
  PRIMARY KEY (`id_retourner`),
  KEY `fk_personne` (`fk_personne`),
  KEY `fk_vehicule` (`fk_vehicule`),
  KEY `fk_etat_controle_technique` (`fk_etat_controle_technique`),
  CONSTRAINT `t_retourner_ibfk_1` FOREIGN KEY (`fk_personne`) REFERENCES `t_personne` (`id_personne`),
  CONSTRAINT `t_retourner_ibfk_2` FOREIGN KEY (`fk_vehicule`) REFERENCES `t_vehicule` (`id_vehicule`),
  CONSTRAINT `t_retourner_ibfk_3` FOREIGN KEY (`fk_etat_controle_technique`) REFERENCES `t_etat_controle_technique` (`id_etat_controle_technique`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_retourner : ~2 rows (environ)
INSERT INTO `t_retourner` (`id_retourner`, `fk_personne`, `fk_vehicule`, `fk_etat_controle_technique`) VALUES
	(1, 2, 1, 1),
	(2, 1, 2, 1);

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_type_compte
DROP TABLE IF EXISTS `t_type_compte`;
CREATE TABLE IF NOT EXISTS `t_type_compte` (
  `id_type_compte` int NOT NULL AUTO_INCREMENT,
  `nom_type_compte` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_type_compte`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_type_compte : ~3 rows (environ)
INSERT INTO `t_type_compte` (`id_type_compte`, `nom_type_compte`) VALUES
	(1, 'Admin'),
	(2, 'Client'),
	(3, 'Privilege');

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_vehicule
DROP TABLE IF EXISTS `t_vehicule`;
CREATE TABLE IF NOT EXISTS `t_vehicule` (
  `id_vehicule` int NOT NULL AUTO_INCREMENT,
  `modele_vehicule` varchar(255) DEFAULT NULL,
  `imatriculation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_vehicule`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_vehicule : ~16 rows (environ)
INSERT INTO `t_vehicule` (`id_vehicule`, `modele_vehicule`, `imatriculation`) VALUES
	(1, 'toyota corolla', 'FR434346'),
	(2, 'Nissan Juke', 'FR253864'),
	(3, 'Wolswagen Golf', 'FR323578'),
	(4, 'BMW M3 E36', 'FR456223'),
	(5, 'Honda nsx', 'FR846767'),
	(6, 'Bentley Continental', 'FR121145'),
	(7, 'Mercedes Classe S', 'FR388778'),
	(8, 'Range Rover Sport', 'FR167890'),
	(9, 'pagani huayra', 'FR322543'),
	(10, 'ferrari f40', 'FR234298'),
	(11, 'mercedes classe g', 'FR112312'),
	(12, 'skoda junpee', 'FR354324'),
	(13, 'toyota raptor', 'VD837487'),
	(14, 'audi rs5', 'FR874920'),
	(15, 'lamborgihini huracan', 'VS849490'),
	(16, 'subaru brz', 'GE127340'),
	(17, 'skbidi toilet', 'VD474467'),
	(18, 'test', 'FR TEST'),
	(19, 'test', 'FR TEST'),
	(20, 'test', 'FR3242352'),
	(21, 'test', 'fr3434343');

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_vehicule_garage
DROP TABLE IF EXISTS `t_vehicule_garage`;
CREATE TABLE IF NOT EXISTS `t_vehicule_garage` (
  `id_vehicule_garage` int NOT NULL AUTO_INCREMENT,
  `fk_vehicule` int DEFAULT NULL,
  `fk_garage` int DEFAULT NULL,
  PRIMARY KEY (`id_vehicule_garage`),
  KEY `fk_vehicule` (`fk_vehicule`),
  KEY `fk_garage` (`fk_garage`),
  CONSTRAINT `t_vehicule_garage_ibfk_1` FOREIGN KEY (`fk_vehicule`) REFERENCES `t_vehicule` (`id_vehicule`),
  CONSTRAINT `t_vehicule_garage_ibfk_2` FOREIGN KEY (`fk_garage`) REFERENCES `t_garage` (`id_garage`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_vehicule_garage : ~9 rows (environ)
INSERT INTO `t_vehicule_garage` (`id_vehicule_garage`, `fk_vehicule`, `fk_garage`) VALUES
	(1, 1, 1),
	(3, 3, 2),
	(4, 9, 3),
	(5, 12, 3),
	(26, 11, 1);

-- Listage de la structure de table morattel_bryan_expi1a_mpd. t_vehicule_periode
DROP TABLE IF EXISTS `t_vehicule_periode`;
CREATE TABLE IF NOT EXISTS `t_vehicule_periode` (
  `id_vehicule_periode` int NOT NULL AUTO_INCREMENT,
  `fk_vehicule` int DEFAULT NULL,
  `fk_periode` int DEFAULT NULL,
  PRIMARY KEY (`id_vehicule_periode`),
  KEY `fk_vehicule` (`fk_vehicule`),
  KEY `fk_periode` (`fk_periode`),
  CONSTRAINT `t_vehicule_periode_ibfk_1` FOREIGN KEY (`fk_vehicule`) REFERENCES `t_vehicule` (`id_vehicule`),
  CONSTRAINT `t_vehicule_periode_ibfk_2` FOREIGN KEY (`fk_periode`) REFERENCES `t_periode` (`id_periode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table morattel_bryan_expi1a_mpd.t_vehicule_periode : ~3 rows (environ)
INSERT INTO `t_vehicule_periode` (`id_vehicule_periode`, `fk_vehicule`, `fk_periode`) VALUES
	(1, 1, 1),
	(2, 2, 2),
	(3, 3, 3);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
