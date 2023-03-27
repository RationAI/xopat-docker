--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 15.2

-- Started on 2023-03-25 16:23:03

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
-- TOC entry 3390 (class 1262 OID 16384)
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

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 16385)
-- Name: access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.access (
    user_id integer NOT NULL,
    root character varying(255) NOT NULL
);


ALTER TABLE public.access OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16388)
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
-- TOC entry 211 (class 1259 OID 16391)
-- Name: file_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file_events (
    file_id integer NOT NULL,
    event character varying(63),
    data text,
    tstamp timestamp without time zone
);


ALTER TABLE public.file_events OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16396)
-- Name: files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.files (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created timestamp without time zone,
    status character varying(31),
    root character varying(255),
    biopsy character varying(32)
);


ALTER TABLE public.files OWNER TO postgres;

--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 212
-- Name: COLUMN files.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.files.status IS 'File processing status. ''uploaded'', ''converted'', ''error''';


--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 212
-- Name: COLUMN files.root; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.files.root IS 'Root path for the file. Biopsy can further define sub-directories relative to root.';


--
-- TOC entry 213 (class 1259 OID 16401)
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
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 213
-- Name: file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.file_id_seq OWNED BY public.files.id;


--
-- TOC entry 214 (class 1259 OID 16402)
-- Name: seen_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seen_files (
    user_id integer NOT NULL,
    file_id integer NOT NULL
);


ALTER TABLE public.seen_files OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16405)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(63) NOT NULL,
    email character varying(255),
    created timestamp with time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16408)
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
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 217 (class 1259 OID 16409)
-- Name: xopat_annotation_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.xopat_annotation_data (
    id integer NOT NULL,
    annotation_id integer NOT NULL,
    tstamp timestamp without time zone NOT NULL,
    data text,
    format character varying(16),
    version character varying(16)
);


ALTER TABLE public.xopat_annotation_data OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16414)
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
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 218
-- Name: xopat_annotation_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.xopat_annotation_data_id_seq OWNED BY public.xopat_annotation_data.id;


--
-- TOC entry 219 (class 1259 OID 16415)
-- Name: xopat_annotations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.xopat_annotations (
    id integer NOT NULL,
    author_user_id integer,
    file_id integer NOT NULL,
    metadata text
);


ALTER TABLE public.xopat_annotations OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16418)
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
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 220
-- Name: xopat_annotations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.xopat_annotations_id_seq OWNED BY public.xopat_annotations.id;


--
-- TOC entry 221 (class 1259 OID 16419)
-- Name: xopat_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.xopat_session (
    user_id integer NOT NULL,
    file_id integer NOT NULL,
    session text
);


ALTER TABLE public.xopat_session OWNER TO postgres;

--
-- TOC entry 3201 (class 2604 OID 16424)
-- Name: files id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.file_id_seq'::regclass);


--
-- TOC entry 3202 (class 2604 OID 16425)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3203 (class 2604 OID 16426)
-- Name: xopat_annotation_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotation_data ALTER COLUMN id SET DEFAULT nextval('public.xopat_annotation_data_id_seq'::regclass);


--
-- TOC entry 3204 (class 2604 OID 16427)
-- Name: xopat_annotations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotations ALTER COLUMN id SET DEFAULT nextval('public.xopat_annotations_id_seq'::regclass);


--
-- TOC entry 3208 (class 2606 OID 16429)
-- Name: auth access_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT access_pkey PRIMARY KEY (user_id, type_id);


--
-- TOC entry 3212 (class 2606 OID 16431)
-- Name: files file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT file_pkey PRIMARY KEY (id);


--
-- TOC entry 3216 (class 2606 OID 16433)
-- Name: seen_files seen_files_user_id_file_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seen_files
    ADD CONSTRAINT seen_files_user_id_file_id_key UNIQUE (user_id, file_id);


--
-- TOC entry 3234 (class 2606 OID 16513)
-- Name: xopat_session ufuni; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_session
    ADD CONSTRAINT ufuni UNIQUE (user_id, file_id);


