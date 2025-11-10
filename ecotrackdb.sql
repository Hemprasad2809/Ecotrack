--
-- PostgreSQL database dump
--

\restrict qWMbJOSVgPR3vTm9x5dzR8w6jWX7nLe1ol5pHKbPBbCOo9flGB1tzHHldzXcyk3

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-11-09 22:48:41

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 25599)
-- Name: blood_donor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blood_donor (
    id integer NOT NULL,
    user_id integer NOT NULL,
    blood_type character varying(5) NOT NULL,
    phone_number character varying(15) NOT NULL,
    location character varying(200) NOT NULL,
    is_available boolean
);


ALTER TABLE public.blood_donor OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25598)
-- Name: blood_donor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blood_donor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.blood_donor_id_seq OWNER TO postgres;

--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 229
-- Name: blood_donor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blood_donor_id_seq OWNED BY public.blood_donor.id;


--
-- TOC entry 232 (class 1259 OID 25611)
-- Name: blood_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blood_request (
    id integer NOT NULL,
    user_id integer NOT NULL,
    blood_type character varying(5) NOT NULL,
    urgency character varying(20) NOT NULL,
    location character varying(200) NOT NULL,
    status character varying(20)
);


ALTER TABLE public.blood_request OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25610)
-- Name: blood_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blood_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.blood_request_id_seq OWNER TO postgres;

--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 231
-- Name: blood_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blood_request_id_seq OWNED BY public.blood_request.id;


--
-- TOC entry 234 (class 1259 OID 25623)
-- Name: booking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking (
    id integer NOT NULL,
    user_id integer NOT NULL,
    slot_id integer NOT NULL,
    booking_date date NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    status character varying(20),
    otp integer
);


ALTER TABLE public.booking OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 25622)
-- Name: booking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_id_seq OWNER TO postgres;

--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 233
-- Name: booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_id_seq OWNED BY public.booking.id;


--
-- TOC entry 224 (class 1259 OID 25561)
-- Name: contact_form_submission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_form_submission (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    subject character varying(200) NOT NULL,
    message text NOT NULL,
    "timestamp" timestamp without time zone
);


ALTER TABLE public.contact_form_submission OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25560)
-- Name: contact_form_submission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_form_submission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contact_form_submission_id_seq OWNER TO postgres;

--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 223
-- Name: contact_form_submission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_form_submission_id_seq OWNED BY public.contact_form_submission.id;


--
-- TOC entry 226 (class 1259 OID 25570)
-- Name: food_donation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.food_donation (
    id integer NOT NULL,
    user_id integer NOT NULL,
    orphanage_id integer NOT NULL,
    food_type character varying(50) NOT NULL,
    quantity double precision NOT NULL,
    pickup_time timestamp without time zone NOT NULL,
    pickup_place character varying(200) NOT NULL,
    status character varying(20)
);


ALTER TABLE public.food_donation OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25569)
-- Name: food_donation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.food_donation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.food_donation_id_seq OWNER TO postgres;

--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 225
-- Name: food_donation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.food_donation_id_seq OWNED BY public.food_donation.id;


--
-- TOC entry 220 (class 1259 OID 25547)
-- Name: orphanage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orphanage (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    address character varying(200) NOT NULL,
    contact_number character varying(15) NOT NULL
);


ALTER TABLE public.orphanage OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25546)
-- Name: orphanage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orphanage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orphanage_id_seq OWNER TO postgres;

--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 219
-- Name: orphanage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orphanage_id_seq OWNED BY public.orphanage.id;


--
-- TOC entry 222 (class 1259 OID 25554)
-- Name: parking_lot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parking_lot (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    total_bike_slots integer,
    total_car_slots integer
);


ALTER TABLE public.parking_lot OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25553)
-- Name: parking_lot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.parking_lot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.parking_lot_id_seq OWNER TO postgres;

--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 221
-- Name: parking_lot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parking_lot_id_seq OWNED BY public.parking_lot.id;


--
-- TOC entry 228 (class 1259 OID 25587)
-- Name: parking_slot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parking_slot (
    id integer NOT NULL,
    lot_id integer NOT NULL,
    slot_type character varying(10) NOT NULL,
    status character varying(10),
    "current_user" character varying(100),
    allotted_time time without time zone,
    expiry_time time without time zone
);


