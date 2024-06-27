-- ###################################
-- ##### Mysql2 - Ejercicio Dia4 #####
-- ###################################

use mysql2_EjercicioDia4;

--  Registro de empleado

DELIMITER //
CREATE PROCEDURE registro_empleado (empleado_id_sucursal INT, empleado_cedula VARCHAR(20), empleado_nombre1 VARCHAR(100), empleado_nombre2 VARCHAR(100), empleado_apellido1 VARCHAR(100), empleado_apellido2 VARCHAR(100), empleado_direccion VARCHAR(200), empleado_ciudad_residencia VARCHAR(100), empleado_celular VARCHAR(20), empleado_correo_electronico VARCHAR(100))
BEGIN
    DECLARE sucursal_count INT;
    SELECT COUNT(*) INTO sucursal_count FROM sucursal WHERE id = empleado_id_sucursal;
    
    IF sucursal_count > 0 THEN 
        INSERT INTO empleado(sucursal_id, cedula, nombre1, nombre2, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico) 
        VALUES (empleado_id_sucursal, empleado_cedula, empleado_nombre1, empleado_nombre2, empleado_apellido1, empleado_apellido2, empleado_direccion, empleado_ciudad_residencia, empleado_celular, empleado_correo_electronico);
    ELSE 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: el ID de sucursal no existe';
    END IF;
END //
DELIMITER ;
-- Test
call registro_empleado(1, '1010425322', 'Brayan', 'Yesid', 'Lindarte', 'Anaya', 'Calle 31 #6-72', 'Cucuta', '3123469865', 'brayancasimiro23@gmail.com');
SELECT * from empleado;

-- Actualizar de empleado (cedula)

delimiter //
create procedure actualizar_empleado(p_cedula varchar(20), p_sucursal_id int, p_nombre1 varchar(100), p_nombre2 varchar(100), p_apellido1 VARCHAR(100), p_apellido2 VARCHAR(100), p_direccion VARCHAR(200), p_ciudad_residencia VARCHAR(100), p_celular VARCHAR(20), p_correo_electronico VARCHAR(100))
begin
    update empleado
    set sucursal_id = p_sucursal_id, nombre1 = p_nombre1, nombre2 = p_nombre2, apellido1 = p_apellido1, apellido2 = p_apellido2, direccion = p_direccion, ciudad_residencia = p_ciudad_residencia, celular = p_celular, correo_electronico = p_correo_electronico
    where cedula = p_cedula;
end //
delimiter ;

-- Test 
call actualizar_empleado('1096701633', 5, 'Deivid', NUll, 'Velasquez', 'Gutierrez', 'Calle 104a #8-16', 'Bucaramanga', '3178925556', 'deividvelasquez122@gmail.com');

-- Registro de cliente

delimiter //
create procedure registro_cliente(p_cedula VARCHAR(20), p_nombre1 VARCHAR(100), p_nombre2 VARCHAR(100), p_apellido1 VARCHAR(100), p_apellido2 VARCHAR(100), p_direccion VARCHAR(200), p_ciudad_residencia VARCHAR(100), p_celular VARCHAR(20), p_correo_electronico VARCHAR(100))
begin
    insert into cliente (cedula, nombre1, nombre2, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico)
    values (p_cedula, p_nombre1, p_nombre2, p_apellido1, p_apellido2, p_direccion, p_ciudad_residencia, p_celular, p_correo_electronico);
end //
delimiter ;
-- Test
CALL registro_cliente('123456789', 'Juan', 'Carlos', 'Pérez', 'Gómez', 'Calle 123', 'Bogotá', '1234567890', 'juan.perez@example.com' );
select * from cliente;

-- Actualizacion de cliente (Cedula)

delimiter //
create procedure Actualizar_cliente(p_cedula VARCHAR(20), p_nombre1 VARCHAR(100), p_nombre2 VARCHAR(100), p_apellido1 VARCHAR(100), p_apellido2 VARCHAR(100), p_direccion VARCHAR(200), p_ciudad_residencia VARCHAR(100), p_celular VARCHAR(20), p_correo_electronico VARCHAR(100))
begin
    update cliente
    set nombre1 = p_nombre1, nombre2 = p_nombre2, apellido1 = p_apellido1, apellido2 = p_apellido2, direccion = p_direccion, ciudad_residencia = p_ciudad_residencia, celular = p_celular, correo_electronico = p_correo_electronico
    where cedula = p_cedula;
end //
delimiter ;