--
-- TOC entry 3218 (class 2606 OID 16435)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3220 (class 2606 OID 16437)
-- Name: users users_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- TOC entry 3222 (class 2606 OID 16439)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3225 (class 2606 OID 16441)
-- Name: xopat_annotation_data xopat_annotation_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotation_data
    ADD CONSTRAINT xopat_annotation_data_pkey PRIMARY KEY (id);


--
-- TOC entry 3230 (class 2606 OID 16443)
-- Name: xopat_annotations xopat_annotations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotations
    ADD CONSTRAINT xopat_annotations_pkey PRIMARY KEY (id);


--
-- TOC entry 3209 (class 1259 OID 16444)
-- Name: fki_R; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_R" ON public.auth USING btree (user_id);


--
-- TOC entry 3205 (class 1259 OID 16445)
-- Name: fki_aci; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_aci ON public.access USING btree (user_id);


--
-- TOC entry 3226 (class 1259 OID 16446)
-- Name: fki_aif; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_aif ON public.xopat_annotations USING btree (file_id);


--
-- TOC entry 3227 (class 1259 OID 16447)
-- Name: fki_ais; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_ais ON public.xopat_annotations USING btree (author_user_id);


--
-- TOC entry 3228 (class 1259 OID 16448)
-- Name: fki_aiu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_aiu ON public.xopat_annotations USING btree (author_user_id);


--
-- TOC entry 3206 (class 1259 OID 16449)
-- Name: fki_fci; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fci ON public.access USING btree (user_id);


--
-- TOC entry 3231 (class 1259 OID 16450)
-- Name: fki_fsi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fsi ON public.xopat_session USING btree (file_id);


--
-- TOC entry 3210 (class 1259 OID 16451)
-- Name: fki_fsin; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fsin ON public.file_events USING btree (file_id);


--
-- TOC entry 3213 (class 1259 OID 16452)
-- Name: fki_inf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_inf ON public.seen_files USING btree (file_id);


--
-- TOC entry 3214 (class 1259 OID 16453)
-- Name: fki_uin; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_uin ON public.seen_files USING btree (user_id);


--
-- TOC entry 3232 (class 1259 OID 16454)
-- Name: fki_usi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_usi ON public.xopat_session USING btree (user_id);


--
-- TOC entry 3223 (class 1259 OID 16455)
-- Name: fki_x; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_x ON public.xopat_annotation_data USING btree (annotation_id);


--
-- TOC entry 3235 (class 1259 OID 16456)
-- Name: user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "user" ON public.xopat_session USING btree (user_id);


--
-- TOC entry 3237 (class 2606 OID 16457)
-- Name: auth access_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT access_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3241 (class 2606 OID 16462)
-- Name: xopat_annotation_data aia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotation_data
    ADD CONSTRAINT aia FOREIGN KEY (annotation_id) REFERENCES public.xopat_annotations(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3242 (class 2606 OID 16467)
-- Name: xopat_annotations aif; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotations
    ADD CONSTRAINT aif FOREIGN KEY (file_id) REFERENCES public.files(id) NOT VALID;


--
-- TOC entry 3243 (class 2606 OID 16472)
-- Name: xopat_annotations aiu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_annotations
    ADD CONSTRAINT aiu FOREIGN KEY (author_user_id) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 3236 (class 2606 OID 16477)
-- Name: access fci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access
    ADD CONSTRAINT fci FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3244 (class 2606 OID 16482)
-- Name: xopat_session fsi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_session
    ADD CONSTRAINT fsi FOREIGN KEY (file_id) REFERENCES public.files(id) NOT VALID;


--
-- TOC entry 3238 (class 2606 OID 16487)
-- Name: file_events fsin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_events
    ADD CONSTRAINT fsin FOREIGN KEY (file_id) REFERENCES public.files(id) NOT VALID;


--
-- TOC entry 3239 (class 2606 OID 16492)
-- Name: seen_files inf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seen_files
    ADD CONSTRAINT inf FOREIGN KEY (file_id) REFERENCES public.files(id) NOT VALID;


--
-- TOC entry 3240 (class 2606 OID 16497)
-- Name: seen_files uin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seen_files
    ADD CONSTRAINT uin FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 3245 (class 2606 OID 16502)
-- Name: xopat_session usi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xopat_session
    ADD CONSTRAINT usi FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-03-25 16:23:04

--
-- PostgreSQL database dump complete
--

