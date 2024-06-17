--
-- PostgreSQL database cluster dump
--

-- Started on 2023-01-02 13:01:25

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE "db-rental";
ALTER ROLE "db-rental" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:67CJRR6+lf9p8eRJoqNxiQ==$KKZcqkMaUxjEEda9b2Ca5L8MlNoKTrcw+DvFQBOWucE=:W8K5CDESxLKGD4xArpg76GS8CLTJQZMt/JEA7shNzfw=';
COMMENT ON ROLE "db-rental" IS 'Account for application';
CREATE ROLE "my-app";
ALTER ROLE "my-app" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "my-script";
ALTER ROLE "my-script" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:HCXtqPuQxABm++ejp5WNDQ==$vWhTwI6nL8aEyN7k3OCntXhXy2PxX5iEEQ7zcjNv2E8=:/oN2fTM8gIP72QjB6A21XLXoJNXFr6p9vU8ZXzDcSmM=';

--
-- User Configurations
--


--
-- Role memberships
--

GRANT pg_read_all_data TO "db-rental" GRANTED BY postgres;
GRANT pg_write_all_data TO "db-rental" GRANTED BY postgres;






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.0

-- Started on 2023-01-02 13:01:25

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

-- Completed on 2023-01-02 13:01:26

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.0

-- Started on 2023-01-02 13:01:26

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

--
-- TOC entry 8 (class 2615 OID 19632)
-- Name: mydb; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA mydb;


ALTER SCHEMA mydb OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 4 (class 3079 OID 20069)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA mydb;


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 3 (class 3079 OID 19884)
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA mydb;


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- TOC entry 273 (class 1255 OID 19951)
-- Name: attention_notice(); Type: FUNCTION; Schema: mydb; Owner: postgres
--

CREATE FUNCTION mydb.attention_notice() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
RAISE NOTICE 'USER INSERTED SUCCESFULLY';
RETURN NEW;
END;
$$;


ALTER FUNCTION mydb.attention_notice() OWNER TO postgres;

--
-- TOC entry 271 (class 1255 OID 19975)
-- Name: insert_data_staff(character varying, character varying, character varying); Type: PROCEDURE; Schema: mydb; Owner: postgres
--

CREATE PROCEDURE mydb.insert_data_staff(IN first_name character varying, IN last_name character varying, IN email character varying)
    LANGUAGE sql
    AS $$
	INSERT INTO mydb.staff(first_name,last_name,email) VALUES ('Tomas','Lacko','SmartGranadir@gmail.com')
	$$;


ALTER PROCEDURE mydb.insert_data_staff(IN first_name character varying, IN last_name character varying, IN email character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 19672)
-- Name: address; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.address (
    address_id integer NOT NULL,
    street_id integer NOT NULL,
    customer_id integer NOT NULL
);


ALTER TABLE mydb.address OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 19671)
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.address_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.address_address_id_seq OWNER TO postgres;

--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 223
-- Name: address_address_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.address_address_id_seq OWNED BY mydb.address.address_id;


--
-- TOC entry 226 (class 1259 OID 19689)
-- Name: brand_of_vehicle; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.brand_of_vehicle (
    brand_id integer NOT NULL,
    brand_name character varying(20) NOT NULL
);


ALTER TABLE mydb.brand_of_vehicle OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 19688)
-- Name: brand_of_vehicle_brand_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.brand_of_vehicle_brand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.brand_of_vehicle_brand_id_seq OWNER TO postgres;

--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 225
-- Name: brand_of_vehicle_brand_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.brand_of_vehicle_brand_id_seq OWNED BY mydb.brand_of_vehicle.brand_id;


--
-- TOC entry 235 (class 1259 OID 19754)
-- Name: car; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.car (
    rental_id integer NOT NULL,
    rented_car_id character varying(17) NOT NULL,
    car_id integer NOT NULL
);


ALTER TABLE mydb.car OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 19753)
-- Name: car_car_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.car_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.car_car_id_seq OWNER TO postgres;

--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 234
-- Name: car_car_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.car_car_id_seq OWNED BY mydb.car.car_id;


--
-- TOC entry 228 (class 1259 OID 19696)
-- Name: rental; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.rental (
    rental_id integer NOT NULL,
    rental_date date NOT NULL,
    return_date date NOT NULL,
    rented_car_id character varying(17),
    customer_id integer NOT NULL,
    payment_id integer,
    last_update timestamp without time zone
);


ALTER TABLE mydb.rental OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 19728)
-- Name: rented_car; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.rented_car (
    rented_car_id_vin_number_ character varying(17) NOT NULL,
    brand_name_id integer NOT NULL,
    vehicle_type_id integer NOT NULL,
    fuel_type_id integer NOT NULL,
    color_id integer NOT NULL,
    availability boolean
);


ALTER TABLE mydb.rented_car OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 21190)
-- Name: car_date_view; Type: VIEW; Schema: mydb; Owner: postgres
--

CREATE VIEW mydb.car_date_view AS
 SELECT rental.rental_date,
    rental.return_date,
    rented_car.rented_car_id_vin_number_
   FROM ((mydb.car
     RIGHT JOIN mydb.rented_car ON (((rented_car.rented_car_id_vin_number_)::text = (car.rented_car_id)::text)))
     RIGHT JOIN mydb.rental ON ((rental.rental_id = car.rental_id)));


ALTER TABLE mydb.car_date_view OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 19648)
-- Name: city; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.city (
    city_id integer NOT NULL,
    city character varying(32) NOT NULL,
    post_code character varying(5) NOT NULL,
    country_id integer NOT NULL
);


ALTER TABLE mydb.city OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 19647)
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.city_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.city_city_id_seq OWNER TO postgres;

--
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 221
-- Name: city_city_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.city_city_id_seq OWNED BY mydb.city.city_id;


--
-- TOC entry 249 (class 1259 OID 19851)
-- Name: color_of_vehicle; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.color_of_vehicle (
    color_id integer NOT NULL,
    color character varying(20) NOT NULL
);


ALTER TABLE mydb.color_of_vehicle OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 19850)
-- Name: color_of_vehicle_color_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.color_of_vehicle_color_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.color_of_vehicle_color_id_seq OWNER TO postgres;

--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 248
-- Name: color_of_vehicle_color_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.color_of_vehicle_color_id_seq OWNED BY mydb.color_of_vehicle.color_id;


--
-- TOC entry 220 (class 1259 OID 19641)
-- Name: country; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.country (
    country_id integer NOT NULL,
    country character varying(32) NOT NULL
);


ALTER TABLE mydb.country OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 19640)
-- Name: country_country_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.country_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.country_country_id_seq OWNER TO postgres;

--
-- TOC entry 3592 (class 0 OID 0)
-- Dependencies: 219
-- Name: country_country_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.country_country_id_seq OWNED BY mydb.country.country_id;


--
-- TOC entry 218 (class 1259 OID 19634)
-- Name: customer; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.customer (
    customer_id integer NOT NULL,
    first_name character varying(16) NOT NULL,
    last_name character varying(16) NOT NULL,
    active boolean,
    create_date date NOT NULL,
    username character varying(16) NOT NULL,
    password character varying(16) NOT NULL,
    hashedpassword character varying(255)
);


ALTER TABLE mydb.customer OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 19771)
-- Name: customer_contact; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.customer_contact (
    customer_contact_id integer NOT NULL,
    customer_id integer NOT NULL,
    phone character varying(13) NOT NULL,
    email character varying(32) NOT NULL
);


ALTER TABLE mydb.customer_contact OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 19770)
-- Name: customer_contact_customer_contact_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.customer_contact_customer_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.customer_contact_customer_contact_id_seq OWNER TO postgres;