ALTER TABLE public.parking_slot OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25586)
-- Name: parking_slot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.parking_slot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.parking_slot_id_seq OWNER TO postgres;

--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 227
-- Name: parking_slot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parking_slot_id_seq OWNED BY public.parking_slot.id;


--
-- TOC entry 218 (class 1259 OID 25534)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password text NOT NULL,
    phone_number character varying(15),
    points integer,
    badge character varying(50),
    is_admin boolean
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25533)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO postgres;

--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 217
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 4741 (class 2604 OID 25602)
-- Name: blood_donor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_donor ALTER COLUMN id SET DEFAULT nextval('public.blood_donor_id_seq'::regclass);


--
-- TOC entry 4742 (class 2604 OID 25614)
-- Name: blood_request id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_request ALTER COLUMN id SET DEFAULT nextval('public.blood_request_id_seq'::regclass);


--
-- TOC entry 4743 (class 2604 OID 25626)
-- Name: booking id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking ALTER COLUMN id SET DEFAULT nextval('public.booking_id_seq'::regclass);


--
-- TOC entry 4738 (class 2604 OID 25564)
-- Name: contact_form_submission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_form_submission ALTER COLUMN id SET DEFAULT nextval('public.contact_form_submission_id_seq'::regclass);


--
-- TOC entry 4739 (class 2604 OID 25573)
-- Name: food_donation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_donation ALTER COLUMN id SET DEFAULT nextval('public.food_donation_id_seq'::regclass);


--
-- TOC entry 4736 (class 2604 OID 25550)
-- Name: orphanage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orphanage ALTER COLUMN id SET DEFAULT nextval('public.orphanage_id_seq'::regclass);


--
-- TOC entry 4737 (class 2604 OID 25557)
-- Name: parking_lot id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parking_lot ALTER COLUMN id SET DEFAULT nextval('public.parking_lot_id_seq'::regclass);


--
-- TOC entry 4740 (class 2604 OID 25590)
-- Name: parking_slot id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parking_slot ALTER COLUMN id SET DEFAULT nextval('public.parking_slot_id_seq'::regclass);


--
-- TOC entry 4735 (class 2604 OID 25537)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 4931 (class 0 OID 25599)
-- Dependencies: 230
-- Data for Name: blood_donor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blood_donor (id, user_id, blood_type, phone_number, location, is_available) FROM stdin;
1	1	AB-	9841602444		t
2	1	AB-	9841602444		t
\.


--
-- TOC entry 4933 (class 0 OID 25611)
-- Dependencies: 232
-- Data for Name: blood_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blood_request (id, user_id, blood_type, urgency, location, status) FROM stdin;
1	1	AB-	Normal	Apollo	Pending
2	1	AB-	Normal	Apollo	Pending
3	1	AB-	Normal	Apollo	Pending
4	1	AB-	Normal	Apollo	Pending
5	1	AB-	Normal	Apollo	Pending
6	1	AB-	Normal	Apollo	Pending
7	1	AB-	Normal	Apollo	Pending
8	1	AB-	Normal	Apollo	Pending
9	1	AB-	Normal	Apollo	Pending
10	1	AB-	Normal	Apollo	Pending
\.


--
-- TOC entry 4935 (class 0 OID 25623)
-- Dependencies: 234
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking (id, user_id, slot_id, booking_date, start_time, end_time, status, otp) FROM stdin;
1	1	1	2025-11-06	04:34:00	07:34:00	Active	284135
\.


--
-- TOC entry 4925 (class 0 OID 25561)
-- Dependencies: 224
-- Data for Name: contact_form_submission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_form_submission (id, name, email, subject, message, "timestamp") FROM stdin;
\.


--
-- TOC entry 4927 (class 0 OID 25570)
-- Dependencies: 226
-- Data for Name: food_donation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.food_donation (id, user_id, orphanage_id, food_type, quantity, pickup_time, pickup_place, status) FROM stdin;
1	1	4	cooked	2	2025-11-06 02:22:00	Gate	Scheduled
2	1	3	cooked	2	2025-11-06 02:24:00	Gate	Scheduled
\.


