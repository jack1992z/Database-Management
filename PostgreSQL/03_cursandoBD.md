-- PostgreSQL database dump
-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

create database dbname;

createdb -h localhost -p 5432 -U postgres runoobdb

\l   -- show database
\l runnobdb
psql -h localhost -p 5432 -U postgres runoobdb

drop database [if exists] name
dropdb -h localhost -p 5432 -U postgres runoobdb






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

DROP DATABASE curso;
CREATE DATABASE curso WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';

ALTER DATABASE curso OWNER TO postgres;


connect curso;

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

-- Name: esquema; Type: SCHEMA; Schema: -; Owner: postgres
CREATE SCHEMA esquema;

ALTER SCHEMA esquema OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

-- Name: DEPARTAMENTOS; Type: TABLE; Schema: esquema; Owner: postgres
--

CREATE TABLE esquema."DEPARTAMENTOS" (
    "DEP" integer NOT NULL,
    "DEPARTAMENTO" character(100)
);
ALTER TABLE esquema."DEPARTAMENTOS" OWNER TO postgres;

-- Name: PEDIDOS; Type: TABLE; Schema: esquema; Owner: postgres

CREATE TABLE esquema."PEDIDOS" (
    "ID" integer NOT NULL,
    "PRODUCTO" character(100),
    "CANTIDAD" integer,
    "IMPORTE" integer,
    "FECHA" timestamp with time zone
);

ALTER TABLE esquema."PEDIDOS" OWNER TO postgres;
COMMENT ON TABLE esquema."PEDIDOS" IS 'Esta es la tabla de PEDIDOS';

-- Name: PERSONAS; Type: TABLE; Schema: esquema; Owner: postgres
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

-- Name: PRODUCTOS; Type: TABLE; Schema: esquema; Owner: postgres

CREATE TABLE esquema."PRODUCTOS" (
    "ID" integer NOT NULL,
    "PRODUCTO" character(100),
    "PRECIO" integer,
    "DESCRIPCION" character(100)
);


ALTER TABLE esquema."PRODUCTOS" OWNER TO postgres;

COPY esquema."DEPARTAMENTOS" ("DEP", "DEPARTAMENTO") FROM stdin;
\.
COPY esquema."DEPARTAMENTOS" ("DEP", "DEPARTAMENTO") FROM '$$PATH$$/3150.dat';


COPY esquema."PEDIDOS" ("ID", "PRODUCTO", "CANTIDAD", "IMPORTE", "FECHA") FROM stdin;
\.
COPY esquema."PEDIDOS" ("ID", "PRODUCTO", "CANTIDAD", "IMPORTE", "FECHA") FROM '$$PATH$$/3149.dat';

--
-- Data for Name: PERSONAS; Type: TABLE DATA; Schema: esquema; Owner: postgres
--

COPY esquema."PERSONAS" ("PER", "NOMBRE", "APELLIDO1", "APELLIDO2", "DNI", "EDAD", "DEP") FROM stdin;
\.
COPY esquema."PERSONAS" ("PER", "NOMBRE", "APELLIDO1", "APELLIDO2", "DNI", "EDAD", "DEP") FROM '$$PATH$$/3151.dat';


COPY esquema."PRODUCTOS" ("ID", "PRODUCTO", "PRECIO", "DESCRIPCION") FROM stdin;
\.
COPY esquema."PRODUCTOS" ("ID", "PRODUCTO", "PRECIO", "DESCRIPCION") FROM '$$PATH$$/3152.dat';

--
-- Name: DEPARTAMENTOS DEPARTAMENTOS_pkey; Type: CONSTRAINT; Schema: esquema; Owner: postgres
--

ALTER TABLE ONLY esquema."DEPARTAMENTOS"
    ADD CONSTRAINT "DEPARTAMENTOS_pkey" PRIMARY KEY ("DEP");


--
-- Name: PEDIDOS PEDIDOS_pkey; Type: CONSTRAINT; Schema: esquema; Owner: postgres
--

ALTER TABLE ONLY esquema."PEDIDOS"
    ADD CONSTRAINT "PEDIDOS_pkey" PRIMARY KEY ("ID");


--
-- Name: PERSONAS PERSONAS_pkey; Type: CONSTRAINT; Schema: esquema; Owner: postgres
--

ALTER TABLE ONLY esquema."PERSONAS"
    ADD CONSTRAINT "PERSONAS_pkey" PRIMARY KEY ("PER");


--
-- Name: PRODUCTOS PRODUCTOS_pkey; Type: CONSTRAINT; Schema: esquema; Owner: postgres
--

ALTER TABLE ONLY esquema."PRODUCTOS"
    ADD CONSTRAINT "PRODUCTOS_pkey" PRIMARY KEY ("ID");


--
-- PostgreSQL database dump complete
--

