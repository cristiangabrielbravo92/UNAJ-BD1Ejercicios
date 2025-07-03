/* Ver enunciado en Parcial 2 BD1_2025.pdf */

/* Idea: pasar las tablas normalizadas a una BD antes de hacer las consultas */

CREATE DATABASE P2C12025;
USE P2C12025;

CREATE TABLE if NOT EXISTS Estado(
	ID INT NOT NULL AUTO_INCREMENT,
	descripcion VARCHAR(45) NOT NULL UNIQUE,
	PRIMARY KEY(ID)
	);
	
CREATE TABLE if NOT EXISTS Fabricante(
	ID INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(45) NOT NULL UNIQUE,
	PRIMARY KEY(ID)
	);
	
CREATE TABLE if NOT EXISTS Producto(
	codP INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(45) NOT NULL,
	PRIMARY KEY (codP)
	);
	
CREATE TABLE if NOT EXISTS ProductosEnTienda(
	ID INT NOT NULL AUTO_INCREMENT,
	codPID INT NOT NULL,
	modelo VARCHAR(45),
	estadoID INT NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (codPID) REFERENCES Producto(codP),
	FOREIGN KEY (estadoID) REFERENCES Estado(ID)
	);
	
CREATE TABLE if NOT EXISTS Ubicaciones(
	ID INT NOT NULL AUTO_INCREMENT,
	codPID INT NOT NULL,
	almacen INT NOT NULL,
	seccion VARCHAR(1),
	PRIMARY KEY (ID),
	FOREIGN KEY (codPID) REFERENCES Producto(codP)
	);
	
	
CREATE TABLE if NOT EXISTS FabricantesProductos(
	ID INT NOT NULL AUTO_INCREMENT,
	codPID INT NOT NULL,
	fabricanteID INT NOT NULL, 
	PRIMARY KEY (ID),
	FOREIGN KEY (codPID) REFERENCES Producto(codP),
	FOREIGN KEY (fabricanteID) REFERENCES Fabricante(ID)
	);
	
/* Carga de datos en tablas */
INSERT INTO estado
	(descripcion)
	VALUES 
	('Vendido'), ('Disponible');

INSERT INTO fabricante
	(nombre)
	VALUES 
	('Samsung'),('LG'),('Whirpool'),('Panasonic'),('HP'),('Lenovo');

INSERT INTO producto
	(nombre)
	VALUES
	('Televisor'),('Lavadora'),('Refrigerador'),('Microondas'),('Laptop');

/* Consultas para carga de datos pedidas a chat gpt */
-- Televisor
INSERT INTO ProductosEnTienda (codPID, modelo, estadoID) VALUES (1, '1234', 1);
INSERT INTO ProductosEnTienda (codPID, modelo, estadoID) VALUES (1, '1235', 2);
INSERT INTO ProductosEnTienda (codPID, modelo, estadoID) VALUES (1, '1236', 1);

-- Lavadora
INSERT INTO ProductosEnTienda (codPID, modelo, estadoID) VALUES (2, '5678', 2);
INSERT INTO ProductosEnTienda (codPID, modelo, estadoID) VALUES (2, '5679', 1);

-- Refrigerador
INSERT INTO ProductosEnTienda (codPID, modelo, estadoID) VALUES (3, '9101', 2);

-- Microondas
INSERT INTO ProductosEnTienda (codPID, modelo, estadoID) VALUES (4, '1121', 1);
INSERT INTO ProductosEnTienda (codPID, modelo, estadoID) VALUES (4, '1122', 2);

-- Laptop
INSERT INTO ProductosEnTienda (codPID, modelo, estadoID) VALUES (5, '3141', 2);
INSERT INTO ProductosEnTienda (codPID, modelo, estadoID) VALUES (5, '3142', 1);

INSERT INTO FabricantesProductos (codPID, fabricanteID) VALUES (1, 1); -- Samsung
INSERT INTO FabricantesProductos (codPID, fabricanteID) VALUES (2, 2); -- LG
INSERT INTO FabricantesProductos (codPID, fabricanteID) VALUES (3, 3); -- Whirlpool
INSERT INTO FabricantesProductos (codPID, fabricanteID) VALUES (4, 4); -- Panasonic
INSERT INTO FabricantesProductos (codPID, fabricanteID) VALUES (5, 5); -- HP

/* Insert a modo de orrección por el faltante de un producto de copID 6*/
INSERT INTO producto
	(nombre)
	VALUES ('');
INSERT INTO FabricantesProductos (codPID, fabricanteID) VALUES (6, 6); -- Lenovo

INSERT INTO Ubicaciones (codPID, almacen, seccion) VALUES (1, 1, 'A');
INSERT INTO Ubicaciones (codPID, almacen, seccion) VALUES (2, 1, 'B');
INSERT INTO Ubicaciones (codPID, almacen, seccion) VALUES (3, 2, 'C');
INSERT INTO Ubicaciones (codPID, almacen, seccion) VALUES (4, 2, 'D');
INSERT INTO Ubicaciones (codPID, almacen, seccion) VALUES (5, 3, 'E');
INSERT INTO Ubicaciones (codPID, almacen, seccion) VALUES (6, 3, 'F');



/* Consultas para ir viendo las tablas */

SELECT * FROM producto;
SELECT * FROM fabricante;
SELECT * FROM estado;
SELECT * FROM productosentienda;
SELECT * FROM ubicaciones;
SELECT * FROM fabricantesproductos;
