-- Active: 1718972580738@@172.16.101.155@3306@mysql2_dia21
-- ############################
-- #### Dia # 2 - MySLQII #####
-- ############################

create database mysql2_dia21;

use mysql2_dia21;

-- CREATE TABLE

CREATE TABLE departamento (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DOUBLE UNSIGNED NOT NULL,
gastos DOUBLE UNSIGNED NOT NULL
);


CREATE TABLE empleado (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nif VARCHAR(9) NOT NULL UNIQUE,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
id_departamento INT UNSIGNED,
FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

-- INSERT TABLE

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);
INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero',NULL);

-- TABLE QUERIES

-- #### Consultas sobre una tabla ####

-- 1.Lista el primer apellido de todos los empleados. 

DELIMITER //
CREATE PROCEDURE listar_apellido1_empleados()
BEGIN
    SELECT apellido1 FROM empleado;
END //
DELIMITER ;

CALL listar_apellido1_empleados();

-- 2.Lista el primer apellido de los empleados eliminando los apellidos que estén
-- repetidos.

DELIMITER // 
CREATE PROCEDURE listar_apellido1_unique()
BEGIN 
	SELECT DISTINCT apellido1 FROM empleado;
END //
DELIMITER ; 

CALL listar_apellido1_unique();

-- 3.Lista todas las columnas de la tabla empleado.

DELIMITER //
CREATE PROCEDURE listar_all_empleados()
BEGIN 
	SELECT * FROM empleado;
END //
DELIMITER ;

CALL listar_all_empleados();

-- 4.Lista el nombre y los apellidos de todos los empleados.

DELIMITER //
CREATE PROCEDURE lista_names_apellidos_employed()
BEGIN 
	SELECT nombre, apellido1, apellido2 FROM empleado;
END //
DELIMITER ;

CALL lista_names_apellidos_employed();

-- 5.Lista el identificador de los departamentos de los empleados que aparecen
-- en la tabla empleado.
DELIMITER //
CREATE PROCEDURE listar_departamentos_employeds()
BEGIN 
	SELECT DISTINCT id_departamento FROM empleado WHERE id_departamento IS NOT NULL;
END //
DELIMITER ; 

CALL listar_departamentos_employeds();

-- 6.Lista el identificador de los departamentos de los empleados que aparecen
-- en la tabla empleado, eliminando los identificadores que aparecen repetidos.
DELIMITER //
CREATE PROCEDURE listar_departamentos_unicos()
BEGIN
	SELECT DISTINCT id_departamento FROM empleado WHERE id_departamento IS NOT NULL;
END //
DELIMITER ; 

CALL listar_departamentos_unicos();

-- 7.Lista el nombre y apellidos de los empleados en una única columna. 
DELIMITER //
CREATE PROCEDURE listar_nombre_apellidos_onecolumn()
BEGIN 
	SELECT CONCAT(nombre, ' ', apellido1, ' ', IFNULL(apellido2, '')) AS full_name FROM empleado;
END //
DELIMITER ;

CALL listar_nombre_apellidos_onecolumn();

-- 8.Lista el nombre y apellidos de los empleados en una única columna,
-- convirtiendo todos los caracteres en mayúscula.
DELIMITER //
CREATE PROCEDURE listar_nombre_apellidos_mayus()
BEGIN 
	SELECT UPPER(CONCAT(nombre, ' ', apellido1, ' ', IFNULL(apellido2, ''))) AS full_name_mayus FROM empleado;
END //
DELIMITER ;

CALL listar_nombre_apellidos_mayus();

-- 9.Lista el nombre y apellidos de los empleados en una única columna,
-- convirtiendo todos los caracteres en minúscula.
DELIMITER //
CREATE PROCEDURE listar_nombre_apellidos_minus()
BEGIN 
	SELECT LOWER(CONCAT(nombre, ' ', apellido1, ' ', IFNULL(apellido2, ''))) AS full_name_minus FROM empleado;
END //
DELIMITER ;

CALL listar_nombre_apellidos_minus();

