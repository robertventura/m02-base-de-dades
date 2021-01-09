/* 
-- -------------------------------------

Autor Robert Ventura

Basat amb SQL Murder Mystery de Kniht lab (https://mystery.knightlab.com/)
i Scene Crime de Laure Centellas (https://gitlab.com/centellas/m2-bases-de-dades/-/blob/master/)
CC BY-NC-SA 3.0
-- -------------------------------------
*/


/*
CONTEXT:

Dilluns 19/10/2020

A les oficines de l'empresa Xifols, una empresa farmacèutica pionera en el mercat d'investigació i de les primeres en trobar una possible vacuna per el SARS-CoV-2, s'ha trobat mort el sr Leonard Cameron i hi ha evidències clares que demostren que es tracta d'un crim.
El metege forense ha determinat que l'hora de la mort es podria situar entre les 18:00h i les 22:30h del
passat dia 16, però no en podrà determinar les causes fins que en faci un estudi forense complet.
Mentrestant l'inspector en cap de la policia ha demanat a la direcció de l'empresa tota la informació possible.

S'han pogut recopilar:
	- la informació dels empleats amb els càrrecs que ocupen
	- els diferents departaments
	- la relació de trucades de l'última setmana
	- les compres realitzades la setmana passada mitjançant les targetes bancàries de l'empresa.
	- els horaris laborals dels empleats (fitxatges de la setmana del crim)

També disposem de l'agenda de la víctima i el llistat de les impressions que s'han realitzat a les impresores durant l'última setmana.

El senyor David Burman ens ha fet arribar un backup de les dades.

Siusplau inspector és un cas urgent!

Ens podria dir quines pistes ha trobat? Pot saber qui ha estat l'assassí? com i perquè?'

A la taula policia_evidencies cal incloure aquelles pistes/evidencies que et facin sosptitar de certs indicis

A la taula policia_sospitosos cal introduïr els empleats sospitosos amb els motius que han dut a cometre el crim

Possibles canvis/incorporacions:
	- Afegir un camp de mòbil a cada empleat per introduïr entropia en les trucades telefòniques.
	- Introduïr una taula de logins en els PCs de l'empresa (login(usuari) + IP)
	- Introduïr una taula de les últimes pàgines web (URL) consultades

*/


USE crime_xifols_sql;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE agenda_victima;
TRUNCATE fitxatges;
TRUNCATE impressions;
TRUNCATE trucades;
TRUNCATE compres;
TRUNCATE empleats;
TRUNCATE departaments;
TRUNCATE carrecs;
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------
-- DADES DEPARTAMENTS
-- ------------------

INSERT INTO departaments (departament_id,nom,targeta_credit) VALUES 
(1, 'Direcció General' 		,'4000-0011-3456-7899')
,(2, 'I+D'					,'4000-0012-3456-5888')
,(3, 'Laboratori'			,'4000-0013-3456-3835')
,(4, 'Epidemiologia'			,'4000-0014-3456-5477')
,(5, 'Oncologia'				,'4000-0015-3456-1105')
,(6, 'IT'					,'4000-0016-3456-0608')
,(7, 'Comercial'				,'4000-0017-3456-0125')
,(8, 'RRHH'					,'4000-0018-3456-7456')
,(9, 'Neteja'				,'4000-0019-3456-3259');

-- ----------------
-- DADES CÀRRECS
-- ----------------

INSERT INTO carrecs(carrec_id,nom) VALUES 
 (1, 'Director/a general')
,(2, 'Secretari/a')
,(3, 'Director/a I+D')
,(4, 'Investigador/a cap')
,(5, 'Investigador/a sénior')
,(6, 'Investigador/a júnior')
,(7, 'Epidemiòleg/òloga cap')
,(8, 'Epidemiòleg/òloga sénior')
,(9, 'Epidemiòleg/òloga júnior')
,(10, 'Oncòleg/òloga  cap')
,(11, 'Oncòleg/òloga sénior')
,(12, 'Oncòleg/òloga júnior')
,(13, 'IT cap')
,(14, 'IT-cap de l''àrea de desenvolupament')
,(15, 'IT-developer sénior')
,(16, 'IT-developer júnior')
,(17, 'IT-cap de l''àrea sistemes i comunicacions')
,(18, 'IT-tècnic/a superior de comunicacions')
,(19, 'IT-tècnic/a de seguretat')
,(20, 'Estudiant en pràctiques')
,(21, 'Director/a comercial')
,(22, 'Comercial/Venedor')
,(23, 'Màrketing')
,(24, 'RRHH cap')
,(25, 'Administratiu/va')
,(26, 'Neteja');


-- ----------------
-- DADES EMPLEATS
-- ----------------

-- DADES D'EMPLEATS DEPT 1 - Direcció General
INSERT INTO empleats (empleat_id, departament_id, carrec_id, nom, cognom1, cognom2, adreca, data_naixement,sou,telefon,targeta_credit )
        VALUES 	(1,1,1,'Jan','Cameron','Murphy','Gran 43, Barcelona'		,'1950-06-05',95000,'938740101','5000-0011-3456-3259')
		,(2,1,2,'Xavier','Sevilla','Gagarin','Trinitat 12, 5  Barcelona'	,'1979-07-13',32000,'938740102','5000-0011-7484-3259')

-- DADES D'EMPLEATS DEPT 2 - I+D
		,(3,2,3,'Leonard','Cameron','Callaghan', 'Guillem Cata 9, 1 Barcelona'	,'1975-04-20',64000,'938740201','5000-0012-2578-4524')
		,(4,2,5,'Fran','Abbot','Edison','Major 13, 3 Barcelona'					,'1979-10-13',35000,'938740202','5000-0012-5577-2183')
		,(5,2,6,'Neus','Ferrari','Caldwell','Pascal 23, 2 Barcelona'			,'1981-08-17',25000,'938740203','5000-0012-5687-2248')
		,(28,2,2,'Fran','Lebaque','Chamin','Balmes 72, 4 Barcelona'				,'2000-06-05',20000,'938740204','5000-0012-8899-3354')

