-- Active: 1719230625866@@172.16.101.155@3306@mysql2_dia4
-- ################################
-- ####### Dia 4 - MySQL 2  #######
-- ################################

show database;

create database mysql2_dia4;
use mysql2_dia4;

-- Creación de usuario camper con acceso desde cualquier parte
create user 'camper'@'%' identified by 'campus2023';

-- Revisar permisos de x usuario
show grants for 'camper'@'%';

--Crear una tabla de personas
create table persona(id int PRIMARY key, nombre VARCHAR(255), apellido VARCHAR(255));
INSERT into persona (id, nombre, apellido) values (1, 'Juan', 'Perez');
INSERT into persona (id, nombre, apellido) values (2, 'Andres', 'Pastrana');
INSERT into persona (id, nombre, apellido) values (3, 'Pedro', 'Gómez');
INSERT into persona (id, nombre, apellido) values (4, 'Camilo', 'Gonzalez');
INSERT into persona (id, nombre, apellido) values (5, 'Stiven', 'Maldonado');
INSERT into persona (id, nombre, apellido) values (6, 'Ardila', 'Perez');
INSERT into persona (id, nombre, apellido) values (7, 'Ruben', 'Gómez');
insert into persona (id,nombre,apellido) values (8,'Andres','Portilla');
insert into persona (id,nombre,apellido) values (9,'Miguel','Carvajal');
insert into persona (id,nombre,apellido) values (10,'Andrea','Gómez');

-- Asignar permisos a x usuario para que acceda a la tabla persona de y base de datos
grant select on mysql2_dia4.persona to 'camper'@'%';

-- refrecar permisos de la BBDD
flush privileges;

-- Añadir permisos para hacer CRUD
grant update, insert, delete on mysql2_dia4.persona to 'camper'@'%';

-- Crear otra tabla 
create table persona2(id int PRIMARY key, nombre VARCHAR(255), apellido VARCHAR(255));
INSERT into persona2 (id, nombre, apellido) values (1, 'Carlos', 'Perez');
INSERT into persona2 (id, nombre, apellido) values (2, 'Andres', 'Martinez');
INSERT into persona2 (id, nombre, apellido) values (3, 'Alejandro', 'Gómez');
INSERT into persona2 (id, nombre, apellido) values (4, 'Camila', 'Gonzalez');
INSERT into persona2 (id, nombre, apellido) values (5, 'Stiven', 'Montañas');
INSERT into persona2 (id, nombre, apellido) values (6, 'Ardila', 'Lule');
INSERT into persona2 (id, nombre, apellido) values (7, 'Sebastian', 'Gómez');
insert into persona2 (id,nombre,apellido) values (8,'Andres','Portrilla');
insert into persona2 (id,nombre,apellido) values (9,'Miguel','Carvajal');
insert into persona2 (id,nombre,apellido) values (10,'Andrea','Gómez');

-- PELIGROSO: CREAR UN USUARIO CON PERMISOS A TODO DESDE CUALQUIER LADO CON MALA CONTRASEÑA
create user 'todito'@'%' identified by 'todito';
grant all on *.* to 'todito'@'%';
show grants for 'todito'@'%';

-- Denegar todos los permisos 
revoke all on *.* from 'todito'@'%';

-- Crear un limite para que solamente se hagan x consultas por hora 
alter user 'camper'@'%' with MAX_QUERIES_PER_HOUR 5;
flush PRIVILEGES;
-- create user 'camper'@'%' identified by 'campus2023'

-- Revisar los límites o permisos que tiene un usuario a nivel de motor
select * from mysql.user where User='camper';

-- Eliminar usurario 
drop user 'camper'@'%'

-- Solo poner permisos para que consulte una x base de datos, una y tabla y una z columna
grant select (nombre) on mysql2_dia4.persona to 'camper'@'%';

-- Desarrollado por Deivid Velasquez Gutierrez / TI: 1096701633