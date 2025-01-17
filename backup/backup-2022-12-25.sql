PGDMP                           z            postgres    15.1    15.1 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    5    postgres    DATABASE     }   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Slovak_Slovakia.1250';
    DROP DATABASE postgres;
                postgres    false            �           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3577                        2615    19632    mydb    SCHEMA        CREATE SCHEMA mydb;
    DROP SCHEMA mydb;
                postgres    false                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            �           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2                        3079    20069    pgcrypto 	   EXTENSION     :   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA mydb;
    DROP EXTENSION pgcrypto;
                   false    8            �           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    4                        3079    19884    unaccent 	   EXTENSION     :   CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA mydb;
    DROP EXTENSION unaccent;
                   false    8            �           0    0    EXTENSION unaccent    COMMENT     P   COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';
                        false    3                       1255    19951    attention_notice()    FUNCTION     �   CREATE FUNCTION mydb.attention_notice() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
RAISE NOTICE 'USER INSERTED SUCCESFULLY';
RETURN NEW;
END;
$$;
 '   DROP FUNCTION mydb.attention_notice();
       mydb          postgres    false    8                       1255    19975 J   insert_data_staff(character varying, character varying, character varying) 	   PROCEDURE       CREATE PROCEDURE mydb.insert_data_staff(IN first_name character varying, IN last_name character varying, IN email character varying)
    LANGUAGE sql
    AS $$
	INSERT INTO mydb.staff(first_name,last_name,email) VALUES ('Tomas','Lacko','SmartGranadir@gmail.com')
	$$;
 �   DROP PROCEDURE mydb.insert_data_staff(IN first_name character varying, IN last_name character varying, IN email character varying);
       mydb          postgres    false    8            �            1259    19672    address    TABLE     �   CREATE TABLE mydb.address (
    address_id integer NOT NULL,
    street_id integer NOT NULL,
    customer_id integer NOT NULL
);
    DROP TABLE mydb.address;
       mydb         heap    postgres    false    8            �            1259    19671    address_address_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.address_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE mydb.address_address_id_seq;
       mydb          postgres    false    8    224            �           0    0    address_address_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE mydb.address_address_id_seq OWNED BY mydb.address.address_id;
          mydb          postgres    false    223            �            1259    19689    brand_of_vehicle    TABLE     u   CREATE TABLE mydb.brand_of_vehicle (
    brand_id integer NOT NULL,
    brand_name character varying(20) NOT NULL
);
 "   DROP TABLE mydb.brand_of_vehicle;
       mydb         heap    postgres    false    8            �            1259    19688    brand_of_vehicle_brand_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.brand_of_vehicle_brand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE mydb.brand_of_vehicle_brand_id_seq;
       mydb          postgres    false    226    8            �           0    0    brand_of_vehicle_brand_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE mydb.brand_of_vehicle_brand_id_seq OWNED BY mydb.brand_of_vehicle.brand_id;
          mydb          postgres    false    225            �            1259    19754    car    TABLE     �   CREATE TABLE mydb.car (
    rental_id integer NOT NULL,
    rented_car_id character varying(17) NOT NULL,
    car_id integer NOT NULL
);
    DROP TABLE mydb.car;
       mydb         heap    postgres    false    8            �            1259    19753    car_car_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.car_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE mydb.car_car_id_seq;
       mydb          postgres    false    235    8                        0    0    car_car_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE mydb.car_car_id_seq OWNED BY mydb.car.car_id;
          mydb          postgres    false    234            �            1259    19696    rental    TABLE       CREATE TABLE mydb.rental (
    rental_id integer NOT NULL,
    rental_date date NOT NULL,
    return_date date NOT NULL,
    rented_car_id character varying(17),
    customer_id integer NOT NULL,
    payment_id integer,
    last_update timestamp without time zone
);
    DROP TABLE mydb.rental;
       mydb         heap    postgres    false    8                       0    0    TABLE rental    ACL     D   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mydb.rental TO "my-app";
          mydb          postgres    false    228                       0    0    COLUMN rental.rental_date    ACL     <   GRANT SELECT(rental_date) ON TABLE mydb.rental TO "my-app";
          mydb          postgres    false    228    3585                       0    0    COLUMN rental.return_date    ACL     <   GRANT SELECT(return_date) ON TABLE mydb.rental TO "my-app";
          mydb          postgres    false    228    3585                       0    0    COLUMN rental.rented_car_id    ACL     >   GRANT SELECT(rented_car_id) ON TABLE mydb.rental TO "my-app";
          mydb          postgres    false    228    3585            �            1259    19728 
   rented_car    TABLE       CREATE TABLE mydb.rented_car (
    rented_car_id_vin_number_ character varying(17) NOT NULL,
    brand_name_id integer NOT NULL,
    vehicle_type_id integer NOT NULL,
    fuel_type_id integer NOT NULL,
    color_id integer NOT NULL,
    availability boolean
);
    DROP TABLE mydb.rented_car;
       mydb         heap    postgres    false    8            �            1259    21190    car_date_view    VIEW     I  CREATE VIEW mydb.car_date_view AS
 SELECT rental.rental_date,
    rental.return_date,
    rented_car.rented_car_id_vin_number_
   FROM ((mydb.car
     RIGHT JOIN mydb.rented_car ON (((rented_car.rented_car_id_vin_number_)::text = (car.rented_car_id)::text)))
     RIGHT JOIN mydb.rental ON ((rental.rental_id = car.rental_id)));
    DROP VIEW mydb.car_date_view;
       mydb          postgres    false    228    228    233    235    235    228    8            �            1259    19648    city    TABLE     �   CREATE TABLE mydb.city (
    city_id integer NOT NULL,
    city character varying(32) NOT NULL,
    post_code character varying(5) NOT NULL,
    country_id integer NOT NULL
);
    DROP TABLE mydb.city;
       mydb         heap    postgres    false    8            �            1259    19647    city_city_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.city_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE mydb.city_city_id_seq;
       mydb          postgres    false    8    222                       0    0    city_city_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE mydb.city_city_id_seq OWNED BY mydb.city.city_id;
          mydb          postgres    false    221            �            1259    19851    color_of_vehicle    TABLE     p   CREATE TABLE mydb.color_of_vehicle (
    color_id integer NOT NULL,
    color character varying(20) NOT NULL
);
 "   DROP TABLE mydb.color_of_vehicle;
       mydb         heap    postgres    false    8            �            1259    19850    color_of_vehicle_color_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.color_of_vehicle_color_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE mydb.color_of_vehicle_color_id_seq;
       mydb          postgres    false    249    8                       0    0    color_of_vehicle_color_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE mydb.color_of_vehicle_color_id_seq OWNED BY mydb.color_of_vehicle.color_id;
          mydb          postgres    false    248            �            1259    19641    country    TABLE     k   CREATE TABLE mydb.country (
    country_id integer NOT NULL,
    country character varying(32) NOT NULL
);
    DROP TABLE mydb.country;
       mydb         heap    postgres    false    8            �            1259    19640    country_country_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.country_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE mydb.country_country_id_seq;
       mydb          postgres    false    8    220                       0    0    country_country_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE mydb.country_country_id_seq OWNED BY mydb.country.country_id;
          mydb          postgres    false    219            �            1259    19634    customer    TABLE     }  CREATE TABLE mydb.customer (
    customer_id integer NOT NULL,
    first_name character varying(16) NOT NULL,
    last_name character varying(16) NOT NULL,
    active boolean,
    create_date date NOT NULL,
    username character varying(16) NOT NULL,
    password character varying(16) NOT NULL,
    dummypassword character varying(16),
    dummypasswordhash character varying
);
    DROP TABLE mydb.customer;
       mydb         heap    postgres    false    8                       0    0    TABLE customer    ACL     4   GRANT SELECT ON TABLE mydb.customer TO "my-script";
          mydb          postgres    false    218            �            1259    19771    customer_contact    TABLE     �   CREATE TABLE mydb.customer_contact (
    customer_contact_id integer NOT NULL,
    customer_id integer NOT NULL,
    phone character varying(13) NOT NULL,
    email character varying(32) NOT NULL
);
 "   DROP TABLE mydb.customer_contact;
       mydb         heap    postgres    false    8            	           0    0    TABLE customer_contact    ACL     <   GRANT SELECT ON TABLE mydb.customer_contact TO "my-script";
          mydb          postgres    false    237            �            1259    19770 (   customer_contact_customer_contact_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.customer_contact_customer_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE mydb.customer_contact_customer_contact_id_seq;
       mydb          postgres    false    8    237            
           0    0 (   customer_contact_customer_contact_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE mydb.customer_contact_customer_contact_id_seq OWNED BY mydb.customer_contact.customer_contact_id;
          mydb          postgres    false    236            �            1259    19633    customer_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.customer_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE mydb.customer_customer_id_seq;
       mydb          postgres    false    218    8                       0    0    customer_customer_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE mydb.customer_customer_id_seq OWNED BY mydb.customer.customer_id;
          mydb          postgres    false    217            �            1259    19783    payment    TABLE     �   CREATE TABLE mydb.payment (
    payment_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date date NOT NULL
);
    DROP TABLE mydb.payment;
       mydb         heap    postgres    false    8                       0    0    TABLE payment    ACL     E   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mydb.payment TO "my-app";
          mydb          postgres    false    239                       0    0    COLUMN payment.amount    ACL     8   GRANT SELECT(amount) ON TABLE mydb.payment TO "my-app";
          mydb          postgres    false    239    3596            �            1259    21185    customer_info_view    VIEW     I  CREATE VIEW mydb.customer_info_view AS
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
 #   DROP VIEW mydb.customer_info_view;
       mydb          postgres    false    218    239    237    239    237    237    228    228    218    218    8            �            1259    19987    customer_materialized_view    MATERIALIZED VIEW     �  CREATE MATERIALIZED VIEW mydb.customer_materialized_view AS
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
 8   DROP MATERIALIZED VIEW mydb.customer_materialized_view;
       mydb         heap    postgres    false    228    218    218    228    239    239    8            �            1259    21198    dummy_customer    TABLE       CREATE TABLE mydb.dummy_customer (
    name character varying(32) NOT NULL,
    username character varying(32) NOT NULL,
    surname character varying(32) NOT NULL,
    email character varying(32) NOT NULL,
    phone character varying(10) NOT NULL,
    age integer NOT NULL
);
     DROP TABLE mydb.dummy_customer;
       mydb         heap    postgres    false    8            �            1259    19969    expired_car    TABLE     �   CREATE TABLE mydb.expired_car (
    expired_car_id integer NOT NULL,
    car_first_name character varying(32),
    car_serial_number character varying(17)
);
    DROP TABLE mydb.expired_car;
       mydb         heap    postgres    false    8            �            1259    19968    expired_car_expired_car_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.expired_car_expired_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE mydb.expired_car_expired_car_id_seq;
       mydb          postgres    false    251    8                       0    0    expired_car_expired_car_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE mydb.expired_car_expired_car_id_seq OWNED BY mydb.expired_car.expired_car_id;
          mydb          postgres    false    250            �            1259    19715 	   fuel_type    TABLE     q   CREATE TABLE mydb.fuel_type (
    fuel_type_id integer NOT NULL,
    fuel_type character varying(20) NOT NULL
);
    DROP TABLE mydb.fuel_type;
       mydb         heap    postgres    false    8            �            1259    19714    fuel_type_fuel_type_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.fuel_type_fuel_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE mydb.fuel_type_fuel_type_id_seq;
       mydb          postgres    false    8    230                       0    0    fuel_type_fuel_type_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE mydb.fuel_type_fuel_type_id_seq OWNED BY mydb.fuel_type.fuel_type_id;
          mydb          postgres    false    229            �            1259    19782    payment_payment_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.payment_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE mydb.payment_payment_id_seq;
       mydb          postgres    false    239    8                       0    0    payment_payment_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE mydb.payment_payment_id_seq OWNED BY mydb.payment.payment_id;
          mydb          postgres    false    238            �            1259    19695    rental_rental_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.rental_rental_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE mydb.rental_rental_id_seq;
       mydb          postgres    false    8    228                       0    0    rental_rental_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE mydb.rental_rental_id_seq OWNED BY mydb.rental.rental_id;
          mydb          postgres    false    227            �            1259    19795    staff    TABLE     �   CREATE TABLE mydb.staff (
    staff_id integer NOT NULL,
    first_name character varying(16) NOT NULL,
    last_name character varying(16) NOT NULL,
    email character varying(32) NOT NULL,
    rental_shop_id integer NOT NULL
);
    DROP TABLE mydb.staff;
       mydb         heap    postgres    false    8            �            1259    19794    staff_staff_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.staff_staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE mydb.staff_staff_id_seq;
       mydb          postgres    false    8    241                       0    0    staff_staff_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE mydb.staff_staff_id_seq OWNED BY mydb.staff.staff_id;
          mydb          postgres    false    240            �            1259    19809    staff_store    TABLE     �   CREATE TABLE mydb.staff_store (
    rental_shop_id integer NOT NULL,
    staff_id integer NOT NULL,
    store_id integer NOT NULL,
    rental_id integer
);
    DROP TABLE mydb.staff_store;
       mydb         heap    postgres    false    8            �            1259    19808    staff_store_rental_shop_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.staff_store_rental_shop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE mydb.staff_store_rental_shop_id_seq;
       mydb          postgres    false    8    245                       0    0    staff_store_rental_shop_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE mydb.staff_store_rental_shop_id_seq OWNED BY mydb.staff_store.rental_shop_id;
          mydb          postgres    false    244            �            1259    19802    store    TABLE     p   CREATE TABLE mydb.store (
    store_id integer NOT NULL,
    name_of_the_shop character varying(32) NOT NULL
);
    DROP TABLE mydb.store;
       mydb         heap    postgres    false    8            �            1259    19801    store_store_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.store_store_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE mydb.store_store_id_seq;
       mydb          postgres    false    8    243                       0    0    store_store_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE mydb.store_store_id_seq OWNED BY mydb.store.store_id;
          mydb          postgres    false    242            �            1259    19831    street    TABLE     �   CREATE TABLE mydb.street (
    street_id integer NOT NULL,
    street character varying(32) NOT NULL,
    house_number character varying(8) NOT NULL,
    city_id integer NOT NULL
);
    DROP TABLE mydb.street;
       mydb         heap    postgres    false    8            �            1259    19830    street_street_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.street_street_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE mydb.street_street_id_seq;
       mydb          postgres    false    8    247                       0    0    street_street_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE mydb.street_street_id_seq OWNED BY mydb.street.street_id;
          mydb          postgres    false    246            �            1259    19722    type_of_vehicle    TABLE     }   CREATE TABLE mydb.type_of_vehicle (
    vehicle_type_id integer NOT NULL,
    vehicle_type character varying(20) NOT NULL
);
 !   DROP TABLE mydb.type_of_vehicle;
       mydb         heap    postgres    false    8            �            1259    19721 #   type_of_vehicle_vehicle_type_id_seq    SEQUENCE     �   CREATE SEQUENCE mydb.type_of_vehicle_vehicle_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE mydb.type_of_vehicle_vehicle_type_id_seq;
       mydb          postgres    false    232    8                       0    0 #   type_of_vehicle_vehicle_type_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE mydb.type_of_vehicle_vehicle_type_id_seq OWNED BY mydb.type_of_vehicle.vehicle_type_id;
          mydb          postgres    false    231            �           2604    19675    address address_id    DEFAULT     t   ALTER TABLE ONLY mydb.address ALTER COLUMN address_id SET DEFAULT nextval('mydb.address_address_id_seq'::regclass);
 ?   ALTER TABLE mydb.address ALTER COLUMN address_id DROP DEFAULT;
       mydb          postgres    false    224    223    224            �           2604    19692    brand_of_vehicle brand_id    DEFAULT     �   ALTER TABLE ONLY mydb.brand_of_vehicle ALTER COLUMN brand_id SET DEFAULT nextval('mydb.brand_of_vehicle_brand_id_seq'::regclass);
 F   ALTER TABLE mydb.brand_of_vehicle ALTER COLUMN brand_id DROP DEFAULT;
       mydb          postgres    false    225    226    226                        2604    19757 
   car car_id    DEFAULT     d   ALTER TABLE ONLY mydb.car ALTER COLUMN car_id SET DEFAULT nextval('mydb.car_car_id_seq'::regclass);
 7   ALTER TABLE mydb.car ALTER COLUMN car_id DROP DEFAULT;
       mydb          postgres    false    234    235    235            �           2604    19651    city city_id    DEFAULT     h   ALTER TABLE ONLY mydb.city ALTER COLUMN city_id SET DEFAULT nextval('mydb.city_city_id_seq'::regclass);
 9   ALTER TABLE mydb.city ALTER COLUMN city_id DROP DEFAULT;
       mydb          postgres    false    222    221    222                       2604    19854    color_of_vehicle color_id    DEFAULT     �   ALTER TABLE ONLY mydb.color_of_vehicle ALTER COLUMN color_id SET DEFAULT nextval('mydb.color_of_vehicle_color_id_seq'::regclass);
 F   ALTER TABLE mydb.color_of_vehicle ALTER COLUMN color_id DROP DEFAULT;
       mydb          postgres    false    249    248    249            �           2604    19644    country country_id    DEFAULT     t   ALTER TABLE ONLY mydb.country ALTER COLUMN country_id SET DEFAULT nextval('mydb.country_country_id_seq'::regclass);
 ?   ALTER TABLE mydb.country ALTER COLUMN country_id DROP DEFAULT;
       mydb          postgres    false    219    220    220            �           2604    19637    customer customer_id    DEFAULT     x   ALTER TABLE ONLY mydb.customer ALTER COLUMN customer_id SET DEFAULT nextval('mydb.customer_customer_id_seq'::regclass);
 A   ALTER TABLE mydb.customer ALTER COLUMN customer_id DROP DEFAULT;
       mydb          postgres    false    218    217    218                       2604    19774 $   customer_contact customer_contact_id    DEFAULT     �   ALTER TABLE ONLY mydb.customer_contact ALTER COLUMN customer_contact_id SET DEFAULT nextval('mydb.customer_contact_customer_contact_id_seq'::regclass);
 Q   ALTER TABLE mydb.customer_contact ALTER COLUMN customer_contact_id DROP DEFAULT;
       mydb          postgres    false    236    237    237                       2604    19972    expired_car expired_car_id    DEFAULT     �   ALTER TABLE ONLY mydb.expired_car ALTER COLUMN expired_car_id SET DEFAULT nextval('mydb.expired_car_expired_car_id_seq'::regclass);
 G   ALTER TABLE mydb.expired_car ALTER COLUMN expired_car_id DROP DEFAULT;
       mydb          postgres    false    250    251    251            �           2604    19718    fuel_type fuel_type_id    DEFAULT     |   ALTER TABLE ONLY mydb.fuel_type ALTER COLUMN fuel_type_id SET DEFAULT nextval('mydb.fuel_type_fuel_type_id_seq'::regclass);
 C   ALTER TABLE mydb.fuel_type ALTER COLUMN fuel_type_id DROP DEFAULT;
       mydb          postgres    false    230    229    230                       2604    19786    payment payment_id    DEFAULT     t   ALTER TABLE ONLY mydb.payment ALTER COLUMN payment_id SET DEFAULT nextval('mydb.payment_payment_id_seq'::regclass);
 ?   ALTER TABLE mydb.payment ALTER COLUMN payment_id DROP DEFAULT;
       mydb          postgres    false    239    238    239            �           2604    19699    rental rental_id    DEFAULT     p   ALTER TABLE ONLY mydb.rental ALTER COLUMN rental_id SET DEFAULT nextval('mydb.rental_rental_id_seq'::regclass);
 =   ALTER TABLE mydb.rental ALTER COLUMN rental_id DROP DEFAULT;
       mydb          postgres    false    228    227    228                       2604    19798    staff staff_id    DEFAULT     l   ALTER TABLE ONLY mydb.staff ALTER COLUMN staff_id SET DEFAULT nextval('mydb.staff_staff_id_seq'::regclass);
 ;   ALTER TABLE mydb.staff ALTER COLUMN staff_id DROP DEFAULT;
       mydb          postgres    false    240    241    241                       2604    19812    staff_store rental_shop_id    DEFAULT     �   ALTER TABLE ONLY mydb.staff_store ALTER COLUMN rental_shop_id SET DEFAULT nextval('mydb.staff_store_rental_shop_id_seq'::regclass);
 G   ALTER TABLE mydb.staff_store ALTER COLUMN rental_shop_id DROP DEFAULT;
       mydb          postgres    false    244    245    245                       2604    19805    store store_id    DEFAULT     l   ALTER TABLE ONLY mydb.store ALTER COLUMN store_id SET DEFAULT nextval('mydb.store_store_id_seq'::regclass);
 ;   ALTER TABLE mydb.store ALTER COLUMN store_id DROP DEFAULT;
       mydb          postgres    false    242    243    243                       2604    19834    street street_id    DEFAULT     p   ALTER TABLE ONLY mydb.street ALTER COLUMN street_id SET DEFAULT nextval('mydb.street_street_id_seq'::regclass);
 =   ALTER TABLE mydb.street ALTER COLUMN street_id DROP DEFAULT;
       mydb          postgres    false    247    246    247            �           2604    19725    type_of_vehicle vehicle_type_id    DEFAULT     �   ALTER TABLE ONLY mydb.type_of_vehicle ALTER COLUMN vehicle_type_id SET DEFAULT nextval('mydb.type_of_vehicle_vehicle_type_id_seq'::regclass);
 L   ALTER TABLE mydb.type_of_vehicle ALTER COLUMN vehicle_type_id DROP DEFAULT;
       mydb          postgres    false    232    231    232            �          0    19672    address 
   TABLE DATA           C   COPY mydb.address (address_id, street_id, customer_id) FROM stdin;
    mydb          postgres    false    224   X�       �          0    19689    brand_of_vehicle 
   TABLE DATA           >   COPY mydb.brand_of_vehicle (brand_id, brand_name) FROM stdin;
    mydb          postgres    false    226   ��       �          0    19754    car 
   TABLE DATA           =   COPY mydb.car (rental_id, rented_car_id, car_id) FROM stdin;
    mydb          postgres    false    235   ��       �          0    19648    city 
   TABLE DATA           B   COPY mydb.city (city_id, city, post_code, country_id) FROM stdin;
    mydb          postgres    false    222   E�       �          0    19851    color_of_vehicle 
   TABLE DATA           9   COPY mydb.color_of_vehicle (color_id, color) FROM stdin;
    mydb          postgres    false    249   ��       �          0    19641    country 
   TABLE DATA           4   COPY mydb.country (country_id, country) FROM stdin;
    mydb          postgres    false    220   �       �          0    19634    customer 
   TABLE DATA           �   COPY mydb.customer (customer_id, first_name, last_name, active, create_date, username, password, dummypassword, dummypasswordhash) FROM stdin;
    mydb          postgres    false    218   V�       �          0    19771    customer_contact 
   TABLE DATA           X   COPY mydb.customer_contact (customer_contact_id, customer_id, phone, email) FROM stdin;
    mydb          postgres    false    237   x�       �          0    21198    dummy_customer 
   TABLE DATA           R   COPY mydb.dummy_customer (name, username, surname, email, phone, age) FROM stdin;
    mydb          postgres    false    255   x�       �          0    19969    expired_car 
   TABLE DATA           V   COPY mydb.expired_car (expired_car_id, car_first_name, car_serial_number) FROM stdin;
    mydb          postgres    false    251   ��       �          0    19715 	   fuel_type 
   TABLE DATA           :   COPY mydb.fuel_type (fuel_type_id, fuel_type) FROM stdin;
    mydb          postgres    false    230   ��       �          0    19783    payment 
   TABLE DATA           L   COPY mydb.payment (payment_id, rental_id, amount, payment_date) FROM stdin;
    mydb          postgres    false    239   �       �          0    19696    rental 
   TABLE DATA           x   COPY mydb.rental (rental_id, rental_date, return_date, rented_car_id, customer_id, payment_id, last_update) FROM stdin;
    mydb          postgres    false    228   a�       �          0    19728 
   rented_car 
   TABLE DATA           �   COPY mydb.rented_car (rented_car_id_vin_number_, brand_name_id, vehicle_type_id, fuel_type_id, color_id, availability) FROM stdin;
    mydb          postgres    false    233   5�       �          0    19795    staff 
   TABLE DATA           U   COPY mydb.staff (staff_id, first_name, last_name, email, rental_shop_id) FROM stdin;
    mydb          postgres    false    241   Q�       �          0    19809    staff_store 
   TABLE DATA           R   COPY mydb.staff_store (rental_shop_id, staff_id, store_id, rental_id) FROM stdin;
    mydb          postgres    false    245   �       �          0    19802    store 
   TABLE DATA           9   COPY mydb.store (store_id, name_of_the_shop) FROM stdin;
    mydb          postgres    false    243   M�       �          0    19831    street 
   TABLE DATA           H   COPY mydb.street (street_id, street, house_number, city_id) FROM stdin;
    mydb          postgres    false    247   ��       �          0    19722    type_of_vehicle 
   TABLE DATA           F   COPY mydb.type_of_vehicle (vehicle_type_id, vehicle_type) FROM stdin;
    mydb          postgres    false    232   ��                  0    0    address_address_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('mydb.address_address_id_seq', 5, true);
          mydb          postgres    false    223                       0    0    brand_of_vehicle_brand_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('mydb.brand_of_vehicle_brand_id_seq', 5, true);
          mydb          postgres    false    225                       0    0    car_car_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('mydb.car_car_id_seq', 5, true);
          mydb          postgres    false    234                       0    0    city_city_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('mydb.city_city_id_seq', 6, true);
          mydb          postgres    false    221                       0    0    color_of_vehicle_color_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('mydb.color_of_vehicle_color_id_seq', 5, true);
          mydb          postgres    false    248                       0    0    country_country_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('mydb.country_country_id_seq', 5, true);
          mydb          postgres    false    219                       0    0 (   customer_contact_customer_contact_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('mydb.customer_contact_customer_contact_id_seq', 50, true);
          mydb          postgres    false    236                       0    0    customer_customer_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('mydb.customer_customer_id_seq', 52, true);
          mydb          postgres    false    217                       0    0    expired_car_expired_car_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('mydb.expired_car_expired_car_id_seq', 1, true);
          mydb          postgres    false    250                        0    0    fuel_type_fuel_type_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('mydb.fuel_type_fuel_type_id_seq', 5, true);
          mydb          postgres    false    229            !           0    0    payment_payment_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('mydb.payment_payment_id_seq', 8, true);
          mydb          postgres    false    238            "           0    0    rental_rental_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('mydb.rental_rental_id_seq', 11, true);
          mydb          postgres    false    227            #           0    0    staff_staff_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('mydb.staff_staff_id_seq', 6, true);
          mydb          postgres    false    240            $           0    0    staff_store_rental_shop_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('mydb.staff_store_rental_shop_id_seq', 5, true);
          mydb          postgres    false    244            %           0    0    store_store_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('mydb.store_store_id_seq', 5, true);
          mydb          postgres    false    242            &           0    0    street_street_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('mydb.street_street_id_seq', 5, true);
          mydb          postgres    false    246            '           0    0 #   type_of_vehicle_vehicle_type_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('mydb.type_of_vehicle_vehicle_type_id_seq', 5, true);
          mydb          postgres    false    231                       2606    19677    address address_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY mydb.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);
 <   ALTER TABLE ONLY mydb.address DROP CONSTRAINT address_pkey;
       mydb            postgres    false    224                       2606    19694 &   brand_of_vehicle brand_of_vehicle_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY mydb.brand_of_vehicle
    ADD CONSTRAINT brand_of_vehicle_pkey PRIMARY KEY (brand_id);
 N   ALTER TABLE ONLY mydb.brand_of_vehicle DROP CONSTRAINT brand_of_vehicle_pkey;
       mydb            postgres    false    226                       2606    19759    car car_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY mydb.car
    ADD CONSTRAINT car_pkey PRIMARY KEY (car_id);
 4   ALTER TABLE ONLY mydb.car DROP CONSTRAINT car_pkey;
       mydb            postgres    false    235                       2606    19653    city city_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY mydb.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);
 6   ALTER TABLE ONLY mydb.city DROP CONSTRAINT city_pkey;
       mydb            postgres    false    222            +           2606    19856 &   color_of_vehicle color_of_vehicle_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY mydb.color_of_vehicle
    ADD CONSTRAINT color_of_vehicle_pkey PRIMARY KEY (color_id);
 N   ALTER TABLE ONLY mydb.color_of_vehicle DROP CONSTRAINT color_of_vehicle_pkey;
       mydb            postgres    false    249                       2606    19646    country country_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY mydb.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);
 <   ALTER TABLE ONLY mydb.country DROP CONSTRAINT country_pkey;
       mydb            postgres    false    220                       2606    19776 &   customer_contact customer_contact_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY mydb.customer_contact
    ADD CONSTRAINT customer_contact_pkey PRIMARY KEY (customer_contact_id);
 N   ALTER TABLE ONLY mydb.customer_contact DROP CONSTRAINT customer_contact_pkey;
       mydb            postgres    false    237            
           2606    19639    customer customer_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY mydb.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);
 >   ALTER TABLE ONLY mydb.customer DROP CONSTRAINT customer_pkey;
       mydb            postgres    false    218            -           2606    21202 "   dummy_customer dummy_customer_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY mydb.dummy_customer
    ADD CONSTRAINT dummy_customer_pkey PRIMARY KEY (username);
 J   ALTER TABLE ONLY mydb.dummy_customer DROP CONSTRAINT dummy_customer_pkey;
       mydb            postgres    false    255                       2606    19720    fuel_type fuel_type_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY mydb.fuel_type
    ADD CONSTRAINT fuel_type_pkey PRIMARY KEY (fuel_type_id);
 @   ALTER TABLE ONLY mydb.fuel_type DROP CONSTRAINT fuel_type_pkey;
       mydb            postgres    false    230            !           2606    19788    payment payment_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY mydb.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);
 <   ALTER TABLE ONLY mydb.payment DROP CONSTRAINT payment_pkey;
       mydb            postgres    false    239                       2606    19701    rental rental_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY mydb.rental
    ADD CONSTRAINT rental_pkey PRIMARY KEY (rental_id);
 :   ALTER TABLE ONLY mydb.rental DROP CONSTRAINT rental_pkey;
       mydb            postgres    false    228                       2606    19732    rented_car rented_car_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY mydb.rented_car
    ADD CONSTRAINT rented_car_pkey PRIMARY KEY (rented_car_id_vin_number_);
 B   ALTER TABLE ONLY mydb.rented_car DROP CONSTRAINT rented_car_pkey;
       mydb            postgres    false    233            #           2606    19800    staff staff_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY mydb.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);
 8   ALTER TABLE ONLY mydb.staff DROP CONSTRAINT staff_pkey;
       mydb            postgres    false    241            '           2606    19814    staff_store staff_store_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY mydb.staff_store
    ADD CONSTRAINT staff_store_pkey PRIMARY KEY (rental_shop_id);
 D   ALTER TABLE ONLY mydb.staff_store DROP CONSTRAINT staff_store_pkey;
       mydb            postgres    false    245            %           2606    19807    store store_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY mydb.store
    ADD CONSTRAINT store_pkey PRIMARY KEY (store_id);
 8   ALTER TABLE ONLY mydb.store DROP CONSTRAINT store_pkey;
       mydb            postgres    false    243            )           2606    19836    street street_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY mydb.street
    ADD CONSTRAINT street_pkey PRIMARY KEY (street_id);
 :   ALTER TABLE ONLY mydb.street DROP CONSTRAINT street_pkey;
       mydb            postgres    false    247                       2606    19727 $   type_of_vehicle type_of_vehicle_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY mydb.type_of_vehicle
    ADD CONSTRAINT type_of_vehicle_pkey PRIMARY KEY (vehicle_type_id);
 L   ALTER TABLE ONLY mydb.type_of_vehicle DROP CONSTRAINT type_of_vehicle_pkey;
       mydb            postgres    false    232                       1259    19974    idx_payment_detail    INDEX     T   CREATE INDEX idx_payment_detail ON mydb.payment USING btree (amount, payment_date);
 $   DROP INDEX mydb.idx_payment_detail;
       mydb            postgres    false    239    239            <           2620    19952    customer after_trigger    TRIGGER     x   CREATE TRIGGER after_trigger AFTER INSERT ON mydb.customer FOR EACH STATEMENT EXECUTE FUNCTION mydb.attention_notice();
 -   DROP TRIGGER after_trigger ON mydb.customer;
       mydb          postgres    false    218    272            =           2620    19976    customer after_triggers    TRIGGER     y   CREATE TRIGGER after_triggers AFTER INSERT ON mydb.customer FOR EACH STATEMENT EXECUTE FUNCTION mydb.attention_notice();
 .   DROP TRIGGER after_triggers ON mydb.customer;
       mydb          postgres    false    218    272            /           2606    19678    address fk_address_customer1    FK CONSTRAINT     �   ALTER TABLE ONLY mydb.address
    ADD CONSTRAINT fk_address_customer1 FOREIGN KEY (customer_id) REFERENCES mydb.customer(customer_id);
 D   ALTER TABLE ONLY mydb.address DROP CONSTRAINT fk_address_customer1;
       mydb          postgres    false    224    3338    218            4           2606    19760    car fk_car_rental1    FK CONSTRAINT     w   ALTER TABLE ONLY mydb.car
    ADD CONSTRAINT fk_car_rental1 FOREIGN KEY (rental_id) REFERENCES mydb.rental(rental_id);
 :   ALTER TABLE ONLY mydb.car DROP CONSTRAINT fk_car_rental1;
       mydb          postgres    false    3348    235    228            5           2606    19765    car fk_car_rented_car1    FK CONSTRAINT     �   ALTER TABLE ONLY mydb.car
    ADD CONSTRAINT fk_car_rented_car1 FOREIGN KEY (rented_car_id) REFERENCES mydb.rented_car(rented_car_id_vin_number_);
 >   ALTER TABLE ONLY mydb.car DROP CONSTRAINT fk_car_rented_car1;
       mydb          postgres    false    235    233    3354            .           2606    19654    city fk_city_country1    FK CONSTRAINT     }   ALTER TABLE ONLY mydb.city
    ADD CONSTRAINT fk_city_country1 FOREIGN KEY (country_id) REFERENCES mydb.country(country_id);
 =   ALTER TABLE ONLY mydb.city DROP CONSTRAINT fk_city_country1;
       mydb          postgres    false    220    3340    222            6           2606    20059 .   customer_contact fk_customer_contact_customer1    FK CONSTRAINT     �   ALTER TABLE ONLY mydb.customer_contact
    ADD CONSTRAINT fk_customer_contact_customer1 FOREIGN KEY (customer_id) REFERENCES mydb.customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY mydb.customer_contact DROP CONSTRAINT fk_customer_contact_customer1;
       mydb          postgres    false    237    3338    218            7           2606    20064    payment fk_payment_rental1    FK CONSTRAINT     �   ALTER TABLE ONLY mydb.payment
    ADD CONSTRAINT fk_payment_rental1 FOREIGN KEY (rental_id) REFERENCES mydb.rental(rental_id) ON DELETE CASCADE;
 B   ALTER TABLE ONLY mydb.payment DROP CONSTRAINT fk_payment_rental1;
       mydb          postgres    false    228    239    3348            0           2606    19702    rental fk_rental_customer1    FK CONSTRAINT     �   ALTER TABLE ONLY mydb.rental
    ADD CONSTRAINT fk_rental_customer1 FOREIGN KEY (customer_id) REFERENCES mydb.customer(customer_id);
 B   ALTER TABLE ONLY mydb.rental DROP CONSTRAINT fk_rental_customer1;
       mydb          postgres    false    228    3338    218            1           2606    19733 *   rented_car fk_rented_car_brand_of_vehicle1    FK CONSTRAINT     �   ALTER TABLE ONLY mydb.rented_car
    ADD CONSTRAINT fk_rented_car_brand_of_vehicle1 FOREIGN KEY (brand_name_id) REFERENCES mydb.brand_of_vehicle(brand_id);
 R   ALTER TABLE ONLY mydb.rented_car DROP CONSTRAINT fk_rented_car_brand_of_vehicle1;
       mydb          postgres    false    233    3346    226            2           2606    19743 #   rented_car fk_rented_car_fuel_type1    FK CONSTRAINT     �   ALTER TABLE ONLY mydb.rented_car
    ADD CONSTRAINT fk_rented_car_fuel_type1 FOREIGN KEY (fuel_type_id) REFERENCES mydb.fuel_type(fuel_type_id);
 K   ALTER TABLE ONLY mydb.rented_car DROP CONSTRAINT fk_rented_car_fuel_type1;
       mydb          postgres    false    233    3350    230            3           2606    19748 )   rented_car fk_rented_car_type_of_vehicle1    FK CONSTRAINT     �   ALTER TABLE ONLY mydb.rented_car
    ADD CONSTRAINT fk_rented_car_type_of_vehicle1 FOREIGN KEY (vehicle_type_id) REFERENCES mydb.type_of_vehicle(vehicle_type_id);
 Q   ALTER TABLE ONLY mydb.rented_car DROP CONSTRAINT fk_rented_car_type_of_vehicle1;
       mydb          postgres    false    232    3352    233            8           2606    19815 "   staff_store fk_staff_store_rental1    FK CONSTRAINT     �   ALTER TABLE ONLY mydb.staff_store
    ADD CONSTRAINT fk_staff_store_rental1 FOREIGN KEY (rental_id) REFERENCES mydb.rental(rental_id);
 J   ALTER TABLE ONLY mydb.staff_store DROP CONSTRAINT fk_staff_store_rental1;
       mydb          postgres    false    3348    245    228            9           2606    19820 !   staff_store fk_staff_store_staff1    FK CONSTRAINT     �   ALTER TABLE ONLY mydb.staff_store
    ADD CONSTRAINT fk_staff_store_staff1 FOREIGN KEY (staff_id) REFERENCES mydb.staff(staff_id);
 I   ALTER TABLE ONLY mydb.staff_store DROP CONSTRAINT fk_staff_store_staff1;
       mydb          postgres    false    241    245    3363            :           2606    19825 !   staff_store fk_staff_store_store1    FK CONSTRAINT     �   ALTER TABLE ONLY mydb.staff_store
    ADD CONSTRAINT fk_staff_store_store1 FOREIGN KEY (store_id) REFERENCES mydb.store(store_id);
 I   ALTER TABLE ONLY mydb.staff_store DROP CONSTRAINT fk_staff_store_store1;
       mydb          postgres    false    245    243    3365            ;           2606    19837    street fk_street_city1    FK CONSTRAINT     u   ALTER TABLE ONLY mydb.street
    ADD CONSTRAINT fk_street_city1 FOREIGN KEY (city_id) REFERENCES mydb.city(city_id);
 >   ALTER TABLE ONLY mydb.street DROP CONSTRAINT fk_street_city1;
       mydb          postgres    false    3342    247    222            �           0    19987    customer_materialized_view    MATERIALIZED VIEW DATA     ;   REFRESH MATERIALIZED VIEW mydb.customer_materialized_view;
          mydb          postgres    false    252    3573            �   '   x�3�4�4�2�4�4�2��\&@Ҙ˔������ Lg5      �   3   x�3�t�t�2���wq�2��u��&�.�Ξ�\��!���!�\1z\\\ �L	<      �   c   x��9�0 �ZzLƺ,�4"1�����#��\R5����,�12�c�3�+>4�ŁQ���2%&���	��j�s�l�]�A����uZ�o#�=�烈Z��      �   o   x�3�N�S�,�L)�WHIU�)�I-�4147�4�2I��+���&sZqqs��drZy&��E�y�
