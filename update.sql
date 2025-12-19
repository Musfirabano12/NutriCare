--
-- PostgreSQL database dump
--

\restrict eVrBEoUsOJ8ncRZObVJVQumh6AqOcd8DzWRLbyZd6dbN9IJNaHxlV0RcCwHlDZ6

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2025-12-19 20:54:24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 892 (class 1247 OID 17459)
-- Name: activity_level_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.activity_level_enum AS ENUM (
    'Sedentary (little to no exercise)',
    'Lightly Active (light exercise 1-3 days/week)',
    'Moderately Active (moderate exercise 3-5 days/week)',
    'Very Active (hard exercise 6-7 days/week)',
    'Extremely Active (very hard exercise, physical job)',
    'sedentary',
    'lightly_active',
    'moderately_active',
    'very_active',
    'extremely_active'
);


ALTER TYPE public.activity_level_enum OWNER TO postgres;

--
-- TOC entry 895 (class 1247 OID 17470)
-- Name: diabetes_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.diabetes_status_enum AS ENUM (
    'Type 1 Diabetes',
    'Type 2 Diabetes',
    'Pre-diabetes',
    'Gestational Diabetes',
    'No Diabetes',
    'none',
    'type1',
    'type2',
    'prediabetes',
    'gestational'
);


ALTER TYPE public.diabetes_status_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 17321)
-- Name: dietary_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dietary_preferences (
    diet_id integer NOT NULL,
    diet_name text NOT NULL
);


ALTER TABLE public.dietary_preferences OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17320)
-- Name: dietary_preferences_diet_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dietary_preferences_diet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dietary_preferences_diet_id_seq OWNER TO postgres;

--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 223
-- Name: dietary_preferences_diet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dietary_preferences_diet_id_seq OWNED BY public.dietary_preferences.diet_id;


--
-- TOC entry 228 (class 1259 OID 17401)
-- Name: file_storage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file_storage (
    file_id uuid NOT NULL,
    user_id integer,
    filename text NOT NULL,
    mime_type text,
    size_bytes integer,
    storage_type text,
    file_url text,
    file_data text,
    uploaded_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.file_storage OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17308)
-- Name: health_goals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_goals (
    goal_id integer NOT NULL,
    goal_name text NOT NULL
);


ALTER TABLE public.health_goals OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17307)
-- Name: health_goals_goal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.health_goals_goal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.health_goals_goal_id_seq OWNER TO postgres;

--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 221
-- Name: health_goals_goal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.health_goals_goal_id_seq OWNED BY public.health_goals.goal_id;


--
-- TOC entry 231 (class 1259 OID 17441)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    token_id uuid NOT NULL,
    user_id integer NOT NULL,
    token_hash text NOT NULL,
    issued_at timestamp with time zone DEFAULT now(),
    expires_at timestamp with time zone NOT NULL,
    used boolean
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17333)
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refresh_tokens (
    token_id uuid NOT NULL,
    user_id integer NOT NULL,
    token_hash text NOT NULL,
    issued_at timestamp with time zone DEFAULT now(),
    expires_at timestamp with time zone NOT NULL,
    revoked boolean,
    revoked_at timestamp with time zone
);


ALTER TABLE public.refresh_tokens OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17417)
-- Name: sugar_readings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sugar_readings (
    reading_id integer NOT NULL,
    user_id integer NOT NULL,
    reading_value numeric NOT NULL,
    reading_unit text NOT NULL,
    reading_time timestamp without time zone NOT NULL,
    device_file_id uuid,
    notes text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.sugar_readings OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17416)
-- Name: sugar_readings_reading_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sugar_readings_reading_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sugar_readings_reading_id_seq OWNER TO postgres;

--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 229
-- Name: sugar_readings_reading_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sugar_readings_reading_id_seq OWNED BY public.sugar_readings.reading_id;


--
-- TOC entry 227 (class 1259 OID 17384)
-- Name: user_diet_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_diet_preferences (
    user_id integer NOT NULL,
    diet_id integer NOT NULL
);


ALTER TABLE public.user_diet_preferences OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17367)
-- Name: user_health_goals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_health_goals (
    user_id integer NOT NULL,
    goal_id integer NOT NULL
);


