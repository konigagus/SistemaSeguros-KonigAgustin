-- 1. Base de Datos
DROP DATABASE IF EXISTS SistemaSeguros;
CREATE DATABASE SistemaSeguros;
USE SistemaSeguros;

-- 2. Tablas Maestras
CREATE TABLE Asegurados (
    id_asegurado INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    dni VARCHAR(20) NOT NULL, 
    email VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    telefono VARCHAR(20),
    fecha_nacimiento DATE,
    PRIMARY KEY (id_asegurado), 
    UNIQUE (email)
);

CREATE TABLE Tipos_Seguro (
    id_tipo INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo VARCHAR(50) NOT NULL,
    descripcion TEXT -- [5]
);

CREATE TABLE Metodos_Pago (
    id_metodo_pago INT PRIMARY KEY AUTO_INCREMENT,
    nombre_metodo VARCHAR(50) NOT NULL
);

-- 3. Tablas Dependientes
CREATE TABLE Polizas (
    id_poliza INT PRIMARY KEY AUTO_INCREMENT,
    nro_poliza VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    monto_asegurado DECIMAL(15, 2),
    estado VARCHAR(20) DEFAULT 'Activa',
    id_asegurado INT,
    id_tipo INT,
    CONSTRAINT FK_Asegurado FOREIGN KEY (id_asegurado) 
        REFERENCES Asegurados(id_asegurado) ON DELETE CASCADE,
    CONSTRAINT FK_TipoSeguro FOREIGN KEY (id_tipo) 
        REFERENCES Tipos_Seguro(id_tipo) ON DELETE CASCADE
);

CREATE TABLE Siniestros (
    id_siniestro INT PRIMARY KEY AUTO_INCREMENT,
    fecha_siniestro DATE NOT NULL,
    monto_reclamado DECIMAL(15, 2),
    descripcion_incidente TEXT,
    id_poliza INT,
    CONSTRAINT FK_Poliza_Siniestro FOREIGN KEY (id_poliza) 
        REFERENCES Polizas(id_poliza) ON DELETE CASCADE
);

CREATE TABLE Pagos (
    id_pago INT PRIMARY KEY AUTO_INCREMENT,
    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
    monto DECIMAL(10, 2) NOT NULL,
    id_metodo_pago INT,
    id_poliza INT,
    CONSTRAINT FK_Poliza_Pago FOREIGN KEY (id_poliza) 
        REFERENCES Polizas(id_poliza) ON DELETE CASCADE,
    CONSTRAINT FK_Metodo_Pago FOREIGN KEY (id_metodo_pago) 
        REFERENCES Metodos_Pago(id_metodo_pago) );
        
-------------------------------------------
-- VISTA 1

CREATE VIEW vista_polizas_asegurados AS
SELECT 
p.id_poliza,
p.nro_poliza,
a.nombre,
a.dni,
p.monto_asegurado,
p.estado
FROM Polizas p
JOIN Asegurados a ON p.id_asegurado = a.id_asegurado;

-- VISTA 2

CREATE VIEW vista_siniestros_poliza AS
SELECT
s.id_siniestro,
s.fecha_siniestro,
s.monto_reclamado,
p.nro_poliza
FROM Siniestros s
JOIN Polizas p ON s.id_poliza = p.id_poliza;

-- VISTA 3

CREATE VIEW vista_pagos_poliza AS
SELECT
pa.id_pago,
pa.fecha_pago,
pa.monto,
p.nro_poliza
FROM Pagos pa
JOIN Polizas p ON pa.id_poliza = p.id_poliza;

-- FUNCIONES

DELIMITER //

CREATE FUNCTION total_pagado(poliza INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

DECLARE total DECIMAL(10,2);

SELECT SUM(monto)
INTO total
FROM Pagos
WHERE id_poliza = poliza;

RETURN IFNULL(total,0);

END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION cantidad_siniestros(poliza INT)
RETURNS INT
DETERMINISTIC
BEGIN

DECLARE total INT;

SELECT COUNT(*)
INTO total
FROM Siniestros
WHERE id_poliza = poliza;

RETURN total;

END //

DELIMITER ;

-- STORED PROCEDURES

DELIMITER //

CREATE PROCEDURE registrar_pago(
IN monto_pago DECIMAL(10,2),
IN metodo INT,
IN poliza INT
)
BEGIN

INSERT INTO Pagos (monto,id_metodo_pago,id_poliza)
VALUES (monto_pago,metodo,poliza);

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE registrar_siniestro(
IN fecha DATE,
IN monto DECIMAL(10,2),
IN descripcion TEXT,
IN poliza INT
)
BEGIN

INSERT INTO Siniestros (fecha_siniestro,monto_reclamado,descripcion_incidente,id_poliza)
VALUES (fecha,monto,descripcion,poliza);

END //

DELIMITER ;

-- TRIGGERS

DELIMITER //

CREATE TRIGGER validar_pago
BEFORE INSERT ON Pagos
FOR EACH ROW
BEGIN

IF NEW.monto <= 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'El monto del pago debe ser mayor a 0';
END IF;

END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_estado_poliza
AFTER INSERT ON Siniestros
FOR EACH ROW
BEGIN

UPDATE Polizas
SET estado = 'Con siniestro'
WHERE id_poliza = NEW.id_poliza;

END //

DELIMITER ;