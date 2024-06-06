"""Gestion des "routes" FLASK et des données pour les genres.
Fichier : gestion_genres_crud.py
Auteur : OM 2021.03.16
"""
from pathlib import Path

from flask import redirect
from flask import request
from flask import session
from flask import url_for

from APP_FILMS_164 import app
from APP_FILMS_164.database.database_tools import DBconnection
from APP_FILMS_164.erreurs.exceptions import *
from APP_FILMS_164.Personnes.gestion_personnes_wtf_forms import FormWTFAjouterPersonne
from APP_FILMS_164.Personnes.gestion_personnes_wtf_forms import FormWTFDeletePersonne
from APP_FILMS_164.Personnes.gestion_personnes_wtf_forms import FormWTFUpdatePersonne

"""
    Auteur : OM 2021.03.16
    Définition d'une "route" /genres_afficher

    Test : ex : http://127.0.0.1:5575/genres_afficher

    Paramètres : order_by : ASC : Ascendant, DESC : Descendant
                id_genre_sel = 0 >> tous les genres.
                id_genre_sel = "n" affiche le genre dont l'id est "n"
"""


@app.route("/personne_afficher/<string:order_by>/<int:id_type_sel>", methods=['GET', 'POST'])
def personne_afficher(order_by, id_type_sel):
    if request.method == "GET":
        try:
            with DBconnection() as mc_afficher:
                if order_by == "ASC" and id_type_sel > 0 and id_type_sel < 99999:
                    valeurs_insertion_dictionnaire = {"id_type_sel": id_type_sel}
                    strsql_genres_afficher = """SELECT id_personne,nom,prenom,mail,telephone,pseudo_compte,nom_type_compte FROM t_compte_personne 
                                                INNER JOIN t_compte  ON t_compte.id_compte = t_compte_personne.fk_compte
                                                INNER JOIN t_personne ON t_personne.id_personne = t_compte_personne.fk_personne
                                                INNER JOIN t_compte_type_compte  ON t_compte.id_compte = t_compte_type_compte.fk_compte
                                                INNER JOIN t_type_compte ON t_type_compte.id_type_compte = t_compte_type_compte.fk_type_compte
                                                WHERE id_type_compte = %(id_type_sel)s
                                                ORDER BY id_personne ASC"""
                    mc_afficher.execute(strsql_genres_afficher, valeurs_insertion_dictionnaire)
                elif order_by == "ASC" and id_type_sel == 0 :
                    strsql_genres_afficher = """SELECT id_personne,nom,prenom,mail,telephone,pseudo_compte,nom_type_compte FROM t_personne
                                                LEFT JOIN t_compte_personne ON t_compte_personne.fk_personne = t_personne.id_personne 
                                                LEFT JOIN t_compte  ON t_compte.id_compte = t_compte_personne.fk_compte
                                                LEFT JOIN t_compte_type_compte  ON t_compte.id_compte = t_compte_type_compte.fk_compte
                                                LEFT JOIN t_type_compte ON t_type_compte.id_type_compte = t_compte_type_compte.fk_type_compte
                                                ORDER BY id_personne ASC"""
                    mc_afficher.execute(strsql_genres_afficher)
                elif order_by == "ASC" and id_type_sel == 99999 :
                    strsql_genres_afficher = """SELECT id_personne,nom,prenom,mail,telephone FROM t_personne
                                                LEFT JOIN t_compte_personne ON t_compte_personne.fk_personne = t_personne.id_personne
                                                WHERE t_compte_personne.fk_personne IS NULL
                                                ORDER BY id_personne ASC"""
                    mc_afficher.execute(strsql_genres_afficher)
                else:
                    strsql_genres_afficher = """SELECT id_personne,nom,prenom,mail,telephone,pseudo_compte,nom_type_compte FROM t_personne
                                                LEFT JOIN t_compte_personne ON t_compte_personne.fk_personne = t_personne.id_personne 
                                                LEFT JOIN t_compte  ON t_compte.id_compte = t_compte_personne.fk_compte
                                                LEFT JOIN t_compte_type_compte  ON t_compte.id_compte = t_compte_type_compte.fk_compte
                                                LEFT JOIN t_type_compte ON t_type_compte.id_type_compte = t_compte_type_compte.fk_type_compte
                                                ORDER BY id_personne DESC"""

                    mc_afficher.execute(strsql_genres_afficher)

                data_genres = mc_afficher.fetchall()
                strSql_type_afficher = """SELECT * FROM t_type_compte"""
                mc_afficher.execute(strSql_type_afficher)
                data_type_compte = mc_afficher.fetchall()

                print("data_genres ", data_genres, " Type : ", type(data_genres))

                # Différencier les messages si la table est vide.
                if not data_genres :
                    flash("""aucun utilisateurs!!""", "warning")
                else:
                    # Dans tous les autres cas, c'est que la table "t_genre" est vide.
                    # OM 2020.04.09 La ligne ci-dessous permet de donner un sentiment rassurant aux utilisateurs.
                    flash(f"Personnes affichés !!!", "success")

        except Exception as Exception_genres_afficher:
            raise ExceptionGenresAfficher(f"fichier : {Path(__file__).name}  ;  "
                                          f"{personne_afficher.__name__} ; "
                                          f"{Exception_genres_afficher}")

    # Envoie la page "HTML" au serveur.
    return render_template("personne/personne_afficher.html", data=data_genres, data_type_compte=data_type_compte, id_type_sel=id_type_sel)


