-- Active: 1718882984278@@172.16.101.155@3306@mysql2_dia2
-- ############################
-- #### Dia # 2 - MySLQII ####
-- ############################

create database mysql2_dia2;

use mysql2_dia2;

-- TITULO: CONSULTAS AVANZADAS
create table productos(
    id int AUTO_INCREMENT,
    nombre VARCHAR(100),
    precio DECIMAL(10,2),
    PRIMARY KEY(id)
);

INSERT INTO productos VALUES
    (1,"Pepito",23.2),
    (2,"MousePad",100000.21),
    (3,"Espionap",2500.25),
    (4,"BOB-ESPONJA",1500.25),
    (5,"Cary",23540000.23),
    (6,"OvulAPP",198700.23),
    (7,"PapayAPP",2000.00),
    (8,"Menosprecio",3800.00),
    (9,"PerfumeMascotas",2300.00),
    (10,"Perfume La Cumbre", 35000.25),
    (11,"Nevera M800",3000.12),
    (12,"Crema Suave", 2845.00),
    (13,"juego de mesa La Cabellera",9800.00),
    (14,"Cargador iPhone",98000.00);

-- Para crear una funcion la cual me retorne el nombre del producto con el precio mas iva(19%)
-- Donde si vale menos de 1000 se aplica un descuento del 20%
delimiter //
create function TotalConIVA(precio decimal(10,2),iva decimal(5,3))
returns decimal(10,2) deterministic
begin
    if precio > 1000 then
        return (precio+(precio*iva))-((precio+(precio*iva))*0.2);
    else
        return precio+(precio*iva);
    end if;
end//
delimiter ;

-- Eliminar la funcion
drop FUNCTION TotalConIVA;
-- Utilizar la funcion TotalConIVA
select TotalConIVA(25000,0.19);

-- Extrapolar funcion con datos de la base de datos
select TotalConIVA(precio,0.19) from productos;

-- Funcion para obtener el precio de un producto dado su nombre
delimiter //
create function obtener_precio_producto(nombre_producto varchar(100)) 
returns decimal(10,2)
deterministic
begin
    declare precio_producto decimal(10,2);  
    select precio into precio_producto from productos
    where nombre = nombre_producto;
    return precio_producto;
end//
delimiter ;

-- Usar funcion 
select obtener_precio_producto('Pepito') as Precio;

-- Función para obtener el precio de un producto (con su iva y promoción)
-- dado su nombre
delimiter //
Create function obtener_precio_producto_prom(nombre_producto varchar(100))
returns decimal (10,2)
deterministic
begin
    declare precio_producto decimal(10,2);
    select TotalConIva(precio,0.19) into precio_producto from productos 
    where nombre = nombre_producto;
    return precio_producto;
end//
delimiter ;

-- Uso de la funcion
select obtener_precio_producto_prom('Pepito') as Precio;

-- Funcion para calcular el precio promedio de todos los productos
DELIMITER //
create Function precio_promedio_productos()
RETURNS DECIMAL(10,2)
DETERMINISTIC
begin
    declare promedio DECIMAL(10,2);
    select avg(precio) into promedio from productos;
    RETURN promedio;
end//
DELIMITER ;

select precio_promedio_productos();

-- Procedimiento para insertar un nuevo producto
DELIMITER //
create Procedure insertar_producto(in nombre_producto VARCHAR(100), in precio_producto decimal(10,2))
begin
    insert into productos (nombre,precio)
    values (nombre_producto, precio_producto);
end //
DELIMITER ;

-- Eliminar procedimiento
drop PROCEDURE insertar_producto;
-- Uso de procedimiento
call insertar_producto('sombrilla',50000.00);

-- Procedimiento para eliminar un producto dado su nombre
DELIMITER //
create Procedure eliminar_producto(in nombre_producto varchar(100))
begin
    delete from productos where nombre=nombre_producto;
end //
DELIMITER ;

call eliminar_producto('sombrilla');

-- Desarrollado por Deivid Velasquez Gutierrez / TI 1096701633