-- 10.Lista el identificador de los empleados junto al nif, pero el nif deberá
-- aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la
-- otra la letra.
DELIMITER //
CREATE PROCEDURE listar_id_nif_separado()
BEGIN 
	SELECT id,
	SUBSTRING(nif, 1, LENGTH(nif) - 1)AS nif_digit,
    RIGHT(nif, 1) AS nif_letter
	FROM empleado;
END // 
DELIMITER ;

CALL listar_id_nif_separado(); 

-- 11.Lista el nombre de cada departamento y el valor del presupuesto actual del
-- que dispone. Para calcular este dato tendrá que restar al valor del
-- presupuesto inicial (columna presupuesto) los gastos que se han generado
-- (columna gastos). Tenga en cuenta que en algunos casos pueden existir
-- valores negativos. Utilice un alias apropiado para la nueva columna columna
-- que está calculando.
DELIMITER //
CREATE FUNCTION calcular_presupuesto_actual(presupuesto DOUBLE, gastos DOUBLE)
RETURNS DOUBLE
DETERMINISTIC 
BEGIN 
	RETURN presupuesto - gastos;
END // 
DELIMITER ; 

SELECT nombre, 
		calcular_presupuesto_actual(presupuesto, gastos) AS presupuesto_actual
FROM departamento;


-- 12.Lista el nombre de los departamentos y el valor del presupuesto actual
-- ordenado de forma ascendente.

SELECT nombre, 
		calcular_presupuesto_actual(presupuesto, gastos) AS presupuesto_actual
FROM departamento
ORDER BY presupuesto_actual ASC;

-- 13.Lista el nombre de todos los departamentos ordenados de forma
-- ascendente.

DELIMITER //
CREATE PROCEDURE listar_departamentos_asc()
BEGIN 
	SELECT nombre
    FROM departamento
	ORDER BY nombre ASC;
END //
DELIMITER ;

CALL listar_departamentos_asc();

-- 14.Lista el nombre de todos los departamentos ordenados de forma
-- descendente.
DELIMITER //
CREATE PROCEDURE listar_departamentos_desc()
BEGIN 
	SELECT nombre 
	FROM departamento 
	ORDER BY nombre DESC;
END //
DELIMITER ;

CALL listar_departamentos_desc();

-- 15.Lista los apellidos y el nombre de todos los empleados, ordenados de forma
-- alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su
-- nombre.
DELIMITER //
CREATE PROCEDURE lista_empleados_orde()
BEGIN
	SELECT apellido1, apellido2, nombre
    FROM empleado
    ORDER BY apellido1, apellido2, nombre;
END //
DELIMITER ;

CALL lista_empleados_orde();

-- 16.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.  
DELIMITER //
CREATE PROCEDURE top3_departamentos_mayor_presupuesto()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    ORDER BY presupuesto DESC
    LIMIT 3;
END //
DELIMITER ;

CALL top3_departamentos_mayor_presupuesto();

-- 17.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.
DELIMITER //
CREATE PROCEDURE top3_departamentos_menor_presupuesto()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    ORDER BY presupuesto ASC
    LIMIT 3;
END //
DELIMITER ;

CALL top3_departamentos_menor_presupuesto();

-- 18.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.
DELIMITER //
CREATE PROCEDURE top2_departamentos_mayor_gasto()
BEGIN
    SELECT nombre, gastos
    FROM departamento
    ORDER BY gastos DESC
    LIMIT 2;
END //
DELIMITER ;

CALL top2_departamentos_mayor_gasto();

-- 19.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.
DELIMITER //
CREATE PROCEDURE top2_departamentos_menor_gasto()
BEGIN
    SELECT nombre, gastos
    FROM departamento
    ORDER BY gastos ASC
    LIMIT 2;
END //
DELIMITER ;

CALL top2_departamentos_menor_gasto();

--20.Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La
-- tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las columnas de la tabla empleado.
DELIMITER //
CREATE PROCEDURE lista_empleados_desde_tercera()
BEGIN
    SELECT *
    FROM empleado
    LIMIT 2, 5;
END //
DELIMITER ;

