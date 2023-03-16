CREATE SCHEMA minimarketJose;

Use minimarketJose;
################################ Bajada del problema ################################
#Las tablas que se necesita:
#Productos
#categoría de productos
#Proveedores 
#producto y proveedores
#boleta precio venta
#boleta precio compra
#Ganancias Anuales

#añadir 5 productos
#añadir 4 tipos de productos

#Hacer 2 consultas
#Hacer 1 consulta que una al menos 2 tablas

################################ Creación de Tablas ################################

#Se crea la tabla producto donde se ingresará los productos a vender.
CREATE TABLE Producto(
	producto_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50),
    marca VARCHAR(50),
    sku INTEGER,
    precioVenta INTEGER,
    precioCompra INTEGER
    
);

#Se le añade categoria_id a la tabla Producto
ALTER TABLE Producto ADD categoria_id INTEGER NOT NULL;
ALTER TABLE Producto
ADD FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id);

#Se crea la tabla categoria
CREATE TABLE Categoria(
	categoria_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombreCategoria VARCHAR(25)

);

#Se crea la tabla proveedor donde se ingresará los proveedores del minimarket.
CREATE TABLE Proveedor(
	proveedor_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    direccion VARCHAR(25),
    telefono INTEGER,
    email VARCHAR(50)

);

#se añade categoria_id a la tabla Proveedor
ALTER TABLE Proveedor ADD categoria_id INTEGER NOT NULL;
ALTER TABLE Proveedor
ADD FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id);
#se añade el nombre del proveedor a la tabla Proveedor
ALTER TABLE Proveedor ADD nombreProveedor VARCHAR(25);

#Se crea la tabla relacional entre Producto y Proveedor.
CREATE TABLE ProductoProveedor(
	productoProveedor_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL

);

#Se añaden las foreign key a la tabla productoProveedor.
ALTER TABLE ProductoProveedor ADD producto_id INTEGER NOT NULL;
ALTER TABLE ProductoProveedor
ADD FOREIGN KEY (producto_id) REFERENCES Producto (producto_id);

ALTER TABLE ProductoProveedor ADD proveedor_id INTEGER NOT NULL;
ALTER TABLE ProductoProveedor
ADD FOREIGN KEY (proveedor_id) REFERENCES Proveedor (proveedor_id);

#Se crea la tabla BoletaProveedor, que guardaría las boletas entregadas por el proveedor
CREATE TABLE BoletaProveedor(
	boleta_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    fecha DATE,
    nombreProducto VARCHAR(25),
    cantidad INTEGER,
    total INTEGER
   
);

#se añadre proveedor_id a la tabla BoletaProveedor para saber a qué proveedor se refiere
ALTER TABLE BoletaProveedor ADD proveedor_id INTEGER NOT NULL;
ALTER TABLE BoletaProveedor 
ADD FOREIGN KEY (proveedor_id) REFERENCES Proveedor(proveedor_id);

#Se crea la tabla productoVendido, donde se añaden todos los productos que se hayan vendido con la fecha del día en el que se vendió.
CREATE TABLE productoVendido(
	productoVendido_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    fechaVendido DATE
   
);

#Se añade producto_id para saber con detalle el producto vendido.
ALTER TABLE productoVendido ADD producto_id INTEGER NOT NULL;
ALTER TABLE productoVendido
ADD FOREIGN KEY (producto_id) REFERENCES Producto(producto_id);

################################ Poblar tablas ################################
INSERT INTO Categoria (nombreCategoria)
Values ("Congelados");

INSERT INTO Categoria (nombreCategoria)
VALUES ("LecheVegetal");

INSERT INTO Categoria (nombreCategoria)
VALUES ("Embutidos");

INSERT INTO Categoria (nombreCategoria)
VALUES ("Salsas");

INSERT INTO Categoria (nombreCategoria)
VALUES ("Lavaloza");

INSERT INTO Categoria (nombreCategoria)
VALUES ("Energetica");

INSERT INTO Categoria (nombreCategoria)
VALUES ("Fermentados");


