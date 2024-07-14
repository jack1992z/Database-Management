SELECT * FROM "esquema"."DEPARTAMENTOS";

-- SELECT DISTINCT
--elimina duplicados
SELECT "NOMBRE" FROM "esquema"."PERSONAS";
SELECT DISTINCT "NOMBRE" FROM "esquema"."PERSONAS";

-- SELECT COUNT
-- cuantas filas de datos se tiene.
select count(*) from "esquema"."PRODUCTOS";

/* where */
SELECT * from "esquema"."PERSONAS";
SELECT * from "esquema"."PERSONAS" WHERE "EDAD">=30;
SELECT * from "esquema"."PERSONAS" WHERE "NOMBRE">='PEDRO';

-- ORDER BY : usado para ordenar
-- ORDENANDO LA COLUMNA EN FUNCION A EDAD
SELECT * from "esquema"."PERSONAS" ORDER BY "EDAD" ASC;
SELECT * from "esquema"."PERSONAS" ORDER BY "EDAD", "EDAD" DESC;

-- LIMIT: Limitar el numero de filas.
SELECT COUNT (*) FROM "esquema"."PERSONAS";
SELECT  * FROM "esquema"."PERSONAS" LIMIT 2;

--- BETWEEN: SELECCIONAR VALORES ENTRE MINIMOS Y MAXIMOS
select * from "esquema"."PEDIDOS" where "IMPORTE" BETWEEN 100 and 200;
select * from "esquema"."PEDIDOS" WHERE "PEDIDOS"."FECHA" BETWEEN '2020-08-02' AND '2020-08-04';


--- BETWEEN: SELECCIONAR VALORES ENTRE MINIMOS Y MAXIMOS
select * from "esquema"."PEDIDOS" where "IMPORTE" BETWEEN 100 and 200;
select * from "esquema"."PEDIDOS" WHERE "PEDIDOS"."FECHA" BETWEEN '2020-08-02' AND '2020-08-04';

-- IN: sleecionar una lista de valores
SELECT * from "esquema"."PRODUCTOS";
SELECT * from "esquema"."PRODUCTOS" where "PRODUCTO" in ('ORDENADOR', 'IMPRESORA', 'TECLADO');
SELECT * from "esquema"."PRODUCTOS" where "PRODUCTO" NOT in ('ORDENADOR', 'IMPRESORA', 'TECLADO');


-- LIKE: BUSCAR POR PATRONES
-- buscar a la personas cuyo nombr eempiesa con "a"
SELECT * FROM esquema."PERSONAS" where "NOMBRE" like 'A%';
SELECT * FROM esquema."PERSONAS" where "NOMBRE" ilike 'a%';
SELECT * FROM esquema."PERSONAS" where "NOMBRE" ilike '_NT%';


--  GROUO By  HAVING: reemplazo de where
SELECT "PRODUCTO", SUM("IMPORTE")
FROM  esquema."PEDIDOS"
GROUP BY "PRODUCTO"
HAVING SUM("IMPORTE") > 200;

-- AS: sirve para crear un alias
SELECT * FROM esquema."PEDIDOS";
SELECT "ID" AS "CLAVE", "PRODUCTO" AS "VALOR 0", "IMPORTE"  AS "VALOR 1"
from esquema."PEDIDOS";


-- INNER JOIN
SELECT "NOMBRE","DEPARTAMENTO"
FROM "esquema"."PERSONAS" INNER JOIN "esquema"."DEPARTAMENTOS"
ON "esquema"."PERSONAS"."DEP" = "esquema"."DEPARTAMENTOS"."DEP";


-- FULL JOIN: selecciond e todo
Select * from esquema."PERSONAS";
SELECT "NOMBRE", "APELLIDO1", "DEPARTAMENTO"
from esquema."PERSONAS" full join "esquema"."DEPARTAMENTOS"
on esquema."PERSONAS"."DEP" = "esquema"."DEPARTAMENTOS"."DEP";

-- LEFT JOIN
SELECT "NOMBRE", "APELLIDO1", "DEPARTAMENTO"
FROM esquema."PERSONAS" LEFT JOIN esquema."DEPARTAMENTOS"
on esquema."PERSONAS"."DEP"= esquema."DEPARTAMENTOS"."DEP";


-- RIGHT JOIN
SELECT "NOMBRE", "APELLIDO1", "DEPARTAMENTO"
FROM esquema."PERSONAS" RIGHT JOIN esquema."DEPARTAMENTOS"
on esquema."PERSONAS"."DEP"= esquema."DEPARTAMENTOS"."DEP";