"""
    Auteur : OM 2021.03.22
    Définition d'une "route" /genres_ajouter

    Test : ex : http://127.0.0.1:5575/genres_ajouter

    Paramètres : sans

    But : Ajouter un genre pour un film

    Remarque :  Dans le champ "name_genre_html" du formulaire "genres/genres_ajouter.html",
                le contrôle de la saisie s'effectue ici en Python.
                On transforme la saisie en minuscules.
                On ne doit pas accepter des valeurs vides, des valeurs avec des chiffres,
                des valeurs avec des caractères qui ne sont pas des lettres.
                Pour comprendre [A-Za-zÀ-ÖØ-öø-ÿ] il faut se reporter à la table ASCII https://www.ascii-code.com/
                Accepte le trait d'union ou l'apostrophe, et l'espace entre deux mots, mais pas plus d'une occurence.
"""


@app.route("/personne_ajouter", methods=['GET', 'POST'])
def personne_ajouter_wtf():
    form = FormWTFAjouterPersonne()
    if request.method == "POST":
        try:
            if form.validate_on_submit():
                nom_personne = form.nom_personne_wtf.data

                prenom_personne = form.prenom_personne_wtf.data

                email_personne_wtf = form.email_personne_wtf.data
                email_personne = email_personne_wtf.lower()

                telephone_personne_wtf = form.telephone_personne_wtf.data
                telephone_personne = telephone_personne_wtf.lower()

                valeurs_insertion_dictionnaire = {"nom_personne": nom_personne, "prenom_personne": prenom_personne, "email_personne": email_personne, "telephone_personne": telephone_personne}
                print("valeurs_insertion_dictionnaire ", valeurs_insertion_dictionnaire)

                strsql_insert_genre = """INSERT INTO t_personne (id_personne, nom, prenom, mail, telephone) VALUES (NULL,%(nom_personne)s,%(prenom_personne)s,%(email_personne)s,%(telephone_personne)s) """
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(strsql_insert_genre, valeurs_insertion_dictionnaire)

                flash(f"Données insérées !!", "success")
                print(f"Données insérées !!")

                # Pour afficher et constater l'insertion de la valeur, on affiche en ordre inverse. (DESC)
                return redirect(url_for('personne_afficher', order_by='DESC', id_type_sel=-1))

        except Exception as Exception_genres_ajouter_wtf:
            raise ExceptionGenresAjouterWtf(f"fichier : {Path(__file__).name}  ;  "
                                            f"{personne_ajouter_wtf.__name__} ; "
                                            f"{Exception_genres_ajouter_wtf}")

    return render_template("personne/personne_ajouter_wtf.html", form=form)


"""
    Auteur : OM 2021.03.29
    Définition d'une "route" /genre_update

    Test : ex cliquer sur le menu "genres" puis cliquer sur le bouton "EDIT" d'un "genre"

    Paramètres : sans

    But : Editer(update) un genre qui a été sélectionné dans le formulaire "genres_afficher.html"

    Remarque :  Dans le champ "nom_personne_update_wtf" du formulaire "genres/genre_update_wtf.html",
                le contrôle de la saisie s'effectue ici en Python.
                On transforme la saisie en minuscules.
                On ne doit pas accepter des valeurs vides, des valeurs avec des chiffres,
                des valeurs avec des caractères qui ne sont pas des lettres.
                Pour comprendre [A-Za-zÀ-ÖØ-öø-ÿ] il faut se reporter à la table ASCII https://www.ascii-code.com/
                Accepte le trait d'union ou l'apostrophe, et l'espace entre deux mots, mais pas plus d'une occurence.
"""