-- Test
call Actualizar_cliente('123456789', 'Juan', 'Carlos', 'Pérez', 'Gonzalo', 'Calle 123', 'Bogotá', '1234567890', 'juan.perez@example.com');
select * from cliente;

-- Registro de vehiculo

DELIMITER //
CREATE PROCEDURE registrar_vehiculo( p_tipo ENUM('sedán', 'compacto', 'camioneta platón', 'camioneta lujo', 'deportivo'), p_placa VARCHAR(20), p_referencia VARCHAR(100), p_modelo INT, p_puertas INT, p_capacidad INT, p_sunroof BOOLEAN, p_motor VARCHAR(50), p_color VARCHAR(30))
BEGIN
    IF p_tipo NOT IN ('sedán', 'compacto', 'camioneta platón', 'camioneta lujo', 'deportivo') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de vehículo no válido';
    END IF;

    INSERT INTO vehiculo (tipo, placa, referencia, modelo, puertas, capacidad, sunroof, motor, color) 
    VALUES (p_tipo, p_placa, p_referencia, p_modelo, p_puertas, p_capacidad, p_sunroof, p_motor, p_color);
END //
DELIMITER ;

-- Test
CALL registrar_vehiculo( 'deportivo', 'ABC-999', 'Ferrari 488', 2022, 2, 2, TRUE, 'V8 Turbo', 'Rojo');

-- Actualizacion de vehiculo (Placa)

DELIMITER //
CREATE PROCEDURE actualizar_vehiculo(p_placa VARCHAR(20), p_tipo ENUM('sedán', 'compacto', 'camioneta platón', 'camioneta lujo', 'deportivo'), p_referencia VARCHAR(100), p_modelo INT, p_puertas INT, p_capacidad INT, p_sunroof BOOLEAN, p_motor VARCHAR(50), p_color VARCHAR(30))
BEGIN
    IF p_tipo NOT IN ('sedán', 'compacto', 'camioneta platón', 'camioneta lujo', 'deportivo') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de vehículo no válido';
    END IF;

    UPDATE vehiculo
    SET tipo = p_tipo, referencia = p_referencia, modelo = p_modelo, puertas = p_puertas, capacidad = p_capacidad, sunroof = p_sunroof, motor = p_motor, color = p_color
    WHERE placa = p_placa;
END //
DELIMITER ;

-- Test
CALL actualizar_vehiculo( 'ABC-999', 'deportivo', 'Ferrari 488', 2022, 2, 2, TRUE, 'V8 Turbo', 'Gris');
select * from vehiculo;

-- Registro de sucursal
DELIMITER //
CREATE PROCEDURE registrar_sucursal(p_ciudad VARCHAR(100), p_direccion VARCHAR(200), p_telefono_fijo VARCHAR(20), p_celular VARCHAR(20), p_correo_electronico VARCHAR(100))
BEGIN
    INSERT INTO sucursal (ciudad, direccion, telefono_fijo, celular, correo_electronico) 
    VALUES (p_ciudad, p_direccion, p_telefono_fijo, p_celular, p_correo_electronico);
END //
DELIMITER ;
-- Test
CALL registrar_sucursal('Bucaramanga', 'Calle 123 #45-67', '1234567', '3001234567', 'bucaramanga@sucursal.com');
select * from sucursal;

-- Actualizar sucural (ID)
DELIMITER //
CREATE PROCEDURE actualizar_sucursal(p_id INT, p_ciudad VARCHAR(100), p_direccion VARCHAR(200), p_telefono_fijo VARCHAR(20), p_celular VARCHAR(20), p_correo_electronico VARCHAR(100))
BEGIN
    DECLARE sucursal_count INT;
    SELECT COUNT(*) INTO sucursal_count FROM sucursal WHERE id = p_id;
    
    IF sucursal_count > 0 THEN 
        UPDATE sucursal
        SET ciudad = p_ciudad, direccion = p_direccion, telefono_fijo = p_telefono_fijo, celular = p_celular, correo_electronico = p_correo_electronico
        WHERE id = p_id;
    ELSE 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: el ID de sucursal no existe';
    END IF;
END //
DELIMITER ;

-- Test 
CALL actualizar_sucursal(1, 'Bogota', 'Avenida 123 #45-67', '7654321', '3007654321', 'contacto_nuevo@sucursal.com');
select * from sucursal;