--
-- TOC entry 4921 (class 0 OID 25547)
-- Dependencies: 220
-- Data for Name: orphanage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orphanage (id, name, address, contact_number) FROM stdin;
1	Hope Children's Home	123 Anna Salai, Chennai, Tamil Nadu 600002	9841602444
2	Sunshine Orphanage	45 Mount Road, Chennai, Tamil Nadu 600015	9841602444
3	St. Mary's Orphanage	78 Cathedral Road, Chennai, Tamil Nadu 600086	9841602444
4	Little Hearts Home	12 T. Nagar, Chennai, Tamil Nadu 600017	9841602444
5	Chennai Children's Shelter	5 Besant Avenue, Adyar, Chennai, Tamil Nadu 600020	9841602444
\.


--
-- TOC entry 4923 (class 0 OID 25554)
-- Dependencies: 222
-- Data for Name: parking_lot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parking_lot (id, name, total_bike_slots, total_car_slots) FROM stdin;
1	Main Campus Lot	100	50
2	North Gate Lot	80	40
3	Library Lot	60	30
\.


--
-- TOC entry 4929 (class 0 OID 25587)
-- Dependencies: 228
-- Data for Name: parking_slot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parking_slot (id, lot_id, slot_type, status, "current_user", allotted_time, expiry_time) FROM stdin;
2	1	Bike	Vacant	\N	\N	\N
3	1	Bike	Vacant	\N	\N	\N
4	1	Bike	Vacant	\N	\N	\N
5	1	Bike	Vacant	\N	\N	\N
6	1	Bike	Vacant	\N	\N	\N
7	1	Bike	Vacant	\N	\N	\N
8	1	Bike	Vacant	\N	\N	\N
9	1	Bike	Vacant	\N	\N	\N
10	1	Bike	Vacant	\N	\N	\N
11	1	Bike	Vacant	\N	\N	\N
12	1	Bike	Vacant	\N	\N	\N
13	1	Bike	Vacant	\N	\N	\N
14	1	Bike	Vacant	\N	\N	\N
15	1	Bike	Vacant	\N	\N	\N
16	1	Bike	Vacant	\N	\N	\N
17	1	Bike	Vacant	\N	\N	\N
18	1	Bike	Vacant	\N	\N	\N
19	1	Bike	Vacant	\N	\N	\N
20	1	Bike	Vacant	\N	\N	\N
21	1	Bike	Vacant	\N	\N	\N
22	1	Bike	Vacant	\N	\N	\N
23	1	Bike	Vacant	\N	\N	\N
24	1	Bike	Vacant	\N	\N	\N
25	1	Bike	Vacant	\N	\N	\N
26	1	Bike	Vacant	\N	\N	\N
27	1	Bike	Vacant	\N	\N	\N
28	1	Bike	Vacant	\N	\N	\N
29	1	Bike	Vacant	\N	\N	\N
30	1	Bike	Vacant	\N	\N	\N
31	1	Bike	Vacant	\N	\N	\N
32	1	Bike	Vacant	\N	\N	\N
33	1	Bike	Vacant	\N	\N	\N
34	1	Bike	Vacant	\N	\N	\N
35	1	Bike	Vacant	\N	\N	\N
36	1	Bike	Vacant	\N	\N	\N
37	1	Bike	Vacant	\N	\N	\N
38	1	Bike	Vacant	\N	\N	\N
39	1	Bike	Vacant	\N	\N	\N
40	1	Bike	Vacant	\N	\N	\N
41	1	Bike	Vacant	\N	\N	\N
42	1	Bike	Vacant	\N	\N	\N
43	1	Bike	Vacant	\N	\N	\N
44	1	Bike	Vacant	\N	\N	\N
45	1	Bike	Vacant	\N	\N	\N
46	1	Bike	Vacant	\N	\N	\N
47	1	Bike	Vacant	\N	\N	\N
48	1	Bike	Vacant	\N	\N	\N
49	1	Bike	Vacant	\N	\N	\N
50	1	Bike	Vacant	\N	\N	\N
51	1	Bike	Vacant	\N	\N	\N
52	1	Bike	Vacant	\N	\N	\N
53	1	Bike	Vacant	\N	\N	\N
54	1	Bike	Vacant	\N	\N	\N
55	1	Bike	Vacant	\N	\N	\N
56	1	Bike	Vacant	\N	\N	\N
57	1	Bike	Vacant	\N	\N	\N
58	1	Bike	Vacant	\N	\N	\N
59	1	Bike	Vacant	\N	\N	\N
60	1	Bike	Vacant	\N	\N	\N
61	1	Bike	Vacant	\N	\N	\N
62	1	Bike	Vacant	\N	\N	\N
63	1	Bike	Vacant	\N	\N	\N
64	1	Bike	Vacant	\N	\N	\N
65	1	Bike	Vacant	\N	\N	\N
66	1	Bike	Vacant	\N	\N	\N
67	1	Bike	Vacant	\N	\N	\N
68	1	Bike	Vacant	\N	\N	\N
69	1	Bike	Vacant	\N	\N	\N
70	1	Bike	Vacant	\N	\N	\N
71	1	Bike	Vacant	\N	\N	\N
72	1	Bike	Vacant	\N	\N	\N
73	1	Bike	Vacant	\N	\N	\N
74	1	Bike	Vacant	\N	\N	\N
75	1	Bike	Vacant	\N	\N	\N
76	1	Bike	Vacant	\N	\N	\N
77	1	Bike	Vacant	\N	\N	\N
78	1	Bike	Vacant	\N	\N	\N
79	1	Bike	Vacant	\N	\N	\N
80	1	Bike	Vacant	\N	\N	\N
81	1	Bike	Vacant	\N	\N	\N
82	1	Bike	Vacant	\N	\N	\N
83	1	Bike	Vacant	\N	\N	\N
84	1	Bike	Vacant	\N	\N	\N
85	1	Bike	Vacant	\N	\N	\N
86	1	Bike	Vacant	\N	\N	\N
87	1	Bike	Vacant	\N	\N	\N
88	1	Bike	Vacant	\N	\N	\N
89	1	Bike	Vacant	\N	\N	\N
90	1	Bike	Vacant	\N	\N	\N
91	1	Bike	Vacant	\N	\N	\N
92	1	Bike	Vacant	\N	\N	\N
93	1	Bike	Vacant	\N	\N	\N
94	1	Bike	Vacant	\N	\N	\N
95	1	Bike	Vacant	\N	\N	\N
96	1	Bike	Vacant	\N	\N	\N
97	1	Bike	Vacant	\N	\N	\N
98	1	Bike	Vacant	\N	\N	\N
99	1	Bike	Vacant	\N	\N	\N
100	1	Bike	Vacant	\N	\N	\N
101	1	Car	Vacant	\N	\N	\N
102	1	Car	Vacant	\N	\N	\N
103	1	Car	Vacant	\N	\N	\N
104	1	Car	Vacant	\N	\N	\N
105	1	Car	Vacant	\N	\N	\N
106	1	Car	Vacant	\N	\N	\N
107	1	Car	Vacant	\N	\N	\N
108	1	Car	Vacant	\N	\N	\N
109	1	Car	Vacant	\N	\N	\N
110	1	Car	Vacant	\N	\N	\N
111	1	Car	Vacant	\N	\N	\N
112	1	Car	Vacant	\N	\N	\N
113	1	Car	Vacant	\N	\N	\N
114	1	Car	Vacant	\N	\N	\N
115	1	Car	Vacant	\N	\N	\N
116	1	Car	Vacant	\N	\N	\N
117	1	Car	Vacant	\N	\N	\N
118	1	Car	Vacant	\N	\N	\N
119	1	Car	Vacant	\N	\N	\N
120	1	Car	Vacant	\N	\N	\N
121	1	Car	Vacant	\N	\N	\N
122	1	Car	Vacant	\N	\N	\N
123	1	Car	Vacant	\N	\N	\N
124	1	Car	Vacant	\N	\N	\N
125	1	Car	Vacant	\N	\N	\N
126	1	Car	Vacant	\N	\N	\N
127	1	Car	Vacant	\N	\N	\N
128	1	Car	Vacant	\N	\N	\N
129	1	Car	Vacant	\N	\N	\N
130	1	Car	Vacant	\N	\N	\N
131	1	Car	Vacant	\N	\N	\N
132	1	Car	Vacant	\N	\N	\N
133	1	Car	Vacant	\N	\N	\N
134	1	Car	Vacant	\N	\N	\N
135	1	Car	Vacant	\N	\N	\N
136	1	Car	Vacant	\N	\N	\N
137	1	Car	Vacant	\N	\N	\N
138	1	Car	Vacant	\N	\N	\N
139	1	Car	Vacant	\N	\N	\N
140	1	Car	Vacant	\N	\N	\N
141	1	Car	Vacant	\N	\N	\N
142	1	Car	Vacant	\N	\N	\N
143	1	Car	Vacant	\N	\N	\N
144	1	Car	Vacant	\N	\N	\N
145	1	Car	Vacant	\N	\N	\N
146	1	Car	Vacant	\N	\N	\N
147	1	Car	Vacant	\N	\N	\N
148	1	Car	Vacant	\N	\N	\N
149	1	Car	Vacant	\N	\N	\N
150	1	Car	Vacant	\N	\N	\N
151	2	Bike	Vacant	\N	\N	\N
152	2	Bike	Vacant	\N	\N	\N
153	2	Bike	Vacant	\N	\N	\N
154	2	Bike	Vacant	\N	\N	\N
155	2	Bike	Vacant	\N	\N	\N
156	2	Bike	Vacant	\N	\N	\N
157	2	Bike	Vacant	\N	\N	\N
158	2	Bike	Vacant	\N	\N	\N
159	2	Bike	Vacant	\N	\N	\N
160	2	Bike	Vacant	\N	\N	\N
161	2	Bike	Vacant	\N	\N	\N
162	2	Bike	Vacant	\N	\N	\N
163	2	Bike	Vacant	\N	\N	\N
164	2	Bike	Vacant	\N	\N	\N
165	2	Bike	Vacant	\N	\N	\N
166	2	Bike	Vacant	\N	\N	\N
167	2	Bike	Vacant	\N	\N	\N
168	2	Bike	Vacant	\N	\N	\N
169	2	Bike	Vacant	\N	\N	\N
170	2	Bike	Vacant	\N	\N	\N
171	2	Bike	Vacant	\N	\N	\N
172	2	Bike	Vacant	\N	\N	\N
173	2	Bike	Vacant	\N	\N	\N
174	2	Bike	Vacant	\N	\N	\N
175	2	Bike	Vacant	\N	\N	\N
176	2	Bike	Vacant	\N	\N	\N
177	2	Bike	Vacant	\N	\N	\N
178	2	Bike	Vacant	\N	\N	\N
179	2	Bike	Vacant	\N	\N	\N
180	2	Bike	Vacant	\N	\N	\N
181	2	Bike	Vacant	\N	\N	\N
182	2	Bike	Vacant	\N	\N	\N
183	2	Bike	Vacant	\N	\N	\N
184	2	Bike	Vacant	\N	\N	\N
185	2	Bike	Vacant	\N	\N	\N
186	2	Bike	Vacant	\N	\N	\N
187	2	Bike	Vacant	\N	\N	\N
188	2	Bike	Vacant	\N	\N	\N
189	2	Bike	Vacant	\N	\N	\N
190	2	Bike	Vacant	\N	\N	\N
191	2	Bike	Vacant	\N	\N	\N
192	2	Bike	Vacant	\N	\N	\N
193	2	Bike	Vacant	\N	\N	\N
194	2	Bike	Vacant	\N	\N	\N
195	2	Bike	Vacant	\N	\N	\N
196	2	Bike	Vacant	\N	\N	\N
197	2	Bike	Vacant	\N	\N	\N
198	2	Bike	Vacant	\N	\N	\N
199	2	Bike	Vacant	\N	\N	\N
200	2	Bike	Vacant	\N	\N	\N
201	2	Bike	Vacant	\N	\N	\N
202	2	Bike	Vacant	\N	\N	\N
203	2	Bike	Vacant	\N	\N	\N
204	2	Bike	Vacant	\N	\N	\N
205	2	Bike	Vacant	\N	\N	\N
206	2	Bike	Vacant	\N	\N	\N
207	2	Bike	Vacant	\N	\N	\N
208	2	Bike	Vacant	\N	\N	\N
209	2	Bike	Vacant	\N	\N	\N
210	2	Bike	Vacant	\N	\N	\N
211	2	Bike	Vacant	\N	\N	\N
212	2	Bike	Vacant	\N	\N	\N
213	2	Bike	Vacant	\N	\N	\N
214	2	Bike	Vacant	\N	\N	\N
215	2	Bike	Vacant	\N	\N	\N
216	2	Bike	Vacant	\N	\N	\N
217	2	Bike	Vacant	\N	\N	\N
218	2	Bike	Vacant	\N	\N	\N
219	2	Bike	Vacant	\N	\N	\N
220	2	Bike	Vacant	\N	\N	\N
221	2	Bike	Vacant	\N	\N	\N
222	2	Bike	Vacant	\N	\N	\N
223	2	Bike	Vacant	\N	\N	\N
224	2	Bike	Vacant	\N	\N	\N
225	2	Bike	Vacant	\N	\N	\N
226	2	Bike	Vacant	\N	\N	\N
227	2	Bike	Vacant	\N	\N	\N
228	2	Bike	Vacant	\N	\N	\N
229	2	Bike	Vacant	\N	\N	\N
230	2	Bike	Vacant	\N	\N	\N
231	2	Car	Vacant	\N	\N	\N
232	2	Car	Vacant	\N	\N	\N
233	2	Car	Vacant	\N	\N	\N
234	2	Car	Vacant	\N	\N	\N
235	2	Car	Vacant	\N	\N	\N
236	2	Car	Vacant	\N	\N	\N
237	2	Car	Vacant	\N	\N	\N
238	2	Car	Vacant	\N	\N	\N
239	2	Car	Vacant	\N	\N	\N
240	2	Car	Vacant	\N	\N	\N
241	2	Car	Vacant	\N	\N	\N
242	2	Car	Vacant	\N	\N	\N
243	2	Car	Vacant	\N	\N	\N
244	2	Car	Vacant	\N	\N	\N
245	2	Car	Vacant	\N	\N	\N
246	2	Car	Vacant	\N	\N	\N
247	2	Car	Vacant	\N	\N	\N
248	2	Car	Vacant	\N	\N	\N
249	2	Car	Vacant	\N	\N	\N
250	2	Car	Vacant	\N	\N	\N
251	2	Car	Vacant	\N	\N	\N
252	2	Car	Vacant	\N	\N	\N
253	2	Car	Vacant	\N	\N	\N
254	2	Car	Vacant	\N	\N	\N
255	2	Car	Vacant	\N	\N	\N
256	2	Car	Vacant	\N	\N	\N
257	2	Car	Vacant	\N	\N	\N
258	2	Car	Vacant	\N	\N	\N
259	2	Car	Vacant	\N	\N	\N
260	2	Car	Vacant	\N	\N	\N
261	2	Car	Vacant	\N	\N	\N
262	2	Car	Vacant	\N	\N	\N
263	2	Car	Vacant	\N	\N	\N
264	2	Car	Vacant	\N	\N	\N
265	2	Car	Vacant	\N	\N	\N
266	2	Car	Vacant	\N	\N	\N
267	2	Car	Vacant	\N	\N	\N
268	2	Car	Vacant	\N	\N	\N
269	2	Car	Vacant	\N	\N	\N
270	2	Car	Vacant	\N	\N	\N
271	3	Bike	Vacant	\N	\N	\N
272	3	Bike	Vacant	\N	\N	\N
273	3	Bike	Vacant	\N	\N	\N
274	3	Bike	Vacant	\N	\N	\N
275	3	Bike	Vacant	\N	\N	\N
276	3	Bike	Vacant	\N	\N	\N
277	3	Bike	Vacant	\N	\N	\N
278	3	Bike	Vacant	\N	\N	\N
279	3	Bike	Vacant	\N	\N	\N
280	3	Bike	Vacant	\N	\N	\N
281	3	Bike	Vacant	\N	\N	\N
282	3	Bike	Vacant	\N	\N	\N
283	3	Bike	Vacant	\N	\N	\N
284	3	Bike	Vacant	\N	\N	\N
285	3	Bike	Vacant	\N	\N	\N
286	3	Bike	Vacant	\N	\N	\N
287	3	Bike	Vacant	\N	\N	\N
288	3	Bike	Vacant	\N	\N	\N
289	3	Bike	Vacant	\N	\N	\N
290	3	Bike	Vacant	\N	\N	\N
291	3	Bike	Vacant	\N	\N	\N
292	3	Bike	Vacant	\N	\N	\N
293	3	Bike	Vacant	\N	\N	\N
294	3	Bike	Vacant	\N	\N	\N
295	3	Bike	Vacant	\N	\N	\N
296	3	Bike	Vacant	\N	\N	\N
297	3	Bike	Vacant	\N	\N	\N
298	3	Bike	Vacant	\N	\N	\N
299	3	Bike	Vacant	\N	\N	\N
300	3	Bike	Vacant	\N	\N	\N
301	3	Bike	Vacant	\N	\N	\N
302	3	Bike	Vacant	\N	\N	\N
303	3	Bike	Vacant	\N	\N	\N
304	3	Bike	Vacant	\N	\N	\N
305	3	Bike	Vacant	\N	\N	\N
306	3	Bike	Vacant	\N	\N	\N
307	3	Bike	Vacant	\N	\N	\N
308	3	Bike	Vacant	\N	\N	\N
309	3	Bike	Vacant	\N	\N	\N
310	3	Bike	Vacant	\N	\N	\N
311	3	Bike	Vacant	\N	\N	\N
312	3	Bike	Vacant	\N	\N	\N
313	3	Bike	Vacant	\N	\N	\N
314	3	Bike	Vacant	\N	\N	\N
315	3	Bike	Vacant	\N	\N	\N
316	3	Bike	Vacant	\N	\N	\N
317	3	Bike	Vacant	\N	\N	\N
318	3	Bike	Vacant	\N	\N	\N
319	3	Bike	Vacant	\N	\N	\N
320	3	Bike	Vacant	\N	\N	\N
321	3	Bike	Vacant	\N	\N	\N
322	3	Bike	Vacant	\N	\N	\N
323	3	Bike	Vacant	\N	\N	\N
324	3	Bike	Vacant	\N	\N	\N
325	3	Bike	Vacant	\N	\N	\N
326	3	Bike	Vacant	\N	\N	\N
327	3	Bike	Vacant	\N	\N	\N
328	3	Bike	Vacant	\N	\N	\N
329	3	Bike	Vacant	\N	\N	\N
330	3	Bike	Vacant	\N	\N	\N
331	3	Car	Vacant	\N	\N	\N
332	3	Car	Vacant	\N	\N	\N
333	3	Car	Vacant	\N	\N	\N
334	3	Car	Vacant	\N	\N	\N
335	3	Car	Vacant	\N	\N	\N
336	3	Car	Vacant	\N	\N	\N
337	3	Car	Vacant	\N	\N	\N
338	3	Car	Vacant	\N	\N	\N
339	3	Car	Vacant	\N	\N	\N
340	3	Car	Vacant	\N	\N	\N
341	3	Car	Vacant	\N	\N	\N
342	3	Car	Vacant	\N	\N	\N
343	3	Car	Vacant	\N	\N	\N
344	3	Car	Vacant	\N	\N	\N
345	3	Car	Vacant	\N	\N	\N
346	3	Car	Vacant	\N	\N	\N
347	3	Car	Vacant	\N	\N	\N
348	3	Car	Vacant	\N	\N	\N
349	3	Car	Vacant	\N	\N	\N
350	3	Car	Vacant	\N	\N	\N
351	3	Car	Vacant	\N	\N	\N
352	3	Car	Vacant	\N	\N	\N
353	3	Car	Vacant	\N	\N	\N
354	3	Car	Vacant	\N	\N	\N
355	3	Car	Vacant	\N	\N	\N
356	3	Car	Vacant	\N	\N	\N
357	3	Car	Vacant	\N	\N	\N
358	3	Car	Vacant	\N	\N	\N
359	3	Car	Vacant	\N	\N	\N
360	3	Car	Vacant	\N	\N	\N
1	1	Bike	Occupied	hem	04:34:00	07:34:00
\.