ALTER TABLE public.user_health_goals OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17481)
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_profiles (
    user_id integer NOT NULL,
    age integer,
    gender text,
    weight_kg numeric,
    height_cm numeric,
    bmi numeric,
    activity_level public.activity_level_enum NOT NULL,
    diabetes_status public.diabetes_status_enum NOT NULL,
    insulin_usage boolean,
    insulin_dosage numeric,
    profile_completed boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_profiles OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17292)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    first_name text,
    last_name text,
    email text NOT NULL,
    password_hash text NOT NULL,
    is_active boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17291)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4804 (class 2604 OID 17324)
-- Name: dietary_preferences diet_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dietary_preferences ALTER COLUMN diet_id SET DEFAULT nextval('public.dietary_preferences_diet_id_seq'::regclass);


--
-- TOC entry 4803 (class 2604 OID 17311)
-- Name: health_goals goal_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_goals ALTER COLUMN goal_id SET DEFAULT nextval('public.health_goals_goal_id_seq'::regclass);


--
-- TOC entry 4807 (class 2604 OID 17420)
-- Name: sugar_readings reading_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sugar_readings ALTER COLUMN reading_id SET DEFAULT nextval('public.sugar_readings_reading_id_seq'::regclass);


--
-- TOC entry 4800 (class 2604 OID 17295)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 5003 (class 0 OID 17321)
-- Dependencies: 224
-- Data for Name: dietary_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dietary_preferences (diet_id, diet_name) FROM stdin;
\.


--
-- TOC entry 5007 (class 0 OID 17401)
-- Dependencies: 228
-- Data for Name: file_storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.file_storage (file_id, user_id, filename, mime_type, size_bytes, storage_type, file_url, file_data, uploaded_at) FROM stdin;
\.


--
-- TOC entry 5001 (class 0 OID 17308)
-- Dependencies: 222
-- Data for Name: health_goals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.health_goals (goal_id, goal_name) FROM stdin;
\.


--
-- TOC entry 5010 (class 0 OID 17441)
-- Dependencies: 231
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (token_id, user_id, token_hash, issued_at, expires_at, used) FROM stdin;
b9e43f99-559c-4f45-8079-0c85a5fbc8f3	1	d41008efe88844cc565be910a87d76b401a2dffc1226253f644ba80ec043f0b5	2025-12-13 00:14:56.381683+05	2025-12-12 20:14:56.378235+05	f
8995e521-6384-4100-ae0a-cd64ab1cb7ca	18	d5d29aa0f70c2516221cd9c019c549c8778684a202854c4f97ce3c201e9ad940	2025-12-13 00:25:45.880819+05	2025-12-12 20:25:45.886983+05	f
c4e45499-0955-4407-8f67-4d28fbd53c44	18	32da84c3c8d6e1a1bd448934c01527cbcfd4f0bfa5113c94ab627e0f181fdbfd	2025-12-13 00:28:55.857638+05	2025-12-12 20:28:55.858085+05	f
1daf474c-c3e6-4d2c-a6bb-b68d3c858450	18	b389f2f82bbe9da50553a46d641634978bd7de771823517a94f75e56b4524105	2025-12-13 00:57:30.353631+05	2025-12-12 20:57:30.375619+05	t
2b7c54e9-6981-47b9-871a-e29d79c81e9a	18	ae865a7c3c4042154cc24930a244644d2cce50eedd26eed0e46136fbd36d0af5	2025-12-13 01:04:14.917952+05	2025-12-12 21:04:14.91792+05	t
c1c55408-bab8-457a-93e6-c3559d4a76b3	18	2f60d923fc71ec06708374bab4a60a51c0c5caab7ca4f5ae1dcf3679a094559b	2025-12-13 01:09:50.084758+05	2025-12-12 21:09:50.087973+05	t
0cc7db6e-1389-4804-a3ab-97acfed4f785	18	f59eff426876ff918f63cb7afb4bc849363e1c18c1784dfb28cb000bdec28bc9	2025-12-13 01:23:23.257632+05	2025-12-12 21:23:23.262245+05	t
bcf5f7b6-0a8a-4e0e-a40c-ae4f3ea0f712	18	51a259c62f40027d911c320d0d4f6b8d8d495db9e1eb106296cafe7d5b4024fe	2025-12-13 02:01:22.768522+05	2025-12-12 22:01:22.779046+05	f
1fb347f7-ff07-4f19-b2c7-18f423ffc535	18	4d0a32cf1151fba899d4b808683dcd2b345c310d5631cb8db2f28aefbf9a291e	2025-12-13 02:10:10.211971+05	2025-12-12 22:10:10.213187+05	f
d4ff580f-6a99-42da-bc8f-57fc99eb4cde	21	e078573f09033813d7df63c28adeb008b5d3044bb8afcd3fcc7121eab8ba1ab8	2025-12-13 22:31:20.923041+05	2025-12-13 18:31:20.923634+05	f
83fa702f-4d59-4a2d-be13-e8220106855b	18	b96c97e95018c0a466772e2b746f1019c16453a61de6195afa4bc64ef721cf61	2025-12-14 02:39:10.274668+05	2025-12-13 22:39:10.274082+05	f
5067ada4-eb8f-4733-aad4-19a144078c82	18	b39121670139e2b309914728e9544df9eb6b17a2e59d0403994bc3f50fc00b9e	2025-12-14 09:26:56.355236+05	2025-12-14 05:26:56.371389+05	t
718b56d5-251d-4e1d-ab51-a21de33cf6fd	18	fba1c01bc53ab1667d8d46ee1020a40b244f0f03d43170d46ce067eff5bcbabd	2025-12-14 11:31:11.242444+05	2025-12-14 07:31:11.257103+05	t
\.