-- union: UNE LAS CONSULTAS
SELECT "PRODUCTO", "IMPORTE" FROM esquema."PEDIDOS" where "IMPORTE" > 200
UNION
SELECT "PRODUCTO", "IMPORTE" FROM esquema."PEDIDOS" WHERE "PRODUCTO" = 'RATON';


/* FECJA Y HORA */
-- SELECT now()
-- SELECT TIMEOFDAY() -- INDICA LA FECHA
-- SELECT CURRENT_TIME -- INDICA LA HORA ACTUAL
-- select CURRENT_DATE -- INDICA LA FECHA
SELECT EXTRACT (DAY FROM "FECHA") AS "DIAA"
FROM esquema."PEDIDOS" ;-- EXTRAE EL DIA

-- MATEMATICAS
SELECT * FROM esquema."PEDIDOS";
SELECT "IMPORTE"/"CANTIDAD" AS "Precio Unitario"
FROM esquema."PEDIDOS";


-- CARACTERES
SELECT * FROM esquema."PERSONAS";
/* conteo de caracteres*/
select "NOMBRE" ,length ("NOMBRE") AS "longitud"
from esquema."PERSONAS";
/* minusculas*/
select "NOMBRE" ,LOWER ("NOMBRE") AS "minusculas"
from esquema."PERSONAS";
select "NOMBRE" ,left ("NOMBRE",3) AS "longitud"
from esquema."PERSONAS";


-- Subconsulta Valor numerico
-- CONSULTA SOBRE CONSULTA
select "PRODUCTO", "IMPORTE", "FECHA" from esquema."PEDIDOS"
where "IMPORTE" >(SELECT AVG("IMPORTE") FROM esquema."PEDIDOS");


-- Subconsulta por lista de Valores
select "DEP", "DEPARTAMENTO" from esquema."DEPARTAMENTOS"
where "DEP" in
(SELECT "DEP" FROM esquema."PERSONAS" WHERE "EDAD" > 30);


-- Subconsulta con EXITS
SELECT "NOMBRE", "APELLIDO1", "DEP"
from esquema."PERSONAS" as p
where EXISTS
(SELECT * FROM esquema."DEPARTAMENTOS" as D
WHERE D."DEP" = P."DEP");


drop TABLE usuarios;
create table usuarios(
    id_usuario INTEGER ,
    nombre varchar(50),
    apellido1 varchar(50),
    apellido2 varchar(50),
    contraseña varchar(50),
    email varchar(50),
    fecha_creacion DATE
);

select * from "usuarios";

/* Insertar */

INSERT INTO usuarios(id_usuario,nombre, apellido1, apellido2, contraseña, email, fecha_creacion)
values(2,'Brian', 'marquez', 'inca roca', '123', 'brian@mail.com', CURRENT_TIMESTAMP)

INSERT INTO usuarios(id_usuario,nombre, apellido1, apellido2, contraseña, email, fecha_creacion)
values(5,'Maria', 'Isabel', 'Isabel', '456', 'maria@mail.com', CURRENT_TIMESTAMP)

INSERT INTO usuarios(id_usuario,nombre, apellido1, apellido2, contraseña, email, fecha_creacion)
values(6,'brianenrique', 'Isabel', 'Isabel', '456', 'brianenrique@mail.com', CURRENT_TIMESTAMP)

INSERT INTO usuarios(id_usuario,nombre, apellido1, apellido2, contraseña, email, fecha_creacion)
values(9,'jackup', 'Isabel', 'Isabel', '456', 'jackup@mail.com', CURRENT_TIMESTAMP)

-- insert into usuarios select ... from source_table;
-- insert into usuarios(id_usuario,nombre) values(10,'test'),(11,'test1');
-- truncate table db.tb_name; copy db.tb_name from '/home/path/xxx.txt';



drop TABLE ocupaciones;
create table ocupaciones(
    id_ocupacion INTEGER,
    tipo_ocupacion varchar(50),
    descripcion varchar(150)
);

Insert Into ocupaciones(id_ocupacion,tipo_ocupacion, descripcion)
values (1,'DBA', 'Reliaza Mantenimiento a la base de datos')

create table usuario_ocupaciones(
    id_usuario integer,
    id_ocupacion integer
);

Insert into usuario_ocupaciones(id_usuario, id_ocupacion)
values (1,1);


