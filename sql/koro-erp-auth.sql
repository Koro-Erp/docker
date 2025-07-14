--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.8

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
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: identity_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_types (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.identity_types OWNER TO postgres;

--
-- Name: identity_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.identity_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.identity_types_id_seq OWNER TO postgres;

--
-- Name: identity_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.identity_types_id_seq OWNED BY public.identity_types.id;


--
-- Name: logged_in_attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logged_in_attempts (
    id integer NOT NULL,
    username character varying(255),
    attempt_time timestamp without time zone NOT NULL,
    success boolean NOT NULL,
    ip_address character varying(255) NOT NULL
);


ALTER TABLE public.logged_in_attempts OWNER TO postgres;

--
-- Name: logged_in_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logged_in_attempts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logged_in_attempts_id_seq OWNER TO postgres;

--
-- Name: logged_in_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logged_in_attempts_id_seq OWNED BY public.logged_in_attempts.id;


--
-- Name: oauth_clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_clients (
    id integer NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    name text NOT NULL,
    scopes text[] NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    require_user_token boolean DEFAULT true
);


ALTER TABLE public.oauth_clients OWNER TO postgres;

--
-- Name: oauth_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth_clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oauth_clients_id_seq OWNER TO postgres;

--
-- Name: oauth_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth_clients_id_seq OWNED BY public.oauth_clients.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refresh_tokens (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    token text NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.refresh_tokens OWNER TO postgres;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refresh_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refresh_tokens_id_seq OWNER TO postgres;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.refresh_tokens_id_seq OWNED BY public.refresh_tokens.id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    role_id integer NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    username character varying(100) NOT NULL,
    password text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone,
    phone_number character varying(15),
    id_number character varying(20),
    email character varying(100),
    id_type_id integer,
    first_name character varying(100),
    last_name character varying(100),
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: identity_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_types ALTER COLUMN id SET DEFAULT nextval('public.identity_types_id_seq'::regclass);


--
-- Name: logged_in_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logged_in_attempts ALTER COLUMN id SET DEFAULT nextval('public.logged_in_attempts_id_seq'::regclass);


--
-- Name: oauth_clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_clients ALTER COLUMN id SET DEFAULT nextval('public.oauth_clients_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Data for Name: identity_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_types (id, name, description, created_at) FROM stdin;
1	National ID	National Identity Card	2025-05-20 15:41:18.500378+03
4	Passport	Passport	2025-06-26 12:03:15.509648+03
5	A driving licence	Your driving licence	2025-06-26 12:06:26.210472+03
\.


--
-- Data for Name: logged_in_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logged_in_attempts (id, username, attempt_time, success, ip_address) FROM stdin;
1	koros	2025-05-07 11:18:35.503373	t	[::1]:39578
2	koros	2025-05-07 11:19:22.456264	t	[::1]:48180
3	koros	2025-05-07 11:19:24.327866	t	[::1]:48180
4	koros	2025-05-07 11:19:27.589905	t	[::1]:48180
5	koros	2025-05-07 11:19:29.878547	t	[::1]:48180
6	koros	2025-05-08 13:13:20.938733	t	[::1]:42852
7	koros	2025-05-08 13:14:17.80723	t	[::1]:56216
8	koros	2025-05-08 14:28:36.034597	t	[::1]:41106
11	koros	2025-05-08 14:30:17.626706	t	[::1]:54394
12	koros	2025-05-08 14:34:43.224521	t	[::1]:34684
13	koros	2025-05-08 14:48:26.444253	t	[::1]:40654
14	koros	2025-05-08 14:49:52.755225	t	[::1]:53196
18	koros	2025-05-08 14:54:24.35661	t	[::1]:34636
19	koros	2025-05-08 14:56:19.021131	t	[::1]:58332
20	koros	2025-05-08 14:57:58.784161	t	[::1]:59642
22	koros	2025-05-08 14:59:43.146013	t	[::1]:59642
23		2025-05-08 15:01:21.47922	f	[::1]:41532
24		2025-05-08 15:02:13.574109	f	[::1]:47656
25	koros	2025-05-08 15:03:11.01906	t	[::1]:52576
26	koros	2025-05-08 15:59:53.083356	t	[::1]:37874
27	koros	2025-05-08 16:27:09.516709	t	[::1]:50048
28	koros	2025-05-08 16:54:09.575861	t	[::1]:56774
36	kevinongulu@gmail.com	2025-05-09 09:42:56.604777	t	[::1]:59596
37	kevinongulu@gmail.com	2025-05-09 09:43:37.280644	t	[::1]:59596
38	kevinongulu@gmail.com	2025-05-09 09:44:29.098863	t	[::1]:49478
39	kevinongulu@gmail.com	2025-05-09 09:45:16.379801	t	[::1]:47684
40	kevinongulu@gmail.com	2025-05-09 09:47:15.848691	t	[::1]:39058
41	32414225	2025-05-09 09:47:45.444983	t	[::1]:39908
42	32414225	2025-05-09 10:34:33.385118	t	::1
43	32414225	2025-05-09 10:47:59.428487	t	::1
44	32414225	2025-05-09 10:59:18.7276	t	::1
45	32414225	2025-05-09 11:44:05.116015	t	::1
46	32414225	2025-05-09 12:02:24.497063	f	::1
47	32414225	2025-05-09 12:02:34.338905	t	::1
48	32414225	2025-05-09 12:03:59.112221	t	::1
49	32414225	2025-05-09 12:05:34.138958	f	::1
50	32414225	2025-05-09 12:11:11.640496	f	::1
51	32414225	2025-05-09 12:11:35.355661	f	::1
52	32414225	2025-05-09 12:12:45.748773	f	::1
53	32414225	2025-05-09 12:12:53.357613	t	::1
54	32414225	2025-05-09 12:23:38.258326	t	::1
55	32414225	2025-05-09 15:51:34.922567	t	::1
56	32414225	2025-05-09 16:02:22.85018	t	::1
57	32414225	2025-05-09 16:14:36.317988	t	::1
58	32414225	2025-05-09 16:25:16.873905	t	::1
59	32414225	2025-05-09 16:35:55.504089	t	::1
60	32414225	2025-05-12 09:22:59.840961	t	::1
61	32414225	2025-05-12 09:36:05.487808	t	::1
62	32414225	2025-05-12 09:47:28.136528	t	::1
63	32414225	2025-05-12 10:08:58.029453	t	::1
64	32414225	2025-05-12 10:19:17.256201	t	::1
65	32414225	2025-05-12 10:32:13.962103	t	::1
66	32414225	2025-05-12 11:01:09.228057	t	::1
67	32414225	2025-05-19 16:15:59.850167	t	::1
69	korobosta	2025-05-20 15:43:29.984286	t	::1
70	korobosta	2025-05-21 10:55:53.421169	t	::1
71	korobosta	2025-05-21 10:57:57.945246	t	::1
72	korobosta	2025-05-21 11:10:41.072811	t	::1
73	korobosta	2025-05-21 11:14:00.323294	t	::1
74	korobosta	2025-05-21 11:32:41.897221	t	::1
75	korobosta	2025-05-21 11:43:01.76577	t	::1
76	korobosta	2025-05-21 11:54:47.066178	t	::1
77	korobosta	2025-05-21 17:16:30.826087	t	::1
78	korobosta	2025-05-22 08:46:05.813371	t	::1
79	korobosta	2025-05-22 08:50:46.078075	t	::1
80	korobosta	2025-05-22 09:17:16.250435	t	::1
81	korobosta	2025-05-22 10:06:53.093937	t	::1
82	korobosta	2025-05-22 10:08:50.124337	t	::1
83	korobosta	2025-05-22 14:46:32.932398	t	::1
84	korobosta	2025-05-22 14:55:02.124934	t	::1
85	korobosta	2025-05-22 14:58:24.527308	t	::1
86	korobosta	2025-05-22 15:06:03.186517	t	::1
87	korobosta	2025-05-22 16:57:52.159184	t	::1
88	korobosta	2025-05-23 09:21:08.858373	t	::1
89	korobosta	2025-05-23 09:23:10.808922	t	::1
90	korobosta	2025-05-23 12:23:09.549167	t	::1
91	korobosta	2025-05-23 12:34:58.134598	t	::1
92	korobosta	2025-05-23 12:53:24.251781	t	::1
93	korobosta	2025-05-23 12:55:20.494447	t	::1
94	korobosta	2025-05-27 11:28:31.662137	t	::1
95	korobosta	2025-05-29 10:11:14.531125	t	::1
96	korobosta	2025-06-04 11:09:54.526335	t	::1
97	korobosta	2025-06-04 15:04:26.41296	t	::1
98	korobosta	2025-06-04 16:02:23.45833	t	::1
99	korobosta	2025-06-05 09:06:50.889736	t	::1
100	korobosta	2025-06-09 12:11:39.232554	t	::1
101	korobosta	2025-06-09 12:30:10.876465	t	::1
102	korobosta	2025-06-09 12:32:23.301307	t	::1
103	korobosta	2025-06-09 12:38:17.858595	t	::1
104	korobosta	2025-06-09 12:41:04.705326	t	::1
105	korobosta	2025-06-09 12:41:22.266365	t	::1
106	korobosta	2025-06-09 12:57:01.348935	t	::1
107	korobosta	2025-06-09 12:57:03.563758	t	::1
108	korobosta	2025-06-09 12:58:09.015223	t	::1
109	korobosta	2025-06-09 15:34:12.835513	t	::1
110	korobosta	2025-07-02 15:34:36.142124	t	::1
111	korobosta	2025-07-02 15:43:28.719489	t	::1
112	korobosta	2025-07-02 15:53:14.806619	t	::1
113	korobosta	2025-07-02 15:53:16.006923	t	::1
114	korobosta	2025-07-02 15:53:16.88894	t	::1
115	korobosta	2025-07-02 15:53:17.60014	t	::1
116	korobosta	2025-07-02 15:53:18.118284	t	::1
117	korobosta	2025-07-02 15:53:18.808648	t	::1
118	korobosta	2025-07-02 15:53:56.154796	t	::1
119	korobosta	2025-07-02 15:55:26.83892	t	::1
120	korobosta	2025-07-02 15:55:28.08095	t	::1
121	korobosta	2025-07-02 15:55:28.875786	t	::1
122	korobosta	2025-07-02 15:55:29.074908	t	::1
123	korobosta	2025-07-02 15:55:29.354572	t	::1
124	korobosta	2025-07-02 15:55:29.908291	t	::1
125	korobosta	2025-07-02 15:55:30.068649	t	::1
126	korobosta	2025-07-02 15:55:30.260268	t	::1
127	korobosta	2025-07-02 15:55:30.439214	t	::1
128	korobosta	2025-07-02 15:55:31.830017	t	::1
129	korobosta	2025-07-02 15:55:32.044406	t	::1
130	korobosta	2025-07-02 15:55:32.262132	t	::1
131	korobosta	2025-07-02 15:55:32.433549	t	::1
132	korobosta	2025-07-02 15:55:32.633355	t	::1
133	korobosta	2025-07-02 15:55:32.836239	t	::1
134	korobosta	2025-07-02 15:55:33.225604	t	::1
135	korobosta	2025-07-02 15:55:35.586039	t	::1
136	korobosta	2025-07-02 15:55:36.651314	t	::1
137	korobosta	2025-07-02 15:55:37.380387	t	::1
138	korobosta	2025-07-02 15:55:37.979616	t	::1
139	korobosta	2025-07-02 15:55:38.51922	t	::1
140	korobosta	2025-07-02 15:55:40.467188	t	::1
141	korobosta	2025-07-02 15:55:41.947124	t	::1
142	korobosta	2025-07-02 15:55:42.55947	t	::1
143	korobosta	2025-07-02 15:12:04.457735	t	::1
144	korobosta	2025-07-02 15:12:05.738824	t	::1
145	korobosta	2025-07-02 15:12:06.248299	t	::1
146	korobosta	2025-07-02 15:12:06.799241	t	::1
147	korobosta	2025-07-02 15:12:07.129792	t	::1
148	korobosta	2025-07-02 15:12:07.349612	t	::1
149	korobosta	2025-07-02 15:12:07.541105	t	::1
150	korobosta	2025-07-02 15:12:07.74713	t	::1
151	korobosta	2025-07-02 15:12:07.949483	t	::1
152	korobosta	2025-07-02 15:12:08.136535	t	::1
153	korobosta	2025-07-02 15:12:08.360796	t	::1
154	korobosta	2025-07-02 15:12:08.575588	t	::1
155	korobosta	2025-07-02 15:12:08.820076	t	::1
156	korobosta	2025-07-02 15:12:09.026358	t	::1
157	korobosta	2025-07-02 15:46:50.321159	t	::1
158	korobosta	2025-07-02 15:50:19.755501	t	::1
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_clients (id, client_id, client_secret, name, scopes, created_at, require_user_token) FROM stdin;
1	korobosta	$2a$10$JrCxjilTa0.ADfs3N7lBEeRBhd46SUp47m7N5FBI1WO/z6RtXrH2S	hrm	{user-check}	2025-05-22 08:55:58.958379	f
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, name, description) FROM stdin;
9	can_add_user	\N
1	can_delete_users	\N
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_tokens (id, username, token, expires_at, created_at) FROM stdin;
44	korobosta	d17b0d19-c5b2-4f07-a0ed-b7018bcbb790	2025-05-27 15:43:29.992065	2025-05-20 15:43:29.993059
45	korobosta	d32baab3-8a12-4fb3-a96e-4b2e2b1b6434	2025-05-28 10:55:53.432356	2025-05-21 10:55:53.432618
46	korobosta	960ab3b6-a2e5-49dd-a27e-0caa020d11b9	2025-05-28 10:57:57.953553	2025-05-21 10:57:57.954168
47	korobosta	79e2fd25-89b6-4396-a4d4-cd0afe7e919f	2025-05-28 11:10:41.078579	2025-05-21 11:10:41.079436
48	korobosta	9322b232-e2dd-4f08-9a48-6e67702c7429	2025-05-28 11:14:00.330298	2025-05-21 11:14:00.331379
49	korobosta	fe7ea42b-9409-405a-9e91-88eb21591525	2025-05-28 11:32:41.903856	2025-05-21 11:32:41.904243
50	korobosta	66ded854-6fdf-4338-8db2-5b80ca041e58	2025-05-28 11:43:01.769863	2025-05-21 11:43:01.770095
51	korobosta	b2a70a4d-bc5a-4691-930a-be6908cff0f5	2025-05-28 11:54:47.075123	2025-05-21 11:54:47.07562
52	korobosta	279871c0-ac4a-4f28-be76-1b8abf83f1fa	2025-05-28 17:16:30.833269	2025-05-21 17:16:30.833433
53	korobosta	51353d91-e45f-428b-ab5c-f4c275c19ec9	2025-05-29 08:46:05.821098	2025-05-22 08:46:05.821466
54	korobosta	598b3f4a-ae9f-4e41-9517-ab9cbb760a73	2025-05-29 08:50:46.084716	2025-05-22 08:50:46.085044
55	korobosta	e92a2911-36a8-4420-bc33-d9d69be993d8	2025-05-29 09:17:16.258081	2025-05-22 09:17:16.258602
56	korobosta	8320e9d2-10df-4577-819b-d9282959c5fd	2025-05-29 10:06:53.101079	2025-05-22 10:06:53.101302
57	korobosta	5b988f2e-6452-47e4-85d3-a492f4da4cb3	2025-05-29 10:08:50.130466	2025-05-22 10:08:50.130765
58	korobosta	49b01199915ce59eadde39a002404326a480d1ce29a44f90a1d56882bf290616	2025-05-29 14:46:32.948003	2025-05-22 14:46:32.948821
59	korobosta	13af0c5146a93acb4e18e60334e0bc7c27510eb600bc931656448c8da468ddc1	2025-05-29 14:55:02.133944	2025-05-22 14:55:02.134202
60	korobosta	9690814ba812bbc843f082693dd85d6479b1157022ee40fd84a98d15f3198852	2025-05-29 14:58:24.53667	2025-05-22 14:58:24.536925
61	korobosta	a3bfbbcca68180cada73640184e720b927d03b575f5d3ef8cb680b46f375d9b2	2025-05-29 15:06:03.194098	2025-05-22 15:06:03.1948
62	korobosta	d990c12230044460f6d10e2ad8bdf504b0ac24f58a7909108cc0626891b1c079	2025-05-29 16:57:52.172038	2025-05-22 16:57:52.172743
63	korobosta	2980147c6aaf358acbce723c2dfe92684792856e8e05f474205491bf56584827	2025-05-30 09:21:08.867432	2025-05-23 09:21:08.868032
64	korobosta	4f6fe972490ee86f9e8143972508dbfe11f2b6857c3954ba016e1f796ce87f48	2025-05-30 09:23:10.81775	2025-05-23 09:23:10.818097
65	korobosta	d7826374f933bcff0743ed09d2f0f5b646cdcbafad6b1af3b5c604bc9e35bd06	2025-05-30 12:23:09.559851	2025-05-23 12:23:09.560181
66	korobosta	7ba2620543cad376b40aa2f3fcae5e22a0a9b22a46539db02e1dcff696ab338c	2025-05-30 12:34:58.146498	2025-05-23 12:34:58.146935
67	korobosta	160279bf3f05cb6ce08ea3073e70eaf8ade593a7862475e0e1414d0ea3768989	2025-05-30 12:53:24.263915	2025-05-23 12:53:24.264339
68	korobosta	d04f303ec8ff76bb29aa7786a092ad0143ebaf01c5f6adb99262a04456545ca8	2025-05-30 12:55:20.503628	2025-05-23 12:55:20.504433
69	korobosta	53898021b6952cfacc11323064afb817ff5a5fd682d9d23603738d23447f144f	2025-06-03 11:28:31.672618	2025-05-27 11:28:31.672847
70	korobosta	dedc5528bd630ea8d64915ad398d3a443e30ad7b1b2894c549e2a24f0578ea0f	2025-06-05 10:11:14.541044	2025-05-29 10:11:14.541346
71	korobosta	bc376f94b4107eaf568a40c3f82a3bffaa7f578bc5e0b6b9a24da58b03a51934	2025-06-11 11:09:54.537243	2025-06-04 11:09:54.537394
72	korobosta	92b685fca503cd469a5f79a2eaac15bb35cbbb05a170282027b12a2ed3cdcd0e	2025-06-11 15:04:26.419807	2025-06-04 15:04:26.42002
73	korobosta	788c10840ab34ccfde7302b6905730dd128f7165a690bc58fb3f6fe7210c86b8	2025-06-11 16:02:23.465775	2025-06-04 16:02:23.465997
74	korobosta	837ff68ad37e48582793799087cd6673f797f73310ee5938644e7fa6f117b123	2025-06-12 09:06:50.895848	2025-06-05 09:06:50.895978
75	korobosta	2d968b0f742442f1621cb8acd1d9133680dcb9e84ef4d4d29d6f46a99f46d152	2025-06-16 12:11:39.248538	2025-06-09 12:11:39.248847
76	korobosta	caccbff98b30e50face1d561f60864723368282b4adeb78fb8b144b21ca5b5ad	2025-06-16 12:30:10.88608	2025-06-09 12:30:10.886382
77	korobosta	e6cc9dfc953f351128c1c4a9fe1c08a6e7565e8cf4c26189c7d132469c353d5e	2025-06-16 12:32:23.311269	2025-06-09 12:32:23.311617
78	korobosta	a2bdff901d7873cdc5cb460fdf7efd3a2372ac8915602d3f73dee691bf4a85a6	2025-06-16 12:38:17.86775	2025-06-09 12:38:17.868194
79	korobosta	a6cf48d3a5b2ef42521345fcfb80e6b17f3ac7fe2ad78d373929fc3c27ec1321	2025-06-16 12:41:04.714012	2025-06-09 12:41:04.714366
80	korobosta	46b66c4b27c17e8cc913c427fe1702058decfd3c57cae109e35281a010042dd5	2025-06-16 12:41:22.275736	2025-06-09 12:41:22.276023
81	korobosta	ac97b941a377336a71329e164a82aec5744754cd34eb40fb61f213f7a78155ae	2025-06-16 12:57:01.355284	2025-06-09 12:57:01.355415
82	korobosta	96d5f861fce050c6bf60066999d6ecf1928f15cccdf00e4b7006bce25b8e518c	2025-06-16 12:57:03.569542	2025-06-09 12:57:03.569661
83	korobosta	b0be6a491bf561fb9a153f803edc174860b2d301a12d2f4c1d57c31ba794e034	2025-06-16 12:58:09.022825	2025-06-09 12:58:09.023242
84	korobosta	cebc99141e4cdb5a15184353db1ec32b55dc5705aa372c1e50f02c1cf23c4b30	2025-06-16 15:34:12.840213	2025-06-09 15:34:12.840344
85	korobosta	252e4f4e2b200801c2db1a990a067d72a5223b7a7d95565c03e1eb94bcbeb269	2025-07-09 15:34:36.152218	2025-07-02 15:34:36.152403
86	korobosta	0a0896e05776be62fc2b94579d9d3cb39db35d57365d97dbe679995a8a367a69	2025-07-09 15:43:28.72462	2025-07-02 15:43:28.724787
87	korobosta	b52ba4e981c5f3d1f1cc2aac8c5553f823dbe9f86498231fe3a20bfd9fb79146	2025-07-09 15:53:14.811755	2025-07-02 15:53:14.811878
88	korobosta	caaeb47c030a139ca7909b47a3fa6b0611dc0a6539ee7db5068aaf099fb9aaed	2025-07-09 15:53:16.011527	2025-07-02 15:53:16.011588
89	korobosta	e10d7523c176928dc0eed3d0eed2ae52330ea85cc5408668b20df91df7822c55	2025-07-09 15:53:16.895543	2025-07-02 15:53:16.895716
90	korobosta	0c647c3b092bc528402518b3f96812970139b21e4442699d83172ed6ac06b73c	2025-07-09 15:53:17.606292	2025-07-02 15:53:17.606404
91	korobosta	c094c4faaa7aa07474035c3abdc9e47a6634574f1646d2c359a6bfaed9e4b4c9	2025-07-09 15:53:18.124351	2025-07-02 15:53:18.124538
92	korobosta	07860e5622e59c0682e600d30af12b1cdcaa2b8ac37ca94a493fc4b5839b07a1	2025-07-09 15:53:18.814603	2025-07-02 15:53:18.814695
93	korobosta	dd214cba35dd7d1d608e5e7888f2a9070563844a3791938313dc29cbb51dfb82	2025-07-09 15:53:56.161356	2025-07-02 15:53:56.161523
94	korobosta	f48c9ada14ae4a5f04008268815bb86e95898b427013f5cf75eb38f9c2bac730	2025-07-09 15:55:26.84496	2025-07-02 15:55:26.845094
95	korobosta	ed0f791335edc09f3cf680daef32242cd8823e2eca83a6aba020e342aa50b7b9	2025-07-09 15:55:28.087555	2025-07-02 15:55:28.087654
96	korobosta	896f7fd295a5b2dbdc753a8b5353d51e79d61aecda7fb7430879c11da3325717	2025-07-09 15:55:28.881723	2025-07-02 15:55:28.881911
97	korobosta	cf6f3164c883fc1c77c5d4267d943a60b66d0c0bd0f641a9ad8a5464866e12b7	2025-07-09 15:55:29.081459	2025-07-02 15:55:29.081658
98	korobosta	df1f284a53e33ce3fbbb6edcca08e5a8b2aef2d53c251b4afba3284a20a51046	2025-07-09 15:55:29.359986	2025-07-02 15:55:29.360078
99	korobosta	5480f93fd218373a2db4584353e4cf5cf1f1665737728edfe026b3a297b67316	2025-07-09 15:55:29.914699	2025-07-02 15:55:29.914953
100	korobosta	272d613afd75c38bf6b389a32fdc09e7fb11d7de4d7d2e88252431e70ebaa53b	2025-07-09 15:55:30.073968	2025-07-02 15:55:30.074381
101	korobosta	4c2ff53b68efead103a672287735cec816f3e192d39cdeac5acb1934b5eb9f2a	2025-07-09 15:55:30.266367	2025-07-02 15:55:30.266461
102	korobosta	9c2b4285609d8bf39fff547e07ce51f3fbc2227ed11b04a33c32f4741bdd4199	2025-07-09 15:55:30.444552	2025-07-02 15:55:30.444868
103	korobosta	2b72d4c1ffb7b8d8cb15f374b0e2273cdda3ef74fa0857043b81c6664065d377	2025-07-09 15:55:31.835239	2025-07-02 15:55:31.835415
104	korobosta	f59ab4b57518c568f5d7e554298119651669658aa5ea29377b287b8f7bc2ae51	2025-07-09 15:55:32.051041	2025-07-02 15:55:32.051178
105	korobosta	3abd71847d35f6171d0ab4ae53f25d6b4664d09529c530c85c309cb216237592	2025-07-09 15:55:32.266657	2025-07-02 15:55:32.266958
106	korobosta	eb5fa5cebd9c9ebbd1f3e691cfec8b51a611d0e2ff8c04f8c330abb38ab68180	2025-07-09 15:55:32.439775	2025-07-02 15:55:32.439904
107	korobosta	e55fe4e79b552937b672fa3865a71d07dbc477908a56ce3c30310613d30c8bd5	2025-07-09 15:55:32.638566	2025-07-02 15:55:32.638653
108	korobosta	fed60afc306aa33fa2e8c56d14bd7be5dedf1c9cb464aa767cfa81ad4b7d8f73	2025-07-09 15:55:32.842777	2025-07-02 15:55:32.842874
109	korobosta	38f2c18b80b6fb2b35b4ab71e768440860bc2c7ee4c4a74539d36931a6d06d5a	2025-07-09 15:55:33.232268	2025-07-02 15:55:33.232658
110	korobosta	b13f1995990d2b1ac147fb5f39d43d530a1f0e322b3f815a440c37b0ece66a20	2025-07-09 15:55:35.591424	2025-07-02 15:55:35.59148
111	korobosta	a0c937b5abf6e6200b6001586ed7c48b5e5f718a354b6e48e448fb0b2ee75c80	2025-07-09 15:55:36.657628	2025-07-02 15:55:36.657759
112	korobosta	abb2859951da98c2bf3116e80b75c405db6c3255fd573c18801fe3782453317f	2025-07-09 15:55:37.386582	2025-07-02 15:55:37.38681
113	korobosta	111ae96a207bec0cd6324c8332f5be6fec3143d04d94963997cbb313a7cf684e	2025-07-09 15:55:37.984744	2025-07-02 15:55:37.984887
114	korobosta	6c478bc0fb1089b90c97350b00bdc8760bafe3708b86eca03a98df4f8ee38e8a	2025-07-09 15:55:38.526381	2025-07-02 15:55:38.526614
115	korobosta	4f8f4ef9779b08686851c986845d05c4535592eadd59af1c9b2221244506fa55	2025-07-09 15:55:40.473344	2025-07-02 15:55:40.473472
116	korobosta	df83d00b2e40bd8e018a95a8af55d8bf95306bd8232fc7a381cc62d1df0d4f57	2025-07-09 15:55:41.953909	2025-07-02 15:55:41.954046
117	korobosta	b43c26cfc3f9f419eca2be2aecb134c7ade262c6a1a756ee501c35c1a9e0981d	2025-07-09 15:55:42.562562	2025-07-02 15:55:42.562635
118	korobosta	0f719a866e7e27d2a60a123cf6760203867ca0682a2b3c009f58c90522e2fdfb	2025-07-09 15:12:04.463054	2025-07-02 15:12:04.463213
119	korobosta	55703accfc22ca6d924c03ff9d2844e677eeaeb105502e684592e980cf6c1c13	2025-07-09 15:12:05.745388	2025-07-02 15:12:05.745524
120	korobosta	4675f5d8d9756377547ed7f9603ca50d9355a3b330a3e40612ea62e0560db75b	2025-07-09 15:12:06.25372	2025-07-02 15:12:06.253885
121	korobosta	640aca6315c42d7d18a6be22eb416b5d9fc75f6951e7757b66ba5e0a8c38dae4	2025-07-09 15:12:06.805164	2025-07-02 15:12:06.805523
122	korobosta	d907cc5af9ca17b46a6826b05c96c7f9ceb84197b08745ff27855643e44d5f33	2025-07-09 15:12:07.134832	2025-07-02 15:12:07.134899
123	korobosta	5388db2ce10cba72c6bda3808011d0b84873965040b3e6ba7d2b330b563a227b	2025-07-09 15:12:07.353993	2025-07-02 15:12:07.354049
124	korobosta	a1756378499a7bbe0f768e4bb66b5e483add4a224c9cf75d857b526db36af096	2025-07-09 15:12:07.547625	2025-07-02 15:12:07.547757
125	korobosta	0ec329b1a240ecf6c2b9f0242dd1922db2f193d8d1d241aefd120da409cbeac9	2025-07-09 15:12:07.753658	2025-07-02 15:12:07.753928
126	korobosta	45dee7f102359f2532c184dff0909afeb6e09e1f3c72e7d5e45e2285e7a89d55	2025-07-09 15:12:07.955709	2025-07-02 15:12:07.955804
127	korobosta	a59bb57eeeb6091beb5557281fb59cb1d5dace54b63daf1064482597092d9ab7	2025-07-09 15:12:08.14216	2025-07-02 15:12:08.142569
128	korobosta	ed5854b0619685d66aba5a10e9904ef7a71fc667f11ab6ed5c74456b6a6d1ac2	2025-07-09 15:12:08.367477	2025-07-02 15:12:08.367639
129	korobosta	d9b8fe8380704fbf1bfd0975af2498456af92f97356be716ac9dcdc0dc3e891f	2025-07-09 15:12:08.581963	2025-07-02 15:12:08.582148
130	korobosta	ca7bd7cc225b351f37a80c65c295b64f587dbfbdfcd0a3aa3ec859b934bc5544	2025-07-09 15:12:08.826495	2025-07-02 15:12:08.826629
131	korobosta	59248226fd2f634f31015b1ae6112920e25dde0d2a655b2bba5455a6b13baf3b	2025-07-09 15:12:09.033475	2025-07-02 15:12:09.033666
132	korobosta	0d445d811f2a2faaabdd886161a0319758b13cb92cc3f89a87c0c554d0dfb651	2025-07-09 15:46:50.327646	2025-07-02 15:46:50.327777
133	korobosta	175d22c5910bd7121fb05e7f3c0989a5f0e58d7e263d7831732808b02212b6a2	2025-07-09 15:50:19.761496	2025-07-02 15:50:19.761637
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (role_id, permission_id) FROM stdin;
6	1
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, description) FROM stdin;
7	Technician	Technician
6	Software Developer	Fullstcck software developer
5	Senior Manager	Senior Manager
8	Ceo	Ceo
3	Admin2	Admin Two
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (role_id, user_id) FROM stdin;
3	1d936902-b271-40cc-967c-c7291e4cc421
6	1d936902-b271-40cc-967c-c7291e4cc421
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (username, password, created_at, updated_at, phone_number, id_number, email, id_type_id, first_name, last_name, id) FROM stdin;
omundu	$2a$10$R2RBfqvQEiGk2hhFriKQ.umur76622zXkyhlPo7pXk2.o4zhc5ODK	2025-06-10 10:39:15.243214	\N	0713887070	32414225	omunduomulosi@gmail.com	1	omundu	omulosi	3893b972-11c5-48be-9885-ab85d7f26ece
korobosta	$2a$10$3Y0YkPMsqTjvxeDghgR.0eKPWkSf4AkGg7BbRMf5DbLFbh7eIlA2K	2025-05-20 15:41:39.547361	\N	0773492943	32414200	kevinkorobosta@gmail.com	1	Kevin	Korobosta	1d936902-b271-40cc-967c-c7291e4cc421
\.


--
-- Name: identity_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.identity_types_id_seq', 6, true);


--
-- Name: logged_in_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logged_in_attempts_id_seq', 158, true);


--
-- Name: oauth_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth_clients_id_seq', 2, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 10, true);


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 133, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 9, true);