--
-- TOC entry 5004 (class 0 OID 17333)
-- Dependencies: 225
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_tokens (token_id, user_id, token_hash, issued_at, expires_at, revoked, revoked_at) FROM stdin;
a42da4a5-a03c-491b-a5f8-f7aa3ab72909	1	cb0ba02c94bc3199fdac942d897e358476be70541b63942ae2ac4bd0bcda74ba	2025-12-09 23:23:22.998346+05	2026-01-08 18:23:23.071572+05	f	\N
8f991fb2-884f-4a2d-9c89-64f60c2a5d62	2	6f7fd89936fd50db23f0ad7ad657d4962f26304b1a2bdf60e6ded0cf7cad84e4	2025-12-09 23:23:49.017017+05	2026-01-08 18:23:49.005418+05	f	\N
2744a0b8-aaa6-46e8-86f6-bc79af813770	2	cf41f428405e7a1fc0fe4b1cc98b001a2d3cbfb674f2ac4b72422174416043cf	2025-12-09 23:27:44.754966+05	2026-01-08 18:27:45.109599+05	f	\N
e414fc26-5d16-4ada-bf83-20b8f96e8149	2	a4d0b6936f4d34c82ce0d0954ce24bfd023f6865968156772d01c33c0654db74	2025-12-10 00:00:57.186813+05	2026-01-08 19:00:57.586504+05	f	\N
fd4506ef-13a5-4854-9e6f-a6bba0312570	3	2fc481e3d90407b8880a2802f27f3408147d52be30e7ded9b60fce4853925fe5	2025-12-10 00:02:11.103896+05	2026-01-08 19:02:11.103464+05	f	\N
2e4369e9-5e47-4aa3-bfc5-503380c87325	4	820c20500e22cedb9bd6ac284486cb12cefd17ac0c91faa977c4e42c2ecd7924	2025-12-10 00:30:02.23041+05	2026-01-08 19:30:02.263015+05	f	\N
22296e80-f1ac-4e73-acce-441fd3950490	5	ea3ae685bc4edb8fffeae878bf20ffd49f03783df882f09119270e2c801272e9	2025-12-10 00:37:06.120258+05	2026-01-08 19:37:06.162541+05	f	\N
5baae3bf-619f-4af9-abdc-eedf8a44e37e	2	646d725705f886ef9e48371e6efb4ed52ed87f08afae723ace46dadb7405f8a8	2025-12-09 20:55:48.976354+05	2026-01-08 20:55:48.960718+05	f	\N
fe375880-e1b8-4661-9d25-22b057c6d411	7	ee28d532b1393eac00e0cd5d9b4aa42bcb5c697ac786a4e12e2a0e80d8c2d36f	2025-12-09 20:58:41.338156+05	2026-01-08 20:58:41.338156+05	f	\N
4a18cb8a-7b48-4f5a-a3ca-2d6d4b0ecfaf	8	c8a7d7a3b239d82079f1e1a4485abd31fd79635a7803a1efd30185d40c06c9a9	2025-12-09 21:17:13.175155+05	2026-01-08 21:17:13.10955+05	f	\N
5d00b28a-e90f-4532-8e32-3e2161f85724	9	a57fd0240dad87d4ae7705957dd3918bf07ca0e07f10ea193590752389596759	2025-12-09 21:34:04.321131+05	2026-01-08 21:34:04.239523+05	f	\N
bed441fd-3589-4929-ba3e-8f3ce1724935	10	380b5d05a568cf995ab62400d56e96fc125157724846f728d48587d31a2db176	2025-12-09 21:47:10.538959+05	2026-01-08 21:47:10.537244+05	f	\N
bdcb1e28-3f3a-44be-89e4-93f2a3e6599c	11	b206a903f4eb22202eb0673d73cd2e84600457643e7bad25c9695a3cdc695013	2025-12-09 21:59:04.395605+05	2026-01-08 21:59:04.395605+05	f	\N
1fe79852-d102-49b9-8c71-a30db3497b35	12	615dfb5046853c5c9e4eb5734ef650c384be9f58c26d2b5df0669a1ccd2f3565	2025-12-09 22:13:24.750193+05	2026-01-08 22:13:24.747193+05	f	\N
fd97614c-15cd-4463-b3ea-7a4d2fff4474	13	291283ea916b7c0238092c2f0a0ef9b09cad3d3ef6df56c0345153328b779c8b	2025-12-09 22:17:28.931586+05	2026-01-08 22:17:28.929588+05	f	\N
b6249fa9-7364-440a-adf8-5334067b6c5f	2	c2fffa6f6f33c55ad76f43e3737153db03392d997a73d6c1d398a1b76eaf32cf	2025-12-09 22:22:09.588188+05	2026-01-08 22:22:09.588188+05	f	\N
54ccb0ca-4acf-49c3-bfe8-f4b8adea0924	14	5413e2ad9c43525c4daa6873d792ef3c8154b8523432c6af1c6b13a04df8e5a3	2025-12-09 22:23:23.520778+05	2026-01-08 22:23:23.518777+05	f	\N
40d60418-a4da-4b3a-a1e2-c9866138e616	15	d43800a45839a7bb4779fb43f61aaabc2328fa1124a6db7379f8a86047381587	2025-12-09 22:36:39.851696+05	2026-01-08 22:36:39.84612+05	f	\N
59ce3f50-e6f8-41cb-9467-f71a13bdd289	16	a2eced687c2ba183900aa679baaca2fd7d23e42a304dbe0d3b481924bd2d5623	2025-12-10 12:35:52.394894+05	2026-01-09 12:35:52.378795+05	f	\N
7fe89fbb-4a7a-4e97-b76d-0f2aba55346d	17	3a6c0a45b58a14a163dfd59392842206d4391fb948ebe366e21cba39fa2678d7	2025-12-10 12:49:58.560339+05	2026-01-09 12:49:58.560339+05	f	\N
859f8f4a-4ffc-4754-9d64-ebc15476e6e1	18	2b1d060d2aa1db4c93942276f561029ded8c4f87ec6a67c146f68c2537da4ae0	2025-12-12 23:33:24.780237+05	2026-01-11 18:33:24.792365+05	f	\N
e0b93983-c829-43f3-839e-6ddd057c5f94	18	b69bca7246aa660b6c6215ec136ce573ed70c46a627a9e8abff8891a02baa28c	2025-12-13 02:04:00.713696+05	2026-01-11 21:04:01.225889+05	f	\N
ae528ccf-6b8b-46bb-876d-5a80834f8622	19	62e1c9d8f3e010602c4b6519dd29bff50ce24f52bc0b07669c3183be8ed2fe4c	2025-12-13 20:00:18.599146+05	2026-01-12 15:00:18.636384+05	f	\N
7abe19e8-f692-4516-b884-801e6a0ce6f4	20	3ae52184a9b49f68aeef71167ab16579f272f95ef0b6c6b2e70a225cc006b5d4	2025-12-13 20:00:28.890099+05	2026-01-12 15:00:28.880291+05	f	\N
f3450766-f82c-4017-99c9-c486582e76d3	21	5d44ffcfa07382df6b38c8cf62025e29b7045a922d485b6de8d391bc9f078502	2025-12-13 22:28:19.011369+05	2026-01-12 17:28:19.040792+05	f	\N
6eaf75e7-ef2d-4a3c-82d7-212d1c25924d	22	28cf29637ac5624c5951245fa0f32130deabbf59c108be54cb5fc439d74dddbb	2025-12-13 22:54:15.187314+05	2026-01-12 17:54:15.228319+05	f	\N
55df0017-83bd-4d2f-8c3b-31c2e19a2f77	22	b7441512201089e7acb2b3ef5919805893cd5ec4088d873c113bfe505f922606	2025-12-13 23:00:00.944467+05	2026-01-12 18:00:01.133357+05	f	\N
ca26a1e6-bcf4-4a72-a4e5-0d2d56d372dd	23	7bda62cb873b668eef5eab391c7f7888eb0fcafb24df9d35c872c8f40997db44	2025-12-13 23:16:13.234968+05	2026-01-12 18:16:13.257998+05	f	\N
fb220177-5a93-4ba1-b754-601e186e88b1	23	4acfab839e00124634e9e5ce572ad5693c3942d8c18fc636980a1c910fe2776a	2025-12-13 23:22:04.129808+05	2026-01-12 18:22:04.330333+05	f	\N
00d0483e-49ac-4418-b6df-dca3af56af9e	23	6677156701ac87dbd1833aa510463b95ee468ac8e79819fe885dabd888434b30	2025-12-13 23:28:32.341935+05	2026-01-12 18:28:32.538332+05	f	\N
53d73456-f65d-4e26-b2ae-4d5b81223db7	24	5f36132052807a24f088b6bd57cb86dd70e746523740e8148a60926938be8c12	2025-12-13 23:30:31.155502+05	2026-01-12 18:30:31.147976+05	f	\N
51880421-2fc8-41ec-baa9-63b1de166286	23	7fbf1ca6a84160a6384cc7c330897b31cc28fb1c15b338cb2d7ee131620a68a1	2025-12-14 02:37:32.57625+05	2026-01-12 21:37:32.993574+05	f	\N
c626d92c-149d-40a0-81e3-84d175766882	25	cbf9ef67a7036e7b79b4ee31144e3241c9632f977fc566c385a3916ee37e99ec	2025-12-14 02:39:58.172584+05	2026-01-12 21:39:58.169772+05	f	\N
869999a8-c039-4899-a713-bae36fbb08d0	18	137538061ed56c61e04cb1a58fdb02b55f8c3795c8b801c42b3f7544554f7e2a	2025-12-14 09:30:35.647024+05	2026-01-13 04:30:35.920052+05	f	\N
031043b4-8111-4d3a-aee3-d7cc27b2d50a	26	b0400a97b1d519672aecc1cc0e90bffebbc6764a95ca3ab072f1c9af07c6691a	2025-12-14 09:33:39.124472+05	2026-01-13 04:33:39.125381+05	f	\N
046561a8-394f-4933-ab30-dad389806946	18	63f311207ec931bee53748bb4171be321f17b8cb7cd68cfd60db33461c3211bd	2025-12-14 11:34:02.540937+05	2026-01-13 06:34:02.96509+05	f	\N
\.