.�Y�@Q3CN.SN�ʔ���8��L9M�b���� ��      �   3   x�3��M,-�2�t.��-���2�(MN�2�t�)M�2��������� �"      �   ?   x�3�t*J����2��/*)MO��2��,J�I�K�2�t+J�KN�2���/K��L����� �      �     x�]V�v�H}�|�y���D�G�&�I�$����@s�M�h�o�[�Ǧm%�r��l�U�kW�`�0�P�BV@�aY����2�\Pvfʪ�,�.�����	����y��}�kt!O�pz���9��r�@ե�횟e	�	�A��!y}E��r �4n��Ck��=xx�80$�̸W^���&�m���a��٘>�(X%>�E��{��G��+́�������.̹���a�U�T\���b������۟���؅^N��e�
Y!�xW؅��<lW�i�H�V��KQ�F4�*n7��~&���<$�f��+��Q���DD��3�G�����O;E�q����Ɍ3��Y�!V�����,�i�`2?�E"H~/%�\���?ȃ%7�f��̱f���g!���GˆT(,���j洕B�
�Ɋ2�QP �����q�~�֔�e[ZH~ľi��"�+��Z��u���	�2�zW��٨j8�W8��ޜ��_/���ola�4�YF��(E2�����H�$�.<���	����<�T�KR�'0kn���J���y�S5@S"2~��OWI:�/h
�.4�K��&�x"��|~����F���a��};�cMG�P!ᕔR�L�t���41�4��:O%C��`ʣ(���&�k0�k�[�5�Ƈ=��1��b�](ļ���t����aJ	�z�I�gI����a����s��ﱂf9���
��,A��w�`OzT7�ٛ�z4��Wt��@�	��)Zl���/�]��?��L�\�+C��T���ht��5�J�u����ڳ�m<��/�2o�M�_�|I�7�(~�^Y-C5?@ž�2�����kP�r\Ň��r�?PJ�,��ӦpZ�5X������]i�=����	&��]4�<B4L}γ�b~���M�
e���i����O�|��ڍ�o��0�cUD|��:�?�/�7��
���׆�
�]��ʱ>�-C�h?��
J�KW����90 R$�c#x����՗W����2�=)5����SdX����y�1��}��~.4хM�r��A�g��dtAq7l���<3��V��|a���,�)Fa��Q�U�t�"=�����1ǝ�s��Pa�������vʒ=.�-'��v�u��E|r�N�v6�l��G�M�-�^�B"�;�uF���zu^u?4����
�i���A'i�LSƤ�7�mÆ�V��B6F�U�@��8Z��:?jb��	SnڐLҠ1O�=�gnKs���~R�ꀁ�핢�Ŗ��0����2����[a;0ʎ�oa�+�g���O�ₚvێsX&q���l}�J~D�ďj��`����~[�cwչM�n��^ �P.f�0߻��C�4(A��p�k�5��Pg�8�x�����&�pyN
X����B���A�=��W�i钶-܉x\� ���Ƽ.\u8��[z�+��\G%�j ^^�mw��P,��F9�����8r����/�L(�b��H(֟��+�>�      �   �  x�mU˖�8\+�B~���28;�@��_?����fN�9�Ȓ�Jb���0�k��m~ʭ{ƴ���:���U��nX+�%�%NG�a��ϵA�:�5Z�FH�iY�0F_֜F�f_�|�a<.��A����h�h��8�%����OvԑRm�[�0ۑ�aYB����Dm�'P>�m:k�Vv����0���>�uM��T���Q�h��>eە��kۏ�IgBC�,Gx�e]K��S�n[�>Q�,qm�4jT��G\֣�6��X�>�-���k	����R�a��6c�ֽ>�q� %@���`��4/�+���X���g$'@3�IXm)��O�����_B��0A�!�7�t��i�%/c��y(G�3�$@w]#Y[_gt�e����˔��=~��� �l�ԍ��ޗ!�1��^:('�`��V�Q
ӌ��B�nn[�	8�4��h� ��[N���6Lv��3Tfy��[M�˯O4������p�?/��)�(j���c]�4mѽ�|��/��!��jVQ�����]���u8���Ja��e�C����}Z��i:�p<j�m�?C�ŭ1�}�>]��u҅������BS?-P��n�KNgRI�F3��4ğG���Or[���ts�O��L�P�ma5Q��a����0Ӭմ��p�)�a�1N'=\C��GZٴFK�_�AL�_���ǎ�o��(d���w����8ǸhJ�Y����a)K9�1Z��i��/qsi�j�hBjd�5Z���f�	�ݔ�kZ.�S ��ǻJJ��m��s8\��tv#8�K����S��:ކ��ه��dZ�CyZI�0�t��^n��!	`-kjR
�߰���˷{_����HBRmx�	�r�Vo�����P��FJT�`���w�?.�Xu� 
� ���F�G�d��(�f��Xb<��������	���q�8��^�ٞ�n��Ĕw�C���/�%�K�m��==���̄��<����K�B!n�a۱msb҅���HN��
����㶿Y�j��#��ӂ �������,��0��p���fʽ=�w݌�`:,:�5�ã[�G���X�AT��[Yvp�R�*�ѕ���mg������6��*�	(�*��5���f�
	|n/(5ڂ��|./��Y��9$Pep���u�{,~�;?��7���%֫`��mGe�o͑.|V�y]a �#ܮʐҸL�3$96��cs����r�WkRP      �      x������ � �      �      x�3����KI�44261Ef�\1z\\\ qZJ      �   5   x�3�t�tv��2��t
�t�2�tw�2��	p�2�t�qu	������ ��	K      �   I   x�E̱�0�Z����]��I�_| +���M������Ums����|s���_�l,�y��/P��      �   �   x�eP�
�0<o����#���Z��ЃX�����݂l�a2;FfG�8} Gt��	k��H$��O�;��z6�B�����x����R��LK���䰮��8ó�kLg������61���{��ChO؍�~��I3x0��9hu����8�﹛���x�H���b�}�لX���0�����i��cKe      �     x�MTˎ�8<�?f �$�()���1�t�� s������Ҳ�i��\$�X4�!��� �h$rp��~��GZ�)�>	k�b �^0P��:2��I1D������T&�#��=F��������,�{G���4��G�9"Vj,ٙ2η�<�4�Ccn���s+�\9��8��P]JMub{ŉz�dlb�i�B�k��O�U6�+��+!�K$"?{b�/��fڋ�۾b=o�$�id�i�gzq1)�#ߋ�n������p��7���!����h�����E(O��b��Yo�٘_Ɣz�N�x��ieˀe�abE�{پl:�2Rc�K &l;���I�b}r��e��_c���r�H�x�ɓ��;�������*�l���8ƈ�;��o�4`B�'��)�m�K�l:}����������c���V��ː����B���>^?�l�8�@�[��z��E�=wN�o�3�s�\=8�V��$5�)����Nx��r)PV/��~Dؗ�֩�AR�N{�_R���,<3P =��K{�S�s���U�B����⊭��%>6ۻ	����:��1��t���P)iC=9����y<&7d+Ov��~KY�����\�g��B�LR$�4Bfs���~�����_���(6P �OP��@e,9;%׬����s�+S�I絞��8�$���L=}x�cA�
n���cC��m�xx���{��c>�$,��w��p�,\jG�)�@CÞ�dÛ �"ɰ߿>>>���,n      �   �   x�5��n�0Cg�c���YN��4c�+�B���T����1��$Avx/���ޞ����8ɭ.�W�rD�z|d��������L�,����z5`��Mx�yc�{�7m�4/�17[v�����?5����ՄO*��#�习�9�{����I���#գm����a%�#I8�&���R�;<O�      �   $   x�3�4A.#N0�2�C.N0�2�C�=... {G^      �   /   x�3�LN,JIM�I-���2B��q#q}�L�eC�LQec���� �.      �   ]   x�˱� ���N`�d c�,,llH � @��v�y
w�U`�P����C����341� -	,+����t�U��!��wX,=3}I\B      �   0   x�3��
�2�tvt
���2��ru�2�vuq��2����qqq �	�     