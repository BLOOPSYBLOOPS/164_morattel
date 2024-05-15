-- OM 2021.02.17
-- FICHIER MYSQL POUR FAIRE FONCTIONNER LES EXEMPLES
-- DE REQUETES MYSQL
-- Database: MACCAUD_OLIVIER_INFO1X_FILMS_164_2023

-- Destruction de la BD si elle existe.
-- Pour être certain d'avoir la dernière version des données

DROP DATABASE IF EXISTS morattel_bryan_expi1a_mpd;

-- Création d'un nouvelle base de donnée

CREATE DATABASE IF NOT EXISTS morattel_bryan_expi1a_mpd;

-- Utilisation de cette base de donnée

USE morattel_bryan_expi1a_mpd;
-- --------------------------------------------------------
DROP DATABASE IF EXISTS morattel_bryan_expi1a_mpd;
CREATE DATABASE morattel_bryan_expi1a_mpd;
USE morattel_bryan_expi1a_mpd;

CREATE TABLE t_personne (
    id_personne INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    mail VARCHAR(255) UNIQUE,
    telephone VARCHAR(255)
);

CREATE TABLE t_compte (
    id_compte INT AUTO_INCREMENT PRIMARY KEY,
    mot_de_passe_compte VARCHAR(255),
    date_creation_compte DATE,
    pseudo_compte VARCHAR(255)

);

CREATE TABLE t_type_compte (
    id_type_compte INT AUTO_INCREMENT PRIMARY KEY,
    nom_type_compte VARCHAR(255)
);

CREATE TABLE t_vehicule (
    id_vehicule INT AUTO_INCREMENT PRIMARY KEY,
    modele_vehicule VARCHAR(255),
    imatriculation VARCHAR(255)

);

CREATE TABLE t_garage (
    id_garage INT AUTO_INCREMENT PRIMARY KEY,
    adresse_garage VARCHAR(255),
    nbr_place_total INT
);

CREATE TABLE t_periode (
    id_periode INT AUTO_INCREMENT PRIMARY KEY,
    debut_periode DATE,
    fin_periode DATE

);

CREATE TABLE t_etat_controle_technique (
    id_etat_controle_technique INT AUTO_INCREMENT PRIMARY KEY,
    nom_etat VARCHAR(255)

);

CREATE TABLE t_compte_type_compte (
    id_compte_type_compte INT AUTO_INCREMENT PRIMARY KEY,
    fk_compte INT,
    fk_type_compte INT,
    FOREIGN KEY (fk_compte) REFERENCES t_compte(id_compte),
    FOREIGN KEY (fk_type_compte) REFERENCES t_type_compte(id_type_compte)

);

CREATE TABLE t_compte_personne (
    id_compte_personne INT AUTO_INCREMENT PRIMARY KEY,
    fk_compte INT,
    fk_personne INT,
    FOREIGN KEY (fk_compte) REFERENCES t_compte(id_compte),
    FOREIGN KEY (fk_personne) REFERENCES t_personne(id_personne)

);

CREATE TABLE t_louer (
    id_louer INT AUTO_INCREMENT PRIMARY KEY,
    fk_personne INT,
    fk_vehicule INT,
    fk_etat_controle_technique INT,
    FOREIGN KEY (fk_personne) REFERENCES t_personne(id_personne),
    FOREIGN KEY (fk_vehicule) REFERENCES t_vehicule(id_vehicule),
    FOREIGN KEY (fk_etat_controle_technique) REFERENCES t_etat_controle_technique(id_etat_controle_technique)

);

CREATE TABLE t_retourner (
    id_retourner INT AUTO_INCREMENT PRIMARY KEY,
    fk_personne INT,
    fk_vehicule INT,
    fk_etat_controle_technique INT,
    FOREIGN KEY (fk_personne) REFERENCES t_personne(id_personne),
    FOREIGN KEY (fk_vehicule) REFERENCES t_vehicule(id_vehicule),
    FOREIGN KEY (fk_etat_controle_technique) REFERENCES t_etat_controle_technique(id_etat_controle_technique)

);

CREATE TABLE t_vehicule_garage (
    id_vehicule_garage INT AUTO_INCREMENT PRIMARY KEY,
    fk_vehicule INT,
    fk_garage INT,
    FOREIGN KEY (fk_vehicule) REFERENCES t_vehicule(id_vehicule),
    FOREIGN KEY (fk_garage) REFERENCES t_garage(id_garage)

);


CREATE TABLE t_vehicule_periode (
    id_vehicule_periode INT AUTO_INCREMENT PRIMARY KEY,
    fk_vehicule INT,
    fk_periode INT,
    FOREIGN KEY (fk_vehicule) REFERENCES t_vehicule(id_vehicule),
    FOREIGN KEY (fk_periode) REFERENCES t_periode(id_periode)

);

INSERT INTO t_personne (nom, prenom, mail, telephone) VALUES
('Morattel', 'Kevin', 'kev.morattel@example.com', '0796644337'),
('Durif', 'Miguel', 'mig.durif@example.com', '0796783453'),
('Dupont', 'Raphael', 'raph.dupont@example.com', '0794763473');

INSERT INTO t_compte (pseudo_compte, date_creation_compte,mot_de_passe_compte) VALUES
('KevM123', '2022-02-03', '$2y$10$A37KDszAFRgxE5N4FTWwxeLeKTM6s/MPsU9yGdOH1mKa5oxSWSfRW'),
('MigJ456', '2021-04-06', '$2y$10$bSoXQyAFFEIucuqXA64rWuVq12c.tI/MXDBsEjvFJYZ/Olfyc7vrK'),
('Raph789', '2020-03-01', '$2y$10$.JhA9ModioYAGmHwdC4fP.mrSbRnmVRriEWtkYfjZeF.wELEZX.xq');

INSERT INTO t_type_compte (nom_type_compte) VALUES
('Admin'),
('Client'),
('Privilege');

INSERT INTO t_vehicule (modele_vehicule, imatriculation) VALUES
('Toyota Corolla 2020', 'FR434346'),
('Nissan Juke 2022', 'VD253864'),
('Wolswagen Golf 2018', 'FR323578');

INSERT INTO t_garage (adresse_garage, nbr_place_total) VALUES
('Route Ducoin 12', 10),
('Chemin rix 34', 15);

INSERT INTO t_periode (debut_periode, fin_periode) VALUES
('2023-03-03', '2023-04-28'),
('2023-01-12', '2023-01-22'),
('2022-06-01', '2022-07-13');

INSERT INTO t_etat_controle_technique (nom_etat) VALUES
('très mauvais état'),
('mauvais état'),
('Bonne état'),
('Comme neuf');

INSERT INTO t_vehicule_periode (fk_vehicule, fk_periode) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO t_vehicule_garage (fk_vehicule, fk_garage) VALUES
(1, 1),
(2, 1),
(3, 2);

INSERT INTO t_louer (fk_vehicule, fk_personne, fk_etat_controle_technique) VALUES
(1, 2, 3),
(2, 1, 1),
(3, 3, 4);

INSERT INTO t_retourner (fk_vehicule, fk_personne, fk_etat_controle_technique) VALUES
(1, 2, 1),
(2, 1, 1);

INSERT INTO t_compte_personne (fk_compte, fk_personne) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO t_compte_type_compte (fk_compte, fk_type_compte) VALUES
(1, 1),
(2, 2),
(3, 3);