--
-- TOC entry 5009 (class 0 OID 17417)
-- Dependencies: 230
-- Data for Name: sugar_readings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sugar_readings (reading_id, user_id, reading_value, reading_unit, reading_time, device_file_id, notes, created_at) FROM stdin;
9	20	140.5	mg/dL	2025-12-13 17:16:45.019128	\N	Fasting reading	2025-12-13 22:16:45.018971+05
26	24	140.599999999999994315658113919198513031005859375	mg/dL	2025-12-13 21:32:13.794595	\N	Fasting reading	2025-12-14 02:32:13.780921+05
27	1	200.599999999999994315658113919198513031005859375	mg/dL	2025-12-13 21:33:33.921999	\N	Fasting reading	2025-12-14 02:33:33.920494+05
28	18	160.69999999999998863131622783839702606201171875	mg/dL	2025-12-14 04:32:26.427893	\N	Fasting reading	2025-12-14 09:32:26.386474+05
29	2	130	mg/dL	2025-12-14 06:35:41.002029	\N	fasting reading	2025-12-14 11:35:40.956396+05
\.


--
-- TOC entry 5006 (class 0 OID 17384)
-- Dependencies: 227
-- Data for Name: user_diet_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_diet_preferences (user_id, diet_id) FROM stdin;
\.


