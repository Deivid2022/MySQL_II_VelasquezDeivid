-- Active: 1719453301211@@127.0.0.1@3306@mysql2_ejerciciodia4
-- ###################################
-- ##### Mysql2 - Ejercicio Dia4 #####
-- ###################################

use mysql2_EjercicioDia4;

create user 'empleado'@'LocalHost' IDENTIFIED BY 'empleado123';
create user 'cliente'@'LocalHost' IDENTIFIED BY 'cliente123';


-- Permisos para los empleados 
grant execute on procedure mysql2_EjercicioDia4.registro_empleado to 'empleado'@'LocalHost';
grant execute on procedure mysql2_EjercicioDia4.actualizar_empleado to 'empleado'@'LocalHost';
grant execute on procedure mysql2_EjercicioDia4.registrar_vehiculo to 'empleado'@'LocalHost';
grant execute on procedure mysql2_EjercicioDia4.actualizar_vehiculo to 'empleado'@'LocalHost';
grant execute on procedure mysql2_EjercicioDia4.registrar_sucursal to 'empleado'@'LocalHost';
grant execute on procedure mysql2_EjercicioDia4.actualizar_sucursal to 'empleado'@'LocalHost';

show grants for 'empleado'@'LocalHost';

-- Permisos para los clientes
grant execute on procedure mysql2_EjercicioDia4.registro_cliente to 'cliente'@'LocalHost';
grant execute on procedure mysql2_EjercicioDia4.Actualizar_cliente to 'cliente'@'LocalHost';
grant execute on procedure mysql2_EjercicioDia4.consultar_disponibilidad_vehiculos to 'cliente'@'LocalHost';
grant execute on procedure mysql2_EjercicioDia4.registrar_alquiler to 'cliente'@'LocalHost';
grant execute on procedure mysql2_EjercicioDia4.historial_alquileres_por_cliente to 'cliente'@'LocalHost';

show grants for 'cliente'@'LocalHost';

-- Desarrollado por Deivid Velasquez Gutierrez / TI: 1096701633