--
-- TOC entry 4919 (class 0 OID 25534)
-- Dependencies: 218
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, username, email, password, phone_number, points, badge, is_admin) FROM stdin;
1	hem	hemprasadac@gmail.com	$2b$12$rAcfEwLoFWQrT4lVROQABueqyMH8fKkw5eLC8FahMc.nGhFdAryPK	9841602444	45	Beginner	f
\.


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 229
-- Name: blood_donor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blood_donor_id_seq', 2, true);


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 231
-- Name: blood_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blood_request_id_seq', 10, true);


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 233
-- Name: booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_id_seq', 1, true);


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 223
-- Name: contact_form_submission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_form_submission_id_seq', 1, false);


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 225
-- Name: food_donation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.food_donation_id_seq', 2, true);


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 219
-- Name: orphanage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orphanage_id_seq', 5, true);


--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 221
-- Name: parking_lot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parking_lot_id_seq', 3, true);


--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 227
-- Name: parking_slot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parking_slot_id_seq', 360, true);


--
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 217
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 1, true);


--
-- TOC entry 4761 (class 2606 OID 25604)
-- Name: blood_donor blood_donor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_donor
    ADD CONSTRAINT blood_donor_pkey PRIMARY KEY (id);


--
-- TOC entry 4763 (class 2606 OID 25616)
-- Name: blood_request blood_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_request
    ADD CONSTRAINT blood_request_pkey PRIMARY KEY (id);