--
-- TOC entry 5005 (class 0 OID 17367)
-- Dependencies: 226
-- Data for Name: user_health_goals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_health_goals (user_id, goal_id) FROM stdin;
\.


--
-- TOC entry 5011 (class 0 OID 17481)
-- Dependencies: 232
-- Data for Name: user_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_profiles (user_id, age, gender, weight_kg, height_cm, bmi, activity_level, diabetes_status, insulin_usage, insulin_dosage, profile_completed, created_at, updated_at) FROM stdin;
24	40	female	50	50	200	lightly_active	type2	f	12	t	2025-12-14 02:32:13.780921+05	2025-12-14 02:32:13.780921+05
1	30	male	60	70	122.4489795918367462945752777159214019775390625	lightly_active	type1	f	0	t	2025-12-14 02:33:33.920494+05	2025-12-14 02:33:33.920494+05
18	23	female	40	60	111.111111111111114269078825600445270538330078125	sedentary	type1	f	0	t	2025-12-14 09:32:26.386474+05	2025-12-14 09:32:26.386474+05
2	40	male	40	50	160	sedentary	type1	f	12	t	2025-12-14 11:35:40.956396+05	2025-12-14 11:35:40.956396+05
\.


--
-- TOC entry 4999 (class 0 OID 17292)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, first_name, last_name, email, password_hash, is_active, created_at, updated_at) FROM stdin;
1	string	string	user@example.com	$2b$12$iGHdHaUcREaFlfnFgG0a0e9Y49rdSAzh1Y2k//VQLHlLjehPybtOq	t	2025-12-09 23:23:22.626136+05	2025-12-09 23:23:22.626136+05
2	musfira	bano	musfira@gmail.com	$2b$12$FAZ3FB7yNbIiXIBDJnEBHOmLa7LU0hlTy4GrHDMA9S..V65B8qUWa	t	2025-12-09 23:23:48.646466+05	2025-12-09 23:23:48.646466+05
3	kiran	dawood	kiran@gmail.com	$2b$12$UAQIDCODp1fypP0teEWURuIPg7Eo0sq4ORPbIkO3pFlg7m1egFipK	t	2025-12-10 00:02:10.663557+05	2025-12-10 00:02:10.663557+05
4	Saim	Azam	saim@gmail.com	$2b$12$p0VmLSI1RKZpqSEHTEoiseDbxjnYn6KTgGbGHlDPOoNbKn/KZz5py	t	2025-12-10 00:30:01.603544+05	2025-12-10 00:30:01.603544+05
5	abc	123	abc@gmail.com	$2b$12$lWSI9gYRkkdHeInWAmdGXun2iwpPOAuvIp/CIV34kI1291dVvh1Z2	t	2025-12-10 00:37:05.487296+05	2025-12-10 00:37:05.487296+05
6	Kashan	Tauseef	kashan@gmail.com	$2b$12$xLJRFudURHpO1l5trJ4cWer8aiTnKJz1/D1La5gzzRXefAuUeAI4e	t	2025-12-10 01:29:00.756428+05	2025-12-10 01:29:00.756428+05
7	aa	bb	aa@gmail.com	$2b$12$YA2MTogpYR8dPsk9u6MpzeGvLqIDIwwPGrdJzJz358iaSLq3AgAPG	t	2025-12-09 20:58:41.33165+05	2025-12-09 20:58:41.33165+05
8	jim	keen	jim@gmail.com	$2b$12$Fx3yzfzJ7Fo0x21DuS9/p.yitttYDzEN4xxfmIb/MeuYPz8WwW.La	t	2025-12-09 21:17:13.023841+05	2025-12-09 21:17:13.023841+05
9	Naheed	bano	naheed@gmail.com	$2b$12$AFVeOKXCT6840Ob30c00lu7rBfaZBuaR.mjmO/Os4ulJpCJhqU2R2	t	2025-12-09 21:34:04.171723+05	2025-12-09 21:34:04.171723+05
10	baba	mama	bama@gmail.com	$2b$12$t6EZaeHIHoPwjXA5YWfXkuFO2j1Zo7l4kyxZvqFVBcdHws2TRTR0K	t	2025-12-09 21:47:10.497898+05	2025-12-09 21:47:10.497898+05
11	hani	fari	hani@gmail.com	$2b$12$cLgMOL4GQsQ4TZDelK.hsexaVtGKBXOZk8DbdFzRKGM3Y7ja5HQPq	t	2025-12-09 21:59:04.334649+05	2025-12-09 21:59:04.334649+05
12	test	bell	test@gmail.com	$2b$12$3ClYTi9FPsRtVfDIpvDZr.0pS2P56I2VbtY7IQ4MMHs6Z72FMESYK	t	2025-12-09 22:13:24.668417+05	2025-12-09 22:13:24.668417+05
13	jingler	lee	lee@gmail.com	$2b$12$p.BoVAN7FQ5BI16CdCMdAeNlMf./QgSMYL6NpZ67PXLckjmWaWVB6	t	2025-12-09 22:17:28.910508+05	2025-12-09 22:17:28.910508+05
14	ullu	ullu	ullu@gmail.com	$2b$12$fWdspi25tO9OQVN4ItnFxusmp3hyER0ygwfM3gdey.ki.UqbKEfx6	t	2025-12-09 22:23:23.480233+05	2025-12-09 22:23:23.480233+05
15	hasan	naqash	naqash@gmail.com	$2b$12$zIgKQdYV1wDPvQRZXcN9B.hxEwCnSE8MSr7AM.QZ8hm7Z/x7i0koK	t	2025-12-09 22:36:39.783917+05	2025-12-09 22:36:39.783917+05
16	muhammad	saim	muhammad@gmail.com	$2b$12$5HlYX8ntyyUyKT/X6yhM3eGjNSI7gZzRL.K1GIMif2NRFc/E1NMX2	t	2025-12-10 12:35:52.328179+05	2025-12-10 12:35:52.328179+05
17	Ma	ma	mam@gmail.com	$2b$12$ckeQvb.F7nhaMeD/sV6WauKQ9X6QIN561Clzbq00nWbDgqjA988d.	t	2025-12-10 12:49:58.4471+05	2025-12-10 12:49:58.4471+05
19	User	Test	test@example.com	$argon2id$v=19$m=65536,t=3,p=4$lRLiXCvl3Psf4/wfwxhDSA$jyjwxTRjL4ja1dCvzADrJ40i+9JVp9vRash/GtTOeb4	t	2025-12-13 20:00:18.330961+05	2025-12-13 20:00:18.330961+05
20	User	Test	test12@example.com	$argon2id$v=19$m=65536,t=3,p=4$dC4lhPC+d67VupfSWstZSw$1XJhNJj4biCUQ43cGTa7OErzg+GrfycvtYziXfUPh4A	t	2025-12-13 20:00:28.715651+05	2025-12-13 20:00:28.715651+05
21	faizan	naveed	artsoffaizan@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$HYOQ8n7PmZMSAsBYK2UsRQ$nspdf81yqeD9S8cXzxi1a8CNChOgCxzGYTdkc0qZc1I	t	2025-12-13 22:28:18.84366+05	2025-12-13 22:28:18.84366+05
22	Testing	Profile	profile@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$8x7jHMOYE+L8X2sNYSylFA$ap0I0HJmBHV1qHEegKwSckzSZJkbJqR+PUv3t6k2p8Y	t	2025-12-13 22:54:15.038437+05	2025-12-13 22:54:15.038437+05
23	abc	def	abc123@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$j/Fey7k3plRq7T3HWAuB8A$mZCmfipVVPuGY6P4uF0+9Y7ptjVwUSA+Ox5TkFT4Ems	t	2025-12-13 23:16:13.009415+05	2025-12-13 23:16:13.009415+05
24	profile	details	profiledetails@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$yJlTylmLsdZa67035tz7Hw$zu1puJSryZYAy9bku4hqQ9mu/HhEk4xGb6SZWaxIpA4	t	2025-12-13 23:30:30.951813+05	2025-12-13 23:30:30.951813+05
25	flutter	Check	flutterch@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$/t87p9R6LwXgvNe6V6p1Lg$R1CaZCnHFEVh8Wf7GWib2O5ei1dzU5Jmc0hMuiPreMg	t	2025-12-14 02:39:57.865575+05	2025-12-14 02:39:57.865575+05
26	Rumaisa	Saif	rumi@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$pTTmvJfyPgfAOAdgzJmT8g$TlDhV93oPsMsB4qQItDLgOmWMSMjbGQC+HJAX+Kn9cQ	t	2025-12-14 09:33:38.933711+05	2025-12-14 09:33:38.933711+05
18	M	B	musfirabano30@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$VArhvDcGoBQihFAK4VyrNQ$Db9/l1I4dB38CJUoUkpSq84iO6QNfK+yAUDRRQjuAsI	t	2025-12-12 23:33:24.38547+05	2025-12-14 11:33:44.724983+05
\.


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 223
-- Name: dietary_preferences_diet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dietary_preferences_diet_id_seq', 1, false);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 221
-- Name: health_goals_goal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.health_goals_goal_id_seq', 1, false);


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 229
-- Name: sugar_readings_reading_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sugar_readings_reading_id_seq', 29, true);


