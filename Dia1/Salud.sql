-- Active: 1718423209898@@127.0.0.1@3306@dia1ii
-- ##################################
-- #### Dia # 1 BBDD de hospital ####
-- ##################################

create database dia1II;

use dia1II;

create table persona(
    id int(10) primary key,
    nombre varchar(25) not null,
    direccion varchar(50) not null,
    telefono varchar(20) not null,
    poblacion varchar(50) not null,
    provincia varchar(50) not null,
    codigoPostal varchar(10) not null,
    nif varchar(20) not null,
    numero_de_la_Seguridad_Social varchar(20) not null
);

create table medico(
    id_persona int(10) primary key,
    numeroColegiado  varchar(20) not null,
    tipo enum("Titular", "Interino", "Sustituto") not null,
    foreign key (id_persona) references persona(id)
);

create table empleado(
    id_persona int(10) primary key,
    tipo enum("ATS", "ATS de zona", "Auxiliar de enfermería", "Celador", "Administrativo") not null,
    foreign key (id_persona) references persona(id)
);

create table paciente(
    id_persona int(10) primary key,
    medico_asignado int(10),
    foreign key (id_persona) references persona(id),
    foreign key (medico_asignado) references medico(id_persona)
);

create table consulta(
    id int(10) primary key,
    id_medico int(10) not null,
    dia_semana enum("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo") not null,
    hora_inicio time not null,
    hora_final time not null,
    foreign key (id_medico) references medico(id_persona)
);

create table sustitucion(
    id_medico int(10),
    fecha_alta date not null,
    Fecha_baja date not null,
    primary key(id_medico, fecha_alta),
    foreign key (id_medico) references medico(id_persona)
);

create table vacaciones(
    id int(10) primary key,
    id_persona int(10) not null,
    fecha_inicio date not null,
    fecha_final date not null,
    estado enum("Planificada", "Disfrutada") not null,
    foreign key (id_persona) references persona(id)
);


-- ####### INSERT TABLES #######


INSERT INTO persona (id, nombre, direccion, telefono, poblacion, provincia, codigoPostal, nif, numero_de_la_Seguridad_Social)
VALUES 
(1, 'Dr. Juan Perez', 'Calle Falsa 123', '123456789', 'Ciudad A', 'Provincia A', '12345', 'NIF001', 'SS001'),
(2, 'Dra. Maria Lopez', 'Avenida Siempre Viva 742', '987654321', 'Ciudad B', 'Provincia B', '54321', 'NIF002', 'SS002'),
(3, 'Ana Martinez', 'Calle Sol 100', '456789123', 'Ciudad C', 'Provincia C', '67890', 'NIF003', 'SS003'),
(4, 'Luis Garcia', 'Avenida Luna 101', '789123456', 'Ciudad D', 'Provincia D', '09876', 'NIF004', 'SS004'),
(5, 'Pedro Sanchez', 'Calle Estrella 202', '321654987', 'Ciudad E', 'Provincia E', '56789', 'NIF005', 'SS005'),
(6, 'Carmen Rodriguez', 'Avenida Mar 303', '654987321', 'Ciudad F', 'Provincia F', '87654', 'NIF006', 'SS006'),
(7, 'Paciente 1', 'Calle Norte 1', '111222333', 'Ciudad G', 'Provincia G', '11223', 'NIF007', 'SS007'),
(8, 'Paciente 2', 'Calle Norte 2', '111222334', 'Ciudad H', 'Provincia H', '11224', 'NIF008', 'SS008'),
(9, 'Paciente 3', 'Calle Norte 3', '111222335', 'Ciudad I', 'Provincia I', '11225', 'NIF009', 'SS009'),
(10, 'Paciente 4', 'Calle Norte 4', '111222336', 'Ciudad J', 'Provincia J', '11226', 'NIF010', 'SS010'),
(11, 'Paciente 5', 'Calle Norte 5', '111222337', 'Ciudad K', 'Provincia K', '11227', 'NIF011', 'SS011'),
(12, 'Paciente 6', 'Calle Norte 6', '111222338', 'Ciudad L', 'Provincia L', '11228', 'NIF012', 'SS012');

INSERT INTO medico (id_persona, numeroColegiado, tipo)
VALUES 
(1, 'Colegiado001', 'Titular'),
(2, 'Colegiado002', 'Interino'),
(3, 'Colegiado003', 'Sustituto');


INSERT INTO empleado (id_persona, tipo)
VALUES 
(4, 'ATS'),
(5, 'Celador'),
(6, 'Administrativo');


INSERT INTO paciente (id_persona, medico_asignado)
VALUES 
(7, 1),
(8, 1),
(9, 2),
(10, 2),
(11, 1),
(12, 3);