--
-- TOC entry 4765 (class 2606 OID 25628)
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);


--
-- TOC entry 4755 (class 2606 OID 25568)
-- Name: contact_form_submission contact_form_submission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_form_submission
    ADD CONSTRAINT contact_form_submission_pkey PRIMARY KEY (id);


--
-- TOC entry 4757 (class 2606 OID 25575)
-- Name: food_donation food_donation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_donation
    ADD CONSTRAINT food_donation_pkey PRIMARY KEY (id);


--
-- TOC entry 4751 (class 2606 OID 25552)
-- Name: orphanage orphanage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orphanage
    ADD CONSTRAINT orphanage_pkey PRIMARY KEY (id);


--
-- TOC entry 4753 (class 2606 OID 25559)
-- Name: parking_lot parking_lot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parking_lot
    ADD CONSTRAINT parking_lot_pkey PRIMARY KEY (id);


--
-- TOC entry 4759 (class 2606 OID 25592)
-- Name: parking_slot parking_slot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parking_slot
    ADD CONSTRAINT parking_slot_pkey PRIMARY KEY (id);


--
-- TOC entry 4745 (class 2606 OID 25545)
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- TOC entry 4747 (class 2606 OID 25541)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 4749 (class 2606 OID 25543)
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- TOC entry 4769 (class 2606 OID 25605)
-- Name: blood_donor blood_donor_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_donor
    ADD CONSTRAINT blood_donor_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- TOC entry 4770 (class 2606 OID 25617)