--
-- TOC entry 3595 (class 0 OID 0)
-- Dependencies: 236
-- Name: customer_contact_customer_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.customer_contact_customer_contact_id_seq OWNED BY mydb.customer_contact.customer_contact_id;


--
-- TOC entry 217 (class 1259 OID 19633)
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.customer_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.customer_customer_id_seq OWNER TO postgres;

--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 217
-- Name: customer_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.customer_customer_id_seq OWNED BY mydb.customer.customer_id;


--
-- TOC entry 239 (class 1259 OID 19783)
-- Name: payment; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.payment (
    payment_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date date NOT NULL
);


ALTER TABLE mydb.payment OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 21185)
-- Name: customer_info_view; Type: VIEW; Schema: mydb; Owner: postgres
--

CREATE VIEW mydb.customer_info_view AS
 SELECT customer.first_name,
    customer.last_name,
    payment.amount,
    rental.rental_id,
    customer_contact.phone,
    customer_contact.email
   FROM (((mydb.customer
     JOIN mydb.rental ON ((rental.customer_id = customer.customer_id)))
     LEFT JOIN mydb.payment ON ((payment.rental_id = rental.rental_id)))
     JOIN mydb.customer_contact ON ((customer_contact.customer_id = customer.customer_id)))
  GROUP BY rental.rental_id, customer.first_name, customer.last_name, customer_contact.phone, customer_contact.email, payment.amount;


ALTER TABLE mydb.customer_info_view OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 19987)
-- Name: customer_materialized_view; Type: MATERIALIZED VIEW; Schema: mydb; Owner: postgres
--

CREATE MATERIALIZED VIEW mydb.customer_materialized_view AS
 SELECT customer.first_name,
    rental.rental_id,
    payment.amount,
    count(customer.customer_id) AS count
   FROM ((mydb.customer
     JOIN mydb.rental ON ((rental.customer_id = customer.customer_id)))
     LEFT JOIN mydb.payment ON ((payment.rental_id = rental.rental_id)))
  GROUP BY customer.first_name, rental.rental_id, payment.amount
 HAVING (payment.amount > (440)::numeric)
  ORDER BY payment.amount DESC
  WITH NO DATA;


ALTER TABLE mydb.customer_materialized_view OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 21198)
-- Name: dummy_customer; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.dummy_customer (
    name character varying(32) NOT NULL,
    surname character varying(32) NOT NULL,
    email character varying(32) NOT NULL,
    phone character varying(10),
    age integer,
    id integer NOT NULL
);


ALTER TABLE mydb.dummy_customer OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 21203)
-- Name: dummy_customer_Id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb."dummy_customer_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb."dummy_customer_Id_seq" OWNER TO postgres;

--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 256
-- Name: dummy_customer_Id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb."dummy_customer_Id_seq" OWNED BY mydb.dummy_customer.id;


--
-- TOC entry 251 (class 1259 OID 19969)
-- Name: expired_car; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.expired_car (
    expired_car_id integer NOT NULL,
    car_first_name character varying(32),
    car_serial_number character varying(17)
);


ALTER TABLE mydb.expired_car OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 19968)
-- Name: expired_car_expired_car_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.expired_car_expired_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.expired_car_expired_car_id_seq OWNER TO postgres;

--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 250
-- Name: expired_car_expired_car_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.expired_car_expired_car_id_seq OWNED BY mydb.expired_car.expired_car_id;


--
-- TOC entry 230 (class 1259 OID 19715)
-- Name: fuel_type; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.fuel_type (
    fuel_type_id integer NOT NULL,
    fuel_type character varying(20) NOT NULL
);


ALTER TABLE mydb.fuel_type OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 19714)
-- Name: fuel_type_fuel_type_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.fuel_type_fuel_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.fuel_type_fuel_type_id_seq OWNER TO postgres;

--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 229
-- Name: fuel_type_fuel_type_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.fuel_type_fuel_type_id_seq OWNED BY mydb.fuel_type.fuel_type_id;


--
-- TOC entry 238 (class 1259 OID 19782)
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.payment_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.payment_payment_id_seq OWNER TO postgres;

--
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 238
-- Name: payment_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.payment_payment_id_seq OWNED BY mydb.payment.payment_id;


--
-- TOC entry 227 (class 1259 OID 19695)
-- Name: rental_rental_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.rental_rental_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.rental_rental_id_seq OWNER TO postgres;

--
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 227
-- Name: rental_rental_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.rental_rental_id_seq OWNED BY mydb.rental.rental_id;


--
-- TOC entry 241 (class 1259 OID 19795)
-- Name: staff; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.staff (
    staff_id integer NOT NULL,
    first_name character varying(16) NOT NULL,
    last_name character varying(16) NOT NULL,
    email character varying(32) NOT NULL,
    rental_shop_id integer NOT NULL
);


ALTER TABLE mydb.staff OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 19794)
-- Name: staff_staff_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.staff_staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.staff_staff_id_seq OWNER TO postgres;

--
-- TOC entry 3604 (class 0 OID 0)
-- Dependencies: 240
-- Name: staff_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.staff_staff_id_seq OWNED BY mydb.staff.staff_id;


--
-- TOC entry 245 (class 1259 OID 19809)
-- Name: staff_store; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.staff_store (
    rental_shop_id integer NOT NULL,
    staff_id integer NOT NULL,
    store_id integer NOT NULL,
    rental_id integer
);


ALTER TABLE mydb.staff_store OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 19808)
-- Name: staff_store_rental_shop_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.staff_store_rental_shop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.staff_store_rental_shop_id_seq OWNER TO postgres;

--
-- TOC entry 3605 (class 0 OID 0)
-- Dependencies: 244
-- Name: staff_store_rental_shop_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.staff_store_rental_shop_id_seq OWNED BY mydb.staff_store.rental_shop_id;


--
-- TOC entry 243 (class 1259 OID 19802)
-- Name: store; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.store (
    store_id integer NOT NULL,
    name_of_the_shop character varying(32) NOT NULL
);


ALTER TABLE mydb.store OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 19801)
-- Name: store_store_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.store_store_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.store_store_id_seq OWNER TO postgres;

--
-- TOC entry 3606 (class 0 OID 0)
-- Dependencies: 242
-- Name: store_store_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.store_store_id_seq OWNED BY mydb.store.store_id;


--
-- TOC entry 247 (class 1259 OID 19831)
-- Name: street; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.street (
    street_id integer NOT NULL,
    street character varying(32) NOT NULL,
    house_number character varying(8) NOT NULL,
    city_id integer NOT NULL
);


ALTER TABLE mydb.street OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 19830)
-- Name: street_street_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.street_street_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.street_street_id_seq OWNER TO postgres;

--
-- TOC entry 3607 (class 0 OID 0)
-- Dependencies: 246
-- Name: street_street_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.street_street_id_seq OWNED BY mydb.street.street_id;


--
-- TOC entry 232 (class 1259 OID 19722)
-- Name: type_of_vehicle; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.type_of_vehicle (
    vehicle_type_id integer NOT NULL,
    vehicle_type character varying(20) NOT NULL
);


ALTER TABLE mydb.type_of_vehicle OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 19721)
-- Name: type_of_vehicle_vehicle_type_id_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.type_of_vehicle_vehicle_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mydb.type_of_vehicle_vehicle_type_id_seq OWNER TO postgres;

--
-- TOC entry 3608 (class 0 OID 0)
-- Dependencies: 231
-- Name: type_of_vehicle_vehicle_type_id_seq; Type: SEQUENCE OWNED BY; Schema: mydb; Owner: postgres
--