--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 26, true);


--
-- TOC entry 4821 (class 2606 OID 17332)
-- Name: dietary_preferences dietary_preferences_diet_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dietary_preferences
    ADD CONSTRAINT dietary_preferences_diet_name_key UNIQUE (diet_name);


--
-- TOC entry 4823 (class 2606 OID 17330)
-- Name: dietary_preferences dietary_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dietary_preferences
    ADD CONSTRAINT dietary_preferences_pkey PRIMARY KEY (diet_id);


--
-- TOC entry 4831 (class 2606 OID 17410)
-- Name: file_storage file_storage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_storage
    ADD CONSTRAINT file_storage_pkey PRIMARY KEY (file_id);


--
-- TOC entry 4817 (class 2606 OID 17319)
-- Name: health_goals health_goals_goal_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_goals
    ADD CONSTRAINT health_goals_goal_name_key UNIQUE (goal_name);


--
-- TOC entry 4819 (class 2606 OID 17317)
-- Name: health_goals health_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_goals
    ADD CONSTRAINT health_goals_pkey PRIMARY KEY (goal_id);


--
-- TOC entry 4835 (class 2606 OID 17452)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (token_id);


--
-- TOC entry 4825 (class 2606 OID 17344)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (token_id);


--
-- TOC entry 4833 (class 2606 OID 17430)
-- Name: sugar_readings sugar_readings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sugar_readings
    ADD CONSTRAINT sugar_readings_pkey PRIMARY KEY (reading_id);