--
-- Name: identity_types identity_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_types
    ADD CONSTRAINT identity_types_name_key UNIQUE (name);


--
-- Name: identity_types identity_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_types
    ADD CONSTRAINT identity_types_pkey PRIMARY KEY (id);


--
-- Name: logged_in_attempts logged_in_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logged_in_attempts
    ADD CONSTRAINT logged_in_attempts_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_client_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_clients
    ADD CONSTRAINT oauth_clients_client_id_key UNIQUE (client_id);


--
-- Name: oauth_clients oauth_clients_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_clients
    ADD CONSTRAINT oauth_clients_name_key UNIQUE (name);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_key UNIQUE (name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: permissions unique_permission_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT unique_permission_name UNIQUE (name);


--
-- Name: roles unique_role_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT unique_role_name UNIQUE (name);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: fki_i; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_i ON public.users USING btree (id_type_id);


--
-- Name: idx_attempts_ip_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_attempts_ip_time ON public.logged_in_attempts USING btree (ip_address, attempt_time);


--
-- Name: idx_attempts_username_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_attempts_username_time ON public.logged_in_attempts USING btree (username, attempt_time);


--
-- Name: refresh_tokens refresh_tokens_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_username_fkey FOREIGN KEY (username) REFERENCES public.users(username) ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;


--
-- Name: users users_id_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_type_id_fkey FOREIGN KEY (id_type_id) REFERENCES public.identity_types(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