INSERT INTO Producto (nombre, marca, sku, precioVenta, precioCompra, categoria_id)
VALUES ("HeladoMoraCrema", "LiveGreen", 456789, 3990, 2120, 1);

INSERT INTO Producto (nombre, marca, sku, precioVenta, precioCompra, categoria_id)
VALUES ("NotIceCreamChocolove", "NotCo", 456951, 3590, 1630, 1);

INSERT INTO Producto (nombre, marca, sku, precioVenta, precioCompra, categoria_id)
VALUES ("BebidaAlmendrasVainilla", "Vilay", 123456, 1300, 650, 2);

INSERT INTO Producto (nombre, marca, sku, precioVenta, precioCompra, categoria_id)
VALUES ("Salchicha", "Rikü", 124578,2850, 1320, 3);

INSERT INTO Producto (nombre, marca, sku, precioVenta, precioCompra, categoria_id)
VALUES ("MayoRealVegan", "Kraft", 963258, 3990, 2210, 4);

INSERT INTO Producto (nombre, marca, sku, precioVenta, precioCompra, categoria_id)
VALUES ("NotMayo", "NotCo", 459678, 1000, 560, 4);

INSERT INTO Producto (nombre, marca, sku, precioVenta, precioCompra, categoria_id)
VALUES ("NotBurguer", "NotCo", 357159, 1200, 640, 3);

INSERT INTO Producto (nombre, marca, sku, precioVenta, precioCompra, categoria_id)
VALUES ("LavalozaEcológico", "Virutex", 12121234, 3750, 1890, 5);

INSERT INTO Producto (nombre, marca, sku, precioVenta, precioCompra, categoria_id)
VALUES ("BebidaAtomFruitMango", "AtomFruit", 959896, 1090, 460, 6);

INSERT INTO Producto (nombre, marca, sku, precioVenta, precioCompra, categoria_id)
VALUES ("KombuchaOriginal", "Kombuchacha", 754678, 1970, 850, 7);

INSERT INTO Proveedor (direccion, telefono, email, categoria_id, nombreProveedor)
VALUES ("notdireccion123", 45678912, "notco@riquisimo.cl", 1, "NotCo");

################################ Ediciones ################################
UPDATE Producto
SET nombre = "NotIceCreamMenta"
WHERE producto_id = 1;

UPDATE Producto
SET marca = "NotCo"
WHERE producto_id = 1;
SELECT * FROM Producto;

################################ Consultas a la Base de Datos ################################
#Se consulta los productos que pertenezcan a la categoría Salsas.
SELECT Producto.nombre, Producto.marca, Producto.precioVenta
FROM Producto
WHERE categoria_id = 4;

#Se consulta los productos de la marca AtomFruit.
SELECT Producto.nombre, Producto.precioVenta
FROM Producto
WHERE marca = "AtomFruit";

#Se consulta por el nombre del producto, y precio de compra de los productos comprados directo en la empresa de 
#producción, en este caso de NotCo
SELECT Producto.nombre, Producto.precioCompra
FROM Producto JOIN Proveedor ON Producto.marca = Proveedor.nombreProveedor != "NotCo";

################################ Ganancia Anual y Venta de productos ################################
#Si quiere saber la ganancia anual, siga los siguientes pasos:

# Va a traer las boletas generadas por los proveedores(BoletaProveedor) indicando el año que
# se desea saber, se sumará la columna total de la tabla BoletaProveedor para saber cuánto ha sido la inversión.

SELECT SUM(total)
FROM BoletaProveedor;

# Luego va a traer los productos vendidos 

SELECT producto_id
FROM productoVendido;

#A esta lista de productos_id, accede a cada producto y suma la columna precioCompra, luego suma la columna precioVenta,
# luego las resta y conseguirá el valor de ganancia por productos.

#Teniendo estos valores, procede a restarle el total de inversión a la ganancia por productos, consiguiendo así el
# total final de ganancias que logró el minimarket el año solicitado.

#Si quiere saber la venta de productos seleccione lo siguiente:
SELECT * FROM productoVendido;

 

