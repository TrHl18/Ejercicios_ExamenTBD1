
-- Compartir comandos de imagen de docker

2022-CU10-GDR1-ubuntu-22.04
docker pull mcr.microsoft.com/mssql/server:2022-CU10-GDR1-ubuntu-22.04


docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Ceutec1*" -e "MSSQL_PID=Developer" -p 1433:1433  --name sqlServer01 --hostname sqlServer01 -d mcr.microsoft.com/mssql/server:2022-CU10-GDR1-ubuntu-22.04


-- Crear script con sintaxis DDL y DML

USE master;
IF DB_ID('Tickets') IS NOT NULL
    DROP DATABASE Tickets;

CREATE DATABASE Tickets;

USE Tickets;

CREATE TABLE Usuario(
    usuario_id INT PRIMARY KEY IDENTITY NOT NULL,
    nombres VARCHAR(250) NOT NULL,
    apellidos VARCHAR(250) NOT NULL,
    correo VARCHAR(250) NOT NULL
);

CREATE TABLE Categoria(
    categoria_id INT PRIMARY KEY IDENTITY NOT NULL,
    nombre VARCHAR(250) NOT NULL,
    descripcion VARCHAR(500) NOT NULL
);

CREATE TABLE Ingeniero(
    ingeniero_id INT PRIMARY KEY IDENTITY NOT NULL,
    nombre VARCHAR(250) NOT NULL,
    apellido VARCHAR(250) NOT NULL,
    correo VARCHAR(250) NOT NULL,
    experiencia VARCHAR(500) NOT NULL,
    categoria_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id)
);

CREATE TABLE Caso(
    caso_id INT PRIMARY KEY IDENTITY NOT NULL,
    ingeniero_id INT NOT NULL,
    usuario_id INT NOT NULL,
    categoria_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id),
    FOREIGN KEY (ingeniero_id) REFERENCES Ingeniero(ingeniero_id),
    FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id)
);

CREATE TABLE Procedimiento(
    procedimiento_id INT PRIMARY KEY IDENTITY NOT NULL,
    caso_id INT NOT NULL,
    descripcion VARCHAR(500) NOT NULL,
    fecha DATETIME NOT NULL,
    FOREIGN KEY (caso_id) REFERENCES Caso(caso_id)
);

CREATE TABLE Retroalimentacion(
    retro_id INT PRIMARY KEY IDENTITY NOT NULL,
    puntuacion INT NOT NULL,
    ingeniero_id INT NOT NULL,
    usuario_id INT NOT NULL,
    caso_id INT NOT NULL,
    comentarios VARCHAR(500) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id),
    FOREIGN KEY (ingeniero_id) REFERENCES Ingeniero(ingeniero_id),
    FOREIGN KEY (caso_id) REFERENCES Caso(caso_id)
);

-- Sintaxis DML

INSERT INTO Usuario (nombres, apellidos, correo) 
VALUES ('Andrea Maria', 'Mejia Lopez', 'Andrea_ML@gmail.com')
