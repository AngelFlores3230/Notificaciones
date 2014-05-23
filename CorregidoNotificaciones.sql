/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases V8.1.2                     */
/* Target DBMS:           PostgreSQL 9                                    */
/* Project file:          Biseño Notificación.dez                         */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database creation script                        */
/* Created on:            2014-05-23 15:23                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Add tables                                                             */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "Seccion"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE Seccion (
    sec_id INTEGER  NOT NULL,
    sec_des CHARACTER VARYING(40)  NOT NULL,
    CONSTRAINT PK_Seccion PRIMARY KEY (sec_id)
);

/* ---------------------------------------------------------------------- */
/* Add table "Ciclo"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE Ciclo (
    cic_id INTEGER  NOT NULL,
    cic_des CHARACTER VARYING(40)  NOT NULL,
    CONSTRAINT PK_Ciclo PRIMARY KEY (cic_id)
);

/* ---------------------------------------------------------------------- */
/* Add table "Curso"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE Curso (
    cur_id INTEGER  NOT NULL,
    cur_des CHARACTER VARYING(40)  NOT NULL,
    cic_id INTEGER  NOT NULL,
    CONSTRAINT PK_Curso PRIMARY KEY (cur_id, cic_id)
);

/* ---------------------------------------------------------------------- */
/* Add table "Ocupacion"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE Ocupacion (
    ocu_id INTEGER  NOT NULL,
    ocu_des CHARACTER VARYING(40)  NOT NULL,
    CONSTRAINT PK_Ocupacion PRIMARY KEY (ocu_id)
);

/* ---------------------------------------------------------------------- */
/* Add table "Representante"                                              */
/* ---------------------------------------------------------------------- */

CREATE TABLE Representante (
    rep_ced INTEGER  NOT NULL,
    rep_nom CHARACTER VARYING(40)  NOT NULL,
    rep_ape CHARACTER VARYING(40)  NOT NULL,
    rep_dir CHARACTER VARYING(40)  NOT NULL,
    rep_tel CHARACTER VARYING(40),
    ocu_id INTEGER  NOT NULL,
    CONSTRAINT PK_Representante PRIMARY KEY (rep_ced, ocu_id)
);

/* ---------------------------------------------------------------------- */
/* Add table "Docente"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE Docente (
    doc_ced INTEGER  NOT NULL,
    doc_nom CHARACTER VARYING(40)  NOT NULL,
    doc_ape CHARACTER VARYING(40)  NOT NULL,
    doc_tel CHARACTER VARYING(40)  NOT NULL,
    doc_ema CHARACTER VARYING(40),
    CONSTRAINT PK_Docente PRIMARY KEY (doc_ced)
);

/* ---------------------------------------------------------------------- */
/* Add table "Estudiante"                                                 */
/* ---------------------------------------------------------------------- */

CREATE TABLE Estudiante (
    est_id INTEGER  NOT NULL,
    est_nom CHARACTER VARYING(40)  NOT NULL,
    est_ape CHARACTER VARYING(40)  NOT NULL,
    est_fec_nac DATE  NOT NULL,
    est_fot BYTEA,
    sec_id INTEGER  NOT NULL,
    cur_id INTEGER  NOT NULL,
    cic_id INTEGER  NOT NULL,
    rep_ced INTEGER  NOT NULL,
    ocu_id INTEGER  NOT NULL,
    CONSTRAINT PK_Estudiante PRIMARY KEY (est_id, sec_id, cur_id, cic_id, rep_ced, ocu_id)
);

/* ---------------------------------------------------------------------- */
/* Add table "Notificacion"                                               */
/* ---------------------------------------------------------------------- */

CREATE TABLE Notificacion (
    not_id INTEGER  NOT NULL,
    not_fec DATE  NOT NULL,
    not_des CHARACTER VARYING(100)  NOT NULL,
    not_dia TIME  NOT NULL,
    doc_ced INTEGER  NOT NULL,
    est_id INTEGER  NOT NULL,
    sec_id INTEGER  NOT NULL,
    cur_id INTEGER  NOT NULL,
    cic_id INTEGER  NOT NULL,
    rep_ced INTEGER  NOT NULL,
    ocu_id INTEGER  NOT NULL,
    CONSTRAINT PK_Notificacion PRIMARY KEY (not_id, doc_ced, est_id, sec_id, cur_id, cic_id, rep_ced, ocu_id)
);

/* ---------------------------------------------------------------------- */
/* Add foreign key constraints                                            */
/* ---------------------------------------------------------------------- */

ALTER TABLE Curso ADD CONSTRAINT Ciclo_Curso 
    FOREIGN KEY (cic_id) REFERENCES Ciclo (cic_id);

ALTER TABLE Estudiante ADD CONSTRAINT Seccion_Estudiante 
    FOREIGN KEY (sec_id) REFERENCES Seccion (sec_id);

ALTER TABLE Estudiante ADD CONSTRAINT Curso_Estudiante 
    FOREIGN KEY (cur_id, cic_id) REFERENCES Curso (cur_id,cic_id);

ALTER TABLE Estudiante ADD CONSTRAINT Representante_Estudiante 
    FOREIGN KEY (rep_ced, ocu_id) REFERENCES Representante (rep_ced,ocu_id);

ALTER TABLE Representante ADD CONSTRAINT Ocupacion_Representante 
    FOREIGN KEY (ocu_id) REFERENCES Ocupacion (ocu_id);

ALTER TABLE Notificacion ADD CONSTRAINT Docente_Notificacion 
    FOREIGN KEY (doc_ced) REFERENCES Docente (doc_ced);

ALTER TABLE Notificacion ADD CONSTRAINT Estudiante_Notificacion 
    FOREIGN KEY (est_id, sec_id, cur_id, cic_id, rep_ced, ocu_id) REFERENCES Estudiante (est_id,sec_id,cur_id,cic_id,rep_ced,ocu_id);
