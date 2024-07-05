-- Active: 1720092096515@@172.16.101.155@3306@mysql2_dia5
-- #################################
-- ######## DIA 6 - MySQL 2 ########
-- #################################

use mysql2_dia5;

-- SUBCONSULTAS: Se usan para realizar operaciones que requieren un conjunto de datos que se obtiene de manera dinámica a través de otra consulta

-- SUBCONSULTA ESCALAR: Toda subconsulta que devuelve un solo valor (fila y columna)

-- EJ: Devuelva el nombre del país con la mayor población
select Name
from country
where population = (select max(`Population`) from country);

-- SUBCONSULTA DE COLUMNA ÚNICA: Devuelve una columna de múltiples filas.
-- EJ: Encuentre los nombres de todas las ciudades en los paises que tienen un área mayor a 1000000 km2
select Name 
from city
where `CountryCode` in (select code from country where `SurfaceArea` > 1000000);

-- SUBCONSULTAS DE MÚLTIPLES COLUMNAS: Devuelve múltiples columnas de múltiples filas
-- EJ: Encontrar las ciudades que tengan la misma población y distrito que cualquier ciudad del pais. USA
select Name, `CountryCode`, `District`, `Population`
from city
where (`District`, `Population`) in (select `District`, `Population` from city where `CountryCode` = 'USA');

-- SUBCONSULTA CORRELACIONADA: Depende de la consulta externa para cada fila procesada.
-- EJ: Liste las ciudades con una población mayor que el promedio de la poblacion de las ciudades en el mismo pais
select Name, `CountryCode`, `Population`
from city c1
where `Population` > (select avg(`Population`) from city c2 where c1.`CountryCode` = c2.`CountryCode`);

-- SUBCONSULTA MÚLTIPLE: 
-- EJ: las ciudades que tengan la misma poblacion que la capital del país 'JPN' (Japon)
select Name
from city
where `Population` = (select `Population` from city where ID = (select Capital from country where Code = 'JPN'));

-- INDEXACIÒN
SELECT * FROM city;

--Crear índice en la columna 'Name' de City
create index idx_city_name on city(Name);
select Name from city;

-- Crear índice compuesto de las columnas 'District' y 'Population'
create index idx_city_district_population on city(District, Population);
select District from city;


-- TRANSACCIONES
-- Son secuencias de uno o más operaciones SQL, las cuales son ejecutadas como una única unidad de trabajo. En otras palabras, las transacciones aseguran
-- que todas las operaciones se realices de manera correcta antes de ser ejecutadas en la bbdd real, buscando cumplir con las propiedades ACID.
-- (ATOMICIDAD, CONSISTENCIA, AISLAMIENTO, DURABILIDAD).

-- Primer paso: INICIAR LA TRANSACCIÓN
start TRANSACTION;

-- Segundo Paso: Hacer comandos
-- Actualizar la población de la ciudad de 'New York'
update city
set `Population` = 9000000
where Name = 'New York';

select * from city where Name = 'New York';

-- Tercer Paso: Si quiero que los cambios se mantengan pongo COMMIT, sino revierto mis cambios con ROLLBACk.

commit; -- Mandar cambios a produccion
rollback; -- Revertir cambios

-- Desarrollado  Gutierrez / TI: 1096701633por Deivid Velasquez