-- DADES D'EMPLEATS DEPT 3 - Laboratori
        ,(6,3,4,'Matilda','Yellow','Vaca','Guillem Cata 9, 1 Barcelona'		,'1981-10-16',48000,'938740301','5000-0013-4712-4321')
        ,(7,3,5,'Àlex','Arenas','Valdes','Sant Andreu 44, Barcelona'		,'1969-06-30',33000,'938740302','5000-0013-4765-1234')
        ,(8,3,6,'Guillermina','Fructuos','Amstel','Cardona 12, 4 Barcelona'	,'1999-02-11',29000,'938740303','5000-0013-5588-5635')
        ,(30,3,2,'Ben','Harris','Neal','Pere III 68, 6 Barcelona'			,'1980-07-05',20000,'938740304','5000-0013-7732-9874')
		
-- DADES D'EMPLEATS DEPT 4 - Epidemiologia
        ,(9,4,7,'Oriol','Mitjà','Villar','Universitat 23, 8 Barcelona'		,'1980-06-23',40000,'938740401','5000-0014-8874-4451')
        ,(10,4,8,'Gorka','Boniquet','Fiedler','Londres 13, Barcelona'		,'1981-07-13',33000,'938740402','5000-0014-1234-5544')
        ,(11,4,9,'Naiara','Fournier','Bakshi','Paris 54, 5 Barcelona'		,'1999-11-05',27000,'938740403','5000-0014-5429-7752')

-- DADES D'EMPLEATS DEPT 5 - Oncologia
        ,(12,5,10,'Mercedes','Essa','Naser','Gaudi 24, Barcelona'				,'1981-08-13',40000,'938740501','5000-0015-5478-4455')
        ,(13,5,11,'Mafalda','Olivier','Patel','Picasso 57, 7 Barcelona'		,'1976-11-10',32000,'938740502','5000-0015-1230-5634')
        ,(14,5,12,'Aldo','Garcia','Delgado','Velazquez 499, 2 Barcelona'	,'1998-08-05',23000,'938740503','5000-0015-0014-9871')
		        
-- DEADES D'EMPLEATS DEPT 6 - IT
        ,(15,6,13,'Qiu','Chan','Zhu','Reina 243, 5 Barcelona'								,'1961-12-30',65000,'938740601','5000-0016-4224-2605')
        ,(16,6,15,'Vicente','Avilers','Murphy','Centelles 543, 6 Barcelona'					,'1965-05-26',40000,'938740602','5000-0016-7899-7712')
		,(17,6,16,'Maria Veronica','Cabello','Mans','Horticultor Corset 79, 2 Barcelona'	,'1989-10-16',26000,'938740603','5000-0016-9954-2147')
        ,(18,6,17,'David','Burman','Tahan','Colorado 43, Barcelona'							,'1961-09-14',40000,'938740701','5000-0016-4475-1245')
		,(19,6,19,'Victoria','Ganim','Dalal','Everest 85, 4 Barcelona'						,'1983-12-12',38000,'938740702','5000-0016-5588-4897')
		,(20,6,20,'Olga','Da Costa','Van Hal','Miseria 12, 9 Barcelona'						,'2000-07-11',18000,'938740703',NULL)

-- DADES D'EMPLEATS DEPT 7 - Comercial
		,(21,7,21,'Marc','Cameron','Callaghan','Mediterrani 111, 1 Barcelona'				,'1980-05-24',45000,'938740801','5000-0017-4766-7435')
		,(22,7,22,'Xènia','Kumar','Ray','Elba 232, 1 Barcelona'								,'1985-08-11',35000,'938740802','5000-0017-4855-6328')
		,(23,7,23,'Saidou','Antar','Morcos','Garona 16, 12 Barcelona'						,'1996-07-25',35000,'938740803','5000-0017-1122-5468')
		,(29,7,2,'Ona','Cortina','Garrett','Centelles 543, 6 Barcelona'						,'1975-03-08',20000,'938740804','5000-0017-3344-4872')
		,(31,7,20,'Jorgina','Avilers','Cortina','Centelles 543, 6 Barcelona'				,'2002-10-17',18000,'938740805',NULL)

-- DADES D'EMPLEATS DEPT 8 - RRHH
		,(24,8,24,'Fatima','Bracamonte','Papadopoulus', 'Lepant 327, 1 Barcelona'			,'1965-09-06',45000,'938740901','5000-0018-7496-3614' )
		,(25,8,25,'Nicolai','Rytas','Yanovich','Còrcega 31, 1 Barcelona'					,'1982-04-27',35000,'938740902','5000-0018-4769-4163' )

-- DADES D'EMPLEATS DEPT 9 - Neteja
		,(26,9,26,'Mireia','Rojo','Callus','Rosselló 55, 6 Barcelona'						,'1955-10-15',19000,'938741001',NULL)
		,(27,9,26,'Jordi','Casp','Valldaura','Indústria 77, 3 Barcelona'					,'1999-12-23',19000,'938741002',NULL);

		
-- ------------------------------
-- DADES DE L'AGENDA DE LA VÍCTIMA
-- ------------------------------
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-12 00:00', 'Comprar regal');
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-12 12:00', 'Reunió departament');
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-12 13:00', 'Visita concessionari de cotxes');

INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-13 00:00', 'Aniversari Fran Abbot');
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-13 09:30', 'Notari - posposat, pendent de nova data.');
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-13 10:30', 'Reunió Xavier Sevilla ');
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-13 13:00', 'Visita concessionari de cotxes');
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-15 15:30', 'Assessorament genètic - Vall Hebrón Planta Baixa');

INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-14 11:00', 'Reunió Dr Oliver - Vall Hebrón (Dr papa) Planta 2');
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-14 13:35', 'Entrevista Novartis (Basilea)');
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-14 13:00', 'Visita concessionari de cotxes');


INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-15 9:30', 'Reunió Fatima Bracamonte');
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-15 11:00', 'Reunió telemàtica amb Josep Cargol(cap I+D Hipra SA)');
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-15 13:00', 'Visita concessionari de cotxes');
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-15 17:00', 'Reunió telemàtica amb Dolors Massagran(cap I+D Laboratoris Esteve SA)');


INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-16 13:00', 'Dinar aniversari');
INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-16 17:30', 'Reunió Neus Ferrari');


INSERT INTO agenda_victima (data_hora, descripcio) VALUES ('2020-10-19 10:00', "Simpossium Hospital Clínic de Barcelona");


-- ------------------------------------
-- DADES ESDEVENIMENTS
-- ------------------------------------

-- DIA 12

INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-2578-4524','2020-10-12 13:55','Dinar a La Camarga (80€)');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-2578-4524','2020-10-12 14:05','Reserva 2 nits de cap de setmana a una casa rural de la Garrotxa');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-2578-4524','2020-10-12 18:22','Supermercat Bon Preu Esclat');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-2578-4524','2020-10-12 18:58','Compra regal aniversari 30€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-5577-2183','2020-10-12 18:41','Supermercat Bon Preu Esclat');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-5687-2248','2020-10-12 9:42','Càpsules Nespresso');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-8899-3354','2020-10-12 19:07','500€ apostes esportives');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-4765-1234','2020-10-12 18:34','Cerveseria El Traguinyol 15€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0016-4224-2605','2020-10-12 18:20','Bar la Cantonada 35€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-1122-5468','2020-10-12 20:08','Portàtil HP');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-3344-4872','2020-10-12 18:20','Supermercat LIDL');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-3344-4872','2020-10-12 18:42','Supermercat ALDI');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-4855-6328','2020-10-12 19:04','Bicicleta estàtica Decathlon');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 2),'2020-10-12 9:40','Cafetera Nespresso ( 150€)');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 2),'2020-10-12 9:44','Material de laboratori a Fisher Scientific SL ( 5.500€)');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 3),'2020-10-12 9:18','Renovació d''equipament de laboratori');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 4),'2020-10-12 14:50','Compra de 3 webcam Logitech');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 7),'2020-10-12 13:20','1 bitllet BCN-SVO 12/10/20 - SVO-BCN 14/10/20');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 7),'2020-10-12 16:05','Material per stand de la Fira de Munich');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 7),'2020-10-12 9:02','Material per stand de la Fira de Munich');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 7),'2020-10-12 9:22','Compra 4 bitllets per BCN-MUNICH 21 MUNICH-BCN 24');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 7),'2020-10-12 9:30','Reserva hotel 2 habitacions dobles del 21 al 24 Munich');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(1,'2020-10-12 11:30');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(1,'2020-10-12 13:08');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(10,'2020-10-12 18:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(10,'2020-10-12 9:04');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(11,'2020-10-12 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(11,'2020-10-12 8:56');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-12 13:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-12 14:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-12 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-12 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(13,'2020-10-12 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(13,'2020-10-12 8:58');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(14,'2020-10-12 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(14,'2020-10-12 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(15,'2020-10-12 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(15,'2020-10-12 9:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(16,'2020-10-12 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(16,'2020-10-12 8:55');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(17,'2020-10-12 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(17,'2020-10-12 8:58');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(18,'2020-10-12 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(18,'2020-10-12 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(19,'2020-10-12 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(19,'2020-10-12 9:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(2,'2020-10-12 11:57');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(2,'2020-10-12 12:43');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(2,'2020-10-12 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(2,'2020-10-12 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(21,'2020-10-12 15:35');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(21,'2020-10-12 9:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(22,'2020-10-12 18:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(22,'2020-10-12 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(23,'2020-10-12 18:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(23,'2020-10-12 9:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(24,'2020-10-12 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(24,'2020-10-12 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(25,'2020-10-12 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(25,'2020-10-12 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(26,'2020-10-12 12:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(26,'2020-10-12 21:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(28,'2020-10-12 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(28,'2020-10-12 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(29,'2020-10-12 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(29,'2020-10-12 8:55');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-12 13:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-12 14:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-12 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-12 8:56');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-12 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-12 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(31,'2020-10-12 18:04');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(31,'2020-10-12 8:55');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(4,'2020-10-12 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(4,'2020-10-12 9:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-12 13:06');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-12 14:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-12 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-12 9:32');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(6,'2020-10-12 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(6,'2020-10-12 8:56');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(7,'2020-10-12 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(7,'2020-10-12 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(8,'2020-10-12 18:04');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(8,'2020-10-12 9:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(9,'2020-10-12 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(9,'2020-10-12 9:01');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(1,'2020-10-12 11:38','Resum pressupostos lloc i càtering 50è Aniversari Xifols');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(3,'2020-10-12 9:06','Canvis de en la producció de la vacuna del virus Ébola.docx');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(5,'2020-10-12 9:19','Cancer: Principles & Practices of Oncology');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(7,'2020-10-12 14:10',' Targeta embarcament BCN-SVO 12/10/20 - SVO-BCN 14/10/20');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(7,'2020-10-12 9:00','Ordre del dia de la reunió de departament 121020-10.docx');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(7,'2020-10-12 9:35','previsió de vendes Any 2021.xlsx');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(7,'2020-10-12 9:40','reunió de departament  COM 121020-10.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(10,'2020-10-12 10:35','Estratègies per al tractament del pain.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(11,'2020-10-12 12:09','Dossier Noves estratègies pel diagnòstic i tractament de la infecció del pian.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(12,'2020-10-12 11:39','Apartaments a la Costa Brava.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(13,'2020-10-12 9:42','Cancer: The Facts.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(14,'2020-10-12 9:23','Cancer: Principles & Practices of Oncology.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(2,'2020-10-12 10:02','Pressupost Hotel W Barcelona.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(2,'2020-10-12 10:08','Pressupost Juvany Events');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(2,'2020-10-12 10:18','Pressupost Hotel Miramar de Barcelona.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(2,'2020-10-12 10:30','Pressupost Cavas Codorniu.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(2,'2020-10-12 9:07','Renovació de contractes amb proveïdors.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(2,'2020-10-12 9:58','Pressupost Mas Marroch.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(21,'2020-10-12 9:05','actualitzció testament.pdf ');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(21,'2020-10-12 9:09','Prova de paternitat - Laboratoris  ECHEVARNE.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(21,'2020-10-12 9:50','Article What are Novichok agents and what do they do.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(21,'2020-10-12 9:53','Pharmacology & Toxicology.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(22,'2020-10-12 9:05','reunió de departament 121020-10.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(22,'2020-10-12 9:35','previsió de vendes Any 2021.xlsx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(23,'2020-10-12 11:20','Tarifes 2019.xlsx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(23,'2020-10-12 9:05','Propostes eslògans 2021.pptx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(23,'2020-10-12 9:39','previsió de vendes Any 2021.xlsx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(23,'2020-10-12 9:40','ordre del dia de la reunió de departament 121020-10.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(28,'2020-10-12 10:00','Ordre del dia de la reunió de departament I+D 121020-12.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(3,'2020-10-12 10:09','Ordre del dia de la reunió de departament I+D 121020-12.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(3,'2020-10-12 10:17','Informe de assajos preclínics SARS-CoV2.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(3,'2020-10-12 10:25','Resultats del coltiu bacterià.xlsx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(3,'2020-10-12 10:37','Procediments en Microbiologia clínica.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(3,'2020-10-12 11:14',' Millors Cases Rurals Alta Garrotxa.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(31,'2020-10-12 9:00','Ordre del dia de la reunió de departament 121020-10.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(31,'2020-10-12 9:18','Tècniques de venda aplicades a la indústrica farmacèutica.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(4,'2020-10-12 10:12','Ordre del dia de la reunió de departament I+D 121020-12.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(5,'2020-10-12 10:00','Ordre del dia de la reunió de departament I+D 121020-12.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(5,'2020-10-12 17:26','Treball 1BAT Física.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(5,'2020-10-12 17:35','Treballl4ESO Biologia.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(6,'2020-10-12 11:13','Proposta augment salarial Ben Harris.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(7,'2020-10-12 9:16','Review anàlisi de teixits biològics.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(8,'2020-10-12 9:24','Review anàlisi de fluids.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(9,'2020-10-12 10:10','Estratègies per al diagnòsic de la infecció del pain.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(9,'2020-10-12 9:10','Noves mesures de prevenció del SARS-CoV-2.pdf');
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('+495611063366','938740802','2020-10-12 14:30','2020-10-12 14:36');
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('+495611063366','938740804','2020-10-12 14:30',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('+498994920720','938740804','2020-10-12 14:08',TIMESTAMPADD(MINUTE,10,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('931288000','938740801','2020-10-12 11:10','2020-10-12 11:15');
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740102','932811600','2020-10-12 10:15',TIMESTAMPADD(MINUTE,3,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740102','932952800','2020-10-12 9:59',TIMESTAMPADD(MINUTE,3,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740102','935403355','2020-10-12 9:44',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740102','938126810','2020-10-12 10:04',TIMESTAMPADD(MINUTE,3,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740102','938740101','2020-10-12 11:34',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740102','938913342','2020-10-12 10:26',TIMESTAMPADD(MINUTE,3,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740102','972394234','2020-10-12 9:55',TIMESTAMPADD(MINUTE,3,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740203','2020-10-12 9:08',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740301','938740302','2020-10-12 9:02',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740301','938740303','2020-10-12 9:03',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740301','938740304','2020-10-12 11:24',TIMESTAMPADD(MINUTE,3,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740301','938740304','2020-10-12 9:04',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740301','938740901','2020-10-12 11:08',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740303','938740302','2020-10-12 11:01',TIMESTAMPADD(MINUTE,4,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740304','938740301','2020-10-12 11:01',TIMESTAMPADD(MINUTE,4,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740401','938740403','2020-10-12 10:48',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740402','938740401','2020-10-12 10:38',TIMESTAMPADD(MINUTE,6,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740801','938740803','2020-10-12 11:16','2020-10-12 11:18');
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740801','938740804','2020-10-12 11:05','2020-10-12 11:06');
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740802','935573500','2020-10-12 11:24','2020-10-12 11:25');
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740803','931288000','2020-10-12 11:23',TIMESTAMPADD(MINUTE,3,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740804','+498995468633','2020-10-12 9:24',TIMESTAMPADD(MINUTE,5,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740804','+74952217777','2020-10-12 12:55',TIMESTAMPADD(MINUTE,10,hora_inici));

-- DIA 13

INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0011-3456-3259','2020-10-13 9:35','Cafegeria Engrunes 8.25€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0011-7484-3259','2020-10-13 19:00','Supermercat Carrefour 55€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-2578-4524','2020-10-13 18:49','Carinsessia Cal Joan 80€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-5577-2183','2020-10-13 13:55','3 menús Restaurant El Ginjoler 40€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-5577-2183','2020-10-13 19:06','Reserva 2 nits habitació doble a l''Hotel Majèstic de BCN pel dia 20 Nov.');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-5577-2183','2020-10-13 21:30','Restaurant Koy Shunka 2 persones - 150€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-5577-2183','2020-10-13 8:58','Fleca i pastisseria Cal Forner 25€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-8899-3354','2020-10-13 18:20','Compra de loteria ONCE 15€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-8899-3354','2020-10-13 20:37',' Intercanvi de fitxes Casino BCN 60€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-4712-4321','2020-10-13 18:44','Queviures Pla de l''hort 70€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-4765-1234','2020-10-13 18:30','Cerveseria El Traguinyol 20€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-4765-1234','2020-10-13 21:35','Compra 3 ampolles Cutty Sark a la Bezinera Ronda del General Mitre 128 35€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-5588-5635','2020-10-13 18:09','Supermercat Carrefour 60€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-5588-5635','2020-10-13 18:59',' Perruqueria El teu estil 110€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-7732-9874','2020-10-13 13:50','Menú diari al Resturant La Camarga 15€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-7732-9874','2020-10-13 8:55','Ram de roses (40€) per entrega el dia 15 Oct. al Laboratori de l''''empresa');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-1234-5544','2020-10-13 18:21','Bicicleta plegable 350€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-1234-5544','2020-10-13 19:20','Reserva 4 entrades Aquarium Barcelona 13 Nov.');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-1234-5544','2020-10-13 19:41','Compra 50€ a la Drogueria/Ferreteria Els tres porquets');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-1234-5544','2020-10-13 8:51','Bitllet TMB T-CASUAL');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-5429-7752','2020-10-13 18:31','Bitllet de T-CASUAL');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-5429-7752','2020-10-13 20:24','Pizzes per emportar Don Giovanni 8€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-8874-4451','2020-10-13 18:37','2 entrades al Teatre Lliure');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-8874-4451','2020-10-13 19:10','4 entrades exposició temporal al Museu Nacional Art de Catalunya MNAC');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0015-5478-4455','2020-10-13 13:50','Dinar a La Camarga (83€)');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0015-5478-4455','2020-10-13 18:44','Entrada al cinema 6.80€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0016-7899-7712','2020-10-13 18:45','Bar la Cantonada 35€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 1),'2020-10-13 9:24','Càtering al Mas Marroch per la cel·lebració del 50è aniversari de l''''empersa');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 3),'2020-10-13 12:35','Compra de material de laboratori 500€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 5),'2020-10-13 13:10','Mostres de tractament del càncer de pulmó');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 6),'2020-10-13 11:55','Creació d''una compte corporativa a AWS');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 6),'2020-10-13 11:59','Creació d''una compte corporativa a Azure');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 6),'2020-10-13 12:16',' En David Burman compra 5 llicències Oracle 6000€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 6),'2020-10-13 12:42',' La Victoria Ganim compra punts d''accés Ubiquiti 600€');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(1,'2020-10-13 14:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(1,'2020-10-13 9:49');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(10,'2020-10-13 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(10,'2020-10-13 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(11,'2020-10-13 18:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(11,'2020-10-13 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-13 13:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-13 13:55');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-13 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-13 9:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(13,'2020-10-13 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(13,'2020-10-13 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(14,'2020-10-13 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(14,'2020-10-13 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(15,'2020-10-13 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(15,'2020-10-13 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(16,'2020-10-13 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(16,'2020-10-13 8:56');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(17,'2020-10-13 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(17,'2020-10-13 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(18,'2020-10-13 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(18,'2020-10-13 9:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(19,'2020-10-13 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(19,'2020-10-13 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(2,'2020-10-13 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(2,'2020-10-13 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(22,'2020-10-13 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(22,'2020-10-13 9:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(23,'2020-10-13 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(23,'2020-10-13 9:06');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(24,'2020-10-13 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(24,'2020-10-13 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(25,'2020-10-13 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(25,'2020-10-13 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(26,'2020-10-13 13:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(26,'2020-10-13 21:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(27,'2020-10-13 13:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(27,'2020-10-13 21:30');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(28,'2020-10-13 13:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(28,'2020-10-13 14:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(28,'2020-10-13 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(28,'2020-10-13 9:12');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(29,'2020-10-13 18:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(29,'2020-10-13 9:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-13 13:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-13 13:55');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-13 15:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-13 17:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-13 18:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-13 9:49');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-13 13:20');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-13 13:55');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-13 18:04');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-13 9:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(31,'2020-10-13 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(31,'2020-10-13 8:55');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(4,'2020-10-13 13:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(4,'2020-10-13 14:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(4,'2020-10-13 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(4,'2020-10-13 9:06');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-13 10:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-13 13:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-13 14:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-13 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(6,'2020-10-13 18:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(6,'2020-10-13 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(7,'2020-10-13 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(7,'2020-10-13 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(8,'2020-10-13 18:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(8,'2020-10-13 9:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(9,'2020-10-13 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(9,'2020-10-13 9:00');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(1,'2020-10-13 9:02','Nous estatus de l''''empresa');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(2,'2020-10-13 17:48','Apunts matemàtiques 1BAT.docx');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(4,'2020-10-13 12:14','Efectes negatius d''espais tancats per la transmissió del SARS-Cov2.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(1,'2020-10-13 9:57','Baixa per malaltia greu.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(10,'2020-10-13 11:45','Fases de control de pandèmies.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(13,'2020-10-13 12:30','Estudi del càncer de mama.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(13,'2020-10-13 12:57','Nova quimioteràpia per els càncers més agressius.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(14,'2020-10-13 11:49','El càncer en fases inicials.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(14,'2020-10-13 12:09','El càncer en fases avançades.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(15,'2020-10-13 11:52','IT Management.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(16,'2020-10-13 12:05','Pressupost de nous equips de desenvolupadors.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(17,'2020-10-13 11:55','Manual Java 12.5.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(17,'2020-10-13 12:26','Integració contínua mitjançant Jenkins');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(18,'2020-10-13 12:11','Pressupost de llicències Oracle');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(19,'2020-10-13 11:41','Manual de CISCO 600.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(19,'2020-10-13 12:20','Manual de configuaració de Firewall Juniper');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(2,'2020-10-13 11:27','Despeses 50è Aniversari.xlsx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(2,'2020-10-13 9:31','Pressupost actuació musical 50è Aniversari.xlsx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(2,'2020-10-13 9:51','Pressupost actuació teatral 50è Aniversari.xlsx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(22,'2020-10-13 10:41','Tècniques de venda en l''entorn farmacèutic.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(22,'2020-10-13 9:14','Targeta embarcament BCN-MUNICH 21 MUNICH-BCN 24.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(23,'2020-10-13 10:14','Eslògans de vacunació.pptx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(23,'2020-10-13 17:03','Targeta embarcament BCN-MUNICH 21 MUNICH-BCN 24.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(28,'2020-10-13 16:13','Apostes destacades de bet365');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(28,'2020-10-13 16:26','Inivició de la proteïna P578.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(3,'2020-10-13 11:07','Simpossium i conferència Hospital Clínic de Barcelona 2020-10-19.pptx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(30,'2020-10-13 12:33','Pressupost de material de laboratori demanat per Guillermina Fructuos.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(30,'2020-10-13 9:14','ordre del dia de la reunió de departament Laboratori 131020-10.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(31,'2020-10-13 11:08','Principals objectius en una venda.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(31,'2020-10-13 12:43','Targeta embarcament BCN-MUNICH 21 MUNICH-BCN 24.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(5,'2020-10-13 17:44','Resum dels llibres de text 4ESO.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(6,'2020-10-13 9:09','ordre del dia de la reunió de departament Laboratori 131020-10.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(6,'2020-10-13 9:14','Resultats de la vaccina Test1 SARS-Cov2');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(7,'2020-10-13 13:07','Mesures pel tractament de l''''alcoholisme.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(7,'2020-10-13 13:47','Review de la producció del fàrmac 6Q700.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(7,'2020-10-13 9:03','ordre del dia de la reunió de departament Laboratori 061020-10.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(7,'2020-10-13 9:06','ordre del dia de la reunió de departament Laboratori 131020-10.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(8,'2020-10-13 12:57','Planificació de producció del fàrmac K560.xlsx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(8,'2020-10-13 9:16','ordre del dia de la reunió de departament Laboratori 131020-10.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(9,'2020-10-13 11:40','Fases de control de pandèmies.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(9,'2020-10-13 12:06','Propostes de restriccions de mobilitat v9.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(9,'2020-10-13 15:07','I+D aplicat a les pandèmies.pdf');
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740101','678525477','2020-10-13 9:55',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740101','938740901','2020-10-13 9:58',TIMESTAMPADD(MINUTE,10,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','678525477','2020-10-13 9:52',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740203','2020-10-13 9:55',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740501','2020-10-13 17:45',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740601','2020-10-13 12:07',TIMESTAMPADD(MINUTE,5,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740801','2020-10-13 9:51',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740901','2020-10-13 9:56',TIMESTAMPADD(MINUTE,5,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740203','938740204','2020-10-13 14:52',TIMESTAMPADD(MINUTE,4,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740204','938740202','2020-10-13 16:29',TIMESTAMPADD(MINUTE,8,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740204','938740902','2020-10-13 12:42',TIMESTAMPADD(MINUTE,5,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740302','938740202','2020-10-13 12:26',TIMESTAMPADD(MINUTE,7,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740302','938740303','2020-10-13 14:51',TIMESTAMPADD(MINUTE,6,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740303','938740304','2020-10-13 12:30',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740304','938740302','2020-10-13 16:05',TIMESTAMPADD(MINUTE,4,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740401','938740201','2020-10-13 13:52',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740401','938740201','2020-10-13 15:00',TIMESTAMPADD(MINUTE,6,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740401','938740402','2020-10-13 11:41',TIMESTAMPADD(MINUTE,1,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740403','938740401','2020-10-13 11:29',TIMESTAMPADD(MINUTE,5,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740503','938740502','2020-10-13 14:13',TIMESTAMPADD(MINUTE,9,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740602','938740601','2020-10-13 12:06',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740603','938740701','2020-10-13 12:48',TIMESTAMPADD(MINUTE,5,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740701','938740601','2020-10-13 12:13',TIMESTAMPADD(MINUTE,1,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740702','938740701','2020-10-13 12:24',TIMESTAMPADD(MINUTE,5,hora_inici));

-- DIA 14

INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-2578-4524','2020-10-14 13:53','Dinar a La Camarga (79€)');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-8899-3354','2020-10-14 20:00',' Inscripció al campionat de pòker BCN 200€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-4765-1234','2020-10-14 18:53','Vins i licors Grau 50€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-5588-5635','2020-10-14 11:39','Bizum 10€ a Àlex Arenas');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-7732-9874','2020-10-14 11:26','Bizum 10€ a Àlex Arenas');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0016-9954-2147','2020-10-14 18:55','Bar la Cantonada 35€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-4766-7435','2020-10-14 7:30','25€ caixa Matrioska de Yakelus');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-4766-7435','2020-10-14 7:31','4€ Cafeteria a Sheremétievo');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 1),'2020-10-14 10:23','Regal de jubilació 2.000€');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(10,'2020-10-14 18:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(10,'2020-10-14 8:58');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(11,'2020-10-14 18:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(11,'2020-10-14 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-14 13:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-14 14:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-14 18:12');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-14 8:50');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(13,'2020-10-14 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(13,'2020-10-14 9:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(14,'2020-10-14 18:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(14,'2020-10-14 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(15,'2020-10-14 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(15,'2020-10-14 8:58');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(16,'2020-10-14 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(16,'2020-10-14 9:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(17,'2020-10-14 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(17,'2020-10-14 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(18,'2020-10-14 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(18,'2020-10-14 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(19,'2020-10-14 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(19,'2020-10-14 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(2,'2020-10-14 18:22');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(2,'2020-10-14 9:08');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(21,'2020-10-14 14:13');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(21,'2020-10-14 18:36');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(22,'2020-10-14 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(22,'2020-10-14 9:19');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(23,'2020-10-14 18:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(23,'2020-10-14 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(24,'2020-10-14 18:04');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(24,'2020-10-14 8:57');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(25,'2020-10-14 18:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(25,'2020-10-14 8:57');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(26,'2020-10-14 13:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(26,'2020-10-14 21:24');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(27,'2020-10-14 13:06');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(27,'2020-10-14 21:22');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(28,'2020-10-14 18:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(28,'2020-10-14 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(29,'2020-10-14 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(29,'2020-10-14 8:58');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-14 10:30');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-14 12:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-14 13:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-14 14:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-14 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-14 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-14 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-14 8:57');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(31,'2020-10-14 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(31,'2020-10-14 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(4,'2020-10-14 18:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(4,'2020-10-14 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-14 17:58');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-14 9:39');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(6,'2020-10-14 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(6,'2020-10-14 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(7,'2020-10-14 18:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(7,'2020-10-14 9:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(8,'2020-10-14 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(8,'2020-10-14 8:58');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(9,'2020-10-14 18:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(9,'2020-10-14 8:57');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(8,'2020-10-14 10:00','Informe de l''últim any  de les entrades i sortides dels empleats del departament I+D');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(8,'2020-10-14 10:06','Certificat jubilació Mireia Rojo.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(12,'2020-10-14 14:23','Passos per aconseguir el permís de residència Suïssa.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(12,'2020-10-14 14:49','Preus apartaments per dues persones a Basilea.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(15,'2020-10-14 10:37','Augment de sou del 200% a Leonard Cameron.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(21,'2020-10-14 16:40','Propostes eslògans de vacunació.pptx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(3,'2020-10-14 12:30','Curriculum Vitae.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(6,'2020-10-14 9:35','Planificació de fabricació d''una vaccina contra SARS-Cov2');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(9,'2020-10-14 12:18','Propostes de restriccions de mobilitat v10.docx');
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','+41613241111','2020-10-14 12:35',TIMESTAMPADD(MINUTE,15,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740203','2020-10-14 9:15',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740301','2020-10-14 12:08',TIMESTAMPADD(MINUTE,6,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740801','2020-10-14 12:07',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740901','2020-10-14 9:16',TIMESTAMPADD(MINUTE,5,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740301','938740302','2020-10-14 9:39',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740302','938740303','2020-10-14 11:27',TIMESTAMPADD(MINUTE,1,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740302','938740303','2020-10-14 9:42',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740302','938740304','2020-10-14 11:25',TIMESTAMPADD(MINUTE,1,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740601','938740102','2020-10-14 10:38',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740601','938740901','2020-10-14 10:39',TIMESTAMPADD(MINUTE,8,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740801','938740803','2020-10-14 16:34',TIMESTAMPADD(MINUTE,5,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740801','938740804','2020-10-14 14:24',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740802','938740901','2020-10-14 9:15',TIMESTAMPADD(MINUTE,1,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740901','938740201','2020-10-14 10:01',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740901','938741001','2020-10-14 15:43',TIMESTAMPADD(MINUTE,5,hora_inici));

-- DIA 15

INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0011-7484-3259','2020-10-15 8:56','Autopista Barcelona - Saragossa ');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-2578-4524','2020-10-15 19:45','2 Entrades al Teatre Victoria BCN');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-2578-4524','2020-10-15 22:16','Restaurant Botafumeiro 2 pers. 140€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-4712-4321','2020-10-15 18:40','Compra a Amazon d''una maleta');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-7732-9874','2020-10-15 13:35','menú diari a La Camarga 15€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-7732-9874','2020-10-15 18:17','Supermercat Bon Preu / Esclat 85€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-7732-9874','2020-10-15 18:20','Estoig de 4 Ganivets Professional Wüsthof steak 12 cm');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-7732-9874','2020-10-15 18:28','Carnisseria el Brasó - Entrecot de vaca vella madurada a 50 dies. 80€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-7732-9874','2020-10-15 18:33','Peixetaria ROS 85€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0015-1230-5634','2020-10-15 18:35','1 entrada al cinema');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0015-5478-4455','2020-10-15 13:58','Dinar a La Camarga (95€)');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0016-4475-1245','2020-10-15 18:40','Bar la Cantonada 35€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-1122-5468','2020-10-15 18:50','Farmàcia Paracetamol 500mg');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-3344-4872','2020-10-15 18:26','Test Clear Blue 3€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-3344-4872','2020-10-15 19:02','Botiga de mascotes el Peluix 85€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-4766-7435','2020-10-15 13:47','4 menús al Restaurant El Fumet de peix');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0018-7496-3614','2020-10-15 20:00','Pizzeria Di Napoli 50€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 3),'2020-10-15 10:26','Ben Harris compra material de laboratori 1000€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 3),'2020-10-15 10:37',' Ben Harris compra material per distribució de vacunes 2000€');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(10,'2020-10-15 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(10,'2020-10-15 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(11,'2020-10-15 18:06');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(11,'2020-10-15 9:06');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-15 13:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-15 14:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-15 18:09');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-15 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(13,'2020-10-15 18:06');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(13,'2020-10-15 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(14,'2020-10-15 18:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(14,'2020-10-15 8:57');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(15,'2020-10-15 18:09');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(15,'2020-10-15 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(16,'2020-10-15 18:09');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(16,'2020-10-15 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(17,'2020-10-15 18:09');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(17,'2020-10-15 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(18,'2020-10-15 18:09');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(18,'2020-10-15 9:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(19,'2020-10-15 18:09');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(19,'2020-10-15 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(21,'2020-10-15 13:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(21,'2020-10-15 14:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(21,'2020-10-15 18:55');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(21,'2020-10-15 9:12');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(23,'2020-10-15 13:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(23,'2020-10-15 14:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(23,'2020-10-15 18:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(23,'2020-10-15 9:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(24,'2020-10-15 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(24,'2020-10-15 8:55');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(25,'2020-10-15 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(25,'2020-10-15 8:56');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(26,'2020-10-15 12:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(26,'2020-10-15 22:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(27,'2020-10-15 12:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(27,'2020-10-15 22:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(28,'2020-10-15 18:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(28,'2020-10-15 8:58');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(29,'2020-10-15 13:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(29,'2020-10-15 14:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(29,'2020-10-15 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(29,'2020-10-15 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-15 13:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-15 14:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-15 18:09');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-15 8:56');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-15 13:16');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-15 13:40');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-15 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-15 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(31,'2020-10-15 13:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(31,'2020-10-15 14:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(31,'2020-10-15 18:04');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(31,'2020-10-15 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(4,'2020-10-15 18:04');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(4,'2020-10-15 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-15 18:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-15 9:44');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(6,'2020-10-15 18:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(6,'2020-10-15 8:56');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(7,'2020-10-15 18:04');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(7,'2020-10-15 9:20');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(8,'2020-10-15 18:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(8,'2020-10-15 8:56');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(9,'2020-10-15 18:04');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(9,'2020-10-15 8:59');
INSERT INTO impressions(departament_id,data_hora,document) VALUES(8,'2020-10-15 10:16','Carta acomiadament Neus.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(18,'2020-10-15 10:41','Permís de paternitat 30 octubre.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(21,'2020-10-15 18:22','Lloguer veler BCN-Menorca 19 octubre');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(24,'2020-10-15 9:26','Baixa de maternitat efectiva 12 Nov. per Maria Veronia Cabello.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(25,'2020-10-15 9:35','Preparació de les nòmines del mes octubre');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(28,'2020-10-15 9:10','ordre del dia de la reunió de departament I+D 151020-12.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(29,'2020-10-15 17:43','Símptomes embaràs.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(4,'2020-10-15 9:04','ordre del dia de la reunió de departament I+D 151020-12.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(5,'2020-10-15 10:10','ordre del dia de la reunió de departament I+D 151020-12.docx');
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('65546765','938740901','2020-10-15 9:10',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('935403355','938740201','2020-10-15 10:02',TIMESTAMPADD(MINUTE,10,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740203','2020-10-15 10:00',TIMESTAMPADD(MINUTE,1,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740301','2020-10-15 17:56',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740501','2020-10-15 18:01',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740901','2020-10-15 9:35',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740301','938740304','2020-10-15 10:17',TIMESTAMPADD(MINUTE,1,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740501','932184230','2020-10-15 16:58',TIMESTAMPADD(MINUTE,1,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740801','938740201','2020-10-15 16:34',TIMESTAMPADD(MINUTE,3,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740901','938740201','2020-10-15 10:17',TIMESTAMPADD(MINUTE,3,hora_inici));

-- DIA 16

INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0011-7484-3259','2020-10-16 18:30',' Compra supermercat Caprabo 60€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-2578-4524','2020-10-16 13:50','Dinar al Restaurant Brugarol (75€)');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-5577-2183','2020-10-16 18:20',' Compra supermercat Mercadona 32€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-8899-3354','2020-10-16 18:45','Compra La Quiniela 60€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0012-8899-3354','2020-10-16 20:11',' Casino Barcelona 350€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-4712-4321','2020-10-16 18:52','Compra de marisc fresc El Capità de Mar 150€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-4712-4321','2020-10-16 19:00','Supermercat el Gourmet 82€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-4712-4321','2020-10-16 8:50','Fleca i pastisseria Cal Forner 45€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-4765-1234','2020-10-16 19:03','Bodega el Buen Vino 90€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-5588-5635','2020-10-16 20:46',' Sushi per emportar 80€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0013-7732-9874','2020-10-16 20:49',' Pizza per emportar 12€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-1234-5544','2020-10-16 19:55','2 entrades cinema');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-1234-5544','2020-10-16 21:00','Restaruant El saber estar');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-5429-7752','2020-10-16 19:56',' Crispetes per a dues persones');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-5429-7752','2020-10-16 21:00','Restaruant El saber estar');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0014-8874-4451','2020-10-16 20:25','Verdures i llegums Hort de Casa 72€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0015-0014-9871','2020-10-16 20:47','Llibreria Geli 40€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0015-1230-5634','2020-10-16 21:07',' Llibreria 22 25€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0015-5478-4455','2020-10-16 18:57','Perfumeria San Remo 60€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0015-5478-4455','2020-10-16 19:15','Compra de roba d''hivern 110€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0016-4224-2605','2020-10-16 21:43',' Oculus Rift');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0016-5588-4897','2020-10-16 18:38','Bar la Cantonada 15€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0016-7899-7712','2020-10-16 18:59','Bar la Cantonada 12€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0016-7899-7712','2020-10-16 21:51','Enginyeria del software - Patrons de disseny');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0016-9954-2147','2020-10-16 20:00','Mensualitat de classes de guitarra');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-1122-5468','2020-10-16 19:09','Compra botiga de menjar asiàtic 50€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-3344-4872','2020-10-16 19:02',' Compra Predictor Early 5 €');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-3344-4872','2020-10-16 20:04','Hamburgueseria El Caliu 50€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-4766-7435','2020-10-16 19:08','Compra de marisc fresc El Capità de Mar 250€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-4766-7435','2020-10-16 19:15',' 2 botelles Château Saint-Aubin Meursaul');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-4855-6328','2020-10-16 18:40','Compra de peix fresc a la Peixeteria Rosa');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0017-4855-6328','2020-10-16 18:52',' Saló de Bellesa 90€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0018-4769-4163','2020-10-16 21:23','Restaurant El Veler 80€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES('5000-0018-7496-3614','2020-10-16 20:55','Entrada al Liceu');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 2),'2020-10-16 9:18','Caixa de bombons i roses');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 7),'2020-10-16 13:15','Compra de material oficina');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 9),'2020-10-16 10:51','Compra Drogueria 60€');
INSERT INTO compres(targeta_credit,data_hora,descripcio) VALUES((SELECT targeta_credit FROM departaments WHERE departament_id = 9),'2020-10-16 11:17','Compra Bon Preu / Esclat 90€');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(10,'2020-10-16 14:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(10,'2020-10-16 22:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(10,'2020-10-16 9:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(10,'2020-10-16 9:17');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(11,'2020-10-16 18:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(11,'2020-10-16 8:57');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-16 18:13');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(12,'2020-10-16 9:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(13,'2020-10-16 18:10');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(13,'2020-10-16 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(14,'2020-10-16 18:09');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(14,'2020-10-16 8:58');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(15,'2020-10-16 18:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(15,'2020-10-16 9:04');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(16,'2020-10-16 18:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(16,'2020-10-16 9:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(17,'2020-10-16 18:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(17,'2020-10-16 8:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(18,'2020-10-16 18:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(18,'2020-10-16 18:41');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(18,'2020-10-16 21:20');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(18,'2020-10-16 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(19,'2020-10-16 18:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(19,'2020-10-16 18:41');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(19,'2020-10-16 21:20');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(19,'2020-10-16 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(2,'2020-10-16 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(2,'2020-10-16 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(21,'2020-10-16 18:45');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(21,'2020-10-16 9:06');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(22,'2020-10-16 18:15');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(22,'2020-10-16 9:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(23,'2020-10-16 19:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(23,'2020-10-16 9:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(24,'2020-10-16 18:38');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(24,'2020-10-16 8:58');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(25,'2020-10-16 18:02');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(25,'2020-10-16 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(26,'2020-10-16 13:15');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(26,'2020-10-16 22:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(27,'2020-10-16 13:15');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(27,'2020-10-16 21:56');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(28,'2020-10-16 18:17');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(28,'2020-10-16 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-16 12:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-16 13:55');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-16 9:05');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-16 9:15');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(3,'2020-10-16 9:27');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(30,'2020-10-16 9:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(4,'2020-10-16 9:01');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-16 18:12');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(5,'2020-10-16 9:52');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(6,'2020-10-16 12:59');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(6,'2020-10-16 13:55');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(6,'2020-10-16 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(6,'2020-10-16 9:07');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(7,'2020-10-16 11:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(7,'2020-10-16 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(8,'2020-10-16 18:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(8,'2020-10-16 9:03');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(9,'2020-10-16 19:00');
INSERT INTO fitxatges(empleat_id, data_hora) VALUES(9,'2020-10-16 9:30');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(21,'2020-10-16 15:53','Beneficis acumulats - Apartat antihistamínics');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(21,'2020-10-16 16:23',' Noves estratègies de mercat.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(21,'2020-10-16 17:12','Inforrme de com involucarar el departament de I+D en el procés de venda com impuls de marca.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(21,'2020-10-16 9:50','reunió de departament 161020-11.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(22,'2020-10-16 14:53','Objectius a curs termini - 1 any.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(22,'2020-10-16 15:06',' Rappel de vendes 2020.pdf');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(22,'2020-10-16 9:58','reunió de departament 161020-11.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(23,'2020-10-16 10:13','reunió de departament 161020-11.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(29,'2020-10-16 12:09','Pressupost departament comercial 2021.xlsx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(29,'2020-10-16 9:55','reunió de departament 161020-11.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(3,'2020-10-16 16:53','Carta acomiadament Neus.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(3,'2020-10-16 18:06','Captures de pantalla d''un virus CryptoLocker.docx');
INSERT INTO impressions(empleat_id,data_hora,document) VALUES(31,'2020-10-16 9:50','reunió de departament 161020-11.docx');
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('+41613241111','938740201','2020-10-16 10:00',TIMESTAMPADD(MINUTE,16,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('65546765','938740901','2020-10-16 9:00',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','698745258','2020-10-16 18:13',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740203','2020-10-16 17:24',TIMESTAMPADD(MINUTE,1,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740301','2020-10-16 17:58',TIMESTAMPADD(MINUTE,1,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740301','2020-10-16 9:29',TIMESTAMPADD(MINUTE,5,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740201','938740501','2020-10-16 10:18',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740402','938740901','2020-10-16 9:15',TIMESTAMPADD(MINUTE,0,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740501','938740201','2020-10-16 18:09',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740701','938740201','2020-10-16 18:43',TIMESTAMPADD(MINUTE,2,hora_inici));
INSERT INTO trucades(origen,desti,hora_inici,hora_fi) VALUES('938740803','938740701','2020-10-16 18:46',TIMESTAMPADD(MINUTE,3,hora_inici));