--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: fleet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.fleet (
    fleet_id integer NOT NULL,
    name character varying(50),
    species character varying(30),
    is_federation boolean NOT NULL,
    description character varying(75) NOT NULL
);


ALTER TABLE public.fleet OWNER TO freecodecamp;

--
-- Name: fleet_fleet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.fleet_fleet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fleet_fleet_id_seq OWNER TO freecodecamp;

--
-- Name: fleet_fleet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.fleet_fleet_id_seq OWNED BY public.fleet.fleet_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30),
    size numeric(6,1),
    has_blackhole boolean DEFAULT true NOT NULL,
    description character varying(100)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    weight integer,
    circumfrance integer,
    planet_id integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text,
    is_gas boolean,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    is_supernova boolean,
    galaxy_id integer,
    description character varying(100)
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: fleet fleet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.fleet ALTER COLUMN fleet_id SET DEFAULT nextval('public.fleet_fleet_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: fleet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.fleet VALUES (1, 'Starfleet', 'Human', true, 'Bolding going where few have gone before');
INSERT INTO public.fleet VALUES (2, 'Romulus Grand Deep Space Fleet', 'Romulans', false, 'The distant and violent cousins to Vulcans');
INSERT INTO public.fleet VALUES (3, 'Prayerfleet', 'Bajoran', true, 'Serving the prophets of the wormhole');


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Andromeda', 535.3, true, 'Our nearest cousins');
INSERT INTO public.galaxy VALUES (2, 'Pinhole Galaxy', 135.3, false, 'Named for its shape');
INSERT INTO public.galaxy VALUES (4, 'Whirlpool Galaxy', 235.3, false, 'Named for its exotic shape');
INSERT INTO public.galaxy VALUES (5, 'Blackeye Galaxy', 335.3, false, 'Someone taught this galaxy a lesson');
INSERT INTO public.galaxy VALUES (6, 'cigar galaxy', 242.0, true, NULL);
INSERT INTO public.galaxy VALUES (7, 'cartwheel galaxy', 342.0, true, NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Lunalopis', 135, 314, 1);
INSERT INTO public.moon VALUES (2, 'Keigler 2353', NULL, NULL, 9);
INSERT INTO public.moon VALUES (3, 'Keigler 2354', NULL, NULL, 9);
INSERT INTO public.moon VALUES (4, 'Keigler 2355', NULL, NULL, 9);
INSERT INTO public.moon VALUES (5, 'Keigler 2356', NULL, NULL, 9);
INSERT INTO public.moon VALUES (6, 'Keigler 2357', NULL, NULL, 9);
INSERT INTO public.moon VALUES (7, 'Keigler 2358', NULL, NULL, 9);
INSERT INTO public.moon VALUES (8, 'Keigler 2359', NULL, NULL, 9);
INSERT INTO public.moon VALUES (9, 'Keigler 2360', NULL, NULL, 9);
INSERT INTO public.moon VALUES (10, 'Keigler 2361', NULL, NULL, 9);
INSERT INTO public.moon VALUES (11, 'Keigler 2362', NULL, NULL, 9);
INSERT INTO public.moon VALUES (12, 'Keigler 2364', NULL, NULL, 9);
INSERT INTO public.moon VALUES (13, 'Keigler 2365', NULL, NULL, 9);
INSERT INTO public.moon VALUES (14, 'Keigler 2366', NULL, NULL, 9);
INSERT INTO public.moon VALUES (15, 'Keigler 2369', NULL, NULL, 9);
INSERT INTO public.moon VALUES (16, 'Keigler 2469', NULL, NULL, 9);
INSERT INTO public.moon VALUES (17, 'Keigler 2470', NULL, NULL, 9);
INSERT INTO public.moon VALUES (18, 'Keigler 2471', NULL, NULL, 9);
INSERT INTO public.moon VALUES (19, 'Keigler 2472', NULL, NULL, 9);
INSERT INTO public.moon VALUES (20, 'Keigler 2473', NULL, NULL, 9);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Percei 8', 'The home planet of Gingis', false, 1);
INSERT INTO public.planet VALUES (3, 'ReverseEarth', NULL, NULL, 1);
INSERT INTO public.planet VALUES (4, 'Orio Prime', NULL, NULL, 2);
INSERT INTO public.planet VALUES (5, 'Orio II', NULL, NULL, 2);
INSERT INTO public.planet VALUES (6, 'Orio III', NULL, NULL, 2);
INSERT INTO public.planet VALUES (7, 'Orio IV', NULL, NULL, 2);
INSERT INTO public.planet VALUES (8, 'Orio V', NULL, NULL, 2);
INSERT INTO public.planet VALUES (9, 'Keigler Prime', NULL, NULL, 5);
INSERT INTO public.planet VALUES (10, 'Keigler II', NULL, NULL, 5);
INSERT INTO public.planet VALUES (11, 'Keigler IV', NULL, NULL, 5);
INSERT INTO public.planet VALUES (12, 'Keigler V', NULL, NULL, 5);
INSERT INTO public.planet VALUES (13, 'Keigler VI', NULL, NULL, 5);
INSERT INTO public.planet VALUES (14, 'Keigler VII', NULL, NULL, 5);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Echochon 9', false, 1, NULL);
INSERT INTO public.star VALUES (2, 'Percei 9', true, 2, NULL);
INSERT INTO public.star VALUES (4, 'Orion Prime', true, 4, NULL);
INSERT INTO public.star VALUES (5, 'Keigler 5', true, 4, NULL);
INSERT INTO public.star VALUES (6, 'Cyrlon', true, 6, NULL);
INSERT INTO public.star VALUES (7, 'Krypton', true, 6, NULL);


--
-- Name: fleet_fleet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.fleet_fleet_id_seq', 3, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 5, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 14, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 7, true);


--
-- Name: fleet fleet_description_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.fleet
    ADD CONSTRAINT fleet_description_key UNIQUE (description);


--
-- Name: fleet fleet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.fleet
    ADD CONSTRAINT fleet_name_key UNIQUE (name);


--
-- Name: fleet fleet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.fleet
    ADD CONSTRAINT fleet_pkey PRIMARY KEY (fleet_id);


--
-- Name: galaxy galaxy_description_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_description_key UNIQUE (description);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_description_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_description_key UNIQUE (description);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon unique_name; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT unique_name UNIQUE (name);


--
-- Name: planet unique_planet_desc; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT unique_planet_desc UNIQUE (description);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

