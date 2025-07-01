/*
Ver esquema en Parcial2Fecha2PracticaC2.PDF
Dado el anterior esquema de base de datos:
*/
/*
1. Escribir las sentencias SQL para crear todas las tablas; en el orden que correspondan ser ejecutadas.
*/
CREATE DATABASE P2F2;
USE P2F2;

CREATE TABLE if NOT exists localidad(
	ID INT NOT NULL UNIQUE auto_increment,
	nombre VARCHAR(45) NOT NULL,
	PRIMARY KEY (id)
);
	
CREATE TABLE if NOT EXISTS Articulo(
	ID INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(45) NOT NULL,
	codigo VARCHAR(45) NOT NULL, 
	PRIMARY KEY(id)
);
	
CREATE TABLE if NOT EXISTS Vendedor(
	ID INT NOT NULL AUTO_INCREMENT,
	nombreApellido VARCHAR(45) NOT NULL,
	comision DECIMAL(15,2) NOT NULL,
	PRIMARY KEY(ID)
);
	
CREATE TABLE if NOT EXISTS Cliente(
	ID INT NOT NULL AUTO_INCREMENT,
	razonSocial VARCHAR(45) NOT NULL,
	cuit INT NOT NULL,
	telefono VARCHAR(45) NOT NULL,
	domicilio VARCHAR(45) NOT NULL, 
	localidadID INT NOT NULL,
	PRIMARY KEY(ID),
	FOREIGN KEY (localidadID) REFERENCES localidad(ID)
);

CREATE TABLE if NOT EXISTS Venta(
	ID INT NOT NULL AUTO_INCREMENT,
	numero INT NOT NULL UNIQUE,
	fecha DATE NOT NULL,
	importeTotal DECIMAL(15,2),
	clienteID INT NOT NULL,
	vendedorID INT NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (clienteID) REFERENCES Cliente(ID),
	FOREIGN KEY (vendedorID) REFERENCES Vendedor(ID)
);

CREATE TABLE if NOT EXISTS VentaDetalle(
	ID INT NOT NULL AUTO_INCREMENT,
	cantidad INT NOT NULL,
	precio DECIMAL(15,2) NOT NULL,
	articuloID INT NOT NULL,
	ventaID INT NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (articuloID) REFERENCES articulo(ID),
	FOREIGN KEY (ventaID) REFERENCES venta(ID)
);

	
/*
2. Insertar un Cliente
*/
INSERT INTO localidad (nombre) VALUES ('Florencio Varela');
-- SELECT * FROM localidad;
INSERT INTO cliente 
	(razonSocial, cuit, telefono, domicilio, localidadID)
	VALUES ('Los Pollos Hnos', 20123456787, '0303456', 'Monserrat 300', 1);


/*
3. Actualizar el teléfono del Cliente insertado
*/
UPDATE cliente
	SET telefono = '11-2233-4455'
	WHERE id=1;
	

/*
4. Agregar, en la tabla Cliente, una columna con nombre “eMail” y tipo varchar(50)
*/
ALTER TABLE cliente
	ADD COLUMN eMail VARCHAR(50)
	AFTER telefono;
	

/*	
5. Escribir las consultas SQL que devuelvan la siguiente información:
*/

/* a. Todas las ventas realizadas al cliente con cuit 20282524171. Mostrar fecha, numero, razonSocial e 
		importeTotal, y ordenar por fecha. */
ALTER TABLE cliente
	MODIFY COLUMN cuit BIGINT;
-- la consulta anterior fue necesaria porque no guardaba los campos cuit como se los insertaban por overflow
-- la solución es el tipo de dato a bigint porque con int se guardan todos los cuit como 2147483647
INSERT INTO cliente
	(razonSocial, cuit, telefono, domicilio, localidadID)
	VALUES ('Bobs Burger', 20282524171, '1170820959', 'Lopez Escribano 1234', 1);

-- se volvieron a ejecutar las últimas 2 consultas para ver que ahora se guardan bien los cuits

-- corrigiendo el cliente con nombre repetido y cuit diferente
DELETE FROM cliente WHERE id = 2;
UPDATE cliente 
	SET id = 2
	WHERE id = 3;

-- carga de registros en tablas para poder ver algo en la consulta
INSERT INTO vendedor 
	(nombreApellido, comision)
	VALUES ('Pocaluz', 15);
INSERT INTO vendedor 
	(nombreApellido, comision)
	VALUES ('Reggi', 15);
INSERT INTO vendedor 
	(nombreApellido, comision)
	VALUES ('Calvin', 15);

INSERT INTO articulo 
	(nombre, codigo)
	VALUES ('revista time', '789');
INSERT INTO articulo
	(nombre, codigo)
	VALUES ('croissant', '654');
INSERT INTO articulo
	(nombre, codigo)
	VALUES ('televisor', '123');
	
