-- donne le vehicule qui à cette plaque d'immatriculation
SELECT * FROM t_vehicule WHERE imatriculation = 'FR434346';


-- donne le pseudo, le nom et le prénom de chaque utilisateurs
SELECT t_compte.pseudo_compte, t_personne.nom, t_personne.prenom
FROM t_compte
JOIN t_compte_personne ON t_compte.id_compte = t_compte_personne.fk_compte
JOIN t_personne ON t_compte_personne.fk_personne = t_personne.id_personne;


-- donne les modèle de véhicule qui sont à l'adresse Route Ducoin 12
SELECT t_vehicule.modele_vehicule, t_garage.adresse_garage
FROM t_vehicule
JOIN t_vehicule_garage ON t_vehicule.id_vehicule = t_vehicule_garage.fk_vehicule
JOIN t_garage ON t_vehicule_garage.fk_garage = t_garage.id_garage
WHERE t_garage.adresse_garage = 'Route Ducoin 12';


-- donne l'état de chaque véhicule au moment d'être loué
SELECT t_vehicule.modele_vehicule, t_etat_controle_technique.nom_etat
FROM t_vehicule
JOIN t_louer ON t_vehicule.id_vehicule = t_louer.fk_vehicule
JOIN t_etat_controle_technique ON t_louer.fk_etat_controle_technique = t_etat_controle_technique.id_etat_controle_technique;



-- donne tout les comptes qui ont été créée après cette dâte
SELECT pseudo_compte, date_creation_compte
FROM t_compte
WHERE date_creation_compte > '2021-01-01';


-- donne le nom et le prenom des personnes qui ont loué un véhicule et qui ne l'ont pas encore retourné
SELECT t_personne.nom, t_personne.prenom
FROM t_personne
JOIN t_louer ON t_personne.id_personne = t_louer.fk_personne
LEFT JOIN t_retourner ON t_louer.fk_vehicule = t_retourner.fk_vehicule AND t_louer.fk_personne = t_retourner.fk_personne
WHERE t_retourner.id_retourner IS NULL;


-- donne le nombre de véhicule à chaque garage
SELECT t_garage.adresse_garage, COUNT(t_vehicule_garage.fk_vehicule) AS nbr_de_vehicule
FROM t_garage
JOIN t_vehicule_garage ON t_garage.id_garage = t_vehicule_garage.fk_garage
GROUP BY t_garage.id_garage;


-- donne les véhicule et leur période d'indisponibilité
SELECT t_vehicule.modele_vehicule, t_periode.debut_periode, t_periode.fin_periode
FROM t_vehicule
JOIN t_vehicule_periode ON t_vehicule.id_vehicule = t_vehicule_periode.fk_vehicule
JOIN t_periode ON t_vehicule_periode.fk_periode = t_periode.id_periode;