--
-- TOC entry 4829 (class 2606 OID 17390)
-- Name: user_diet_preferences user_diet_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_diet_preferences
    ADD CONSTRAINT user_diet_preferences_pkey PRIMARY KEY (user_id, diet_id);


--
-- TOC entry 4827 (class 2606 OID 17373)
-- Name: user_health_goals user_health_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_health_goals
    ADD CONSTRAINT user_health_goals_pkey PRIMARY KEY (user_id, goal_id);


--
-- TOC entry 4840 (class 2606 OID 17492)
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4815 (class 2606 OID 17304)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4836 (class 1259 OID 17500)
-- Name: ix_user_profiles_activity; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_user_profiles_activity ON public.user_profiles USING btree (activity_level);


--
-- TOC entry 4837 (class 1259 OID 17499)
-- Name: ix_user_profiles_age; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_user_profiles_age ON public.user_profiles USING btree (age);


--
-- TOC entry 4838 (class 1259 OID 17498)
-- Name: ix_user_profiles_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_user_profiles_user ON public.user_profiles USING btree (user_id);


--
-- TOC entry 4812 (class 1259 OID 17305)
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- TOC entry 4813 (class 1259 OID 17306)
-- Name: ix_users_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_users_user_id ON public.users USING btree (user_id);


--
-- TOC entry 4846 (class 2606 OID 17411)
-- Name: file_storage file_storage_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_storage
    ADD CONSTRAINT file_storage_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- TOC entry 4849 (class 2606 OID 17453)