/* update */
select * from usuarios;
update usuarios set email='jackupzting@mail.com'
where id_usuario = 9;



-- delete
Insert Into ocupaciones(id_ocupacion,tipo_ocupacion, descripcion)
values (2,'programador', 'Reliaza Mantenimiento de lo sistemas');

Insert Into ocupaciones(id_ocupacion,tipo_ocupacion, descripcion)
values (3,'programador 2', 'Reliaza Mantenimiento a la base de datos 2');

select * from "ocupaciones";
/* delete */
delete from ocupaciones
where id_ocupacion = 3;


-- Alter modifica la esctrutura de la BD o tabla
select * from ocupaciones;

 /*alter*/
 alter table ocupaciones rename column descripcion to tipo_descripcion;
select * from ocupaciones;

 alter table ocupaciones
 rename column tipo_descripcion to descripcion;
 select * from ocupaciones;

-- CASE
SELECT * from usuarios;

select nombre,
case
	when nombre= 'Brian' then 'A'
	when nombre= 'Maria' then 'M'
	ELSE '?'
END As resultado
from usuarios;


-- COALESCE
SELECT COALESCE(NULL,NULL,3);


-- cast
SELECT cast (5 as varchar );



-- Importar fichero .csv en una tabla

create table tabla1(
	columna varchar (50),
	columna2 varchar (50),
	columna3 varchar (50)
);

select * from tabla1;

-- Permission denied   chmod +r fichero.csv
COPY tabla1(columna,columna2,columna3) FROM './fichero.csv/fichero.csv' DELIMITER ',' CSV HEADER;



-- eg 
select
  depname,
  empno,
  sum(salary) over(partition by depname order by empno) as run_total
from empsalary;

SELECT depname, empno, salary, avg(salary) OVER (PARTITION BY depname) FROM empsalary;
SELECT
  depname, empno, salary,
  rank() OVER (PARTITION BY depname ORDER BY salary DESC) as rnk
FROM empsalary;

SELECT salary, sum(salary) OVER () FROM empsalary;

SELECT salary, sum(salary) OVER (ORDER BY salary) FROM empsalary;

SELECT depname, empno, salary, enroll_date
FROM
  (SELECT depname, empno, salary, enroll_date,
          rank() OVER (PARTITION BY depname ORDER BY salary DESC, empno) AS pos
     FROM empsalary
  ) AS ss
WHERE pos < 3;

SELECT sum(salary) OVER w, avg(salary) OVER w
FROM empsalary
WINDOW w AS (PARTITION BY depname ORDER BY salary DESC);


WITH t as (
  SELECT generate_series(1,3)
)
SELECT * FROM t;

WITH RECURSIVE r AS (
       SELECT * FROM test_area WHERE id = 7
     UNION   ALL
       SELECT test_area.* FROM test_area, r WHERE test_area.id = r.fatherid 
     )
 SELECT * FROM r ORDER BY id;



-- explain
explain analyse select * from tb_name tablesample system(0.01);

explain analyze select * from tb_name tablesample bernoulli(0.01);

-- select string_agg(city,',') from city;
-- SELECT country,string_agg(city,',') FROM city GROUP BY country;
-- SELECT country,array_agg(city) FROM city GROUP BY country;

CREATE TABLE score ( id serial primary key,
                      subject character varying(32),
                      stu_name character varying(32),
                      score numeric(3,0) );

INSERT INTO score ( subject,stu_name,score ) VALUES ('Chinese','francs',70);
INSERT INTO score ( subject,stu_name,score ) VALUES ('Chinese','matiler',70);
INSERT INTO score ( subject,stu_name,score) VALUES ('Chinese','tutu',80);
INSERT INTO score ( subject,stu_name,score ) VALUES ('English','matiler',75);
INSERT INTO score ( subject,stu_name,score ) VALUES ('English','francs',90);
INSERT INTO score ( subject,stu_name,score ) VALUES ('English','tutu',60);
INSERT INTO score ( subject,stu_name,score ) VALUES ('Math','francs',80);
INSERT INTO score ( subject,stu_name,score ) VALUES ('Math','matiler',99);
INSERT INTO score ( subject,stu_name,score ) VALUES ('Math','tutu',65);
SELECT row_number() OVER (partition by subject ORDER BY score desc),* FROM score;

SELECT  row_number() OVER (ORDER BY id) AS rownum ,* FROM score;