INSERT INTO consulta (id, id_medico, dia_semana, hora_inicio, hora_final)
VALUES 
(1, 1, 'Lunes', '09:00:00', '12:00:00'),
(2, 1, 'Martes', '09:00:00', '11:00:00'),
(3, 1, 'Miércoles', '10:00:00', '12:00:00'),
(4, 2, 'Lunes', '14:00:00', '18:00:00'),
(5, 2, 'Martes', '14:00:00', '17:00:00'),
(6, 3, 'Lunes', '08:00:00', '10:00:00'),
(7, 3, 'Jueves', '08:00:00', '11:00:00');

INSERT INTO sustitucion (id_medico, fecha_alta, fecha_baja)
VALUES 
(3, '2024-01-01', '2024-03-01'),
(3, '2024-04-01', '2024-06-01');


INSERT INTO vacaciones (id, id_persona, fecha_inicio, fecha_final, estado)
VALUES 
(1, 1, '2024-07-01', '2024-07-10', 'Planificada'),
(2, 1, '2024-01-15', '2024-01-25', 'Disfrutada'),
(3, 4, '2024-08-01', '2024-08-15', 'Planificada'),
(4, 5, '2024-09-01', '2024-09-20', 'Disfrutada'),
(5, 6, '2024-10-01', '2024-10-12', 'Disfrutada');


-- ####### CONSULTAS TABLAS #######

--  1.Número de pacientes atendidos por cada médico

select m.id_persona as id_medico, p.nombre, COUNT(pa.id_persona) as numero_de_pacientes
from medico m
join persona p on m.id_persona = p.id
left join paciente pa on m.id_persona = pa.medico_asignado
group by m.id_persona, p.nombre;

-- 2.Total de días de vacaciones planificadas y disfrutadas por cada empleado

select e.id_persona, p.nombre, SUM(DATEDIFF(v.fecha_final, v.fecha_inicio)) as total_dias_vacaciones
from empleado e
join persona p on e.id_persona = p.id
join vacaciones v on e.id_persona = v.id_persona
group by e.id_persona, p.nombre;

-- 3.Médicos con mayor cantidad de horas de consulta en la semana

select c.id_medico, p.nombre, SUM(TIMESTAMPDIFF(HOUR, c.hora_inicio, c.hora_final)) as total_horas_semana
from consulta c
join persona p on c.id_medico = p.id
group by c.id_medico, p.nombre
ORDER BY total_horas_semana DESC;

-- 4.Número de sustituciones realizadas por cada médico sustituto

select s.id_medico, p.nombre, COUNT(*) as numero_de_sustituciones
from sustitucion s
join persona p on s.id_medico = p.id
GROUP BY s.id_medico, p.nombre;

-- 5.Número de médicos que están actualmente en sustitución

select COUNT(DISTINCT s.id_medico) as medicos_en_sustitucion
from sustitucion s
where s.fecha_baja IS NULL OR s.fecha_baja > CURRENT_DATE;

-- 6.Horas totales de consulta por médico por día de la semana

select c.id_medico, p.nombre, c.dia_semana, SUM(TIMESTAMPDIFF(HOUR, c.hora_inicio, c.hora_final)) as horas_totales
from consulta c
join persona p on c.id_medico = p.id
GROUP BY c.id_medico, p.nombre, c.dia_semana;

-- 7.Médico con mayor cantidad de pacientes asignados

select m.id_persona as id_medico, p.nombre, COUNT(pa.id_persona) as numero_de_pacientes
from medico m
join persona p on m.id_persona = p.id
left join paciente pa on m.id_persona = pa.medico_asignado
GROUP BY m.id_persona, p.nombre
ORDER BY numero_de_pacientes DESC
LIMIT 1;

-- 8.Empleados con más de 10 días de vacaciones disfrutadas

select e.id_persona, p.nombre, SUM(DATEDIFF(v.fecha_final, v.fecha_inicio)) as dias_disfrutados
from empleado e
join persona p on e.id_persona = p.id
join vacaciones v on e.id_persona = v.id_persona
where v.estado = 'Disfrutada'
GROUP BY e.id_persona, p.nombre
HAVING dias_disfrutados > 10;

-- 9.Médicos que actualmente están realizando una sustitución

select s.id_medico, p.nombre
from sustitucion s
join persona p on s.id_medico = p.id
where s.fecha_baja IS NULL OR s.fecha_baja > CURRENT_DATE;

-- 10.Promedio de horas de consulta por médico por día de la semana

select c.id_medico, p.nombre, c.dia_semana, AVG(TIMESTAMPDIFF(HOUR, c.hora_inicio, c.hora_final)) as promedio_horas
from consulta c
join persona p on c.id_medico = p.id
GROUP BY c.id_medico, p.nombre, c.dia_semana;

-- Desarrollado por Deivid Velasquez Gutierrez / TI: 1096701633