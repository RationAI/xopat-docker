--
-- PostgreSQL database dump
-- Delete. public schema definition and adjustments (always exists)
-- Delete. LOCALE_PROVIDER = libc
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2

-- Started on 2023-03-11 09:08:06

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
-- TOC entry 3395 (class 1262 OID 16384)
-- Name: postgresDB; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "postgresDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE "postgresDB" OWNER TO postgres;

\connect "postgresDB"

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
-- TOC entry 219 (class 1259 OID 16427)
-- Name: access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.access (
    user_id integer NOT NULL,
    root character varying(255) NOT NULL
);


ALTER TABLE public.access OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16409)
-- Name: auth; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth (
    user_id integer NOT NULL,
    type character varying(63) NOT NULL,
    type_id character varying(63) NOT NULL,
    secret character varying(255)
);


ALTER TABLE public.auth OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16396)
-- Name: file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    request_id integer,
    created timestamp without time zone
);


ALTER TABLE public.file OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16395)
-- Name: file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_id_seq OWNER TO postgres;

--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 214
-- Name: file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.file_id_seq OWNED BY public.file.id;


--
-- TOC entry 226 (class 1259 OID 24577)
-- Name: file_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file_stats (
    file_id integer NOT NULL,
    status character varying(63)
);


ALTER TABLE public.file_stats OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16436)
-- Name: seen_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seen_files (
    user_id integer NOT NULL,
    file_id integer NOT NULL
);


ALTER TABLE public.seen_files OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16413)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(63) UNIQUE NOT NULL,
    email character varying(255) UNIQUE,
    created timestamp with time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16412)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 225 (class 1259 OID 16508)
-- Name: xopat_annotation_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.xopat_annotation_data (
    id integer NOT NULL,
    annotation_id integer NOT NULL,
    tstamp timestamp without time zone NOT NULL,
    data text
);


ALTER TABLE public.xopat_annotation_data OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16507)
-- Name: xopat_annotation_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.xopat_annotation_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.xopat_annotation_data_id_seq OWNER TO postgres;

--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 224
-- Name: xopat_annotation_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.xopat_annotation_data_id_seq OWNED BY public.xopat_annotation_data.id;


--
-- TOC entry 223 (class 1259 OID 16481)
-- Name: xopat_annotations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.xopat_annotations (
    id integer NOT NULL,
    author_user_id integer,
    file_id integer
);


ALTER TABLE public.xopat_annotations OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16480)
-- Name: xopat_annotations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.xopat_annotations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.xopat_annotations_id_seq OWNER TO postgres;

--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 222
-- Name: xopat_annotations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.xopat_annotations_id_seq OWNED BY public.xopat_annotations.id;


--
-- TOC entry 221 (class 1259 OID 16457)
-- Name: xopat_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.xopat_session (
    user_id integer NOT NULL,
    file_id integer NOT NULL,
    session text
);


ALTER TABLE public.xopat_session OWNER TO postgres;

--
-- TOC entry 3211 (class 2604 OID 16399)
-- Name: file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file ALTER COLUMN id SET DEFAULT nextval('public.file_id_seq'::regclass);


--
-- TOC entry 3212 (class 2604 OID 16416)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3214 (class 2604 OID 16511)
-- Name: xopat_annotation_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotation_data ALTER COLUMN id SET DEFAULT nextval('public.xopat_annotation_data_id_seq'::regclass);


--
-- TOC entry 3213 (class 2604 OID 16484)
-- Name: xopat_annotations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotations ALTER COLUMN id SET DEFAULT nextval('public.xopat_annotations_id_seq'::regclass);


--
-- TOC entry 3218 (class 2606 OID 16426)
-- Name: auth access_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT access_pkey PRIMARY KEY (user_id, type_id);


--
-- TOC entry 3216 (class 2606 OID 16401)
-- Name: file file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_pkey PRIMARY KEY (id);


--
-- TOC entry 3221 (class 2606 OID 16418)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3236 (class 2606 OID 16515)
-- Name: xopat_annotation_data xopat_annotation_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotation_data
    ADD CONSTRAINT xopat_annotation_data_pkey PRIMARY KEY (id);


