-- Active: 1719453301211@@127.0.0.1@3306@mysql2_ejerciciodia4
-- ###################################
-- ##### Mysql2 - Ejercicio Dia5 #####
-- ###################################

USE mysql2_EjercicioDia4;

CREATE TABLE inserciones_actualizaciones_empleados (
    id INT PRIMARY KEY,
    nombre1 VARCHAR(100) NOT NULL,
    nombre2 VARCHAR(100),
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    direccion VARCHAR(200) NOT NULL,
    ciudad_residencia VARCHAR(100) NOT NULL,
    celular VARCHAR(20),
    correo_electronico VARCHAR(100) NOT NULL,
    action VARCHAR(25),
    hora_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DELIMITER //
CREATE TRIGGER after_empleado_insert
AFTER INSERT ON empleado
FOR EACH ROW
BEGIN
    INSERT INTO inserciones_actualizaciones_empleados (id, nombre1, nombre2, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico, action)
    VALUES (NEW.id, NEW.nombre1, NEW.nombre2, NEW.apellido1, NEW.apellido2, NEW.direccion, NEW.ciudad_residencia, NEW.celular, NEW.correo_electronico, 'INSERT');
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_empleado_update
AFTER UPDATE ON empleado
FOR EACH ROW
BEGIN
    INSERT INTO inserciones_actualizaciones_empleados (id, nombre1, nombre2, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico, action)
    VALUES (NEW.id, NEW.nombre1, NEW.nombre2, NEW.apellido1, NEW.apellido2, NEW.direccion, NEW.ciudad_residencia, NEW.celular, NEW.correo_electronico, 'UPDATE');
END //
DELIMITER ;

CREATE TABLE IF NOT EXISTS backup_empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre1 VARCHAR(100) NOT NULL,
    nombre2 VARCHAR(100),
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    direccion VARCHAR(200) NOT NULL,
    ciudad_residencia VARCHAR(100) NOT NULL,
    celular VARCHAR(20),
    correo_electronico VARCHAR(100) NOT NULL,
    hora_backup TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE EVENT IF NOT EXISTS daily_employee_backup
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    INSERT INTO backup_empleados (nombre1, nombre2, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico)
    SELECT nombre1, nombre2, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico
    FROM empleado;
END //
DELIMITER ;

-- Desarrollado por Deivid Velasquez Gutierrez / TI: 1096701633