@app.route("/personne_update", methods=['GET', 'POST'])
def personne_update_wtf():
    # L'utilisateur vient de cliquer sur le bouton "EDIT". Récupère la valeur de "id_genre"
    id_personne_update = request.values['id_personne']

    # Objet formulaire pour l'UPDATE
    form_update = FormWTFUpdatePersonne()
    try:
        # 2023.05.14 OM S'il y a des listes déroulantes dans le formulaire
        # La validation pose quelques problèmes
        if request.method == "POST" and form_update.submit.data:
            # Récupèrer la valeur du champ depuis "genre_update_wtf.html" après avoir cliqué sur "SUBMIT".
            # Puis la convertir en lettres minuscules.
            nom_personne = form_update.nom_personne_update_wtf.data

            prenom_personne = form_update.prenom_personne_update_wtf.data

            email_personne_wtf = form_update.email_personne_update_wtf.data
            email_personne = email_personne_wtf.lower()

            telephone_personne_wtf = form_update.telephone_personne_update_wtf.data
            telephone_personne = telephone_personne_wtf.lower()

            valeur_update_dictionnaire = {"id_personne": id_personne_update, "nom_personne": nom_personne, "prenom_personne": prenom_personne, "email_personne": email_personne, "telephone_personne": telephone_personne}
            print("valeur_update_dictionnaire ", valeur_update_dictionnaire)

            str_sql_update_intitulegenre = """UPDATE t_personne SET nom = %(nom_personne)s, prenom =%(prenom_personne)s, mail = %(email_personne)s, telephone = %(telephone_personne)s
                                              WHERE id_personne = %(id_personne)s """
            with DBconnection() as mconn_bd:
                mconn_bd.execute(str_sql_update_intitulegenre, valeur_update_dictionnaire)

            flash(f"Donnée mise à jour !!", "success")
            print(f"Donnée mise à jour !!")

            # afficher et constater que la donnée est mise à jour.
            # Affiche seulement la valeur modifiée, "ASC" et l'"id_genre_update"
            return redirect(url_for('personne_afficher', order_by="ASC", id_type_sel=-1))
        elif request.method == "GET":
            # Opération sur la BD pour récupérer "id_genre" et "intitule_genre" de la "t_genre"
            str_sql_id_genre = "SELECT id_personne, nom, prenom, mail, telephone FROM t_personne " \
                               "WHERE id_personne = %(id_personne)s"
            valeur_select_dictionnaire = {"id_personne": id_personne_update}
            with DBconnection() as mybd_conn:
                mybd_conn.execute(str_sql_id_genre, valeur_select_dictionnaire)
            # Une seule valeur est suffisante "fetchone()", vu qu'il n'y a qu'un seul champ "nom genre" pour l'UPDATE
            data_personne = mybd_conn.fetchone()
            print("data_nom_genre ", data_personne, " type ", type(data_personne), " genre ",
                  data_personne["nom"])

            # Afficher la valeur sélectionnée dans les champs du formulaire "genre_update_wtf.html"
            form_update.nom_personne_update_wtf.data = data_personne["nom"]
            form_update.prenom_personne_update_wtf.data = data_personne["prenom"]
            form_update.email_personne_update_wtf.data = data_personne["mail"]
            form_update.telephone_personne_update_wtf.data = data_personne["telephone"]

    except Exception as Exception_genre_update_wtf:
        raise ExceptionGenreUpdateWtf(f"fichier : {Path(__file__).name}  ;  "
                                      f"{personne_update_wtf.__name__} ; "
                                      f"{Exception_genre_update_wtf}")

    return render_template("personne/personne_update_wtf.html", form_update=form_update)


"""
    Auteur : OM 2021.04.08
    Définition d'une "route" /genre_delete

    Test : ex. cliquer sur le menu "genres" puis cliquer sur le bouton "DELETE" d'un "genre"

    Paramètres : sans

    But : Effacer(delete) un genre qui a été sélectionné dans le formulaire "genres_afficher.html"

    Remarque :  Dans le champ "nom_genre_delete_wtf" du formulaire "genres/genre_delete_wtf.html",
                le contrôle de la saisie est désactivée. On doit simplement cliquer sur "DELETE"
"""