-- Name: blood_request blood_request_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_request
    ADD CONSTRAINT blood_request_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- TOC entry 4771 (class 2606 OID 25634)
-- Name: booking booking_slot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_slot_id_fkey FOREIGN KEY (slot_id) REFERENCES public.parking_slot(id);


--
-- TOC entry 4772 (class 2606 OID 25629)
-- Name: booking booking_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- TOC entry 4766 (class 2606 OID 25581)
-- Name: food_donation food_donation_orphanage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_donation
    ADD CONSTRAINT food_donation_orphanage_id_fkey FOREIGN KEY (orphanage_id) REFERENCES public.orphanage(id);


--
-- TOC entry 4767 (class 2606 OID 25576)
-- Name: food_donation food_donation_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_donation
    ADD CONSTRAINT food_donation_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- TOC entry 4768 (class 2606 OID 25593)
-- Name: parking_slot parking_slot_lot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parking_slot
    ADD CONSTRAINT parking_slot_lot_id_fkey FOREIGN KEY (lot_id) REFERENCES public.parking_lot(id);


-- Completed on 2025-11-09 22:48:45

--
-- PostgreSQL database dump complete
--

\unrestrict qWMbJOSVgPR3vTm9x5dzR8w6jWX7nLe1ol5pHKbPBbCOo9flGB1tzHHldzXcyk3