-- disponibilidad de vehículos para alquiler por tipo de vehículo, rango de
-- precios de alquiler y fechas de disponibilidad.
DELIMITER //
CREATE PROCEDURE consultar_disponibilidad_vehiculos(p_tipo ENUM('sedán', 'compacto', 'camioneta platón', 'camioneta lujo', 'deportivo'), p_precio_min DECIMAL(10, 2), p_precio_max DECIMAL(10, 2), p_fecha_inicio DATE, p_fecha_fin DATE)
BEGIN
    SELECT v.id, v.tipo, v.placa, v.referencia, v.modelo, v.puertas, v.capacidad, v.sunroof, v.motor, v.color, IFNULL(a.valor_alquiler_dia, p_precio_min) AS valor_alquiler_dia
    FROM vehiculo v
    LEFT JOIN 
        alquileres a ON v.id = a.vehiculo_id 
        AND a.fecha_salida <= p_fecha_fin 
        AND a.fecha_llegada >= p_fecha_inicio
    WHERE 
        v.tipo = p_tipo
        AND (a.id IS NULL OR a.fecha_salida IS NULL OR a.fecha_llegada IS NULL)
        AND IFNULL(a.valor_alquiler_dia, p_precio_min) BETWEEN p_precio_min AND p_precio_max;
END //
DELIMITER ;

-- Test
CALL consultar_disponibilidad_vehiculos('sedán', 60000.00, 100000.00, '2027-07-01', '2030-07-10');

-- Alquiler de vehiculo
DELIMITER //
CREATE PROCEDURE registrar_alquiler(p_vehiculo_id INT, p_cliente_id INT, p_empleado_id INT, p_sucursal_salida_id INT, p_sucursal_llegada_id INT, p_fecha_salida DATE, p_fecha_llegada DATE, p_fecha_esperada_llegada DATE, p_valor_alquiler_semana DECIMAL(10, 2), p_valor_alquiler_dia DECIMAL(10, 2), p_porcentaje_descuento DECIMAL(5, 2), p_valor_cotizado DECIMAL(10, 2), p_valor_pagado DECIMAL(10, 2))
BEGIN
    DECLARE alquiler_count INT;

    -- Verificar disponibilidad del vehículo
    SELECT COUNT(*) INTO alquiler_count 
    FROM alquileres 
    WHERE vehiculo_id = p_vehiculo_id 
      AND fecha_salida <= p_fecha_llegada 
      AND fecha_llegada >= p_fecha_salida;

    IF alquiler_count = 0 THEN
        -- Insertar nuevo alquiler
        INSERT INTO alquileres (
            vehiculo_id, cliente_id, empleado_id, sucursal_salida_id, sucursal_llegada_id, 
            fecha_salida, fecha_llegada, fecha_esperada_llegada, valor_alquiler_semana, 
            valor_alquiler_dia, porcentaje_descuento, valor_cotizado, valor_pagado
        ) VALUES (
            p_vehiculo_id, p_cliente_id, p_empleado_id, p_sucursal_salida_id, p_sucursal_llegada_id, 
            p_fecha_salida, p_fecha_llegada, p_fecha_esperada_llegada, p_valor_alquiler_semana, 
            p_valor_alquiler_dia, p_porcentaje_descuento, p_valor_cotizado, p_valor_pagado
        );
    ELSE
        -- Señalar que el vehículo no está disponible
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: el vehículo no está disponible en las fechas especificadas';
    END IF;
END //
DELIMITER ;

-- Test
CALL registrar_alquiler(1, 1, 1, 1, 2, '2024-07-01', '2024-07-07', '2024-07-07', 1000.00, 150.00, 10.00, 900.00, 850.00);

select * from alquileres;

-- Historial de alquileres por cliente
DELIMITER //
CREATE PROCEDURE historial_alquileres_por_cliente(IN p_cliente_id INT)
BEGIN
    SELECT a.id, a.vehiculo_id, v.tipo, v.placa, a.empleado_id, e.nombre1 AS empleado_nombre, a.sucursal_salida_id, s1.ciudad AS sucursal_salida, a.sucursal_llegada_id, s2.ciudad AS sucursal_llegada, a.fecha_salida, a.fecha_llegada, a.fecha_esperada_llegada, a.valor_alquiler_semana, a.valor_alquiler_dia, a.porcentaje_descuento, a.valor_cotizado, a.valor_pagado
    FROM alquileres a
    JOIN vehiculo v ON a.vehiculo_id = v.id
    JOIN empleado e ON a.empleado_id = e.id
    JOIN sucursal s1 ON a.sucursal_salida_id = s1.id
    JOIN sucursal s2 ON a.sucursal_llegada_id = s2.id
    WHERE a.cliente_id = p_cliente_id;
END //
DELIMITER ;

call historial_alquileres_por_cliente(1);

-- Desarrollado por Deivid Velasquez Gutierrez / TI: 1096701633