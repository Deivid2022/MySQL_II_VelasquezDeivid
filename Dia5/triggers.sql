-- #############################
-- ###### DIA 5 - MySQL 2 ######
-- #############################

USE mysql2_dia5;

-- Trigger para insertar o actualizar una ciudad en país con
-- la nueva población

DELIMITER //

CREATE TRIGGER after_city_insert_update
AFTER INSERT ON city
FOR EACH ROW 
BEGIN 
    UPDATE country
    SET Population = Population + NEW.Population
    WHERE CODE = NEW.CountryCode;

END //

DELIMITER ;

-- Trigger para insertar o actualizar una ciudad en país con
-- la nueva población después de haberse eliminado


DELIMITER //

CREATE TRIGGER after_city_delete
AFTER DELETE ON city
FOR EACH ROW 
BEGIN 
    UPDATE country
    SET Population = Population - OLD.Population
    WHERE Code = OLD.CountryCode;

END //

DELIMITER ;

SELECT * from city where `Name`= "Artemis";
DELETE from city where id = 4080;

-- Crear una tabla para auditoria de ciudad
CREATE Table if not exists city_audit(
    audit_id int AUTO_INCREMENT PRIMARY KEY,
    city_id int,
    action varchar(10),
    old_population int,
    new_population int,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Test
INSERT into city (`Name`, `CountryCode`, `District`, `Population`)
values ('Artemis', 'AFG', 'Piso 6', 1250000);

-- Trigger para auditoria de ciudades cuando se inserta
DELIMITER //
create Trigger after_city_insert_audit
AFTER INSERT on city
for EACH row
begin
    insert into city_audit(city_id, action, new_population)
    values (new.id, 'INSERT', new.Population);
end //
DELIMITER ;


-- Trigger para auditoria de ciudades cuando se inserta
DELIMITER // 
create trigger after_city_update_audit
after update on city
for each row
begin
    insert into city_audit(city_id, `action`, old_population, new_population)
    values (OLD.ID, 'UPDATE', OLD.Population, new.Population);
end //
DELIMITER ;

-- Test
update city set `Population` = 1500000 where ID=4081;
select * from city_audit;

-- EVENTOS
-- CREACIÓN DE TABLA PARA BK DE CIUDADES
create table if not exists city_backup(
    ID int not null,
    Name char(35) not null,
    CountryCode char(3) not null,
    District char(20) not null,
    Population int not null,
    PRIMARY KEY (ID)
) Engine=InnoDB DEFAULT charset=utf8mb4;

DELIMITER //
create event if not exists weekly_city_backup
on schedule every 1 week
DO
begin
    truncate table city_backup;
    insert into city_backup(ID, Name, `CountryCode`, `District`)
    select ID, Name, `CountryCode`, `District`, `Population`
    from city;
end //
DELIMITER ;


