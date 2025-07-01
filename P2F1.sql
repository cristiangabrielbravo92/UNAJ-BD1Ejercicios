/*
Ver esquema en Parcial2Fecha1PracticaC2.PDF
Dado el anterior esquema de base de datos:
*/

/* CONSIGNA
En base al modelo de datos anterior escribir: 
*/

/* 1.	Los scripts de SQL para poder crear las tablas, para registrar los datos de un equipo; 
		ordenando su ejecución como corresponda. 
		Ejecutar, antes de la creación de las tablas, un script para crear la base de datos 
		"Campeonato”. Luego usar esa base de datos. */

CREATE DATABASE Campeonato;
USE Campeonato;

CREATE TABLE if NOT EXISTS Estadio (
	ID INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(45) NOT NULL,
	capacidad INT NOT NULL,
	PRIMARY KEY (ID)
	);
	
CREATE TABLE if NOT EXISTS Persona (
	ID INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(45) NOT NULL,
	apellido VARCHAR(45) NOT NULL,
	dni VARCHAR(45) NOT NULL,
	PRIMARY KEY(ID)
	);
	
CREATE TABLE if NOT EXISTS Posicion (
	ID INT NOT NULL AUTO_INCREMENT,
	descripcion VARCHAR(45) NOT NULL UNIQUE,
	PRIMARY KEY(ID)
	);

CREATE TABLE if NOT EXISTS Equipo (
	ID INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(45) NOT NULL,
	estadioID INT NOT NULL,
	dtID INT NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (estadioID) REFERENCES Estadio(ID),
	FOREIGN KEY (dtID) REFERENCES Persona(ID)
	);

-- creación de tabla contrato para el siguiente ítem
CREATE TABLE if NOT EXISTS Contrato (
	ID INT NOT NULL AUTO_INCREMENT,
	fechaInicio DATE NOT NULL,
	fechaFin DATE,
	equipoID INT NOT NULL,
	jugadorID INT NOT NULL,
	posicionID INT NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (equipoID) REFERENCES Equipo(ID),
	FOREIGN KEY (jugadorID) REFERENCES Persona(ID),
	FOREIGN KEY (posicionID) REFERENCES Posicion(ID)
	);
	

/* 2.	Los INSERT necesarios para registrar un equipo con 2 jugadores. 
		Utilizar, como valores de columnas, los ejemplos que deseen. */

INSERT INTO Posicion 
	(descripcion)
	VALUES
	('Arquero'), ('Defensor'), ('Mediocampista'), ('Delantero'), ('DT');

INSERT INTO Estadio
	(nombre, capacidad)
	VALUES 
	('Alberto J Armando', 57200);

INSERT INTO persona
	(nombre, apellido, dni)
	VALUES
	('Miguel Angel', 'Russo',22123456);

INSERT INTO equipo
	(nombre, estadioID, dtID)
	VALUES 
	('Club Atletico Boca Juniors', 1,1)


INSERT INTO persona
	(nombre, apellido, dni)
	VALUES
	('Rodrigo', 'Palacio', 32123456),
	('Juan Román', 'Riquelme', 29123456);
	
INSERT INTO contrato
	(fechaInicio, fechaFin, equipoID, jugadorID, posicionID)
	VALUES 
	('20050101',NULL,1,2,4),
	('20070201',NULL,1,3,3);


/* 3.	Actualizar el nombre del equipo que se registró anteriormente, modificando su valor. */
UPDATE equipo
	SET nombre='Boca Juniors'
	WHERE id=1;


/* 4.	Agregar a la tabla campeonato la columna imagenCopa, de tipo varchar(50), no obligatoria. */
-- creación de tabla campeonato que hasta el momento no se necesitaba
CREATE TABLE if NOT EXISTS  Campeonato (
	ID INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(45) NOT NULL,
	premio INT NOT NULL,
	PRIMARY KEY (ID)
	);

ALTER TABLE campeonato
	ADD COLUMN imagenCopa VARCHAR(45)
	AFTER premio;


/* 5.	Las siguientes consultas SQL: */
/* 	a.	Lista de jugadores de “Gimnasia de la Plata”. Suponer que son jugadores actuales aquellos que tienen 
			fecha de inicio de contrato, pero no tienen fecha de fin. 
			Mostrar nombre, apellido (concatenados), fecha de inicio de contrato y posición. */

-- Cambio en la consulta el listado a jugadores de 'Boca Juniors' para no tener que cargar tantos datos de nuevo			
SELECT CONCAT(p.nombre,' ', p.apellido) AS nombreApellido, c.fechaInicio AS fechaInicio, pos.descripcion AS posicion
	FROM persona p INNER JOIN contrato c INNER JOIN equipo e INNER JOIN posicion pos ON c.jugadorID = p.ID  && c.equipoID = e.ID && c.posicionID = pos.ID
	WHERE e.nombre = 'Boca Juniors' && c.fechaInicio IS NOT NULL && c.fechaFin IS NULL;


/*		b. Los resultados de todos los partidos de la fecha 2 del campeonato que se llama 
			“Liga Profesional 2022”. 
			Mostrar fecha, estadio, equipo, goles, rol. Ordenar por fecha del partido. */

-- creación de tablas faltantes
CREATE TABLE if not EXISTS Fecha (
	ID INT NOT NULL AUTO_INCREMENT,
	numero INT NOT NULL,
	campeonatoID INT NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (campeonatoID) REFERENCES campeonato(ID)
	);

CREATE TABLE if NOT EXISTS Partido (
	ID INT NOT NULL AUTO_INCREMENT,
	fechaHora DATETIME NOT NULL,
	fechaID INT NOT NULL,
	estadioID INT NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (fechaID) REFERENCES Fecha(ID),
	FOREIGN KEY (estadioID) REFERENCES Estadio(ID)
	);
	
CREATE TABLE if NOT EXISTS PartidoEquipo (
	ID INT NOT NULL AUTO_INCREMENT,
	rol VARCHAR(45) NOT NULL,
	goles INT NOT NULL,
	partidoID INT NOT NULL,
	equipoID INT NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (partidoID) REFERENCES Partido(ID),
	FOREIGN KEY (equipoID) REFERENCES Equipo(ID)
	);
	
CREATE TABLE if NOT EXISTS PartidoGoleador (
	ID INT NOT NULL AUTO_INCREMENT,
	minuto TIME NOT NULL,
	partidoID INT NOT NULL,
	goleadorID INT NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (partidoID) REFERENCES partido(ID),
	FOREIGN KEY (goleadorID) REFERENCES persona(ID)
	);	



SELECT * FROM posicion;
SELECT * FROM persona;
SELECT * FROM estadio;
SELECT * FROM equipo;
SELECT * FROM contrato;
SELECT * FROM campeonato;
SELECT * FROM fecha;
SELECT * FROM partido;
SELECT * FROM partidoEquipo;
SELECT * FROM partidoGoleador;




	
	
	
	
	
	
	
	
	
	
	