-- Name: password_reset_tokens password_reset_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4841 (class 2606 OID 17345)
-- Name: refresh_tokens refresh_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4847 (class 2606 OID 17436)
-- Name: sugar_readings sugar_readings_device_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sugar_readings
    ADD CONSTRAINT sugar_readings_device_file_id_fkey FOREIGN KEY (device_file_id) REFERENCES public.file_storage(file_id) ON DELETE SET NULL;


--
-- TOC entry 4848 (class 2606 OID 17431)
-- Name: sugar_readings sugar_readings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sugar_readings
    ADD CONSTRAINT sugar_readings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4844 (class 2606 OID 17396)
-- Name: user_diet_preferences user_diet_preferences_diet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_diet_preferences
    ADD CONSTRAINT user_diet_preferences_diet_id_fkey FOREIGN KEY (diet_id) REFERENCES public.dietary_preferences(diet_id) ON DELETE CASCADE;


--
-- TOC entry 4845 (class 2606 OID 17391)
-- Name: user_diet_preferences user_diet_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_diet_preferences
    ADD CONSTRAINT user_diet_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4842 (class 2606 OID 17379)
-- Name: user_health_goals user_health_goals_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_health_goals
    ADD CONSTRAINT user_health_goals_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES public.health_goals(goal_id) ON DELETE CASCADE;


--
-- TOC entry 4843 (class 2606 OID 17374)
-- Name: user_health_goals user_health_goals_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_health_goals
    ADD CONSTRAINT user_health_goals_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4850 (class 2606 OID 17493)
-- Name: user_profiles user_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


-- Completed on 2025-12-19 20:54:25

--
-- PostgreSQL database dump complete
--

\unrestrict eVrBEoUsOJ8ncRZObVJVQumh6AqOcd8DzWRLbyZd6dbN9IJNaHxlV0RcCwHlDZ6