CALL lista_empleados_desde_tercera(); 

-- 21.Devuelve una lista con el nombre de los departamentos y el presupuesto, de
-- aquellos que tienen un presupuesto mayor o igual a 150000 euros.
DELIMITER //
CREATE PROCEDURE departamentos_presupuesto_mayor_igual_150000()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    WHERE presupuesto >= 150000;
END //
DELIMITER ;

CALL departamentos_presupuesto_mayor_igual_150000();

-- 22.Devuelve una lista con el nombre de los departamentos y el gasto, de aquellos que tienen menos de 5000 euros de gastos.
DELIMITER //
CREATE PROCEDURE departamentos_gasto_menor_5000()
BEGIN
    SELECT nombre, gastos
    FROM departamento
    WHERE gastos < 5000;
END //
DELIMITER ;

CALL departamentos_gasto_menor_5000();
 
-- 23.Devuelve una lista con el nombre de los departamentos y el presupuesto, de
-- aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
DELIMITER //
CREATE PROCEDURE departamentos_presupuesto_entre_100000_y_200000()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    WHERE presupuesto >= 100000 AND presupuesto <= 200000;
END //
DELIMITER ;

CALL departamentos_presupuesto_entre_100000_y_200000();

-- 24.Devuelve una lista con el nombre de los departamentos que no tienen un
-- presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
DELIMITER //
CREATE PROCEDURE departamentos_presupuesto_fuera_100000_y_200000()
BEGIN
    SELECT nombre
    FROM departamento
    WHERE presupuesto < 100000 OR presupuesto > 200000;
END //
DELIMITER ;

CALL departamentos_presupuesto_fuera_100000_y_200000();

-- 25.Devuelve una lista con el nombre de los departamentos que tienen un
-- presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
DELIMITER //
CREATE PROCEDURE departamentos_presupuesto_entre_100000_y_200000_between()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    WHERE presupuesto BETWEEN 100000 AND 200000;
END //
DELIMITER ;

CALL departamentos_presupuesto_entre_100000_y_200000_between();

-- 26.Devuelve una lista con el nombre de los departamentos que no tienen un
-- presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
DELIMITER //
CREATE PROCEDURE departamentos_presupuesto_fuera_100000_y_200000_between()
BEGIN
    SELECT nombre
    FROM departamento
    WHERE presupuesto NOT BETWEEN 100000 AND 200000;
END //
DELIMITER ;

CALL departamentos_presupuesto_fuera_100000_y_200000_between();

-- 27.Devuelve una lista con el nombre de los departamentos, gastos y
-- presupuesto, de aquellos departamentos donde los gastos sean mayores que el presupuesto del que disponen.
DELIMITER //
CREATE PROCEDURE departamentos_gastos_mayores_que_presupuesto()
BEGIN
    SELECT nombre, gastos, presupuesto
    FROM departamento
    WHERE gastos > presupuesto;
END //
DELIMITER ;

CALL departamentos_gastos_mayores_que_presupuesto();

-- 28.Devuelve una lista con el nombre de los departamentos, gastos y
-- presupuesto, de aquellos departamentos donde los gastos sean menores que el presupuesto del que disponen.
DELIMITER //
CREATE PROCEDURE departamentos_gastos_menores_que_presupuesto()
BEGIN
    SELECT nombre, gastos, presupuesto
    FROM departamento
    WHERE gastos < presupuesto;
END //
DELIMITER ;

CALL departamentos_gastos_menores_que_presupuesto();

-- 29. Devuelve una lista con el nombre de los departamentos, gastos y
-- presupuesto, de aquellos departamentos donde los gastos sean iguales al
-- presupuesto del que disponen.
DELIMITER //
create FUNCTION departameto_gastos_iguales_presupuesto()
RETURNS varchar(100) DETERMINISTIC
begin
    DECLARE nombre_departamento varchar(100);
    select nombre into nombre_departamento from departamento
    where presupuesto = gastos;
    return nombre_departamento;
end//
DELIMITER ;

select departameto_gastos_iguales_presupuesto();