ALTER SEQUENCE mydb.type_of_vehicle_vehicle_type_id_seq OWNED BY mydb.type_of_vehicle.vehicle_type_id;


--
-- TOC entry 3324 (class 2604 OID 19675)
-- Name: address address_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.address ALTER COLUMN address_id SET DEFAULT nextval('mydb.address_address_id_seq'::regclass);


--
-- TOC entry 3325 (class 2604 OID 19692)
-- Name: brand_of_vehicle brand_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.brand_of_vehicle ALTER COLUMN brand_id SET DEFAULT nextval('mydb.brand_of_vehicle_brand_id_seq'::regclass);


--
-- TOC entry 3329 (class 2604 OID 19757)
-- Name: car car_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.car ALTER COLUMN car_id SET DEFAULT nextval('mydb.car_car_id_seq'::regclass);


--
-- TOC entry 3323 (class 2604 OID 19651)
-- Name: city city_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.city ALTER COLUMN city_id SET DEFAULT nextval('mydb.city_city_id_seq'::regclass);


--
-- TOC entry 3336 (class 2604 OID 19854)
-- Name: color_of_vehicle color_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.color_of_vehicle ALTER COLUMN color_id SET DEFAULT nextval('mydb.color_of_vehicle_color_id_seq'::regclass);


--
-- TOC entry 3322 (class 2604 OID 19644)
-- Name: country country_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.country ALTER COLUMN country_id SET DEFAULT nextval('mydb.country_country_id_seq'::regclass);


--
-- TOC entry 3321 (class 2604 OID 19637)
-- Name: customer customer_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.customer ALTER COLUMN customer_id SET DEFAULT nextval('mydb.customer_customer_id_seq'::regclass);


--
-- TOC entry 3330 (class 2604 OID 19774)
-- Name: customer_contact customer_contact_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.customer_contact ALTER COLUMN customer_contact_id SET DEFAULT nextval('mydb.customer_contact_customer_contact_id_seq'::regclass);


--
-- TOC entry 3338 (class 2604 OID 21204)
-- Name: dummy_customer id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.dummy_customer ALTER COLUMN id SET DEFAULT nextval('mydb."dummy_customer_Id_seq"'::regclass);


--
-- TOC entry 3337 (class 2604 OID 19972)
-- Name: expired_car expired_car_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.expired_car ALTER COLUMN expired_car_id SET DEFAULT nextval('mydb.expired_car_expired_car_id_seq'::regclass);


--
-- TOC entry 3327 (class 2604 OID 19718)
-- Name: fuel_type fuel_type_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.fuel_type ALTER COLUMN fuel_type_id SET DEFAULT nextval('mydb.fuel_type_fuel_type_id_seq'::regclass);


--
-- TOC entry 3331 (class 2604 OID 19786)
-- Name: payment payment_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.payment ALTER COLUMN payment_id SET DEFAULT nextval('mydb.payment_payment_id_seq'::regclass);


--
-- TOC entry 3326 (class 2604 OID 19699)
-- Name: rental rental_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.rental ALTER COLUMN rental_id SET DEFAULT nextval('mydb.rental_rental_id_seq'::regclass);


--
-- TOC entry 3332 (class 2604 OID 19798)
-- Name: staff staff_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.staff ALTER COLUMN staff_id SET DEFAULT nextval('mydb.staff_staff_id_seq'::regclass);


--
-- TOC entry 3334 (class 2604 OID 19812)
-- Name: staff_store rental_shop_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.staff_store ALTER COLUMN rental_shop_id SET DEFAULT nextval('mydb.staff_store_rental_shop_id_seq'::regclass);


--
-- TOC entry 3333 (class 2604 OID 19805)
-- Name: store store_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.store ALTER COLUMN store_id SET DEFAULT nextval('mydb.store_store_id_seq'::regclass);


--
-- TOC entry 3335 (class 2604 OID 19834)
-- Name: street street_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.street ALTER COLUMN street_id SET DEFAULT nextval('mydb.street_street_id_seq'::regclass);


--
-- TOC entry 3328 (class 2604 OID 19725)
-- Name: type_of_vehicle vehicle_type_id; Type: DEFAULT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.type_of_vehicle ALTER COLUMN vehicle_type_id SET DEFAULT nextval('mydb.type_of_vehicle_vehicle_type_id_seq'::regclass);


--
-- TOC entry 3544 (class 0 OID 19672)
-- Dependencies: 224
-- Data for Name: address; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.address (address_id, street_id, customer_id) FROM stdin;
1	2	3
2	4	1
3	4	5
4	4	3
5	3	4
\.


--
-- TOC entry 3546 (class 0 OID 19689)
-- Dependencies: 226
-- Data for Name: brand_of_vehicle; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.brand_of_vehicle (brand_id, brand_name) FROM stdin;
1	FIAT
2	SKODA
3	MAZDA
4	DACIA
5	TOYOTA
\.


--
-- TOC entry 3555 (class 0 OID 19754)
-- Dependencies: 235
-- Data for Name: car; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.car (rental_id, rented_car_id, car_id) FROM stdin;
1	2C3CCAGG7FH059102	1
2	WAUUL98E37A497737	2
3	1G4CU541214484969	3
4	1G6DH577890867382	4
5	WBAPL5C57BA817891	5
\.


--
-- TOC entry 3542 (class 0 OID 19648)
-- Dependencies: 222
-- Data for Name: city; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.city (city_id, city, post_code, country_id) FROM stdin;
1	San Isidro de Lules	4174	1
2	Santo Tomas	8112	2
3	Oli	92013	2
4	Mrongi Daja	92601	4
5	Aydūn	12305	5
\.


--
-- TOC entry 3569 (class 0 OID 19851)
-- Dependencies: 249
-- Data for Name: color_of_vehicle; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.color_of_vehicle (color_id, color) FROM stdin;
1	Mauv
2	Crimson
3	Puce
4	Blue
5	Pink
\.


--
-- TOC entry 3540 (class 0 OID 19641)
-- Dependencies: 220
-- Data for Name: country; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.country (country_id, country) FROM stdin;
1	Brazil
2	Portugal
3	Ireland
4	France
5	Slovakia
\.


