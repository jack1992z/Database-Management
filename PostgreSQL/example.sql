
CREATE DATABASE curso WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';

ALTER DATABASE curso OWNER TO postgres;

connect curso


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE SCHEMA esquema;
ALTER SCHEMA esquema OWNER TO postgres;
SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE TABLE esquema."DEPARTAMENTOS" (
    "DEP" integer NOT NULL,
    "DEPARTAMENTO" character(100)
);

ALTER TABLE esquema."DEPARTAMENTOS" OWNER TO postgres;

CREATE TABLE esquema."PEDIDOS" (
    "ID" integer NOT NULL,
    "PRODUCTO" character(100),
    "CANTIDAD" integer,
    "IMPORTE" integer,
    "FECHA" timestamp with time zone
);

ALTER TABLE esquema."PEDIDOS" OWNER TO postgres;

COMMENT ON TABLE esquema."PEDIDOS" IS 'Esta es la tabla de PEDIDOS';

CREATE TABLE esquema."PERSONAS" (
    "PER" integer NOT NULL,
    "NOMBRE" character(100),
    "APELLIDO1" character(100),
    "APELLIDO2" character(100),
    "DNI" character(20),
    "EDAD" integer,
    "DEP" integer
);


ALTER TABLE esquema."PERSONAS" OWNER TO postgres;

CREATE TABLE esquema."PRODUCTOS" (
    "ID" integer NOT NULL,
    "PRODUCTO" character(100),
    "PRECIO" integer,
    "DESCRIPCION" character(100)
);


ALTER TABLE esquema."PRODUCTOS" OWNER TO postgres;

COPY esquema."DEPARTAMENTOS" ("DEP", "DEPARTAMENTO") FROM stdin;
COPY esquema."DEPARTAMENTOS" ("DEP", "DEPARTAMENTO") FROM '$$PATH$$/3150.dat';


COPY esquema."PEDIDOS" ("ID", "PRODUCTO", "CANTIDAD", "IMPORTE", "FECHA") FROM stdin;
COPY esquema."PEDIDOS" ("ID", "PRODUCTO", "CANTIDAD", "IMPORTE", "FECHA") FROM './3149.dat';

--