-- 30.Lista todos los datos de los empleados cuyo segundo apellido sea NULL.

DELIMITER //
create PROCEDURE empleado_segundo_apellido_null()
begin
    select *
    from empleado
    where apellido2 is null;
end//
DELIMITER ;

call empleado_segundo_apellido_null();

-- 31. Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.

DELIMITER //
create PROCEDURE empleado_segundo_apellido_no_null()
begin
    select *
    from empleado
    where apellido2 is not null;
end//
DELIMITER ;

call empleado_segundo_apellido_no_null();

-- 32. Lista todos los datos de los empleados cuyo segundo apellido sea López.

DELIMITER //
create PROCEDURE empleado_segundo_apellido_Lopez()
begin
    select *
    from empleado
    where apellido2 = 'López';
end//
DELIMITER ;

call empleado_segundo_apellido_Lopez();

-- 33. Lista todos los datos de los empleados cuyo segundo apellido
-- sea Díaz o Moreno. Sin utilizar el operador IN.

DELIMITER //
create PROCEDURE empleado_segundo_apellido_Díaz_o_Moreno()
begin
    select *
    from empleado
    where apellido2 = 'Díaz' or apellido2 = 'Moreno';
end//
DELIMITER ;

call empleado_segundo_apellido_Díaz_o_Moreno();

-- 34. Lista todos los datos de los empleados cuyo segundo apellido
-- sea Díaz o Moreno. Utilizando el operador IN.

DELIMITER //
create PROCEDURE empleado_segundo_apellido_Díaz_o_Moreno_in()
begin
    select *
    from empleado
    where apellido2 in ('Díaz', 'Moreno');
end//
DELIMITER ;

call empleado_segundo_apellido_Díaz_o_Moreno_in();

-- 35. Lista los nombres, apellidos y nif de los empleados que trabajan en el
-- departamento 3.

DELIMITER //
CREATE PROCEDURE empleadosEnDepartamento3()
BEGIN
    SELECT nombre, apellido1, apellido2, nif
    FROM empleado
    WHERE id_departamento = 3;
END //
DELIMITER ;

CALL empleadosEnDepartamento3();

--  36. Lista los nombres, apellidos y nif de los empleados que trabajan en los
-- departamentos 2, 4 o 5.

DELIMITER //
CREATE PROCEDURE empleadosEnDepartamento245()
BEGIN
    SELECT nombre, apellido1, apellido2, nif
    FROM empleado
    WHERE id_departamento in (2,4,5);
END //
DELIMITER ;

CALL empleadosEnDepartamento245();


-- #### Consultas multitabla (Composición interna) ####

-- 1. Devuelve un listado con los empleados y los datos de los departamentos
-- donde trabaja cada uno.

DELIMITER //
create PROCEDURE listaEmpleadoDepartamento()
begin
    select e.id as idEmpleado, e.nif, e.nombre as nombreEmpleado, e.apellido1, e.apellido2, d.id as idDepartamento, d.nombre as NombreDepartamento, d.presupuesto, d.gastos
    from empleado e
    inner join departamento d on e.id_departamento = d.id;
end //
delimiter ;

call listaEmpleadoDepartamento();

-- 2. Devuelve un listado con los empleados y los datos de los departamentos
-- donde trabaja cada uno.

DELIMITER //
CREATE PROCEDURE listarEmpleadosConDepartamentosOrdenado()
begin
    select e.nombre as nombre_empleado, e.apellido1, e.apellido2, e.nif, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    inner join departamento d on e.id_departamento = d.id
    ORDER BY d.nombre ASC, e.apellido1 ASC, e.apellido2 ASC, e.nombre ASC;
end //
DELIMITER ;

CALL listarEmpleadosConDepartamentosOrdenado();

-- 3. Devuelve un listado con el identificador y el nombre del departamento,
-- solamente de aquellos departamentos que tienen empleados.

DELIMITER //
CREATE Procedure identificadorNombreDepartamentos()
begin
    select d.id as identificador, d.nombre as NombreDepartamento
    from departamento d
    inner join empleado e on d.id = e.id_departamento;
end//
DELIMITER ;