--
-- TOC entry 3233 (class 2606 OID 16506)
-- Name: xopat_annotations xopat_annotations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotations
    ADD CONSTRAINT xopat_annotations_pkey PRIMARY KEY (id);


--
-- TOC entry 3219 (class 1259 OID 16424)
-- Name: fki_R; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_R" ON public.auth USING btree (user_id);


--
-- TOC entry 3222 (class 1259 OID 16435)
-- Name: fki_aci; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_aci ON public.access USING btree (user_id);


--
-- TOC entry 3229 (class 1259 OID 16498)
-- Name: fki_aif; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_aif ON public.xopat_annotations USING btree (file_id);


--
-- TOC entry 3230 (class 1259 OID 16504)
-- Name: fki_ais; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_ais ON public.xopat_annotations USING btree (author_user_id);


--
-- TOC entry 3231 (class 1259 OID 16492)
-- Name: fki_aiu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_aiu ON public.xopat_annotations USING btree (author_user_id);


--
-- TOC entry 3223 (class 1259 OID 16456)
-- Name: fki_fci; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fci ON public.access USING btree (user_id);


--
-- TOC entry 3226 (class 1259 OID 16479)
-- Name: fki_fsi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fsi ON public.xopat_session USING btree (file_id);


--
-- TOC entry 3237 (class 1259 OID 24585)
-- Name: fki_fsin; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fsin ON public.file_stats USING btree (file_id);


--
-- TOC entry 3224 (class 1259 OID 16444)
-- Name: fki_inf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_inf ON public.seen_files USING btree (file_id);


--
-- TOC entry 3225 (class 1259 OID 16450)
-- Name: fki_uin; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_uin ON public.seen_files USING btree (user_id);


--
-- TOC entry 3227 (class 1259 OID 16473)
-- Name: fki_usi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_usi ON public.xopat_session USING btree (user_id);


--
-- TOC entry 3234 (class 1259 OID 16521)
-- Name: fki_x; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_x ON public.xopat_annotation_data USING btree (annotation_id);


--
-- TOC entry 3228 (class 1259 OID 16467)
-- Name: user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "user" ON public.xopat_session USING btree (user_id);


--
-- TOC entry 3238 (class 2606 OID 16419)
-- Name: auth access_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT access_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3246 (class 2606 OID 16516)
-- Name: xopat_annotation_data aia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotation_data
    ADD CONSTRAINT aia FOREIGN KEY (annotation_id) REFERENCES public.xopat_annotations(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3244 (class 2606 OID 16493)
-- Name: xopat_annotations aif; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotations
    ADD CONSTRAINT aif FOREIGN KEY (file_id) REFERENCES public.file(id) NOT VALID;


--
-- TOC entry 3245 (class 2606 OID 16487)
-- Name: xopat_annotations aiu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotations
    ADD CONSTRAINT aiu FOREIGN KEY (author_user_id) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 3239 (class 2606 OID 16451)
-- Name: access fci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access
    ADD CONSTRAINT fci FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3242 (class 2606 OID 16474)
-- Name: xopat_session fsi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_session
    ADD CONSTRAINT fsi FOREIGN KEY (file_id) REFERENCES public.file(id) NOT VALID;


--
-- TOC entry 3247 (class 2606 OID 24580)
-- Name: file_stats fsin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_stats
    ADD CONSTRAINT fsin FOREIGN KEY (file_id) REFERENCES public.file(id) NOT VALID;


--
-- TOC entry 3240 (class 2606 OID 16439)
-- Name: seen_files inf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seen_files
    ADD CONSTRAINT inf FOREIGN KEY (file_id) REFERENCES public.file(id) NOT VALID;


--
-- TOC entry 3241 (class 2606 OID 16445)
-- Name: seen_files uin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seen_files
    ADD CONSTRAINT uin FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 3243 (class 2606 OID 16468)
-- Name: xopat_session usi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_session
    ADD CONSTRAINT usi FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;


-- Completed on 2023-03-11 09:08:06

--
-- PostgreSQL database dump complete
--

