--Script

USE master;
IF DB_ID('Energia_Electrica') IS NOT NULL
    DROP DATABASE Energia_Electrica;

CREATE DATABASE Energia_Electrica;

USE Energia_Electrica;

CREATE TABLE Cliente(
    cliente_id INT PRIMARY KEY IDENTITY NOT NULL,
    nombres VARCHAR(250) NOT NULL,
    apellidos VARCHAR(250) NOT NULL,
    correo VARCHAR(250) NOT NULL
);

CREATE TABLE Edificio(
    edificio_id INT PRIMARY KEY IDENTITY NOT NULL,
    nombre VARCHAR(250) NOT NULL,
    descripcion VARCHAR(500) NOT NULL,
    cliente_id INT NOT NULL, 
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

CREATE TABLE Medidor(
    medidor_id INT PRIMARY KEY IDENTITY NOT NULL,
    edificio_id INT NOT NULL,
    cliente_id INT NOT NULL,
    FOREIGN KEY (edificio_id) REFERENCES Edificio(edificio_id),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

CREATE TABLE Lectura(
    lectura_id INT PRIMARY KEY IDENTITY NOT NULL,
    lectura_inicio FLOAT NOT NULL,
    lectura_final FLOAT NOT NULL,
    fecha_inicio DATETIME NOT NULL,
    fecha_final DATETIME NOT NULL,
    medidor_id INT NOT NULL,
    FOREIGN KEY (medidor_id) REFERENCES Medidor(medidor_id)
);

CREATE TABLE Tarifa(
    tarifa_id INT PRIMARY KEY IDENTITY NOT NULL,
    tipo_cliente VARCHAR(250) NOT NULL,
    precio FLOAT NOT NULL
);

CREATE TABLE Consumo(
    consumo_id INT PRIMARY KEY IDENTITY NOT NULL,
    medidor_id INT NOT NULL,
    lectura_id INT NOT NULL,
    tarifa_id INT NOT NULL,
    FOREIGN KEY (medidor_id) REFERENCES Medidor(medidor_id),
    FOREIGN KEY (lectura_id) REFERENCES Lectura(lectura_id),
    FOREIGN KEY (tarifa_id) REFERENCES Tarifa(tarifa_id)
);

CREATE TABLE Factura(
    factura_id INT PRIMARY KEY IDENTITY NOT NULL,
    consumo_id INT NOT NULL,
    fecha_emision DATETIME NOT NULL,
    fecha_vencimiento DATETIME NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    FOREIGN KEY (consumo_id) REFERENCES Consumo(consumo_id)
);






-- Sintaxis DML
INSERT INTO Edificio (nombre, descripcion, cliente_id) VALUES
('Edificio A', 'Edificio principal', 1),
('Edificio B', 'Edificio secundario', 2);

INSERT INTO Medidor (edificio_id, cliente_id) VALUES
(1, 1),
(2, 2);