call identificadorNombreDepartamentos();

-- 4. Devuelve un listado con el identificador, el nombre del departamento y el
-- valor del presupuesto actual del que dispone, solamente de aquellos
-- departamentos que tienen empleados.

DELIMITER //
create Procedure listarDepartamentosConPresupuestoActual()
begin
    select d.id as idDepartamento, d.nombre as NombreDepartamento, (d.presupuesto - d.gastos) as presupuestoActual
    from departamento d
    inner join empleado e on d.id = e.id_departamento
    GROUP BY d.id;
end //
DELIMITER ;

call listarDepartamentosConPresupuestoActual();

-- 5. Devuelve el nombre del departamento donde trabaja el empleado que tiene
-- el nif 38382980M.

DELIMITER //
create Procedure empleado_con_nif_38382980M()
begin
    select d.nombre as NombreDepartamento
    from departamento d
    inner join empleado e on d.id = e.id_departamento
    where e.nif = '38382980M';
end //
DELIMITER ;

call empleado_con_nif_38382980M();

-- 6. Devuelve el nombre del departamento donde trabaja el empleado 
-- Pepe Ruiz Santana.
DELIMITER //
CREATE FUNCTION obtener_departamento_pepe_ruiz_santana()
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    DECLARE depto_nombre VARCHAR(100);
    SELECT d.nombre INTO depto_nombre
    FROM empleado e
    JOIN departamento d ON e.id_departamento = d.id
    WHERE e.nombre = 'Pepe' AND e.apellido1 = 'Ruiz' AND e.apellido2 = 'Santana';
    RETURN depto_nombre;
END //
DELIMITER ;

SELECT obtener_departamento_pepe_ruiz_santana() AS departamento_pepe_ruiz_santana;

-- 7. Devuelve un listado con los datos de los empleados que trabajan en el
-- departamento de I+D. Ordena el resultado alfabéticamente.
DELIMITER //
CREATE PROCEDURE listar_empleados_id()
BEGIN
    SELECT e.*
    FROM empleado e
    JOIN departamento d ON e.id_departamento = d.id
    WHERE d.nombre = 'I+D'
    ORDER BY e.nombre, e.apellido1, e.apellido2;
END //
DELIMITER ;

CALL listar_empleados_id();

-- 8. Devuelve un listado con los datos de los empleados que trabajan en el
-- departamento de Sistemas, Contabilidad o I+D. Ordena el resultado
-- alfabéticamente.
DELIMITER //
CREATE PROCEDURE listar_empleados_departamentos_especificos()
BEGIN
    SELECT e.*
    FROM empleado e
    JOIN departamento d ON e.id_departamento = d.id
    WHERE d.nombre IN ('Sistemas', 'Contabilidad', 'I+D')
    ORDER BY e.nombre, e.apellido1, e.apellido2;
END //
DELIMITER ;

CALL listar_empleados_departamentos_especificos();

-- 9. Devuelve una lista con el nombre de los empleados que tienen los
-- departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
DELIMITER //
CREATE PROCEDURE listar_empleados_departamentos_presupuesto_no_rango()
BEGIN
    SELECT e.nombre, e.apellido1, e.apellido2
    FROM empleado e
    JOIN departamento d ON e.id_departamento = d.id
    WHERE d.presupuesto NOT BETWEEN 100000 AND 200000;
END //
DELIMITER ;

CALL listar_empleados_departamentos_presupuesto_no_rango();

-- 10. Devuelve un listado con el nombre de los departamentos donde existe
-- algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no
-- debe mostrar nombres de departamentos que estén repetidos.
DELIMITER //
CREATE PROCEDURE listar_departamentos_empleados_sin_apellido2()
BEGIN
    SELECT DISTINCT d.nombre
    FROM departamento d
    JOIN empleado e ON d.id = e.id_departamento
    WHERE e.apellido2 IS NULL;
END //
DELIMITER ;

CALL listar_departamentos_empleados_sin_apellido2();


-- #### Consultas multitabla (Composición externa) ####


