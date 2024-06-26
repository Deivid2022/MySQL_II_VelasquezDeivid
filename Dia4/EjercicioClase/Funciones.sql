-- ###################################
-- ##### Mysql2 - Ejercicio Dia4 #####
-- ###################################

use mysql2_EjercicioDia4;

--  Registro de empleado

delimiter //
create procedure registro_empleado (empleado_id_sucursal int, empleado_cedula varchar(20), empleado_nombre1 varchar(100), empleado_nombre2 varchar(100), empleado_apellido1 VARCHAR(100), empleado_apellido2 VARCHAR(100), empleado_direccion VARCHAR(200), empleado_ciudad_residencia VARCHAR(100), empleado_celular VARCHAR(20), empleado_correo_electronico VARCHAR(100))
begin
    insert into empleado(sucursal_id, cedula, nombre1, nombre2, apellido1, apellido2, direccion, ciudad_residencia, celular, correo_electronico)
    VALUES (empleado_id_sucursal, empleado_cedula, empleado_nombre1, empleado_nombre2, empleado_apellido1, empleado_apellido2, empleado_direccion, empleado_ciudad_residencia, empleado_celular, empleado_correo_electronico);
end //

DELIMITER ;
-- Test
call registro_empleado(2, '1010425312', 'Brayan', 'Yesid', 'Lindarte', 'Anaya', 'Calle 31 #6-72', 'Cucuta', '3123469865', 'brayancasimiro23@gmail.com');

select * from empleado;