SELECT s.subject, s.stu_name,s.score, tmp.avgscore
FROM score s
LEFT JOIN (SELECT subject, avg(score) avgscore FROM score GROUP BY subject) tmp
ON s.subject = tmp.subject;
SELECT subject,stu_name, score, avg(score) OVER(PARTITION BY subject) FROM score;
SELECT rank() OVER(PARTITION BY subject ORDER BY score),* FROM score;

SELECT dense_rank() OVER(PARTITION BY subject ORDER BY score),* FROM score;




----------------------------------
create table sensor_stat(
  sid int,             -- 传感器ID
  state boolean,       -- 传感器状态，true在线，false离线
  crt_time timestamp   -- 状态上传时间
);
create index idx_sensor_stat_1 on sensor_stat(sid, crt_time desc); 

insert into sensor_stat select random()*1000, (random()*1)::int::boolean, clock_timestamp() from generate_series(1,1101);  -- 110100000

create table sensor_stat1 (
  sid int,             -- 传感器ID
  state boolean,       -- 传感器状态，true在线，false离线
  crt_time timestamp   -- 状态上传时间
);

create table sensor_stat2 (
  sid int,             -- 传感器ID
  state boolean,       -- 传感器状态，true在线，false离线
  crt_time timestamp   -- 状态上传时间
);

with recursive t as
(
  (
    select sensor_stat as sensor_stat from sensor_stat order by sid, crt_time desc limit 1
  )
  union all
  (
    select (select t1 from sensor_stat AS t1 where t1.sid>(t.sensor_stat).sid order by sid, crt_time desc limit 1) from t where (t.sensor_stat).sid is not null
  )
)
select (t.sensor_stat).* from t where t.* is not null;

explain (analyze,verbose,timing,costs,buffers) with recursive t as
(
  (
    select sensor_stat as sensor_stat from sensor_stat where state is true order by sid, crt_time desc limit 1
  )
  union all
  (
    select (select t1 from sensor_stat AS t1 where t1.sid>(t.sensor_stat).sid and t1.state is true order by sid, crt_time desc limit 1) from t where (t.sensor_stat).sid is not null
  )
)
select (t.sensor_stat).* from t where t.* is not null;

with recursive t as
(
  (
    select sensor_stat as sensor_stat from sensor_stat order by sid, crt_time desc limit 1
  )
  union all
  (
    select (select t1 from sensor_stat AS t1 where t1.sid>(t.sensor_stat).sid order by sid, crt_time desc limit 1) from t where (t.sensor_stat).sid is not null  
  )
)
select count(*) from t where t.* is not null and (t.sensor_stat).state is true;


with recursive t as
(
  (
    select sensor_stat as sensor_stat from sensor_stat order by sid, crt_time desc limit 1
  )
  union all
  (
    select (select t1 from sensor_stat AS t1 where t1.sid>(t.sensor_stat).sid order by sid, crt_time desc limit 1) from t where (t.sensor_stat).sid is not null
  )
)
select count(*) from t where t.* is not null and (t.sensor_stat).state is true;


with recursive t as
(
  (
    select sensor_stat as sensor_stat from sensor_stat where crt_time <= '2017-07-05 10:29:09' order by sid, crt_time desc limit 1
  )
  union all
  (
    select (select t1 from sensor_stat AS t1 where t1.crt_time <= '2017-07-05 10:29:09' and t1.sid>(t.sensor_stat).sid order by sid, crt_time desc limit 1) from t where (t.sensor_stat).sid is not null
  )
)
select count(*) from t where t.* is not null and (t.sensor_stat).state is true;


create table result (crt_time timestamp(0) default now(), state boolean, cnt int);
create index idx_result_1 on result using brin (crt_time);
insert into result (state,cnt)
with recursive t as
(
  (
    select sensor_stat as sensor_stat from sensor_stat order by sid, crt_time desc limit 1
  )
  union all
  (
    select (select t1 from sensor_stat AS t1 where t1.sid>(t.sensor_stat).sid order by sid, crt_time desc limit 1) from t where (t.sensor_stat).sid is not null
  )
)
select (t.sensor_stat).state, count(*) from t where t.* is not null group by 1;

select '2017-07-05 11:11:00', min(cnt), max(cnt) from result where crt_time between '2017-07-05 11:11:00' and '2017-07-05 11:12:00'; 
-- select to_char(crt_time, 'yyyy-mm-dd hh24:mi:00'), min(cnt), max(cnt) from result where crt_time between ? and ? group by 1;  