-- 1. Devuelve un listado con todos los empleados junto con los datos de los
-- departamentos donde trabajan. Este listado también debe incluir los
-- empleados que no tienen ningún departamento asociado.
DELIMITER //
CREATE PROCEDURE listar_empleados_departamentos()
BEGIN
    SELECT e.*, d.nombre AS nombre_departamento, d.presupuesto, d.gastos
    FROM empleado e
    LEFT JOIN departamento d ON e.id_departamento = d.id;
END //
DELIMITER ;

CALL listar_empleados_departamentos();

-- 2. Devuelve un listado donde sólo aparezcan aquellos empleados que no
-- tienen ningún departamento asociado.
DELIMITER //
CREATE PROCEDURE listar_empleados_sin_departamento()
BEGIN
    SELECT e.*
    FROM empleado e
    LEFT JOIN departamento d ON e.id_departamento = d.id
    WHERE d.id IS NULL;
END //
DELIMITER ;

CALL listar_empleados_sin_departamento();

-- 3. Devuelve un listado donde sólo aparezcan aquellos departamentos que no
-- tienen ningún empleado asociado.
DELIMITER //
CREATE PROCEDURE listar_departamentos_sin_empleados()
BEGIN
    SELECT d.*
    FROM departamento d
    LEFT JOIN empleado e ON d.id = e.id_departamento
    WHERE e.id IS NULL;
END //
DELIMITER ;

CALL listar_departamentos_sin_empleados();

-- 4. Devuelve un listado con todos los empleados junto con los datos de los
-- departamentos donde trabajan. El listado debe incluir los empleados que no
-- tienen ningún departamento asociado y los departamentos que no tienen
-- ningún empleado asociado. Ordene el listado alfabéticamente por el
-- nombre del departamento.
DELIMITER //
CREATE PROCEDURE listar_empleados_departamentos_completo()
BEGIN
    SELECT e.*, d.nombre AS nombre_departamento, d.presupuesto, d.gastos
    FROM empleado e
    LEFT JOIN departamento d ON e.id_departamento = d.id
    UNION
    SELECT e.*, d.nombre AS nombre_departamento, d.presupuesto, d.gastos
    FROM empleado e
    RIGHT JOIN departamento d ON e.id_departamento = d.id
    ORDER BY nombre_departamento;
END //
DELIMITER ;

CALL listar_empleados_departamentos_completo();

-- 5. Devuelve un listado con los empleados que no tienen ningún departamento
-- asociado y los departamentos que no tienen ningún empleado asociado.
-- Ordene el listado alfabéticamente por el nombre del departamento.
DELIMITER //
CREATE PROCEDURE listar_empleados_departamentos_no_asociados()
BEGIN
    SELECT e.*, d.nombre AS nombre_departamento, d.presupuesto, d.gastos
    FROM empleado e
    LEFT JOIN departamento d ON e.id_departamento = d.id
    WHERE d.id IS NULL
    UNION
    SELECT e.*, d.nombre AS nombre_departamento, d.presupuesto, d.gastos
    FROM empleado e
    RIGHT JOIN departamento d ON e.id_departamento = d.id
    WHERE e.id IS NULL
    ORDER BY nombre_departamento;
END //
DELIMITER ;

CALL listar_empleados_departamentos_no_asociados();

-- #### Consultas resumen ####

-- 1.Calcula la suma del presupuesto de todos los departamentos.
delimiter //
create function suma_presupuesto()
returns double deterministic
begin
	declare suma_total double;
	select sum(presupuesto) into suma_total from departamento;
	return suma_total;
end//
delimiter ;

select suma_presupuesto() as suma_presupuesto;

-- 2.Calcula la media del presupuesto de todos los departamentos.
delimiter //
create function media_presupuesto()
returns double deterministic
begin
	declare presupuesto_media double;
	select avg(presupuesto) into presupuesto_media from departamento;
	return presupuesto_media;
end//
delimiter ;

select media_presupuesto() as media_presupuesto;