--
-- TOC entry 3538 (class 0 OID 19634)
-- Dependencies: 218
-- Data for Name: customer; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.customer (customer_id, first_name, last_name, active, create_date, username, password, hashedpassword) FROM stdin;
12	Brannon	Foux	f	2022-03-26	bfouxb	R1xVLs7R2	$argon2i$v=19$m=4096,t=10,p=1$ZTFoZm51NjMxbnEwMDAwMA$adcsPOmd+looPWOTPpnmId0mE4iv/CAPOkABnqCW/ls
13	Dulci	Mirams	f	2022-02-08	dmiramsc	BCmdQnfT6	$argon2i$v=19$m=4096,t=10,p=1$Zncwc2hybzdyaHYwMDAwMA$Ni5XpEyzvmM2SOcaUc6zZoBQKCzEDgQ5e1S3SISsGRw
14	Johanna	Rolfo	f	2022-08-24	jrolfod	wS25XQ8	$argon2i$v=19$m=4096,t=10,p=1$YnU5a3Fud2Q4aHUwMDAwMA$xj6hKkNq9EepsOKPybu05MRoxLdHJaC+Ccdj1fNEBbo
15	Windy	Bonsul	f	2022-05-20	wbonsule	YArhlSU	$argon2i$v=19$m=4096,t=10,p=1$Ync5Zncya2txMjcwMDAwMA$zQkCTU3OaI+s0Bw2QNGaRi4q2q6OShtuNey9lyKuvLs
52	Jozo	Test	f	2022-08-24	j	t	$argon2i$v=19$m=65536,t=10,p=1$VUE2kDM+8+2FDkErNVyeZg$V2n9a68+a41ncHyH1fzttE6Fphq7pjXHQ47qLmQBq0U
51	Tomas	Mrkva	f	2022-11-12	Bambus	test123	$argon2i$v=19$m=16,t=10,p=1$cFJ3dWZ6c2xHMkpqd2NOTQ$nGgmnTw5/f9uwdENRnFhAbANbLccXQqT61eunuykcAs
1	Seagan	Antonat	f	2022-07-21	hantonat0	edOOmW9GM	$argon2i$v=19$m=4096,t=10,p=1$bjZtcXdsaGNtN3MwMDAwMA$N8F9HZ3P5iOLevO2/3mbs+5iuYI5XDg+0qzGzfXEw20
2	Emmetá	Urvoá	f	2022-10-20	eurvoy1	s4sMd5	$argon2i$v=19$m=4096,t=10,p=1$cnhjbjRrMmwxMTcwMDAwMA$jLnEp3eqai6yYkwEaGv2Z5vOYdyt6g0HXW7YcfxwD+c
3	Winnie	Durrans	f	2022-01-31	wdurrans2	X1BHnyQKf	$argon2i$v=19$m=4096,t=10,p=1$bjZtcHJibHp2ejAwMDAwMA$vh04LD3mvim70YOGO4coaHEmfsWrml5gZIjk47DgJKU
4	Mariel	Jakoubek	f	2022-01-09	mjakoubek3	AJFj6pAcuFd8	$argon2i$v=19$m=4096,t=10,p=1$bjV2eG82czNmcmswMDAwMA$NMsQ9DgwK6qOKq2c9vheTjiFvzBBEu6mwYEPBEEk3AY
5	Marillin	Goodliffe	t	2022-05-26	mgoodliffe4	ccjD2MoCBk	$argon2i$v=19$m=4096,t=10,p=1$ZTdzOWtpeXhjc3YwMDAwMA$MKoAR17HfB1zklGFYxJ35jHFDv2vSGOOpMOo+TQBYEc
6	Gradey	Kobu	f	2021-12-04	gkobu5	CjulFokI0C	$argon2i$v=19$m=4096,t=10,p=1$ZzJhOWE5Yjl0eXEwMDAwMA$vME64X1Tv7IZycwBBDbaPFeear+1cansPVEL2TvVOXQ
7	Rice	Myles	f	2022-03-28	rmyles6	5HaEF9	$argon2i$v=19$m=4096,t=10,p=1$cXlocndqd3p3eGYwMDAwMA$SF8A34iIxgkWx5JYrXglgtyQaVNl15mzqg/E+Js11xs
8	Lorenzo	Hanster	t	2021-12-11	lhanster7	zM4NcGAVe	$argon2i$v=19$m=4096,t=10,p=1$ZXc4a2s5aGloZWYwMDAwMA$lcAcbVkUt2zo/2yoz7b4Ky0bTfIlhC8WbOqQYTKjrHg
9	Ame	Botfield	t	2022-05-11	abotfield8	Gp1pWp	$argon2i$v=19$m=4096,t=10,p=1$ZnpjY2JxcmVrbWswMDAwMA$yke3k434YudGIOr25ldXUwHt2lNR5n14yxFVtgD962o
10	Ethe	Radenhurst	t	2021-12-06	eradenhurst9	VzaAIKtpiy	$argon2i$v=19$m=4096,t=10,p=1$Y3VsMnRyaXdnbzAwMDAwMA$B620tsqDI4xx4W8d54ZmE7hu574r+Q/anx1otfr8JMQ
11	Aubine	Kedward	f	2022-10-02	akedwarda	MZIXrggVhs	$argon2i$v=19$m=4096,t=10,p=1$dGNtYnZ5M2Y4bDkwMDAwMA$RrXvinkqY+8TcWEZ0+4oA2VIw74Eo5JJvBjYO4kzMus
16	Seamus	Westover	f	2022-06-24	swestoverf	U45l34	$argon2i$v=19$m=4096,t=10,p=1$bGZueTMxN3RxZzAwMDAwMA$Twj0rNN8OqBTmMBy0LLflnhVEitVoXi1jQu625hIK4M
17	Valina	Cluderay	t	2022-04-01	vcluderayg	wk1L1PYqO	$argon2i$v=19$m=4096,t=10,p=1$NXF0c3drNHNjOHAwMDAwMA$vebggdey+aIhS52FKBLjt4FM1tVOS0l6tGRL/oiUpsM
18	Nadean	Tremollet	t	2022-06-04	ntremolleth	jHX0jC	$argon2i$v=19$m=4096,t=10,p=1$dTVpZnN5ZzJveHAwMDAwMA$An6m2GzGGhBKQhfFcORVxrNoH0zgOD0rYDNfTcv7MD8
19	Ivar	Jovanovic	t	2022-11-02	ijovanovici	K5ZWHmG	$argon2i$v=19$m=4096,t=10,p=1$a256b2xpamR5YW0wMDAwMA$GaKN6aMumSlp7MbX4kaVgB6AqcWaw8HsfqXPOfD8NnU
20	Joscelin	Harlowe	t	2022-09-28	jharlowej	8Xf05Qa	$argon2i$v=19$m=4096,t=10,p=1$b21mNjNhYWZ6MzAwMDAwMA$mNDN5mlHG0mcxpTMUUvO23osFhffghWIhrCOhhMyN5g
21	Gregoire	Brampton	t	2022-04-01	gbramptonk	pCUfhB4ioZF	$argon2i$v=19$m=4096,t=10,p=1$YWpqZGgzYWs1NjAwMDAwMA$PGJMpjs9zoD2tH/0JydwGXFPcPtaszc5XDNgVLuw4YM
22	Bert	Pautard	t	2022-10-14	bpautardl	rEtelTXWC	$argon2i$v=19$m=4096,t=10,p=1$M2UxZ2R6YzAxNGEwMDAwMA$BYl4TMYCX+jllMeolqrouNvEHmMYvaMNUXc1QcmF6uI
23	Derry	Hoggin	t	2022-01-31	dhogginm	6qWXMS	$argon2i$v=19$m=4096,t=10,p=1$bG4yM2ozNTY0emQwMDAwMA$nO02VCfeCevrZhTMxDk9X61mTzirYpjEWBp0Zn62vnI
24	Hobey	O'Sheeryne	t	2022-08-03	hosheerynen	Leu8pXv	$argon2i$v=19$m=4096,t=10,p=1$cWprZG1qNWNwYW0wMDAwMA$58fRiROQ+6OfJ7/UOkolJ2VDaW3VzXgz7MW57JBRSdo
25	Heath	Roadknight	t	2022-08-16	hroadknighto	fB37xp	$argon2i$v=19$m=4096,t=10,p=1$cm9yMHI2aDUxMHEwMDAwMA$NgDuFCR4+SUq/5SwLaCY9R/nMdaEaCn3HPuLdrcyt3U
26	Anselm	Van de Vlies	t	2022-06-12	avandevliesp	kPE4TLSEGFV	$argon2i$v=19$m=4096,t=10,p=1$eDE5bzNvbmlkMWIwMDAwMA$hIuYMp5LYOJi8kkFb8qycPUpyH1HuqVs9OQ43F3Z6wc
27	Jarret	Balle	f	2022-05-28	jballeq	DvuXmSmYWKl	$argon2i$v=19$m=4096,t=10,p=1$cnhvem10MGQwdTAwMDAwMA$qmTcio7GZvuX1ULFvVgj1C1LKrFC3kxFBnbFThMHPIw
28	Billie	Piolli	f	2022-09-07	bpiollir	JK9pMpC1O	$argon2i$v=19$m=4096,t=10,p=1$MTI1Y2VhY2V0aHgwMDAwMA$kb0QugWKFDa5J2VSnS6COVDc4LriJ+kWhe7uNaTzH88
29	Abby	Cossum	t	2022-05-17	acossums	qtrk1hghPW	$argon2i$v=19$m=4096,t=10,p=1$aHB3a3pyZGRtbTgwMDAwMA$5rQ5uXePlcVoyRTR2evTDQCdRQneYXjfO6wspiM/nfA
30	Bradan	Owlner	t	2022-09-27	bowlnert	QFyhp7	$argon2i$v=19$m=4096,t=10,p=1$ejgwbjc4YjFpaTAwMDAwMA$s1RkCkI7r62ePpZnd5fqENDJ5AhH/jh5kUyNTl+Bd6M
31	Giulietta	Hancke	t	2022-04-03	ghanckeu	TzU3BvyXig	$argon2i$v=19$m=4096,t=10,p=1$anE1NWZ4dGM2NzAwMDAwMA$I+Ze44806KuLwb0Fa9QFpMPfy1bLvTV29l71J6YP/Vk
32	Aeriela	Basili	t	2021-11-19	abasiliv	gDjcool7MLz	$argon2i$v=19$m=4096,t=10,p=1$ZXEyeDIzb3QydDgwMDAwMA$rtq3UXCl4j91UUIt4mDPH6qNCLNdJft6W4bKqILT00Q
33	Betty	Musico	t	2021-12-04	bmusicow	6ZDDn2XEVW	$argon2i$v=19$m=4096,t=10,p=1$YTBmazZqdTNta2EwMDAwMA$sfpMHTV39z2isyZwjwus5d9eP46H16aQwnU+o0PI5z4
34	Doro	Corhard	f	2021-11-21	dcorhardx	HePyfpAEGz	$argon2i$v=19$m=4096,t=10,p=1$OHk0dWFhYjhvdzIwMDAwMA$N1N8XX1+ZIrvbZo1Qbu1V7kJ9O31emGuJIXHClzrIWM
35	Crystie	Harman	f	2022-04-10	charmany	uaAjRCBx	$argon2i$v=19$m=4096,t=10,p=1$cGFqbWoxMDY3ZDAwMDAwMA$LTWhmjYZ8bydKRkM4WRmzJwrmPy0mx6k0EXiQZKE8J8
36	Catriona	Trouncer	t	2021-12-20	ctrouncerz	5ZEQfNGu	$argon2i$v=19$m=4096,t=10,p=1$ZWo2amo3NjZlc2YwMDAwMA$hwRm6Mu17gAvdoyxbAcRd4Pfr3mQUrmbo4HxeBobonE
37	Demetris	Bausor	f	2022-09-02	dbausor10	H8JbWcmr	$argon2i$v=19$m=4096,t=10,p=1$d2g0anpnZHdocDAwMDAwMA$UonqY9MvpojsaSrubyBognM85kuzssMYHgt/mKsbHYM
38	Tybalt	Godbolt	t	2022-04-06	tgodbolt11	TdMQ1znl	$argon2i$v=19$m=4096,t=10,p=1$b2owdXo4MXA2ZTAwMDAwMA$B70XO/UjNLn4BN4KwquhiZKajSvzXYQ27lTWAWVdVFI
39	Dari	Frangello	t	2022-10-30	dfrangello12	CRBwwAwgF	$argon2i$v=19$m=4096,t=10,p=1$b2lmZm5nYmdyczAwMDAwMA$1W85B4U55RBOQjTHheBFoOOXSjh2mkxWyGswqdivTyM
40	Teodor	Foyle	t	2022-05-11	tfoyle13	97ndzD1	$argon2i$v=19$m=4096,t=10,p=1$a3lraW95MG4wcmgwMDAwMA$H1RyFDQOhu34DJ14g/cGBInkp9aRhjvjHZ6Vs8guwiw
41	Alikee	Worwood	f	2021-11-18	aworwood14	CZoahqe7946T	$argon2i$v=19$m=4096,t=10,p=1$OHZpYTFid2NoMmQwMDAwMA$AAJ0uJDdh4vgDEb9maJdFT/nxqvVtUVj/D4RxHucIJY
42	Rouvin	Tidy	t	2022-02-06	rtidy15	PKeqcCSRzR9Y	$argon2i$v=19$m=4096,t=10,p=1$a2I0b2N4YXhhc20wMDAwMA$iZlC6syw7pLaz6OgKmqyfhbD0Qy7Ba008FvdVhrbB90
43	Roxy	Jerams	t	2022-04-23	rjerams16	Hjnnt04	$argon2i$v=19$m=4096,t=10,p=1$enBoaTNnbzM0NjAwMDAwMA$ZNBWY6WHYNEoBd8NKoK9JPDQtFpnjWxKbw1lYfH+TKU
44	Tani	Rewcastle	f	2022-08-02	trewcastle17	iv2zJZ	$argon2i$v=19$m=4096,t=10,p=1$NncxanVlbzRkb2gwMDAwMA$G7rAYz4vxjZD5R/C8EMfj31ptYDBZCouK8x3pd4UDJw
45	Jeth	Danton	f	2022-04-13	jdanton18	85KLl83	$argon2i$v=19$m=4096,t=10,p=1$Zm9nNXp4a3Fwd2swMDAwMA$h4EW4+Z0qX/4GSviRB8C70G4Z3Dva6hhy488rXe60iA
46	Francisco	Halliburton	t	2022-02-19	fhalliburton19	jujcqjZ1	$argon2i$v=19$m=4096,t=10,p=1$OTk4cXhuMXdzbDkwMDAwMA$efZd9lxah7wqfN2y6rhSvEQucpR5d3Sk3pbF89gxOuE
47	Elvira	Scarlon	f	2022-03-19	escarlon1a	XW76pQihi	$argon2i$v=19$m=4096,t=10,p=1$Z3VjdHNxY3UzZGkwMDAwMA$aEHGmIRT4vegIxwYZ1pMVZGWy/uSbOkp3ZPmPor4pgw
48	Catlin	Girton	t	2022-01-21	cgirton1b	LSgbj4UQG	$argon2i$v=19$m=4096,t=10,p=1$OHMzdjJpNm1yaGUwMDAwMA$zbzcn5hP6OT9mUPRC3lIY2QQ7su7OSXw3ynIyk6oQ44
49	Martin	Turle	f	2022-10-29	mturle1c	Lk8d0i	$argon2i$v=19$m=4096,t=10,p=1$eDZoOHozYjVnNGUwMDAwMA$nzUI+h3TSL6r9HRY4JYU7kO6GFIRF4B7uJPIzRiLwK8
50	Abrahan	Kevern	t	2022-09-20	akevern1d	60FXnFBIH	$argon2i$v=19$m=4096,t=10,p=1$dXV3bTNib2oxcDAwMDAwMA$lwpiLhf9gdlq4eZUiHXt/GVDbu+ImXcERqf8S86ob1E
\.


