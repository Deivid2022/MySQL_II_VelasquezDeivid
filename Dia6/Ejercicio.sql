-- Active: 1720143799702@@127.0.0.1@3306@dia3
-- ##################################
-- ######## DIA 6 - MySQL 2 #########
-- ##################################

use dia3;

-- Escribe una consulta que permita agrupar los clientes de todos los empleados
-- cuyo puesto sea responsable de ventas. Se requiere que la consulta muestre:
-- Nombre del cliente, teléfono, la ciudad, nombre y primer apellido del responsable
-- de ventas y su email.

create index idx_cliente_codigo on cliente(codigo_empleado_rep_ventas);

create index idx_empleado_codigo on empleado(codigo_empleado);

select c.nombre_cliente, c.telefono, c.ciudad, e.nombre, e.apellido1, e.email
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
where e.puesto = 'Representante Ventas';

-- Se necesita obtener los registros de los pedidos entre el 15 de marzo del 2009 y
-- el 15 de julio del 2009, para todos los clientes que sean de la ciudad de
-- Sotogrande. Se requiere mostrar el código del pedido, la fecha del pedido, fecha
-- de entrega, estado, los comentarios y el condigo del cliente que realizo dicho
-- pedido.

create index idx_pedido_codigo on pedido(codigo_pedido, fecha_pedido, codigo_cliente);

create index idx_cliente_codigo2 on cliente(codigo_cliente);

select p.codigo_pedido, p.fecha_pedido, p.fecha_entrega, p.estado, p.comentarios, p.codigo_cliente
from pedido p
where p.fecha_pedido BETWEEN '2009-03-15' and '2009-07-15' and p.codigo_cliente in (select c.codigo_cliente from cliente c where ciudad = 'Sotogrande');

-- Se desea obtener los productos cuya gama pertenezca a las frutas y que el
-- proveedor sea Frutas Talaveras S.A, se desea mostrar el código, nombre,
-- descripción, cantidad en stock, y su precio con 10% de descuento, de igual forma
-- se pide la cantidad en los distintos pedidos que se han hecho.

create index idx_producto_codigo2 on producto(codigo_producto, gama, proveedor);

create index idx_detalle_pedido_codigo on detalle_pedido(codigo_producto);

select p.codigo_producto, p.nombre, p.descripcion, p.cantidad_en_stock, (p.precio_venta - (p.precio_venta * 0.1)) as descuento, count(d.codigo_producto) as cantidad_pedidos
from producto p
inner join detalle_pedido d on p.codigo_producto = d.codigo_producto
where p.gama = 'Frutales' and p.proveedor = 'Frutales Talavera S.A'
group by d.codigo_producto;

-- Desarrollado por Deivid Velasquez Gutierrez / TI: 1096701633 