-- 3.Calcula el valor mínimo del presupuesto de todos los departamentos.
delimiter //
create function minimo_presupuesto()
returns double deterministic
begin
	declare presupuesto_min double;
	select min(presupuesto) into presupuesto_min from departamento;
	return presupuesto_min;
end//
delimiter ;

select minimo_presupuesto() as minimo_presupuesto;

-- 4.Calcula el nombre del departamento y el presupuesto que tiene asignado,
-- del departamento con menor presupuesto.
delimiter //
create function minimo_presupuesto_nombre()
returns varchar(100) deterministic
begin
    declare min_presupuesto int;
    declare depto_nombre varchar(50);
    declare resultado varchar(100);
    select min(presupuesto) into min_presupuesto from departamento;
    select nombre into depto_nombre from departamento where presupuesto = min_presupuesto limit 1;
    set resultado = concat('Nombre: ', depto_nombre, ', Presupuesto: ', min_presupuesto);
    return resultado;
end//
delimiter ;

select minimo_presupuesto_nombre() as resultado;

-- 5.Calcula el valor máximo del presupuesto de todos los departamentos.
delimiter //
create function maximo_presupuesto()
returns double deterministic
begin
	declare presupuesto_max double;
	select max(presupuesto) into presupuesto_max from departamento;
	return presupuesto_max;
end//
delimiter ;

select maximo_presupuesto() as maximo_presupuesto;

-- 6.Calcula el nombre del departamento y el presupuesto que tiene asignado,
-- del departamento con mayor presupuesto.
delimiter //
create procedure maximo_presupuesto()
begin
    declare max_presupuesto int;
    select max(presupuesto) into max_presupuesto from departamento;
    select nombre, presupuesto
    from departamento
    where presupuesto = max_presupuesto;
end//
delimiter ;

call maximo_presupuesto();

-- 7.Calcula el número total de empleados que hay en la tabla empleado.
delimiter //
create procedure numero_empleados()
begin
	select count(id) from empleado;
end//
delimiter ;

call numero_empleados();

-- 8.Calcula el número de empleados que no tienen NULL en su segundo
-- apellido.
delimiter //
create procedure empleados_no_null()
begin
	select count(id) from empleado where apellido2 is not null;
end//
delimiter ;

call empleados_no_null();

-- 9.Calcula el número de empleados que hay en cada departamento. Tienes que
-- devolver dos columnas, una con el nombre del departamento y otra con el
-- número de empleados que tiene asignados.

delimiter //
create procedure nombre_numero_depto()
begin
	select departamento.nombre, count(empleado.id) from departamento inner join empleado on departamento.id = empleado.id_departamento group by departamento.nombre;
end//
delimiter ;

call nombre_numero_depto();

-- 10.Calcula el nombre de los departamentos que tienen más de 2 empleados. El
-- resultado debe tener dos columnas, una con el nombre del departamento y
-- otra con el número de empleados que tiene asignados.

delimiter //
create procedure depto_2()
begin
	select departamento.nombre, count(empleado.id) from departamento inner join empleado on departamento.id = empleado.id_departamento group by departamento.nombre having count(empleado.id)>2;	
end//
delimiter ;

call depto_2();

-- 11.Calcula el número de empleados que trabajan en cada uno de los
-- departamentos. El resultado de esta consulta también tiene que incluir
-- aquellos departamentos que no tienen ningún empleado asociado.
delimiter //
create procedure nombre_numero_depto_todos()
begin
	select departamento.nombre, count(empleado.id) from departamento left join empleado on departamento.id = empleado.id_departamento group by departamento.nombre;
end//
delimiter ;

call nombre_numero_depto_todos();

-- 12.Calcula el número de empleados que trabajan en cada unos de los
-- departamentos que tienen un presupuesto mayor a 200000 euros.
delimiter //
create procedure depto_mayor()
begin
	select departamento.nombre,departamento.presupuesto, count(empleado.id) from departamento left join empleado on departamento.id = empleado.id_departamento where departamento.presupuesto>200000 group by departamento.nombre, departamento.presupuesto;	
end//
delimiter ;

call depto_mayor();

-- Desarrollado por Deivid Velasquez Gutierrez / TI: 1096701633