--
-- TOC entry 3557 (class 0 OID 19771)
-- Dependencies: 237
-- Data for Name: customer_contact; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.customer_contact (customer_contact_id, customer_id, phone, email) FROM stdin;
1	1	836-162-9987	sseago0@pinterest.com
2	2	968-567-1031	brodriguez1@ucoz.ru
3	3	595-777-3497	lmacdiarmond2@harvard.edu
4	4	467-512-8716	csiddeley3@ft.com
5	5	660-709-5195	askellen4@wordpress.com
6	6	690-599-0457	ccanedo5@about.me
7	7	446-894-6515	mbathurst6@howstuffworks.com
8	8	925-760-0150	gabbatini7@slate.com
9	9	278-617-7061	dkilmurray8@acquirethisname.com
10	10	281-514-8982	chamshere9@wired.com
11	11	632-989-3160	nhlaveceka@dropbox.com
12	12	713-809-3979	edibnerb@rambler.ru
13	13	121-802-1856	mghiroldic@techcrunch.com
14	14	755-410-3161	jpallasked@cargocollective.com
15	15	324-147-4260	jbrissendene@walmart.com
16	16	113-872-1171	seagersf@smugmug.com
17	17	772-170-0377	foneleg@squidoo.com
18	18	446-256-7207	evamplersh@hatena.ne.jp
19	19	566-665-7494	ecummungsi@who.int
20	20	546-399-0396	ehellekerj@g.co
21	21	410-827-9439	fmillbergk@jigsy.com
22	22	959-266-9190	aperchl@miitbeian.gov.cn
23	23	690-964-9737	bglanesterm@chron.com
24	24	765-313-3544	cizkovitzn@simplemachines.org
25	25	872-912-3377	amclaineo@simplemachines.org
26	26	886-790-9078	cjanodetp@digg.com
27	27	925-704-0874	hwillingaleq@shutterfly.com
28	28	836-112-8368	dsheddr@123-reg.co.uk
29	29	304-188-1376	aantonellis@nhs.uk
30	30	586-141-7302	pcarbonellt@google.nl
31	31	102-112-6447	lshalloeu@ifeng.com
32	32	607-711-7058	apryerv@discovery.com
33	33	800-958-1764	gemanuelliw@live.com
34	34	101-607-5861	sfetherstonex@weather.com
35	35	200-782-5332	aantonchiky@economist.com
36	36	764-448-1616	natyeaz@i2i.jp
37	37	846-559-0817	pkeesman10@jugem.jp
38	38	490-402-2268	ebranca11@google.com.hk
39	39	527-970-9220	spollastrino12@sciencedaily.com
40	40	249-652-2732	kgiacomo13@edublogs.org
41	41	619-623-2840	cstation14@epa.gov
42	42	841-625-9858	jdufty15@bloglines.com
43	43	655-624-3659	tjedrzejewsky16@yandex.ru
44	44	850-335-1290	srounsefull17@webmd.com
45	45	288-300-4466	pcrowcroft18@trellian.com
46	46	434-554-3969	ascamwell19@live.com
47	47	162-964-8792	agrinter1a@prlog.org
48	48	636-898-5290	ajirasek1b@adobe.com
49	49	923-831-3205	rdoylend1c@example.com
50	50	117-652-6710	dpentin1d@naver.com
\.