INSERT INTO venta
	(numero, fecha, importeTotal, clienteID, vendedorID)
	VALUES (23, '20240606', 798, 2, 1);
INSERT INTO venta
	(numero, fecha, importeTotal, clienteID, vendedorID)
	VALUES (150, '20250110', 800, 2, 2);
INSERT INTO venta
	(numero, fecha, importeTotal, clienteID, vendedorID)
	VALUES (187, '20240206', 500, 2, 3);
INSERT INTO venta
	(numero, fecha, importeTotal, clienteID, vendedorID)
	VALUES (188, '20240206', 500, 1, 3);



SELECT v.fecha, v.numero, c.razonSocial, v.importeTotal
	FROM venta v INNER JOIN cliente c ON v.clienteID = c.ID
	WHERE c.cuit = 20282524171
	ORDER BY v.fecha;


/* b. Cantidad vendida de cada artículo en el año 2023. 
		Mostrar el nombre del artículo y la cantidad vendida */
-- carga de registros en tablas para poder ver algo en la consulta
INSERT INTO venta
	(numero, fecha, importeTotal, clienteID, vendedorID)
	VALUES (1, '20230606', 100, 2, 1);
INSERT INTO ventadetalle
	(cantidad, precio, articuloID, ventaID)
	VALUES 
	(2, 40, 1, 5),
	(2, 10, 2, 5)
	;
INSERT INTO venta
	(numero, fecha, importeTotal, clienteID, vendedorID)
	VALUES (2, '20230607', 60, 1, 2);
INSERT INTO ventadetalle
	(cantidad, precio, articuloID, ventaID)
	VALUES 
	(2, 50, 1, 6),
	(2, 5, 2, 6)
	;


SELECT a.nombre, SUM(vd.articuloID) AS cantidadVendida
	FROM articulo a INNER JOIN ventadetalle vd ON a.ID = vd.articuloID INNER JOIN venta v ON vd.ventaID = v.id
	WHERE YEAR(v.fecha) = '2023'
	GROUP BY vd.articuloID;


/* c. Los 3 clientes que más compraron en 2023. Mostrar la razonSocial y el teléfono */
-- carga de registros en tablas para poder ver algo en la consulta
INSERT INTO cliente 
	(razonSocial, cuit, telefono, domicilio, localidadID)
	VALUES ('Panadería Lembas', 20371234567, '0303456', 'Monserrat 320', 1);
INSERT INTO cliente 
	(razonSocial, cuit, telefono, domicilio, localidadID)
	VALUES ('El Poni Pisador', 20381234567, '0303457', 'Monserrat 340', 1);
INSERT INTO venta
	(numero, fecha, importeTotal, clienteID, vendedorID)
	VALUES 
	(3, '20230608',900, 4, 1),
	(4, '20230609',700, 5, 1),
	(5, '20230610',100,2,1);


SELECT c.razonSocial, c.telefono -- , SUM(v.importeTotal)
	FROM venta v INNER JOIN cliente c ON v.clienteID = c.id
	WHERE YEAR(v.fecha)='2023'
	GROUP BY v.clienteID 
	ORDER BY SUM(v.importeTotal) DESC
	LIMIT 3;

/*	d.	La comisión que debe cobrar cada vendedor en enero del 2023. 
		Mostrar el nombre del vendedor y la comisión a cobrar 
		(considerar que la columna comisión de la tabla vendedor es el porcentaje de 
		comisión por venta) */
-- carga de registros en tablas para poder ver algo en la consulta
INSERT INTO venta
	(numero, fecha, importeTotal, clienteID, vendedorID)
	VALUES 
	(6, '20230108',900, 4, 1),
	(7, '20230109',700, 5, 2),
	(8, '20230110',100,2,2),
	(9, '20230111',100,2,3),
	(10, '20230111',100,2,3),
	(11, '20230111',100,2,1);

SELECT SUM((ven.comision/100)*v.importeTotal) AS comision, ven.nombreApellido
	FROM venta v INNER JOIN vendedor ven ON v.vendedorID = ven.id
	WHERE YEAR(v.fecha) = '2023' AND MONTH(v.fecha)='01'
	GROUP BY ven.id;

/* e.	El promedio de importe por venta que tiene cada cliente. 
		Mostrar razonSocial y promedio. Ordenar por 
		promedio */

SELECT AVG(v.importeTotal) AS promedioImporte, c.razonSocial
	FROM venta v INNER JOIN cliente c ON v.clienteID = c.ID 
	GROUP BY c.ID

-- consulta para verificar si todo dio bien
SELECT v.fecha, v.importeTotal, c.razonSocial
	FROM venta v INNER JOIN cliente c ON v.clienteID=c.ID
	ORDER BY c.ID



SELECT * FROM venta;
SELECT * FROM cliente:
SELECT * FROM ventadetalle;
SELECT * FROM articulo;
SELECT * FROM vendedor;
SELECT * FROM localidad;
