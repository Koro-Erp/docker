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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: app_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_logs (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    service_name character varying(100) NOT NULL,
    user_identifier text,
    level character varying(20) NOT NULL,
    message text NOT NULL,
    stack_trace text,
    extra_data jsonb
);


ALTER TABLE public.app_logs OWNER TO postgres;

--
-- Name: app_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.app_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.app_logs_id_seq OWNER TO postgres;

--
-- Name: app_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.app_logs_id_seq OWNED BY public.app_logs.id;


--
-- Name: gateway_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gateway_logs (
    id integer NOT NULL,
    service_name character varying(100) NOT NULL,
    user_identifier text,
    client_ip character varying(100),
    request_method character varying(10),
    request_url text,
    request_headers jsonb,
    request_body text,
    response_status integer,
    response_body text,
    duration_ms bigint,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.gateway_logs OWNER TO postgres;

--
-- Name: gateway_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gateway_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gateway_logs_id_seq OWNER TO postgres;

--
-- Name: gateway_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gateway_logs_id_seq OWNED BY public.gateway_logs.id;


--
-- Name: app_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_logs ALTER COLUMN id SET DEFAULT nextval('public.app_logs_id_seq'::regclass);


--
-- Name: gateway_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gateway_logs ALTER COLUMN id SET DEFAULT nextval('public.gateway_logs_id_seq'::regclass);


--
-- Data for Name: app_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_logs (id, "timestamp", service_name, user_identifier, level, message, stack_trace, extra_data) FROM stdin;
2	2025-07-03 14:52:10.169728+03	hrm	koros	error	Employee exists		null
3	2025-07-10 09:02:37.993391+03	hrm	koros	error	Employee exists		null
4	2025-07-10 09:10:51.622134+03	hrm	koros	error	Tried to add employee id1d936902-b271-40cc-967c-c7291e4cc421 that already exists		null
5	2025-07-10 09:18:24.302434+03	hrm	koros	error	Tried to add employee with id 1d936902-b271-40cc-967c-c7291e4cc421 that already exists	{'file':'internal/handlers/employees.go','function':'CreateEmployee'}	null
6	2025-07-10 09:34:22.639744+03	hrm	koros	error	Tried to add employee with id 1d936902-b271-40cc-967c-c7291e4cc421 that already exists	{'file':'internal/handlers/employees.go','function':'CreateEmployee'}	null
7	2025-07-10 09:38:43.788644+03	hrm	koros	error	Tried to add employee with id 1d936902-b271-40cc-967c-c7291e4cc421 that already exists	{'file':'internal/handlers/employees.go','function':'CreateEmployee'}	null
8	2025-07-10 11:37:30.582446+03	hrm	koros	error	Tried to add employee with id 1d936902-b271-40cc-967c-c7291e4cc421 that already exists	{'file':'internal/handlers/employees.go','function':'CreateEmployee'}	null
9	2025-07-10 12:27:49.127999+03	hrm	koros	error	Tried to add employee with id 1d936902-b271-40cc-967c-c7291e4cc421 that already exists	{'file':'internal/handlers/employees.go','function':'CreateEmployee'}	null
10	2025-07-10 12:29:56.392927+03	hrm	koros	error	Tried to add employee with id 1d936902-b271-40cc-967c-c7291e4cc421 that already exists	{'file':'internal/handlers/employees.go','function':'CreateEmployee'}	null
11	2025-07-10 12:31:36.693203+03	hrm	koros	error	Tried to add employee with id 1d936902-b271-40cc-967c-c7291e4cc421 that already exists	{'file':'internal/handlers/employees.go','function':'CreateEmployee'}	null
\.


--
-- Data for Name: gateway_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gateway_logs (id, service_name, user_identifier, client_ip, request_method, request_url, request_headers, request_body, response_status, response_body, duration_ms, "timestamp") FROM stdin;
1	gateway	hrm	172.18.0.1	POST	/api/v1/employees	"{\\"Accept\\":[\\"*/*\\"],\\"Accept-Encoding\\":[\\"gzip, deflate, br\\"],\\"Authorization\\":[\\"***\\"],\\"Cache-Control\\":[\\"no-cache\\"],\\"Connection\\":[\\"keep-alive\\"],\\"Content-Length\\":[\\"205\\"],\\"Content-Type\\":[\\"application/json\\"],\\"Cookie\\":[\\"JSESSIONID=86A9EF36B5A30A8970846C495FC7ECEB\\"],\\"Postman-Token\\":[\\"4836700b-8d31-4960-ace1-29a94b350f17\\"],\\"User-Agent\\":[\\"PostmanRuntime/7.39.1\\"]}"	{"department_id":1,"hire_date":"2025-05-21T12:50:00Z","id":"1d936902-b271-40cc-967c-c7291e4cc421","position_id":9,"salary":250000,"status":"active","supervisor_id":null}	400	{"code":400,"message":"Employee ID already exists"}	18	2025-07-10 11:30:19.206886+03
2	gateway	hrm	172.18.0.1	POST	/api/v1/employees	"{\\"Accept\\":[\\"*/*\\"],\\"Accept-Encoding\\":[\\"gzip, deflate, br\\"],\\"Authorization\\":[\\"***\\"],\\"Cache-Control\\":[\\"no-cache\\"],\\"Connection\\":[\\"keep-alive\\"],\\"Content-Length\\":[\\"205\\"],\\"Content-Type\\":[\\"application/json\\"],\\"Cookie\\":[\\"JSESSIONID=86A9EF36B5A30A8970846C495FC7ECEB\\"],\\"Postman-Token\\":[\\"5ae6c263-5a20-4cf4-b98d-431be0cf6677\\"],\\"User-Agent\\":[\\"PostmanRuntime/7.39.1\\"]}"	{"department_id":1,"hire_date":"2025-05-21T12:50:00Z","id":"1d936902-b271-40cc-967c-c7291e4cc421","position_id":9,"salary":250000,"status":"active","supervisor_id":null}	400	{"code":400,"message":"Employee ID already exists"}	12	2025-07-10 11:37:30.582896+03
3	gateway	hrm	172.18.0.1	POST	/api/v1/employees	{"Accept": ["*/*"], "Cookie": ["JSESSIONID=86A9EF36B5A30A8970846C495FC7ECEB"], "Connection": ["keep-alive"], "User-Agent": ["PostmanRuntime/7.39.1"], "Content-Type": ["application/json"], "Authorization": ["***"], "Cache-Control": ["no-cache"], "Postman-Token": ["85a5c516-58c4-4a48-9989-d0ccffd8b757"], "Content-Length": ["205"], "Accept-Encoding": ["gzip, deflate, br"]}	{"department_id":1,"hire_date":"2025-05-21T12:50:00Z","id":"1d936902-b271-40cc-967c-c7291e4cc421","position_id":9,"salary":250000,"status":"active","supervisor_id":null}	400	{"code":400,"message":"Employee ID already exists"}	12	2025-07-10 12:15:40.463258+03
4	gateway	hrm	172.18.0.1	POST	/api/v1/employees	{"Accept": ["*/*"], "Cookie": ["JSESSIONID=86A9EF36B5A30A8970846C495FC7ECEB"], "Connection": ["keep-alive"], "User-Agent": ["PostmanRuntime/7.39.1"], "Content-Type": ["application/json"], "Authorization": ["***"], "Cache-Control": ["no-cache"], "Postman-Token": ["6b20da7f-5df5-46ab-9a7c-2c91f190913c"], "Content-Length": ["205"], "Accept-Encoding": ["gzip, deflate, br"]}	{"department_id":1,"hire_date":"2025-05-21T12:50:00Z","id":"1d936902-b271-40cc-967c-c7291e4cc421","position_id":9,"salary":250000,"status":"active","supervisor_id":null}	400	{"code":400,"message":"Employee ID already exists"}	16	2025-07-10 12:27:49.12799+03
5	gateway	hrm	172.18.0.1	POST	/api/v1/employees	{"Accept": ["*/*"], "Cookie": ["JSESSIONID=86A9EF36B5A30A8970846C495FC7ECEB"], "Connection": ["keep-alive"], "User-Agent": ["PostmanRuntime/7.39.1"], "Content-Type": ["application/json"], "Authorization": ["***"], "Cache-Control": ["no-cache"], "Postman-Token": ["a4398dc9-0418-41c8-b76b-876eab2b9e81"], "Content-Length": ["205"], "Accept-Encoding": ["gzip, deflate, br"]}	{"department_id":1,"hire_date":"2025-05-21T12:50:00Z","id":"1d936902-b271-40cc-967c-c7291e4cc421","position_id":9,"salary":250000,"status":"active","supervisor_id":null}	400	{"code":400,"message":"Employee ID already exists"}	18	2025-07-10 12:29:56.393704+03
6	gateway	hrm	172.18.0.1	POST	/api/v1/employees	{"Accept": ["*/*"], "Cookie": ["JSESSIONID=86A9EF36B5A30A8970846C495FC7ECEB"], "Connection": ["keep-alive"], "User-Agent": ["PostmanRuntime/7.39.1"], "Content-Type": ["application/json"], "Authorization": ["***"], "Cache-Control": ["no-cache"], "Postman-Token": ["b6c5e7e5-5bd3-4e3a-853e-e83d699a26ea"], "Content-Length": ["205"], "Accept-Encoding": ["gzip, deflate, br"]}	{"department_id":1,"hire_date":"2025-05-21T12:50:00Z","id":"1d936902-b271-40cc-967c-c7291e4cc421","position_id":9,"salary":250000,"status":"active","supervisor_id":null}	400	{"code":400,"message":"Employee ID already exists"}	4	2025-07-10 12:31:36.693994+03
\.


--
-- Name: app_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.app_logs_id_seq', 11, true);


--
-- Name: gateway_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gateway_logs_id_seq', 6, true);


--
-- Name: app_logs app_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_logs
    ADD CONSTRAINT app_logs_pkey PRIMARY KEY (id);


--
-- Name: gateway_logs gateway_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gateway_logs
    ADD CONSTRAINT gateway_logs_pkey PRIMARY KEY (id);


--
-- Name: idx_app_logs_level; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_app_logs_level ON public.app_logs USING btree (level);


--
-- Name: idx_app_logs_service; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_app_logs_service ON public.app_logs USING btree (service_name);


--
-- Name: idx_app_logs_timestamp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_app_logs_timestamp ON public.app_logs USING btree ("timestamp");


--
-- PostgreSQL database dump complete
--