--
-- TOC entry 3573 (class 0 OID 21198)
-- Dependencies: 255
-- Data for Name: dummy_customer; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.dummy_customer (name, surname, email, phone, age, id) FROM stdin;
Snehulka	Neprebudena	snehulk@gmail.com\n	232145234\n	22	1
Baba	Yaga	Babayaga@gmail.com	\N	\N	2
\.


--
-- TOC entry 3571 (class 0 OID 19969)
-- Dependencies: 251
-- Data for Name: expired_car; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.expired_car (expired_car_id, car_first_name, car_serial_number) FROM stdin;
1	Honda	12345123451234567
\.


--
-- TOC entry 3550 (class 0 OID 19715)
-- Dependencies: 230
-- Data for Name: fuel_type; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.fuel_type (fuel_type_id, fuel_type) FROM stdin;
1	DIESEL
2	HYBRID
3	GAS
4	LPG
5	ELECTRO
\.


--
-- TOC entry 3559 (class 0 OID 19783)
-- Dependencies: 239
-- Data for Name: payment; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.payment (payment_id, rental_id, amount, payment_date) FROM stdin;
4	5	435.00	2022-10-05
5	1	866.00	2022-08-17
6	4	858.00	2022-09-27
7	2	460.00	2022-02-18
8	3	805.00	2022-05-19
\.


--
-- TOC entry 3548 (class 0 OID 19696)
-- Dependencies: 228
-- Data for Name: rental; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.rental (rental_id, rental_date, return_date, rented_car_id, customer_id, payment_id, last_update) FROM stdin;
1	2022-10-28	2022-06-13	1GYFK13259R671139	1	1	2022-10-25 00:00:00
2	2022-10-22	2022-09-10	2T1BURHE5FC893301	2	2	2022-10-14 00:00:00
3	2022-11-01	2022-07-29	WAUAH78E26A548765	3	3	2022-10-23 00:00:00
4	2021-12-24	2022-10-21	1N6AD0CUXFN452859	4	4	2022-10-30 00:00:00
5	2021-11-30	2022-05-27	4F2CY0C79BK936155	5	5	2022-10-15 00:00:00
11	2022-12-24	2022-12-24	1GYFK13259R671139	52	\N	2022-12-24 00:00:00
\.


--
-- TOC entry 3553 (class 0 OID 19728)
-- Dependencies: 233
-- Data for Name: rented_car; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.rented_car (rented_car_id_vin_number_, brand_name_id, vehicle_type_id, fuel_type_id, color_id, availability) FROM stdin;
WAUAH78E26A548765	5	4	2	1	\N
5UXFG43568L827904	3	1	2	3	\N
3D73M3CL3BG154585	3	2	4	4	\N
1N6AD0CUXFN452859	1	3	3	5	\N
SALAB2D49BA733483	4	4	5	4	\N
5GNRNJEE8A8940259	5	1	1	3	\N
1N6AA0CJ0DN747514	1	4	3	1	\N
WAUAFAFL4AA005866	2	1	4	2	\N
3VWF17AT8FM279631	4	2	1	2	\N
4F2CY0C79BK936155	5	1	1	3	\N
2T1BURHE9FC748942	1	4	4	3	\N
WAUCFAFR6CA871634	4	3	5	5	\N
WAUSF78K09A845036	1	1	3	4	\N
SAJWA4HA7EM536165	4	1	2	3	\N
3N1AB7AP2FL051517	3	5	1	2	\N
WBASP2C53BC636790	2	2	2	4	\N
JN1AV7AP5FM129088	5	2	3	4	\N
3N1CE2CP8EL482197	3	5	2	1	\N
3D4PG3FG9BT571432	4	5	1	4	\N
WAUSH78E96A050535	3	2	2	1	\N
3VWPG3AG1AM142084	2	3	3	2	\N
3D73Y4ELXAG743218	1	5	3	4	\N
3C6JR6CT1DG992936	1	1	5	5	\N
WP1AE2A20BL063081	1	4	2	5	\N
3N1CN7AP6FL314480	4	4	5	3	\N
WA1KK78R69A502009	5	5	5	3	\N
WAUPEBFMXDA795268	2	2	2	4	\N
4USCN33472L973628	5	1	4	4	\N
1G6DP577360087286	1	2	4	2	\N
5N1AR1NB2BC826100	1	3	2	5	\N
WAUEFBFL7EN618926	2	3	4	5	\N
KM8NU4CC1CU653212	4	4	2	2	\N
WAULC58E75A756408	1	4	3	3	\N
WAULT64B54N413718	5	5	4	3	\N
KMHCT4AEXFU688981	2	3	4	3	\N
3FAHP0CG1AR006159	1	5	2	4	\N
TRUSC28N731762709	1	2	2	2	\N
2C3CCAGG7FH059102	1	4	3	2	\N
4JGDA0EB3FA352819	4	4	4	2	\N
WAUUL98E37A497737	1	5	4	4	\N
WBAPL5C57BA817891	5	2	1	5	\N
TestTestTestTest1	1	1	1	1	\N
SALVP2BG5FH073293	1	1	1	1	\N
5FPYK1F42CB970510	3	3	3	3	\N
3N1CE2CP2FL861035	1	1	1	5	\N
1B3CB9HA5AD996643	1	4	2	2	t
1G4CU541214484969	4	2	4	1	t
1G4GJ11Y9HP422546	1	1	2	1	t
1G6AC5S32E0819182	5	1	1	2	f
1G6DH577890867382	4	4	5	1	f
1GYFK13259R671139	3	4	3	3	f
2T1BURHE5FC893301	2	2	2	2	\N
\.