@app.route("/personne_delete", methods=['GET', 'POST'])
def personne_delete_wtf():
    data_films_attribue_genre_delete = None
    btn_submit_del = None
    # L'utilisateur vient de cliquer sur le bouton "DELETE". Récupère la valeur de "id_genre"
    id_personne_delete = request.values['id_personne']

    # Objet formulaire pour effacer le genre sélectionné.
    form_delete = FormWTFDeletePersonne()
    try:
        print(" on submit ", form_delete.validate_on_submit())
        if request.method == "POST" and form_delete.validate_on_submit():

            if form_delete.submit_btn_annuler.data:
                return redirect(url_for("personne_afficher", order_by="ASC", id_type_sel=-1))

            if form_delete.submit_btn_conf_del.data:
                # Récupère les données afin d'afficher à nouveau
                # le formulaire "genres/genre_delete_wtf.html" lorsque le bouton "Etes-vous sur d'effacer ?" est cliqué.
                data_films_attribue_genre_delete = session['data_films_attribue_genre_delete']
                print("data_films_attribue_genre_delete ", data_films_attribue_genre_delete)

                flash(f"Effacer la personne de façon définitive de la BD !!!", "danger")
                # L'utilisateur vient de cliquer sur le bouton de confirmation pour effacer...
                # On affiche le bouton "Effacer genre" qui va irrémédiablement EFFACER le genre
                btn_submit_del = True

            if form_delete.submit_btn_del.data:
                valeur_delete_dictionnaire = {"id_personne": id_personne_delete}
                print("valeur_delete_dictionnaire ", valeur_delete_dictionnaire)

                str_sql_delete_louer = """DELETE FROM t_louer WHERE fk_personne = %(id_personne)s"""
                str_sql_delete_retourner = """DELETE FROM t_retourner WHERE fk_personne = %(id_personne)s"""
                str_sql_delete_vehicule_periode = """DELETE FROM t_compte_personne WHERE fk_personne = %(id_personne)s"""
                str_sql_delete_idgenre = """DELETE FROM morattel_bryan_expi1a_mpd.t_personne WHERE id_personne = %(id_personne)s"""
                # Manière brutale d'effacer d'abord la "fk_genre", même si elle n'existe pas dans la "t_genre_film"
                # Ensuite on peut effacer le genre vu qu'il n'est plus "lié" (INNODB) dans la "t_genre_film"
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(str_sql_delete_louer, valeur_delete_dictionnaire)
                    mconn_bd.execute(str_sql_delete_retourner, valeur_delete_dictionnaire)
                    mconn_bd.execute(str_sql_delete_vehicule_periode, valeur_delete_dictionnaire)
                    mconn_bd.execute(str_sql_delete_idgenre, valeur_delete_dictionnaire)

                flash(f"personne définitivement effacé !!", "success")
                print(f"personne définitivement effacé !!")

                # afficher les données
                return redirect(url_for('personne_afficher', order_by="ASC", id_type_sel=-1))

        if request.method == "GET":
            valeur_select_dictionnaire = {"id_personne": id_personne_delete}
            print(id_personne_delete, type(id_personne_delete))

            # Requête qui affiche tous les films_genres qui ont le genre que l'utilisateur veut effacer
            str_sql_genres_films_delete = """SELECT id_compte_personne, pseudo_compte, id_personne, nom FROM t_compte_personne 
                                            INNER JOIN t_compte ON t_compte_personne.fk_compte = t_compte.id_compte
                                            INNER JOIN t_personne ON t_compte_personne.fk_personne = t_personne.id_personne
                                            WHERE fk_personne = %(id_personne)s"""

            with DBconnection() as mydb_conn:
                mydb_conn.execute(str_sql_genres_films_delete, valeur_select_dictionnaire)
                data_films_attribue_genre_delete = mydb_conn.fetchall()
                print("data_films_attribue_genre_delete...", data_films_attribue_genre_delete)

                # Nécessaire pour mémoriser les données afin d'afficher à nouveau
                # le formulaire "genres/genre_delete_wtf.html" lorsque le bouton "Etes-vous sur d'effacer ?" est cliqué.
                session['data_films_attribue_genre_delete'] = data_films_attribue_genre_delete

                # Opération sur la BD pour récupérer "id_genre" et "intitule_genre" de la "t_genre"
                str_sql_id_genre = "SELECT id_personne, nom FROM t_personne WHERE id_personne = %(id_personne)s"

                mydb_conn.execute(str_sql_id_genre, valeur_select_dictionnaire)
                # Une seule valeur est suffisante "fetchone()",
                # vu qu'il n'y a qu'un seul champ "nom genre" pour l'action DELETE
                data_nom_genre = mydb_conn.fetchone()
                print("data_nom_genre ", data_nom_genre, " type ", type(data_nom_genre), " genre ",
                      data_nom_genre["nom"])

            # Afficher la valeur sélectionnée dans le champ du formulaire "genre_delete_wtf.html"
            form_delete.nom_personne_delete_wtf.data = data_nom_genre["nom"]

            # Le bouton pour l'action "DELETE" dans le form. "genre_delete_wtf.html" est caché.
            btn_submit_del = False

    except Exception as Exception_genre_delete_wtf:
        raise ExceptionGenreDeleteWtf(f"fichier : {Path(__file__).name}  ;  "
                                      f"{personne_delete_wtf.__name__} ; "
                                      f"{Exception_genre_delete_wtf}")

    return render_template("personne/personne_delete_wtf.html",
                           form_delete=form_delete,
                           btn_submit_del=btn_submit_del,
                           data_films_associes=data_films_attribue_genre_delete)