--
-- TOC entry 3561 (class 0 OID 19795)
-- Dependencies: 241
-- Data for Name: staff; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.staff (staff_id, first_name, last_name, email, rental_shop_id) FROM stdin;
1	Gigi	Bysshe	gbysshe0@deliciousdays.com	1
2	Noami	Arkow	narkow1@miibeian.gov.cn	2
3	Agata	Coope	acoope2@upenn.edu	3
4	Aubry	Kennally	akennally3@scribd.com	4
5	Sarine	Ballinger	sballinger4@home.pl	5
6	Tomas	Bambus	malavelka@gmail.com	5
\.


--
-- TOC entry 3565 (class 0 OID 19809)
-- Dependencies: 245
-- Data for Name: staff_store; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.staff_store (rental_shop_id, staff_id, store_id, rental_id) FROM stdin;
1	1	1	1
2	2	2	2
3	3	3	3
4	4	4	4
5	5	5	5
\.


--
-- TOC entry 3563 (class 0 OID 19802)
-- Dependencies: 243
-- Data for Name: store; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.store (store_id, name_of_the_shop) FROM stdin;
1	cardealer_PK
2	cardealer_TN
3	cardealer_LP
4	cardealer_TT
5	cardealer_LP
\.


--
-- TOC entry 3567 (class 0 OID 19831)
-- Dependencies: 247
-- Data for Name: street; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.street (street_id, street, house_number, city_id) FROM stdin;
1	Westport	332	1
2	Delladonna	7183	2
3	Harper	5313	3
4	Old Shore	68	4
5	Forest	7106	5
\.


--
-- TOC entry 3552 (class 0 OID 19722)
-- Dependencies: 232
-- Data for Name: type_of_vehicle; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

COPY mydb.type_of_vehicle (vehicle_type_id, vehicle_type) FROM stdin;
1	SPORT
2	CABRIO
3	JEEP
4	SEDAN
5	CABRIO
\.


--
-- TOC entry 3609 (class 0 OID 0)
-- Dependencies: 223
-- Name: address_address_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.address_address_id_seq', 5, true);


--
-- TOC entry 3610 (class 0 OID 0)
-- Dependencies: 225
-- Name: brand_of_vehicle_brand_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.brand_of_vehicle_brand_id_seq', 5, true);


--
-- TOC entry 3611 (class 0 OID 0)
-- Dependencies: 234
-- Name: car_car_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.car_car_id_seq', 5, true);


--
-- TOC entry 3612 (class 0 OID 0)
-- Dependencies: 221
-- Name: city_city_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.city_city_id_seq', 6, true);


--
-- TOC entry 3613 (class 0 OID 0)
-- Dependencies: 248
-- Name: color_of_vehicle_color_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.color_of_vehicle_color_id_seq', 5, true);


--
-- TOC entry 3614 (class 0 OID 0)
-- Dependencies: 219
-- Name: country_country_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.country_country_id_seq', 5, true);


--
-- TOC entry 3615 (class 0 OID 0)
-- Dependencies: 236
-- Name: customer_contact_customer_contact_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.customer_contact_customer_contact_id_seq', 50, true);


--
-- TOC entry 3616 (class 0 OID 0)
-- Dependencies: 217
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.customer_customer_id_seq', 52, true);


--
-- TOC entry 3617 (class 0 OID 0)
-- Dependencies: 256
-- Name: dummy_customer_Id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb."dummy_customer_Id_seq"', 2, true);


--
-- TOC entry 3618 (class 0 OID 0)
-- Dependencies: 250
-- Name: expired_car_expired_car_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.expired_car_expired_car_id_seq', 1, true);


--
-- TOC entry 3619 (class 0 OID 0)
-- Dependencies: 229
-- Name: fuel_type_fuel_type_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.fuel_type_fuel_type_id_seq', 5, true);


--
-- TOC entry 3620 (class 0 OID 0)
-- Dependencies: 238
-- Name: payment_payment_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.payment_payment_id_seq', 8, true);


--
-- TOC entry 3621 (class 0 OID 0)
-- Dependencies: 227
-- Name: rental_rental_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.rental_rental_id_seq', 11, true);


--
-- TOC entry 3622 (class 0 OID 0)
-- Dependencies: 240
-- Name: staff_staff_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.staff_staff_id_seq', 6, true);


--
-- TOC entry 3623 (class 0 OID 0)
-- Dependencies: 244
-- Name: staff_store_rental_shop_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.staff_store_rental_shop_id_seq', 5, true);


--
-- TOC entry 3624 (class 0 OID 0)
-- Dependencies: 242
-- Name: store_store_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.store_store_id_seq', 5, true);


--
-- TOC entry 3625 (class 0 OID 0)
-- Dependencies: 246
-- Name: street_street_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.street_street_id_seq', 5, true);


--
-- TOC entry 3626 (class 0 OID 0)
-- Dependencies: 231
-- Name: type_of_vehicle_vehicle_type_id_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.type_of_vehicle_vehicle_type_id_seq', 5, true);


--
-- TOC entry 3346 (class 2606 OID 19677)
-- Name: address address_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


--
-- TOC entry 3348 (class 2606 OID 19694)
-- Name: brand_of_vehicle brand_of_vehicle_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.brand_of_vehicle
    ADD CONSTRAINT brand_of_vehicle_pkey PRIMARY KEY (brand_id);


--
-- TOC entry 3358 (class 2606 OID 19759)
-- Name: car car_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.car
    ADD CONSTRAINT car_pkey PRIMARY KEY (car_id);


--
-- TOC entry 3344 (class 2606 OID 19653)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


--
-- TOC entry 3373 (class 2606 OID 19856)
-- Name: color_of_vehicle color_of_vehicle_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.color_of_vehicle
    ADD CONSTRAINT color_of_vehicle_pkey PRIMARY KEY (color_id);


--
-- TOC entry 3342 (class 2606 OID 19646)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


--
-- TOC entry 3360 (class 2606 OID 19776)
-- Name: customer_contact customer_contact_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.customer_contact
    ADD CONSTRAINT customer_contact_pkey PRIMARY KEY (customer_contact_id);


--
-- TOC entry 3340 (class 2606 OID 19639)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 3352 (class 2606 OID 19720)
-- Name: fuel_type fuel_type_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.fuel_type
    ADD CONSTRAINT fuel_type_pkey PRIMARY KEY (fuel_type_id);


--
-- TOC entry 3375 (class 2606 OID 21210)
-- Name: dummy_customer id; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.dummy_customer
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- TOC entry 3363 (class 2606 OID 19788)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 3350 (class 2606 OID 19701)
-- Name: rental rental_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.rental
    ADD CONSTRAINT rental_pkey PRIMARY KEY (rental_id);


--
-- TOC entry 3356 (class 2606 OID 19732)
-- Name: rented_car rented_car_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.rented_car
    ADD CONSTRAINT rented_car_pkey PRIMARY KEY (rented_car_id_vin_number_);


--
-- TOC entry 3365 (class 2606 OID 19800)
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);


--
-- TOC entry 3369 (class 2606 OID 19814)
-- Name: staff_store staff_store_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.staff_store
    ADD CONSTRAINT staff_store_pkey PRIMARY KEY (rental_shop_id);


--
-- TOC entry 3367 (class 2606 OID 19807)
-- Name: store store_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.store
    ADD CONSTRAINT store_pkey PRIMARY KEY (store_id);


--
-- TOC entry 3371 (class 2606 OID 19836)
-- Name: street street_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.street
    ADD CONSTRAINT street_pkey PRIMARY KEY (street_id);


--
-- TOC entry 3354 (class 2606 OID 19727)
-- Name: type_of_vehicle type_of_vehicle_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.type_of_vehicle
    ADD CONSTRAINT type_of_vehicle_pkey PRIMARY KEY (vehicle_type_id);


--
-- TOC entry 3361 (class 1259 OID 19974)
-- Name: idx_payment_detail; Type: INDEX; Schema: mydb; Owner: postgres
--

CREATE INDEX idx_payment_detail ON mydb.payment USING btree (amount, payment_date);


--
-- TOC entry 3390 (class 2620 OID 19952)
-- Name: customer after_trigger; Type: TRIGGER; Schema: mydb; Owner: postgres
--

CREATE TRIGGER after_trigger AFTER INSERT ON mydb.customer FOR EACH STATEMENT EXECUTE FUNCTION mydb.attention_notice();


--
-- TOC entry 3391 (class 2620 OID 19976)
-- Name: customer after_triggers; Type: TRIGGER; Schema: mydb; Owner: postgres
--

CREATE TRIGGER after_triggers AFTER INSERT ON mydb.customer FOR EACH STATEMENT EXECUTE FUNCTION mydb.attention_notice();


--
-- TOC entry 3377 (class 2606 OID 19678)
-- Name: address fk_address_customer1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.address
    ADD CONSTRAINT fk_address_customer1 FOREIGN KEY (customer_id) REFERENCES mydb.customer(customer_id);


--
-- TOC entry 3382 (class 2606 OID 19760)
-- Name: car fk_car_rental1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.car
    ADD CONSTRAINT fk_car_rental1 FOREIGN KEY (rental_id) REFERENCES mydb.rental(rental_id);


--
-- TOC entry 3383 (class 2606 OID 19765)
-- Name: car fk_car_rented_car1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.car
    ADD CONSTRAINT fk_car_rented_car1 FOREIGN KEY (rented_car_id) REFERENCES mydb.rented_car(rented_car_id_vin_number_);


--
-- TOC entry 3376 (class 2606 OID 19654)
-- Name: city fk_city_country1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.city
    ADD CONSTRAINT fk_city_country1 FOREIGN KEY (country_id) REFERENCES mydb.country(country_id);


--
-- TOC entry 3384 (class 2606 OID 20059)
-- Name: customer_contact fk_customer_contact_customer1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.customer_contact
    ADD CONSTRAINT fk_customer_contact_customer1 FOREIGN KEY (customer_id) REFERENCES mydb.customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3385 (class 2606 OID 20064)
-- Name: payment fk_payment_rental1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.payment
    ADD CONSTRAINT fk_payment_rental1 FOREIGN KEY (rental_id) REFERENCES mydb.rental(rental_id) ON DELETE CASCADE;


--
-- TOC entry 3378 (class 2606 OID 19702)
-- Name: rental fk_rental_customer1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.rental
    ADD CONSTRAINT fk_rental_customer1 FOREIGN KEY (customer_id) REFERENCES mydb.customer(customer_id);


--
-- TOC entry 3379 (class 2606 OID 19733)
-- Name: rented_car fk_rented_car_brand_of_vehicle1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.rented_car
    ADD CONSTRAINT fk_rented_car_brand_of_vehicle1 FOREIGN KEY (brand_name_id) REFERENCES mydb.brand_of_vehicle(brand_id);


--
-- TOC entry 3380 (class 2606 OID 19743)
-- Name: rented_car fk_rented_car_fuel_type1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.rented_car
    ADD CONSTRAINT fk_rented_car_fuel_type1 FOREIGN KEY (fuel_type_id) REFERENCES mydb.fuel_type(fuel_type_id);


--
-- TOC entry 3381 (class 2606 OID 19748)
-- Name: rented_car fk_rented_car_type_of_vehicle1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.rented_car
    ADD CONSTRAINT fk_rented_car_type_of_vehicle1 FOREIGN KEY (vehicle_type_id) REFERENCES mydb.type_of_vehicle(vehicle_type_id);


--
-- TOC entry 3386 (class 2606 OID 19815)
-- Name: staff_store fk_staff_store_rental1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.staff_store
    ADD CONSTRAINT fk_staff_store_rental1 FOREIGN KEY (rental_id) REFERENCES mydb.rental(rental_id);


--
-- TOC entry 3387 (class 2606 OID 19820)
-- Name: staff_store fk_staff_store_staff1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.staff_store
    ADD CONSTRAINT fk_staff_store_staff1 FOREIGN KEY (staff_id) REFERENCES mydb.staff(staff_id);


--
-- TOC entry 3388 (class 2606 OID 19825)
-- Name: staff_store fk_staff_store_store1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.staff_store
    ADD CONSTRAINT fk_staff_store_store1 FOREIGN KEY (store_id) REFERENCES mydb.store(store_id);


--
-- TOC entry 3389 (class 2606 OID 19837)
-- Name: street fk_street_city1; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.street
    ADD CONSTRAINT fk_street_city1 FOREIGN KEY (city_id) REFERENCES mydb.city(city_id);


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE rental; Type: ACL; Schema: mydb; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mydb.rental TO "my-app";


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 228 3586
-- Name: COLUMN rental.rental_date; Type: ACL; Schema: mydb; Owner: postgres
--

GRANT SELECT(rental_date) ON TABLE mydb.rental TO "my-app";


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 228 3586
-- Name: COLUMN rental.return_date; Type: ACL; Schema: mydb; Owner: postgres
--

GRANT SELECT(return_date) ON TABLE mydb.rental TO "my-app";


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 228 3586
-- Name: COLUMN rental.rented_car_id; Type: ACL; Schema: mydb; Owner: postgres
--

GRANT SELECT(rented_car_id) ON TABLE mydb.rental TO "my-app";


--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE customer; Type: ACL; Schema: mydb; Owner: postgres
--

GRANT SELECT ON TABLE mydb.customer TO "my-script";


--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE customer_contact; Type: ACL; Schema: mydb; Owner: postgres
--

GRANT SELECT ON TABLE mydb.customer_contact TO "my-script";


--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE payment; Type: ACL; Schema: mydb; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mydb.payment TO "my-app";


--
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 239 3597
-- Name: COLUMN payment.amount; Type: ACL; Schema: mydb; Owner: postgres
--

GRANT SELECT(amount) ON TABLE mydb.payment TO "my-app";


--
-- TOC entry 3572 (class 0 OID 19987)
-- Dependencies: 252 3576
-- Name: customer_materialized_view; Type: MATERIALIZED VIEW DATA; Schema: mydb; Owner: postgres
--

REFRESH MATERIALIZED VIEW mydb.customer_materialized_view;


-- Completed on 2023-01-02 13:01:26

--
-- PostgreSQL database dump complete
--

-- Completed on 2023-01-02 13:01:26

--
-- PostgreSQL database cluster dump complete
--

