--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3
-- Dumped by pg_dump version 15.2

-- Started on 2024-02-08 22:47:03

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: sbs
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO sbs;

--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: sbs
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 851 (class 1247 OID 16386)
-- Name: BookingStatusEnum; Type: TYPE; Schema: public; Owner: sbs
--

CREATE TYPE public."BookingStatusEnum" AS ENUM (
    'BOOKED',
    'USED'
);


ALTER TYPE public."BookingStatusEnum" OWNER TO sbs;

--
-- TOC entry 854 (class 1247 OID 16392)
-- Name: DepartmentEnum; Type: TYPE; Schema: public; Owner: sbs
--

CREATE TYPE public."DepartmentEnum" AS ENUM (
    'SOFTWAREENGINEERING',
    'TOURISMANDMANAGEMENT',
    'ARCHITECTURE'
);


ALTER TYPE public."DepartmentEnum" OWNER TO sbs;

--
-- TOC entry 857 (class 1247 OID 16400)
-- Name: GenderEnum; Type: TYPE; Schema: public; Owner: sbs
--

CREATE TYPE public."GenderEnum" AS ENUM (
    'FEMALE',
    'MALE'
);


ALTER TYPE public."GenderEnum" OWNER TO sbs;

--
-- TOC entry 860 (class 1247 OID 16406)
-- Name: RoleEnum; Type: TYPE; Schema: public; Owner: sbs
--

CREATE TYPE public."RoleEnum" AS ENUM (
    'SUPERADMIN',
    'ADMIN',
    'STUDENT',
    'STAFF',
    'CUSTOMER',
    'DRIVER',
    'VIP_GUEST'
);


ALTER TYPE public."RoleEnum" OWNER TO sbs;

--
-- TOC entry 863 (class 1247 OID 16422)
-- Name: WaitingStatusEnum; Type: TYPE; Schema: public; Owner: sbs
--

CREATE TYPE public."WaitingStatusEnum" AS ENUM (
    'WAITING',
    'USED'
);


ALTER TYPE public."WaitingStatusEnum" OWNER TO sbs;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 16427)
-- Name: AdminInfo; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."AdminInfo" (
    id text NOT NULL,
    "userId" text NOT NULL
);


ALTER TABLE public."AdminInfo" OWNER TO sbs;

--
-- TOC entry 210 (class 1259 OID 16432)
-- Name: Batch; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."Batch" (
    id text NOT NULL,
    department public."DepartmentEnum",
    "batchNum" integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE public."Batch" OWNER TO sbs;

--
-- TOC entry 211 (class 1259 OID 16438)
-- Name: Booking; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."Booking" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "scheduleId" text NOT NULL,
    "payStatus" boolean DEFAULT false NOT NULL,
    status public."BookingStatusEnum" DEFAULT 'BOOKED'::public."BookingStatusEnum" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE public."Booking" OWNER TO sbs;

--
-- TOC entry 212 (class 1259 OID 16446)
-- Name: Bus; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."Bus" (
    id text NOT NULL,
    model text NOT NULL,
    "plateNumber" text NOT NULL,
    "numOfSeat" integer NOT NULL,
    "driverName" text NOT NULL,
    "driverContact" text NOT NULL,
    enable boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE public."Bus" OWNER TO sbs;

--
-- TOC entry 213 (class 1259 OID 16453)
-- Name: Cancel; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."Cancel" (
    id text NOT NULL,
    "scheduleId" text NOT NULL,
    "userId" text NOT NULL
);


ALTER TABLE public."Cancel" OWNER TO sbs;

--
-- TOC entry 214 (class 1259 OID 16458)
-- Name: Cost; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."Cost" (
    id text NOT NULL,
    "targetPeople" text NOT NULL,
    "costPerPerson" double precision DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE public."Cost" OWNER TO sbs;

--
-- TOC entry 215 (class 1259 OID 16465)
-- Name: CustomerInfo; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."CustomerInfo" (
    id text NOT NULL,
    "userId" text NOT NULL
);


ALTER TABLE public."CustomerInfo" OWNER TO sbs;

--
-- TOC entry 216 (class 1259 OID 16470)
-- Name: Departure; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."Departure" (
    id text NOT NULL,
    enable boolean DEFAULT true NOT NULL,
    "fromId" text NOT NULL,
    "destinationId" text NOT NULL,
    "departureTime" time(0) without time zone NOT NULL,
    "pickupLocationId" text NOT NULL,
    "dropLocationId" text NOT NULL
);


ALTER TABLE public."Departure" OWNER TO sbs;

--
-- TOC entry 217 (class 1259 OID 16476)
-- Name: DriverInfo; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."DriverInfo" (
    id text NOT NULL,
    "userId" text NOT NULL
);


ALTER TABLE public."DriverInfo" OWNER TO sbs;

--
-- TOC entry 218 (class 1259 OID 16481)
-- Name: GuestInfor; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."GuestInfor" (
    id text NOT NULL,
    name text NOT NULL,
    gender public."GenderEnum" NOT NULL,
    "scheduleId" text NOT NULL,
    user_type public."RoleEnum" DEFAULT 'VIP_GUEST'::public."RoleEnum" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE public."GuestInfor" OWNER TO sbs;

--
-- TOC entry 219 (class 1259 OID 16488)
-- Name: MainLocation; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."MainLocation" (
    id text NOT NULL,
    "mainLocationName" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE public."MainLocation" OWNER TO sbs;

--
-- TOC entry 220 (class 1259 OID 16494)
-- Name: ManualBooking; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."ManualBooking" (
    id text NOT NULL,
    name text NOT NULL,
    phone text,
    "numberBooking" integer NOT NULL,
    adult integer NOT NULL,
    child integer NOT NULL,
    "totalCost" double precision NOT NULL,
    remark text,
    "scheduleId" text NOT NULL,
    payment text NOT NULL,
    status text NOT NULL,
    user_type text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE public."ManualBooking" OWNER TO sbs;

--
-- TOC entry 221 (class 1259 OID 16500)
-- Name: Schedule; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."Schedule" (
    id text NOT NULL,
    "departureId" text NOT NULL,
    date date NOT NULL,
    "numberOfblock" integer DEFAULT 0,
    "availableSeat" integer DEFAULT 24,
    "busId" text,
    enable boolean DEFAULT true NOT NULL
);


ALTER TABLE public."Schedule" OWNER TO sbs;

--
-- TOC entry 222 (class 1259 OID 16508)
-- Name: StaffInfo; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."StaffInfo" (
    id text NOT NULL,
    "userId" text NOT NULL
);


ALTER TABLE public."StaffInfo" OWNER TO sbs;

--
-- TOC entry 223 (class 1259 OID 16513)
-- Name: StudentInfo; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."StudentInfo" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "batchId" text
);


ALTER TABLE public."StudentInfo" OWNER TO sbs;

--
-- TOC entry 224 (class 1259 OID 16518)
-- Name: SubLocation; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."SubLocation" (
    id text NOT NULL,
    "subLocationName" text NOT NULL,
    "mainLocationId" text NOT NULL,
    enable boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE public."SubLocation" OWNER TO sbs;

--
-- TOC entry 225 (class 1259 OID 16525)
-- Name: SuperAdminInfo; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."SuperAdminInfo" (
    id text NOT NULL,
    "userId" text NOT NULL
);


ALTER TABLE public."SuperAdminInfo" OWNER TO sbs;

--
-- TOC entry 226 (class 1259 OID 16530)
-- Name: Ticket; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."Ticket" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "remainTicket" integer DEFAULT 36 NOT NULL,
    "ticketLimitInhand" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE public."Ticket" OWNER TO sbs;

--
-- TOC entry 227 (class 1259 OID 16538)
-- Name: User; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."User" (
    id text NOT NULL,
    email text,
    username text,
    password text,
    "googlePassword" text,
    role public."RoleEnum" NOT NULL,
    phone text,
    gender public."GenderEnum",
    "inKRR" boolean DEFAULT true,
    enable boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE public."User" OWNER TO sbs;

--
-- TOC entry 228 (class 1259 OID 16546)
-- Name: Waitting; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public."Waitting" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "scheduleId" text NOT NULL,
    "payStatus" boolean DEFAULT false NOT NULL,
    status public."WaitingStatusEnum" DEFAULT 'WAITING'::public."WaitingStatusEnum" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE public."Waitting" OWNER TO sbs;

--
-- TOC entry 229 (class 1259 OID 16554)
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: sbs
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO sbs;

--
-- TOC entry 230 (class 1259 OID 16561)
-- Name: booking_count_by_user_role; Type: VIEW; Schema: public; Owner: sbs
--

CREATE VIEW public.booking_count_by_user_role AS
 SELECT u.role,
    count(b.id) AS booking_count
   FROM (public."User" u
     LEFT JOIN public."Booking" b ON ((u.id = b."userId")))
  GROUP BY u.role;


ALTER TABLE public.booking_count_by_user_role OWNER TO sbs;

--
-- TOC entry 231 (class 1259 OID 16565)
-- Name: booking_count_by_user_role_with_booking_date; Type: VIEW; Schema: public; Owner: sbs
--

CREATE VIEW public.booking_count_by_user_role_with_booking_date AS
 SELECT u.role,
    s.date,
    count(b.id) AS booking_count
   FROM ((public."User" u
     LEFT JOIN public."Booking" b ON ((u.id = b."userId")))
     LEFT JOIN public."Schedule" s ON ((b."scheduleId" = s.id)))
  GROUP BY u.role, s.date;


ALTER TABLE public.booking_count_by_user_role_with_booking_date OWNER TO sbs;

--
-- TOC entry 232 (class 1259 OID 16570)
-- Name: booking_count_by_user_role_with_date; Type: VIEW; Schema: public; Owner: sbs
--

CREATE VIEW public.booking_count_by_user_role_with_date AS
 SELECT u.role,
    s.date,
    count(b.id) AS booking_count
   FROM ((public."User" u
     LEFT JOIN public."Booking" b ON ((u.id = b."userId")))
     LEFT JOIN public."Schedule" s ON ((b."scheduleId" = s.id)))
  GROUP BY u.role, s.date;


ALTER TABLE public.booking_count_by_user_role_with_date OWNER TO sbs;

--
-- TOC entry 233 (class 1259 OID 16575)
-- Name: schedule_with_booking_cancel_count; Type: VIEW; Schema: public; Owner: sbs
--

CREATE VIEW public.schedule_with_booking_cancel_count AS
 SELECT s."scheduleId",
    s.departuredatetime,
    s."cancelId",
    COALESCE(c.cancel_count, (0)::bigint) AS cancel_count,
    COALESCE(b.booking_count, (0)::bigint) AS booking_count
   FROM ((( SELECT s_1.id AS "scheduleId",
            concat(s_1.date, ', ', d."departureTime") AS departuredatetime,
            c_1.id AS "cancelId"
           FROM ((public."Schedule" s_1
             JOIN public."Departure" d ON ((s_1."departureId" = d.id)))
             JOIN public."Cancel" c_1 ON ((s_1.id = c_1."scheduleId")))) s
     LEFT JOIN ( SELECT "Cancel"."scheduleId",
            count(*) AS cancel_count
           FROM public."Cancel"
          GROUP BY "Cancel"."scheduleId") c ON ((s."scheduleId" = c."scheduleId")))
     LEFT JOIN ( SELECT "Booking"."scheduleId",
            count(*) AS booking_count
           FROM public."Booking"
          GROUP BY "Booking"."scheduleId") b ON ((s."scheduleId" = b."scheduleId")));


ALTER TABLE public.schedule_with_booking_cancel_count OWNER TO sbs;

--
-- TOC entry 234 (class 1259 OID 16580)
-- Name: schedule_with_booking_cancel_count_with_date; Type: VIEW; Schema: public; Owner: sbs
--

CREATE VIEW public.schedule_with_booking_cancel_count_with_date AS
 SELECT s."scheduleId",
    s.departuredatetime,
    s."cancelId",
    s.date,
    COALESCE(c.cancel_count, (0)::bigint) AS cancel_count,
    COALESCE(b.booking_count, (0)::bigint) AS booking_count
   FROM ((( SELECT s_1.id AS "scheduleId",
            concat(s_1.date, ', ', d."departureTime") AS departuredatetime,
            c_1.id AS "cancelId",
            s_1.date
           FROM ((public."Schedule" s_1
             JOIN public."Departure" d ON ((s_1."departureId" = d.id)))
             JOIN public."Cancel" c_1 ON ((s_1.id = c_1."scheduleId")))) s
     LEFT JOIN ( SELECT "Cancel"."scheduleId",
            count(*) AS cancel_count
           FROM public."Cancel"
          GROUP BY "Cancel"."scheduleId") c ON ((s."scheduleId" = c."scheduleId")))
     LEFT JOIN ( SELECT "Booking"."scheduleId",
            count(*) AS booking_count
           FROM public."Booking"
          GROUP BY "Booking"."scheduleId") b ON ((s."scheduleId" = b."scheduleId")));


ALTER TABLE public.schedule_with_booking_cancel_count_with_date OWNER TO sbs;

--
-- TOC entry 235 (class 1259 OID 16585)
-- Name: schedule_with_departure_and_bus_and_booking_count; Type: VIEW; Schema: public; Owner: sbs
--

CREATE VIEW public.schedule_with_departure_and_bus_and_booking_count AS
 SELECT s."scheduleId",
    s.departuredatetime,
    s."numOfSeat",
    COALESCE(b.booking_count, (0)::bigint) AS booking_count,
    b."createdAt"
   FROM (( SELECT s_1.id AS "scheduleId",
            concat(s_1.date, ', ', d."departureTime") AS departuredatetime,
            b_1."numOfSeat"
           FROM ((public."Schedule" s_1
             JOIN public."Departure" d ON ((s_1."departureId" = d.id)))
             JOIN public."Bus" b_1 ON ((s_1."busId" = b_1.id)))) s
     LEFT JOIN ( SELECT "Booking"."scheduleId",
            count(*) AS booking_count,
            max("Booking"."createdAt") AS "createdAt"
           FROM public."Booking"
          GROUP BY "Booking"."scheduleId") b ON ((s."scheduleId" = b."scheduleId")));


ALTER TABLE public.schedule_with_departure_and_bus_and_booking_count OWNER TO sbs;

--
-- TOC entry 236 (class 1259 OID 16590)
-- Name: schedule_with_departure_bus_booking_and_mainlocation_details; Type: VIEW; Schema: public; Owner: sbs
--

CREATE VIEW public.schedule_with_departure_bus_booking_and_mainlocation_details AS
 SELECT s."scheduleId",
    s."departureId",
    s.departuredatetime,
    s."numOfSeat",
    COALESCE(b.booking_count, (0)::bigint) AS booking_count,
    ml."mainLocationName"
   FROM ((( SELECT s_1.id AS "scheduleId",
            s_1."departureId",
            concat(s_1.date, ', ', de."departureTime") AS departuredatetime,
            b_1."numOfSeat",
            de."fromId"
           FROM ((public."Schedule" s_1
             JOIN public."Departure" de ON ((s_1."departureId" = de.id)))
             JOIN public."Bus" b_1 ON ((s_1."busId" = b_1.id)))) s
     LEFT JOIN ( SELECT "Booking"."scheduleId",
            count(*) AS booking_count
           FROM public."Booking"
          GROUP BY "Booking"."scheduleId") b ON ((s."scheduleId" = b."scheduleId")))
     LEFT JOIN public."MainLocation" ml ON ((s."fromId" = ml.id)));


ALTER TABLE public.schedule_with_departure_bus_booking_and_mainlocation_details OWNER TO sbs;

--
-- TOC entry 237 (class 1259 OID 16595)
-- Name: schedule_with_departure_bus_booking_and_mainlocation_details_wi; Type: VIEW; Schema: public; Owner: sbs
--

CREATE VIEW public.schedule_with_departure_bus_booking_and_mainlocation_details_wi AS
 SELECT s."scheduleId",
    s."departureId",
    s.departuredatetime,
    s."numOfSeat",
    s.date,
    COALESCE(b.booking_count, (0)::bigint) AS booking_count,
    ml."mainLocationName"
   FROM ((( SELECT s_1.id AS "scheduleId",
            s_1."departureId",
            concat(s_1.date, ', ', de."departureTime") AS departuredatetime,
            b_1."numOfSeat",
            s_1.date,
            de."fromId"
           FROM ((public."Schedule" s_1
             JOIN public."Departure" de ON ((s_1."departureId" = de.id)))
             JOIN public."Bus" b_1 ON ((s_1."busId" = b_1.id)))) s
     LEFT JOIN ( SELECT "Booking"."scheduleId",
            count(*) AS booking_count
           FROM public."Booking"
          GROUP BY "Booking"."scheduleId") b ON ((s."scheduleId" = b."scheduleId")))
     LEFT JOIN public."MainLocation" ml ON ((s."fromId" = ml.id)));


ALTER TABLE public.schedule_with_departure_bus_booking_and_mainlocation_details_wi OWNER TO sbs;

--
-- TOC entry 238 (class 1259 OID 16600)
-- Name: schedule_with_departure_bus_booking_count_with_date; Type: VIEW; Schema: public; Owner: sbs
--

CREATE VIEW public.schedule_with_departure_bus_booking_count_with_date AS
 SELECT s."scheduleId",
    s.departuredatetime,
    s."numOfSeat",
    s.departuredate,
    COALESCE(b.booking_count, (0)::bigint) AS booking_count
   FROM (( SELECT s_1.id AS "scheduleId",
            concat(s_1.date, ', ', d."departureTime") AS departuredatetime,
            s_1.date AS departuredate,
            b_1."numOfSeat"
           FROM ((public."Schedule" s_1
             JOIN public."Departure" d ON ((s_1."departureId" = d.id)))
             JOIN public."Bus" b_1 ON ((s_1."busId" = b_1.id)))) s
     LEFT JOIN ( SELECT "Booking"."scheduleId",
            count(*) AS booking_count
           FROM public."Booking"
          GROUP BY "Booking"."scheduleId") b ON ((s."scheduleId" = b."scheduleId")));


ALTER TABLE public.schedule_with_departure_bus_booking_count_with_date OWNER TO sbs;

--
-- TOC entry 3570 (class 0 OID 16427)
-- Dependencies: 209
-- Data for Name: AdminInfo; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."AdminInfo" (id, "userId") FROM stdin;
ec2dad10-57f2-4494-a624-677cdd4b38f4	509d5033-9f79-4638-9933-6086dd9f5d3e
b8446593-6077-4db9-afd4-2e85d0e92f8d	b2660df3-c832-4245-8e93-b9db034c7e94
\.


--
-- TOC entry 3571 (class 0 OID 16432)
-- Dependencies: 210
-- Data for Name: Batch; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."Batch" (id, department, "batchNum", "createdAt", "updatedAt") FROM stdin;
97c7b202-02ea-46e7-80e4-2f5303d96a1a	SOFTWAREENGINEERING	1	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
d67fed11-7263-4de6-b813-06eb33132975	SOFTWAREENGINEERING	2	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
d5d99db0-2cc4-4ba7-a251-02cc05406f08	SOFTWAREENGINEERING	3	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9	SOFTWAREENGINEERING	4	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
948f9273-0239-401c-bfe4-37a871499e4c	SOFTWAREENGINEERING	5	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
af5868a4-b5d9-41ec-8ba2-0164773e8dbc	SOFTWAREENGINEERING	6	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
0bbc764e-6049-4d09-a2c9-e3505a24ac84	SOFTWAREENGINEERING	7	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b	SOFTWAREENGINEERING	8	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
4443011d-b301-4778-bb98-e8f1d09015c5	SOFTWAREENGINEERING	9	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
60b237fc-3beb-4293-ba4d-1ada657a288d	SOFTWAREENGINEERING	10	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
4db6d042-973c-4ba3-9598-3b8b682691b7	SOFTWAREENGINEERING	11	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
96814388-e785-4b90-a6cc-0933bf685340	TOURISMANDMANAGEMENT	1	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
6d0d910e-1e78-412a-adaa-df7fc3fb3e6f	TOURISMANDMANAGEMENT	2	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
9cb8388d-e125-4b29-9d1c-2aee4ef5b5b1	TOURISMANDMANAGEMENT	3	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
f76ccdfb-a717-4de0-be7e-e96744552432	ARCHITECTURE	1	2023-07-14 12:21:38.361	2023-07-14 12:21:38.361
e015bb71-7d0a-493b-be92-ba2bc541b065	SOFTWAREENGINEERING	15	2024-01-07 15:45:40.628	2024-01-07 15:45:26.403
\.


--
-- TOC entry 3572 (class 0 OID 16438)
-- Dependencies: 211
-- Data for Name: Booking; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."Booking" (id, "userId", "scheduleId", "payStatus", status, "createdAt", "updatedAt") FROM stdin;
02699bf3-255b-4ac4-ba4c-ca7f5bcd2bd2	00e51059-cbac-4b69-8367-de4269873f20	870fb66b-be4a-46d9-9de2-a0cb800cbcc4	t	BOOKED	2023-12-16 14:47:38.647	2023-12-20 14:21:49.622
1b980761-9808-402b-9725-1768a2c15bd3	35d2aad3-e1b8-4b40-9a36-7aecc55e7bbd	870fb66b-be4a-46d9-9de2-a0cb800cbcc4	t	BOOKED	2023-12-16 16:35:12.374	2023-12-20 14:21:49.622
23eb9dba-623c-4e4a-8f81-e5059db38315	21507fd1-9303-415b-8b09-a841252985d3	870fb66b-be4a-46d9-9de2-a0cb800cbcc4	t	BOOKED	2023-12-16 16:30:07.218	2023-12-20 14:21:49.622
384d462c-1f94-4662-a422-dbc09a3fb117	35282e55-cc08-4e9c-9e8b-0380fbd341bd	04e29e85-bb04-4506-871e-064611382c97	t	BOOKED	2023-12-16 16:33:06.213	2023-12-20 14:22:51.204
861ec491-226b-49d3-8597-61a9cafc8996	064decda-bb06-429e-8111-679c35681316	04e29e85-bb04-4506-871e-064611382c97	f	BOOKED	2023-12-20 14:23:21.719	2023-12-20 14:22:52.197
leapheng	58f5f21f-5de4-4f26-9626-c01a48c3e5da	6d4b8e9b-66cf-416f-9023-55c0dcca07c4	t	USED	2023-12-20 14:23:50.963	2024-02-05 08:21:50.967
22313131	10b26249-f81b-4bd8-ab36-2d41b02dc9e1	6d4b8e9b-66cf-416f-9023-55c0dcca07c4	t	USED	2024-01-09 07:49:40.978	2024-02-05 08:21:50.967
ewafadsadsada	f6ef71a7-3cd3-45d7-8236-128280ca1fc9	6d4b8e9b-66cf-416f-9023-55c0dcca07c4	t	USED	2024-01-09 08:10:33.712	2024-02-05 08:21:50.967
sen	10b26249-f81b-4bd8-ab36-2d41b02dc9e1	0a050ba2-aaf0-4005-91c7-27e04f27e332	t	BOOKED	2023-12-16 15:05:54.486	2024-02-05 07:59:02.84
\.


--
-- TOC entry 3573 (class 0 OID 16446)
-- Dependencies: 212
-- Data for Name: Bus; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."Bus" (id, model, "plateNumber", "numOfSeat", "driverName", "driverContact", enable, "createdAt", "updatedAt") FROM stdin;
86be41cf-ef60-4388-91a8-31cc07c395ed	rental Hyundai	3E 9255	44	N/A	N/A	t	2023-07-14 12:21:44.107	2023-07-14 12:21:44.107
88f66fef-c1b4-4966-b9e2-a4366d7931c0	Rental Hyundai	3F 1407	44	N/A	N/A	f	2023-07-14 12:21:44.122	2023-08-11 17:40:33.977
9e6642ab-39b5-4bcf-8759-6093dc114e0c	Rental Hyundai	3E 2050	44	N/A	N/A	f	2023-07-14 12:21:44.118	2023-08-11 17:40:38.912
c653f3b4-9053-4f9f-851e-cf16cecb64fb	Rental Bus	3F 5675	24	N/A	N/A	f	2023-07-14 12:21:44.076	2023-08-11 17:40:45.606
b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	Ssamyong	2AA 5042	11	N/A	N/A	f	2023-07-14 12:21:44.133	2023-08-11 17:40:52.951
50ff5482-287e-40d6-bf27-d383dc105dc1	Rental Bus	3S 2069	24	N/A	N/A	f	2023-07-14 12:21:44.08	2023-08-11 17:41:00.913
7a8131c1-b1ca-460f-aa1d-88c645c31560	Rental Hyundai	3A 2671	24	N/A	N/A	f	2023-07-14 12:21:44.114	2023-08-11 17:41:28.883
922fe9d7-f0f7-471d-8b95-88acb841a17c	Rental Hyundai	3E 9900	24	N/A	N/A	f	2023-07-14 12:21:44.126	2023-08-11 17:41:34.78
aeb73b0b-22c8-4188-9504-1236b19e11e4	Rental Bus	3D 5011	24	N/A	N/A	f	2023-07-14 12:21:44.145	2023-08-11 17:41:38.093
a5b73185-7441-4cab-9531-e5910947fd6c	Rental Bus	3F 6962	44	N/A	N/A	f	2023-07-14 12:21:44.141	2023-08-11 17:41:41.44
e551c73b-0e3b-4a8c-a38c-5d92766b114b	Rental Hyundai	3E 6535	44	N/A	N/A	f	2023-07-14 12:21:44.137	2023-08-11 17:41:45.447
19fa01d6-8b79-4cda-bea1-b0f3f7e98630	Rental Bus	3C 3452	44	N/A	N/A	f	2023-07-14 12:21:44.088	2023-08-20 08:21:27.296
cec2a73c-80fe-46a8-8ba3-e224a890957c	Rental Bus	3E 4978	24	N/A	N/A	f	2023-07-14 12:21:44.149	2023-08-20 08:21:32.897
ea312b20-e0cb-428b-aa0b-36999416a68f	Rental Bus	3C 0997	44	N/A	N/A	f	2023-07-14 12:21:44.095	2023-08-20 08:21:44.43
5bdb42b2-d743-41fd-a0fc-020e28a0977f	Rental Bus	3B 8610	44	N/A	N/A	f	2023-07-14 12:21:44.091	2023-08-20 08:21:48.578
72a311e0-b2b5-481f-aa98-0130d1dee157	Rental Bus	3E 5112	44	N/A	N/A	f	2023-07-14 12:21:44.084	2023-08-20 08:21:53.483
c960d71b-0318-414c-ba2b-9ccc26f638c6	Rental Hyundai	3D 2324	24	N/A	N/A	f	2023-07-14 12:21:44.103	2023-08-20 08:22:01.006
8a282a8f-82a6-4d65-b325-7e3ad1fa9cf8	Rental Hyundai	3T 9544	44	N/A	N/A	f	2023-07-14 12:21:44.11	2023-08-20 08:22:15.671
e121910a-eb7b-4081-a3af-342fd042f994	Rental Hyundia	3C 9995	44	N/A	N/A	f	2023-07-14 12:21:43.981	2023-08-20 08:24:40.035
42c51889-8e8e-4e45-adaa-835382d4a0ce	Samyung	3Q 2813	14	N/A	N/A	f	2023-07-14 12:21:43.985	2023-08-20 08:24:45.771
8065fbcc-f9a3-4770-95fe-41453031e3f6	Samyung	2BA 3524	14	N/A	N/A	f	2023-07-14 12:21:43.992	2023-08-20 08:25:17.481
43960cd4-aaa3-40b5-b13f-8efac0c92668	Rental Hyundia	3D 5755	24	N/A	N/A	f	2023-07-14 12:21:43.996	2023-08-20 08:25:24.652
d3c4102e-f5e7-4eb0-b0f4-0988fc29552d	Rental Bus	2A 5925	14	N/A	N/A	f	2023-07-14 12:21:44	2023-08-20 08:25:32.454
f5fceccf-8230-48fb-a4cd-643ba7f5110a	Rental Bus	2AB 4750	14	N/A	N/A	f	2023-07-14 12:21:44.032	2023-08-20 08:25:46.94
cf6d3f8b-9ce2-426d-b12a-0106fe71051b	ABC	1111	9	N/A	N/A	f	2023-07-14 12:21:43.887	2023-08-20 08:25:56.685
b1de6e67-398b-47e3-a2bf-92876a257ac8	Rental Bus	3E 8585	24	N/A	N/A	f	2023-07-14 12:21:43.897	2023-08-20 08:26:03.857
3e7a3d22-ef23-4f06-8412-976b92880618	Hyundai	3C 9537	24	N/A	N/A	f	2023-07-14 12:21:43.894	2023-08-20 08:26:10.259
d954a2ad-5f79-4272-a7ca-591fb9387ae3	Ssamyong	2AF 9291	14	N/A	N/A	f	2023-07-14 12:21:43.901	2023-08-20 08:26:18.297
eeac58d7-56d8-47f0-8bfa-bc3ce847bb46	Ssamyong	4reserv14	10	N/A	N/A	f	2023-07-14 12:21:43.906	2023-08-20 08:26:25.639
5a4c9fe0-6fef-410a-b296-ca64825cb8e3	Ssamyong	5reserv11	6	N/A	N/A	f	2023-07-14 12:21:43.91	2023-08-20 08:26:33.093
a3795153-89b9-468d-8cd0-5c094a04622e	Rental Hyundia	3D 4872	24	N/A	N/A	f	2023-07-14 12:21:43.914	2023-08-20 08:26:39.721
c1cd13a3-af42-4d89-91f0-d642a68764fb	Rental Hyundia	3C 9992	44	N/A	N/A	f	2023-07-14 12:21:43.918	2023-08-20 08:26:48.791
6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	Rental Bus	3B 2725	24	N/A	N/A	f	2023-07-14 12:21:43.93	2023-08-20 08:26:57.016
c347aff0-7a4d-45ac-b051-63222b036c8f	Rental Hyundia	3E 0006	24	N/A	N/A	f	2023-07-14 12:21:43.926	2023-08-20 08:27:06.784
e64f9dac-2b8a-478f-ab48-193d739a6230	Rental Hyundia	3C 9199	44	N/A	N/A	f	2023-07-14 12:21:43.922	2023-08-20 08:27:18.311
8b5b2810-f49b-44d6-a09a-dc051a08cf2d	Rental Hyundia	3C 3157	24	N/A	N/A	f	2023-07-14 12:21:43.934	2023-08-20 08:27:30.486
7bec0c04-ee21-4cb9-be2d-b447ea5dd160	Rental Hyundia	3E 9333	44	N/A	N/A	f	2023-07-14 12:21:43.938	2023-08-20 08:28:25.243
9ee86f1b-45ca-464a-8719-81f00ac546d4	Rental Hyundia	3C 6778	44	N/A	N/A	f	2023-07-14 12:21:43.942	2023-08-20 08:28:34.613
25f9efa9-4575-4e95-a82b-2a49e6835e90	Rental Bus	xxxx	44	N/A	N/A	f	2023-07-14 12:21:43.946	2023-08-20 08:28:46.555
496ea809-2edb-4da1-8f5e-3302393a5206	Rental Hyundia	3E 6856	24	N/A	N/A	f	2023-07-14 12:21:43.95	2023-08-20 08:28:58.575
19276bb3-9e06-4063-a1fc-2662ec673f4d	Rental Hyundia	3D 0289	44	N/A	N/A	f	2023-07-14 12:21:43.954	2023-08-20 08:29:12.683
eb12cb32-b602-4a96-8d96-f9c78fb22c47	Rental Hyundia	3E 6245	44	N/A	N/A	f	2023-07-14 12:21:43.974	2023-08-20 08:29:23.067
4f9cef16-551e-42ae-b4a1-887e5d0b0980	Rental Hyundia	3E 3646	24	N/A	N/A	f	2023-07-14 12:21:43.966	2023-08-20 08:29:34.333
82a682f9-a8d2-4253-9928-a47fe81ea040	Rental Hyundia	3E 9199	44	N/A	N/A	f	2023-07-14 12:21:43.97	2023-08-20 08:29:45.889
45c3c654-65da-47d3-8001-a763f7c9c13e	Rental Hyundia	3D 6953	44	N/A	N/A	f	2023-07-14 12:21:43.962	2023-08-20 08:29:55.534
7be01b65-548a-4cf7-86c2-3b7c5a14239d	Rental Hyundia	3E 3671	24	N/A	N/A	f	2023-07-14 12:21:43.959	2023-08-20 08:30:18.209
4dff09ea-616d-49cd-aef6-e7292675243d	Rental Hyundia	3C 5874	44	N/A	N/A	f	2023-07-14 12:21:44.004	2023-08-20 08:30:29.17
dbfe61cc-3d34-4af5-aea4-055406c09b45	Rental Hyundia	3D 6901	44	N/A	N/A	f	2023-07-14 12:21:44.009	2023-08-20 08:30:37.199
a1332229-9a80-43d3-8c01-cecb3565300c	Samyung	2BB 2047	14	N/A	N/A	f	2023-07-14 12:21:44.013	2023-08-20 08:30:51.369
30acec88-4b11-483a-afd6-da3f1c8c0620	Rental Bus	3F 2069	24	N/A	N/A	f	2023-07-14 12:21:44.017	2023-08-20 08:31:05.219
24a381cc-a7a5-40f5-8f3d-5ddd19a79b5a	Rental Bus	3E 5874	24	N/A	N/A	f	2023-07-14 12:21:44.025	2023-08-20 08:31:15.679
f6cc6ba7-f5fd-4d85-b472-6c5f15abbc65	Rental Hyundia	3A 0908	24	N/A	N/A	f	2023-07-14 12:21:44.028	2023-08-20 08:31:37.036
43121b33-6e4f-4f3b-974c-6455d0a261c3	Rental Hyundia	3C 7994	44	N/A	N/A	f	2023-07-14 12:21:44.035	2023-08-20 08:31:47.46
10a2e436-ab68-4a45-97c7-f4a22bf06a1a	Rental Hyundia	3C 8566	24	N/A	N/A	f	2023-07-14 12:21:44.039	2023-08-20 08:31:57.41
dae590fe-f90d-41dd-a71c-7d34d220688c	Rental Hyundia	3C 8588	24	N/A	N/A	f	2023-07-14 12:21:44.044	2023-08-20 08:32:59.502
befdd994-a383-472a-b6bd-ced524d45fdd	Rental Bus	3C 8567	24	N/A	N/A	f	2023-07-14 12:21:44.072	2023-08-20 08:33:08.207
e6e196ee-22e7-4730-92f4-be3baba89e42	Rental Hyundia	3D 9255	44	N/A	N/A	f	2023-07-14 12:21:44.048	2023-08-20 08:33:23.79
288b82e6-7e91-46c0-b7d9-7cf69f7b1324	Rental Hyundia	3E 5675	24	N/A	N/A	f	2023-07-14 12:21:44.052	2023-08-20 08:33:35.396
e3f0bc05-c672-4f54-a88d-f9bf086d1b0c	Rental Hyundia	3D 8068	44	N/A	N/A	f	2023-07-14 12:21:44.064	2023-08-20 08:33:44.826
d7c22c08-80ed-4efd-a07e-e45f51d85822	Rental Hyundia	3D 7554	44	N/A	N/A	f	2023-07-14 12:21:44.056	2023-08-20 08:33:57.216
62099af4-17dc-43f0-9690-2f9de337e6ba	Rental Hyundia	3C 8288	44	N/A	N/A	f	2023-07-14 12:21:44.068	2023-08-20 08:34:08.988
dd6b39e1-8671-47c8-8e7d-12aec9c141ff	Rental Hyundia	3D 3283	44	N/A	N/A	f	2023-07-14 12:21:44.06	2023-08-20 08:34:20.298
2e24d271-85b4-4b01-b70c-b8dc86d27370	Ssamyong	2Reserv11	9	N/A	N/A	f	2023-07-14 12:21:44.156	2023-08-11 17:40:24.097
dcb829e1-fa73-413a-95c8-f2cbb47ad302	Ssamyong	2AA 4859	11	N/A	N/A	f	2023-07-14 12:21:44.129	2023-08-11 17:40:28.316
9a65c9ce-f3e0-4865-a4af-562a07a6349e	Renta Hyundai Univer	3F 1406	44	N/A	N/A	f	2023-07-14 12:21:44.164	2023-08-20 08:21:37.029
02dfe11d-a82f-48df-a8c8-ce31cb51610a	Samyung	2L 8346	14	N/A	N/A	f	2023-07-14 12:21:43.978	2024-01-12 19:09:44.434
0a04d741-7203-4369-9ae4-e06809ae9528	Rental Bus	3E 5011	24	N/A	0889681008	t	2023-07-14 12:21:44.153	2023-08-20 08:22:53.304
5d0f526d-be55-4034-bfc6-410e38cf6c37	Rental Hyundia	3D 2725	24	N/A	N/A	f	2023-07-14 12:21:43.989	2023-08-20 08:24:54.298
aa728470-8c19-4d99-9a08-10f2b64d9ba2	Rental Hyundia	3D 7066	44	N/A	N/A	f	2023-07-14 12:21:44.021	2023-08-20 08:31:26.682
5906b64b-3fd9-4e80-8b71-115aa57c67a6	Test	2AA-2000	24	Test	0967521392	t	2023-09-01 11:06:54.973	\N
b7dbc768-347f-4b3a-af18-5ab5d7b7e585	Hyundai	2AA-0000	60	N/A	012345678	t	2023-11-07 07:28:25.825	\N
c87afe32-b2fb-4902-b6ca-f4e6692c664d	Hyundai	2BB-0000	20	N/A	012345678	f	2023-09-19 07:25:26.983	2023-12-04 04:27:50.965
053069da-e32e-4032-b232-db15d9cd9aac	Rental Bus	3E 2719	44	N/A	N/A	f	2023-07-14 12:21:44.099	2024-01-06 16:08:10.196
c7aa264d-8549-4466-9be2-6f2b375f8ab4	Hyundai	2AB-0000	35	N/A	012345678	f	2023-11-09 01:40:25.919	2024-01-12 19:09:44.411
21ac5e62-9a14-4abb-8f69-3eaa72a2a918	Ssamyong	2Reserved	12	N/A	N/A	f	2023-07-14 12:21:44.16	2024-01-21 08:29:09.063
aceeca98-8530-4e00-a74c-4ff83fe96ba1	LX 570	koy009	5	N/A	N/A	f	2023-07-14 12:21:44.167	2024-02-05 08:21:53.727
\.


--
-- TOC entry 3574 (class 0 OID 16453)
-- Dependencies: 213
-- Data for Name: Cancel; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."Cancel" (id, "scheduleId", "userId") FROM stdin;
\.


--
-- TOC entry 3575 (class 0 OID 16458)
-- Dependencies: 214
-- Data for Name: Cost; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."Cost" (id, "targetPeople", "costPerPerson", "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3576 (class 0 OID 16465)
-- Dependencies: 215
-- Data for Name: CustomerInfo; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."CustomerInfo" (id, "userId") FROM stdin;
44dd0f97-c27e-47e8-94c4-4d342d05db24	f1374dc6-94d4-4ec8-a722-6c2637e294e2
ac5bc48e-10de-4f0a-a6c5-36656b0ac3b3	97fc387a-7f37-41fe-b5ab-aa9216ff8a77
8902b9f0-1c1a-4d9c-a7e6-5bf806a6d9ba	bf4ce49c-572a-4174-af18-92561499a666
a0cb17b2-682a-4016-a84b-682e80bb9f79	c70a7341-3015-498a-867c-5aad647beb49
fcc2cc21-6c3d-4c6c-a605-f8847daa7b14	0f18f8ee-954a-4bac-a772-7d7a7a4688c7
c7ecdba8-16a6-4c38-aa63-c57b005dd3b8	143dbb34-1644-4f2c-9e34-b063fab0d1d7
2d8b7239-ca61-4b33-9878-5958f0c5b70b	f5ce7c00-e05d-4fd8-8029-3c4b57db4c5c
d73eda2d-26ff-42d5-96cd-e69b4e84a434	de54b003-60a4-4003-b782-8add34fd6d86
93594f20-1f66-4569-a49f-5bcb402630c7	39df94b4-e962-4a7f-9dc8-b1d381653501
c02ce51e-6959-41ea-b46f-5bfdbd085500	60665637-cded-4de3-8422-cde59a36884d
328c6968-10bc-4b0a-a230-2b521291f6a5	e1e42c53-cc6d-4cf9-9a07-3c853dda5927
616ef6b5-e9ed-4098-b585-16645b57dfe6	32c1d36c-edfe-4c36-9175-b54ce7a86471
1ed1f473-bc9b-4965-bd8c-241158e2b610	2c8b9006-11f4-4be4-a20f-ae937d0aafb1
b2e5b759-a29b-46eb-8211-f87bf7b4b088	a01139f8-911d-46f9-9988-20b68bdc72ef
bab9c1c9-de4b-42d5-8e2c-4c0c00b3dd58	3716ab5c-f25a-4941-a70f-2acf7fcb116b
37482ea2-c6fb-4270-8cd5-8d792d1d8a09	904836b5-276b-4ea5-aee5-1972124ba444
fea340e6-6a21-4949-b42a-b6a1ff674605	a6adc0a0-46e6-47f5-b453-33ae114ae937
95e0734d-ca9b-4a8d-8358-a149406984cf	2a5cfe62-7537-444d-a834-d33b02d261e2
87623238-cd93-4f89-aeb1-5b622e50dddb	6bc1fcf9-3d74-4e04-bd81-d9203aeb8998
f8917930-4a11-478b-9d05-e65d4092fadc	4eec638b-c72e-461a-b477-f4580ae7bf0c
da213fd9-caf6-4706-a002-c8b54f625b5b	ee7e2951-1dc0-46ce-bc5a-fa670d13cc39
8cb8bbe0-810e-444b-8b6d-e3869e28850f	b3e7ba4c-ff69-4292-8109-8da8cda97a62
4b110330-a30e-4ab0-a394-9fecfe1ad1b6	916034f6-a188-4558-88a7-0c313c9b8ab2
9d46d545-aa20-42db-8efb-71583769ccc7	e199c69d-5d57-48b5-856f-9c2ec315f4e9
e1b2c51c-bff9-431c-a45b-a14ea779fa5a	59756565-b44c-4adf-ba2b-efe404d1fedc
80fb043b-92e8-4147-90fb-9ecca06962cc	975092a1-84ac-4791-b190-c459fa11cb51
386b5a2e-94ff-47e8-b72d-e550f33d361b	1b045a04-fb7c-4ea2-8f49-dbb6c8e2ac4f
a969211a-3fc4-445a-983b-f2a69bd3b1ca	ad3c8de5-0693-41fe-a12a-52d3b48dd2e2
7f0cd046-1739-4fc6-89b7-73fbc5571b31	091555b9-d096-42da-9c26-fcccb3edb79a
1892fa25-d8c6-40c2-93d1-78fb4d1450c2	3b8c6e25-b8a4-4882-a4c1-2cd901e92e00
45102dfa-adbc-4be2-995e-c74ff3ff687f	0758cb49-e550-474d-8d7f-25a5d3284b8d
8194a1cf-3cee-432a-9d09-f69f75d8265a	ee87ba85-6b58-4cd1-970f-3ed0705901fd
2a174f21-3993-430e-8dff-6a5476750710	f1c92a36-048c-4305-9d53-e6eabdd63da9
f197766f-946c-44a9-ae34-0413acf006f4	1b563125-d018-4ff7-af19-8d5ab042ac33
aa44c137-0487-4b25-bf52-87e870e533c9	ce23a5c5-885f-4ad7-b536-315d519a4b5e
ab6092e6-01b4-4cb5-97e6-3a5b9280e7f2	62a9ddc7-73e9-478b-bb71-e96bd9592a13
b47aea54-5b42-47d5-b983-8644c071ddd3	fd552629-30e6-4c25-a1b8-fbdee9b1b558
4b96feb8-ac44-4bf1-b1a1-6345108ff7b2	e700aa68-657a-48a1-86a9-71d2e172e4da
9832f432-fe46-4303-a2fa-658e5cd5dd2f	d47c7aaa-0978-46ed-b073-f5d128518e33
fc14eb49-cca5-4b89-8c3d-bfc7ad2dd9e9	3ecc1de3-afaf-451a-a7a2-0968778c8afe
caf9d3d5-e2ad-4d15-be7a-a61677928bd1	b0e6ce80-c88e-4641-b94c-255b49f15da5
d5cbb3d8-a7ef-405c-8721-b4a2af5189f5	1e2ca858-282e-4456-859e-29c56db255cd
f44ecb13-7c7f-4bef-992f-bfdf39d56356	05e18a2b-2ff4-43e4-a757-182d5568fc1a
a8cbfb34-ee53-4d43-a185-4bf21f4c4d01	9bed47e5-0b97-41ec-bb46-731a50cfaac1
c2ba8082-cbeb-4fc7-9217-f55a55d3b02f	6f0f92d2-9fc2-417c-b2b2-492a0442355f
33a3e403-cee4-466d-ad30-80982a40cf5b	bcc3da79-6954-4536-9be4-44657bc4f3e0
550351d4-0f67-46aa-8d27-6baf2d9bf072	4d5d8170-54db-45a9-aeca-67fd6d48c70a
0b560abe-5714-4be1-91fb-a9d4db4615bc	71d26ac9-7dac-4066-9b15-e611e868f52d
7b85b2c6-050d-44d7-9690-df785c2e69ed	6c31b01d-7291-4d2e-ac15-639185f69b89
b2dcd553-e767-4e58-bbf6-c23eb0edf0ea	193a3a3f-3a4f-41d0-ac3a-28566cb9bb22
c3e323e5-bf95-4800-8e68-d114ac972253	04cf7d4a-df6b-419a-8b11-6c92e4f18b7b
08415e77-3952-4b96-81b9-f8965dca982d	7136ac55-b4ba-49c9-a33b-5593146b72cc
84b26b91-26c5-477e-b695-d8194f7c7228	d0e6dc90-e99a-4e41-a18f-12cc92877cca
5d2f0bce-fced-4314-b3b1-852496b9c35e	0aa32ed8-dd69-4d4f-9af2-44e0fa8b3ce0
437508fc-dd0b-487f-828d-b1abb1a7dca3	14bc6cd3-f65e-4ae2-80b2-eff16118a089
c78ba5da-a6aa-41bc-9b2a-0c4667d9a0c2	a33ca2ee-4320-4f2a-92dd-5804d8c2a38d
4c1f5b68-2538-453d-929a-ae01da2b9b26	a7cdcf32-90e5-4e7c-a11b-57864b83322b
b66a1a0d-cb12-473a-ab9f-e9742ba7c093	385f9592-f0ac-4014-b048-6d3dac72f381
67d4d29f-a052-4462-82ea-15526c2b682a	a8dc4722-4c08-4e79-b39c-f560474cb7c2
f0efce46-3af3-42d0-bce2-b3e2d4fa3090	1652c14c-d648-4df5-9364-cb87c310d9d3
6643d01d-f924-47fc-8f66-d1f8d913c4e9	acc69773-acc0-4282-bdee-272a35dd2579
2c8ffc46-a19e-44b8-bc44-0d3f58b54cdc	c5616536-70b5-4c00-b241-bc5d913fe17b
19e98c00-e9b5-4bb0-9980-f935a748db45	168da085-4e6a-4f1f-8c16-40d6c1681e60
b7d4ff53-aeac-46b6-ac68-bab7f22fc783	3faddc5e-57cc-4e8b-b021-5ee31b0c2f03
d6ae5ea3-7263-4c17-bd5a-a949d0225d9c	ddc9ad0c-e40a-4267-9450-0c705dbb239a
170a8e63-cd06-41a5-bb99-0d8a0c2d7a65	ff606822-89c5-4556-97c8-63319d6cd116
161a8e21-09f5-4da4-bc0e-ff2cfcfea2e3	f1f0f766-a85e-4d41-87c6-984ba291edec
4eee4a4d-ae74-44b9-804f-9976b355c1c9	9e6402f8-d49b-4ccb-a4ce-9c276352d432
68899edc-bf0c-4fb0-bb0c-f634f40659b6	2ce21f62-0498-437c-a187-dfd8a60e4e38
ca76bb18-4ff3-4e84-aa59-91854726a8c9	7c65115e-6232-4522-b2f0-4cc297138e2d
da1eacb2-2061-4528-9821-bfe842c47ac0	2b990c9c-4dff-414e-9c8a-78a6448ee318
6ec24056-c1ee-43e3-b649-7305c7b3aae0	37a845a3-3537-4183-a10b-25d7c4f922ac
5c9b3891-5f95-4224-9935-f6f9c00c8a24	7551bea2-f1a4-4244-897a-2b071315042c
9514ba3c-bb88-4da8-a354-52b643adc2a4	07206a59-09fd-4e6d-a81d-33f949123ae0
beefab85-3ca3-46f4-b483-f9e2a6c269a4	83ec7e5c-ba5e-4224-8826-5395b286a145
bde3da63-249a-4746-bbe8-4aa275f5a939	59bd9395-b10c-47db-9d52-4e4418bde08d
14eaf119-da39-4f19-93f9-6151e0aa71f3	3d56810f-2e91-4264-844e-08d7626c9ddd
56780d38-6643-4443-8ed8-58bcadc80b9d	26fea8af-15f4-410b-87ed-d7913581d6ee
5c48c491-b526-4c90-97ea-07b45171ccb2	2c47c092-0b09-4ed2-b3b4-1fe0a8ca3e3b
704df2a7-f07f-4d7a-a378-7b6c40d4a881	e1ed41b7-fcfd-4fe8-9dc3-16fb9d821320
d2f62b4f-f906-460d-a030-cf9499fa8f99	0e9ab026-da30-4618-b4de-2e29b3a7b403
9ac2658c-8d1f-4b4f-9a2c-563023c7a52f	8bd7a978-7c8f-45b7-9b2c-cb65c1fa9ed9
033cb756-7337-4af1-bf06-939cf2fb1a7c	6910e32c-d3f8-46cb-be9d-0fa16a61200b
5cf1a123-19ad-4b0b-b084-d07b7f5e62ce	f8c19dca-7e5b-4c4f-87bd-6c2eb8933e02
707a9385-07a5-46e7-b747-26862ccdf2d4	77444f1b-59fb-4f6d-a868-215e6d93442d
48662c26-ff56-4b5c-903a-dc5a2ecdc607	2e6bdb09-c11e-4d39-ac69-4cb993a9d5df
46ddc71a-a0b5-4fa2-bf18-da18f92681ad	de3194d3-89cd-492d-84ac-fdad69989349
87133cd2-fd1b-44a8-acab-26af7eb66b74	bdc97d97-7408-4a35-99a2-e811e32f1c2b
0d1f760a-75c7-490e-904d-0cf6af7d1c89	51b75e32-2d2d-492f-912a-250ac690d0c7
0e2c74cd-b527-45f6-b6a8-43bbecef9cda	f0c27457-c435-4e98-a6eb-b1595139ffb1
63b6091a-2f47-411d-bed0-8b1fb399c8be	e89b529e-0bc7-4e78-af9e-dac7d70d4099
9cc1e147-4c30-45e0-8484-46aebf39f41b	db956646-6a50-491d-9300-3376ec87b143
f288b887-a1b0-4bb2-b270-af8777bb01bf	c319d322-4539-4bb0-bc7b-f1f758a02cad
d194c37a-1eec-47f3-b758-abfac26ab0e5	ccdbe99e-85a7-4304-8057-ae41ac28e37d
d8a1a227-e067-49d9-a567-d001114dbaf7	ac3d9e04-a639-4efb-97a1-a1d1d005e2d7
7a6334bf-2440-4a32-83fa-a4fe3d107809	c17f952d-23a7-49ff-b098-264f8fd64427
36d95422-862a-46d2-82b4-c53173368422	91fc0bf3-fe71-4f72-8b71-5d60cda551a4
4d06b65f-a283-4962-acb9-957bb6468af8	d4d1bee4-5858-413d-8501-438576d411c8
cf9203e3-bd6c-4e1a-9802-266a84fa6e71	e5141c98-f0b9-41f5-b2b5-0d1d62fa1b7d
7fd5e88e-44d7-44f2-95c8-9c46ab11a3c2	d7861827-9130-42ae-a873-39d0ec01ef12
399ddc84-71b6-45e3-b1ee-9ff156a7d238	32b9bf3f-b4ff-4947-b944-c938d90525a9
b5dc00f1-59f1-4ee1-9537-b1de0ee646d2	08b956a5-f7d8-4cf6-bfbc-216ff58d14eb
2305bbba-5907-45a4-93d7-e91ecc9855b4	ec6dc7ec-5eee-407d-8a1e-edc1124adce0
dbdc1ff7-1111-46ca-ad4a-0011d59dc0a4	2afe3a0e-a85c-44da-a10e-c3dfc6a80ca9
1fabc1a5-bfa3-4314-b970-8d4096ba934b	57102497-cbf1-4df7-8ea3-794e9e2bad7a
831ef591-6179-41de-aed2-421df0925768	af1fea14-2a0d-40eb-b086-7969f13a0c93
dbcb0604-bfde-43f5-ba18-fb7b17569230	e8e95ef2-8676-4300-a40a-8aca8e44d66e
84be52a0-fd05-4d5f-9960-4f87f29d2984	db01abd7-d894-4373-b5a1-4e71d2566c46
2ec4ac8a-b524-468f-8731-c70ad6571c14	7b0f4128-a2cc-47ef-9f69-fc4eda20c4e6
954361c1-890a-4970-8f3b-2dc26e415237	9a40da8a-1dc7-4e62-b7b4-cdef433a8fae
5c45a637-525a-4966-a718-3391c89590f4	dafe86a3-5cda-4133-bad0-2fd975b5051a
3e30085e-bb0f-4dcf-ad55-304c12b88deb	9217ec96-cb71-4ff6-8986-ef57ee095770
75870c1b-b4b3-42a5-8c27-3970068a354e	13760dbe-a10d-4f6c-a274-b61960483476
2d29b96a-6a2b-4c2d-b277-cba8134ab405	aff1a48d-797c-44c0-8190-cacc8f92133c
6f3f558e-e1f9-48a9-a2f2-7d36421eec41	f60ee515-0b19-4ed9-8ccc-1fd9d8d326c3
c377d6da-901d-40a2-b3ff-5388afb81cd4	c7cf595e-7a30-4a0c-b611-7e8c14dec761
c65e5aa2-224a-40b5-aab4-1dd5857d2c72	8de9623a-5f81-42d9-b21a-f18abb15a4e3
0fef3e36-aa94-4a1e-9327-79320e7b1bb6	bae3de62-b4ac-4258-9d05-6c9790b4c141
3a900095-3133-4af0-8650-ee58a909c52d	0cb4bba6-193b-4a85-b72e-5326e3ad46b0
56318c31-4f57-448e-9b91-31bf68b1145a	118aed72-cc52-4097-8629-eb5ed3e3a8bb
3f6e4952-56eb-435f-9d87-0fbd8f1c6e40	fd3e76e6-84cb-49c0-acee-b241511060fd
e214df10-44b6-4097-bfdc-b6472e3906e6	8521a08b-5e2c-47b0-b960-926007857ef2
75881f15-83f7-41a2-994b-cbc99d51ba47	53b03e87-b4d3-4446-a533-1f4903c9bcff
a7c632a8-7c63-48b8-810b-48519ed93049	261be16d-9d6c-45b8-a33d-e7bccc3f3ae2
caee0b21-b37d-4e96-96f1-1ba9b6d33d19	b5e884e8-76a0-4e54-9186-d57ff6c2c64f
71a9640c-0aac-481c-b856-10349de778d5	31fdee9d-e17d-45fb-89aa-f87e9ef1a3fa
e49e17d5-7f46-4eba-b8b7-a25b7f16bffa	aa796ce0-413e-4277-ad36-9b9fb51df2ad
c88b7cf8-b104-4539-b870-5d6f1580ed86	23a86c01-37a9-475a-b8ba-2eba9f6e8cd9
d2b748a4-f435-44a3-a60d-30a17aecb49e	ac151a61-9546-4449-8aae-a9397c859e09
66c49f51-d813-4362-95de-b458ad630805	29767fb9-11aa-40e8-be4b-4d4f986da0b6
71e2be89-89f5-4517-afd1-ebc4d4fd424b	8eef5adf-05c8-4f6c-b1b1-9e23d3cb59d2
eea64171-0e17-466b-a900-8ae7a902c662	119cba60-d3e7-4b1d-a972-c1af69324792
5793e2d2-7bfd-4385-abdb-f786d9dfba5d	8ee0ceba-5557-4e9a-8897-2bd46cb341af
80946400-db38-49d8-ab58-c2dfb5f3751b	cdb10698-feb4-4e38-9458-1bd62682b473
3b20ea6e-a89b-4000-bcfd-67887296a851	d9bc14af-a842-4452-b18d-639a6b42063e
2230dede-a15a-4453-8f4d-ca6161c10368	6dfdb3c8-238e-45ff-be4d-f0745da25e10
2d231818-96b8-418a-aeb3-b7af653020ac	169a129d-de86-4c76-97ea-7d7f042c6c2d
d14cc3e8-3395-4b8b-b4a1-b065cfd0a32e	2e7bec3b-bb0f-4a10-9859-9d5a64d954c8
12079bd4-61c5-4ac3-ba67-39809515578f	eb4d6eb3-1dbf-4f27-9a08-7e941126c1c8
d1a7cea8-6e75-412e-9840-cf7d13a969a7	764ec087-f07a-4d79-a1ec-69327053df8d
345f5f41-f889-474e-9737-cf10d2334c14	d3bd8039-8ce2-4897-9b2d-4728717b60a2
eda171e6-7e43-408a-8cb8-f7a3f7db3434	ad6f650a-35a4-4b29-b298-5e433eb22956
4d61bf9d-8d3d-4646-aa79-b624154a7b3e	c8a8f6a9-034d-4832-823e-1472c86a5486
e2089715-e040-447f-bd64-383492027f9f	f0b2a434-be54-4f53-994e-a9ed82eab2cd
6a6692be-d724-450d-81f2-e48490faacd3	d6d6ad67-5ba6-4ae4-ae8d-79e09e62b8c2
0c9f7c83-92d4-4af4-bc25-3728f42c796d	36d9db1d-cb84-492d-9612-ec4de3f84b6e
79d5a701-fa8b-4aee-bede-c61547269fb1	3f04996a-6c72-40c9-9b46-db0af3c22dfc
3bf197da-7f84-4092-8d53-f2e0f1932287	52f6e3c4-ecef-4bb7-87cc-3358f4466560
6e142262-98fe-4146-b9ac-31820b84b4b2	df4c883f-38f5-4c1c-891c-0c5e4db615ef
f1d35b82-c447-4518-973d-f27a6fd2ab5a	811e0385-f4f3-4b2b-b7b4-c45ad5d68f06
b1f67ca0-7c63-401a-be8b-f1ffee5fa2fa	0173745f-cd63-40ac-924f-8c00f71519bc
21584b0b-25cc-48ae-b082-e7dbe1ee1e92	6a82418c-c7f2-42cd-aed1-b864342a1d44
80055029-595a-41b6-a4bd-b008d32c5f39	627b5cdf-6ead-4aff-870a-ac7d1d8aab4b
ca3776f9-1c4c-4d1d-b3b7-0dd6757f03b5	fb42ef4a-39e0-4f64-bfa6-7b6b1625dbe3
53678770-13d2-44dc-8f90-244260b5529e	d9010519-3230-4440-9e2d-c614e0507f31
f35443ef-a742-4645-be19-2818fa69c3fd	4ccd5be4-d354-480b-b411-de6e2ef182f0
ac9c7931-3c64-49f2-8c3c-402b22e4d85f	99e8546d-45da-4e6e-b0f6-b12eba890b03
c5d7c6db-6935-4d01-95e8-bb66df303a20	57479900-654f-48b1-afa0-aa46daac26c6
1ca48dea-4343-432e-8313-aff839e6c903	4dbbdad8-381f-4cd7-befe-2fe92a60584c
e63f14c4-6091-42fa-a1a7-cb77f6a3bc13	9745c0ed-ae17-4aa8-b0ad-38197749f379
491db7ff-4a76-494b-81cd-fd06da76dca9	2e81a7e5-31ec-4f05-9cda-f51b970b10f1
1ede2716-0bee-4138-bce8-ea3e867ae8dc	5a232203-3430-4efa-ae8b-737f3843ae0c
53e63b1f-5061-4f2f-83aa-df3d5ad88a4e	6bb06091-9085-48d0-a269-61da83bb9f74
154d9dbe-6f47-4ace-b28b-b74e9119a8ad	f5723c86-06ec-471d-aaf8-178eeeaf6263
5e3a900f-e3d5-42b5-bf54-8a29f9ef9a3c	cf1b9a49-f7e0-48d1-af4d-689ea9c60cff
c7ae80d6-0151-4f96-9022-ee4a91b9a991	ddd4f317-3bf3-40f2-a944-82b190700ad1
510f3688-3f71-4696-8133-e8798022a650	40202d17-158d-47a8-9b46-df41185629fc
a6ed1d2f-ed9e-43cb-b8d3-3271349528f8	12ad6b7a-4dc0-4b1d-9165-38c204c1987a
de68d144-ac5f-4f4a-a076-ba564213aec3	ba219b91-9bd2-49bb-894b-963b25e1babe
fbc8b382-d617-4aa2-ba4b-9c54ffba3b7e	461cbd13-61ba-4581-b44c-89793fc63341
286b6e69-c238-45d1-b70e-df861f5f10b6	768b68f7-803f-4a8d-98f4-842ea42b4528
13c8d149-d6b6-485a-bd28-3a0cc35d02e5	5aff7c5b-2ca2-429f-924f-49cea16a3054
6695a02a-b224-4c6e-8292-377fa0e09424	7e8d8c6b-8643-48e4-a41d-635f89a340bc
76cc52eb-2a8d-4489-b27b-11329a111040	d0a65794-2df6-4356-ae35-0f3353f5c508
1f8ba7dd-dd83-47d3-a65b-1f20b6fc330d	8078376c-4d8b-4fa0-a463-d33c7844bdec
6b0b9cfc-5142-4dac-add5-ebf959b01367	4c30ecb2-70d5-45cd-84ea-970280efe8a2
307df81f-8aa7-49b0-bd08-fe7eafc9fa85	4507893f-3a2a-4cce-9ae7-80aac59af508
014fa984-5ee4-468f-af7a-372bf57d4843	0c325c08-01f0-45d0-9575-19e89f3d156e
7a5dca48-19a2-49cb-bb84-f674488d434f	8acfb075-ad87-4fa5-b1b3-435af9e9ed16
c6ede2bd-3770-4c2f-be81-f67775bc69a8	c44afb73-8480-43fb-bddc-279ae14e9bcb
b5410d7a-eb30-463b-b3fb-56d10c7115ca	5ac0315d-cef7-40ff-8f13-858202897870
ef395bda-b6d2-4e8f-b1bd-f39ef10b0843	2bc5f450-a446-41f6-a389-d3893d3d974b
0d0f8bd7-4954-4dd1-a186-50ce8ccfabf0	02896cd0-920b-4858-9904-18b490b22d64
f2ee9a08-94fe-477e-bb22-30a14ba6450a	857651c8-2c71-4bc9-9452-d26fb7cc6815
e0effb7d-a226-4271-9842-f85ba3114e80	857d57fe-be40-4868-b956-25618e05c2ab
cae6385d-9fe2-46f8-8e54-ec172230f083	d4594493-49fe-48f4-8f97-6e561ebb1114
ab41b122-b507-4631-afc9-a89fbe41c13e	3b0e2812-b940-4c8a-b208-bf1b6e594b4e
10b9571c-6cdc-4444-b846-af4e295ccc60	48a6eb49-af68-4c66-bea3-ff39b58b13df
72e20008-304c-408e-8756-0a7d75367775	4a65fdb3-f19b-4787-855c-e8c74d14b7c8
ed9917e2-c05d-40df-bc2f-28c2eebf4a2e	638b29da-b3f1-4a03-b366-6abfeab3f52f
d7e973b2-869d-4096-926d-e17d6e1146e8	32cab213-02a2-4644-9090-6c9a0101cf7a
7e252cbc-f4ce-4622-8129-db145c9a3db9	8612c096-6f37-45bc-94bc-19781699ebcd
0602f519-c941-4eb2-a3c0-40b15293d159	b4b39204-b3f7-4dc2-a78a-ec866ce6b3d3
d3f122e4-4ab3-4dfa-874a-70b2fd364d11	e0df823b-5567-42f6-a825-fb414becbfc6
64dac2b7-bbe0-47ae-b727-64175bc8c374	9e536c81-d210-4ad8-899a-fed30f483f50
ce2579ea-9d18-4460-bd76-5ad27e98124c	38fc16a7-1ba1-4ba7-b23f-7370d38cf962
24b6c42a-bbb3-40e7-a5e2-e86ff6596fb3	96bd4bb8-ce81-4473-8318-b0e59297f483
8abf0a5f-48ad-4b2c-a887-0238e988b1d4	68b1baf5-3fa4-4478-8f5f-4c74b7bbd20b
4a9d19d7-cb72-4236-83f3-de88bc18e954	85f4d975-a485-454e-a048-049b7d8a193a
342a057b-b42e-474e-8df5-0c6f6e7914b8	4e6f3e22-e2b2-41c3-baf6-d536e04b188a
21ca95e8-b598-4f47-9d32-82a2813fb5da	52de9971-31d0-4aff-ac66-e7a058ba2a24
aa412caf-c50a-4b6b-8ddf-db96494ffd6e	fefa94f4-7c25-4620-bdcb-a4a3ff77e2d3
5a52b790-c933-4200-adb9-b75c7d9c1cf9	574021d9-904d-4dc7-a814-c11c2ed149e5
549bd81c-7b22-489f-aa52-607872ce63ee	658c83ba-4e82-4a75-88e4-0de6e6238efb
13cbeb66-72ee-41b5-a9b3-7cc155e09a1c	efe4b707-1eb3-4e85-8369-f12ab304bf13
7e4e18df-cb4a-4ea3-adde-cd1d5a434c7f	8cc0ca84-f0b2-45e4-8cdb-13e8f4e9689a
35d6571f-6b15-46f8-b7ae-9537d7fdc722	10781b58-b0a4-4087-9adb-29afc57543ba
095d6429-01e4-4f16-929c-31658c030336	817e3d95-e81f-4fab-aad9-b82737d94c87
f72f0ca3-d36e-46b6-b4f6-e7b34642e4c7	5b808274-c2c9-4c4d-a9d9-567f823c9a17
adcfafa3-82ea-4f2f-a1e9-1d8ca28f7985	95660623-6eed-44c2-bd82-03e329ece377
85bcd100-ed39-4e0b-ad84-6e6f6e1b725b	e439263a-8704-4d13-9ceb-dc0bb84b0692
46579767-48da-4a7f-805a-0ced8600f797	d046bb49-af60-40e7-ae2a-a5e2b01520e6
1bf20d33-1501-42a4-a5ec-aa26f2037b79	3d3be792-e14a-4a63-94bf-34525489971f
355de8a1-6048-40c7-b5aa-bc2dba2af838	ee676bd9-31c6-4f3c-b3da-706b70122f2d
cbe43af6-d44d-44c9-aa80-dfafce354774	48abc885-7464-4c6a-94fd-433429f1d13d
eab57c09-bf3f-4dda-ace5-d9ed7c73e4b0	6dbcadf1-6345-446b-82a1-389237cb4a48
eb064cbd-9443-4e1c-9c8c-6eb9890d0d9d	b9319ddd-66b6-41b2-a3a5-7eb49b9b4764
1947e410-9d8b-4120-9fd7-aa6189558c3e	e35f4c26-2123-4a10-b791-859e8a11b4ca
83f54ba9-f3d1-4287-9759-efb5f8130fd6	b5b022cf-503d-45a9-8751-0075dc714b2f
b9931133-071e-4a10-a8c6-c059741f09d2	0fd4b340-eeee-4225-8b9a-5b01c136652c
8e359ceb-76a1-43ee-a51e-d095b7ddcc9f	b9ffa1fe-6db6-4c96-a086-1eeeb4f6aa30
b6171d27-5e1f-415f-a0f4-3b77b677b0b8	78e7f610-5fff-4bb9-9727-5213bb3a7673
171e5d4f-1225-4200-bbdf-65106abd1239	7c78df1d-d005-4b2b-b3a3-8f8b8b2a2c35
2cb0adb0-c273-4996-b0c6-6415eb4727f1	a66e45b6-4d57-4d74-b42e-df9e1b7662d1
b6767b66-ee87-4255-abe6-6f1903f41acd	0ce0fa93-f7f6-446f-96f6-615fb76bd611
3c807d1d-bad5-4795-9d88-192924bfd294	e7f1d33f-f06c-459a-a248-2ea842afb3e7
f71cc4f2-88b8-4098-91f3-86111b72a6f6	8c72e738-4027-4bcb-9efe-8d3c5f70d005
11654ead-23e2-4855-b0b7-d54e778d90b2	e421e6a0-6cb5-4e5f-835f-54a6d906c143
f2be8618-9aa4-4558-aaab-28c75b01f3c4	7033587d-1fcc-4272-ab36-a6c1f977ce40
ccf73f44-121f-47d1-8c67-dd3470de3832	57504b9b-0db1-49af-b72f-b0d9b7289517
034797b3-e460-41df-8262-aaf75bb0e3c0	4c123ac9-eb8f-4f4c-890c-e61e54de9843
5d089de3-b314-4c71-9041-d5629e1f6a71	371f5af8-b1a6-4540-8815-5cd7ea1c8761
9c1a8f84-b4f8-46ca-ad62-38d1d299670e	575b05d6-098f-42bc-9bd5-b636a13dcd25
9276501d-74c0-43ce-b0a9-2e8318f3a219	d3500035-d125-4c41-8445-ae1719d37d61
40ea9c06-ed22-473e-bbc6-84fbfb80b089	f6cceb56-63ca-47cd-8453-6b8aed9d2192
e245969a-034f-4da5-8f31-7d6cad4bf23e	13086738-7f53-4eac-8b7e-5f2859119927
18ca9c27-85ec-4757-bdbb-b24bab33e157	ef78cf17-ceb3-4de0-9ee5-c406bf4387b6
5fe61a77-7516-4cb8-a444-ccec2462b0b7	ea2c8a95-a722-4700-9c8e-8f3d62247ab8
e2f84311-2272-4453-a509-540c290e8e22	0eabce33-da5c-4b70-b9ba-74a587d7324c
f4077a13-3cdf-4ae8-97eb-d5bfce5f7782	cf9d9a00-43bc-44a3-9811-7cca4cd3192d
b2ea67a6-98a7-49fe-a8b1-2661dac411a8	66b720cc-d797-49b8-b037-c7ecefb868da
ea1bda94-4398-4f92-828b-a0aaa35d90aa	5c4e5ac8-32b0-4d98-bc46-b4e3f902e5cd
1ea02fec-1d89-4fe8-9761-aa4690d1d9ee	4bed94f3-77ae-40a1-945b-6838bcafcc91
bf7ce93f-d496-4323-962c-6fb987417d97	94b48649-3267-40f3-aec3-844504be45cd
8a3fbb43-b907-4281-a843-c12c1b438bfe	4991a60b-33a7-4aac-b63a-c0ad6e421c20
a928578b-578d-4f2f-802d-07e2e59cfeda	85a95169-8e3b-44d4-ba70-0a07699fa91a
d946194a-7cd5-4c23-9252-eba0e010af30	bbbdef3e-2a9b-4bca-b7b7-7c5a6fb6cdfe
ab5572f0-c1c4-460d-b927-0ee1fb3be89a	e2bcca4c-495d-48e8-b30a-c6e83e26df91
c93804e0-4b36-48de-9087-fcf41e5fee81	bb274cf4-3139-4617-8c03-994462b2ecce
ae710b8e-eaaa-4bfe-9f5b-80fbafbaa6ee	f8e52ba3-fe75-4a0c-92a7-ca2bfe7b12ac
d4381a41-572e-450b-9d43-0625d16e811f	07896e51-8229-4006-8325-0b62a9d34d3d
8b2e73bd-f278-4e1e-9566-34ac83ebaae5	b37b4f85-c8d2-499b-a940-9042550189f3
6a5b0d20-14f3-4d63-a6ff-9e9369245a82	c337313f-df96-4e9d-9543-9c60f1f2af2b
87acdc04-c2b1-4992-84d2-6081d10a5862	dc53d4a2-e160-4ae4-9b4c-4da60066bd70
ee3005c5-9d95-4b9f-8c83-e0dbb11c6081	13b67709-beae-462b-944e-54729bb7f033
746ae71a-a414-42be-8d54-9ddef20cdc91	f2daf226-26e3-41e2-980d-18c8c51c74d6
6eba7a71-3577-4109-bb3d-18aa3681f3f0	09df83dd-3b8d-4b8f-a24c-9530327c6b7c
93808c73-b83c-4d79-bbae-4e6db278de66	01952ae0-7134-43f8-95cc-f707c962d2fe
835585d9-07b2-44bd-8212-39de7747d87f	96de76fb-6399-4e44-8ba3-f8c0ba68075c
aef01eac-a92b-4c2a-9c89-b1abd1be9231	ca1af010-dab5-4085-b5cb-5cdc7a18c35f
13c51a8d-5b21-4701-9c20-3d01d4172c8d	a5c1f755-6c6e-47ff-9553-886a230c2c48
8daccd3c-befd-430d-a3b6-7f4897fed51a	7315e69f-5c5a-44bd-b050-91327eb9d195
0be32d5f-4e40-4927-a826-ec4141999d6a	3a015924-121e-4489-844b-7520d1fd92ad
2f7505be-1de7-4110-b96d-c173cf646a98	f249e3c3-a18c-4494-be02-db37e3447986
b6a570e0-c281-4406-b6f1-465baf7b7814	789c9ddf-de93-479b-acad-8030afb00298
722f33da-b170-45ac-b50f-ac41044917da	89fa26c4-2047-46f8-95aa-a655af6b7f17
09a84001-2b42-4003-940b-afa798cf3609	684ab8e1-6bfc-4c0f-a2ab-134a7393ae8a
45b2f896-55b5-4a7d-9e77-b8b90ac5c8b7	9ed09ca0-781f-471b-a238-d69552529c99
e0cc02a8-78d6-42c5-a7c4-ce9fdb91a91d	45ec31fa-6963-42c7-a20d-ba806418be77
6f0d8abf-c0e9-425c-ab64-f2d87f0c036b	cfa9dc99-58c7-4f1c-89d7-b01e9869b629
01bb427d-a4e5-4934-88e0-3ca59bbd6708	3b3a905f-8476-4335-b72f-fd2f99d3e98f
939d567e-7148-4f85-925b-1643a05f04ce	172124d7-465e-47f9-a73d-3138a2a466b5
f30f144d-d295-4334-b893-da34e77e8b08	b3bb5842-d623-4a05-92a3-11c66f213302
cf6b046c-4511-43cc-821a-9dd9f8c69a48	34a94828-a325-4e65-bba3-63b185c4c8ef
f034c348-53bb-402d-8c4a-d191fce32066	4edf5a2d-7673-49c5-92e6-065e673116a8
aad7dea5-394c-4939-9d57-05f321860106	40db351d-5f46-4c44-ae7f-b271ead4a986
7e8cbec9-54ab-41c9-b588-5b3a41b44f81	1adcc413-1648-4750-add5-c2c459ad321d
f1b0ef12-706a-47a8-98a3-3a95e1a6af4d	86fa1f1f-86e7-4116-a367-788a5e14b718
fe07570e-9313-45b1-9d7f-5d5fbdd2f343	7fa18a48-cfa8-453d-bc6c-3b0398784936
66aa5150-10b6-4c4a-a2b3-6ed207a7a4c9	c3140d9c-210e-44e2-b178-908092f6639d
7c27e9a8-0695-4a08-9a5d-164ac53d447f	9f7bdc66-388e-4faa-8eaf-3e2d103c5bff
94a18c61-a317-4f14-89be-8bfa1ff98ff7	8684283e-1e2a-4731-b93a-20bfddeb7157
f11681c2-3655-489a-8b26-b8f135334f3b	156f9353-f315-4519-92c0-7d678c349490
2bd65330-b0f0-48eb-9f0a-fe302b7aa0ab	78f0d1d0-dc11-40e4-af8e-29f477473bfe
c8393b3e-f14b-4fcc-9f00-69c660c325d8	17ada07f-c47f-4d75-9055-609512823973
04543ccd-429a-49ef-9a04-15e21d603540	50c0fd37-59d3-4b08-822e-00b896c5760e
a3343907-35f1-4fd0-ab5a-8d94925bbdd7	c3de77fc-4084-473c-a30e-b268ea63cccc
0d30d5f3-aff1-4d3d-b65d-ff6bf03033f4	2749787f-eaf5-44f9-aec7-d94b8672caa1
a50b21e1-cae2-4a2b-b55c-20c18defad49	5b19817d-4c6b-47eb-a057-11754ec7cc0f
2cc1deb3-6a68-4e49-b2e1-289e6b88b98b	3bf329d5-35ad-46df-9e6b-eca9705e8226
3d36c9e7-69af-40ac-affd-7efd1fef18fd	44e78dd8-8bdf-419f-bc5c-bf55896562d8
709583db-904e-4e4f-b468-247a09696728	f2ab59d6-c4d5-4552-8e44-d1826f4fdb4f
e8725afe-1ee6-493d-b700-1ba594248e12	4904f6a3-ebf1-44eb-bb8a-6e6cd5b29e3e
0d4345ab-1b7e-49e5-9bd7-fd75bab3b28a	f9bb0462-fa0b-4863-bb13-441fcdbb97bc
49ff6df0-0308-4932-a197-3baa75e26b28	04eab87c-d9c0-48f6-b17a-b7d8b89dbdd0
3ea92873-a771-4d7d-a469-bd0895fe6f27	f42c7c36-8b7f-48fb-bea9-b77ef99dbcd1
c515a793-e90f-454f-a8fe-60822fa12af5	18513307-e9cb-45ce-9509-f8662eeb3c59
0a1f70b0-8a02-457b-8478-cabe16ef83eb	c7f0810d-0833-46c4-86e9-46ad795f4483
743eac6d-db6b-42ea-ae31-aebab8195a50	f064168e-9ca3-41d4-91c6-bfad00ee398f
fc798db4-4c1b-4682-b603-5857f0352bd0	476dd647-6de9-4d27-b74e-f6e92d31d9fc
4c8f73e1-08ef-416b-b8c9-b8227c80e890	c33248c8-07b1-4bef-a967-df38ceb2b9b3
9cbf81fe-b2ee-44cf-a545-e0c15df48fdb	5feb5172-0471-4ec5-a0ca-bcbbffda14f5
02628da9-416e-40dc-ba6f-3d50cc9b78ae	0d7bf6db-8751-4974-9a48-7a8056ee88e2
cdae62b8-aafd-470d-9f62-c0ac00004169	5dbc5ae6-ffe3-468d-aab8-fdf488d08c17
9e217b21-0154-415d-9c0a-26bf6f26d46f	77105a3f-6fa8-459a-a70c-ad14a8d82f60
d869d35c-ca37-4a75-ae0e-a7856baa9f0e	d8efbc39-25af-497e-ad72-bdad95ef46ec
20f90d6c-46f7-4bd8-868c-79a041a901dd	e8ad2327-0e82-4463-8ac6-b69d0f432a2d
db702f53-6773-4dae-8f48-03689aea1abc	9cf5fb2d-1bf4-4151-9204-bc3509da165a
4b3938d8-c516-4088-ba1e-a159a000e82d	92273b61-3e7a-4761-820e-60911be55fdd
dd3c433b-ea37-47ab-93ea-b1cd5acf581d	6e0dc227-6134-4138-b6fb-ae7d9e4a6f62
72a63860-02ff-48e2-bf23-2e3dbc7b6f77	424b8239-bc5d-4f51-8c47-9563af1218c3
4223e7e3-07e9-469e-94ab-65fe47dc88a2	e0b9b0ce-32ce-44fa-9249-4f037c712337
1da75f39-5191-411f-a0d4-a123c0d57f38	ab16e74c-a1f1-40bb-89bb-8540a4d0be7f
e9a4bad1-f24b-41d1-a325-de23bb38ec04	2886d14f-e343-4981-8150-841ac69435a3
3b4b8cd4-01f6-4dde-8056-d4e50a4da2c3	1e0d3d6f-d497-423a-988b-8f5191c2e884
9bacd074-b216-4ec4-a10d-ac2f5d0d2102	f60adec4-49a7-4180-b97c-bb26c7cff48a
143961e6-32dc-454f-9283-bb8d5310d782	09659221-9841-4353-bc0a-dc6f848438b4
287fa10a-a3ac-43c4-8de1-3f2171b31ccc	814d0a9e-eb03-42c6-99e2-238c86181162
8727c102-5aeb-425c-a968-24159cd98313	82b5a84e-1ed0-4027-8aeb-5345f75a0865
3533d38e-6651-4dae-a592-7c945617fc7d	4f24d554-f4a8-452b-9fb5-ea67ae7d3937
b38383ff-1665-4c9d-8cfc-cad966b7cd90	46009ff8-f58f-4269-8dfa-0ad4e65b368e
50e3dc3a-2897-4dfe-b47e-288a7077241e	09e93eaa-30ea-4806-8a4f-68fc4a869d32
9b172d18-3d8c-4206-8f2e-c8d3c099fb79	5250e3c3-6275-4047-954a-482c3acce023
f2ce1aea-ac6d-4e77-87e2-46ab0cfd3469	f5871ea9-a45b-407e-ba26-d6f69e24f642
ef07c830-61cb-46b9-a64d-b4ed786a444b	53697604-fee6-417a-b9e4-34bcfe7bc7d8
c5b958e7-f053-43ff-8da7-7c63d0cde638	bf355690-fd6e-4b6e-8ef2-e293da482e06
e8d8785d-fc2d-4143-a71c-fc521eb0e587	2e5c2ab1-7e1d-402b-a801-a496defe19f5
11e2b636-4166-4c1d-85a0-5446daf022bf	a90be607-9ea3-4f1d-8a5d-334b8618d372
c1c4327c-8768-4a5e-83d8-486abf795a42	0da26372-48ab-4a7a-947b-e651ca1b79b9
faae010a-4d94-4525-9e82-ebfc90785b03	48050c6b-5df4-49f9-aa5b-a7176ade46df
7c0742d6-1ea8-4a2a-8ce4-f88511f1f378	b2586066-acdc-452e-9f19-b851efd9a4f7
e96870c5-3125-4cfa-a1a1-52ead96ca784	28c68b63-8a38-477c-a39b-ee7799588fa4
11f1718e-a43c-452b-bb33-7c8d69973847	9bffcbd8-d305-4b0b-a9ea-700fb1bfc926
9652517c-1d59-4449-97fe-25c317b3396b	87c79c83-3321-47b9-ae21-1bfaf63b32d4
767554fa-45fb-4bf1-b734-3f9aae3313d2	8600daed-36ab-48ca-8519-0cdada9ba497
bde97fd9-9704-40a5-be03-a812ec63aff5	ddfe9f1a-7aee-494e-ba78-dd048bccdfef
3c900c38-5b5b-4f1b-a775-04689c3f1963	33a03037-c391-4fef-89fc-a8b5bf660e9c
54f400bb-2344-4f17-a028-36e163faefad	dc0a9424-4569-4565-84eb-f9c113d7691e
297760ea-3bfa-4a4c-82fd-51165dc31c45	714ce6ac-c1e4-4a8b-a26c-12627ba485c4
cce30ac6-1601-4f72-ac6f-b4704eb1463b	ad27d1d9-ad36-47e7-a549-f526ee58d73f
2b36a51b-c6ec-4f29-b77a-1e38d4586fa6	f742f1a4-1ff5-4e87-a88a-2a191c4bae94
c3213534-a072-47eb-b4fb-338d21ffc9e8	214a3df7-f077-44af-a23c-a10264644459
f3745ecc-e84e-4499-84e1-4b5674473769	419d4339-3e9c-4dec-bc4c-5f82a220d894
8fdd2875-5246-41d8-bc27-d1998ea834f7	0d0b998a-fa54-4ede-8658-332a845cadaf
fcc50f12-b828-4a93-9c74-e0969d334acf	a06cc791-0834-4659-9428-97b17a1efe4a
f147b94b-f0cd-4ad6-887f-b6a030746e23	95da5417-3369-42c6-a38f-ea191168d51a
e3918c53-163e-4971-a0c0-8db2ea15122b	1b93ba4d-e853-43cb-8960-6540ca2eea1f
5615a644-47f7-4e2e-adee-dac8c2de666d	7e983cb3-ecfe-4334-bae5-9343a4c6ef75
\.


--
-- TOC entry 3577 (class 0 OID 16470)
-- Dependencies: 216
-- Data for Name: Departure; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."Departure" (id, enable, "fromId", "destinationId", "departureTime", "pickupLocationId", "dropLocationId") FROM stdin;
9c601b67-3ba5-47b3-84bc-99ca39dcc8e3	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	00:13:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
be24ea06-87f6-48a6-a73d-00e9a0b3eaa7	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	00:08:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
f42b319a-d6e8-401b-9ae6-2ed847a0e40e	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	08:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	13:00:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
34aa93ea-c9b9-4330-8a13-3522dd1d9238	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	08:00:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	16:00:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
384f44b8-29bb-404f-898e-a4919823f91b	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	09:00:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
6b49d4e3-f4b5-47dd-9fea-fb78187d84e2	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	05:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
1895b86c-fb3e-41fe-a5c8-0dc617f391aa	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	07:00:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
5e1c0929-ef35-4d9f-9f4b-cd24b3a66e74	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	15:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
52b1e174-916c-45e3-81d4-f3596ed6ca8b	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	10:00:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	13:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
ce266fd6-ebe7-4d48-a1c5-d064ffe1f292	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	09:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
2b5583eb-23fe-4b86-99d3-970a30beb166	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	14:30:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
505dfc0d-0e7f-4303-be59-74a2a8fc2d3d	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	12:00:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
6dfca435-536a-4fd7-b6ff-f2a163ac2ded	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	14:00:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	06:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
b20d2832-4740-4f13-ae27-9b6738a1083e	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	11:30:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
13cb8c7c-f522-4c87-a6a3-1cd2515acaf4	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	07:15:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
81aef3ed-f05d-48f2-b7cf-aaebabca955c	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	16:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
11fd42bb-8087-4075-afc7-419c5bf6fc01	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	11:45:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
feba6c1f-a359-4162-8471-4df5994d4d4b	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	15:15:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
a71258ea-db77-492d-a4c0-5b2458db460e	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	16:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
00ffab8d-fe4e-4ffc-8ded-4923527e207d	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	15:00:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
0ea3ce20-7bab-4b58-89d1-b18552b58ae4	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	15:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
07c2fb26-38a9-45a4-a923-338f1b4eef35	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	14:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
63e8f037-9766-46d8-85c9-b2838393c953	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	07:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
ed53e116-0d54-4c98-a66d-3e3b0b4c864d	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	10:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
4d03281a-2e2c-4280-bd97-3136122fe750	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	14:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
ca2f149f-87a1-4bfe-8309-9c9b845a692c	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	08:30:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
91358bdb-d6d4-42c7-90b0-ec820721d350	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	11:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
5ec011c2-3145-4297-9c01-8fdb1f2a6906	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	17:45:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
52090ce7-d56d-48ff-ae9c-f3c47af0b829	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	15:30:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
796aa924-1c13-4286-9268-d19ab3f82892	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	15:45:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
9afffda6-46a4-4262-9436-39f3d7d3abb0	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	14:15:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
37cedc13-b71c-437c-8a8d-fd36de695d4e	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	07:45:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
24ae20e1-50c7-4f33-a41f-08530977511a	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	10:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
85059cd7-2c06-48e5-adeb-74ae4177722f	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	08:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
a89bb6d5-3a2b-4a67-98d4-5ad79d90b366	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	06:00:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
5e68d1fd-f252-44d0-b889-e109ea5bd10c	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	16:45:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
72613196-6819-4d69-8e6d-ce781ccd58db	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	11:00:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
0b858375-5c55-4acf-8175-6bcb9d43fa3d	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	16:30:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
1b052437-ffe8-40ef-a40b-8fd9b306e0f8	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	11:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
cb7e4521-6f30-43b3-86ab-f50138d949d8	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	14:45:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
a805db41-cb6c-4996-99df-55e6498293a0	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	17:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
d40170b9-e86c-4fc5-ab25-ec2e100f06f4	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	08:15:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
55d1ef9e-7db5-4a83-bbb2-fc59381cc2e4	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	05:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
329c7248-3a54-4fe7-b61c-f4a22d8e62ba	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	09:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
988a9845-25fc-419e-928c-91a962e80427	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	04:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
992513b6-13f7-4dcb-8471-84972522feb3	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	13:30:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
1dab66fd-8ebe-45f3-b8d6-bfdb14fb8c75	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	16:15:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
b99e1e6a-1648-4640-b0dc-94f42640c60d	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	07:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
76235d70-f972-4b5b-a5d0-5b454b2ecd98	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	07:30:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
d9c6e4ca-5969-462a-9582-bb68f0e09a29	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	06:45:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
c6c0b44a-df6b-4663-801a-5e13d23e6d72	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	17:30:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
bca6e4a5-0cad-437b-b1a8-c7b58857b5cc	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	05:30:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
caef805d-8d74-41f2-acf1-d0500f72b1bb	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	12:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
2021e0d6-9c32-4b81-8c6e-a3b386ad040b	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	10:30:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
06cee4ec-e321-4092-8d7e-976de2f31216	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	18:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
49d25125-63e5-46ca-bddc-f5a7ab8ead0d	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	15:45:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
1daa5d71-ac7b-4bc8-aeff-1f3ef743af01	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	06:30:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
55654d0f-1853-4a92-836a-6c34015daa23	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	09:15:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
4f5e6758-8b47-4e4a-8214-15a4c3486a94	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	12:30:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
6cf0a255-f003-48ac-a467-b0f081f901dc	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	12:15:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
ce40f82f-1412-4e20-8044-61b4a375732e	t	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	13:45:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
06e79466-6c8c-4bed-8015-085b7884e934	t	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	06:30:00	f182bb98-d81b-443b-95ef-c9b2d643e7d7	9e284787-ca4b-4035-82a3-6709b5c4e64a
02633b99-91e5-4a8f-90ad-68d8511141e0	f	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	12:00:00	9e284787-ca4b-4035-82a3-6709b5c4e64a	f182bb98-d81b-443b-95ef-c9b2d643e7d7
\.


--
-- TOC entry 3578 (class 0 OID 16476)
-- Dependencies: 217
-- Data for Name: DriverInfo; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."DriverInfo" (id, "userId") FROM stdin;
eede977d-aff8-48ac-89a4-646da190ac05	2b2badad-093f-4269-861b-3ecc18ccae0d
b02d0137-7d8f-4a1b-b973-1fce0845c0cf	6972a602-301b-41ee-9c0c-98fb5711f61c
a00702b4-88ea-4fe5-bd2f-b273cc65a892	b83a332c-30c7-4ea3-b1ea-7b539de59736
ad428407-b708-4774-80e9-ab8b3900a790	a71f62cd-cd75-4fe3-b05a-8dbcc8378835
9f58a63d-f30e-43c7-9963-8a1b2c813647	60e23362-b1e9-42ef-8b54-90aedb2a007a
e1c92e58-27cd-4232-94e6-224a4e452f92	848828d9-3be0-42c8-b79d-b29431475074
a92286cd-fa4e-4227-964f-9f97028ce64d	ad0187c3-9f37-4d8c-ac4b-7ab2d3650ef6
8f071ef5-a968-45df-885e-c09faee0914a	0575fc59-d2c2-4787-9719-40447e9ad712
a81af3be-92cb-452c-86d2-363e01cc4628	338f3865-449d-49ff-b9a8-d47f4f458010
05e7332b-ba4e-4f5b-8365-795d9faa1f94	3ef809cd-8bf9-42fb-b508-d4d480d67491
2c2389e7-2da8-48e7-b233-9a50c174cc36	72bf90bd-a7ab-49f8-8fa8-300a8f1c2642
d1b0f417-e202-4544-86e0-2848a5fa1591	26f83bd7-814b-4014-927e-8c93a234277f
f46e92e5-04b8-4d7d-be74-492f34cf79a4	0a61eaee-22f0-44e4-82b5-7edcaed9fd78
1a9ce102-1503-4034-b5a8-83595af4ad16	1c2a1416-fab4-46dc-a3ab-dfe3a6d110bf
24dcede6-9cf1-4943-b204-2414d4d5ae58	f4250cee-c889-49bd-a69b-2734b8b11954
92edb5fd-d3eb-4a6f-9721-14ac641719af	25f9dc8f-6f7f-4233-80a5-01bc279857d1
603c2824-186f-4985-ad19-c1b3454cfd06	e08c9428-d028-41e5-a5e7-3f285f90f4ce
07723061-7d2a-4414-b208-af2ec9aba73e	cd50da09-ae91-4456-aa17-90884ab1ae3b
27616899-5a85-4947-9162-0ffff1502950	73961a87-36f1-4d0c-8479-c129a8171f7d
88c363e1-c1b4-48b0-bbb1-d381441f1a42	761438ca-1107-4d9e-9f83-2ca639d7827e
6d2b0df3-e346-44d4-af8d-a7b8f3e97df6	cc9ea9f5-6725-43a7-b144-fe625311909c
a19f6653-fe96-4ec1-a8ef-d0417c02f472	cd6778f2-737f-48f2-b4a2-2f4a52519607
529f4245-45bd-40f9-a2e1-668f54cb0f7a	90d67c39-e60b-41f5-ab0c-821b39f77384
273ae817-39e3-4cc6-8ef5-041ea71a1b48	527dd3e3-5ffd-49fd-b899-93e6c35c831a
3f7e04d6-3b1e-4c1c-989b-1392324f3bae	56bbc7e8-d465-424e-b82a-1dd91c403b83
18927199-94c0-4460-9501-201668f34a9c	9a56bf6d-a15b-4a0a-977f-18c300a8f434
2ac1b202-4f2d-40c4-8a83-c893962b7eb3	e067c226-d756-4568-a76b-451d3457271f
43e2cb47-f0af-4d72-a150-2383e055606c	da655f4c-4ec4-478d-b187-34fa260734c8
fa1378bc-7970-42a9-a173-e5e8c1d0c18b	e20d88b0-9244-4f5f-a5ba-3ae5f016b52b
58de2b23-ce64-42fb-9c91-09bc76c86692	468967b3-1841-49b1-a2b0-d9242614b636
6829fabd-13c0-4804-aec4-dc86f4abd758	50200c15-886f-444d-90e6-d0dec0050164
2925dec1-56b5-4f69-9605-43893386ca1e	afb4f979-ded2-4e42-a96e-134d02c59259
33d3cb37-04cc-4a51-8cb9-0bb6828336f5	33c20c28-4c4c-4649-8dc3-466c8334fe8c
2ce348e1-bb1d-4733-9b75-8c04660d3310	64b52e7d-6e28-44c1-9692-5685e65a498b
f2603ef2-27c9-4ab9-83b4-476d893c1ce9	2891e90c-3d71-4abc-8c85-e5adf057f555
971e4f7a-9611-424c-9f36-10dc4dae8fc4	679e24ae-a049-41c7-922d-079c18219f47
2aa2d80b-8074-4ff2-838e-d6f0abb9a9e8	c051290c-838e-4cf0-94c6-6d8b9b1475f9
e7a83681-94a4-4dd2-924c-f42b1450f9a8	8580a4e5-3169-40a1-bf8d-333f0697ff1c
6792f6c8-0c7f-4f18-9a05-a71fa3586ddf	f2927252-55ce-4266-9d97-a71d9895f6ec
ef18d5cd-de2f-4e99-af17-89614f3300ea	39b73a36-3f7c-4230-8828-efe6dc2d5ea9
c1c37e31-e3fd-4d66-b232-1d45a0579796	b0208fc2-679f-4f87-bb5e-c7255a85e812
8f8ca50d-ef77-4186-9b7e-2b80a34f4ca8	195472d3-7c1d-4c89-aa17-321834fcbf19
62d83b25-c4dc-41d6-bbe3-0bc943e37c59	5dcc9273-5678-452c-a9d1-f9f94dedc4b7
f9a4ca1a-ac9d-4a2e-adb5-7df6b2ab50e6	8e9492e0-44e1-4fe5-a238-780d50905308
87fbbb39-da38-4417-a73d-4d4c8f83eeff	22768d8d-4d30-466d-825e-55aaf0f03a17
6a7c167d-56dd-42de-aa18-1e87ec28dc66	5de82f4e-3582-4cce-806d-34d981288e68
e19fe7b3-fc2b-44bc-9047-c472da999336	c874f80e-a7cb-4f62-bb79-ad7002ea40e7
d6a958bd-9b5c-4f3b-a6ea-665e05629520	e2576780-50d7-4900-a265-aaa34a916e17
b8460bfe-55b9-41a0-94f5-cc04e0c580eb	5906676a-cb35-4fb2-b60f-a27b3bb11aaf
9ba0cdb2-1853-4002-96d1-fd5c86700877	6aa536bf-d6d0-46d4-87c8-38ede8a98db8
777cc71b-c765-478b-9589-0ae943abec3f	96b388af-29ed-4456-9b6b-2cd9c84b717d
cb8f6ca7-f75e-4a83-8929-c48b09751415	7b6a2d99-3055-4850-9631-cf37d08ec4f6
b5474839-c44b-4eb8-9d6b-d7f7ac2e90ca	b186e7c5-88f5-499f-8365-e4978a34909f
a27fb0c4-f77e-4101-9088-5644cc4adee7	f789ba9d-7e29-4d69-aba6-a746bdd18881
22644430-7cba-454a-9354-6c3acd11753c	5a595640-c932-4354-93c7-515b8fd85d34
32fd4a40-88a0-4b5e-be90-3f27a0fcef0a	327eeaaa-e258-42ee-8bc6-a16f06f64a8a
4e469ff6-9d76-4d2e-ae7b-44e6301d4d4b	b64afd65-685e-4b1d-b983-df5717349802
bd6520cb-28a6-469c-9c07-d4c8046f65ab	498f5467-031b-4892-8ae5-79f5b71dfdb4
4a1a75cc-a3eb-4ed5-b787-b3e3c2b53520	f221c092-22f7-4a55-8feb-fe42e124d985
dcfc1bee-b999-4309-903c-314237f210bc	094aa68a-8fb2-47a6-89e3-ac3501724433
c405947a-f248-4f12-9799-ecbb3289c7a3	90ac374b-e443-4716-a7d9-e9656af0b790
5f9af452-714f-4361-8b2c-cb91cc20738d	5632e662-0e21-4bac-98cc-7b13971d6590
cdfb85b8-522c-4886-9bb2-3cd9b88695d1	576fe6af-767e-44fc-8875-40c0e0592213
4150d9cb-2ba5-4a27-a93d-17530bba70f5	5a57ed00-d704-4a37-a207-5db9a9a5e7b6
e98fbfa3-1a85-4116-84a0-6b4f83c32d89	c3a49556-93c2-4e1c-ba2b-4571ce041d6d
5b34e0c3-ce16-4035-80c9-c861b267a77e	e4ba6750-81c3-4ca7-b848-a1b0c3cebd2f
600bfbfb-1c54-49e5-9a7a-7f742da0ef5d	06a863c0-980d-4ac9-a82f-d36ea1c8b1b9
29cc5162-434e-4724-b414-ddb15b2e8a8a	6c4f49d9-ad71-49b5-8970-24e4bc041db3
6f9d5ad2-1694-42f0-b23a-ad2a262fe874	51fa6060-a331-41c3-aa59-c29ada2e19cf
35100219-a48f-4126-aa24-9e92f4b59b06	ce8cf1da-f4bb-4a36-a025-135db6d7d9ea
30f48ea4-6819-475f-8ecc-67852de9593a	2a0fe2eb-5d21-4640-a1ec-3eab3d7f5691
3cdffbf5-388c-4ad2-8404-31db621fcd31	02b81041-6c40-4302-a321-d9942448db22
f2db6fcd-7085-4fdd-8f77-c89ada2a2909	7042d43a-5d28-4ec5-b81d-3f833c15da6f
652e9d0e-0c9f-4cb7-b62c-b9a408da50bc	c3bca25f-cc80-48d1-9d7d-87ef693d1b97
cd987ed8-8490-45df-bfe0-2f48f9de7d8b	13afd05f-c375-450f-8d17-eb721f3f7d51
5a0e30be-41c1-4f83-8226-57490648a3b5	8b8f8aa7-4844-48fb-ade4-e6ccccf55e06
bbda340b-f3d1-476b-9a6b-9c9e1b97e41d	f5ca0883-c719-46f2-8f8c-345034061c88
0e023897-59d6-4a3d-a098-6d1d2249cf3d	93177a13-5ba8-4d59-8991-8b1c9ee20b72
c6747d9f-90b9-4f88-be28-0a71eef6b7f2	1c2d5854-e03e-4b1a-9c15-233cdbc94096
6ca86137-bff1-4f9e-af70-f2f316b33e84	24d612bd-0f70-4f49-b312-f5e5ab46cbec
\.


--
-- TOC entry 3579 (class 0 OID 16481)
-- Dependencies: 218
-- Data for Name: GuestInfor; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."GuestInfor" (id, name, gender, "scheduleId", user_type, "createdAt", "updatedAt") FROM stdin;
b23ee840-255a-448c-8f71-ef5b2b941260	Bruno	MALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-14 16:44:34.254	2023-12-14 16:44:34.254
0645ee67-6392-48a7-be38-2d0bd565c967	Brody	MALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-14 16:44:34.254	2023-12-14 16:44:34.254
79b7b9ee-73af-47c8-b385-5d7c04a01dd6	Karrie	FEMALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-14 16:44:34.254	2023-12-14 16:44:34.254
5c57c445-ad1b-464a-8f38-d877cd675c6d	Wanwan	FEMALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-14 16:44:34.254	2023-12-14 16:44:34.254
98a6a3a3-9bad-449e-9fca-b1df9179bb9a	Leapheng	MALE	00276ec1-f26d-4106-8c50-3c5f86a94918	VIP_GUEST	2023-12-14 16:49:19.751	2023-12-14 16:49:19.751
7e8aa4c3-4236-41d2-96e7-8d9b0d34a223	Seanghor	MALE	00276ec1-f26d-4106-8c50-3c5f86a94918	VIP_GUEST	2023-12-14 16:49:19.751	2023-12-14 16:49:19.751
323b7213-05e6-45c1-9fd0-dba3056f5f58	Bruno	MALE	49c2d35a-8d05-43d7-ac9a-d2873cfb4a06	VIP_GUEST	2023-12-14 16:54:22.641	2023-12-14 16:54:22.641
a9b61676-9be2-4601-b38c-273261fe9e94	Brody	MALE	49c2d35a-8d05-43d7-ac9a-d2873cfb4a06	VIP_GUEST	2023-12-14 16:54:22.641	2023-12-14 16:54:22.641
9f500995-0386-477b-a487-57b8827947c0	Karrie	FEMALE	49c2d35a-8d05-43d7-ac9a-d2873cfb4a06	VIP_GUEST	2023-12-14 16:54:22.641	2023-12-14 16:54:22.641
2b9a5183-0b23-41c8-8cdd-f97b7209ccb6	Wanwan	FEMALE	49c2d35a-8d05-43d7-ac9a-d2873cfb4a06	VIP_GUEST	2023-12-14 16:54:22.641	2023-12-14 16:54:22.641
5a060641-b63b-450e-9ea8-3ed58bac634a	Leapheng	MALE	49c2d35a-8d05-43d7-ac9a-d2873cfb4a06	VIP_GUEST	2023-12-14 16:56:35.449	2023-12-14 16:56:35.449
a0f910f6-d020-4f58-a74f-6fbb8ea639eb	Seanghor	MALE	49c2d35a-8d05-43d7-ac9a-d2873cfb4a06	VIP_GUEST	2023-12-14 16:56:35.449	2023-12-14 16:56:35.449
9198cb51-c60a-4ce8-9c14-8985f0872edc	Leapheng	MALE	49c2d35a-8d05-43d7-ac9a-d2873cfb4a06	VIP_GUEST	2023-12-14 16:57:48.474	2023-12-14 16:57:48.474
4c065dfe-664c-4e79-b633-9cee8326cca1	Seanghor	MALE	49c2d35a-8d05-43d7-ac9a-d2873cfb4a06	VIP_GUEST	2023-12-14 16:57:48.474	2023-12-14 16:57:48.474
d7bf3d5e-87f3-488d-891d-326771adf882	Bruno	MALE	b41adb60-92d4-41e4-8d8e-767bb37d8dbc	VIP_GUEST	2023-12-14 16:58:49.866	2023-12-14 16:58:49.866
6552037b-b0bd-4b4f-911c-c4c1f1a3b668	Brody	MALE	b41adb60-92d4-41e4-8d8e-767bb37d8dbc	VIP_GUEST	2023-12-14 16:58:49.866	2023-12-14 16:58:49.866
62366583-16f9-4c2f-8a59-786911b7e429	Karrie	FEMALE	b41adb60-92d4-41e4-8d8e-767bb37d8dbc	VIP_GUEST	2023-12-14 16:58:49.866	2023-12-14 16:58:49.866
2f313342-b02a-4925-bd62-58a39cebb764	Wanwan	FEMALE	b41adb60-92d4-41e4-8d8e-767bb37d8dbc	VIP_GUEST	2023-12-14 16:58:49.866	2023-12-14 16:58:49.866
f22c3df8-60e1-4f5d-b9b1-01431fa8bd94	Leapheng	MALE	b41adb60-92d4-41e4-8d8e-767bb37d8dbc	VIP_GUEST	2023-12-14 17:00:18.146	2023-12-14 17:00:18.146
a08e3a1b-0fc5-464e-b940-b09fa833baf6	Seanghor	MALE	b41adb60-92d4-41e4-8d8e-767bb37d8dbc	VIP_GUEST	2023-12-14 17:00:18.146	2023-12-14 17:00:18.146
2351f250-84e5-4f4e-8fea-73f4c3c2b617	Bruno	MALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-16 14:06:55.843	2023-12-16 14:06:55.843
1cc2b292-f5c1-4f4f-873d-5593bcd1d30a	Brody	MALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-16 14:06:55.843	2023-12-16 14:06:55.843
11c1642c-1b8e-4ca5-b75a-12809a981f9b	Karrie	FEMALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-16 14:06:55.843	2023-12-16 14:06:55.843
59996a6e-6eb2-4386-aeb5-4f6ea013a464	Wanwan	FEMALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-16 14:06:55.843	2023-12-16 14:06:55.843
622ae9b4-adac-4749-b157-6b3a1e7fb803	Bruno	MALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-16 14:07:18.881	2023-12-16 14:07:18.881
85c7b129-5c5b-46d4-ac25-fa7f782058c4	Brody	MALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-16 14:07:18.881	2023-12-16 14:07:18.881
f5322cfa-6b8c-461f-8365-7fa44a7871fa	Karrie	FEMALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-16 14:07:18.881	2023-12-16 14:07:18.881
6ec75fc5-acbb-44db-9a13-3f690b55861b	Wanwan	FEMALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-16 14:07:18.881	2023-12-16 14:07:18.881
759e3592-c29f-4298-b093-cff9bfbef7da	Bruno	MALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-16 14:07:22.765	2023-12-16 14:07:22.765
c30c23bf-668e-4ea0-8ad9-26b5cc3d082a	Brody	MALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-16 14:07:22.765	2023-12-16 14:07:22.765
9fc4ed8b-fb11-402e-a9aa-52278fd146f6	Karrie	FEMALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-16 14:07:22.765	2023-12-16 14:07:22.765
162312c6-a916-46aa-8991-5b37225bf4bf	Wanwan	FEMALE	9f187ed5-5dc0-41b7-a47c-cbc5675af431	VIP_GUEST	2023-12-16 14:07:22.765	2023-12-16 14:07:22.765
703dc6d3-ca61-46a1-a185-51cfa71d42ae	Leapheng	MALE	b41adb60-92d4-41e4-8d8e-767bb37d8dbc	VIP_GUEST	2023-12-16 14:26:41.445	2023-12-16 14:26:41.445
fb90106f-68f7-4029-9545-7b641422d586	Seanghor	MALE	b41adb60-92d4-41e4-8d8e-767bb37d8dbc	VIP_GUEST	2023-12-16 14:26:41.445	2023-12-16 14:26:41.445
308c4eb5-65d6-4d35-887b-eca03f5ffe14	Visoth	MALE	b41adb60-92d4-41e4-8d8e-767bb37d8dbc	VIP_GUEST	2023-12-16 14:26:41.445	2023-12-16 14:26:41.445
a468d594-1a64-4bb0-96ad-f076275c0836	Chamroeun	MALE	b41adb60-92d4-41e4-8d8e-767bb37d8dbc	VIP_GUEST	2023-12-16 14:26:41.445	2023-12-16 14:26:41.445
ff4a3c74-ba58-425c-8063-eb39133e13cc	Kimhour	MALE	b41adb60-92d4-41e4-8d8e-767bb37d8dbc	VIP_GUEST	2023-12-16 14:26:41.445	2023-12-16 14:26:41.445
def569d5-ff23-40c7-b6c0-3cb42e3a8491	Leapheng	MALE	4bc94403-a9a3-46b2-b5d8-d75cec72ee36	VIP_GUEST	2023-12-16 14:44:07.987	2023-12-16 14:44:07.987
f9864295-97d5-433e-bdaf-a64221c9e4b3	Seanghor	MALE	4bc94403-a9a3-46b2-b5d8-d75cec72ee36	VIP_GUEST	2023-12-16 14:44:07.987	2023-12-16 14:44:07.987
1c9d6e3b-0bb7-4281-b0e6-488f62d99bdb	Visoth	MALE	4bc94403-a9a3-46b2-b5d8-d75cec72ee36	VIP_GUEST	2023-12-16 14:44:07.987	2023-12-16 14:44:07.987
577a8d33-f0b3-47c1-bc63-e4513296a48d	Leapheng	MALE	4bc94403-a9a3-46b2-b5d8-d75cec72ee36	VIP_GUEST	2023-12-16 15:01:59.788	2023-12-16 15:01:59.788
ce24c41d-0f8e-42f3-a44d-e6b92f5b58a2	Seanghor	MALE	4bc94403-a9a3-46b2-b5d8-d75cec72ee36	VIP_GUEST	2023-12-16 15:01:59.788	2023-12-16 15:01:59.788
d08b7d31-c18d-4421-8d5a-229cbed178cc	Visoth	MALE	4bc94403-a9a3-46b2-b5d8-d75cec72ee36	VIP_GUEST	2023-12-16 15:01:59.788	2023-12-16 15:01:59.788
97f2be1c-9369-4205-97b0-f19bbe75ab39	Kimhour	MALE	3f9c421d-0799-43d5-828c-0a26d838abb9	VIP_GUEST	2023-12-16 15:04:22.399	2023-12-16 15:04:22.399
e29a10f9-fe0e-4740-b796-87c0f625467f	Monirith	MALE	3f9c421d-0799-43d5-828c-0a26d838abb9	VIP_GUEST	2023-12-16 15:04:22.399	2023-12-16 15:04:22.399
83a5f5f9-377c-4711-97aa-ab5b183dd698	Seanghor	MALE	b84eef4c-d299-46a3-af65-3d660a3c2456	VIP_GUEST	2023-12-18 15:23:41.167	2023-12-18 15:23:41.167
32cb586e-f1c9-4ab4-bb6a-e9a34f2fea5e	Visoth	MALE	b84eef4c-d299-46a3-af65-3d660a3c2456	VIP_GUEST	2023-12-18 15:23:41.167	2023-12-18 15:23:41.167
f1259a88-f87f-43ab-9aa7-03adc1b326fd	Chamroeun	MALE	b84eef4c-d299-46a3-af65-3d660a3c2456	VIP_GUEST	2023-12-18 15:23:41.167	2023-12-18 15:23:41.167
6bda93fb-c808-4e8a-9fae-a8ba4ac90e93	Kimhour	MALE	b84eef4c-d299-46a3-af65-3d660a3c2456	VIP_GUEST	2023-12-18 15:23:41.167	2023-12-18 15:23:41.167
e186ceba-76d2-4139-8ae8-a30f0d8993d5	Kimhour	MALE	0442122e-b1c6-479c-9b27-61d4922fb63f	VIP_GUEST	2023-12-18 15:27:47.764	2023-12-18 15:27:47.764
ce77e9f2-f116-48f8-a627-3a8f50335c55	Seanghor	MALE	b3dc341a-1874-4a73-a814-978e8f49e9c6	VIP_GUEST	2023-12-19 17:16:48.236	2023-12-19 17:16:48.236
191de968-bb27-4afa-9ea0-ebff2ecacee2	Seanghor	MALE	0442122e-b1c6-479c-9b27-61d4922fb63f	VIP_GUEST	2023-12-18 15:27:47.764	2023-12-18 15:52:37.223
78851806-fe56-4bad-a0d9-ab73cb149c8e	Visoth	MALE	b3dc341a-1874-4a73-a814-978e8f49e9c6	VIP_GUEST	2023-12-19 17:16:48.236	2023-12-19 17:16:48.236
4aab6ed9-0056-4e69-93f9-3160effbd934	Seanghor	MALE	870fb66b-be4a-46d9-9de2-a0cb800cbcc4	VIP_GUEST	2023-12-20 14:19:25.606	2023-12-20 14:19:25.606
72eb015a-5c49-4d08-a28e-e570a9d7f5b2	Visoth	MALE	870fb66b-be4a-46d9-9de2-a0cb800cbcc4	VIP_GUEST	2023-12-20 14:19:25.606	2023-12-20 14:19:25.606
1b00af1e-db52-47b5-ba85-bd0eec3ebea7	Chamroeun	MALE	870fb66b-be4a-46d9-9de2-a0cb800cbcc4	VIP_GUEST	2023-12-20 14:19:25.606	2023-12-20 14:19:25.606
d9862c9a-9505-42e3-8552-e45565ca8987	Kimhour	MALE	870fb66b-be4a-46d9-9de2-a0cb800cbcc4	VIP_GUEST	2023-12-20 14:19:25.606	2023-12-20 14:19:25.606
\.


--
-- TOC entry 3580 (class 0 OID 16488)
-- Dependencies: 219
-- Data for Name: MainLocation; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."MainLocation" (id, "mainLocationName", "createdAt", "updatedAt") FROM stdin;
db04eb04-8ac1-4a7d-96eb-d2c3742116f4	Phnom Penh	2023-07-14 12:21:38.289	2023-07-14 12:21:38.289
9be53471-0fd1-46f7-bed7-ecbb3681eeaa	kirirom	2024-01-11 18:45:38.504	2024-01-11 18:45:38.504
295c7871-18b7-4d41-a3ec-973183e865d1	Aeon Sensok	2024-01-11 18:48:47.022	2024-01-11 18:48:47.022
2eafe9e7-f757-4e35-8243-6108b3d6b1d6	vkirirom	2023-07-14 12:21:38.289	2024-01-11 19:29:36.847
\.


--
-- TOC entry 3581 (class 0 OID 16494)
-- Dependencies: 220
-- Data for Name: ManualBooking; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."ManualBooking" (id, name, phone, "numberBooking", adult, child, "totalCost", remark, "scheduleId", payment, status, user_type, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3582 (class 0 OID 16500)
-- Dependencies: 221
-- Data for Name: Schedule; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."Schedule" (id, "departureId", date, "numberOfblock", "availableSeat", "busId", enable) FROM stdin;
88e1e338-30db-4fbf-9ab3-90647bda99f4	00ffab8d-fe4e-4ffc-8ded-4923527e207d	1970-01-01	24	24	02dfe11d-a82f-48df-a8c8-ce31cb51610a	f
546edc6a-c66c-45b5-af19-98b347fa02c5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-12-18	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
6d4b8e9b-66cf-416f-9023-55c0dcca07c4	9c601b67-3ba5-47b3-84bc-99ca39dcc8e3	2024-07-01	0	5	aceeca98-8530-4e00-a74c-4ff83fe96ba1	f
098d2ce2-8ffd-4929-b853-d48dae110bf6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-11-09	0	60	b7dbc768-347f-4b3a-af18-5ab5d7b7e585	f
6e420e08-d411-4af1-9ca5-5dd0476a3b93	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-05-27	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
af5c35a3-b994-41d7-89ac-db53df966f7f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-09-11	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
d9246992-3569-4814-834b-2bead5961d44	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-08-21	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
77fd2b4b-3e8e-4c83-a8ca-29909ccf3c41	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-15	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
501da7bb-45b6-41c3-9684-950b0b10518b	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-11-01	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
8431a3fb-a9f1-4bdf-93ea-5d6607ec39ff	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-14	0	24	d3c4102e-f5e7-4eb0-b0f4-0988fc29552d	f
c5178107-feee-4576-9562-92a600709532	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-29	0	24	50ff5482-287e-40d6-bf27-d383dc105dc1	f
dfad4fb2-709e-48e2-bbe5-341e22fefad7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-13	0	24	9a65c9ce-f3e0-4865-a4af-562a07a6349e	f
7e364ef4-8dff-461a-a97f-abed561b6fd1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-15	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
39c4ed89-fffa-40ec-b260-74ab7fe3d518	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-18	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
08fdb1f7-6c5f-439e-93c7-fbfdaaf67907	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
198cbfaa-508a-4fc1-9161-8538162bd7a0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b4737dfa-9cf3-45b0-975a-dcb1877195d9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-06	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
a333bf41-d679-4aef-b64a-8a4a5b3219a1	feba6c1f-a359-4162-8471-4df5994d4d4b	2019-09-10	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
90fbd0a8-1c3d-4ee9-b520-8898850a1167	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6cc6bbe1-f268-4819-ae97-88bae6a7e2b9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-01	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
88885010-5062-4013-b609-c0ae2c8990d9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-15	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
179d96f4-ffd7-4743-add2-073767199fa3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
363609a1-4edb-4a0c-bdc5-72bacdf06bb2	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
17dbd26a-4111-41cf-a7dd-7b8a6d3f1e20	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3d688761-8fe4-4a10-940b-eb21db33596d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-16	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
a70d2f6d-ed2f-4494-ab0a-bcd2f25d5a36	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-01	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
8e886b19-6dd1-424a-9b4e-af1783cf708c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-14	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
b28945d1-ac73-4d8a-aaee-9c36b6d620a1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-19	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
994cdf44-c25d-4221-9598-a732765f60d6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-30	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
bf290dee-a1ad-48a2-93c6-bad110953950	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
616c1da2-f4df-4520-9485-b7f99f9fd064	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
20574127-8207-4ba7-bf5b-b1e62288e8ac	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ad04f5ed-e44a-4c43-bf2c-7f1194b788bf	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
4235bf49-52fa-4239-8efe-de5bb602dfd4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
cc66b5f0-a44e-4ead-b7ca-93dc1eb16e28	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4a782652-12f2-4518-926b-2cb0d057f993	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
38eaf368-03d8-4b77-af4f-bf6848c0aa51	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-04-12	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
c577a7d2-18d2-49bb-8669-7799d2cf1b94	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-01	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
19a139c5-32d8-4a87-a39a-a7a28cc3c11f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-23	0	24	c347aff0-7a4d-45ac-b051-63222b036c8f	f
2bfcd386-c3a1-479e-8a9a-35c9373139cb	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
400f89a8-a61f-4355-8d65-8a40f8bafe38	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-14	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
1c8a0517-d9c4-49ad-bfcc-9a2877ca0c53	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
eabc2af8-bac1-4bb3-abb5-c9340a992380	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-21	0	24	e551c73b-0e3b-4a8c-a38c-5d92766b114b	f
a0ef74b2-6699-47cb-bccd-5b10c39f9164	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8d23f068-173a-47d8-b340-2405bed843a2	63e8f037-9766-46d8-85c9-b2838393c953	2019-12-19	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
98abed26-27b0-426c-a3b7-2b4276a470a3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-03	0	24	eb12cb32-b602-4a96-8d96-f9c78fb22c47	f
248b5420-601f-4c81-b989-ce8c5994a326	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-24	0	24	4f9cef16-551e-42ae-b4a1-887e5d0b0980	f
67ec0e12-39de-4b49-9766-656fac100453	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-23	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
87b6ad69-5448-4dcc-8c9b-f30a10306055	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-02	0	24	d7c22c08-80ed-4efd-a07e-e45f51d85822	f
b3a3ffc4-1dc8-4fee-ac94-5e3464626177	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6c17ce40-cc23-4114-9abe-371615c32321	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
de98b296-771a-4cb2-a73d-037821ba18d2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-08	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
66436ce2-5967-4704-acd0-a1129960bd19	52b1e174-916c-45e3-81d4-f3596ed6ca8b	2019-12-20	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
2048a80d-804e-41ad-9f4e-de0520edf14d	63e8f037-9766-46d8-85c9-b2838393c953	2020-01-16	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
bd6f030e-9b3e-4a72-9cff-3f592008d7f3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-29	0	24	4dff09ea-616d-49cd-aef6-e7292675243d	f
32ac61ca-18d9-4f34-9270-0fab9f01a254	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-10-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
493b212e-1ebf-4b94-bcaf-a36484b277dd	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-24	0	24	72a311e0-b2b5-481f-aa98-0130d1dee157	f
c23f7396-ff98-46dd-992f-561dd4f91d58	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-15	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f72e3cc7-268c-4ae6-9fc6-8797e858a67b	ca2f149f-87a1-4bfe-8309-9c9b845a692c	2020-08-24	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
4c53c8f2-86fe-4ae9-90a8-305ae44a605d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-03	0	24	30acec88-4b11-483a-afd6-da3f1c8c0620	f
f69ddcd8-e165-4dcf-a556-3a4a69cd1690	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
412e4175-1d28-43d1-9bf7-2f588dfed0e2	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-02	0	24	e551c73b-0e3b-4a8c-a38c-5d92766b114b	f
800de37e-c690-4985-a31e-880bfc7dbce7	9afffda6-46a4-4262-9436-39f3d7d3abb0	2019-08-09	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f997da51-55e4-43b8-b43c-d3c5c9fa8335	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-10-12	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
bf2fe481-d42f-4f35-9655-f9557bd67459	07c2fb26-38a9-45a4-a923-338f1b4eef35	2019-12-06	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
854cc4d5-6f54-4f76-9dc6-b20c086f43ee	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-11-12	0	24	aeb73b0b-22c8-4188-9504-1236b19e11e4	f
99be379c-8974-4f01-b441-244d43b93c38	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-07	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
8197cbed-5370-4444-b5d4-525f11929655	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-29	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
b7e7fb94-0bf8-4960-b6ee-a8e5d0e4ece4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0eb2db08-a22b-49e7-af49-c904af5a0144	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-27	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
0a050ba2-aaf0-4005-91c7-27e04f27e332	9c601b67-3ba5-47b3-84bc-99ca39dcc8e3	2024-07-02	0	12	21ac5e62-9a14-4abb-8f69-3eaa72a2a918	f
7d694869-81ba-4f47-a1b8-0ec39761ca16	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-12-16	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
4e3fe5b3-7bc5-46ea-bf8e-b844d8d05ad7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-12-16	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
77349d3d-c0d2-43cb-97b3-5c80e7a3afda	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-10-07	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
59c77789-d76c-4222-8cda-99cd269768ed	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-10-11	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
ce7e1008-d805-4f70-bfcf-fe150bdfb03b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-10-28	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
b4363bda-0a5e-451d-a768-6bb8292a4749	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-11	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
46939a60-1981-4106-9852-5b740e894482	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-10-07	0	44	86be41cf-ef60-4388-91a8-31cc07c395ed	f
6c946424-f780-4e45-873b-b9ee2830dab1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-10-17	0	44	86be41cf-ef60-4388-91a8-31cc07c395ed	f
aff2e62c-857f-4076-a34b-6c74faa44160	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-10-28	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
bb843958-df03-479b-b28c-73274d27b4cb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6035ae81-d06d-4dab-a7f0-c067361e6713	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-10-11	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
ad0c70c8-d7d4-4860-a0f7-bf80219302dd	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-10-17	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
9f187ed5-5dc0-41b7-a47c-cbc5675af431	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-12-30	14	6	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
9f74da5f-81dd-4ff1-a993-25f70b60b004	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-10-30	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
9c36ed8e-386d-4948-b41f-df6d29de763e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-10-30	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
c43b78f1-f425-430c-aa62-12b0d711baf5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-16	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
c1e4d5d0-985d-41c1-b975-ebcab66cc5bd	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-11-04	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
e9e766e8-a3a9-4db0-89bd-af7589eea210	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-11-04	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
bf32b2b1-790f-49be-81d7-17f6be023d79	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-11-11	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
7415b0bd-4043-4877-a29b-1e327d706b77	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-11-13	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
b6c0f066-3b45-4600-a75d-92d365cd6a5e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-03-04	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
4dd68556-9231-497a-a3e1-614f8b76f0fd	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-01-31	0	24	2e24d271-85b4-4b01-b70c-b8dc86d27370	f
4546014b-ecd8-48a8-bb08-0ea3cdc0704f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-11-13	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
995dd50a-f94d-4132-9a73-8b4cd9ee4697	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-03-04	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
4c0f3192-9794-48de-9cfd-e9c314daa979	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-13	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
55250697-0500-4b7e-9915-46e473f473f6	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2023-11-10	0	44	86be41cf-ef60-4388-91a8-31cc07c395ed	f
0c493a0d-bca0-403d-9c64-fba7c7908d5c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-03-20	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
84e247b5-fe12-49d3-bcb9-acb6dd2f4da9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-03-25	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
6ef773fb-9843-44d5-99ac-18380762162e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-03-11	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
b9fbfbb5-79dd-4a66-9cda-f863de17f9c1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-12	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a931c4b2-6a64-4214-873b-e01b10d5f6be	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-19	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
b1436545-23b1-4c0a-ae92-657271145376	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-14	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
cfa357a7-300a-46ec-8b41-808f5eb6463b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-11	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
5648954e-6908-42ee-9d73-462588167e9a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-22	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
6084f727-7dd4-46ea-b19d-9e4ca1299a05	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-17	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
509b3b64-c00a-4744-9bf6-2f5276ca498a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-19	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
af573166-0a91-480e-b480-41948da4f23f	a71258ea-db77-492d-a4c0-5b2458db460e	2019-05-01	0	24	2e24d271-85b4-4b01-b70c-b8dc86d27370	f
47700b19-b24c-4ea1-9eeb-3e1d5c281e2d	329c7248-3a54-4fe7-b61c-f4a22d8e62ba	2019-06-21	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
0751a673-f4d9-47fd-be2d-300ef4be8c0e	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2020-03-10	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
b3a54bee-7ad2-45f5-b682-e75738e35f97	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-26	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9c839877-652b-4fa4-9e1f-ec14134262d5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-04-08	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
9cf95101-9101-4e56-be01-f90e94422292	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-04-17	0	24	befdd994-a383-472a-b6bd-ced524d45fdd	f
a5c48bae-6387-4c6a-b424-2d1213b472ff	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-04-01	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
a993eeea-384a-4590-b686-bf2a48ea7006	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-11-25	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
9e553848-b32d-4c56-aa54-8107999d2305	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-12-04	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
896349b4-712a-4caa-9bef-13ff5d383816	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-12-04	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
50e550b8-32e3-4ed1-bbf9-b6005215c63e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-11-11	0	35	c7aa264d-8549-4466-9be2-6f2b375f8ab4	f
2c5be44f-c993-49d6-85a8-d98eb108afca	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-04-03	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
a81f2009-a8d2-47e1-994c-d4721a68f307	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-04-03	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
2a40d558-c7cd-40e8-bac4-8e56add24e80	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-04-01	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
d266e3c5-7214-4297-93e5-7419bfe62595	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-31	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f2ff6a41-76f1-4c7c-b620-76d609a64d3e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-04-24	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
551bb726-5c15-4740-9854-fb2a7de0018b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-05-17	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
464c430a-fc0e-4ee8-9baf-175d7e01b990	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-04-24	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
34a1da59-db2e-4675-b0b8-6ed9fc8c5e48	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-05-17	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
29f9211b-9368-49ad-91ab-606f2152a5cd	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-04-17	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
21711f2c-edd6-40a5-aa75-fce74304aa59	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-07-29	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
649f0f4e-9870-4bf4-8dc8-70e84a69c3fb	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-06-19	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
9e93e1dd-554a-4762-b6f4-a89f0c13341d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-06-17	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
9ef4ea46-aa69-41f2-a85c-dd07b311be99	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-06-10	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
f65c3357-55d3-405c-bbc6-32129ad250c2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-05-27	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
6038eee7-9c89-4c7f-a6b7-1591afe0e794	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-12-18	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
432124b4-f974-4247-8924-1a08db5fe1c6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-05-04	0	24	cec2a73c-80fe-46a8-8ba3-e224a890957c	f
f426f64e-e01a-4683-983a-b9d08181e0ae	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2023-05-04	0	24	cec2a73c-80fe-46a8-8ba3-e224a890957c	f
7e338a0c-0b85-40b6-b592-422000866ac4	24ae20e1-50c7-4f33-a41f-08530977511a	2019-07-31	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
f1d77551-3401-46c3-8e0d-9089b10b26c1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-06-19	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
bc60c7c6-f105-457c-a5ae-ae208ab171e3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-25	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
2c9fd44d-7973-437c-aed5-8e28001ea93a	2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	2019-10-17	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
bf52c632-bcee-4adf-85dc-93a90d75ea38	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-07-22	0	44	25f9efa9-4575-4e95-a82b-2a49e6835e90	f
4b74c291-b8db-4cac-aa32-94e141db1aef	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-07-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a63bbcef-dc08-4d30-8b9d-cf7f04f58a78	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-02	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
d96465dd-0be0-454d-8325-17b0c31945ea	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-07-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
2c5fb10e-0c36-490f-ab85-997581db88de	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-07-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1b5f56d3-5ef7-413e-a583-cf393f7e0218	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-07-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6b7765d5-6480-4f22-a780-6e88da010b9a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-08	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
7093a5ce-8332-44f2-9d71-2311bd84348d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-09-11	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
e395b432-2634-425d-8c87-b2714051bb81	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-09-23	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
0258bf95-416f-49be-bfa3-a076b834fb21	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-09-23	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
34433b9e-8d37-4aa1-acc4-17899ed858aa	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-08-05	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
16cc0296-92a3-434d-8b96-142f2cd37a97	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-08-07	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
a0af45d8-8041-4880-a154-59755fbb3f00	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-08-05	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
8c4ca56f-7f8f-4d82-b385-28629fa4155c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-08-07	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
027c74aa-0e57-4843-a931-6062bb49218e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-08-12	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
fc36327b-15ca-4c20-bc81-6af04699114b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-08-12	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
85246559-49d4-4146-8b05-86484a5c9c57	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-07-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
42b09f52-f8fd-4731-b592-22f4aff6677e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-07-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
65299304-2667-42b5-860a-be1f336a1f08	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-07-22	0	44	25f9efa9-4575-4e95-a82b-2a49e6835e90	f
a9c76546-5a85-483a-9e21-d638258b72bb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-08-18	0	24	cec2a73c-80fe-46a8-8ba3-e224a890957c	f
bd311474-1c26-4769-9cb8-35027ab82267	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-08-21	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
10fbfca5-3806-4b39-a82d-d98edecca570	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-09-02	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
5ad261bc-cd27-4db2-8718-0ebd1509476a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-09-02	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
ef91a00a-3610-445d-8256-c9b2312bef45	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-16	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
671a2531-2cb3-4355-b9b4-f15fcbefd445	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-09-25	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
8560e361-4224-474d-99f9-1cd59ca4b197	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ad30ada3-a702-4a1a-ae9f-fac42711afe0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6beb0d8c-8b18-4b7e-a986-d40eb0ff656a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-20	0	24	053069da-e32e-4032-b232-db15d9cd9aac	f
b553fb5c-f3a1-4e08-9576-a2e51687e04e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-25	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c4524c89-f4d4-4e80-a216-6d361aeb1536	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-06-10	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
f7a4807f-1103-49da-aab0-f132c76b407b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-09-25	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
b039c3ea-14bf-470a-846d-ef8a26415382	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-06-17	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
3322cbc1-c432-4eca-92af-bcfc3b2583db	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-15	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
f61dea16-4084-4eae-be6d-977f64a8fc91	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-25	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4f268ca8-2208-40b0-8fb1-b6ba0a914d7b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-03-11	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
5a3c3ee5-e8ac-4212-9a7c-0ddabdda0270	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-04-08	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
43d978e1-3628-43bb-89ab-927633874152	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-03-20	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
d9677f50-6bac-48bb-8d0a-a6a9faa81b2d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-03-27	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
7f8cf0c9-78d1-4917-90e3-55efc22b642e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-03-27	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
85b9b4ef-0df9-4362-acf5-f46864ba9228	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-03-25	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
54b654cd-4943-4e97-82f4-2d397afb8f7b	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2023-08-17	0	44	86be41cf-ef60-4388-91a8-31cc07c395ed	f
7126e04f-0f51-48e0-afdd-e48dd8c422d2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-08-17	0	44	86be41cf-ef60-4388-91a8-31cc07c395ed	f
94247789-dc29-479f-965a-c599c8993ff0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-22	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
95f6d9b5-e769-4503-beb1-f7f73bb08277	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-08-18	0	24	cec2a73c-80fe-46a8-8ba3-e224a890957c	f
be8b8353-0cc2-409f-b60e-40055f432ffe	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4459a486-9698-45eb-aae8-8a8594a1bb13	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-13	0	24	62099af4-17dc-43f0-9690-2f9de337e6ba	f
03d11c9f-2d48-47a3-a502-4a76960101d8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-13	0	24	aa728470-8c19-4d99-9a08-10f2b64d9ba2	f
741785cf-40fb-433e-a959-a34b0514d5d3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-13	0	24	e3f0bc05-c672-4f54-a88d-f9bf086d1b0c	f
02c98171-5a8c-4d2d-aae4-121e64191755	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-13	0	24	62099af4-17dc-43f0-9690-2f9de337e6ba	f
b849b4f7-9efd-4052-90c4-a5a70282c313	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-13	0	24	dbfe61cc-3d34-4af5-aea4-055406c09b45	f
2b98695b-cc56-4531-8dba-d917d4eae6e1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6d184304-e5a4-4356-812e-557911c7cb1d	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-11-02	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
53fb5658-6370-4ecf-8adb-2b9d7259883f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-13	0	24	e6e196ee-22e7-4730-92f4-be3baba89e42	f
6d9aa291-9699-41bc-a1c2-03beca6e8fed	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-05	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
bfd9b8bb-cccc-4674-8e20-9ddd30d8dc21	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-13	0	24	aa728470-8c19-4d99-9a08-10f2b64d9ba2	f
ca27e38c-7e79-416a-a377-f56554775f82	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-07-04	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
f0339ad1-c35d-46ba-b6a2-909e7b60f02e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-13	0	24	e3f0bc05-c672-4f54-a88d-f9bf086d1b0c	f
d5ae57be-c212-46ed-98f7-ab559db0f253	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-12	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
b9ddcbf1-8d0e-41b2-ae6d-91f752e47b7d	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2021-02-17	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
0752a778-3a8c-40a3-b1e8-e376023238ec	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
5e0f7393-12bd-4ee0-b9e5-00ce94d8bc98	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
31e4c783-5546-4a0b-add9-400f55838274	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-11-14	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
8c658a59-e865-438c-8c0b-2e29a9a785a9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-14	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
2b2eae04-92fb-4174-b014-809c01554a05	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
123d60f5-c54b-429e-aff9-0749657a515f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
0a621b89-5457-4808-b6f4-00266e2debe3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-30	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
6a45b62b-ffba-4dfd-97a2-28ed4cbfd454	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-30	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
9ff170a0-acf5-47ec-98d4-58542d78251f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-14	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
ce55b24a-48b1-4296-8a99-ba96dfc0b04d	384f44b8-29bb-404f-898e-a4919823f91b	2019-12-30	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
f1f4fb1b-0bc9-4732-8869-bc84d2b63f65	6b49d4e3-f4b5-47dd-9fea-fb78187d84e2	2019-09-14	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
80385af9-c035-472d-8b70-d711aa51ae3d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-06	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
38ac10cb-e3cc-4b6d-a3cf-986c6e280ec1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
fc3e318e-6429-45ab-94bb-ab1469bb5c38	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2020-01-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4fb78c91-a01b-4684-82f0-715e9fddc5a8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
95c6e059-8eff-458b-a4af-9e5c61bbc399	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-12-30	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
905f6af0-c375-4573-abb3-99b851abfac7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-12-30	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
937cb273-098d-4ba9-9114-1999ffc63ca9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3d16cfd1-12f9-4018-a936-ac5bb594ebe5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-28	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
adae9c94-ca67-42e4-8435-c2031d30d902	1895b86c-fb3e-41fe-a5c8-0dc617f391aa	2019-11-04	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
64d76a50-f86c-407a-aaed-f081cc018210	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-01	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
28e1a719-67ca-4cb4-963b-4a071692b328	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a2f2495b-0a91-4f77-afd5-bc534ffc4cff	384f44b8-29bb-404f-898e-a4919823f91b	2020-01-29	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
00b5b2e7-5e8f-4ecc-9040-ed586ec5e2e7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-02	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
15dff68c-2a3a-470f-a1d0-7101bdc86f5e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-02	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
35de27cc-48a5-41c9-881e-eee8b149c64a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-01	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
b93d60c2-c100-43b4-a62d-bea6714a3131	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-15	0	24	7a8131c1-b1ca-460f-aa1d-88c645c31560	f
d8456d48-fbdd-4e7f-baa5-79a6aa925202	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
274de9cf-c9ac-4ffd-952b-549185c35329	5e1c0929-ef35-4d9f-9f4b-cd24b3a66e74	2019-08-31	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
d0876e61-e49f-4c2d-a34f-bd69df6cab44	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-09-02	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
4818fe1f-d5b4-4722-83e3-823c0b447c36	52b1e174-916c-45e3-81d4-f3596ed6ca8b	2019-09-11	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
7222b7b9-49b2-4170-9556-c8a6e2591e6e	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-10-25	0	24	dbfe61cc-3d34-4af5-aea4-055406c09b45	f
0b51d459-0312-4bbc-a3f2-4f907a32e70a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-11	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
fe627ac9-5f93-44e4-8507-3c1a67f83d8a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
309cd738-9664-4d75-ad15-7129e4039fb0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
804fd631-1760-45e2-930d-06aa7faba14d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-02	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
a036b389-2b49-4ae0-ad6f-37c2d73651fd	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-14	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
1691759f-32ba-42d3-8b75-f4cd032cd2cb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
721417bc-dd43-4259-aae6-c252a9eee628	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-06	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
e4a5d3b8-c0f0-411e-8cfd-dd927393217c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
cd86433f-70f4-437e-bd1f-0a3ded65a22b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-13	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
0c16f7c8-53fe-4be3-9bf0-071f8155193a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c1b39e5b-f04c-4723-9d9b-17ce2ddab103	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-13	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
0fc09596-7592-49fc-aec8-b5c5109d0a86	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-06	0	24	aeb73b0b-22c8-4188-9504-1236b19e11e4	f
69168394-355b-45ea-9c68-8434eb985a77	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e3fc9419-a502-41b9-afa9-5cc35ee4aa5e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-15	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
d1d3e0e6-9bd4-4cca-8c08-684586e88d4b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-07	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
d00fc954-430b-423c-8e18-589eca7809f6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-17	0	24	e551c73b-0e3b-4a8c-a38c-5d92766b114b	f
f2321788-4bf7-4a95-b095-214696595b20	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e1d0249e-0517-4d14-8922-814dc9a86a64	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-14	0	24	d3c4102e-f5e7-4eb0-b0f4-0988fc29552d	f
6b32aa40-b918-4c33-8c23-1ccbce33be68	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bed9a2ab-cee7-41b4-a457-23f7710c1a14	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-20	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
a3c03d96-4ba5-4107-9141-9e53c2749e35	ce266fd6-ebe7-4d48-a1c5-d064ffe1f292	2021-01-19	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
fb435aae-ce3a-46c2-84b5-20a6b895bd4f	2b5583eb-23fe-4b86-99d3-970a30beb166	2019-09-07	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
ffdba0a1-532c-4aed-8441-4494ff72f8d6	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-09-08	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
f5c32b78-2995-4f73-b61e-b40bf76e7b8f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-19	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
3052a87a-5606-4c78-aed8-5b94d6df0cca	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-20	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
5307f5f6-5212-4ae2-9e02-0434020a219a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-08	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
e835ede4-3803-40d5-93fa-613289ea50a1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-07	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
e89cb200-1baf-4234-a619-532fac204825	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-08	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
987c254b-65ef-4123-a3b0-61e797b8a0d2	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5dd101ab-be96-4831-a08d-bf77316a9277	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-09	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
ee4b804d-da57-4fb4-8c53-4365f8deeb05	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-09	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
61e54ba4-b71f-4531-8f16-a71fe09efc4b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
39d6b054-e214-4804-8078-7898a07dce87	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-10	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
05c2cff0-f6a3-4ab5-aa80-996c5f1bab3b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-10	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
9e406bc9-f860-4fb4-8c31-4e7089e6d200	505dfc0d-0e7f-4303-be59-74a2a8fc2d3d	2021-01-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
a4bf78a9-e945-4328-be3a-6ccfadd9f3f2	2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	2021-01-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
4faa7495-34cd-43e6-adbe-9f1ce5f3b9ec	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-09-01	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8c4130e1-905d-4233-80d5-485a6676dae4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0b69eea0-c7b0-4f92-882f-fc104953e4a3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-12	0	24	5d0f526d-be55-4034-bfc6-410e38cf6c37	f
6f42b672-3674-4295-ac20-5043d83037f9	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-07-14	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
273a469b-b490-48ab-8d10-c1296aa66a08	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
96eaf57a-523f-4f24-8f2e-083ee57d4acf	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b60670f8-1d83-4c56-8271-86d0f9311bc1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
25ddccd7-894a-4798-818a-a389ceeeea7d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
b520cab5-3c7d-42f3-ba4f-07f45dba7eb2	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
94f3b8e7-7a82-4b22-b1ef-911d6e78df7c	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-09-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
88fbedfd-98f5-44d2-a717-94b185fbaac6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-22	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
8dc0979c-4398-4d9b-b25e-e0c432781fa6	b20d2832-4740-4f13-ae27-9b6738a1083e	2019-07-15	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
057e5e72-3288-41f1-b6e8-80bac414d13b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
22461ae7-d360-4af9-a039-0b6f7594ad46	13cb8c7c-f522-4c87-a6a3-1cd2515acaf4	2019-12-11	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
1225ac69-c32e-4911-b4b9-9cc2925db606	505dfc0d-0e7f-4303-be59-74a2a8fc2d3d	2019-12-11	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
673ac0e1-9d09-4927-855b-87756929ce08	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-15	0	24	82a682f9-a8d2-4253-9928-a47fe81ea040	f
bb0c8867-db7c-4f34-9fc4-74f9d5e5e3e0	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-12-10	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
530de1f8-6ae3-41ac-adc6-2319ae8c8218	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-16	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8ffaa406-cb19-477b-8c1b-27e453269ac1	81aef3ed-f05d-48f2-b7cf-aaebabca955c	2019-07-16	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
ce8cf4a1-ceed-43a3-9287-0d2b64ccbb92	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-29	0	24	50ff5482-287e-40d6-bf27-d383dc105dc1	f
06d93829-c0c6-4a18-905c-8a88827d3b25	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-04	0	24	288b82e6-7e91-46c0-b7d9-7cf69f7b1324	f
4ecf21ed-391b-4121-ad5b-620db854d3fb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-04	0	24	288b82e6-7e91-46c0-b7d9-7cf69f7b1324	f
325f6fe4-3d87-47ad-8385-6ca44dab7a96	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-06	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
80b8c50d-7281-4ecd-b8d7-0269c91d9176	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-23	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
23ff8e7f-66e6-403e-9c6c-0ae233370df2	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5fc67023-6c4c-435d-8f8b-d362a9bd84d3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
255a2b94-83b8-4b6c-8332-21617934403a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
840a047e-c436-42a0-8db5-124ece7a4e6d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
3422fb59-cf6a-4cf4-8760-ccb7d43dff3c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
90539566-05b1-420e-90b2-68a3cdcf2106	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-06	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3c15a99c-3ea6-41c3-9705-988c0b90874b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-24	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
b36f92e5-1a33-4fa6-bec8-ce13bc7529dd	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-24	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
cd45aed5-079b-4b4e-bcf5-d08afaee9359	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
73b3c9dd-132b-463f-a9ad-0ce8ba43bffc	11fd42bb-8087-4075-afc7-419c5bf6fc01	2019-11-24	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
97b6b459-512d-4eab-96c0-01541929b524	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-13	0	24	9a65c9ce-f3e0-4865-a4af-562a07a6349e	f
48a26465-4ca0-40a7-977e-e2382b12b34a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5d227aa9-4295-4d9f-89bc-13bc86c1dcd5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-16	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
456c0df7-2335-4145-856b-5683977ef3d3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bcd20bfe-ec69-4651-8d6a-65d2f1d7edf4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
03347b52-d5d6-4415-972d-958973c3f6a8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-01	0	24	7a8131c1-b1ca-460f-aa1d-88c645c31560	f
94996f68-5f0e-41ab-bcac-796df97b8dfe	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4a962c6e-b673-497c-a13c-b7edf2287362	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
859896c0-4859-4a1f-8f61-f6a51448c19c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
dbbce837-912c-4afb-b0bf-fe52e56c98e5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
08058d93-f43d-4baf-8a6e-c62eae720f4b	feba6c1f-a359-4162-8471-4df5994d4d4b	2019-09-12	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8acf21ed-64e2-4f78-934c-b887e311a7cc	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-14	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
52171d01-1ca9-42cd-8470-dd9ae11251d4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-14	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
b5c252b8-5acf-4b07-b7bb-98751e8b48ca	505dfc0d-0e7f-4303-be59-74a2a8fc2d3d	2019-09-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
313c43f9-6cd3-47b6-832e-e3861cecb1bc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-14	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
0516798e-51a5-40b2-9434-5b2396da521a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-14	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
69275e61-23a1-495e-96df-2dc69114c650	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-29	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
7e2e6771-ad5d-4b98-93b0-cfd99b5ed890	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-14	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
67f0c5b2-85d1-45be-9c9c-b211b96df151	5e1c0929-ef35-4d9f-9f4b-cd24b3a66e74	2019-12-30	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8fdcc7cc-178a-4a71-9fdd-8928a979a6bb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
eb09cc84-dd45-4b83-a925-35d2892cc681	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
401aca7f-ca9c-438c-a225-e83df247a6d4	5e1c0929-ef35-4d9f-9f4b-cd24b3a66e74	2019-12-30	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c8f47f97-55a0-4836-9f79-b8d1e8433ad1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-16	0	24	d3c4102e-f5e7-4eb0-b0f4-0988fc29552d	f
4d2653f2-0467-4346-b3f1-ce96bda547b4	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-07-16	0	24	d3c4102e-f5e7-4eb0-b0f4-0988fc29552d	f
199c1dbe-cb20-44c0-adcf-8e4cb010e87d	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2019-10-29	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c6c522f1-caf4-41f0-9705-a259cb34ad29	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2021-01-15	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
3be21e89-7e95-4724-acdd-d3d2bde5a7d0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-04	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
de18cddf-17cc-4f5a-bfc3-c4ce272b8052	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e30b4124-d344-49d0-bf49-0ed370fa4368	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-30	0	24	24a381cc-a7a5-40f5-8f3d-5ddd19a79b5a	f
0171646f-0205-431a-8fad-6c9fcf5e1da8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-15	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
09595f33-eeb1-43a5-9816-910526e72a00	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-30	0	24	24a381cc-a7a5-40f5-8f3d-5ddd19a79b5a	f
444efc38-7d05-472d-9fd8-795a1d7c7c02	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c29b3d40-15e5-422b-a9c3-d474cad2761e	ce266fd6-ebe7-4d48-a1c5-d064ffe1f292	2019-12-31	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
89a84ab3-81ea-4b9b-ac46-f2c166c67e73	505dfc0d-0e7f-4303-be59-74a2a8fc2d3d	2020-01-03	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
75ac15dd-0b11-433c-821c-f09382db870e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-09	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
89eae0de-0273-4472-ae0c-25fad74f547f	a71258ea-db77-492d-a4c0-5b2458db460e	2020-01-03	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
ad9e249f-cd94-49a3-a6a7-b69fdf04290e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c8f71519-35cb-47c4-9ed7-afef365b0753	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2020-01-04	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
0312020c-726b-4ce1-a915-b56756fdf3d9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-16	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
cde75076-4b8c-4e02-91ae-c771224b10ed	0ea3ce20-7bab-4b58-89d1-b18552b58ae4	2021-01-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
feb5eca5-6b53-4396-b259-8d95b3ade0cc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-31	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
906b4a57-b9ae-4f17-8228-01004dc1e800	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-24	0	24	c347aff0-7a4d-45ac-b051-63222b036c8f	f
78c9ce5e-5b61-44e2-8f0e-2eb3ea32e2c4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bad1cde1-6388-4bc3-b91f-38d576ff94ee	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
523eb060-032f-447e-92c2-68effcbeda64	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
33bfaf3b-4613-473f-86e8-71a7887dcbe3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-02	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
cf919aac-9ff7-4aba-b611-7346eef597e4	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-09-03	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f5fdf871-08b7-484b-ae1d-c5423525394b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4c498f57-0897-4d01-85fd-6d4cbe698e1e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-31	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a6250f35-ba9f-45ba-b9b1-250a912299e6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-05	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
33f195ed-a136-411c-bd38-8a9b4563f450	0ea3ce20-7bab-4b58-89d1-b18552b58ae4	2019-09-13	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8633c2c9-38f3-4554-be51-26060e56e173	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-05	0	24	82a682f9-a8d2-4253-9928-a47fe81ea040	f
443ad19c-5769-4ffb-a7be-7ce5f9629c8c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
fb39b113-4e99-4058-917b-4afd4da629c5	2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	2019-07-12	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3f9537cc-0564-415c-b0b6-815932416312	2b5583eb-23fe-4b86-99d3-970a30beb166	2019-07-12	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
ca6cf620-0f75-41e6-8d4b-8c0bdcf337f7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6442ec9f-134b-4c10-b0af-b8d4953c23ab	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ed9ad72f-31f3-410b-a2a5-dfdf95d2acd0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-14	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
54079663-97e3-458a-8037-47fad46d19c7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
037a5c56-ce81-4a0c-a263-fb1d95e5d989	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-14	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
a587d320-7bd1-471f-a859-6b9ab2064506	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9df11d52-27e5-407f-8b55-4443b6136dec	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
79194d9c-c01c-4fcc-8d9d-be1e47b07c81	07c2fb26-38a9-45a4-a923-338f1b4eef35	2019-07-12	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
e8fbd953-f0fc-4827-8c2d-006844300974	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-14	0	24	7be01b65-548a-4cf7-86c2-3b7c5a14239d	f
a407f647-6a01-4560-b7ff-5aa7cbf2dd48	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-25	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a3d112b7-2190-49de-b8eb-a46bd30e4a64	384f44b8-29bb-404f-898e-a4919823f91b	2020-01-02	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
b50370d4-97ef-4c87-8ddb-f261b1863af5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-17	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
22d8f8d1-a02c-4518-89bd-da0ec9eafa75	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-02	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3be306db-60cd-4cb0-817e-d957d608de54	63e8f037-9766-46d8-85c9-b2838393c953	2021-01-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b2633724-d2d5-477f-b19b-a6dd11ca5070	ed53e116-0d54-4c98-a66d-3e3b0b4c864d	2020-01-08	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
4091bad4-7d84-43e1-94d5-2a38031fd7b3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
eadc09dc-e5f8-4147-b1c3-77eeab089d29	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2020-01-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1f0daf31-ce64-429f-9472-823fe4e57f22	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1e563651-7cc6-49a6-a914-9a36402613b3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-23	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
60e31f21-1321-4621-b7e3-0e2ba4f4ed33	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-23	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
ad80fc50-0f6b-40f7-9123-96cb0076d6ef	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-05	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
be5e3000-888f-46d8-a480-6d9b1d51f8b9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-22	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
90d3b736-3f80-4e68-afc7-c0a8c4dd7326	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-27	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
6be7cf84-c06f-4634-837d-b7d9307ce861	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c79a6200-16b9-404c-8f28-1c8cc055c920	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-20	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
9f881835-18b1-4b71-b6b3-7425120b86f8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-20	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
9bc7284d-52c2-44fd-9321-95cb6224b00f	4d03281a-2e2c-4280-bd97-3136122fe750	2021-02-19	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
2b2264b2-c8dd-4947-9fe2-443ec96fad8a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-01-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
76ea8ae7-052c-4bd0-bd54-7ddbca65c7e2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-18	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
40c55826-fb94-4339-97fb-e9ad0462c7cb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-01	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
b5129a17-aa9f-43ec-a582-381df49c1112	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-01	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
b99e3b97-643c-44bb-b59a-9b03c4e606f6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
096259f1-dcc4-4ae7-9b9e-7e83508c4188	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-06	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
7cdbf7fa-28aa-4549-b333-a444220dffaa	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
5b2ebd8d-a797-42c5-88de-c7e57c7f4c4e	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-07-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
183d8f33-08ff-4786-8af5-3a17c2308e5c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-23	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
db361132-e76a-4ea3-8d91-b760b73f8e20	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
53f9cc65-b54e-4c09-898a-8fc80cfc934f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-17	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8957ca20-919d-4182-bb58-39f555332abc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-24	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
304b990f-839f-440a-bc1e-cb146f2f3471	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-02	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
87bba65a-9fe5-4316-9356-2881fc4b80dd	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-05	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
6252cca0-cedb-4a04-a8e1-9a83cd58d18c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6f733b94-a2e6-443a-9539-157db924cc9b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-02	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
750317b9-41f2-42d6-85cd-52a6e93864cc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-15	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4308e21b-7d71-4df6-83ae-4074835fcab8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d1e14041-70cd-49f5-a6a4-64323732b337	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-15	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
18cc0e4c-02d7-49f3-bb84-3a73e6a35364	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
47b9fe37-880f-4a70-baf3-ed1cb8a53baf	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-25	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
fccb2a0a-b504-4b3a-8acd-8ce5bd805dfa	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-25	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
ddd3c7aa-3f30-47dc-808c-ed0173f7facb	ed53e116-0d54-4c98-a66d-3e3b0b4c864d	2020-02-15	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
98c777f4-48bf-4ef2-8990-12bb4ae54c56	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2019-11-26	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
f7fe231e-bd1e-44d4-848f-28a86b8b21f3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-26	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
df29ec71-3dd4-4a5e-8fee-33e3b38473a0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6ba6bd8d-08b5-4310-bfe3-925638156fc9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
37bc033c-aece-41ba-8ba5-9e418090034d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3f2b187e-ac4b-420d-9996-10378de3e7da	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-15	0	24	7a8131c1-b1ca-460f-aa1d-88c645c31560	f
deb890b7-b6ef-455f-8110-1e580ee59b36	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6c4b6478-f1a8-4fa9-b409-5a1bc8483b4e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-20	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
b3569a11-1713-4142-8c57-cc73af6fd38e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-08	0	24	d7c22c08-80ed-4efd-a07e-e45f51d85822	f
41a192f8-51a7-4dea-ac63-0ea941711068	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-08	0	24	dd6b39e1-8671-47c8-8e7d-12aec9c141ff	f
0bc7f12a-53d0-4685-b6cd-b7aab5f02e1e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-08	0	24	d7c22c08-80ed-4efd-a07e-e45f51d85822	f
8a33c1d6-ec06-482f-af03-2a8f978c72b5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-11	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
4a82e218-d741-4fa5-b44d-08c2778bfa50	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d2776b34-110d-4fd7-a6a0-2f92bc5c22e3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-17	0	24	c1cd13a3-af42-4d89-91f0-d642a68764fb	f
05e3295a-c589-40ae-8485-dbec63867092	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-17	0	24	c1cd13a3-af42-4d89-91f0-d642a68764fb	f
020ad064-58f7-4294-8a93-6b839d43af6c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-29	0	24	7bec0c04-ee21-4cb9-be2d-b447ea5dd160	f
dd051c4f-e937-4f07-9a5a-f2ada29ee212	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-04	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
b43bb1ac-2264-4fc4-9400-22e08bcb2b47	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
154f412f-14e8-42d5-967e-e8963d974b42	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
10d76381-f742-4479-86ac-9f395c44913a	ca2f149f-87a1-4bfe-8309-9c9b845a692c	2019-02-05	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
91e39c1a-6db2-43de-9000-a638f32f9409	ed53e116-0d54-4c98-a66d-3e3b0b4c864d	2019-06-05	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a5509e83-2f14-4cf9-8669-1466a8c9a696	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-04	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
f2271ccf-e155-41c8-aac9-a66356cf4fb4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
112cbe1b-e755-44ac-86fd-59334c153917	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
fc2f6cca-44ed-4b28-9040-59cd3cc3773b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-27	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
12c5f662-4113-4b7f-991e-b50dab139b93	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
136437da-52ff-479f-adad-f6a474ac62c7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f2c79aed-1ffd-4b93-8bfb-98735bd3dc7d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-09	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
5349fa59-731d-4ccc-a2cf-373e25a2072a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9fac8e3c-e142-498d-bc10-b10f22a64d70	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-16	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
ae3f8889-45d7-4ba6-b19a-598095fb7253	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
934097c8-cb60-43e7-aa93-32740d54283f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
6076808d-0e70-4292-ad03-796bdfdf88ca	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-18	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
62c373ad-fd5b-449a-a4cc-93a16e2cdc12	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-04	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f4aac2ad-27c2-4397-b608-cf741ab74420	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-01-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8b98c064-a08f-4e9a-998e-c32a23094471	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-16	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
aa04e02c-a07b-42f9-9401-315a73011d47	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3b34a6f4-c752-4710-8dd2-a72e680857fa	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ee65c77b-3f47-4653-be29-9dfd2690770c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-05	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
cf2a73b4-7e6e-4fa0-bef1-a78fbb0dc03e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0062f8b6-3fc5-4128-a076-ebe013d4df9a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-16	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
2ce4723b-c6ee-4a99-bc37-cf3321e4c819	a71258ea-db77-492d-a4c0-5b2458db460e	2020-02-17	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3534ec30-5b2e-457b-bf37-0f008b78b0df	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
553acb46-2453-404c-98c9-32199a22dfb1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-01	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
d574a0c3-c2ce-4efd-b5d4-7c00ede7d644	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
69a141b1-e6c2-440a-b79f-aa82059637d1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-16	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
6571c06c-fc2b-4334-a185-c8f0d2c1dd07	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e9c54855-74b1-4574-a4ee-2c79b5ed061a	4d03281a-2e2c-4280-bd97-3136122fe750	2019-11-18	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
1fce9339-008e-497e-8e62-dfca27b9e3f7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-31	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
b79ebf16-2ae0-44fe-92a9-f416e9248c83	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
578cae91-ddce-4dd4-a4eb-64567c892131	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0aaff60d-bd62-44aa-a6f2-c1d5e06b1130	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a792d5d4-144a-4ced-a872-ae40b0c28fbc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4de5dd52-698c-47ad-aa11-6fadb73ee18f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-10	0	24	9ee86f1b-45ca-464a-8719-81f00ac546d4	f
8a41f7ec-8e32-463f-adaa-da2df4760998	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
f603dd1f-5416-49d6-b5a2-0b5b72304dea	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
92f0e404-9e09-4765-806e-542d34ebce00	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-11	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
53f387b7-8bad-4fcd-a8ca-7ac55bc2d959	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-15	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
6691bdcf-206a-47a9-9536-a823fe6397db	81aef3ed-f05d-48f2-b7cf-aaebabca955c	2019-04-25	0	24	2e24d271-85b4-4b01-b70c-b8dc86d27370	f
1ee70961-8009-41b9-b5b5-025ea59a4094	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
850896e2-4482-4727-865b-6c1db0992c10	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-23	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
0f33ec01-1846-4023-9c42-8facb8eb2ea6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-24	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
9737738b-b364-45f9-995b-65886661fb8e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-05	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
ee1578d9-aff8-4192-b24f-899567f4d998	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-25	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
38a472f2-f8bb-437f-b0b6-5977e7338a57	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
359bf4be-44bc-4452-a63e-7ebb3f774b45	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
32d7a91b-7b2d-462b-a2c2-6d12dc5630b7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-14	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
c8b3f30a-eb7d-495e-bbfd-8bdbb8fbbe9f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-14	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
9f20ad33-f02a-4075-95dc-8bff0c0a8fed	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8a8c167e-5e04-4c5d-8da6-e748c7c676a6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-01	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4b23ac2a-4ec7-44b2-b19c-52accf3da604	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
59080f6d-62da-416e-a14a-4c7fa306a579	91358bdb-d6d4-42c7-90b0-ec820721d350	2020-02-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
32206ca6-1f16-4530-b776-dfe9be858516	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
db55c3ff-0b1d-4f06-a6fc-17de0cc7fb60	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-11	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
3126529f-7c09-4cca-8f74-743341fa1210	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-11	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
dbffe418-9e7a-4ebf-822a-1358207919a6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
fb132e37-6059-4586-b566-97a570e5ebb6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-16	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
82913762-09ec-4cfa-9d99-2560d4655acd	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-14	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
269613d5-e615-4782-8e5a-5f722657d534	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-01	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
d4ab59b2-c9c6-4263-a34b-57a9f0dfb4cd	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-14	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
230997b4-f163-424c-9e50-ea0cecfd828d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-01	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
bcf57ed5-f896-4833-b38b-836c2e363522	ce266fd6-ebe7-4d48-a1c5-d064ffe1f292	2019-05-12	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
b92acf91-f377-4e7e-97a6-c0c3cc26b7bd	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-12	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
a4e8e7dd-675f-4eee-87ab-d39c8658a8cc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-13	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
37bde6eb-4a6f-4c9a-85f5-907c9b44828b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-28	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
a26a7352-ebd3-4c99-9b38-bac54d4a6cd1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-12	0	24	7bec0c04-ee21-4cb9-be2d-b447ea5dd160	f
59a68bd6-ccd4-4978-8da0-99c76d8d002f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-12	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
51373eeb-ab42-4899-85ed-48fdf3280ef8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-28	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
f21ee095-8325-4ddf-99dc-578c2edd9eb9	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-05-12	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
b17c72b2-480d-41e2-9fa1-e1abd02a62f3	5ec011c2-3145-4297-9c01-8fdb1f2a6906	2019-05-12	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
8a86c6ad-0573-486e-a6d0-9c23e90ae3c6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-08	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8a7d2a94-5faa-4ee9-a673-9c01df11125c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f3e33062-e1a8-400f-937e-8e2d97e2b86f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-08	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
079d6016-7cb0-449a-b101-4bf2173d8017	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-15	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
352f76a3-adc6-4556-b2ec-1cb5a02c4126	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-02	0	24	7a8131c1-b1ca-460f-aa1d-88c645c31560	f
2196f1c2-0d6a-4c0a-bd68-4236f289ad61	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-11-18	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
13fe29ca-0b7e-4038-8374-de7b75ac4182	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-17	0	24	e551c73b-0e3b-4a8c-a38c-5d92766b114b	f
1710c1bc-c55d-40d4-b662-fe1a5fab2a2f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-18	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
e213db66-b133-4a0d-9c6e-d18539305671	a71258ea-db77-492d-a4c0-5b2458db460e	2020-02-02	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
ce18ee9b-6bff-4044-936d-fc10a7e13974	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-11-20	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
77315947-fb4b-4df2-a093-842603fe2c4b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bae16b36-c475-4c0d-9b24-f76946a7a6ef	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-15	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
8517322d-7900-46de-b2cc-2d50d5fc6312	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-12-15	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
db1844dc-32b4-4ace-b955-7f642f6f6079	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2020-02-03	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3f935031-f778-4eb6-b80f-e7eb270b4be1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c6353ab9-031f-414d-9e56-8a3cc235264a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1dc9cd6a-d149-4093-8c76-116a320e6b96	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5dfae5ea-aa72-42f0-b694-abf8a34c3907	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3fd8891c-24d4-43cc-8ea2-1b8d7e11b660	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-11	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
5124d81e-c6aa-4570-9465-d61c64ecf1cb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-14	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
62d06078-0364-4d80-9931-c4d2193c4d9a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-15	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
41718dd7-4f15-41a9-8eb7-be3864f5a2ae	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1743778f-bed7-468b-b767-ef3231011047	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a44835bf-476d-4fbf-8663-23c7cbf6e3ab	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-05-15	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
96996132-a371-48fe-8018-7a29684a6c14	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f107f991-58ca-44d7-93ec-a2c58b3a6707	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
aa399139-21f3-439b-b0bb-be7a137adf35	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-19	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a408f799-5e27-49c9-83d3-176613238f71	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-13	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
45fc3432-7010-48c3-bdfc-2b3544c14df9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-07	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
4ffcc39a-6626-4ede-baf8-531bca1243e0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
18852d61-df05-444f-88ae-b607516dba84	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-01	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
7426be65-31c1-48f5-b9cc-cfe4448fd307	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-15	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
6e181225-6291-4dfb-85a6-2ff6b38925e6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bc85552e-a1f7-4be1-95f3-8a626f3dbfbe	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-06	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
b1c41270-d82a-4dac-b030-6eb976b222c4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-19	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
bae89e7f-bac7-4d3f-9df8-c124e0138a48	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-19	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
b73ed642-fdcd-46e4-960e-86b26aec06ca	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-16	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
7855d771-f72d-4c6e-9ab1-a7f9608a9dfe	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-14	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
23d0db7b-408a-43f9-ba59-29a48edf42de	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-03	0	24	7a8131c1-b1ca-460f-aa1d-88c645c31560	f
b6e96a40-a079-45ec-b9c2-d195c828f632	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-03	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
d25a759a-4eb4-417c-a5b6-e7cd39d4db73	a71258ea-db77-492d-a4c0-5b2458db460e	2019-12-17	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
a498a295-27b2-4783-b937-7c5adc3ad26e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-16	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
41660c56-a70f-474b-a40c-bf30f517445a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-16	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
aac72fbb-7a78-44f9-b6ae-93016443dbfa	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1ff74e53-d9c5-407c-91ff-4cc1104a3a1c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-19	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
13ef908f-efd2-4c77-bc4c-717c0139adb2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-14	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
32cb39e4-97a9-459e-85f2-19fd31e539b0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d7e9d037-fd13-4156-8342-c06e3bc17474	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
1f34592d-1f04-4012-a767-f6a447e846c2	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-19	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
b077b697-dd13-4c34-a959-87db6ca86028	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-13	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
73c1e839-ca8c-46cf-bc74-5c3bd7020b15	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-16	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
bd0ec334-d9fa-42fe-bd1a-c1ea2ac9f088	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ca69f163-286a-447f-9d1c-cfedb0f247c4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8ecd1c0d-a9dc-4107-a90e-afce29a0e570	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-16	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
3a916657-ae14-4e84-8260-d0b8e1b91803	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f911db92-89c5-4883-97c1-4a5d5eb77ba7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-18	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
e0c82d68-7cae-4472-a1fb-f3f060b47966	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
14cba12c-8819-4e8b-ac06-b3aca80c2da0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-23	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
6bdbe63f-7614-4a87-9fa3-3179f6359de4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8d550637-f9f6-467f-8529-be546dd8738e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5707f67f-310f-46e5-9a25-aea59667bd93	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-11-19	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
8ac802cd-9b87-4ad9-ac08-c4559e12659e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-16	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
13fd2f95-557b-409e-a572-46c3d581ccdc	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-19	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
891b41fb-76e5-46c4-946b-ad00f16744a4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8698ae96-4b46-4cd2-b509-3074d5508336	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-12	0	24	7bec0c04-ee21-4cb9-be2d-b447ea5dd160	f
53e24afc-4bb0-4242-9806-a1b7f9152870	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
31f6fd0c-408a-4e61-bd67-a0a0c6e2ac5b	52090ce7-d56d-48ff-ae9c-f3c47af0b829	2019-11-19	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
148e37cd-5272-4ce0-a98f-22e9409cb8fb	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-13	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
4eea942c-f12b-4bdf-a428-8866b11e4eaa	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-29	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
a8bf4b35-7d64-4289-9f4c-d718bbb00003	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-07	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c51e18bc-3cfe-4e7f-8aff-dfd7ebe70b96	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7d61533a-d878-43e4-b077-cf24bc6aae2b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-15	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
7f27a871-cf9c-4753-a761-0030bbb14ca5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-06	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
c7848e5f-3b44-431a-8a30-1d900fa7b337	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-09	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
03021eb4-1118-4ed9-b9c5-f1bda3a10ce4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
490686e0-c539-4fbb-971d-0e9bd9658f54	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-29	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
3b8bd383-4b6c-40aa-91b0-5c8eafcf77b6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-25	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
ce9ab4d2-f832-469a-ba63-d0d3b152303e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-26	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
298bc2be-aa33-4017-8928-23799dd31c55	1895b86c-fb3e-41fe-a5c8-0dc617f391aa	2019-07-01	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
2f22730f-2020-4e82-869d-1038f86be938	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-29	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
bc78b026-f71d-4e60-82d2-079e05ff9164	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b3315fb1-b357-4a6e-8ae3-00d9101a4dcf	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
cc077011-dd99-46e5-a4b1-bbc84f7da5e7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-29	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
719176e3-c200-4d4d-abd7-d36ff19c4c44	5e1c0929-ef35-4d9f-9f4b-cd24b3a66e74	2019-10-31	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8f57561e-70e1-4f2d-83c4-5de7bbd83cdb	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-26	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
af5a147d-ff80-477e-8e24-f88ebcee54cb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c9cc181c-8d36-42ca-8a62-bb35daa323c7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-17	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9e2a1f91-2e6c-4357-8961-5cbab29899be	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-17	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
1760b52c-ba9d-4c90-83a9-d0e3cf2490c2	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-27	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
ef26ad84-f2e6-4422-b127-6aec1019fbdd	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-05	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
b2d9c0c0-33a4-4a6c-a1d2-d5dec02ca9ad	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-13	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
828dcb4b-1f67-47be-bfa1-865cfded8a5b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-27	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e8dfa9cb-cc03-4632-bf9c-5fb1e3c4c16e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-02	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
409d320a-1a03-4c7f-8cd9-291f699c3fca	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
ad62d63a-b87c-40b7-9067-9db59c1d3eeb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a540adf0-0889-45c8-a792-24605694ef52	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ef41a67d-ec18-4cc8-821c-c94b114e033a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6a45e44f-f039-4da4-9689-37e98f99b198	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-12-17	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
dc56eb78-5f20-49d5-a77a-9c10ff5ba385	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-05	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
87716d21-7223-474d-8471-6dd699a15665	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a9dc44c2-e3aa-404c-8e8b-e5ef3785c011	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a701b87b-269c-4df1-ae79-bf96bad0be2b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-06	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
eb9a2357-e3fb-4b99-bf0e-43b61c7b62c0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
cc9270ef-d598-4878-ab4b-1e25b100dc1b	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-01-07	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
43a92337-e436-40b9-82cb-bd15f691f57d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c7747462-30df-4906-a072-632c751496f6	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-09-18	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
7fcdd702-a5de-4810-b091-85690a5c4a45	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-18	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
faf3210a-6494-4c30-852b-4f72f1bc0933	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-22	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
887bd8ba-9d37-4658-bcaa-ab05f2cd06af	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-08	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
53925320-e1b6-4fb9-973e-0fd856facaaa	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-22	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
9037485b-5d49-4d81-a3b3-ae940f215b54	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9971f77d-85c4-4ee8-b7ef-a43952355c4a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
39f9af2e-9859-43b2-8356-5b316eb5bdee	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
ab904431-85f9-4a35-b96c-a55a60239d43	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-11	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
23cea593-e5b6-45c4-897f-f489e35c7b36	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-22	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4c0a0a00-cc7e-40dd-8ca7-979eca7304db	4d03281a-2e2c-4280-bd97-3136122fe750	2019-12-17	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
a8456035-e555-4121-aaeb-ebeea0534a10	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-22	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9e47017c-b7ce-49c2-8293-1246ae48c388	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
69f5a9ca-8424-4fc6-b92d-4f712877e73f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-22	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8c836b20-b54c-44b7-bc4d-a9947ffb37e8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7940d0ae-1ae3-4530-a039-024a310385ea	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3c20a902-2609-41a5-b1a5-968cdd5ee663	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-11	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
1274000b-ffdb-42b7-92ce-9cc6df849708	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-10	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
f1d1e793-689b-4aad-b44d-5314c6c2af37	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-10	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
0c531e2e-6563-459c-8375-17c75f655216	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
4a0b226d-32ac-445b-a804-a4871f69f073	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-20	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
bc963c05-8e69-451c-aa78-88b8ce6c7281	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
cbb02a88-3e34-4dc1-b0aa-9bfe3fe0c47e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1dfa7bc5-1dec-4132-96d9-79e3034c5a64	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-10	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
a5297f39-f5c3-4e82-b43a-838f458c161e	796aa924-1c13-4286-9268-d19ab3f82892	2019-07-21	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
d5a85cf9-697c-4fc0-8ad5-19bcddfc684d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-10	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a5f34afb-0c43-42f2-b969-5570710beca1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b60235c5-33be-4ba5-be7e-6c7d685cf98d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-14	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
c42c05c2-7b85-4b78-bd95-1d998c0e0983	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
cc4b1fb7-2dbf-4039-aad6-e72eddc8e9a7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e93f58af-a17e-4c31-8f90-ca47065baab3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-11	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
dea3d920-f052-4493-91dd-6dd070c0f464	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-25	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
565a4efb-b4dd-4d28-b9d8-a5fe802f35de	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-10	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
23ce07dc-74e4-45eb-be2d-23e4154de2e0	ed53e116-0d54-4c98-a66d-3e3b0b4c864d	2019-11-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
97bf5853-28c6-4c3b-88bc-ccb0b4f46453	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-31	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
a21c146a-bb47-40aa-a65a-454450801f16	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-21	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a02051df-414c-454e-9aad-cac50fca57ac	384f44b8-29bb-404f-898e-a4919823f91b	2019-05-17	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
09645e39-7e2b-4e08-bb9c-8d37a861b5b1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a57ee35d-913f-4bf2-8c69-1d0522bfa717	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-31	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
818da8ff-396e-4222-b96a-20716b7492d7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8a47e07f-f7c3-4dbe-8ebc-8a45132b28e1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-09	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
91357975-dffd-45b2-a1e2-ec91141e2316	9afffda6-46a4-4262-9436-39f3d7d3abb0	2019-07-01	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
7265d896-dfec-46db-a984-438647d1c19d	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-05-01	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
ad543b6c-4d38-4d6a-b809-3ee45e4ba8e3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7bb7a86e-acde-4759-a434-0b802ddc3850	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-01	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
f6c615bb-24bc-421c-8c7a-2d5ebfba5834	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3701a8a7-6479-4cab-a885-71b8ee3da52a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
60cbf0ed-f237-40ad-a352-25774c08205f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-18	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
f8d9890d-9826-4374-a408-ceb4ce43fbe8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-31	0	24	82a682f9-a8d2-4253-9928-a47fe81ea040	f
9b29d78c-efef-4734-aa69-b3e15b1ab87c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1089833e-f7a9-42ef-a23c-b6cd8b3a6a16	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-07	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
5cd99116-be35-4bf2-8b2b-ddc6c1e2a02f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-11	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
953c3f40-61d1-485b-a1c3-c5f7087e7c9a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-31	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bbf8a5a2-ae64-4050-9c63-ec01b355741b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-11	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
ce609186-9363-4dbb-8b19-6914740ce2d2	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-01-07	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
904c03de-65ae-4528-a6b6-76805211108b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9343cba9-25ab-4b2e-999a-78b7d86947f6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-08	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
11c474a3-332f-4d67-ad17-54a01c0e5821	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-08	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
c18c8302-edfd-4011-8bca-8ebc03cb7176	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-24	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
4340785a-e9bf-4b86-aff9-602548da87be	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f3d039a2-3d86-4cce-a025-d9b19dfc4882	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-22	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
14940029-4bf9-4aa5-9477-cc77d0e9ffa7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-13	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
3b867905-e4ee-46b7-b3c7-740ffd6278ae	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-11	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
16b9baaf-ad9a-4654-a8f7-a33550e900ba	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-31	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5a12653b-eacb-4333-873d-8b1abfaa9013	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-13	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
448caffa-71c3-45c2-9cad-b5a7d9c885d8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a5f3fda4-748a-4f29-8155-6623b6889ad1	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-01-17	0	24	eeac58d7-56d8-47f0-8bfa-bc3ce847bb46	f
b4418cf7-5318-476c-a958-ead694fd79a4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-30	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4a7aacde-5c30-4be7-8d99-cca8df148533	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b809e893-33f2-407e-8a37-134a4ed9ac29	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-16	0	24	5d0f526d-be55-4034-bfc6-410e38cf6c37	f
9cb9908a-e42c-4d2d-87f7-493d75525300	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ad7e983f-fa4e-40da-95bd-41d96da5dbb9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-04	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
2b092609-52a4-498a-9d34-91298c5d907a	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2020-02-04	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
866cdfd4-45be-4373-a3b1-0be709bf086e	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-05-29	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
e6c4dd32-bc6f-46f8-a040-b38ecf55e2b4	37cedc13-b71c-437c-8a8d-fd36de695d4e	2019-05-20	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
61176f08-2839-4531-8644-f421916dfe27	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-05-02	0	24	5a4c9fe0-6fef-410a-b296-ca64825cb8e3	f
2a2a2124-6e43-4f9f-b8ed-6464fdd929c2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
45648e02-1077-454a-a284-64a9d76f432a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
98bbf5d0-9c78-4eca-8387-8a6f074b6d12	37cedc13-b71c-437c-8a8d-fd36de695d4e	2019-05-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7b60c3e5-2db4-4f1c-b01a-660424de4d37	07c2fb26-38a9-45a4-a923-338f1b4eef35	2019-05-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
341233b0-0f1f-41ba-9069-6253c60f2a32	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4cfc44e3-fc09-440a-9c21-69010f8a2747	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6531e890-b4d5-4ec4-9b58-6d635cf821de	24ae20e1-50c7-4f33-a41f-08530977511a	2019-06-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
485506d2-b76f-41fd-b29e-6955dcdff287	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-06	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
fc3ab759-9f45-4e53-8601-6aeaedce885f	2b5583eb-23fe-4b86-99d3-970a30beb166	2019-06-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
fbd37298-c2cb-445d-a37b-4b7c28fd07c6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
2cbfc7fe-e076-4964-906d-38786352f650	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-04	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
2fd09ec9-661b-4e02-baa9-4caf61b89541	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0b474ed5-5f26-4bb3-94d1-926fd7e92b14	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
24a41efd-3543-416b-adea-82594077aa58	85059cd7-2c06-48e5-adeb-74ae4177722f	2019-07-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a0778fbc-9c23-4693-9f97-38f0687f3b06	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
fd3f320c-a83c-4fb6-ad10-036f1775c44b	a71258ea-db77-492d-a4c0-5b2458db460e	2020-02-05	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
e11f2c75-2d66-4704-a2dd-c2f95c70ddaa	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d168049f-f808-4fe4-8fee-0e693826b8de	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0b00e793-480f-49bb-89fc-856fa4083420	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-20	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
89903ad4-489b-4f87-9b75-6d49dfa6957b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
6e4a65c8-0484-41fa-ae10-5c02553d8213	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ffa0e389-a6c9-477d-9547-a71aa996b9f6	505dfc0d-0e7f-4303-be59-74a2a8fc2d3d	2019-01-16	0	24	21ac5e62-9a14-4abb-8f69-3eaa72a2a918	f
270ffd00-68db-4a45-83fb-67272b10fc4d	384f44b8-29bb-404f-898e-a4919823f91b	2019-01-17	0	24	2e24d271-85b4-4b01-b70c-b8dc86d27370	f
5638d3f5-0f75-46d0-9ae9-8ca5a4f48ca4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d9470ef0-8f3e-4d7a-afc1-6e86284f2566	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-21	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
371f4213-8755-4333-ac53-2aee568f287d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
08336a38-a4c4-49b7-8988-af11af88d142	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b8e03a92-9950-4852-b142-014bac3566f9	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-01-17	0	24	21ac5e62-9a14-4abb-8f69-3eaa72a2a918	f
a470cb4e-2aad-4490-aa6c-1bf0baf0bc90	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-24	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
a1ec37b5-91ad-4bb2-b75a-7b6649d3f62d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
2e225c01-6848-4b4b-96a5-ae59b68a59f0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-23	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
ebe84538-f85a-47f6-8ad7-ab988d7e45ab	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
eb293981-1684-48d3-af1e-9b980634a4f4	2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	2019-01-17	0	24	2e24d271-85b4-4b01-b70c-b8dc86d27370	f
6240278f-2a00-43bb-a423-d21dd072f853	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-01-24	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
699d7db0-298b-4321-99ab-f68ec3d2f409	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
c0354fae-d27d-4d62-9474-a691087e6247	a89bb6d5-3a2b-4a67-98d4-5ad79d90b366	2019-01-25	0	24	5a4c9fe0-6fef-410a-b296-ca64825cb8e3	f
058a89dd-b4f7-4531-aa83-ad4babbbaa0a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-21	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
75d134f8-eca2-4644-ab8f-fd86c7323b50	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-07	0	24	aeb73b0b-22c8-4188-9504-1236b19e11e4	f
f8291d31-44be-467f-86f6-9a170c805615	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-27	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bb245aa3-1b49-44f5-a231-62ef3b7d3c7c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7bdbfe7e-92ca-468f-a358-4e3c7cf158cf	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-12	0	24	288b82e6-7e91-46c0-b7d9-7cf69f7b1324	f
48746021-5f82-427b-96f4-6e524b0a7ae7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-12	0	24	288b82e6-7e91-46c0-b7d9-7cf69f7b1324	f
ce39ecbc-4385-4735-ba1f-1cc4d23bb8b4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
16dd580f-8088-4203-b4f0-306d4238bbd1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bb14738a-5ac1-4f7e-8f54-13f4b8c0649f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-24	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
75a4fbee-7343-4967-9787-d9c1e739986c	5e68d1fd-f252-44d0-b889-e109ea5bd10c	2019-11-12	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
9b4111df-8719-4ce3-aa52-98f6a3314a1f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-21	0	24	43960cd4-aaa3-40b5-b13f-8efac0c92668	f
771084f9-1d4a-44d2-9dd6-aaa38b515987	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2020-01-12	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
cbf453ab-af84-4a5f-b168-51de68a8c65e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-14	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
aff4c9f5-ef43-4f96-bebc-f93def5403ff	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9e0e5c85-51ec-4d3b-b970-ebe63ee068b6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
84dfaa43-9ce3-4aa9-b770-1f19f0760f8a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-06	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
198c2318-16de-4d50-b7bb-fbc60dd6d70b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-04	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
54155d8c-d310-48ca-a5c5-04277e9ad077	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-14	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
456d9b65-2f6a-4c4a-a9e6-1ccb43c0c280	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
6fa04b5f-06cc-4af4-9edd-fa3284ad25f5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ad7de5a0-8395-43d9-a36e-24c3ace70304	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-05	0	24	b1de6e67-398b-47e3-a2bf-92876a257ac8	f
510a7587-206d-4d35-82f3-acb5962fbbdf	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-31	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
0bae9099-d722-4fa8-b6d8-1b8b656d1dc2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6f071297-f450-432f-bf9a-9ec2f763057f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-05	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
449ed698-c486-4066-8267-ee5ff98ab924	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-05	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
df8d5ef2-0361-42a1-856c-cd06f011d020	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-06	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
c6c7ae8c-531c-48fa-8324-bcb761334df5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-19	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
f301f7fd-96f5-41e1-a42b-856ce6451646	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
fe6b0b3e-b5fe-4e5d-9194-93d5c7f43721	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-01-07	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
669836c6-aaab-4892-a33b-4c6d306834fc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
93e9c7a1-cd8e-4591-98e8-cd1970c2fcf9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a10c0a85-3bb0-46e6-9d2a-7acd868a9443	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-04	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
e0dd9bcc-d021-467c-8c30-501996a4ba71	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-25	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
b7d0f3f4-5ad1-47e1-a2c7-f7672c5dcf06	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
75c0cbad-7b21-4f6b-aefc-1e0e9414deb5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4dbeb51d-faf8-4a9d-8cdb-816ebe7a61f6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-22	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
63bc7c67-b2f5-43b1-8537-0c22bf022387	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-26	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3fda585a-8555-41e0-963c-3ecbf9845737	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-29	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
13b6f239-9aac-4fb4-a755-52899e21cea6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-23	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
e4188750-457a-4283-9c5a-8c627dcea0d3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-24	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
eb7b35ab-9394-449e-a990-822c2bc1225d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
91d8c0b2-8b88-4936-97a8-e90e6921f4f3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-22	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
3fec7846-dde0-4151-b0b9-51c046dfcdbe	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-28	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
f787dd11-33a6-4aaa-af40-46d9dd5c2961	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-29	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
7387830f-34d2-406e-ae5d-43f922751353	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ce213479-d26e-47ef-b0f6-5ba7ab024be7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-12	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
69ad9b2c-ebb1-4c1f-8cad-b40dd9dd4a63	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a4280073-90c9-4e7b-ac60-a4f060d2f2ff	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-01	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
2664d184-e029-4c62-90a1-9fccf714e9eb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-23	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
53e615dd-b0a9-4de7-9543-5857a039ecda	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-24	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
c99c494c-207a-4431-bfed-63fea7e15fcb	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-18	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
5ed85fab-5e1d-4f81-babc-37ea6cba3990	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-30	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
c8c67cd7-586e-4f29-92de-674652771508	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-31	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
d1ee53d6-80c7-4aee-a230-4764ca05aea8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
04896c0e-d5e4-47fc-be83-8699ce83c04f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-22	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
69ce2483-b094-4d5f-953b-14f5a0036ebd	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-21	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
09b7bd10-8f06-44fb-be71-c67ce6625367	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ae3d366c-963d-4b50-bd3a-0837a26c7d08	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-24	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
33aff77c-e532-480e-b072-001ab958a213	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-23	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
565914b0-d9fd-44de-a260-bbb1aec41381	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d87fafc9-e38b-480c-9250-7b12a516987e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
aacb8bbc-8d09-43ba-8f1d-97ab0275347d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-11	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
e43cd541-85db-4490-8a58-c709febf6baa	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
cf13cee0-727a-4e58-8325-a3c03a3ba0eb	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b9ee6fd0-b7f6-45d6-8908-1c7f2d4f6057	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
34130ae0-e3bb-4a0e-9d4b-f791365993e6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-14	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
7652e1ba-19d7-4b06-bbcf-8e43c5834047	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d8213308-7067-496f-89c4-edeb432ce2d3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-14	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
b857fd89-1461-4e75-9482-4f78b48779c9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
af7cf72d-1374-438e-b780-35a74734a29d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-12	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
45e3cf4f-669b-4f33-832e-80425930be17	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-02-01	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
1a420938-ddef-44b7-9121-f723fa9dfbb5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
456f7d54-6dac-4729-aa88-9ff0751b2519	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
88b41377-0127-4fe6-8100-821dfc83fa3a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-04	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
4027adf8-46e4-451d-b6fc-596ee36d5ba8	72613196-6819-4d69-8e6d-ce781ccd58db	2019-02-01	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
d91cc3fd-ae14-4648-957b-f682d8d31747	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
cae32508-33dd-4a23-a4a2-ee879f1a1def	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-02	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
2ac7caaf-ae84-4574-a158-c734bc7f13f8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-18	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
63c507d5-84b1-4c11-bcfb-be99069f9993	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
5e32c4f0-2638-42ac-bd79-8fda7c2b2bf3	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-04-08	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
daeeeea3-43a3-4a0f-9992-3a730bf64c27	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-24	0	24	c347aff0-7a4d-45ac-b051-63222b036c8f	f
0ba71c7a-9cc2-443f-983a-242d7b65ff7d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-21	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
2bdb3b28-aaec-4e50-92f4-55309473ea4b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9a306a91-899e-4d8a-9259-625261eb3191	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-26	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
4a475575-88ab-4508-ae51-d4d5407288bc	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7b57da60-c6e2-42cd-9ea2-2686380371b8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-03	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
32da04c9-e954-4585-9634-f0edbd12f11e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
22c6c17c-c8cb-4ee2-b58c-6dea0c16677e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-01	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
d5069a5c-a30b-4cd6-aca5-3f8fcc3859ff	02633b99-91e5-4a8f-90ad-68d8511141e0	2019-04-11	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
dfe54b8d-f248-4586-b2cf-d73bb8f9369d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-27	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
fb72b26a-142c-4efb-9530-ed12083f1c51	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-04-11	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
34a1ffcd-d95c-4b7e-97b1-5fcc3e524239	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-11	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
592e9819-3e68-40f9-b5d2-4786f553f079	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-04-13	0	24	5a4c9fe0-6fef-410a-b296-ca64825cb8e3	f
ba07cfcd-be51-4122-83f1-e935e991dd63	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-25	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
8a2ab229-0b1a-4a9b-a33b-be1fb51bf900	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
29bc44f7-7a4a-487c-b3fe-b1c246f449ef	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-27	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0c119748-9566-4dfe-980f-da8b9aad9150	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0e0bb671-9173-4dba-9ca0-3d9583ad8113	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-12	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
d28563f1-b282-43c3-92f7-d48e8a2b6daa	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a98412fa-a01d-4445-89d8-fbc7f2b48cca	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-04	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
8f798e5b-4dec-4144-a11a-c1f9b79f2abf	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-12	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
9ca04ef9-7f7c-4a69-9be3-c87d63effcad	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
60b8bdc3-07bd-4fde-aefc-c4343c3d344e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-28	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
4fedca7d-e7ca-4e79-beb3-a420bd0ab8f9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-28	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
c07587f4-e06a-4bc9-959f-34289bac6777	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-13	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
b1f65df4-a4c3-4db6-9aff-1c94412d43d5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-21	0	24	43960cd4-aaa3-40b5-b13f-8efac0c92668	f
61a26156-83f7-42f7-907d-68faec4948ed	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-04	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
8ad51578-b7a0-4331-b950-6b7240d6c30e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-13	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
bfb8df7c-56f6-4192-a7ec-d0ca59c7a9f0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-08	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9eb68447-e38c-42d6-86c2-ce4c0fe2c670	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-08	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
de77dfa9-68b3-4e7f-9627-1a03f5e02bcd	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-13	0	24	c960d71b-0318-414c-ba2b-9ccc26f638c6	f
96ab07cb-1631-4370-94a7-4f493c6db684	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-31	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
94b1a864-bd4e-4519-9fbb-d220dbbfbb46	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-01-07	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a494a396-71ef-41de-9da7-bfac26ef1270	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-01-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ebcca51c-4527-409b-a22a-253a22539693	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-13	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
24940aa9-2377-4c5c-a386-29de6628ab7d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-18	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
45f50640-ce29-4c42-ada3-7040099170da	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-18	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
79e1a724-156e-49d7-ab48-88d1864f7b8f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
659bd67c-74b5-443b-89cc-54ee2c31a95c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4dc0a967-de5e-4231-9b06-f2b86a20de12	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b0d09afe-9174-4478-a36c-8c2c0c480b82	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-16	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
81b5dcd0-c786-49b1-8f23-0ad0d6c2732d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
cb6aa10d-cde3-4205-b71e-770e560b44d4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0a0d96eb-4053-45ad-a318-24b1ee3794db	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1ec1ac5d-d5ff-426f-913f-e622f7799179	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-11	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
231061d2-f01f-4852-a87d-601f6a60f18f	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-01-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b28f15c5-32fb-4d09-9703-158598c9ecb7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-30	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6b7b27a1-0d8c-4da3-8c2b-ff8090c403a5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-11	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
7f172d51-e82c-4d75-903e-46808348748c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
b14a0fcb-c4fd-4f1c-8df0-56f115766cab	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1da1c8d1-a919-4763-b76c-e5cb8d45425f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-02	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
6644c894-938c-419c-9aeb-74266777eb1a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-29	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
cfb23867-0023-48fd-b534-b3faf4f27fbe	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2018-12-29	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
978177ca-76d9-408b-ba5c-724ea7286f07	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-31	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
9c04c1ae-66f1-47f0-a046-dc9b6cbafd50	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2018-12-31	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
d0b48a36-7914-4dbf-8aa0-7cd670ae5e5c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0820578a-b692-4a56-8a5b-ef7fc9ee8525	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-22	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
0bbc0f2c-5f6b-4e69-90cb-59ea2ba9bd29	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-11	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
826f335d-c3bb-4de7-b9b7-ad1be921b800	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c70eea15-e0cc-47e5-bed2-174d2953f76e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1d79d57c-9b4a-49a3-9347-5b1590a62d03	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f14f4458-f9d3-480b-9f64-d93aa9ab74b7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-01	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
99252f57-daaa-48d9-a413-ab3180691f1b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-02	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a173d688-fad2-4183-a2f6-708ae6f58a30	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-30	0	24	2e24d271-85b4-4b01-b70c-b8dc86d27370	f
06e4a871-bdf1-4282-9319-560e4c4e7ab0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-30	0	24	2e24d271-85b4-4b01-b70c-b8dc86d27370	f
8ff8811d-b27b-4070-bbed-18676c6dfae3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ea8c0ad7-2f73-4d5d-b97e-5acaf55006c9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-17	0	24	c1cd13a3-af42-4d89-91f0-d642a68764fb	f
b8a6a146-8f50-4b86-aa42-0b229dc31fd1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
48327d4c-9427-443e-ae98-e2094311ee81	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6f387c2c-bcb6-4d0d-bedd-fcdbe36ac01a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-13	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
9e8982a7-9da5-49b1-826f-452b06f377ce	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-13	0	24	c960d71b-0318-414c-ba2b-9ccc26f638c6	f
f00e76dd-122c-4db4-adb6-c77835a20e1e	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-05-09	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
0833ca6b-9530-4123-9755-fbc25c3cc731	0b858375-5c55-4acf-8175-6bcb9d43fa3d	2019-04-09	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
10f980de-9832-4593-a67c-07676fa35982	1b052437-ffe8-40ef-a40b-8fd9b306e0f8	2019-04-13	0	24	5a4c9fe0-6fef-410a-b296-ca64825cb8e3	f
3e9f2d93-112a-48b7-ba65-86644e44290e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6ac99675-753f-4154-934b-76b3869b1590	ed53e116-0d54-4c98-a66d-3e3b0b4c864d	2019-05-24	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
f381ddc9-bc61-445a-8b55-5ec63c866f33	02633b99-91e5-4a8f-90ad-68d8511141e0	2019-04-12	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
89bd56c6-2120-43f4-8f68-e61420a26b48	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-08	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
076da6af-c908-43e3-bd94-60b7f597e15c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-08	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
daf8336e-ed09-47f4-be7d-e80aeb2cf4cb	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5079628b-6c0d-43a0-9542-b80ec955d780	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9691327f-fee6-4d40-af63-11a8413731a7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-30	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d8ca6740-1f35-4d7c-b693-0f78291d00e0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-22	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
320154bb-a5f2-4612-a94c-6c6ad52b9531	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9a3c650b-a5bd-407a-801a-b7e69785acfe	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0efcf6cc-1c7e-400f-894d-49f272d0714e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-30	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
47121aef-6d72-43a3-b6fe-088be64a1e88	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-16	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
3a84518b-7eac-4ac5-b7b1-a4f54a1f775c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-18	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
ac7ce86d-a2e1-4af3-b093-93f3a2c00c38	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
2cea835a-9db4-420e-80ef-d6906c6c5af6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-26	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
4920e8a0-cfc3-4b19-837a-536713e790a0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-01-28	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
7ef73f64-b929-459d-8c33-b9b48ea02dd7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-01-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d4f06530-9818-4e3d-922b-fe2210ac92e4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-02	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
03e9cf10-33b5-4cd6-bffb-49423700b3c0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-02	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
5fb327c6-effc-41cc-b916-cc8fad27ba43	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4e6f87d2-b5b6-4c9c-aaec-24e48d68d1f0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3ccfefec-2abe-4486-bf1a-9aa8420468c0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-16	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
acd8e392-0592-404e-ab8d-65643c667b3c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ece080cf-8472-499c-a148-6f3012ad0692	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
b243795f-0988-40d5-bbd5-a9d76c44f2b5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-15	0	24	c1cd13a3-af42-4d89-91f0-d642a68764fb	f
420c55a0-92cd-473a-a147-a24961f974f4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-23	0	24	c347aff0-7a4d-45ac-b051-63222b036c8f	f
fb0e80f1-f452-44a7-83d1-3b89625b0193	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-10	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
82b377f2-6c6d-4cc5-b100-0611d8ae4bf4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9b267b1f-9e0d-42fc-902c-ce44d136134e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
fb638bf4-6e1f-4a78-aad0-1dde2de34a5d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c7362e6d-9e40-4088-8ca8-7c2d64bc6b09	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
503075b9-224d-4b32-bd4f-d1fd57f029a7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c52573eb-4709-4197-b791-f17c3df7e8a8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
fbc03187-149e-4f90-a001-d28ee1380128	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ed3d8dcd-9f1a-47ce-b6c9-6ae7e549c899	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-25	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9788ca60-ae90-4611-8670-88266fa76d9e	81aef3ed-f05d-48f2-b7cf-aaebabca955c	2019-04-09	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
0b052ac6-7e2e-4c52-bd5e-a4d3d87de40a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9e24c710-1adb-43d3-868a-ada9e815f3ba	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-22	0	24	496ea809-2edb-4da1-8f5e-3302393a5206	f
07d126c3-f602-47b2-a37c-faab4169fe6e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4f094577-a52f-4d01-babe-f8d23eac8375	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-21	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
d01129c1-d35d-4dff-bb18-89ebbcd811fe	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-06-26	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
c3a74033-0b58-44f5-b69a-f3cbd934565d	24ae20e1-50c7-4f33-a41f-08530977511a	2019-06-25	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
21785d82-109c-4203-a1de-f97bd403dd8c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-27	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
07010de8-d326-4eda-b6e5-a1917af26a61	81aef3ed-f05d-48f2-b7cf-aaebabca955c	2019-05-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f4b28278-bc1e-4722-a617-087d16dbc542	ce266fd6-ebe7-4d48-a1c5-d064ffe1f292	2019-05-06	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
f657e5b5-eaa3-4745-a303-545ce1ad3651	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-06	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
43a34054-4c2f-488d-9b88-ae51a83dbdd5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-06	0	24	7be01b65-548a-4cf7-86c2-3b7c5a14239d	f
11d213d3-c3d7-4f03-9258-50e68e2916eb	1895b86c-fb3e-41fe-a5c8-0dc617f391aa	2019-05-10	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
e2cf9c4e-7c75-4841-a353-ecc0d8fae4f7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-06	0	24	7be01b65-548a-4cf7-86c2-3b7c5a14239d	f
4b5b0686-d013-4ee7-a74f-aa9c9d9c02ac	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-04-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
aee23381-e9ed-4486-80c9-c09f9984ecec	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
2a03ddd8-fa29-462e-92e8-692c04fdfddb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3c1642b6-5202-462c-9440-0b75ef4f0797	a71258ea-db77-492d-a4c0-5b2458db460e	2019-05-06	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
7cbe8009-b0b3-4204-9647-b8f77d140f03	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9a4417ab-a443-48b2-b82f-7c1beb50e06f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-24	0	24	e121910a-eb7b-4081-a3af-342fd042f994	f
7601e58b-155a-43b6-bb32-54efd7c2d791	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c3454a78-31b9-4ecd-bee3-ea506fe069e5	cb7e4521-6f30-43b3-86ab-f50138d949d8	2019-06-25	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
176db71c-5b24-4fb4-b7bb-7e24799715f3	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-05-07	0	24	2e24d271-85b4-4b01-b70c-b8dc86d27370	f
034eb41c-fcd2-463e-9cec-b56bca912c1d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
40d8f694-e80a-4895-b159-d0c13ddc53b0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-24	0	24	e121910a-eb7b-4081-a3af-342fd042f994	f
84b68a1a-1c58-4bdf-a9c6-e99ed9ac5502	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-29	0	24	5d0f526d-be55-4034-bfc6-410e38cf6c37	f
4aa5aea3-7b88-4322-9afd-a5790328b56c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6203c02a-da5b-4b22-8ffe-99f53f4cbf93	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-09-21	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
72dfd883-03ef-4525-96f8-1f5786c414b4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-16	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
f0b68ce3-8bfa-4f15-9909-6e91789e71cf	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-22	0	24	43960cd4-aaa3-40b5-b13f-8efac0c92668	f
9ebb0429-b061-46a3-9d5b-1c4f81f2cb32	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-09	0	24	2e24d271-85b4-4b01-b70c-b8dc86d27370	f
270be626-e1ff-44dd-b70c-22a8528ea038	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
00dd40d7-1457-48c2-89db-05626e2a286d	a805db41-cb6c-4996-99df-55e6498293a0	2019-06-26	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
67b577ba-14e0-4656-8763-0e400b267df0	a71258ea-db77-492d-a4c0-5b2458db460e	2019-04-22	0	24	eeac58d7-56d8-47f0-8bfa-bc3ce847bb46	f
931d62f5-916e-459d-b975-813ef7e5fab1	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-06-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
67c6aa90-7bea-453a-8c5a-1938f2ce4e1e	5e1c0929-ef35-4d9f-9f4b-cd24b3a66e74	2019-05-26	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3338bee3-f154-46a0-9d91-17b2d50a2f3e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-23	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
539f3a86-9818-4a74-8043-ec39365161a5	d40170b9-e86c-4fc5-ab25-ec2e100f06f4	2019-06-05	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
3590c377-e5d8-4d24-85c2-67b7c4e371ab	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-26	0	24	19276bb3-9e06-4063-a1fc-2662ec673f4d	f
fd2057e4-914f-4844-9469-e8eb45e174f7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-26	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
d9e88b04-d356-4bdb-87f5-5e7c2caa5313	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2019-05-24	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
e1622644-6e98-4d88-aff9-299b051fef17	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-08	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
8df60914-29fd-4bf8-9e93-86cc29f452f6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-08	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
6fbad7b9-f2c3-4301-8869-4930c2393563	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-05	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
add10491-0cd6-4b89-9ed7-4170476d8a75	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f7580258-5460-4d68-82e7-7b0dfa962c06	feba6c1f-a359-4162-8471-4df5994d4d4b	2019-07-03	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
f0fa0b02-9a73-4205-a0d7-52c519c2ee58	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
1bbd13ca-101e-4021-9624-304f7e493fdc	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-25	0	24	c347aff0-7a4d-45ac-b051-63222b036c8f	f
3aa00c17-9c3a-4983-9e4f-71b7303839f2	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-11	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
ea010eab-8ed9-42a2-aea8-87817f4e2a53	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
15d74073-e63e-4de7-b784-acf306331dad	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-06	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
07340a5e-62bc-49cc-be40-4b25f3dc6dd4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
e4fedb02-95b5-4042-a197-323302da0f3d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8fe32d9f-4ad7-4f74-bb4d-dd2585d87d8c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e10bedd3-4475-41f7-ac7c-cca9c1f07fe7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-03	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9b09505e-2190-47e5-acb7-01c6e8e15111	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7f3a4ee9-4a56-4654-8c7a-1ed783b0e1cc	a89bb6d5-3a2b-4a67-98d4-5ad79d90b366	2019-04-23	0	24	eeac58d7-56d8-47f0-8bfa-bc3ce847bb46	f
441a971a-3935-4798-a094-dc76d7d2dcdb	ca2f149f-87a1-4bfe-8309-9c9b845a692c	2019-06-27	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
105a35c7-c3cc-4987-acc8-0f6907f4eb40	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-03	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
27bf5b70-433f-4a0c-96f5-e1cb2524a535	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1ae3477a-24a3-4ccc-9e5e-da0bf65a7096	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
59c156a3-fb2e-42a8-92c6-15a21c1917a0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-11	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
e8673bd8-3c31-4ca5-b637-0f3553e18df2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-26	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
b4a906f1-2b2f-458a-9011-b4ec12cf2710	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
703d000a-415a-4d8a-83d0-d60dd9b71e20	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-25	0	24	496ea809-2edb-4da1-8f5e-3302393a5206	f
8ae1da0e-970d-447a-a97d-2ffb834669ab	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
135fc6e5-fc51-443b-b33e-e1bf76a6d12c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-16	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
aa098d90-f958-4953-af29-040c9cfae9ab	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a52f2672-aa18-46ee-907b-34a8da131a42	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
eba2405e-13ab-4c69-9d9c-f04bec5f623e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-06	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
c374072f-4012-4542-8412-f79458dec30e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e1e05c63-bee7-42dd-9ff0-48dc1a00e653	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-07	0	24	a5b73185-7441-4cab-9531-e5910947fd6c	f
0f8237d1-414c-4fca-9b88-bac467558437	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-18	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
80e586aa-f2e4-4888-b7cc-78aba453c85b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-15	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
509d0601-cdaa-4577-a143-b90297087271	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bb02411f-64df-4dd6-9378-3db31a191b05	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-15	0	24	c1cd13a3-af42-4d89-91f0-d642a68764fb	f
0e6964af-5950-40dd-b6b2-590bfa4acb65	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-02	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
dfcea501-9847-471f-8e55-10af64fbf4a8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3b1bd706-031b-439e-b60a-8665cd4d67f0	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-06-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3099a084-bf6d-487d-adc8-bb9394920aad	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-27	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
86809be9-e93a-4198-a45f-e80d59500d44	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-06-15	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
bbebb327-6aa5-4fed-b501-c06c7400ec4b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-26	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
5bc8859a-690b-42cc-97cc-737ea98892c5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d84fb4ce-9aac-43fd-8576-ce8bb004b9e3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-02-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3cb4a0f9-ac3c-434f-afa1-8d748fd3af63	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-11	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
5c218270-484d-4aef-bf23-b05a0e5d5aa7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-29	0	24	7bec0c04-ee21-4cb9-be2d-b447ea5dd160	f
442fc0c5-9987-48d9-ab56-f24604ca4075	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-30	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
eb8999d0-cb59-4292-97e7-23c1e85d1fb1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-02-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5c689ab4-c8a7-4a4d-86af-4468dbe57826	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-06-06	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
cab7208f-c0fd-4422-a963-34c3b3ff3570	a71258ea-db77-492d-a4c0-5b2458db460e	2019-04-24	0	24	2e24d271-85b4-4b01-b70c-b8dc86d27370	f
b8576874-f1bb-4b80-9a92-0efd31387693	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e2c38fd1-195b-469f-b6e2-3949d794d844	81aef3ed-f05d-48f2-b7cf-aaebabca955c	2019-05-11	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
32886139-6d67-4dbd-a82a-c6e2e0a82aee	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-30	0	24	5d0f526d-be55-4034-bfc6-410e38cf6c37	f
16b1153e-4abd-415d-920d-f613f5b7a383	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4a958771-9813-4199-8608-90206e7e6f0f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-08	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a3375834-ab7c-4962-aeaa-bd9ee3a2ff61	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-26	0	24	19276bb3-9e06-4063-a1fc-2662ec673f4d	f
73fb50fe-c642-4a27-9792-7109083f27b1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-24	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
7125ce20-1072-4bdf-a22f-7317982a7a7f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3d2276e5-4761-4633-a363-c1b993faf0cb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-26	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
1382380c-7b51-4405-857d-eee96899d76c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-24	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
7bf518aa-7850-49b9-be0d-6d76a49edfbd	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-26	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
663a33b8-aa98-41a1-ae69-3f07a1af2995	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
470b6ce4-ce38-41cc-9608-cf9d914da0b6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
adccae45-ecb6-4d74-ae3e-80f3be8c7ca5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-23	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
e1510e4d-56cd-4ca8-b620-2090c41aa034	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5cb82f77-37b8-4534-9d68-528d8a42b80c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-25	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
8e2ac8ed-b7d1-44c6-8ae3-e2332d7529aa	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-28	0	24	42c51889-8e8e-4e45-adaa-835382d4a0ce	f
86020655-a354-45ab-9604-e71080cc7f65	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-28	0	24	42c51889-8e8e-4e45-adaa-835382d4a0ce	f
f6d83ad8-4ff5-46b9-9d4d-1cfdfe9ccbb9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5d635b20-79b3-4549-9056-7bf8df4ee128	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
fd9fd38c-adf3-4106-88df-06c06b610fe3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-09	0	24	aeb73b0b-22c8-4188-9504-1236b19e11e4	f
2c5c4eee-5d0f-4089-bf9d-8ce58628babb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e6acdb40-ea18-4daf-a053-aba2e249a0b5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
fceb2a56-742d-4556-9b20-57835fc626af	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
56981901-e4e9-41ae-b27a-c9b2c4780ac4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-31	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
0bc10788-dc57-4d0f-a4c5-e34b1c32e66d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-31	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
64ef6024-0cfa-44c7-9a9f-0dd4196e8576	07c2fb26-38a9-45a4-a923-338f1b4eef35	2019-06-17	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
393336e1-d05e-4122-a610-7c37406ccf18	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-07	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
82e7da2e-50a1-4b32-85ad-bdef0fa9b351	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-26	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
11fab301-d748-4f52-a8a4-bb7cc66df456	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d7c5ca7c-ce52-4a1c-9f57-5fff3d5a12b7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9be56bea-2131-4687-a1df-8baac0052918	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-07	0	24	7bec0c04-ee21-4cb9-be2d-b447ea5dd160	f
8410f2ae-03d9-4cd0-9951-005790ee5419	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-30	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
5afb1b86-0278-4a0f-bb48-ae31994c0dd6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-16	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
791e4318-63d7-4acb-be79-c0364fbcb10b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-01	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
907b761a-1884-4e0d-a7ca-52e771f57ccc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b895f5cc-1597-4c81-b6e2-67b10fb7cfe2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-22	0	24	496ea809-2edb-4da1-8f5e-3302393a5206	f
467416e2-649c-401c-bf63-87c9e1d24e5c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-11	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
2f98b45c-587a-4ff3-8a26-33fba1455a16	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-31	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ba83fb82-d032-439e-875f-adf57d1b82ab	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a1a1bca6-b85a-402b-b146-7b32d46cdf52	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-01	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
f1bf28b2-d665-4772-8edc-6dc865c0d1fb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
29c3a57f-4816-48d4-8130-0729cb4138c2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-13	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
d0be3b6f-3409-415d-8e1e-4c042ec067a7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-29	0	24	5d0f526d-be55-4034-bfc6-410e38cf6c37	f
5d28150b-123a-4ac2-8619-5280cba9cc9b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
57df6a7a-763a-4fa2-9b01-2eab9543eeb4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-12	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
c48b224f-d2a8-432a-948a-e12b631ca85f	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-05-13	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
bc456b0e-9e76-4647-a6e0-1de9a2acf9cb	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
78d1c3c4-02b4-4670-b277-0cd11d8b4dd1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-07	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
ad07b1c6-5c02-4822-a985-b42c76df0668	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
270d5dc6-24ac-479c-88fe-e758645fdeab	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-14	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
2501b558-c992-4dab-bcec-52585e5dff83	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
aface142-2fe7-4e91-86c8-ef320c095b1a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-15	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3e810f8d-2084-451f-a06f-faba329f447e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9441bf6c-8443-4db4-bb39-a3460cadda38	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
629a526f-ddf8-42f5-bfa8-3f83e4da7b0e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-08	0	24	dd6b39e1-8671-47c8-8e7d-12aec9c141ff	f
15ae3683-d7f5-433f-a735-e78d0dcdd72c	2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	2019-06-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
2e9ef485-2e1e-45d7-ac86-8bf8e623f545	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-14	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
01ec6c7e-a7c9-4676-a9b8-e049126af92b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
cda6f981-9907-4514-a301-b2919dbee025	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-14	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
919e16e6-93ca-4415-9a1e-1d83d5f1773a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-03	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
2b40d7ac-1c2a-4a93-a58a-d26f40c93f52	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-08	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
b4e3da23-34d7-4d62-938d-c23d060b0391	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-07	0	24	7bec0c04-ee21-4cb9-be2d-b447ea5dd160	f
f2ba4b20-e8b0-49b4-a761-18affe069b4b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-07	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
243b7c79-e04a-47b1-9841-f3a6d05a7274	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-27	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
eab2464d-cfc8-4ab8-8dde-3f179a11520c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-10	0	24	9ee86f1b-45ca-464a-8719-81f00ac546d4	f
2c65242b-be37-4a5b-9403-aa2d3e49d7bc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-09	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
e1a16722-a51c-4373-85bf-1bbb6471b27a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-27	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
858f247e-de7f-4456-99d2-eabadf39762f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-02	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
a8048310-1e0a-45f9-b710-b614d3249158	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
4707e53d-7f09-450e-8109-911951446b2f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bebd9403-385a-4169-8ced-057fac8c724f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-29	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
2cc1791a-420b-4640-b9a4-bd11b74e5a75	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-29	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
fefe1520-fab9-4b1e-aef2-77b4b6b94d64	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bc2bb9de-40dd-49a8-8745-1088e27b484e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-27	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
49a152d8-b9e1-4ec9-9b58-6722086dc4b4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-01	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
ac30500f-2548-43c8-8c7c-3ebb5490bd0e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-26	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
7d1efcdf-0bd5-4d4a-99de-b31457aa46ce	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
960f37f0-defa-4ffe-8589-251a8a813f6b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-02	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
02aa2cac-81cf-4758-bc1c-56e16585b403	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-26	0	24	dcb829e1-fa73-413a-95c8-f2cbb47ad302	f
f9119326-8052-416b-b902-fc8494ac7065	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5df8c64b-af90-4af9-a848-90b5328a2807	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-03-02	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
f826f5d0-1504-49be-a217-7a0d46079a9f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9036b4a1-95b7-4357-94c0-1c6712eb64f6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-14	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
aa58c09a-884e-48d3-a18c-12f79f64c1d5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-04-11	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
05ba3d08-4608-4370-82eb-c0ef4b0eefff	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-17	0	24	c1cd13a3-af42-4d89-91f0-d642a68764fb	f
7b7be931-8e7f-46af-b676-336efbe9e3d2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-03-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
2590ac88-9bad-4d2c-812e-3b825fcb3ff2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-17	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
fc15042b-4b8e-4ba4-8c58-b5b25e2d632c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8b7bbf08-c593-43ca-8e7b-11f09d92fbcc	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
59029345-be9c-4cb9-b5b5-917c0c9be2c1	55d1ef9e-7db5-4a83-bbb2-fc59381cc2e4	2019-05-29	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
ef35ff10-c4fc-4b67-b0d4-a54426a93f4a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
2d76998d-324e-4a91-8f4c-a43a1a9f3364	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-08	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
1c4be090-4484-4f3d-80e5-c2ed7c08e143	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
449c18f8-4df1-4b1b-8a8a-23b7b0238fbe	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
2677edaa-4746-494a-9804-dc8d6c6faf04	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-04-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d671f646-fd9d-47a7-bf2f-698d301eda57	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
308293f0-e415-499e-a9ed-676385d01ad4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
da79be8b-d3c4-4074-b44e-3d986e818c7c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-16	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
70f3ad32-9628-4d23-846b-0b2bdb07ff7d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-05	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
e24d2e0e-2463-4366-ac5a-4cc3beffe89f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
549108d0-9a25-45c2-be6a-0eaec6f710fb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-05	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
970cf94e-8dad-41fb-8634-1dd3378ef59b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-12	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
1c1f3f7e-8912-401d-9cb4-0506bbba45fa	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-15	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8ac51990-2ae4-44a9-97f2-36f2e5a168df	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2020-01-15	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
d36a1dd5-0147-4838-9f6e-88373ce3b442	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-30	0	24	5d0f526d-be55-4034-bfc6-410e38cf6c37	f
c220b91c-c2ad-40ed-95bd-ea523be18e07	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-07	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
2a8f8418-8b26-478d-b448-60bda6900e4b	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-05-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9a83d0eb-1f7a-4ea2-866e-34f1e9ae5240	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-16	0	24	c1cd13a3-af42-4d89-91f0-d642a68764fb	f
232dbbb2-1d94-4640-a194-a43980aaf57f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-16	0	24	45c3c654-65da-47d3-8001-a763f7c9c13e	f
90bc783b-8fb4-4707-b48c-cf7a84dd5856	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-10	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
46da467c-6a64-413d-bb65-6e7d8933e31e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-21	0	24	e551c73b-0e3b-4a8c-a38c-5d92766b114b	f
f736fa6d-85f4-424e-998e-b5a40b828c97	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-10	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
fb975bf8-b816-4468-b454-64ef65d4390c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-27	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
b7d108cc-0188-4b77-909f-2573f4498a52	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-10	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
96e75e78-0970-458d-9b55-5bb39778dcbc	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
58696c2f-16c3-4930-8196-6bd0f7e8a5aa	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-16	0	24	45c3c654-65da-47d3-8001-a763f7c9c13e	f
e2514461-4988-406c-b07f-d365edbd0495	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-07	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4edeaed1-0b9e-473c-8fad-190a96c16ff6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-22	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c42ffcb7-1cfa-4e24-9278-50d937853f8a	feba6c1f-a359-4162-8471-4df5994d4d4b	2019-09-22	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
6b09a5c2-11f4-4acc-8984-458513447886	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-21	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
43b0c9ba-04ea-4ac1-90fb-6781a168e318	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
22a0c4a0-7e32-444e-939d-37f755b95bf2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-16	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
c1bed5e6-ffd7-4b9f-931e-0600fa5e79b9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-07	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
270b2781-3ae7-42d1-ba51-345314e70c2d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9f879fb1-d588-4a41-98fd-3a9901247683	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-17	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
f04f3499-17b1-4794-9a23-5a07406108f7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-09	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
c49e684e-07b6-41d7-b88a-1d8ae4117850	ce266fd6-ebe7-4d48-a1c5-d064ffe1f292	2019-09-21	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
ffd805aa-e8e7-43b4-93f1-b806a984ece0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-13	0	24	dbfe61cc-3d34-4af5-aea4-055406c09b45	f
62d97551-bf31-48b8-bebb-f062d1ecf24b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-17	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
044a1310-2fd5-4524-aea3-bc681db173f0	ed53e116-0d54-4c98-a66d-3e3b0b4c864d	2020-03-10	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
15fa3e46-b902-431a-ac5e-c80012f88631	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-09	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
f4d7ef62-f357-439c-a213-cbfc918766a1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
83dbff3d-1354-46a7-bfd0-55baf1d97f69	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-11-11	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c4e6e875-0e5d-42d3-9315-298e0b2f6cf2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-17	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
57c76d85-cb96-4abe-becc-840d377bd718	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-11	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
686b1ffc-6b75-41f7-8b63-6626492ff502	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
28c8ea93-0a6e-49d1-9ad2-8e91a955a273	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-09	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
3d7a4960-cc75-4556-a76d-35e934e8b0fc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-09	0	24	cec2a73c-80fe-46a8-8ba3-e224a890957c	f
f05ffb7f-113e-4617-93c1-f9769b32dc0b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
07988593-86a8-44c8-ac2f-051e47ff9b6a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-22	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
e6742419-2b1a-4b63-95f4-a7787b5d5289	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-22	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
08a4a336-bcbc-4bd2-b907-b0f5421fb908	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e99e8d76-a7e6-4731-9157-aec29f280bc2	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-24	0	24	4f9cef16-551e-42ae-b4a1-887e5d0b0980	f
a6edc2a0-762f-4e7f-8193-3dac3d8e97d5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-24	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
66fc0df3-1d38-416a-8fa5-9ce96fa9d20e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
46bd3926-a16c-4ba0-9bee-aabef071ff3e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3398af0d-8023-4279-b40c-f4e682f6173c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-03	0	24	eb12cb32-b602-4a96-8d96-f9c78fb22c47	f
3b976332-0863-4048-a4b6-6033aed28600	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
96887b0a-e79d-4b08-b7dc-3cdd1a6ce746	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0c213234-afb1-408e-864e-285dd3463e03	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
336d06bf-49ab-4ba2-8f55-a2d2df01ea80	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-02	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
6ae6143e-8b68-47b4-b014-48e369aeb6f6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-02	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a82fddec-2519-4b63-954d-bdf1bb6670b0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-02	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
525977ba-142a-4353-bfa5-120c0d45e5f3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
56c8a8ad-2198-47d1-9d0b-31c915c247ca	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f31e3358-5643-4d28-8c85-dbfdcbb58c87	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-07	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
c855b7f8-99cb-476f-8a94-f0b6324150a7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9c83cbd0-d444-49f9-9de0-803ea3a3146b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
310084a9-135b-40cc-9b98-201e5fc02402	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-05-03	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
a77d2caf-45d4-4c13-a50e-5c54ad6d77aa	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
44611458-a1bb-4cf0-a4fe-73e07f7559dc	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-21	0	24	02dfe11d-a82f-48df-a8c8-ce31cb51610a	f
562920c4-0588-4963-a041-e993b48fd134	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-21	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
a2e6c3be-3558-4a87-af70-d567e8afe938	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-03	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8726e74b-d08f-48e1-9490-0565647e3e39	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
156eede7-c7f6-4903-84b5-b2bd049c0036	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-09	0	24	cec2a73c-80fe-46a8-8ba3-e224a890957c	f
6b77205b-b9b1-4db8-b909-9729df44287e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-22	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
fca71af6-b8c2-42c4-8746-d8d5098245c8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
c777d9da-0ea4-4b73-b1fb-dcfbef2b8e0b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1f2803d1-d5ef-4a66-abb6-3158d0c55541	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8a436fa8-72d0-42fe-9ede-06d31feeb464	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a1bebc17-65f4-4725-8f0c-e6fc1e6c7547	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-21	0	24	02dfe11d-a82f-48df-a8c8-ce31cb51610a	f
ba6a8c9f-e4bd-494d-9041-42ee87dcad0f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e6361ba3-9b6d-4cb4-a573-45bb31f00310	988a9845-25fc-419e-928c-91a962e80427	2019-05-04	0	24	2e24d271-85b4-4b01-b70c-b8dc86d27370	f
40e7c1a6-4cea-4e4f-a79e-ea0c3517dacd	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
f9855631-9f1f-40c0-90ec-d15d083b3549	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
27e49a1c-00dd-47d3-8cb4-182c10efe278	81aef3ed-f05d-48f2-b7cf-aaebabca955c	2019-06-22	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
1adb42f5-d75e-4fda-a9ca-b2c2291ce7a5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ff9f0549-4803-46f1-9b68-315c92bca83f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3c35edb9-3318-449d-9b37-219714f53b52	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1a461411-4b58-48ba-af88-9da94c77ba83	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1e8af8be-b86b-429a-924b-41acf465b12c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
afd1fc5a-fe6e-434d-8598-5a948aba71b4	feba6c1f-a359-4162-8471-4df5994d4d4b	2019-06-23	0	24	b6fa0bbf-ff89-4e0b-85d1-5745c072fac4	f
4cc4c77b-30d3-4b0f-b2cb-6dd0ffeee285	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
070d207e-bd99-4951-bec2-bff5e6c028a5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-06-23	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
211cce19-8af0-438c-91bf-10155369de5d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
22860778-fdb6-477d-91c3-fa799e528647	5e1c0929-ef35-4d9f-9f4b-cd24b3a66e74	2019-05-05	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
89bb6a8f-8f75-4ff6-b14a-ebe5c67c0d4f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-23	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
188d5742-d3e9-4233-b26a-151d9e08ad2c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-06-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
fd46778e-43dc-4ac0-a4bb-1a5ab605f06e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-17	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9b4d760f-6f17-408e-85ef-611278a88666	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5ab8577a-8aa8-4d60-aa80-d0c2ebe5aba3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-11	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
c5056feb-7381-45ed-80c3-310de12864d1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-11	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9ad6bd27-ee81-4247-bbfb-cd8e40e8d575	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-05-09	0	24	2e24d271-85b4-4b01-b70c-b8dc86d27370	f
0d77fc99-5259-490b-b32a-ccb105bf623d	2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	2019-05-08	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a6aa8e9d-6132-4425-a6ec-a93b66a7d9d0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-05-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b18a91cb-d6a0-4573-b2dd-b1f5b397d0b2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c07ac293-24fb-4910-9b01-45f6e2a9724c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-23	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8f4027c9-9c97-4d41-9c13-9fb5a45a8ca6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-12	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
608f5a08-4642-4913-81cd-a2a0ae26af1c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-22	0	24	43960cd4-aaa3-40b5-b13f-8efac0c92668	f
f9667188-556b-4026-a556-98b39b3ccc81	992513b6-13f7-4dcb-8471-84972522feb3	2020-02-23	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
6fb6a001-f3de-401f-9ae3-a6567445eb73	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-23	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
7646e36e-ed36-4d4d-b5f2-400ed3131688	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-13	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
01ccef57-2e66-45ba-87af-153b122fbad7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ef578194-8337-4c56-acf2-5bd21ff292d6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-23	0	24	0a04d741-7203-4369-9ae4-e06809ae9528	f
6837a197-5ef4-45b0-b413-1fa3d81f9833	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ed873df9-21d0-4ea9-b0dd-30217438abc3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-24	0	24	88f66fef-c1b4-4966-b9e2-a4366d7931c0	f
d55c314b-9790-4dcd-88bc-9ab2b69f916e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-24	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
7ebddb6f-f23a-4753-aa98-eee731f928bb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-24	0	24	88f66fef-c1b4-4966-b9e2-a4366d7931c0	f
f830c7f7-1f49-4f33-aa7c-55dc0bbb7ab3	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2020-02-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b07d8cc7-ef93-4f62-878e-4264c373d1c0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-13	0	24	e6e196ee-22e7-4730-92f4-be3baba89e42	f
caeba86e-f979-4d7e-8b1f-e411fd4186e9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-16	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
edd03aaf-ed4e-40a7-a999-dc60a121e8fd	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-06	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
a54c38ca-b5d7-4f3e-bbb1-e9412ae7afc1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b9e56478-b5ff-4a2b-92c5-510319812a8d	feba6c1f-a359-4162-8471-4df5994d4d4b	2019-07-23	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
fd1e4ecf-89b7-4dd7-b84c-173caf14b428	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-07-24	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
fd613d4c-8eb7-4474-8400-822c7b1dbf6f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-22	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
2d10f47f-f179-4af1-9d61-2c44a5c398de	1dab66fd-8ebe-45f3-b8d6-bfdb14fb8c75	2019-07-24	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
5e2d9c62-bc7a-4709-94a3-7f6ec91ee86e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-26	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
bef8fd90-fcd9-49dc-93dd-3910f193b7e3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-06	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
25f8e774-4ed0-415c-97af-d721c3e6a3a9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-24	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
e3b6cfb2-c1e1-4b68-b5c4-4b26cb4c185a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-24	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
664e3b6b-c9b2-4c2b-a544-beb19a071c09	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-07	0	24	9e6642ab-39b5-4bcf-8759-6093dc114e0c	f
e277dbcc-dd21-4b85-a00f-335a504ef01a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-07	0	24	24a381cc-a7a5-40f5-8f3d-5ddd19a79b5a	f
85fb082a-32a2-41db-9406-371e470a8413	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-07	0	24	9e6642ab-39b5-4bcf-8759-6093dc114e0c	f
d1db0301-6544-40b0-b3b4-aee2c1f20e85	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
77295018-69e4-4802-9d36-3f4bc5c72aef	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
47bcfe96-e56c-486a-9f52-fb1c63f92f21	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-24	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
23a41026-6cbd-464d-9165-f4a058b4fa7a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-24	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
6f482ae7-b9cd-4b10-b17f-48a6d5b082e0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-25	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
57105064-d6c1-425e-b34a-afdd8ff33545	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-25	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
6bc578b1-f160-4f45-b1ea-447b17371032	505dfc0d-0e7f-4303-be59-74a2a8fc2d3d	2019-07-25	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
92f84526-6d9c-4429-9ba5-975f43b2ce32	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-23	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
2a4c878b-df9f-442e-a4e4-9ed5e9e0e48b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-23	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
7cd0e2c3-4312-4afb-8a35-5a7e3b2235d1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8f6e47e1-53c9-4a05-917e-ef8f04b23502	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-02	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
d1711d85-e1fc-44d1-9a23-cf9adfcd8505	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-07	0	24	24a381cc-a7a5-40f5-8f3d-5ddd19a79b5a	f
4de71079-a84d-461e-a4a2-16dc27bdbfc3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-02	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
7545fd60-0a6e-4c5a-a049-ec38eb297c1e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-02	0	24	43121b33-6e4f-4f3b-974c-6455d0a261c3	f
d3738800-c405-46b7-9f61-fd16c9592ed3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
01133ad2-d175-44b0-baab-9a36de8ae890	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-08	0	24	24a381cc-a7a5-40f5-8f3d-5ddd19a79b5a	f
18780e54-53d8-4820-b0fb-9be16f5bc10a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4347325c-e86c-4f57-9c7d-53f565969117	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
90b4e74e-f15e-46dd-b643-e8794dc9d952	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-02	0	24	dd6b39e1-8671-47c8-8e7d-12aec9c141ff	f
20403279-4799-4b34-ba20-3015471d2f4c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-02	0	24	62099af4-17dc-43f0-9690-2f9de337e6ba	f
fd55de6a-643a-49b3-acd5-d3c111ca07a6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-08	0	24	7a8131c1-b1ca-460f-aa1d-88c645c31560	f
32969bc8-4662-4cba-85e2-7a26e0beeacd	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-26	0	24	d3c4102e-f5e7-4eb0-b0f4-0988fc29552d	f
99daa45f-3d24-435d-848e-5d7450ac877d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-08	0	24	9e6642ab-39b5-4bcf-8759-6093dc114e0c	f
a58cbe20-06c8-4572-92d5-d7786508b78f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-02	0	24	62099af4-17dc-43f0-9690-2f9de337e6ba	f
ec9d0142-954e-4b67-a268-9a50293b4db1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-08	0	24	9e6642ab-39b5-4bcf-8759-6093dc114e0c	f
43f8bde3-c1c4-4bf9-bf3d-888b30cad11b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
621321b1-029c-462a-b344-6407d86560e5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
df23cc9f-b67f-4678-a16b-549e1e217018	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9ef95368-f2ce-4e7c-a139-4e6e41972d77	52b1e174-916c-45e3-81d4-f3596ed6ca8b	2019-07-26	0	24	d3c4102e-f5e7-4eb0-b0f4-0988fc29552d	f
09280887-b0ad-4b4a-a703-9415f2caf1f0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-26	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
c5e50076-5c2b-4c7f-94bc-b890c630180b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-25	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
e7668791-1494-4d49-ae14-22d742aa7324	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-25	0	24	10a2e436-ab68-4a45-97c7-f4a22bf06a1a	f
82f11a86-abe6-46a7-9464-727255715745	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-25	0	24	10a2e436-ab68-4a45-97c7-f4a22bf06a1a	f
0c4fc050-7a29-495c-a8f6-da8df6bfe309	2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	2019-07-26	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
f2c39b81-68db-4eec-8e49-0aec4da1744d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-15	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
28a9abc0-8728-4b1b-8794-62c532693bbc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-08	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
be237c4b-d8ee-41d5-a65a-658e980392e5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-08	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
aab2b5e0-fac8-4518-89e8-670ae3e08190	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-25	0	24	43121b33-6e4f-4f3b-974c-6455d0a261c3	f
1647ff51-fc27-418a-b415-16e9e4f13a8f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-09	0	24	9e6642ab-39b5-4bcf-8759-6093dc114e0c	f
af020528-b0f5-4022-b83d-ae0af335c3af	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
199f63a0-928a-4c64-97cb-188cb262a81e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-09	0	24	9e6642ab-39b5-4bcf-8759-6093dc114e0c	f
607c5c42-a2b4-485b-b41a-a5408fd5ad4a	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2020-02-09	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c1ab2975-88fb-4397-8669-bc526f9059ec	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-30	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
3029555c-2337-4c3c-877b-84fd1a22b277	a71258ea-db77-492d-a4c0-5b2458db460e	2020-03-20	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
d43ffa20-196e-4332-8dec-a3c308ebb79e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-28	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
fe33737f-171d-495d-becd-49019c7eafda	ce266fd6-ebe7-4d48-a1c5-d064ffe1f292	2020-03-20	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
1184969b-6d19-444c-9591-5b612ef2112e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-28	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
fde8e85c-dd16-449b-a4b3-6b2a11b054bb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-25	0	24	43121b33-6e4f-4f3b-974c-6455d0a261c3	f
f9b5b40b-1243-43af-83c6-127d59190eed	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-25	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
1ac77b32-009b-4819-b05d-81fe83b034eb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c018af82-3e0a-461d-b087-f5821744697d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c4d1c268-bbae-45de-86c7-c3dda4b83c4a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-20	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
ec4434da-4362-494a-96f4-0b30bf0df40e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-26	0	24	d3c4102e-f5e7-4eb0-b0f4-0988fc29552d	f
88859b9f-c0f3-4c2b-9e7a-03617d8c7011	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b388ab04-a612-400e-9f9e-c9402a7ad3e6	b99e1e6a-1648-4640-b0dc-94f42640c60d	2020-02-10	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
9b555776-410a-4e03-95ad-c18bfc536d5d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
eef7e14e-7e26-4124-ac5d-d054de2eb29f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-22	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
1d314a09-8d27-4eda-a53f-5ac34a29c405	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-26	0	24	e6e196ee-22e7-4730-92f4-be3baba89e42	f
b33e1936-8980-401b-a6f1-9b5aa43e0c00	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-10	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
5a22f41b-a659-4dca-b415-66a507c81885	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-27	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
0305dd62-f02d-42d7-9c00-8525af327abc	2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	2019-07-27	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
723b2f15-c5a6-4a0f-9023-05961d8d553e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-23	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
94e013d1-15f7-420f-b9cb-0de22a18866c	02633b99-91e5-4a8f-90ad-68d8511141e0	2020-03-24	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
fe365f18-4f03-4aab-932d-540762d08f12	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
4bd53ef4-441d-4256-98d4-19d565ac6be8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-10	0	24	88f66fef-c1b4-4966-b9e2-a4366d7931c0	f
c4a35075-7c18-4c5e-8fa6-71d3261c7cda	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-27	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7d4d9f9b-2e8a-4893-96ce-21fc47baa447	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-27	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
751ca261-f3c3-4bfd-9f1b-75b2fa081950	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-29	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
784efefc-62ac-41ca-9edb-c55532c546ed	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b7b1c6dd-5648-406f-89ef-3f2f6134c74b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-27	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8c6cf333-9394-4567-8fc0-39fc1aa45a9b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5c08fb2b-e981-4b4b-9995-323ae0fe9e45	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-06-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
1c9935ff-c166-438d-a1a2-b0e72b7db75a	76235d70-f972-4b5b-a5d0-5b454b2ecd98	2020-07-03	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
df3a108e-42af-4ed2-ab00-c5249f135a76	505dfc0d-0e7f-4303-be59-74a2a8fc2d3d	2020-07-03	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
57fceed7-412a-49ee-be5c-2de5a66cf9c5	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2020-07-04	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
d333df16-dd21-45e9-9971-d02ef89c9a58	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-27	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
cefb3fb8-469c-4088-aba7-fa2b0ea1105a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-07-05	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
01dc9a6a-102f-444c-a2ab-2c2132f129ea	2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	2019-10-26	0	24	43121b33-6e4f-4f3b-974c-6455d0a261c3	f
a8de5e8c-d5f7-4d73-9a81-2fbb14a0f8c8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-30	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
d22cb9c9-5e57-4984-adf1-4ed653406746	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
be0fe533-208d-44eb-957b-14b83dc6e986	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-13	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b7559e27-6aec-4e0d-b003-d55ea85b8d51	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-08	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
ba7c9693-09b0-408d-a7ea-1b2345967b80	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9a651e30-eec8-4ef2-8a52-46118c127177	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-10	0	24	88f66fef-c1b4-4966-b9e2-a4366d7931c0	f
a6ab9fde-75a9-46a9-923a-83ab993eb665	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-28	0	24	82a682f9-a8d2-4253-9928-a47fe81ea040	f
a72a273a-0226-42ce-abea-b121da3cdfae	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0e42fbe2-9530-4cfc-84c6-c4b33ac2a75c	24ae20e1-50c7-4f33-a41f-08530977511a	2020-07-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
cdbba40f-5a09-49ff-84a8-c5aa76dc1ad2	d9c6e4ca-5969-462a-9582-bb68f0e09a29	2020-07-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
a6b5562c-3bbc-439d-beae-e758127611b9	5e1c0929-ef35-4d9f-9f4b-cd24b3a66e74	2019-07-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
758bd999-b97e-457c-abdd-4fb30043d4c1	c6c0b44a-df6b-4663-801a-5e13d23e6d72	2019-07-28	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
2af219c6-7dbc-44d6-bba4-fe4908c0208b	1895b86c-fb3e-41fe-a5c8-0dc617f391aa	2019-07-29	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
20b847b2-ba5d-47e5-a207-b59a1f748b98	1895b86c-fb3e-41fe-a5c8-0dc617f391aa	2019-07-29	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9a602b81-1335-48ed-83f2-d86a377b970b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8237de87-b757-4e49-a711-e6710620d927	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-28	0	24	e64f9dac-2b8a-478f-ab48-193d739a6230	f
0dba8a6c-02c8-4dc5-9f3a-d29aeb878c38	2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	2019-12-20	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
66d17bf0-f047-46da-9bfe-ad446db4c0f4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-07-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
d870ebde-bd4a-41cb-9c82-0a51b6d15a52	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-07-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
be42662e-e80f-492f-8f37-c0d88f7a11eb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-26	0	24	e6e196ee-22e7-4730-92f4-be3baba89e42	f
a7da2511-df93-49b9-a3a1-2703ad5c1741	bca6e4a5-0cad-437b-b1a8-c7b58857b5cc	2020-07-25	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
0b43b4bc-b979-4291-b5b1-5b9ccaae3048	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-07-25	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
de769cd0-6195-4736-a713-9e52b983362c	63e8f037-9766-46d8-85c9-b2838393c953	2020-07-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a8117f13-c576-46a8-89af-26980f4b9b3d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-27	0	24	8a282a8f-82a6-4d65-b325-7e3ad1fa9cf8	f
8be2dc4b-072a-4bfd-8ff2-435e944d9735	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-27	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
e85149cb-382b-4953-94b4-4ad581cdd512	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
14382c1d-5f8e-40b3-a92b-68345f714814	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8f6b39d5-8ceb-482a-9e42-d827bf9cd9d2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9468c6cf-2e25-4a05-94a2-3e629d27eb6f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c88ef524-f6ba-4c24-b680-9cd73ee9ddc1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-31	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
129abb5b-e2be-4b92-b2c9-b1dae473e1e4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-31	0	24	c960d71b-0318-414c-ba2b-9ccc26f638c6	f
33929a20-d4bd-416a-9661-6cd2e5a20507	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-31	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4e055f54-5470-469e-ab12-3a569693f6de	caef805d-8d74-41f2-acf1-d0500f72b1bb	2019-09-28	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
0388e6d4-2f79-4216-a2f4-cfa2796dffed	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0977b001-6879-4927-9323-2826f2d90bbe	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6f362d72-e2bb-4748-b562-3ad2ba7ce675	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-31	0	24	7a8131c1-b1ca-460f-aa1d-88c645c31560	f
c0767017-de82-4718-a3d1-6bd347c3e361	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-14	0	24	7a8131c1-b1ca-460f-aa1d-88c645c31560	f
8f5a981b-c908-446d-aefd-28c0787886aa	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
474ac5e3-f8d8-4fdb-b73a-936c7efab44a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-31	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
566dd875-f7e3-47ed-91da-d58586c0811d	72613196-6819-4d69-8e6d-ce781ccd58db	2019-12-19	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
21a6b491-2f48-4849-b05c-80a98d5f06f8	81aef3ed-f05d-48f2-b7cf-aaebabca955c	2020-07-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
a9fff7d9-3258-42d7-b018-1b6d70433d95	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-07-26	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
2b2e0325-6cf7-4ede-ba39-0c80ce4fd387	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-07-26	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
491ba14c-9e73-4317-a505-d0f87d737a34	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-07-27	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
fb5d90d3-99e9-464d-bac1-8daaec63a250	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-07-29	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
4d6843cd-c30c-4afb-8e7c-e141c2271480	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3be3cf4e-0c07-4c7a-bf13-3d5dc1b32890	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-13	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
59c2b865-f0d5-49fe-9709-a1fdf1cb8f4d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-13	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
44fe4f46-1723-4ae2-8253-d94cf3f2e1b0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2021-02-08	0	24	5d0f526d-be55-4034-bfc6-410e38cf6c37	f
aa6fda35-51fd-4247-9da3-17e4316d429e	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-10-01	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
fd3a6f59-3a48-438d-81d5-3ecbbb87864e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-07-30	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
89d63dcb-a8af-4eff-a0b1-7a3932a906d5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-08-02	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
49efd674-dbbb-493d-a0a2-7544bfc4a1c3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-16	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
aa8eeee4-9ec9-4d4b-827d-6953d6679fd4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
e90fd712-0cf0-4386-8601-be6ac2a70fe2	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-30	0	24	aa728470-8c19-4d99-9a08-10f2b64d9ba2	f
2003519c-9808-45ce-91d0-fc9229f50fe3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-07-31	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
3fc90674-7661-46fb-bb3d-2b1b88815aa7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-30	0	24	43121b33-6e4f-4f3b-974c-6455d0a261c3	f
68e29c15-69fd-43d8-816a-bcb0bb0fe1f2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-30	0	24	aa728470-8c19-4d99-9a08-10f2b64d9ba2	f
7eff61e1-55e4-424e-9db1-fb46cb120bfa	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-30	0	24	43121b33-6e4f-4f3b-974c-6455d0a261c3	f
0a37c6c9-75fa-42d2-8373-8cd81a25e6b0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
068fd7c1-c281-4bad-b4a6-d1bd404a3684	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-08-01	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
5c4b0ff0-a69d-4e9e-9717-ea0521d77663	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-08-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
1e61c45c-4196-42fc-9a38-7d7de8a64947	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-08-07	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
5a97df19-8305-409f-bce2-5c2951b3857d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-02	0	24	43121b33-6e4f-4f3b-974c-6455d0a261c3	f
169053ef-965e-41fa-8392-eb00de95d489	72613196-6819-4d69-8e6d-ce781ccd58db	2019-10-04	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c11d3e4c-29af-48ea-9222-843685c60103	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
302559a4-537d-4791-a745-a12a5e01a2f8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-17	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4910388c-8f94-4ed4-b5f0-476f88b128e7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-31	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
b59fc92f-cfc4-4bfc-9057-0790cea58381	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-17	0	24	24a381cc-a7a5-40f5-8f3d-5ddd19a79b5a	f
256a2049-b146-4e7e-8b24-12c5833ac0f6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b9d3a4ac-9eae-4c82-ac7d-f6a78386dcac	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
2e00ebec-dd4a-4b60-8826-52c59c869ba5	2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	2019-12-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
32d48dfc-a9a3-458e-8baf-7174b3b6d964	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-02	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
e1827e87-ce71-43a4-afc6-3adeeaf664ce	24ae20e1-50c7-4f33-a41f-08530977511a	2019-12-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
140a2acb-94f6-4477-bf4a-6964ef78d597	feba6c1f-a359-4162-8471-4df5994d4d4b	2019-12-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
1f1cb187-5357-481d-8265-dacdc095ff7c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
30bef44a-5899-4017-8493-b11276f39928	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-17	0	24	24a381cc-a7a5-40f5-8f3d-5ddd19a79b5a	f
5a18a36b-01da-4a92-84a0-6f3b35258fcd	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
2cd5ad1d-2552-4654-85e2-338733c36f84	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
23affab1-4f9d-4f4a-b25f-104ce2555ba5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-20	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
518baaca-0082-4d21-8655-a17d384c3b67	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-18	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
535643ae-4466-4d44-a954-c2df39345cd8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6badf9eb-11d4-4613-82fc-bb85b7bd86e9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-02	0	24	43121b33-6e4f-4f3b-974c-6455d0a261c3	f
78d604aa-4686-4eeb-bf38-5400583f3083	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-02	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
11d79bb7-56cd-47df-bb82-d14aa147c3e5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-21	0	24	50ff5482-287e-40d6-bf27-d383dc105dc1	f
3660a176-f8ac-450f-b24c-77230131c360	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-21	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
970f47de-335d-42d0-8e68-c64d1c9464f4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
4c1d61e7-8ecc-4fb7-a3dd-21b665a170a6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-21	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
a462b2de-fcb0-4547-a37f-276e2e6650c8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-29	0	24	4dff09ea-616d-49cd-aef6-e7292675243d	f
22365443-ad40-4925-9787-57ea3bb5f025	ed53e116-0d54-4c98-a66d-3e3b0b4c864d	2019-07-30	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
1bd01582-4ebb-47b2-ac20-b4203ce8a115	1b052437-ffe8-40ef-a40b-8fd9b306e0f8	2019-10-03	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
26f803cf-67a2-4aac-a219-65dcdcaee251	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2021-02-20	0	24	053069da-e32e-4032-b232-db15d9cd9aac	f
cf617899-ea68-4e0c-a691-255857e2c0e7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-21	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
bfeca383-18d6-4155-bcef-3476d39a0971	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-21	0	24	50ff5482-287e-40d6-bf27-d383dc105dc1	f
7f82ff47-5651-4bf6-a072-64fb8191db77	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3a972b1d-b3b2-4111-9146-b2a0583a5e66	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-21	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
22211527-9b59-45b6-8665-bc5719a3ffd9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-07	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
48ff91f7-ff64-46fc-82fe-adeb198d06b1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-05	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
6bef9305-bf63-4642-b628-d632acdf679a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-25	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
a5a09400-9d84-43f2-9da3-8c971dff05c7	63e8f037-9766-46d8-85c9-b2838393c953	2020-01-18	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c9f1262f-304a-4769-9868-d8412e7732fb	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-07-31	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
c949b086-1c4a-4d63-b11c-e0f3d6e32941	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-18	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
915039a4-1518-4f1b-9148-6a399e554149	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-22	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
d9d3f706-ffac-4f04-bc63-7f31da22c89b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-22	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
cd597b57-b468-4e28-bf69-21bae066bb81	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ab35992e-3f99-4b51-a9fa-401c8a52e56d	ce266fd6-ebe7-4d48-a1c5-d064ffe1f292	2019-11-28	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
9514ff98-8c10-4e06-b3e2-570724453a88	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-29	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
de6efb1f-dfbf-4fcf-a5da-14b736d276f4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-07-31	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
b1320d7c-f8bc-4a2d-91d4-d3e9011cb850	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-07-31	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
79940ed8-b286-4bb8-84a8-2672fb5189a9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-05	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
65243191-af43-4819-a50a-b1c87d06e48f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
65bead56-b815-4246-a88d-0a6c210b10bc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-22	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
f9c3b2c8-c526-4970-9387-4f9625d3b14d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5fb3f6fe-a43e-4ad3-8c82-8bbcf9b7d0ac	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
21fe1893-ad73-4915-851a-e6243e6bafb6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-07	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
6ee8990c-ec3a-4c06-9723-d751ead01010	a71258ea-db77-492d-a4c0-5b2458db460e	2019-10-13	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
e56e03d7-6605-47e4-8326-81963212e66e	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-10-14	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
dc7a00e6-d59d-49f7-be00-66272c7c3995	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-29	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
c876b2d1-677f-4b06-88ee-18d587470c55	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
13a04715-be63-4d2a-bf41-f3d3a882d01c	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-12-26	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4a5a76bf-2577-4d7d-bcbe-845540cfc08d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
73325550-784e-4f69-b35b-51350799e9c9	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-12-23	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
1c8c40be-207d-45e8-8c3a-a0f03a53b066	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-22	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
3bf0e408-17dd-4b97-bfc4-cb4d51af1dca	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-23	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
2c813f64-6ee8-4176-9402-3947325cd6a6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-23	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
c0990923-121e-4c7f-8b71-0c56fbd6c2b1	2861019e-efa7-4c8f-a3ed-5b1d6cf61a1d	2020-08-08	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
303a60f0-6a4e-45d4-b179-13573833cc1f	52b1e174-916c-45e3-81d4-f3596ed6ca8b	2020-08-08	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4c3d40fb-b760-4770-989c-3b096643acc3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-08-10	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
791f9d0a-cadd-4c9c-b0ea-3748c0e8a182	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-23	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
ba18c1eb-fe87-4d06-a4e9-4d896fd1837e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-08-16	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
0454c894-04d9-4933-8acb-1e5eac04abec	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-08-11	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
23e63887-6d3d-4606-afc7-164790bfa501	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-10-26	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
9a86b62c-0879-44bb-a18a-bb388464fa14	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-10-26	0	24	e6e196ee-22e7-4730-92f4-be3baba89e42	f
12725f11-ee25-49a5-ad5a-52659756f145	5e1c0929-ef35-4d9f-9f4b-cd24b3a66e74	2019-12-24	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8d039bb7-b6e2-4613-b2ee-ca0beac012e8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-24	0	24	053069da-e32e-4032-b232-db15d9cd9aac	f
7bd0c7c7-dfdd-4a69-9825-5cc1acd5593f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-24	0	24	ea312b20-e0cb-428b-aa0b-36999416a68f	f
4359067e-0655-4859-9ed8-0e7575698fa4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-08-16	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
bdb0dcab-a076-4697-8c35-a9650e3139cc	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-24	0	24	19fa01d6-8b79-4cda-bea1-b0f3f7e98630	f
94840bff-254f-4d53-8e76-3cc3c5a3f1d9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-24	0	24	19fa01d6-8b79-4cda-bea1-b0f3f7e98630	f
cb96f679-a507-48e0-8203-a836a1d03604	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-24	0	24	5bdb42b2-d743-41fd-a0fc-020e28a0977f	f
b24e438d-833b-40ac-bd1a-1176936bb37d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-08-14	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
6e924657-4d93-4d11-89f0-92afd73f4cb3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
e83ca933-d7bd-40b0-94ce-1410180693a3	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-08-14	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
67ba3584-4bcd-41bc-9584-f0118b099a96	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-29	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9194d40d-9dc1-42ca-b8c6-56f7d7e4f722	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-24	0	24	053069da-e32e-4032-b232-db15d9cd9aac	f
b6e4bfe0-04c7-4556-8240-c03ce62e61b1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bf6a814c-7f68-47e0-8db4-5ea2d0230ad7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-12	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
30ece27c-3280-4d14-b195-580fa2595222	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-12	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
d31ac597-ce9d-4edb-87a8-c45936b209cd	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-29	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
cddc0d1d-aec6-4f38-9497-f3d87b48856c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
fa05d683-65cf-4164-90df-271e5d0f5119	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-24	0	24	ea312b20-e0cb-428b-aa0b-36999416a68f	f
d7211c93-e4f9-474d-bb2a-32f2bed07ea4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
e2f2d52d-4ffb-4a4c-9b96-af364d2dbb98	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-15	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
1be5da86-89d1-448f-b1d1-86d7268a43bc	2021e0d6-9c32-4b81-8c6e-a3b386ad040b	2019-08-01	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
d534aec9-c074-49c9-acc4-e66b557909fa	52090ce7-d56d-48ff-ae9c-f3c47af0b829	2019-08-01	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
834d8c5d-7ca0-4029-b16b-631d50831612	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-24	0	24	5bdb42b2-d743-41fd-a0fc-020e28a0977f	f
a888dbf5-8795-4d8b-ad9a-12be829b4297	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
f2b1d46f-0136-47d9-9685-ac4a5e9e7629	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-30	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
a12853d9-efd3-45e2-8659-cd954302249b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-30	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b186259c-799e-42c0-8637-3cb539a9bfcb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-16	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
ce5110b8-ffd4-4baa-bb24-d294fe6ee7ec	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-24	0	24	72a311e0-b2b5-481f-aa98-0130d1dee157	f
82b72e09-18bc-4e29-9909-da7b3f1d6038	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-16	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4a678758-07f5-4f28-befd-2fd89f44c1e0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-30	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
38dee7da-4b4b-4c82-a1f0-8f4ecaefeb6e	0ea3ce20-7bab-4b58-89d1-b18552b58ae4	2019-10-17	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
0a022320-ea51-4a66-9247-de9f0747bd0e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-18	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
e82964c0-698d-4ba8-8d9e-d77f8acd019d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-02	0	24	d7c22c08-80ed-4efd-a07e-e45f51d85822	f
d93a08d7-3971-47a6-903f-7eeac73b007e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-02	0	24	43121b33-6e4f-4f3b-974c-6455d0a261c3	f
dddde494-7ee6-442f-8b2e-5745b3b0ec6f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-02	0	24	e6e196ee-22e7-4730-92f4-be3baba89e42	f
04ca26b8-1ddd-4b43-b4fc-fa1bb0756be7	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
eb74dc1a-3dc2-4297-aff0-c72f65abe6d5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-08-20	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
6c875c3f-e7b5-4e43-8f3e-81f7c97e6f42	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-29	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
04243f9a-1e11-44cb-a3e2-435e999b4f5b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-02	0	24	dbfe61cc-3d34-4af5-aea4-055406c09b45	f
3b89937c-ef9c-45da-87e0-e43013cfab24	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-11-30	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
519efb25-1b87-4a32-bf19-59d566941281	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
76a76670-7773-43bd-9b76-2cd74eb1fd3d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-08-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
6132f71a-fae0-4aee-9dca-d9aebcea8c37	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-29	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
04276d46-4b70-4a1e-a138-00b19dc74fa3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-19	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
b54dc001-6118-4813-8b84-528f86748411	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-01	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
c5bcd989-a033-480c-88fa-480cdb08c118	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-02	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
8c2d8556-1934-4027-9f21-126336fef203	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-02	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
dab61056-fcdb-45d0-a561-50d45f76641f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-19	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
2eece20f-2dfb-4103-8fb2-9cbbdbfcb4fa	ce266fd6-ebe7-4d48-a1c5-d064ffe1f292	2020-08-22	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
2ba5108a-62c6-4cf3-b028-2302b83a53e9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-08-23	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f33bbc1e-9338-4ed3-acce-fa2d3cb5b72c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-29	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4cc6c8b8-24b8-48a6-ae8f-2ca471483300	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-29	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
aed51822-c82c-4f52-a35a-3c38b1ec39f2	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-08-24	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
7932c221-b029-4002-8076-2efdfa9ce212	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-18	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
303232f8-c942-43b6-9c84-91927cee3032	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-19	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3ffd20c8-4845-43c4-9036-ed591a4c2090	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-02	0	24	dbfe61cc-3d34-4af5-aea4-055406c09b45	f
20eaff34-631a-4f42-bc27-8030ec964f99	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-02	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
c861b7da-8f02-463d-851a-87848bdbf2f9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-19	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
bc7a21bb-0083-4aa9-9bfa-2a5d276274f4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7d6a6b71-3eea-4410-9632-2f9b3838ea87	1b052437-ffe8-40ef-a40b-8fd9b306e0f8	2020-08-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
14ffe251-c9ef-4dd8-a296-77bf3fbd8921	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0ec78ffc-1be8-4818-9abd-b23ef43cb652	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2020-08-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3e755433-a465-44bf-b27b-fd58366458af	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-20	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
d1295b61-4aaa-4fce-9df4-04ca1a9fdf22	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-01	0	24	aeb73b0b-22c8-4188-9504-1236b19e11e4	f
a75efb74-7f25-4178-a5b5-813cd2225835	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-20	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c3bdd906-a6f4-4a0f-b1c1-e8e0717d9eb8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
950955fd-2dc3-4103-8c07-3bfc37f1732b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-30	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
9976479b-32ef-41e6-84e5-2c926ab48301	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-04	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
643f4b67-70be-448b-b776-1e695c898368	1895b86c-fb3e-41fe-a5c8-0dc617f391aa	2019-08-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f826414e-654d-4a7c-abfc-160f37bb0d34	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d2de0b21-592a-4947-a257-50eec877b261	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-04	0	24	dbfe61cc-3d34-4af5-aea4-055406c09b45	f
6a20ffcf-da93-47bd-a46c-55233d5c3e81	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-19	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
26451a81-13f5-4ff9-9d98-bc031715f1c0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
bd305131-12c0-41a5-80a3-666f7b0e9cc9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-03	0	24	30acec88-4b11-483a-afd6-da3f1c8c0620	f
2ec18037-cad7-4768-af92-41172406cfef	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-03	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
530ac14e-c9dc-4d91-881a-8302bc35644d	bca6e4a5-0cad-437b-b1a8-c7b58857b5cc	2020-08-28	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
24364177-d362-4f93-9d17-8d9bb1be3ef6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-19	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
46a7e19f-52cc-425b-aee7-dfb9d1138d6c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-04	0	24	aa728470-8c19-4d99-9a08-10f2b64d9ba2	f
623b6b02-5c7b-4880-a80e-cda364038eab	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2020-08-28	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
29e2da2e-fd9d-4160-a17c-24317a8f5406	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-11-30	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6629a185-19ef-4fb1-9ecb-6ea888aab273	5e1c0929-ef35-4d9f-9f4b-cd24b3a66e74	2019-10-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
e7559d98-b637-4140-bcf9-a99310f4e669	06cee4ec-e321-4092-8d7e-976de2f31216	2019-10-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
fed0d9e8-8eab-4186-8345-13d088be0553	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-01	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
169b9235-0d76-4c90-8183-4a67bf350568	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-01	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
f3183838-b3a9-407e-8064-0193be2bc9ac	63e8f037-9766-46d8-85c9-b2838393c953	2019-10-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
224c78a7-5c0c-42af-a471-8cd38dd87b0c	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-10-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
cbd27fe2-0fb8-4f19-962e-323e96d8e09d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-20	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
de8d09f4-ba98-4ccf-9e79-bae9a34fa54a	feba6c1f-a359-4162-8471-4df5994d4d4b	2019-08-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
162d66c7-2cd8-4c92-8b22-e51af696bb81	4d03281a-2e2c-4280-bd97-3136122fe750	2019-08-04	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
5d4b644c-4ac8-480a-b250-d4ef371fef72	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-20	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
38d79646-9537-48e4-a34c-b06d45e05b53	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-01	0	24	a5b73185-7441-4cab-9531-e5910947fd6c	f
7a907ae9-c4e4-4617-a301-911c5dde4277	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-09-02	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
7233c378-95e7-4b00-92d9-67d909f21c5c	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2020-09-02	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8cabf5f6-8afa-43d9-9d76-f1fd46efa9b9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0b2d6f49-278b-4100-bbe3-ec5ace16abac	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-02	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
5f01cfd1-a15b-4a65-b0a3-88607fa0995e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-02	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
5c4565ba-55f2-4ac3-a965-adeaa246997d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-02	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
50cd1afd-f28c-4bf3-af38-f4bf15baf11c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-20	0	24	c960d71b-0318-414c-ba2b-9ccc26f638c6	f
95f9d545-1695-4330-8693-bde39d482daa	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3bfbd54c-45c9-4911-b954-c1b478330123	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-20	0	24	c960d71b-0318-414c-ba2b-9ccc26f638c6	f
a2bc80ae-80c4-4d93-82d5-8880aab92b0d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-01	0	24	a5b73185-7441-4cab-9531-e5910947fd6c	f
c32cfbe9-e083-48c0-bbee-6e9d45dfed75	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-01	0	24	aeb73b0b-22c8-4188-9504-1236b19e11e4	f
91e31ab3-c4a0-484c-a411-a8936d3b3982	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-09-03	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
528fb9c6-1da6-4b33-a4a2-0a65dfc79dec	384f44b8-29bb-404f-898e-a4919823f91b	2020-09-04	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f5aa0ef8-8aa1-494b-af96-79c3b099c1d2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-01	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
dc2ddb80-b95e-41c5-ab1b-ba06df661e51	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
5dadc22b-3da4-4bae-b84c-67d89ab92ba3	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-08-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
be55607e-4f86-4a5f-8271-c50617eddb2f	1895b86c-fb3e-41fe-a5c8-0dc617f391aa	2019-08-05	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
1ebc0a1e-f5aa-4668-b9df-de17cca2a8a9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-05	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ca401005-019b-4282-8f2a-c71f818b8835	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-05	0	24	24a381cc-a7a5-40f5-8f3d-5ddd19a79b5a	f
fae1dfde-a2a5-4a0a-bb65-545ecdd761d1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-05	0	24	24a381cc-a7a5-40f5-8f3d-5ddd19a79b5a	f
d0e8f93e-eb38-4ed6-b18b-453a96f62ded	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-05	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
db8617aa-5724-48fa-bfe6-2b7ce44c3120	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
7e6047c9-2dd2-4f3c-9aa4-959db90d3466	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
86e5a8aa-8665-4a39-ad90-1737e8703e8b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-02	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
dc833dad-aa11-406e-9c0c-2dd1a7bac0c3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-02	0	24	a3795153-89b9-468d-8cd0-5c094a04622e	f
bbbef17e-32dc-46ff-8d70-96b2fc0ffa01	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-05	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
78953225-f3f6-463e-a879-b06a37c47574	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
20a537fb-66ae-4327-b39b-4007ce549b6e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-02	0	24	288b82e6-7e91-46c0-b7d9-7cf69f7b1324	f
d4614de2-2065-42ba-969c-eb4fb33d5611	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-10-22	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
8218a33b-34fa-4182-a5cb-e0f083d80c55	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-22	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
25eaa11f-e23d-44d8-987a-5645c9edf498	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-10-26	0	24	e6e196ee-22e7-4730-92f4-be3baba89e42	f
b22230cc-38f4-4f87-8db2-8c8b3578ff05	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-02	0	24	288b82e6-7e91-46c0-b7d9-7cf69f7b1324	f
15073da1-49a0-45f2-b9e1-a65ca5359458	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-02	0	24	e551c73b-0e3b-4a8c-a38c-5d92766b114b	f
338f563f-1615-4940-be62-80f7d173413e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-03-22	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
acfb44a3-25f7-4bdb-a71a-37d7c4b5dc4b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-03-23	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
7b8057dd-7fdc-4af4-b06b-de5679f5ca1b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-09-07	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
2fd42c29-7f78-4d5f-8d36-fe3163b2f185	2b5583eb-23fe-4b86-99d3-970a30beb166	2019-08-06	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
88ccf04f-c039-4417-9581-34a60f2bdb67	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
03bd2290-afe7-41ed-9bdc-3a32419584a9	52090ce7-d56d-48ff-ae9c-f3c47af0b829	2019-08-07	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
3e24fbf0-1f9d-41c2-a1b8-76e6860addfb	a71258ea-db77-492d-a4c0-5b2458db460e	2020-01-22	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
5f25cfd2-3cdb-43dc-8d5d-685ec625d705	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-07	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
975f6152-2ad8-42fc-8192-813c0615e007	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-09-05	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f663117b-bec7-4dc4-b50c-c7f0927f6061	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-09-05	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
7388068e-6500-4701-8b5c-f58fcd29ada0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-09-07	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
9c84f918-be37-4efc-b5b3-c2acb9eda44a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-09-15	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f9c105ac-998a-4612-a67d-4bdc964b9c3b	49d25125-63e5-46ca-bddc-f5a7ab8ead0d	2020-09-15	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f67ab968-1cea-451a-af11-3f63f3478b82	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-07	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
49b33099-9804-4d8e-91de-4ec72e63ca9b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-09-17	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
8854f998-0d53-4a15-a8d6-05a2ab884a19	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-09-18	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
b9ea37d7-9418-426a-bc92-a8bdab77859e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-09-21	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
7d1cc38f-1769-496e-8896-6dcc7bd713b2	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-09-21	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
7f6f204c-a5b9-4ed7-82ad-fc6a8778b074	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-08	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
08b42b3f-445e-43a8-8abe-9129ba211271	992513b6-13f7-4dcb-8471-84972522feb3	2020-09-22	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
65b0ca26-d239-4327-98d1-d9d90d27d84d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-08	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
02e2ccca-ce23-4997-945c-bffc03d338e3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-09-23	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
ddcd45db-b33e-4c1b-b8ef-2684916149ae	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-09-25	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
cbbae84d-69db-47de-95ff-428329132852	24ae20e1-50c7-4f33-a41f-08530977511a	2020-09-26	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
6896a10b-4d02-4c56-bbc0-68517d8864a5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-09-24	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
ad7db55e-13a2-44dd-acab-52b075e8c8ac	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-09-24	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
75ed77c9-b17a-46e0-a45f-d7691cc0fd1a	52090ce7-d56d-48ff-ae9c-f3c47af0b829	2019-08-08	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
78f5280f-fb3f-4916-9fda-70866b603b36	384f44b8-29bb-404f-898e-a4919823f91b	2020-09-30	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
9c326286-b1ee-4594-8bad-767f8d9d8dbd	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-09	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
e32c1a93-f241-4aaf-ace1-13bcd4393808	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-08-09	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
ad89b11e-4e5b-42c6-8449-66697e74ec9c	63e8f037-9766-46d8-85c9-b2838393c953	2020-09-29	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
5c0b31a7-9226-4d50-9e66-3f578c7b0d23	505dfc0d-0e7f-4303-be59-74a2a8fc2d3d	2020-09-29	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
736deefd-c1e0-4cd0-b8f1-33fec8ca52cb	55d1ef9e-7db5-4a83-bbb2-fc59381cc2e4	2020-09-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
fd113286-b77a-4891-957a-d5515c8cf3c0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-10-05	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f6748edc-8342-4510-909a-9962d970e82c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-10-05	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
3c19de8b-61ae-4974-94e9-efd3559e8450	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
99144885-6f67-45f7-97dd-06dc38a756e4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-10-08	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
bc632384-0550-4a31-8698-1e56e81d7576	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-10-12	0	24	9a65c9ce-f3e0-4865-a4af-562a07a6349e	f
1ba301c3-7891-40d1-96e2-0c4d6fa59e86	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-10-12	0	24	9a65c9ce-f3e0-4865-a4af-562a07a6349e	f
84418052-8a8e-4b9a-b413-31272d40b016	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3d3ca6e9-6f2d-49f8-9b26-277c10b3c41e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-09	0	24	f6cc6ba7-f5fd-4d85-b472-6c5f15abbc65	f
c7fde7f0-2930-4da5-a395-7626539c3bb4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-09	0	24	f6cc6ba7-f5fd-4d85-b472-6c5f15abbc65	f
7d493e13-6afc-4204-88ad-deca203dc718	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-10-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9a863cfe-81a3-4834-bdcf-35ff0082b83b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-10-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c7e2188d-1c48-4b1c-8eb4-2627d8e68550	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-10	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
a48785f6-effd-4b5d-84a2-ccd76b9dbea0	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-10-12	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
a5459374-7892-4091-983a-439e2867800e	1daa5d71-ac7b-4bc8-aeff-1f3ef743af01	2020-10-20	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
0f24a280-94d8-499f-b3b6-b69970105136	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2020-10-20	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
6385e274-3d9e-4ff6-aab9-81c6801208b7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-10-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4a21a102-88b9-41ce-b15f-5717eb54d214	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2020-10-26	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
2d2ac7c2-a97a-4e7f-b1c8-ab28d9fccc59	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-10-26	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
2420c4c8-9dd0-4f7a-91a3-0c8fc0be2522	07c2fb26-38a9-45a4-a923-338f1b4eef35	2019-08-10	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
e49baf52-5b90-4bbf-ab3e-a80a391c2f21	55654d0f-1853-4a92-836a-6c34015daa23	2019-08-10	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c25c9140-2a7a-45d2-ba55-4378ed2fb8e2	07c2fb26-38a9-45a4-a923-338f1b4eef35	2020-01-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ba3906b6-19c9-452f-aea0-1c4455c795a9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-10	0	24	f5fceccf-8230-48fb-a4cd-643ba7f5110a	f
d67fb2f2-fa63-4688-8321-6a4b09f67b36	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
62954813-afd9-47b2-9178-d86d1f4c3c26	1895b86c-fb3e-41fe-a5c8-0dc617f391aa	2020-01-23	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
96f26ecb-7911-4f5f-a299-dccea71faea5	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2020-10-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
596e8351-4dee-49ff-a4b4-d694e7cb5ce8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-10	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
700dcc1b-e3bb-4d69-bb08-83f34346daed	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-10	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
704d7d6b-ab76-4dcf-96ad-32416969f86a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-10-29	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
dfd7d93b-66ac-478e-9d3a-c1f0c54f254d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-10-29	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
87b22e3e-99cf-429c-9693-02ca5d4aa83b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-10	0	24	f5fceccf-8230-48fb-a4cd-643ba7f5110a	f
ce7f7716-e335-4a6b-883c-f3842685c94a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3d784b3c-3ce6-4ea6-b8f2-7894c3ef11aa	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-10-28	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
19fa5b41-09df-4bbf-9b49-1d9a53b1ef31	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-11	0	24	f5fceccf-8230-48fb-a4cd-643ba7f5110a	f
1e5bac65-1600-46c3-8656-680cc236fc1c	72613196-6819-4d69-8e6d-ce781ccd58db	2019-08-11	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
56634887-f1d6-4f78-bbb8-ad464dc13d89	63e8f037-9766-46d8-85c9-b2838393c953	2019-08-11	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
6d137f53-4278-40d0-9173-07cfdd5a513a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-11	0	24	f5fceccf-8230-48fb-a4cd-643ba7f5110a	f
4bd85f10-f303-4a81-bab8-dcf86aeeed9f	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-10-30	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f3a0b828-a433-43e1-9ff1-d4eaed569696	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-10-30	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
2f3f9c3d-71ff-4034-837a-82267b57a612	63e8f037-9766-46d8-85c9-b2838393c953	2020-11-01	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
0cd7b54a-b655-4dbf-82f1-061e06055485	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-11-01	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
47e3e07b-ba4a-4965-993b-fc43a7214476	63e8f037-9766-46d8-85c9-b2838393c953	2020-11-03	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
e3b990e6-ec69-4a49-a084-62177acf34d8	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2020-11-03	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
224406eb-bddf-4111-83c5-c7cc73639f04	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-11-04	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
9b9de1a6-e4d4-4437-85c7-71da804e0293	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-11-06	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
54cabc61-3609-4656-b564-d2fcb40cfe5b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-11-06	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
311b616e-847f-4bcb-b3f9-ff7d59254856	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-11-04	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
ee46ea73-d7f3-4f1d-a132-bc2c900a2e2a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
cb1d44eb-bb1a-45e2-8428-f3e649b8219b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4e692892-388e-4d08-938d-7ba8db2b891f	4f5e6758-8b47-4e4a-8214-15a4c3486a94	2019-12-05	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
8bf7d9c3-8659-42d4-b744-216bad985668	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
774823f7-3552-4f7b-8a0e-3dcf10c095da	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-06	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
7dbfb002-942e-427f-8ef9-f8c71b1b6abf	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-06	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
0770c16b-f619-4437-a5fd-be006891cfcf	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2020-11-09	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
f380a7cc-3583-4ca4-ba7e-0ce691c11261	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-12	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
ff4accc0-8363-4a6b-a4a1-5e158a16195c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-12	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c4ac25ff-fe1e-4fdb-aa9a-51c4f11cce12	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-11-10	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f6af4854-6e42-4958-8e98-082e1b9c11a7	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-11-11	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4c68e19e-e4d8-4dd4-9b00-ca367f9e023f	2b5583eb-23fe-4b86-99d3-970a30beb166	2020-11-11	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c10c23de-87d1-4344-9063-76c02cb7545e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3a642910-6df2-4ace-abee-5f8ea349b490	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f3c7bc40-62d4-402e-a4da-25c8b306a7f1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-11-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f64ac205-0bc2-488e-ac05-6c6ab0906566	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-11-12	0	24	aeb73b0b-22c8-4188-9504-1236b19e11e4	f
fc3554d6-093e-47a0-8438-08eef8746850	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-11-12	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
9ab92ea9-b993-473f-9baa-6d723c7af9d6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-11-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
eece1a96-f66b-4759-b23a-dcefd8cd785b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-11-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c80f911f-8bb4-4ff0-8c07-e9a16e87d39c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-11-25	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
640a2c73-1390-4c8f-b859-eed536129bde	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-05	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
e60ece1a-1c4d-4e89-97e7-89ba8a83679c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-11-25	0	24	6ff84530-5ae7-4fcd-bfc7-07b1e51655e8	f
f1679fc4-9b6e-4d34-a6f7-3ef50f847892	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-11-26	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
05e53789-b2e4-42ea-a884-c0a42c9ea3a3	63e8f037-9766-46d8-85c9-b2838393c953	2020-11-26	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
9e05e486-7b81-483f-af10-11d33fdc5c1e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-11-28	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
1ce645f2-aa0e-49a7-b780-8df913883842	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2020-11-28	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
36587c6e-6409-4bab-8e43-7f1095d1ed8c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-12-07	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
29bd4431-dd3d-4557-bd97-522c6e7f34ef	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
cd1759d9-b3e6-4f02-b301-4f866a60ea9c	6dfca435-536a-4fd7-b6ff-f2a163ac2ded	2020-12-08	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
e5603dc2-f241-4f2e-bd8b-cb10cbee651e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-06	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
3d12ed79-1714-43f2-be74-dfa26ef1a567	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-13	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
50bdd7c2-f8e4-47ee-a777-7ea0a5c457bc	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-24	0	24	86be41cf-ef60-4388-91a8-31cc07c395ed	f
a3e62891-4df9-4f2d-ba93-082a093ff269	505dfc0d-0e7f-4303-be59-74a2a8fc2d3d	2019-12-05	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
968b64e2-ca56-40a5-9947-65ba54bd76a9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-12-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
74b2ba8c-6f28-4ef4-a8ac-24486b6105bf	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-12-23	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
19146043-c3fe-499a-84f9-adfccdb90719	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-12-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0de8ed49-49bb-4c5c-a712-2de591ee2d73	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-12-23	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
9b10d7f6-0dde-4bcc-acaf-1e737486194b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-12-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b848df45-0d92-4068-9599-2fe97f65b97a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-12-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
0fd8c249-413a-4e3f-84b7-6b49732023ed	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-14	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
8057ccaa-4c8d-4987-84cb-3e5f0a9cb273	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-06	0	24	befdd994-a383-472a-b6bd-ced524d45fdd	f
8d15cf27-89a1-4dba-b60e-455bf32e8d51	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-08-14	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
5b7185a3-d025-4764-ae34-a1b5b7f7f329	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
4c52b876-77f0-4d8c-997a-d758ed06dac9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c5181ea9-317c-4de6-ad1d-67bd32d1291a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-14	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d180d397-8275-4c21-a457-83169d4d9158	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-24	0	24	86be41cf-ef60-4388-91a8-31cc07c395ed	f
19656888-214c-4654-9f5c-34d4ddc66064	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-06	0	24	befdd994-a383-472a-b6bd-ced524d45fdd	f
b9696cbb-527a-4536-ad24-3b158228295e	52090ce7-d56d-48ff-ae9c-f3c47af0b829	2019-08-15	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
08e4e9c8-2a89-42da-93d5-b2da0d35aad6	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-08-15	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
77edb112-0303-4ff8-ab2d-f526636712b2	d9c6e4ca-5969-462a-9582-bb68f0e09a29	2019-08-15	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
3a4bad3e-01b6-4d2f-b955-529f2ee8ca31	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-16	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c2199f15-c3cd-4e4e-8a1b-69d9055b197c	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-15	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
2ab56add-0610-4b93-9668-e2b840bc9332	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-07	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
189b7014-8382-409f-b701-2552fd4a29af	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-07	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
a80362a5-957c-4e43-ae93-b252d574d34a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b27cb19d-34be-4895-a505-47fed9c193b9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-07	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
5016d6ef-5db5-4260-b2f0-ad45f31bb893	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-17	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7ba3faec-a657-44b5-afcc-937ba83f5572	992513b6-13f7-4dcb-8471-84972522feb3	2019-08-16	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a813ab88-7b04-40e7-b18a-bb9e252cf15a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-16	0	24	f5fceccf-8230-48fb-a4cd-643ba7f5110a	f
637344c6-d350-4b9b-b81e-e2d790af6fee	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
932680c3-0b8e-4f12-b7f3-f51621d62474	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-07	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
c6701071-e45e-48d8-8359-7b794f937089	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-07	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
cbdec083-5879-400d-b15e-46818c7f3194	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2019-12-08	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
37f6e296-9065-41c3-b99a-dd13cfc55bb0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-16	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
d0f76fae-6814-4b06-b76e-b87e58bf4286	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c95068f8-ecf0-4cfa-b4f9-a20fc6285af8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
c1c8ea00-7d6b-40cc-93d6-e1341d814b0b	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-03	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
0b8928df-5e8d-49f0-bcb6-37c2530532d5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-17	0	24	f5fceccf-8230-48fb-a4cd-643ba7f5110a	f
3071902f-f7d5-424e-93c1-9552692531a9	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-17	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
0f05f9cd-2237-4b20-8505-e0581f3000d9	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-17	0	24	f5fceccf-8230-48fb-a4cd-643ba7f5110a	f
29fa8630-3f59-43f0-b898-0da69d1831fb	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-17	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
06c439a7-1ba4-4fe0-93ae-9325c3486dfa	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-17	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
36166e4e-0556-4788-9e4b-adcb2c35e97a	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-29	0	24	d3c4102e-f5e7-4eb0-b0f4-0988fc29552d	f
3403918c-e64b-4bb1-9647-598e85f17a23	34aa93ea-c9b9-4330-8a13-3522dd1d9238	2019-08-18	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d9a87de3-bc11-4bad-93cf-f8372f404b6e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-17	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
6b21af80-b09f-4fd2-aa4a-d2e9bd46b1fb	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-03	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f7406d59-a247-436b-abba-2751af71017e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-18	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c6dd6446-0dca-4025-8a5d-e2dccde4a0be	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
d1b4561e-06fa-4e1e-bbd3-c3c2870e2b23	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-18	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
2255d427-c92b-4fcc-833c-8199eee39f96	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-18	0	24	f5fceccf-8230-48fb-a4cd-643ba7f5110a	f
5e98d8b0-d4b0-4c62-9ce2-6deb0ff57b9f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-08	0	24	c653f3b4-9053-4f9f-851e-cf16cecb64fb	f
d0f310a4-f912-40ed-8978-acaa0918337e	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-08	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
816e8ad6-c45a-4a3e-baaa-12de784fa2d1	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-08	0	24	c653f3b4-9053-4f9f-851e-cf16cecb64fb	f
7f6634b8-1eb4-4fb8-b319-1cf829d5e589	11fd42bb-8087-4075-afc7-419c5bf6fc01	2019-08-18	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
29104e3b-6ccc-42e0-a308-76f3018b342b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-08	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
b63c8280-d89e-4f3b-bbcc-077b39feeb12	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-18	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
1ec1ccb7-99f0-4403-9b9a-76b657234296	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-18	0	24	f5fceccf-8230-48fb-a4cd-643ba7f5110a	f
c4f2ec5c-a28d-4dc9-9d70-ed3d1268ba84	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-18	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
11bc5c9b-f07d-4c33-95c9-d7141f0a11e3	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-08	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
f750546a-f0b2-4ebf-b52b-78f31fb61554	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7af057b4-09a6-4496-b6b9-369483f25621	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-09	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
dfd4fcf2-3cda-4c9b-9e87-c97d1420ecfd	feba6c1f-a359-4162-8471-4df5994d4d4b	2019-08-19	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
4153199d-dc26-49e3-afae-d560e040c156	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-09	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
4a01135a-fc89-4c88-9b49-c8ed72027c0a	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-12-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
fc412ec1-4c8c-421a-8ce8-50caeb4a415d	76235d70-f972-4b5b-a5d0-5b454b2ecd98	2019-12-10	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b3d66bcf-9a3b-48b8-af4c-d01874ecced1	1895b86c-fb3e-41fe-a5c8-0dc617f391aa	2019-08-20	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f332f8fc-c679-4aec-91ca-7d36eaef1f90	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-12-11	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
597a9854-07e6-42de-947b-6bb42cfca54a	505dfc0d-0e7f-4303-be59-74a2a8fc2d3d	2019-08-20	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
6c67e60a-12f8-40a3-93cc-943deb08bc01	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a1ccee01-62fc-4f94-9c23-0908bc1b0f3d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-19	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
96a02649-4364-434f-af69-45d728c86872	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-09	0	24	10a2e436-ab68-4a45-97c7-f4a22bf06a1a	f
7cceea90-e9e5-4aff-ad29-c7a4a4dc6408	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-09	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
d679c1b7-e4f2-4213-ab66-c34b4a48c851	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-19	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
4d416cf3-7be0-4f7a-9587-3b7615cf33e2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-12-09	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7a50601a-b1a2-4d22-afc5-916e411d9245	63e8f037-9766-46d8-85c9-b2838393c953	2019-08-20	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
fd5e1efb-a193-40ab-a357-14ef60fbdd88	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
582b8b05-ea3d-43ed-b287-7beca325cd40	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-08-19	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
e2b3a0f3-0ad7-4c14-8ba6-ec5cfb64acb4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-19	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
0f28b752-53ad-41c7-bc5d-9b096cb0af51	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-02-28	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
485b67a5-4ffb-40cc-8808-6a3c5461ef09	1daa5d71-ac7b-4bc8-aeff-1f3ef743af01	2019-08-21	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
3d4c6f2d-4f3d-487b-8297-f88051c3b8ec	6cf0a255-f003-48ac-a467-b0f081f901dc	2019-08-21	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
f538416f-8591-4d0c-bc29-49c7a2ffd2b6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-02-02	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
8c265fb6-c515-4504-8fb7-182e70169c54	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
57136704-c1ee-4965-80bf-36e2caeeb6b5	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
5a65c5d5-f715-456d-bfdb-41a13d1f5ba4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
72d7eba4-1fb8-4cfe-8a96-743d2fdacbb8	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
551ff6b6-9e00-465b-8486-42ee2bb9db09	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-21	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6ce5c961-4c3b-4088-a1b5-0d49db2fb0a5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-26	0	24	86be41cf-ef60-4388-91a8-31cc07c395ed	f
cc99e613-dbf2-4332-8aad-77f0c7d418ee	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-26	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
29f5bc02-ea01-493e-8f6b-f1c2bffb52a1	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-26	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
6b6b2d4f-b957-460b-9142-9a3ac9ec6f1e	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-08-21	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
fa6ce802-16f7-444d-8647-6d67ab699708	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
878326ef-8609-4ad1-9f34-7b968a6d06d9	d1ef1b62-79f8-4bf7-9ef2-17b0328b1f2a	2020-01-26	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
fe403ac4-fe16-4cc8-8d74-0ec07a5ad9cd	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-26	0	24	86be41cf-ef60-4388-91a8-31cc07c395ed	f
ea3c9d14-22bf-41bc-bb8a-44151d2de16c	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-27	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f43123b9-4783-4983-9b11-39c9441cceb2	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-27	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
254f7f8c-6d31-4f63-9839-148f7603d49f	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2020-01-27	0	24	8a282a8f-82a6-4d65-b325-7e3ad1fa9cf8	f
8e3ec5a7-9696-4f22-ba4c-f82fd1fdbdc4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2020-01-25	0	24	86be41cf-ef60-4388-91a8-31cc07c395ed	f
0bbaaf8c-04b3-4dcc-afad-adcfba1010dd	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6eb156e6-3d01-49c7-8139-ddb3d86add69	ce40f82f-1412-4e20-8044-61b4a375732e	2019-08-23	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
df3e2685-2db7-4273-af14-6de1f0987fb4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-23	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
b651b9ea-4819-481b-a85f-e4797bf9545c	caef805d-8d74-41f2-acf1-d0500f72b1bb	2019-08-23	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
50c97d4a-0c9a-4572-833e-2031679b9fa6	5e1c0929-ef35-4d9f-9f4b-cd24b3a66e74	2019-08-24	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
a742771f-b355-4ecb-bad4-c549354fa028	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-23	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
04942365-eeaf-42f6-b327-41b5fa825803	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-02	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
4bd472a8-7213-4508-ad70-ea8d3f3bae79	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-02	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
2085b98b-78ca-4568-a43a-a382d6a3ff8d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-16	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
eb82b687-81dc-47b3-b4c2-82a4e0f7677d	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-16	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
c9f3044c-b5da-40f5-a264-1bab22a57cfa	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-16	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
70cb8dfc-04cd-43d8-850b-8588d2e00b41	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-04	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
9ab2dda5-e4b8-421f-b1a7-ebf0e4828dae	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-07	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
110d9444-9dfb-4981-b386-859a92d2f950	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
7b2f1879-e9eb-4595-8dee-3826254f9b6b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ba4082bd-1de1-40de-896a-c7c81953afe6	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-24	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
ff774f9c-5733-45ff-9f95-559cd8224b79	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-25	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
181dd523-3128-43d6-9adb-89a854bf695a	0ddac3bb-20d3-48c1-a9f3-2aae5749c9ef	2019-08-25	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
26551a18-bdc2-4a51-99e5-90f41bedecdd	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-26	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
8f9e2598-fcb2-4357-ac4b-0c76eda3b214	00ffab8d-fe4e-4ffc-8ded-4923527e207d	2019-08-27	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
2e62145f-9d37-433e-9c4b-b1d1a9281f5e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-27	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
08b303cc-8cef-4161-8d14-1479a85fc998	5e1c0929-ef35-4d9f-9f4b-cd24b3a66e74	2019-08-27	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
a1339bcc-c4dc-413e-b04d-b220616ae27d	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
74d488b8-4ddb-42fd-b226-20b4ea0d3da4	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-26	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
870fb66b-be4a-46d9-9de2-a0cb800cbcc4	1b052437-ffe8-40ef-a40b-8fd9b306e0f8	2024-04-14	4	6	5a4c9fe0-6fef-410a-b296-ca64825cb8e3	t
04e29e85-bb04-4506-871e-064611382c97	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2024-04-14	0	5	aceeca98-8530-4e00-a74c-4ff83fe96ba1	t
3caf2ada-6ee6-463e-ba5d-709c151ed823	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-04	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
aa9ecf60-68f9-4eff-a20c-2a0b139c42e4	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-30	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
3f9c421d-0799-43d5-828c-0a26d838abb9	9c601b67-3ba5-47b3-84bc-99ca39dcc8e3	2024-02-02	2	2	aceeca98-8530-4e00-a74c-4ff83fe96ba1	f
34164f3a-f25a-4671-a889-6e6d22489bb0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-30	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
b209ccae-b0d2-4ccb-b96d-5adf5c32919b	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-31	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
de70703c-7602-4a4e-ab14-4318626623c8	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-31	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b9410294-e13d-461c-8f24-9400fab47609	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b84eef4c-d299-46a3-af65-3d660a3c2456	9c601b67-3ba5-47b3-84bc-99ca39dcc8e3	2024-02-01	4	5	aceeca98-8530-4e00-a74c-4ff83fe96ba1	f
4bc94403-a9a3-46b2-b5d8-d75cec72ee36	9c601b67-3ba5-47b3-84bc-99ca39dcc8e3	2024-01-31	4	1	aceeca98-8530-4e00-a74c-4ff83fe96ba1	f
b670b78d-6375-4d21-bfd4-b9687895f0f7	06e79466-6c8c-4bed-8015-085b7884e934	2019-08-28	0	24	a1332229-9a80-43d3-8c01-cecb3565300c	f
56818123-f081-420b-9682-f9655f9ea9d5	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-09-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
8e257a42-6ef7-4c3d-b0ad-a15e7575b422	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-29	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
d886001f-86ad-4ad6-9856-64393777129e	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-08-28	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
6e8b07ac-385c-4cf3-b6c1-1d5869f30850	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2019-08-28	0	24	d954a2ad-5f79-4272-a7ca-591fb9387ae3	f
a414aa59-9346-43d5-a2d7-e796422f0105	02633b99-91e5-4a8f-90ad-68d8511141e0	2019-08-28	0	24	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
79f08f21-f710-450e-8842-7e8ec55b16ae	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-01	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
b1ede39a-6f79-4853-ae4f-8d9f05857f52	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2019-09-02	0	24	3e7a3d22-ef23-4f06-8412-976b92880618	f
f72e1a4c-5fba-444b-9f21-06ea4bfcb8c6	f42b319a-d6e8-401b-9ae6-2ed847a0e40e	2023-11-25	0	20	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
00276ec1-f26d-4106-8c50-3c5f86a94918	24ae20e1-50c7-4f33-a41f-08530977511a	2019-07-27	2	0	8065fbcc-f9a3-4770-95fe-41453031e3f6	f
b41adb60-92d4-41e4-8d8e-767bb37d8dbc	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2024-01-02	12	0	21ac5e62-9a14-4abb-8f69-3eaa72a2a918	f
b3dc341a-1874-4a73-a814-978e8f49e9c6	9c601b67-3ba5-47b3-84bc-99ca39dcc8e3	2024-02-04	-14	5	aceeca98-8530-4e00-a74c-4ff83fe96ba1	f
aaeeb153-be45-4fbe-90b0-b8d930642bf0	a25e385f-6e3a-4c25-b48a-7cb0a8dd9396	2023-12-30	4	16	c87afe32-b2fb-4902-b6ca-f4e6692c664d	f
0442122e-b1c6-479c-9b27-61d4922fb63f	9c601b67-3ba5-47b3-84bc-99ca39dcc8e3	2023-12-18	2	5	aceeca98-8530-4e00-a74c-4ff83fe96ba1	f
f0cabbf0-a4a3-4e60-b760-42a25b018554	06cee4ec-e321-4092-8d7e-976de2f31216	2024-01-01	0	14	02dfe11d-a82f-48df-a8c8-ce31cb51610a	f
49c2d35a-8d05-43d7-ac9a-d2873cfb4a06	be24ea06-87f6-48a6-a73d-00e9a0b3eaa7	2024-01-01	6	27	c7aa264d-8549-4466-9be2-6f2b375f8ab4	f
59f04888-4600-464e-ab88-8507925a16ad	02633b99-91e5-4a8f-90ad-68d8511141e0	2024-01-01	0	14	02dfe11d-a82f-48df-a8c8-ce31cb51610a	f
\.


--
-- TOC entry 3583 (class 0 OID 16508)
-- Dependencies: 222
-- Data for Name: StaffInfo; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."StaffInfo" (id, "userId") FROM stdin;
7259b8c9-bcb5-4345-98a6-2417a91f06b5	a3246906-ea72-4d4a-8beb-eb87463ae71f
1d53a79a-2880-494d-b5fe-bd98a1043cf3	dbec9d85-ed36-4bbb-8464-88128c099874
53c56127-6734-4c48-aaee-ac1663e30342	074bc14f-dc06-4286-9b6a-41c5f37f77d2
f863a056-7afd-4dde-aa63-1f38867b51d1	1e213d78-0641-4db7-99f6-c23d356bc014
afeb7652-8dce-4dc5-b971-b2d7614be400	8aabd880-8712-4cf6-98d5-d80d8dff9065
5fd025d7-200a-46a4-add4-6766d8e0f519	c2be90e2-bea4-41b4-8088-63cef889750c
b9241174-4971-4ee0-a76f-e9a3f812f5d2	56b821da-d1a0-4cdc-a9eb-8c979861e504
1443d658-e623-4009-b8ef-869cad8ccc97	57b4912f-2664-4a27-93cc-7f2dae822da3
d33a1581-45fc-4574-95db-66ba7755d5f2	4daa2cc5-e484-45a0-b99b-b2bbcbf452d3
b96d1c56-228a-4bbf-bedf-3d72f20db3e8	8d50d2b1-e9a0-4532-a5cd-98a972fc2be2
35190a86-15ef-4d11-ae04-9bfe8b456e75	28d5aa8f-d8e2-4213-8404-11a60cd9bcef
882c9b8e-5dfa-41f1-bc2f-e0bb944dfda6	bbab96c2-9637-40bd-a5aa-e2d74866ad5b
20a8d4c4-48e4-46e2-b83e-758ac0d08a59	85c25414-acc0-43be-95a4-76ea0477eb11
6c71d191-df58-4f57-a479-c4c924122bc4	297a6446-2ec9-4552-b92c-2aa300cbea98
6b58526f-85ac-4790-8de1-cfeb061ec21a	bd710c7c-b3ef-4a95-aec6-3c28b95a5edf
c017190e-15ca-4951-a0f7-e58235e1ca66	17fb6082-cb40-458d-abc0-1a6579a44339
3db44446-3966-40bf-9416-2539d63260c6	893a5910-f44b-4677-8c67-5f7e3737557f
772327d1-5447-47b5-994f-3b9964da993e	9871524f-e58d-4f5b-9a39-1fcceab0cfd7
69d53629-7b32-489f-af07-8c626a100a5a	93be610c-2219-4eed-9486-e4924beaed9a
74f52ae8-6099-4320-86e7-bded12c26d6e	531c56db-0fab-4e04-a569-c082fd7d416c
3f44cd8b-a5a5-457d-bc08-2c5435e159c5	287ea090-0b2a-4184-8b24-1b335673ef7e
e4855e85-d66d-4303-9c96-b903282e5f7a	f6a2961e-288c-4912-ad37-0c6eb51d664a
c8f0c4f0-4590-4ec0-9166-28080c04d76b	bb35cbf4-2557-4a89-8cdf-f28bdf81e580
d8d94c47-4747-48be-9159-de6cbf1ac5be	df2d2273-ea08-4f73-9a77-0cfb99bec429
d5973913-33f0-4ff1-a065-a9b67658ca88	4cfd4865-b335-4e19-89e0-7b81f14cca11
9e3096a6-5c7e-4533-b82a-fa13525ef004	395da688-ff8a-4f08-ad18-ab494c2b654c
3439673c-61c1-46c2-9022-424330e6248a	b5fff0ca-9f60-4278-9ed4-7cf1420da2e0
9df321a4-ceb3-4101-b857-d3e781888a3c	e26e6aee-fa3e-4667-b3ad-3183e2664cb0
b832c844-5670-4cb1-9b72-55df648c8542	a371753d-eac1-4ea9-912c-c27e6878772f
02781029-4c13-462b-83cc-2414a6e72667	b8d4ada2-4f25-4695-869f-5994e3ff9f7d
b4f18f40-4050-4888-b93d-46caa585878c	0b2236ea-4fb8-4b66-8a23-02044665339b
7be68e47-6603-4a77-a739-11a961281560	fd1240b4-9d4a-4b24-99a9-ca3fd3d1644f
5f131eba-0ec4-4268-b6d4-6849ca62ef42	8a5072d0-aa3a-44e2-b483-f3bc4de6825c
b0c722da-9d4a-4bcb-b82e-cabdee350810	e4363169-6f04-467a-83c0-efa0a64d7054
06500a74-fc73-4818-a4c1-fa2da766b7f2	c55a745d-b176-440d-9838-1bfd10d7223d
9d23e32c-9dfa-4bcf-b061-09481392798f	f13aa186-945f-4e10-a429-e936f841dccb
08ec61cd-530a-4cc4-a013-5baec0aa0a2b	b53200bd-16bc-4b4a-81f2-9cc1d42d4931
42f7f597-002a-4b6a-ae2e-dc22fdd65bb5	f0452433-0382-4956-9883-e471b888629c
5502f82c-13df-43d0-be15-77702f00bf6b	25054e9b-280c-406f-8290-3dd9fc84830f
94da6a10-dfb1-4341-a2d4-0ba2e8742d60	3c5c9883-3b9f-45a4-ac2c-6fcdf3212415
f602493f-7169-438a-a5ee-8d3cbfea738a	55076c72-eccb-4dd7-99b2-5e42ddcce4dc
b6816e0d-7083-464f-bb8a-64bb3e5d60d0	54346e2f-8104-43f5-9d44-a1c02ce24f46
668739c9-57ae-4608-93fc-b4c3e5e7240a	7a744620-1b44-49f7-a115-58d42f78ca10
86394cc9-490a-4545-aa19-0e03ad90b849	5221493c-260c-4494-8f00-601a92950dce
9b377334-1707-4b17-8e30-cfc846b30ded	13268378-7cd3-4327-9de9-0f9cd0d0e24c
8b4dd97e-7588-4c27-830f-e34f14ce7fda	11d249c8-fa62-4cc9-bdaa-36d0c5461d84
909e03b6-4fd7-41df-996b-67ae1a89de17	d25ecf0f-e9ae-4c34-a09d-bf6dedcead9f
ceb18495-ff83-4a5b-b89c-51fd5d68bbea	b7426eaa-81ba-46dd-958a-d78ac8bdafe9
82fb1de0-df5c-4761-95fc-cbe94f2b77cc	e31fc0ea-1a75-42c1-8e7f-342559e432d1
0ed8611f-7f9f-403b-bb6a-18d373869cc7	2196ca59-23ab-4f9c-8f70-dcc891350a19
dfdc5c9e-795e-48b3-996b-93eb8d2c54cb	fe659e41-5ad6-400a-96c6-55c6d96df571
b12c9764-4215-4f84-a06a-2da9c3ab7b16	1c5ae57f-d16e-418b-a8e5-2bd91ddecf62
5130da45-5fbb-4cda-bf8f-8a342ae13ac6	1df9c493-f210-45c5-b674-8b357878bf5d
16040771-96ec-4766-a6ab-2197819608ed	0bdd9958-cc59-4a75-923f-631f4ee944f3
e875da8d-a022-42ed-a9f8-04cc7dbb82f3	a09997df-b639-4e8f-97e5-2ba3b2ae3490
913b41c6-8aa0-4e07-90a6-051dd62f6b5d	b22bb730-9074-4233-b05c-e289d89e8215
908b97cc-89cb-425b-b938-a4418edd47ed	17287de3-bfa2-445d-aba8-7e5ee380e53e
8c0e2429-2358-4170-accc-09eb13f42115	9a675017-d953-4f01-b78e-0e03a9a4fbf0
b5a66d29-7148-4245-8fc8-87239d5a1c8c	06c110eb-5c99-473e-bc29-3fcc9cd76045
f5e1e344-99e5-4adb-92c2-585bdf083f17	9c02d719-f073-4719-9699-97d3f6053d17
182d793b-9ca2-44a9-9d71-40ac142dab86	3fe19200-bce9-4ea3-a5b2-4a975b2d5ecf
81574f3a-3275-429e-b8a6-7bbbc992ad25	4966e3a7-64ac-4aa3-93fc-92c3a7cb2175
7b342479-ebff-4372-8fa5-d2d888e7b3b2	f986ba44-59ad-4ab6-aa61-eca803292358
d6bc0f8d-e9b4-4eaf-a6d5-ee9e017cca0a	b63d4c23-c6f7-4f48-96f5-99dbb4e11bbc
de06d3a9-deb7-42b8-93ec-80947f7c4668	c8b5b2d1-842c-4665-977d-c62a0f01f8ce
ff52222b-d817-49e0-a6dc-dac02ae27491	23aaf19b-dde9-4fed-92e9-81dec4b72ba4
81254a0d-affc-4c7a-a30f-2852e1ca4ad5	bae84d88-7181-4053-b879-b46989235f1d
c969a429-b2bc-4566-a6ed-c37be55e06e1	e5b68834-7553-4b14-8bc8-96b26dd0d169
04b6e886-47e9-4ad4-9bd3-89a39b68164c	adcfc26f-4e80-4534-9167-59f694ae0bbc
413426dd-d4e4-4db8-9cbf-a87bccb36083	33ef104b-3b18-4802-bd70-8ac393168bd3
8ace5914-ea37-4c1c-9d8f-f5cbd0afeb63	9c5d0e60-5b79-489b-8e72-81773d55603f
0d14cd66-95e3-4321-80a7-d8333eae0cf6	1d42809a-c4b1-427e-9feb-cbe16eb22357
71555957-8a9a-4996-bc53-59f53ec6678a	39f30790-b432-476a-b510-0094ed72faf9
9d07cab2-318d-4c73-9354-a5ae7d908adf	d7792974-e9fc-4db8-93cc-856c2a6b3c8d
8436556f-8c10-4834-932a-2ec9f4f56e2b	5787d877-817d-4229-bdb3-ffc7d18808e5
69d245b6-a3ec-4d45-9610-86d3a1bb9097	8f12abc3-c1c8-48a0-a772-36c7fb2937f5
4a9fa11b-5e28-455f-a2a5-3bd5c394ec46	c3b233f6-d730-41ce-80f0-51fa50b574a4
aca33244-5714-4317-af29-1bf29549d545	52272b0d-6d76-4066-937b-75418e212a74
58ec37af-56fd-4b8a-abb2-512d40e94ef4	bb6f92a6-fe43-4c9e-b9a2-cc63b997046d
bead058b-706b-4828-9dbf-d18e5112a4bd	157fd050-e9c7-4ac2-b43b-987151aeba9c
1778019d-3c01-4d39-8bf0-fc26d11c01e0	412c79b7-f0c4-4664-9d84-444b77fd5bbb
c4213b50-cdf6-44e3-8495-ff46dc6cc1f7	247f88a1-1b9b-4d3c-aad3-7bb9263d976d
65ca1b09-c2d5-4452-89f3-7f829b53f0f9	4a6f5bdc-177e-4128-9080-a205cd3a42ac
ee5c2f7f-dba7-4365-bfe4-7bbd7137a3a5	08dcd518-4078-4329-b9b0-4081679246a2
04f3e421-56be-4324-b119-9b6845b5bca7	fa564883-b05c-4e67-855c-e5e50adb00d9
22137f7c-4d76-47be-aa0b-865e706b2a68	f21d945c-989d-4a81-862d-4bb67b4ec9c7
1f4db229-c231-47e8-9bb7-e9f8635531de	6640733e-16f4-42c6-9235-5f7f25e3155c
d65a855a-fc34-4fb3-910f-33078d23ba71	609abc9a-49ea-4fa9-a1ca-ee84182f9dc0
20201fe9-a803-4402-80c5-7f333e8a1884	2257d6d5-15df-4768-8bbd-760f13b498b2
cbdb64a7-3677-47a1-996c-c649ed991b05	ecde2c82-9fd6-4684-98ab-ad2e0d429a78
1ffdce1e-b926-4d76-937c-bc70cd687487	5c8a925d-f7a7-4f68-bf85-73fb0ca789ee
2a51c2d6-7c8b-465c-809d-fcb2e69c2bf9	9c1f343d-52a5-47d1-aa86-5f7794e29794
8fd63b5c-2775-424a-a7d9-b957171a1661	f13791f7-4675-49d8-9891-f4da8d235718
87844cb7-3bfa-4bff-8f35-f3f242b4ec90	6abb20ad-f5da-478a-8d27-ba9fcc41f4bc
ea2479be-0449-4178-be8c-8cd5ca0a489c	83ef2d5d-6cd3-4fd4-a391-3db0449c6c04
5f23cca7-2f00-4345-a9dc-c2d5c8056008	773926f6-16e1-422e-a4a4-e8ecc073d3a6
09d2f562-1bcb-4422-8aa6-66cf4ef93f54	757a2777-fe75-486d-88c2-fcd63cd60511
30928891-99d6-4ea5-b4c8-a8118821d720	7849fa38-f55b-47dc-b123-b0cfa0baee4a
71ce9816-3084-47d1-a37d-529fec87f8fa	df73852e-595e-4735-bde6-048cd014995d
b66485b8-08d0-4d7c-b296-434e95b11392	161a47f0-fa82-461e-b974-06f69147e62b
72f207f0-c46e-4a75-86ed-e64bb70388a2	3f40dcfc-e892-49e2-9878-c35fd3a9a442
799c2167-56c1-4efa-ae96-433e532cdf14	e65120ba-14f1-4838-bdd9-28324d945a55
90c49a01-3af1-4189-95b2-e9bd789fcf97	2d58be9d-10a0-486d-9b6c-0b76b4cd9b7f
08486728-e48c-403f-8efa-2ad2a6a3404d	179c3f54-084b-49c0-8bc9-bce0088c6bed
e21f190d-dd8b-4894-a4fb-a108601d431a	15ee892d-d86f-46a0-8ba7-900a79996fc5
006a3961-0d07-4adf-af4e-5a72e07cb41d	b97f0068-cfb7-4ee9-bf3e-1fe7830ccc3e
ead1f385-4470-45bc-9d1d-4f098a1ab1f2	dfc89883-0bf0-413d-a757-23cf2217bf93
21cf4ad9-d5d9-4033-9e1a-4f06381b8708	f8ccc9a1-30dc-4033-b34a-dd5a34a6b79f
da0f3919-6d95-461e-a6af-f5330bb73314	1aa3a202-0ad8-477b-bc9a-103548cca52b
9db198a9-6790-4727-b62d-6dcc7bd0d2b6	7100a80d-0a28-429f-9bb1-35cf8b897bba
d9e4f312-6730-466d-9289-22bc1107d7da	06a17449-17dc-4202-8e20-cef2efc1d598
871784c4-c749-46dd-a9c1-231188aa6208	3ad26f0e-1c28-4e25-b8f7-abb3902d6de0
3c282df7-b2d0-4964-98a4-20edfe7aa6b8	9bfc3bee-729f-42c5-82df-ba3c282ab64b
bfafbd0d-555a-4933-a9b7-0f687ec3b9be	0310bada-3e87-4d98-9835-c3fccea48539
7bf5be1d-bbd4-4f6b-b729-a62833e4dc28	51fd02f7-ee0d-4e63-87ce-dd23db7b1aa2
e917409e-b41c-49f3-97c1-7790a2d3fe99	ffd69e2b-b0fe-4fe9-af6e-3ef8d75f1fbd
2155f9c8-5c57-4f23-800e-9d0f8d6d7e84	c1d4a056-16df-47d7-aae4-90231f2a4b6a
\.


--
-- TOC entry 3584 (class 0 OID 16513)
-- Dependencies: 223
-- Data for Name: StudentInfo; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."StudentInfo" (id, "userId", "batchId") FROM stdin;
6a5b0d34-3c2a-4c0d-a3b8-998acb95d07b	58f5f21f-5de4-4f26-9626-c01a48c3e5da	e015bb71-7d0a-493b-be92-ba2bc541b065
9c7067b5-9744-4ec4-8932-055119a72368	6fe89cd6-a5a5-41bf-9c21-c39982ed3922	4443011d-b301-4778-bb98-e8f1d09015c5
a9e15bf6-549a-407d-9cdd-adb987efbeeb	58e6e3a2-797a-4562-b157-47b218b11cbc	4443011d-b301-4778-bb98-e8f1d09015c5
bccda800-8b90-4b97-89b9-6faaf0913ff3	7e195416-d966-4255-ba5b-cfbd338ccbf5	4443011d-b301-4778-bb98-e8f1d09015c5
5490cd85-6ad1-43c3-a2b7-9f9e8a70a7ea	47938de6-4ee2-4504-a678-f827149a87fe	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
d57e5d8f-1349-4843-ae02-90fc96ff0709	5b03ef99-0943-48e2-be24-789ce920d690	f76ccdfb-a717-4de0-be7e-e96744552432
c3be43d0-6d1a-4056-804b-d5413ef43a60	6c9db7d1-f3f4-440f-91fa-504dd0254f52	9cb8388d-e125-4b29-9d1c-2aee4ef5b5b1
a40eaed1-d853-49e9-a2c9-4e6bfadbf58b	a47b51bf-8167-4a7f-adfd-58dc5ef554f8	60b237fc-3beb-4293-ba4d-1ada657a288d
d86daa6c-3525-45ff-a377-494421a5b021	be7a0bef-1088-4ce7-92b8-d6af714fb558	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
bd2da41e-6d4c-4c9b-8422-d450a6cc3e74	933af6e4-2587-4737-b357-fdb71c12732d	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
845f66e3-4337-49e6-802d-be6c741b6c94	eca5d8be-55b6-4090-90d6-22729dc92ba3	f76ccdfb-a717-4de0-be7e-e96744552432
f011d746-87b2-43ed-b1db-4a0a83b1e1cb	d091f328-618b-40d2-be4b-d16c62854782	f76ccdfb-a717-4de0-be7e-e96744552432
2e53cc35-0038-4116-8fc2-5f3b3bfd1d33	5fa859f4-b299-4660-88d6-4a86f2bb9153	4443011d-b301-4778-bb98-e8f1d09015c5
a0e06c9f-4c07-48b4-9064-381aa76133a9	f5bdcfd9-8130-44bb-a0ad-aa03c5a36f63	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
b8de64f2-d348-4e08-8ad7-bcfd0f747f58	674d7726-13be-4908-94d6-17718dbab53a	60b237fc-3beb-4293-ba4d-1ada657a288d
eeacc8eb-b9ac-4461-872d-a4384cef2679	1140db3f-d07d-450f-88ab-26ad9b88f657	60b237fc-3beb-4293-ba4d-1ada657a288d
443a3dc3-335d-4936-8e6a-6d3cb9a0bec6	10b26249-f81b-4bd8-ab36-2d41b02dc9e1	60b237fc-3beb-4293-ba4d-1ada657a288d
f229f8e5-8325-4f68-ae15-c0eb5bbbcc57	3311f813-d9ee-4d42-a981-a55089ded559	60b237fc-3beb-4293-ba4d-1ada657a288d
373cfb01-baf9-4630-a693-671c04ba2957	af2f2aeb-988b-40c6-a9e2-7a3cb1fafb09	4443011d-b301-4778-bb98-e8f1d09015c5
4e164244-ab96-4918-b2d0-e26f251f2582	ca22a660-ac87-4467-9cae-95e7d4a0f593	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
609885be-39a2-439a-a389-48713b884664	2ae5a1b9-a7fc-4ff2-bce6-59cbc1c8baf4	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
2a3ac18f-b862-4e23-8aaa-2eea8166c780	f09e7966-6ea2-4520-b933-744b35a147d3	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
e32532fd-13db-4f22-9c06-54f9a22e5a2b	65733ada-1dc1-451f-ac4d-a2c9d17e095c	9cb8388d-e125-4b29-9d1c-2aee4ef5b5b1
91bfade8-808f-4057-8eee-4ce0329d562b	91f359f7-87e2-4e9c-b815-c1d5c765fbd2	4443011d-b301-4778-bb98-e8f1d09015c5
79e201b2-65a3-485f-aed3-c9891a5ab77a	03617242-6e4f-4696-9a77-1662b111b195	4443011d-b301-4778-bb98-e8f1d09015c5
5c0e83c0-2d6a-422a-82bb-b48b38ea6d7d	c689fb09-d65f-4033-a4d2-36576db5d1e2	60b237fc-3beb-4293-ba4d-1ada657a288d
f60b700e-42b0-4363-aae0-6aef1c57ac1b	fc160bbd-a511-4a6f-9fe7-705f18ba25bf	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
901e2067-9d13-4ad9-ae1a-ec175dfa964e	e2ff6211-22b0-459e-8976-612c89675db6	6d0d910e-1e78-412a-adaa-df7fc3fb3e6f
cfc1fca9-b3b2-41f0-800a-b939513123a6	09b68251-c4e4-424b-879d-d4383971201e	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
1e5bf1fc-4c5d-40cd-aac4-4f133a7c47cb	179723a8-a43a-4009-89e7-c41c89176edf	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
924d7b82-5839-45f4-9506-379f5c788976	96df90ce-813d-4d1d-ad21-c110218a161d	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
28964ce1-23e1-453d-9c83-435fc291e67f	465f7607-be54-4947-90f1-aabf4355d623	4443011d-b301-4778-bb98-e8f1d09015c5
0d09a375-a608-4cd7-a528-39128532d5b6	e9af9870-2627-4e23-a475-47803342eaa4	4443011d-b301-4778-bb98-e8f1d09015c5
5f9ebb23-c6d1-4e3b-b620-c37fb63a8914	98bd82d9-e5bb-4765-abf6-4aec9962bd06	60b237fc-3beb-4293-ba4d-1ada657a288d
d8a2c09f-c623-464b-92e8-b1c531686e32	be1b9bbc-b791-4b23-8df2-6ec9c6fd9e5e	4443011d-b301-4778-bb98-e8f1d09015c5
8e69fc5c-5228-4457-9bae-7dd3ad26a946	88bfc3e3-b7bf-460f-9e95-160bc46b984c	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
46cbbb33-f200-487b-a919-3dc4558f1658	d6a68749-90e9-404a-b304-3918c9f827d0	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
31ce69fd-5392-4e72-97be-74c61bd98889	fd4cd666-cb75-4ab0-9e7f-77dc1e0ebd7f	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
8c0296b5-4809-4ced-8a2a-ed9322c759b5	74925e2d-6d3d-471e-8ce2-a8826c429d94	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
e3984e60-a63c-4071-a0a5-69d449c4705a	b4948d5a-24e8-4434-b990-842c3cc8b71a	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
1a6ace08-cd26-4f19-adeb-2e31292bee56	8b8cadc7-89cf-4f9e-95f9-7912ff9ab44c	4443011d-b301-4778-bb98-e8f1d09015c5
ea80d010-755f-4246-af38-2e6e608845b4	dc659915-4204-486f-a91e-010721352352	4443011d-b301-4778-bb98-e8f1d09015c5
1a3c7d33-5ee5-4719-a898-f3f202d43da4	bd1ccedb-ef51-41f4-a9fb-12c69c6b9b61	4443011d-b301-4778-bb98-e8f1d09015c5
855cbfa6-d5e3-4ad4-a5a1-10ffe674e8f9	80ace21f-1eb5-4e08-b5ad-e6a9a50b977d	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
3f989e48-90f7-4897-89c2-46f10ae72357	3a14a4c0-7355-4b34-af81-ba8cac6ed89c	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
76b6fc8e-6948-4bb5-99dc-a81241140dbe	f49f756f-0e95-4fcb-8102-e0a82f07124f	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
080e8b29-ed1e-4a43-a9c2-343c45c0aa16	2abad29b-ba4d-4862-a4fe-5fb7c534da16	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
0dfa87e7-2b1f-41a4-81cd-f8e8c7124e2b	00e51059-cbac-4b69-8367-de4269873f20	9cb8388d-e125-4b29-9d1c-2aee4ef5b5b1
4c6539bf-0c82-4441-9559-c71578916742	834b557d-c530-492d-9357-f827b547bb8f	f76ccdfb-a717-4de0-be7e-e96744552432
be108df2-3495-482f-8b80-d6af88101712	08c14b89-7efc-4446-b8e1-4fe6e92dafaf	4443011d-b301-4778-bb98-e8f1d09015c5
d58f155c-7846-4c83-81ad-631d22a20ad1	db2f28bc-933b-4a4d-b850-e4cbcfee4782	4443011d-b301-4778-bb98-e8f1d09015c5
e1ec9810-6ffa-4aa3-987f-29656229f3f6	b2869ff2-7e91-4707-b410-b6b770a6c4e5	4443011d-b301-4778-bb98-e8f1d09015c5
cf5482a4-6aa0-4c4f-8652-a17ee284d7c4	2cf3a4df-3b54-445e-8532-4e4dfcc38f48	4443011d-b301-4778-bb98-e8f1d09015c5
667f3a22-45c6-43ad-889a-b6ec8012cd0a	5f34c195-9245-4fa0-a7ac-c6e63ed8567e	f76ccdfb-a717-4de0-be7e-e96744552432
742fc84e-7f5c-4ab8-b1d0-4165f4eb9169	28763b44-00ed-4901-8793-aa8419c8aba2	96814388-e785-4b90-a6cc-0933bf685340
ced0260e-d2d9-4f32-ac56-cf0c9281b086	73c2f029-7376-4370-b5d4-2004722f7fd5	96814388-e785-4b90-a6cc-0933bf685340
f2aed0b4-bbed-45bc-bd09-9f7e62eea97b	1e31af0a-a481-4a32-a3f1-3a47a88abfae	96814388-e785-4b90-a6cc-0933bf685340
61f9204a-05c9-473b-9fad-c1e9b6042625	680abf23-6e09-4ee0-8f10-5811d5c0ae8a	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
79456481-84d3-400a-8e15-d1b8ba2ea2ee	8d80f5a8-193c-40e1-ba3d-ec74c4420810	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
81a302bc-d07e-4ae8-bab7-6f79adc61fb3	cefc8313-6752-4fbc-bf0c-74e65c1150c3	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
7c17dd0d-dac7-4172-8322-8f6c52d972e2	4f622744-6a75-4a90-ac25-59bf4d943f0a	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
c90f9c87-a9d2-49a6-8161-c9c7541c3221	fda0d9a7-9d58-49f2-831c-850775209d60	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
15172ca9-e2c5-4f43-bb8d-1793c33d03fa	49de437c-2231-412c-a285-73d09b71522f	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
fad7ec30-3541-4ce4-a0e0-63ebe35a597e	c8da4369-5554-4e79-8479-0e76de556b9c	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
514b83c9-c4e0-4262-8372-6ce97a32f850	42581b4e-9a24-4cd1-a275-3464b8ff68b4	6d0d910e-1e78-412a-adaa-df7fc3fb3e6f
5d86468f-9ca6-4ff5-abc2-1553bf59d5ad	6cbbddaa-a205-493b-9d59-13a546614270	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
4fd32b95-6fa8-4d8c-beaf-3be0dda99a8f	b1dfc76d-360a-4419-9170-400bf674cdca	6d0d910e-1e78-412a-adaa-df7fc3fb3e6f
8fbbb03d-28df-41f8-bd3f-c737533fda85	7f8cf876-27f4-4744-837b-6adda82ee68d	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
22907327-a6c5-4ca8-948a-926f0ad17998	e885e7b0-f51e-449c-ab42-22e6563cae4b	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
a7564125-a1d0-4c69-8ef5-4d6bb6bc1194	56b4ea55-2c8b-4d8c-a6ac-4fe7ac8ac4e8	6d0d910e-1e78-412a-adaa-df7fc3fb3e6f
c0c04670-6ec0-423f-b264-5b72b3d51069	a30cb6d0-2b90-4261-ae54-b5db9ff16ecc	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
74811b6e-719c-48a6-bf91-732a613b0bea	bfa62633-feb2-43eb-8b99-6a7eb0d3566b	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
c1ddf84c-512f-496e-825d-b8ec2ac1a966	40123385-1a35-46d0-aeca-e8e3a943622a	4443011d-b301-4778-bb98-e8f1d09015c5
e173430e-fad9-4925-a89f-75877beb5851	7dab4f12-7e30-4952-82f1-9093d48c19b4	9cb8388d-e125-4b29-9d1c-2aee4ef5b5b1
08d4643a-8a6b-4efc-9235-e85dbf429bfd	2bff25a8-9c04-40f2-9d52-dd8d09f8aac8	4443011d-b301-4778-bb98-e8f1d09015c5
11b3c203-c60c-44ba-99f1-ad2441891c52	ad6c7e9d-64c2-4502-b0de-9af77f9761ac	4443011d-b301-4778-bb98-e8f1d09015c5
682141f2-1359-4c9a-9d86-ea300b2f267f	0cdb2e12-4cb1-4319-b6ab-cbcc7d1423ce	4443011d-b301-4778-bb98-e8f1d09015c5
de0ba4c7-604e-4df5-82bf-6306d5fe9607	cb81fe51-27be-4176-bfc1-1b361d42ecd4	4443011d-b301-4778-bb98-e8f1d09015c5
e5f1714a-e542-472c-b77b-89c22c45baab	5c9e6d39-338c-4cc1-814f-db5e36e7294f	60b237fc-3beb-4293-ba4d-1ada657a288d
21a4a39f-111d-45e0-a9ea-773abeb08790	d756feb1-5fb8-4af4-9242-20166ddc3fe2	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
c29052d6-c58c-4168-b140-855b04d58e30	89446203-abde-4ccc-875a-0128b0240721	96814388-e785-4b90-a6cc-0933bf685340
d7e5a73c-7ab3-4434-8881-51cce88173bc	f6ef71a7-3cd3-45d7-8236-128280ca1fc9	e015bb71-7d0a-493b-be92-ba2bc541b065
6f582a5c-1332-4c5c-b228-d0f3f8bd8d13	42b0500f-c9f5-4df9-8dca-525aaacdbf8f	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
ab0ddf7e-1b44-4536-a44a-2afdd83d87af	c23ca408-3aaa-479d-a26f-ef6c2e4851cb	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
dc952183-ee8b-49d1-a173-b45cc8bb1767	74f4cc4c-5992-4518-ac80-41dff96c2249	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
7505b087-3e2f-4438-aa2d-6d820b53de2e	bb6a3e0c-188d-4bac-a0f6-a1c91fc871de	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
76082e00-5046-4d59-8ab7-17091212400c	f591dc20-ff79-4c65-9a98-53db7cd3ac65	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
6ed84eb1-e65e-47ce-80a4-89b3c67ece05	d64d8ce1-4225-4026-8c7c-ec774f5f7376	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
5738f85d-63bb-4428-ac8a-0f5fe3ea2315	fb366f4d-2228-447c-9455-7a58b5d858f5	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
4582ccf8-d5fb-4b5b-b91e-10667eab8f85	4e8153e6-4c71-4d15-b72e-fd65d45479f8	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
135e4677-7b6e-4bbf-9e8e-04f327c43321	4fff5fc1-fbf2-43bb-8b9c-4ef06574929a	6d0d910e-1e78-412a-adaa-df7fc3fb3e6f
644500ef-78b4-47a5-a949-5a1db20a2177	2688c238-b324-4e71-813a-b03702c1d33c	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
beaf016b-32b1-4e48-8cd6-43258edc9005	28397014-e9a0-4c23-87d0-8a2c71ad7aa3	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
dc9aaf49-8d1b-47c8-8aa6-35aa80b600b8	a9f9ba65-06c6-4912-8ba1-71a70e00c698	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
31a88b51-efb4-4d1a-8af1-ca106e032e10	91f8763f-a8d1-424a-b638-ee08e8587e3d	f76ccdfb-a717-4de0-be7e-e96744552432
24cd0743-2f1a-4690-882b-4ce421f90836	d846c4c0-68c3-4045-9c4d-ff8eace3fa34	4443011d-b301-4778-bb98-e8f1d09015c5
62c6fc71-971c-4ef9-b48a-e17af8786804	f6cc83a0-b7f0-4195-bd76-c256db705889	4db6d042-973c-4ba3-9598-3b8b682691b7
ba73e085-e0f2-444c-8ffd-7d1fc1cef00c	197bffb0-52ab-4511-96bf-75f7558e84ed	d67fed11-7263-4de6-b813-06eb33132975
b737cbc3-0c5c-41d4-bd2a-7ada4ce4d379	b13b1853-5f86-4f64-afd5-094f113b00a2	d67fed11-7263-4de6-b813-06eb33132975
280758b6-a70a-46e8-9dd6-d869e8c14e9d	1fb9a8c3-c509-4ba1-b1b8-9273e76c8949	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
944c52a4-45a5-4aed-93f9-965a91bd95b3	d35f0e96-b589-4d5b-bee6-2293a66c0a5a	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
a539aa30-29e7-46d4-8fef-1bfb0f2757e7	2e625bc3-51dc-46cd-b39e-600b0730806f	d67fed11-7263-4de6-b813-06eb33132975
7f7ad8fa-1855-40a1-ab30-6c78edf5536d	e9995766-fc8f-4b2d-bceb-543a6f46e065	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
dc1416be-0b16-4e3b-963a-70cbad80a48f	7024b8db-d952-45d8-8ad9-fdf947dabcab	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
f613df0e-09b3-4613-8e28-e7dfbec46129	db1e3e5b-80cb-489d-a369-6e39f7ae8ce0	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
553b189d-67a1-4680-b3aa-9c8671f79232	2746cc8f-6348-4e7d-9dda-adc586acb643	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
d9b85edc-7475-4c60-88cc-342c4233bad1	c77df251-4f28-4fae-9c75-4805118f40b6	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
347f6a99-a02b-48fb-bcd3-4e4b2f66cb75	6e69126c-78a3-4270-a940-e89c30d3733d	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
8e46415f-e3e0-464e-af1f-27968eebcbe8	e5cffe5b-22b4-4d84-b71d-520e9950c107	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
c24bca1d-5dd3-41ae-8fd0-295088ed2d4a	12ada5f8-962f-40d5-9e2a-6d5cdb47fc01	948f9273-0239-401c-bfe4-37a871499e4c
6fc7aa0d-16be-45a4-8248-0091d62eff87	c4fd0791-d8c6-4554-8b6f-167181754d1b	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
c29ff318-6952-4df7-a386-f053597879a5	7df71d27-b812-4d63-a890-e6b62fecf9dc	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
0980a4ca-5fac-4332-9593-b1e4ef8eec34	b43efd61-79bf-4dff-88b0-24407008ad2b	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
9e35ce24-0b74-4f5a-805c-406352a9a83a	ff27db98-98fb-49aa-a55e-e1f0cb3270d9	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
e9f466f5-e05a-4e35-9aea-5a63e5d4f60b	717016e7-86c1-4b9d-9d8a-abbb603a7eb9	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
a568b91d-a36f-40e8-aae2-26a08c5eddc9	0425646c-9ef6-46a1-895f-d33603bd3127	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
0049b2fb-d36a-4c40-ae82-6cb491745e8c	b5f69f00-641e-4317-bf69-66af15f1bb58	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
91631477-3f29-4429-9682-67f7780ff71b	e79a3ad1-0a3f-4169-86e8-11111ec99d07	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
abca876d-2e99-4ecb-a309-6294cd679190	c5738791-8d08-4b2b-b67e-982e4c98d9ea	948f9273-0239-401c-bfe4-37a871499e4c
57fac796-bea3-4e20-abae-15379b094101	6fa6c6ea-f689-401e-8a9e-69ce059f6d93	948f9273-0239-401c-bfe4-37a871499e4c
846d1f01-b414-4fcf-bf2e-8f6e3fa3195a	e5669273-53e7-48ac-835f-0a93afd4c484	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
9401d246-b33d-4c91-a7a9-7f4e5998bff0	d771fe84-4add-495a-aae7-358ef2117e73	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
1b8303fa-16fa-406b-873c-f88b651b5e34	69e5cdf6-c093-4f1f-aa18-ccb8a95de933	d5d99db0-2cc4-4ba7-a251-02cc05406f08
58f613f2-7c5a-491f-a837-5b75d7093b0b	f8770680-f04f-4bbf-be70-a6e01a65ae17	d67fed11-7263-4de6-b813-06eb33132975
702a9384-e3dd-40fa-834e-e67f6fa45925	cc6fe942-be3b-483c-9d8e-cb4f8818f548	948f9273-0239-401c-bfe4-37a871499e4c
4029e8ba-7af1-47fb-a4dd-17eed2c1b5d4	5129abd8-993e-4563-8cc2-f945499fb3aa	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
81af1c1e-0092-4c74-97d8-982a3ca8b4f7	582fdf42-de6e-41e4-beef-46fe797ed1ef	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
32556b63-f0d5-451b-8bd6-a4124ed18359	2f75b41b-9b4a-499e-ba74-1a9535203e2f	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
44fbc028-7b06-4d95-85a9-85838dc2faba	58d9a9c4-d1b1-4f92-b9ec-0c7bf3d6354a	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
b01e8dd4-ef08-4a4e-923d-5163cbef2b0a	c5f65189-d34b-43cb-8cbc-c17566156b0a	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
6c6cfd1f-f63d-4ee9-9e01-ca12b75a4fac	35a8e5c0-aa3c-41e3-80b1-8a1582432650	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
6df363fb-bd59-4a75-a7a4-2ff0e8805f1c	2b3762a6-2fc8-4a5c-a759-56a50a4219d8	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
35341ca5-ea8e-4ebf-ae13-0bcba726b906	aba904bb-c7a8-430e-ad9d-5ed1762eab65	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
e83076aa-9aad-4cd5-babc-6cf35bac7c93	83b5bf52-c2b9-48fc-b4b8-49dcf393e125	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
d49d26fc-5311-4e37-923b-b1dac5170ea9	5b49c6af-2dc8-4e87-bbf0-7f41612fe06d	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
3355d107-fa62-4f3d-b398-56c5c7449dd0	932e4409-c24d-4c1e-b4f5-37d9311b2350	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
fc31435c-886f-48c4-affb-8e9fabef75f9	86017b6f-c0a6-4601-bfa9-4c206c19e7ac	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
40011d88-8793-4863-a673-ccc8d5b0768c	66d97dda-fd2e-492d-8146-ca9512ac0e01	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
7ab08de8-12c2-4a8f-b843-58e4403eeb89	42ece2f2-7ba3-4b10-9e4f-65d472be87a2	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
4fc506ac-acb2-4540-97e8-d2b2d1187b60	f15488bd-dbdb-414d-a1b3-3999569519be	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
d484d14b-3315-445a-b3a2-41ba5406beac	cd5915bb-a524-4073-8b7a-8e91961bfef6	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
035fbf86-75d6-4657-ac6e-32f6541f6943	ab152fce-24a7-4841-841d-dfcc28a9056b	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
deb787fa-02f7-421e-9983-1c18dc7c6644	bc3243d6-46cc-4bb7-90be-f4277888d4ee	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
0d94566f-b43b-40f5-8a01-14a193acfea7	94a0352f-548c-4577-90f7-cd79c32757b0	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
214a7eff-78e2-4852-a95a-12716a0a7ebd	48ee8906-aece-49be-a59a-db2b1ae25841	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
40bba9c6-4cc6-40bc-b222-a156ef7a995b	54e4ed17-c3b3-4f81-8f8b-95faee88e66f	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
9a820643-466c-49a8-82a4-f594836dc4ca	01c4eb80-f0d1-461b-82e3-460b5be13bf9	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
67c48ab6-aec6-4178-b091-f8216b9baa97	44db78be-05bb-40b2-8e09-e8fb5a650513	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
1d185dec-f66a-453a-9992-f7db74a4a50c	ad3a7a70-439f-4fc5-9ddd-6e275eae1e12	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
43c39073-fcf5-47c1-84bb-9b96d09c497c	8ecf1303-7a73-4f17-9a12-76b23a387c83	d5d99db0-2cc4-4ba7-a251-02cc05406f08
6b46d477-4a89-452e-95a7-3a3c911307e4	abdba6bd-8c86-4afa-919c-cb3d3cf075ca	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
903b87df-a01e-4144-8abd-86ad62e8760e	db8eaf3b-f95a-4b30-b1ee-0228be1abf0d	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
d3b96155-d497-46fc-ad9c-553da149cb2f	b3fbff81-8b91-4c58-b788-aad57b9afba4	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
39147a16-3644-4687-80bb-1d7a09130cce	7f940df3-91cb-49db-9587-5b577393afc2	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
9f496476-5d4f-4e8e-b5ec-cfd2a7ea7ac3	1943f5f9-4473-4425-ad80-9c8587b034c1	97c7b202-02ea-46e7-80e4-2f5303d96a1a
c34f6ee2-f60a-4106-b8cf-6761449ca779	7d10b369-1729-4dcf-81ac-70cd5ae54b8e	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
c0c5de6d-de1f-443e-a772-67cc7338058b	b84d039b-bad1-4648-bb2b-a60e2dc53c8e	d5d99db0-2cc4-4ba7-a251-02cc05406f08
ba49d686-1f90-4d69-8154-91fa2de188c4	90eed5b7-0729-4659-b1d0-3df256ef82e1	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
e33494d9-ed1a-4317-a739-e64855e2e2b3	d51620fd-7036-464f-b58b-e8d13ad095b5	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
d888f9c8-9750-479b-92cf-74e9fac72e8e	af5edebd-19d0-4aa2-a2f9-c9685616c646	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
bdffb1bb-a1ef-42c3-bfe8-ab91aeb6082f	e294ac32-f961-4a76-856d-38d503853063	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
57b3511e-3786-4c9f-afa0-24a7292d8cd1	3b0f73de-73e9-4591-99d9-026eff35a37f	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
1751dc7f-7d1c-4c3b-bd41-06249fbd78bd	4f2def71-ee2d-4134-9838-9b40dd35768d	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
a0daa3e9-8b60-49a2-b788-6e5c0f6764b1	00891a9e-6363-41a1-98a6-9c04bc8fc8ad	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
0216ff37-b71d-4c8a-95fb-812baaa9fafe	154182e9-ed42-4361-aac5-92ca90d72b73	948f9273-0239-401c-bfe4-37a871499e4c
247e5996-9a3c-4493-be1c-283bea3a2236	2b90ab73-32c6-4c3e-8605-d38ea2eaf3a6	d67fed11-7263-4de6-b813-06eb33132975
15e7c673-c84c-4bde-a080-0ace885e1699	7a0e934c-fc3d-41eb-873d-082f881ce623	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
190381ae-3271-46ab-96ec-87df65045f3c	cd9c9f38-8367-4ace-94d3-104545a85a03	97c7b202-02ea-46e7-80e4-2f5303d96a1a
52668e65-843b-4e2b-9c3d-4f5de58d29b7	0f678b08-d9e6-46f7-8411-a3eb93bc3b72	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
a12df0e3-72e5-435b-bc62-d2fcd7aab5ea	92c8d939-ec6d-4671-9210-656fc5ed58fa	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
33842482-cff0-4b4c-9a50-ddfb51b2be1a	7716d634-5aaa-48b7-944e-871e336cdd11	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
3857f809-7b15-4b4f-bdda-182abc383250	53658cf9-bb07-485f-abc7-16d20eaf07ff	97c7b202-02ea-46e7-80e4-2f5303d96a1a
20d05173-3bb1-4fcf-aa18-a23bf2a39479	1537d0b9-d64a-418b-831b-2eff539dd827	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
f59d9ae2-83ff-4366-822c-b1ed49630a8f	56ee4b69-a52d-479a-b595-b0eff3b7f5f4	d67fed11-7263-4de6-b813-06eb33132975
fbe594bd-16f1-4a2c-b018-d945bbb1dc4f	7cf7bf9e-6480-42cd-9d02-f457e0106325	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
1e34d889-074c-4f3f-b789-fa759b718cc8	877884fd-1cbe-434a-bdb2-7fa33454a790	97c7b202-02ea-46e7-80e4-2f5303d96a1a
7d5e3578-4980-419d-8ffb-efda074e76c0	2e20be61-3a29-47db-b5d8-aa8806ca08f3	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
7f90a8bc-2a44-4096-8db5-f6590bbbb991	61537699-3d20-4be6-ac2c-57d3b0ce81f7	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
de7844f9-1f36-4550-aed7-0fc2bd043be9	6fff7783-bc6a-414c-a045-a62c3d4fa86f	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
38f5a175-7244-4c4b-8fe0-7eac6541c7fe	50b9735e-be7f-4080-99c6-b06ff68726a7	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
be823981-b8bd-4213-a910-9bbec51ec9e4	81b84d2b-2889-4b56-9e5b-1045ab659bad	d67fed11-7263-4de6-b813-06eb33132975
fa1544a7-00b6-45f4-bcdc-87e840bbd83c	725e988d-6780-47b2-9b44-f83af2c3fca8	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
505cf8ee-a0ca-46ad-b43f-dc9ccd02af58	40838f37-da01-4279-9cfa-e7c1752a5735	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
f678e9f6-5ec2-4cd9-b7bb-84edb9889b9d	173e94ab-1303-4b79-8181-c3ecd4bb3b36	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
f4547bbf-1817-4abd-aab0-491a683d8787	788d6c3a-dc03-4758-b3d9-5465c05edbf1	97c7b202-02ea-46e7-80e4-2f5303d96a1a
1edfe5e4-2ff1-4f4f-a853-1e43015fcb9c	ca1b3103-d9cb-400e-b939-b1a575b78830	d67fed11-7263-4de6-b813-06eb33132975
f3b3ff30-3dc8-46a3-abcb-91cddbebbfde	6047e9d3-472e-400f-8782-05c80f0c6771	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
e6fb4977-0f1b-434a-bcd9-8cce00ee4f6e	d15c088d-a090-4348-9504-4c3e96997317	d67fed11-7263-4de6-b813-06eb33132975
e71fb07b-1e59-42ad-8c3a-233ef857c105	8ea8423f-8510-43ed-8dc9-b1672f42f2f7	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
2ca4cb97-61df-452e-b01e-32e74abc81ee	8089758f-83f2-4552-875b-9bf8d2220e45	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
2f9df1a7-c5c1-4fb4-a5bd-9a0f1f1acd31	d7b6ecdf-c2de-4a8d-905a-3e7dc86dafd8	d67fed11-7263-4de6-b813-06eb33132975
7cc7c4de-2cae-40ed-bad3-cfea9ea1ba37	9154771c-4d31-4d1e-a48a-49c10802ca7f	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
02fe08bd-6605-41a5-b429-ce45856efa77	37efb265-acbb-4979-ac31-123e0c80ddc4	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
b5bf3b9e-ad1a-4442-a760-5c54ed593ec7	f3fb6c4f-4f02-4c9d-ae78-c8b82e20e6b9	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
06d14b84-d2c8-47c6-b8e3-2d3569e6f34e	d10ab048-7259-47eb-a4f5-959919a4b700	d67fed11-7263-4de6-b813-06eb33132975
cb88d7da-bed5-48fa-b0b6-7003cbf4f5dc	bb1bc1d9-8c29-4d43-af54-dd1423f2d38a	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
dbe7690d-26b8-4f8a-bf47-d66f9ff42050	76d4f04c-9ff4-499a-b337-59901006c0bf	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
735e686e-457a-4dd7-855c-3a651b85f9c9	f37369a3-1ad3-4569-a2c0-f8fb349ea7e6	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
07c5003e-592c-46e2-b31e-5e454d7944b8	2d79aa6d-0078-419d-bf33-dbddfaf33387	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
a3f3016d-c75c-4a55-9e40-df4cb8cf2df4	e047136a-10de-440e-8ecf-f9e670a8b8ce	d5d99db0-2cc4-4ba7-a251-02cc05406f08
ad560c03-c4f7-4ebf-b89c-4ed21fccf05d	e7afd0a7-9b47-481b-8071-3e96863dec0f	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
31eb572d-fbb6-4b4f-a2a6-030703e1b100	9e8e6050-b09a-4de3-a661-101609782338	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
01059686-b165-41c9-931f-ce2f5740debb	6568987d-a559-4d06-ad69-0e896a0b018f	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
1206cb03-8f06-4230-9a63-879a48a1eee3	aafe306c-2d6c-4df8-9464-a9bc9f681f78	d67fed11-7263-4de6-b813-06eb33132975
c112b970-ec04-47a1-b3f5-369976e163cc	175950af-4e37-4cf9-88b6-1bf3d721296c	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
6b4c9778-f042-4857-9200-bcded421bacf	acdb145e-9f27-4bdb-adfe-dd25c9435498	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
8993cb1d-4c86-429e-b24a-e995854ae3a9	a8ee57ae-be9e-4bcf-b025-4abc96e45d65	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
2a6d9d7c-4993-40a9-b268-b4ba5f0d87c5	84f9dfcd-6800-4900-bd25-6cf3ff55f7f4	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
bf4011a6-6f2b-46ee-befc-5bd58d7566b5	7ec25321-54e2-4536-a2b6-7fc02f107a7c	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
bd696438-bdd1-4608-b72b-015de87faa46	a494d500-0933-4fcf-9f21-db5ff4287248	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
62f6c020-7985-4d06-b53d-4eabfc352ef8	e92200a0-ec86-4e71-a78d-fc419e813bea	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
2a255ce1-92d1-4b8b-bc95-6e3f722c5c4e	269809d7-bc6d-41a9-8abb-bcd406b422f2	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
ccc81b89-0dcc-4b03-90bf-8663b80e0b41	c1a4d147-22e6-4461-837c-b63de505d7d0	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
6425c638-f8fb-43cf-9c58-c80c4ca74b05	c3933f5a-63d6-4b78-ac54-eafbefd46265	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
8bc1bcc2-8349-46b0-a934-a586b4c2c9ab	21774aab-0474-4c74-91c2-70edf00810f2	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
659309dc-5f7c-4b4d-a938-e238f24c701d	22ea4482-d8ca-44cf-b39d-563ce78da2bc	d67fed11-7263-4de6-b813-06eb33132975
c349015e-7ced-4959-a89b-c5572d4fc959	cf3e638a-08d6-4edf-8e17-1a760c871a4d	97c7b202-02ea-46e7-80e4-2f5303d96a1a
831e9e64-46e7-4a14-8304-c9adba762b1e	912eb30e-5cfc-4f48-99e0-fad19da55344	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
e534dceb-9d1f-49ae-974e-aa0384de1005	d7355f08-0654-4560-8f22-fb6a9fb04c03	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
a7b3df33-6d4e-4fbc-991a-e9e143158c1a	c0b6b026-3b6e-47be-abc7-464f96ba90d8	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
f8614ded-d79c-457b-98da-3df0a1d8c934	4c1811c9-6345-4b6b-bcf1-5ff05f2a98f5	948f9273-0239-401c-bfe4-37a871499e4c
c378137b-f575-4074-91cd-b13cdfe309db	20d3564d-f976-4a0a-ad31-4d5cff6133ec	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
954d68ae-98fe-42f7-9249-2fc9c744a264	c9c4e2ee-4b24-463d-89d4-82e90cc51257	d67fed11-7263-4de6-b813-06eb33132975
33b83d19-828d-467f-ab98-5b156a575604	aa86b955-0785-4d04-b3e0-a08408d6b0d4	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
54cd32f2-5d6d-4237-9103-42c130edbae3	1af2e637-13de-42b7-a2c8-97dbbe558d02	d67fed11-7263-4de6-b813-06eb33132975
47fb4fdc-0d0d-438b-b538-899278d83f82	ad699d2d-fa80-4cae-b846-22461fc6f637	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
06427d06-c548-4c74-814a-8776be08e2da	35282e55-cc08-4e9c-9e8b-0380fbd341bd	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
05b2b8f5-8b05-44b9-8d32-248b99433ee8	43891e21-8acf-40ac-ae80-831559b8dc65	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
811a1cb2-1748-42cc-9bba-cc87a6210290	4192c694-dfe7-4987-8f65-f0c86b8e42b3	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
e93ec1bb-3a5a-4ef9-9ff4-e893026c9515	737dde79-444d-4d48-a4fe-da59e6007523	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
245ae2b0-3f5c-4f61-9a32-e56b73d29547	ae5d7c40-4a27-4d5e-8d14-0e5d8ae59050	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
d1e7ad6f-64aa-464f-af29-e5eb2cea8729	a3c61194-c275-468b-9b88-d2bced68288a	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
ec5da312-5668-4d3d-b9d1-a948c7574590	e52ad439-29e5-48be-81a5-9e4fcd0c6c5b	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
f92969e3-3e61-4e87-8469-4f3cc25ec304	6e8a7863-21b7-48cc-9905-509117fc9c5c	948f9273-0239-401c-bfe4-37a871499e4c
9eab3975-6df4-486d-8d2b-34c757aed323	9f18a9ff-6824-4e36-9f33-0e3a80e5bc62	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
cf6c2c9a-81ca-4c8c-b1dc-da3eef6a7c97	d9333f27-d6ee-4e4e-81a3-29dffe6b266e	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
2c082754-0b10-44bc-be89-b1cb7f871f64	2a47f500-534d-451d-b4f8-97b54eaa7cf3	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
781638c5-fd90-4629-a3db-78c01554cbd4	a45ef98a-ebbb-496d-b775-e95739c82aee	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
b32ee798-e0d0-4d79-aafa-54be238e2d7a	e9d112c5-2fba-4de5-877c-e2640b030429	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
e01a2d94-a839-4f4e-b595-7aa6a6b9e529	e6e47c59-a345-42d2-8e37-d0252a3c685b	d67fed11-7263-4de6-b813-06eb33132975
9a382f7d-d832-4482-ab19-6d467fc1cb3b	e521170d-6319-4880-a07f-2050f48a5dcd	d67fed11-7263-4de6-b813-06eb33132975
3032941a-435d-4b42-9d2b-4963c1e4d0b2	e65da901-e737-4e61-bb59-4dee1fce4903	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
82426a80-4f13-4428-9785-de70840813a6	c2f94a33-85a6-4491-bb8a-5b745c246029	d67fed11-7263-4de6-b813-06eb33132975
2ca699bf-8339-4a24-a79a-0536ee29a010	b4446414-c82d-4ae6-84a5-8b1c3423c0d4	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
c55a221d-9cca-4089-a714-0a816d5aeadc	f0bc1f54-032b-430f-a22f-885b8f68bd20	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
15119574-05d4-457f-b8c7-fb8cbe3538c9	97e170b2-335c-4023-92f6-587af53cd966	d67fed11-7263-4de6-b813-06eb33132975
93537b33-041c-46d0-85ac-33b6d3acc49d	75e6991e-1f5a-4952-8eab-82752be30210	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
a273966e-0cb2-4728-861a-d0cf1fa24d62	21ac609d-9873-4104-8af2-4c1333e553db	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
9e5d2e64-a7b0-47d3-b9ce-de2eba35bd8b	50b4cef3-bc47-4e07-bad1-7507cc16a3fb	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
aad38cef-94f7-4424-aa78-2d842a7b4dce	eed4612e-a1bf-4598-ba59-4fd81d1cd32d	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
e6069cf5-0937-4334-b2d6-ebdbc69bc104	2272fb42-714e-43e8-b14c-918270ba814a	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
c09f8a8a-7cb0-4e89-aa7e-bc67a35a2471	eeff1666-c5d4-42aa-8ef0-cde2cdd2b969	d5d99db0-2cc4-4ba7-a251-02cc05406f08
e2f9fba4-205c-4395-a7af-5557470ab0c5	ee2a6f28-fb30-47f4-917b-2ccf98323916	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
0af14964-9fc1-4c03-9af9-c35bb548c18e	25c751da-54de-4683-9c76-429cc849062e	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
e910ed7e-601c-43b0-9165-2d43b9d09992	c5200875-008b-49ee-95e0-97d3640cbbb4	d67fed11-7263-4de6-b813-06eb33132975
1816484f-059e-4f92-a7fd-070b61024c2c	68b31f1c-5810-4548-bae4-262f5be1a193	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
d374b635-09b0-4916-9012-950e5449d31a	bcc17fd4-976d-4637-8e7c-d08e87f32b04	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
f9f76b7d-70fe-409e-bb3e-856c0a34e8b1	7a6c5868-9ad8-482a-802b-2427728fd2ad	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
c39e9524-154a-49b1-a33b-b25330839843	ea8fef71-5a1b-421c-bfcf-89f2f17951f0	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
a77ecba3-f617-4ac3-8de0-1d12dc934a09	675ddc4e-7100-42cd-acb2-2a951e5682aa	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
a90467dd-a9c3-4fb9-9ad1-571907bc9694	d4dd3b8d-feef-414c-a538-92be779daa3f	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
7228d2b6-5ab8-4f27-8269-111039c1e5a6	666c8c03-420b-4353-b1f2-59e458deee90	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
ce9b17c6-b926-4fbb-b080-f859f116687c	3f1cd2a8-dd19-4522-ba1d-923fe1fb8a62	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
b4c57b21-fe9c-4afe-8f0c-7fc3face8b61	21f07170-de4c-4e33-a4ee-c5b02662f085	948f9273-0239-401c-bfe4-37a871499e4c
35c9e455-9566-4b00-b1ed-2e090c05d67c	3b2e498e-fd04-40cf-8e7c-7d039c4956cb	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
10f3fb58-13f4-4484-bfbf-b4bd09dea933	c03d4ede-569e-41c6-aafd-0b93ab9d9080	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
24ce5905-9802-40d0-a99d-8f88ea361d7e	9080eec3-4743-480c-8873-e259b73064f5	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
322458fe-176b-440f-832d-cf44a70a4d4e	27e3d083-2695-4c33-9372-beb6c2575c9a	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
b9d7d217-fdb4-4b0b-bc46-cc3f29c50c0c	83d65a7a-517a-4fc8-81d0-c164f397e0d7	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
2c089ccb-1279-413c-a5dd-2219374118f4	350ade1c-1401-4624-9019-3d4af7cd58ef	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
ac738c53-c94f-4af4-915b-4a3b5b8ee625	32ff48c2-2599-4617-90c2-3a708c42b1c0	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
e6533822-c860-4248-b9d5-756253a0f6f0	de3cc11d-60d8-436d-85e2-f9eb9dff4b64	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
462bac87-15e6-4a01-8b0b-d59d54afb626	a39b5ce9-a272-4057-96ef-574892f4c902	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
1488396f-2958-49ae-9954-78632f65e37a	34ad3d09-04c4-4742-8d0e-636c9911b705	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
e7f11be7-4ce2-456f-bda4-7ffb43e85b29	20540d62-4f1c-46de-a26a-eebf606da62e	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
c1a337b7-2236-465c-912d-e5d554d8ac3c	aea2fe4d-d38b-4081-a1e4-e8709698c32d	d67fed11-7263-4de6-b813-06eb33132975
98da5fa5-a434-47b6-bfc7-b5ffa29cb99f	ab00abf8-c4db-4814-bbb4-5b60607626c1	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
6f6edfe4-fca3-49f2-8745-040b1e26a161	05b57ebc-2271-4847-a183-ba6efa50363a	d5d99db0-2cc4-4ba7-a251-02cc05406f08
ace99336-7f56-498a-8def-4bd31c59f076	99e6d9c3-c00f-41f6-ad3b-069d662f61c9	d5d99db0-2cc4-4ba7-a251-02cc05406f08
884835b4-aab3-4fe3-9094-e35273050aa4	1bbe8294-1c88-4538-a9b0-30065d2e9460	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
07b18db4-8cb1-4ade-b34d-628f35fef1f1	05b19571-234b-4a3b-afff-416ea1acbdb0	d67fed11-7263-4de6-b813-06eb33132975
645db442-f718-4196-ad99-b6d8673dc0ec	f4afa11b-9d3b-4088-88b4-830f648d472c	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
4464ad38-6a4a-4c1b-b018-841dd3c53188	fd6abb92-ad82-491a-92cd-2d6790a1fcff	d67fed11-7263-4de6-b813-06eb33132975
0e8e52cb-288c-4f24-8c2e-7cb11d44ac93	db26ecd1-7a73-4ca2-ab26-253bd00b48ef	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
dc49b531-2285-49fa-b2b6-1482e0b08095	1883297e-5445-4f0d-af44-67582c85724e	948f9273-0239-401c-bfe4-37a871499e4c
ce470164-a3c1-41a2-ae3a-66a5ac89589f	8aafeb43-bc26-4669-bd7d-011b12bb8e0d	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
35c26581-2a74-4038-a2d4-2d2f2dcd9bbb	0fd638df-1155-47f1-9909-d70973805f33	d67fed11-7263-4de6-b813-06eb33132975
a38d4920-2a1f-4666-bca3-2f0d64ad388b	3e2d9e10-bd31-4ea8-9a34-52c1266f4039	948f9273-0239-401c-bfe4-37a871499e4c
e21eb7d6-7468-4827-8822-6b688d1d949d	28fabb64-c648-44da-bda1-cbfa0d95f2ec	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
c5c26608-545e-4c69-9bf1-a63d2a634a72	de3a696b-c07d-480c-8d69-3b444cdeef84	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
f07f4cce-1ec9-42be-80ff-3f7fd4f81e44	26609761-27b9-47e0-aed1-29ea37b86307	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
e203a1df-ca6c-4b73-ab93-b98f8b86939b	556a34ab-6212-47f3-ab0e-f68f2d44bdc3	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
f2bf3595-d3f6-426a-a6fe-dcb835c785ff	d0568df8-dda0-4cf1-9abc-a29508350191	d67fed11-7263-4de6-b813-06eb33132975
44998c91-832d-4333-87fa-58a6cc1df3af	22070504-b248-4794-9377-2327e1fa6259	d5d99db0-2cc4-4ba7-a251-02cc05406f08
fec2322e-46a7-4746-a827-347498c540a4	064decda-bb06-429e-8111-679c35681316	d5d99db0-2cc4-4ba7-a251-02cc05406f08
e6299d4f-793b-497a-ac5c-5bc299785d2c	e048bd6c-a65f-4c90-bf7f-cf03c1b06a90	97c7b202-02ea-46e7-80e4-2f5303d96a1a
f0c4b52b-dc50-4df8-9ba3-bf6dc656b969	7bb07689-1d69-43fe-8f08-9c2fcd7e3c45	97c7b202-02ea-46e7-80e4-2f5303d96a1a
a9312959-781d-421c-bc68-af3c1b98d81d	adc6f36f-20b0-4177-8001-6a2a6d07fbdb	97c7b202-02ea-46e7-80e4-2f5303d96a1a
c98ab221-7c4a-4940-bf1b-e01d70797417	11a33a9e-1738-4c73-95d5-308ebeedc0f9	97c7b202-02ea-46e7-80e4-2f5303d96a1a
85e92f27-6129-4a1a-ba94-44329d6690c0	4d2cbec6-ff18-4182-aecf-0e2902b6970f	d67fed11-7263-4de6-b813-06eb33132975
6d0367e3-4181-41a0-89de-b06dde1e16f5	cac0987f-3e14-4b38-a6e1-59f4fe8206f7	97c7b202-02ea-46e7-80e4-2f5303d96a1a
a87487f2-3aef-46d0-8e8b-1b13eedd3753	585715a2-94ee-41d7-bd73-70259f4ae918	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
7d43b792-a03c-4b5e-a1e1-4f0f87c3c0e1	ea65e223-027a-488b-8178-1c73cbcf4979	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
ff93bd64-d961-4c24-bbb1-6fa2295c3d56	4e0873f6-f934-4410-b6e8-aa604b7341b5	948f9273-0239-401c-bfe4-37a871499e4c
324159e2-a237-432c-854a-9ce38dd37dbd	725755a1-0c93-45e7-b75b-a42a411bd255	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
e72272dd-2a8a-4aac-ad2a-f911700afe78	c99f847c-bfe4-4b96-89bb-a3fcaf63ee72	0bbc764e-6049-4d09-a2c9-e3505a24ac84
2d70c564-4842-4814-8546-2cd2d929127a	eb3b2396-bd30-48ff-a344-32088dfb5500	0bbc764e-6049-4d09-a2c9-e3505a24ac84
5ac831c9-aeda-4699-81f4-a16ab8a0dede	54d9eec5-e395-4bb4-98be-c9150b704218	96814388-e785-4b90-a6cc-0933bf685340
d2f2f16d-52c4-4077-958c-797193a2d3a1	bfd3ccf2-5912-4ea9-9c66-8eb30c6cfddb	0bbc764e-6049-4d09-a2c9-e3505a24ac84
5096aa29-ad47-4ce5-bcec-1d5ee3ea29e3	7fbc3b89-0f1f-4691-ae81-1e70b1be9733	0bbc764e-6049-4d09-a2c9-e3505a24ac84
bf771c1d-94ed-4f2f-b26d-de852c15e052	43cd46d6-f192-47eb-95a9-a2783f5fac92	0bbc764e-6049-4d09-a2c9-e3505a24ac84
0b787289-f231-4bbc-8d14-afd039ea0f68	eb70e639-7ca0-40bc-b49e-4734b020e8c6	0bbc764e-6049-4d09-a2c9-e3505a24ac84
9fdd2bf2-a42f-4e9c-8f1d-fd53fe687835	ce163171-661e-45a0-8299-852239060ac3	96814388-e785-4b90-a6cc-0933bf685340
055bb07a-d9f0-4eee-a0fd-b308b7ccf8aa	7dab0a8f-8959-4c6d-b4b1-0d2388ad0cc3	96814388-e785-4b90-a6cc-0933bf685340
e1953493-536d-49ea-9132-e1757baf8854	04bd796d-e5d1-455a-b73c-956c8b855c6f	0bbc764e-6049-4d09-a2c9-e3505a24ac84
b1b7d48b-9682-4888-bb95-7075fd7954af	c13a5f25-4437-4b8d-9b89-12abbd2dee7a	0bbc764e-6049-4d09-a2c9-e3505a24ac84
1543f593-88cf-49e4-bb77-a581bb91e5fa	9072e4f4-6e31-49c2-b840-c46f883486fb	0bbc764e-6049-4d09-a2c9-e3505a24ac84
66d2c093-3d6c-4d6e-b3a2-c24d50f5837e	9431ef83-8a15-40e2-9192-2f35d3083d44	0bbc764e-6049-4d09-a2c9-e3505a24ac84
896ecba1-54c4-4124-b351-760a7b2e6461	286f3f5c-cbe0-4055-96c9-79b6663dff27	96814388-e785-4b90-a6cc-0933bf685340
6d62352f-1aa2-48da-8809-8ad23ae699c8	63243e88-8217-4b6a-a546-b21c47c538bf	96814388-e785-4b90-a6cc-0933bf685340
35e7e3da-b5ae-48b9-acc9-f783865382cb	4bfc1d24-2793-4d31-938a-d8f2ff25bb98	96814388-e785-4b90-a6cc-0933bf685340
44fa2336-1949-4453-bcb4-1adacd9df0f0	4ce9c4a0-0072-413b-ab4a-5c2b5921e943	0bbc764e-6049-4d09-a2c9-e3505a24ac84
48512aff-cbe3-452b-9da9-67ea0934cafd	16ce1e36-f68a-481f-831d-95ee59447c5f	0bbc764e-6049-4d09-a2c9-e3505a24ac84
88d12d6d-628f-4e8f-9f72-052142ee15a2	3dee8ad4-59e8-46ae-bed1-a8f59833854f	af5868a4-b5d9-41ec-8ba2-0164773e8dbc
a1c802a5-ffb8-4b8f-956c-19b51fe24135	e6cfaff7-6e4a-4e06-a5ea-861ae2cd0214	0bbc764e-6049-4d09-a2c9-e3505a24ac84
ec163e0f-8aca-4192-b198-3ddfaef6767d	d9d2e8c1-2e2c-4b12-9670-4e201a891dfb	0bbc764e-6049-4d09-a2c9-e3505a24ac84
663876a7-2c66-473c-a3d8-b778fe3ca7b1	602c5c6e-a9fd-4060-a215-31263c6911b3	0bbc764e-6049-4d09-a2c9-e3505a24ac84
c1d17a24-8988-4039-9e8a-6b6492a2e9fe	d8cb5f3e-5212-4edc-912f-9816de9394f7	0bbc764e-6049-4d09-a2c9-e3505a24ac84
1f0d1795-d272-4ce9-9ac7-4ae053dcf0af	0306b3fb-0261-44d3-85c6-a3e11e1b3fce	0bbc764e-6049-4d09-a2c9-e3505a24ac84
c51aa249-6b3b-40c7-9bcc-8f9aaf6cd885	a702a1dd-efeb-4e33-9b94-660fe1702a52	96814388-e785-4b90-a6cc-0933bf685340
89c7754c-c4c3-403d-b883-9dc01f0a795f	c205cd74-8a39-47c2-8c9c-4373b080e0f8	97c7b202-02ea-46e7-80e4-2f5303d96a1a
f8954599-f29d-4edb-82c1-1f29d81daed5	bf98ffe0-8105-4c64-ad92-4e8738630622	97c7b202-02ea-46e7-80e4-2f5303d96a1a
4c0aee97-ae0f-4b33-9730-3c49eb966fec	4d68016f-90a4-4416-a830-e34d4ccc4170	97c7b202-02ea-46e7-80e4-2f5303d96a1a
096455ce-e506-468e-b749-1e6f8b7cf066	21507fd1-9303-415b-8b09-a841252985d3	d5d99db0-2cc4-4ba7-a251-02cc05406f08
b73c5898-803c-49f2-9806-53226948e9e9	8c1c6cde-c437-4611-8b85-f59c04db9912	97c7b202-02ea-46e7-80e4-2f5303d96a1a
fb7fddc7-079e-41b0-b40f-249f5c601d0a	9be28166-b7a4-4010-8a06-d795c2c1bf55	97c7b202-02ea-46e7-80e4-2f5303d96a1a
15b582e6-d5db-4b34-93f0-82ba406a0a5c	0851dfa7-9103-4755-a4ab-3ef6c08c044e	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
9e924eff-0c7b-402e-8745-d170e91cdfea	7cceb40f-56f0-483c-a5bc-e88c69e0e5e8	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
051aae35-2dcf-4fbc-a8f0-6a8ba1c43dce	adb03bff-4f9b-47ae-9654-106891133a52	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
c2fa56ac-4175-419f-b625-5d22e52d3915	5414f3aa-5ea3-4b97-88cb-1e4acdf996c8	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
ef017459-fc25-4584-a508-eaa25dd66503	d43a7bba-38be-414e-8c55-554ff2a0bf82	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
7a6fa2ff-5432-4d4b-81bd-3f3aa83bd22a	8ddc1ccb-29b0-4c37-a826-d1e19f649ab1	6d0d910e-1e78-412a-adaa-df7fc3fb3e6f
2e059cf0-9ebd-43e6-b314-fb93e9a2e8fc	7f9552a5-bdc9-44d4-9d14-499b93737a24	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
32ab95c9-f811-4342-93b3-19e99ba4dae4	491228e7-2318-4043-b9ef-77057fac95c0	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
2ea5e65b-678e-4514-ae08-42bb8eaf7725	7a68a7ae-719a-4c74-9b3e-315616e8dbe7	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
2e7b88da-27c8-45eb-a1ab-98a1cd9cb8ee	9f0ab818-ea50-41cc-b6a7-2f829f3faae2	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
66b36ec3-48b9-4a86-a5a0-ef2d577ead6c	438a6d7e-5dc2-441e-aff7-ad842ffd5601	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
9a5d255e-ea27-4765-9371-68cf9cc412ce	90fd8c72-8999-403f-9bd4-7436d2af4c6a	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
6bfdee8d-8c1d-42db-9380-2c751f6d5d9a	52af29ed-cd46-4691-be09-49a342ee1663	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
c3033523-d188-48f0-800a-b136f9d43051	93db068b-c731-4e13-9b0c-fc70dda20169	6d0d910e-1e78-412a-adaa-df7fc3fb3e6f
4c571740-c431-41ef-bb9e-cc1293f47d73	853659fc-368a-4842-85f7-5051aabf91a3	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
6b59f6f1-e215-42ce-a014-913de2a02781	9a321b09-11ec-4a90-9504-759e9a3269ac	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
6a7f923c-c422-417a-911f-6e175481a26c	345747ac-20a9-4fb9-b6f3-de41ba7213aa	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
b66ea528-633e-4323-a893-effb64dbe20d	45ad5059-250e-4525-aa66-eb95d21f165f	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
7658f786-35c1-4e34-9ac7-0e93648c02e4	84007ba5-b897-433d-a764-4f5be9ac2931	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
231096ae-87b0-48e2-bf7f-2b076d9d07bb	6aeaa888-7f7b-4a09-81cc-e596998c96e8	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
307784f0-45a5-46b9-8775-0e4a5fe896f4	75710a8e-ba2c-4fc8-8136-b6da6640e55c	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
d759292c-31e7-4ad7-9406-3488adf1ba12	8c01a18f-fda9-431a-aa89-b45f95af5470	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
3e8c15a1-c9ee-4df3-83d0-6d2b4498d2b6	3122a21b-9612-4ed2-9b3c-25ba9f24e2f3	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
5a6c9ff1-834a-483b-bc71-5342a80fc224	44edd45d-5c3d-4562-a028-bb255b67d492	97c7b202-02ea-46e7-80e4-2f5303d96a1a
c1a15826-c1eb-43e7-a1d9-d6d7446b1e36	9be4d8ca-e4ac-4d1c-84a1-4cb262b2cc42	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
d40ab843-aa6c-43ad-83f2-61dd0094dc5b	44994f28-e612-4eb0-92f7-fcd8b4e5f600	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
625103e8-4ad6-4dd5-b6f4-b01fe6a86ac3	506dbd51-8921-4902-9179-2d24d4cf1f45	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
4cda362b-29c6-4bb5-a675-8c633917a6d9	ff8fb21e-a82b-45db-b723-b97889e8afc6	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
46b4b00d-494f-43fe-9b7e-dfe402461468	835050bf-3867-45e7-a02d-bbe741aa1bb3	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
2bd3a11b-684b-4fb9-93f1-b434359df419	383c3111-5303-47af-9151-2bb299f0eb28	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
32ede942-86a2-4aa2-8ac1-df30266442d6	07e21d38-8a0a-448f-8761-a5c2786b29a2	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
5030a885-fc4b-4cc5-8e61-67664bbe25ad	09b97077-7d8f-439c-94b5-c66e2cc5a472	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
635169f8-72d7-4ef1-9bb6-9cd41d6e0727	c2f6dcd3-529d-4ca4-b84c-b83c633e3ce2	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
5b9ff06e-327c-4a98-9453-91f90c45a135	130fc5ec-e7a8-4142-853e-d9be084c40b8	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
95ef0729-7e8d-42a8-8e2a-689d3e8c93d6	45860172-eb7e-4b58-906a-f487073b051b	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
9528a160-fe5c-4263-94cf-d900a9d37513	1574f83c-56c7-4bb1-b60f-b627ba701449	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
e5f9cd91-ec0a-4a87-95f3-3b6f7d0bbb69	466019fb-284e-4818-84f2-a812078a3045	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
ed961c1b-2eb0-49ca-baaa-03bdc1f49a07	b2ff8c73-38dc-4d98-b54a-5f5bc6099598	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
5806a60c-32b3-4c99-a2e6-af4a069a7fa6	7f72566b-2d68-43fc-a0c3-2a29baa3d370	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
9d416cb8-8829-4d61-9ba3-8475566153cb	f4349416-f1f3-4522-ac2f-69c363418700	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
cb57775b-fadd-45e9-906e-422092621040	1dedee5b-ce6b-453a-bde9-6f67a3decd92	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
92dbe4bb-4cd3-4305-ae1c-857f50f89da4	bea8c7be-5b7c-4dc3-80a8-ee675895e13f	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
a67df75e-01b8-421e-8fa0-2d5d76d34753	b166f660-eea5-46b4-af50-e71d5554cd8e	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
9c01e41a-ff88-432d-bf62-259bea1a4c8e	760d3855-65cf-48a8-b2fd-42fc02435802	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
764f6b90-7c56-4e2c-910f-7d7a64b78dd8	9e6dc627-b199-48d3-9253-fd8badb06070	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
ce0f1760-ea0a-47b0-b579-9cb6cb937feb	971ea270-5039-4851-9d86-a09a8e75c5b2	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
d5d39949-bddd-4f75-924c-4a31b8726745	81c5aead-4092-47eb-a862-0f6d35222f3b	6d0d910e-1e78-412a-adaa-df7fc3fb3e6f
a4a4e575-8573-4352-9975-6ed53f79220d	45eaea86-0169-47ec-8e9e-ebecccf3fb23	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
455ab605-addc-4de2-90dc-65dea93e7574	fcefd6f0-be68-4cf4-8a3a-d12ba5498e92	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
d338aa88-2139-4a5d-a23c-edcff6018f31	eafc63bc-edd2-46e4-b96c-f3ccd9ea3056	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
64acc1e1-0cbf-4795-8a11-a06c0b278acb	d442a912-07d2-4bf7-87aa-eaabb9f3a31b	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
e51bb3ac-513d-4311-93f3-4651c0505e75	875188f6-51d5-44db-a801-0969bce3b98d	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
af459088-1d9e-43b6-aeee-f9394bc5bcd6	ab7a00df-ac68-442c-9e7f-be5915ff83b3	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
666f431f-cdfc-49cd-9d4b-599357c77c06	9a9d3acd-d50b-4b3b-be5e-9e88f0f80e0a	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
d39a12fc-5e6e-468b-aeb7-7994f46c36af	6ab16e96-64c5-4b86-9999-494b68085604	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
0b26040c-f6f6-4a39-bd1c-4565940eae3f	8019ade5-008c-4a71-8279-58344df330d8	6d0d910e-1e78-412a-adaa-df7fc3fb3e6f
47876879-8471-4062-90d0-05141115fe1e	c0cdefd1-2eff-45c5-8327-e3cd1c8e962e	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
c3a0af05-c8be-4288-9bc2-921d1217ebd4	8070208e-c1fe-49a3-9c02-d9e5939972e3	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
86eb87aa-97f5-4137-a3e7-2d7ebbafeff8	76da99ba-82aa-4918-8322-1057463d53bd	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
ee6a9e38-baad-4ac7-a6a3-dae212052d84	f2477f78-a9c3-4804-9575-5244a8a62e6b	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
4fb27df3-13d1-452c-b2e5-b26f5f6d169a	48461ecb-7dad-40ba-a01e-c8fbe2ae4948	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
a209b742-0b45-4c75-9a79-b13d4ff3c1cd	f70c5fcb-29fe-4e62-ab78-61dea7e5fb51	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
690668f2-5c35-473f-96c4-fe189a6d2e20	91e950d8-5582-40a9-881d-0d4e4233a05d	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
f89b6b92-fef6-477b-9f17-73355a6b6c17	ec30d151-8593-46fd-b923-b3616d9719e4	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
8ba1c0f8-cedd-4d15-854e-8f8931fe96be	e8c991cd-6d98-40fa-8e81-7e0a53e03abf	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
9ed08c66-3343-4212-85bc-0756f5b51490	e3b0a020-b8a3-491d-9c41-c2ae36121ae4	6d0d910e-1e78-412a-adaa-df7fc3fb3e6f
2df9f8bc-c2d2-4141-8e29-cb1560282972	3220cc29-ba9a-4e3f-ae02-f937d32046bc	1f673d38-18cc-4fdd-ad4c-5b8c7b1fab2b
ac2b4a31-a40b-4634-9c7c-fcda403e2d85	5921ebe8-2aa4-4af9-a470-0c06103aa6c8	e75ee99b-d2d5-4c1a-9ec5-a573e3e35ee9
9c86de08-4986-4b69-8b80-213c56d1d8a6	a72aca7c-8889-4ebd-a8cc-d02a00626f66	4443011d-b301-4778-bb98-e8f1d09015c5
b9ead023-e0e9-4f17-81b5-1c570879adff	e3cc7486-6412-403f-8501-109b516eb9dc	4443011d-b301-4778-bb98-e8f1d09015c5
84d3544d-edea-49cd-9450-1dc2f46bdc0f	74e16c3a-2242-4f49-a81e-9ea3babf9c82	4db6d042-973c-4ba3-9598-3b8b682691b7
1874a790-6e37-48c9-af83-96eae7c77397	bd7d50e1-2e4d-4b9d-8468-62a39411c051	4db6d042-973c-4ba3-9598-3b8b682691b7
e0df569c-b63b-4b4d-8d8a-fcb373a39515	b89e93e5-ae1a-41ac-8839-7d9af5b2b743	4db6d042-973c-4ba3-9598-3b8b682691b7
50e9a8d1-b18b-4b54-93b8-8479f5497754	54d863db-e0de-48aa-aa30-de6571b1f731	4db6d042-973c-4ba3-9598-3b8b682691b7
aba96342-ac41-45f2-831b-5b37f9fb517c	af0e3623-e22e-41ef-b6a7-61bca53cd197	4db6d042-973c-4ba3-9598-3b8b682691b7
cea60a6d-3bad-40ae-858f-34c886be38a7	7c22dc89-e61c-4496-af68-7faad9744af2	4db6d042-973c-4ba3-9598-3b8b682691b7
435ecb44-8d6e-40e7-b55b-5297244cac24	e272fe3f-78a3-45ea-94e8-d1ab98697bfe	4db6d042-973c-4ba3-9598-3b8b682691b7
2412ecba-5fc0-40c2-91f8-71be2817746a	c3383912-7f86-4b9c-a8e5-34c51994daa7	4db6d042-973c-4ba3-9598-3b8b682691b7
ab03679c-de47-4477-a6a1-1fdbcebc8365	ba58637d-28d4-4069-81e1-de019afb713e	4db6d042-973c-4ba3-9598-3b8b682691b7
f2ff66bf-45ac-4d48-aea0-96015ce42d0d	8f024973-acd0-443a-a730-f0e0304b9f74	4db6d042-973c-4ba3-9598-3b8b682691b7
bf222bee-e5e3-409b-a0a7-2842740cae76	4a08a05d-0952-42d6-a081-af8a24fee821	4db6d042-973c-4ba3-9598-3b8b682691b7
e5595891-9277-486f-a05d-aa20604f0e40	17183098-78bd-44d0-8fab-05c422a0cf55	4db6d042-973c-4ba3-9598-3b8b682691b7
0bbfa1be-32e9-40b7-8855-51607c539404	d6401cf1-175d-42f9-b84a-5c4f385a9d93	4db6d042-973c-4ba3-9598-3b8b682691b7
cefe753e-73e8-4bed-9fa2-6f409690aa43	44a1d007-4a1b-4195-8622-2b6327ce7498	4db6d042-973c-4ba3-9598-3b8b682691b7
8250cdf2-3292-4f41-9bc0-5e92b4f9df38	2f4605f7-ddc6-4ef8-bf83-667e575244d0	4db6d042-973c-4ba3-9598-3b8b682691b7
ca0c3d9b-94c9-4890-b416-c5424294ec88	a60bc086-f5ed-46bc-8f81-64bb74b7e367	4db6d042-973c-4ba3-9598-3b8b682691b7
95904e29-7077-40d5-bec7-375d64dae570	76b044dd-27e6-4e82-9c66-eac6b2d0005f	4db6d042-973c-4ba3-9598-3b8b682691b7
4fae52e6-1ef0-42d7-8dbc-6956e3644fa3	83aee2e8-2851-470e-bc28-ce2c2330a72e	4db6d042-973c-4ba3-9598-3b8b682691b7
38ee201e-3d17-4f1d-82ff-4ae3dd8e9de1	de49c7da-6ac0-42a5-bbb1-8675074a3e2a	4db6d042-973c-4ba3-9598-3b8b682691b7
5fd131c4-52b9-4fd6-8904-0fe9f7c8e60f	631cf878-508c-43fa-abca-0879653194ba	4db6d042-973c-4ba3-9598-3b8b682691b7
f7e4adb8-3da8-49eb-b72e-69152d3f4e11	6720bdaa-dfc7-419b-add4-1b7b9180ebea	4db6d042-973c-4ba3-9598-3b8b682691b7
962c8d7f-d621-434f-b2e7-df4228033950	50a38de9-3992-43dd-a365-dd889f058802	4db6d042-973c-4ba3-9598-3b8b682691b7
d789ef23-f980-4ac8-89c4-f98409d24a73	1e08c0ad-862d-4b87-a3f7-e506e20d54d2	4db6d042-973c-4ba3-9598-3b8b682691b7
563ab4c2-ba0e-4a9f-b660-6befe7dd4003	4e8606d4-9294-422c-9119-a8e90758c3e4	4db6d042-973c-4ba3-9598-3b8b682691b7
09e4d6ae-c72e-4236-9a33-ff7cdfcb3da3	ede3001d-29ce-4f0a-84a0-db51fef18069	4db6d042-973c-4ba3-9598-3b8b682691b7
b85cbd0c-48c4-4ead-9332-62854b48ee28	35d2aad3-e1b8-4b40-9a36-7aecc55e7bbd	4db6d042-973c-4ba3-9598-3b8b682691b7
8c773612-2f4b-490d-85ab-f009125addb7	6eeb44ed-c963-4f01-9610-247ffe63fd68	4db6d042-973c-4ba3-9598-3b8b682691b7
7fc95746-21d5-4bb2-ac26-467d12e13338	df2ca7f9-3730-4831-8f90-3da707e179da	4db6d042-973c-4ba3-9598-3b8b682691b7
a3f089ff-4a69-4111-a27b-2cf10e3c3514	fe3945fd-36ad-44aa-acce-654cfafbc13f	4db6d042-973c-4ba3-9598-3b8b682691b7
ba1ca347-2d8a-42a4-9ba2-4f4aa8ce5f7e	a75f5339-6cda-4497-89ca-1758ba55aff5	4db6d042-973c-4ba3-9598-3b8b682691b7
2c0d00a2-bc2a-48ef-9dff-9eaf2562ac5e	632db9d2-4bd2-460c-9514-d74bb5e87762	4db6d042-973c-4ba3-9598-3b8b682691b7
4b4209f9-e100-4daf-9e27-cd3928e8de27	0bd74f14-bc42-47dc-ba39-912895d0152b	4db6d042-973c-4ba3-9598-3b8b682691b7
81dd6357-acbd-4665-a7b3-425677d0e5af	6a3a558f-20b6-4a4d-8931-8362464a3cd8	4db6d042-973c-4ba3-9598-3b8b682691b7
567d8d0f-c42e-4eff-9464-b00d84ab7a22	86d0bdee-d881-4084-afe7-b2c4711144d8	4db6d042-973c-4ba3-9598-3b8b682691b7
b19c9313-ce65-4a1c-99aa-9cfc5b984f51	efb96196-6e66-44a8-8e2f-5e7037865ef4	4db6d042-973c-4ba3-9598-3b8b682691b7
ae122ff6-027b-4e59-b58f-785665e3fecb	718d732f-2215-4dd4-aee5-97051c596005	4443011d-b301-4778-bb98-e8f1d09015c5
e9efc973-e1f3-42e7-8495-e317286233ce	bc15a18d-3a86-41ac-a8d4-8fa8ed951788	6d0d910e-1e78-412a-adaa-df7fc3fb3e6f
\.


--
-- TOC entry 3585 (class 0 OID 16518)
-- Dependencies: 224
-- Data for Name: SubLocation; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."SubLocation" (id, "subLocationName", "mainLocationId", enable, "createdAt", "updatedAt") FROM stdin;
ed9ee400-d2d1-4341-aa1b-d5a8a4ce1ff0	Lux Riverside Hotel Apartment	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
1f9ab735-e5cc-431e-8aa3-55702f09afa4	Onederz Hotel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
9de46936-22fe-40d9-8cec-7edd38d7db17	Other Location	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
216143b5-bad6-44a2-bfab-3972cb66b8cd	Park Cafe opposite of Airport	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
f57bd37d-1197-4738-92df-09cad5812228	Pavilion Hotel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
18b52370-ebc8-4871-b113-f01eba6469a5	PHN Airport	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
f182bb98-d81b-443b-95ef-c9b2d643e7d7	PHN Office	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
a5aedb7f-f2bd-472b-b959-f506199fd201	Phnom Penh City	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
7f9d4e7c-b5c0-40f4-b749-01ec83338f40	Phnom Penh Hotel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
18824952-7d46-4ba9-8934-b6628300de86	Plantation Hotel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
d12b07a3-5a0c-4039-9d16-4db64755d064	Ratana Plaza	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
584fd90f-13aa-4510-bba8-4c990e27d76f	River view Cambodia Bou Hotel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
28dd9458-5e2f-4348-a8d7-8e4fc4ac0625	Rosewood Hotel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
f6220d82-52dd-4f77-a90d-24b9627aba4f	RUPP	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
8ff21f09-5018-4004-a386-4d23cec3cf76	Sofitel Hotel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
f69e26a6-0ea3-4a97-9407-fed52327abf3	Sun and Moon Urban Hotel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
1aa3a5e2-17be-41aa-b5fc-f7ca4c836922	Sun rise Hospital	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
93d14ab3-5c01-4d8b-8ca0-1782f724b842	Sunway Hotel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
be6fb990-649e-417a-83e6-c7f749c541ab	Tamasa Hotel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
33fa6d73-b485-458b-af84-23ef844d7f76	The Big Easy Hostel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
5c6e6a92-fc45-461a-af23-beeceeb85cb4	Tith Chara Hotel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
bd115816-9838-4f88-a480-627629d80978	TK Venue Toul Kork	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
fe4a988d-b4e3-4316-aa0a-c197aac99f04	Tokyo Inn Hotel	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
fcc060e2-7726-40cd-bb11-0c2e4350f62e	Tuol Sleng Genocide Museum	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
54ca465d-3587-480b-8025-77d1d7e2166f	vKirirom Head Office	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
9e284787-ca4b-4035-82a3-6709b5c4e64a	vKirirom	2eafe9e7-f757-4e35-8243-6108b3d6b1d6	t	2023-07-14 12:21:38.353	2023-07-14 12:21:38.353
0707bab8-9439-4f15-86ca-354c9b298132	a3a	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2024-01-11 19:07:01.269	2024-01-11 19:28:12.662
0becd4e0-b296-4dc8-b01e-4de6ae0c51ac	a2a	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2023-07-14 12:21:38.353	2024-01-06 16:09:10.588
57838944-27e8-4750-847b-b158f80e2ae2	vkirirom head office22222	db04eb04-8ac1-4a7d-96eb-d2c3742116f4	t	2024-01-11 19:05:24.951	2024-01-11 19:05:24.951
\.


--
-- TOC entry 3586 (class 0 OID 16525)
-- Dependencies: 225
-- Data for Name: SuperAdminInfo; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."SuperAdminInfo" (id, "userId") FROM stdin;
\.


--
-- TOC entry 3587 (class 0 OID 16530)
-- Dependencies: 226
-- Data for Name: Ticket; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."Ticket" (id, "userId", "remainTicket", "ticketLimitInhand", "createdAt", "updatedAt") FROM stdin;
b039ddee-1814-410e-9c9a-fd67e1c1b25c	10b26249-f81b-4bd8-ab36-2d41b02dc9e1	24	-14	2023-07-14 12:21:40.721	2024-02-05 08:21:50.996
36780afd-4fbe-4a1e-bbf0-5b9e86c26ea1	f6ef71a7-3cd3-45d7-8236-128280ca1fc9	10	-22	2023-07-14 12:21:40.872	2024-02-05 08:21:51.009
6c1f3ea1-116a-4fd8-81fb-e9110c7b0dfb	6fe89cd6-a5a5-41bf-9c21-c39982ed3922	36	0	2024-02-06 08:06:22.424	\N
9b8785f3-139f-4aea-8399-e85ff0059035	58f5f21f-5de4-4f26-9626-c01a48c3e5da	24	-26	2023-07-14 12:21:40.813	2024-02-05 08:21:50.995
468a859d-bdd1-47ef-962e-14cb7434e517	f5bdcfd9-8130-44bb-a0ad-aa03c5a36f63	29	0	2023-07-14 12:21:40.704	2023-07-14 12:21:40.704
a19e6ac4-ae91-4199-bb1d-1bc470188606	1e31af0a-a481-4a32-a3f1-3a47a88abfae	34	0	2023-07-14 12:21:40.975	2023-07-14 12:21:40.975
d94ef3d8-53c7-4f53-a60e-7b97ed69c68c	be1b9bbc-b791-4b23-8df2-6ec9c6fd9e5e	31	0	2023-07-14 12:21:40.832	2023-08-11 14:12:50.577
92cd6f4c-bd00-4e09-97ac-942e33e51f11	933af6e4-2587-4737-b357-fdb71c12732d	24	0	2023-07-14 12:21:40.68	2023-09-08 17:11:34.52
959a9153-e9d4-44b7-858e-b994f6348869	f09e7966-6ea2-4520-b933-744b35a147d3	22	0	2023-07-14 12:21:40.749	2023-11-09 03:55:43.663
ece3a249-1245-4f3e-9483-b71b76385b58	7e195416-d966-4255-ba5b-cfbd338ccbf5	32	0	2023-07-14 12:21:40.642	2023-07-21 14:52:06.064
e98962ba-bbf3-4652-834d-6a734e7fbd05	6c9db7d1-f3f4-440f-91fa-504dd0254f52	22	0	2023-07-14 12:21:40.662	2023-11-03 01:20:10.02
79ea0ac1-e9af-4679-8864-b09166e9057d	dbec9d85-ed36-4bbb-8464-88128c099874	32	0	2023-07-14 12:21:40.98	2023-08-11 14:11:26.673
0a23730a-dfd0-4aee-9252-c55eddf87b26	ca22a660-ac87-4467-9cae-95e7d4a0f593	28	0	2023-07-14 12:21:40.738	2023-11-13 06:01:12.826
2eb6bf02-de5d-4237-94d7-01571db56114	96df90ce-813d-4d1d-ad21-c110218a161d	22	0	2023-07-14 12:21:40.802	2023-11-13 06:01:12.84
c8c6706d-dc01-4cc6-a044-e38eb9e6c334	cefc8313-6752-4fbc-bf0c-74e65c1150c3	32	0	2023-07-14 12:21:40.997	2023-11-08 05:41:37.953
5ebdad53-841f-4ba3-a237-9b1ef7ffe7eb	8d80f5a8-193c-40e1-ba3d-ec74c4420810	31	0	2023-07-14 12:21:40.992	2023-11-09 03:55:43.643
2d4eec67-8eaa-41be-9cac-8d15eda9bebc	8b8cadc7-89cf-4f9e-95f9-7912ff9ab44c	31	0	2023-07-14 12:21:40.866	2023-08-11 08:53:34.774
ed77c98b-e445-4e8d-88e8-0771af7cdb0e	b4948d5a-24e8-4434-b990-842c3cc8b71a	27	0	2023-07-14 12:21:40.86	2023-11-09 03:55:43.625
c58d8133-57b6-462b-b660-0641f2768a6d	74925e2d-6d3d-471e-8ce2-a8826c429d94	27	0	2023-07-14 12:21:40.854	2023-10-17 06:42:36.425
0ba893c1-286d-468c-a351-a9c178f8b5c7	3a14a4c0-7355-4b34-af81-ba8cac6ed89c	30	0	2023-07-14 12:21:40.9	2023-11-09 03:55:43.663
4b1fc68b-d96c-490f-8b9d-de4f28170228	2cf3a4df-3b54-445e-8532-4e4dfcc38f48	29	0	2023-07-14 12:21:40.945	2023-11-10 05:26:54.5
2d3226ab-1817-4d77-b928-d1969206c415	465f7607-be54-4947-90f1-aabf4355d623	29	0	2023-07-14 12:21:40.807	2023-10-28 01:24:52.022
ae5d24fd-f48b-4829-9503-58565333c00d	88bfc3e3-b7bf-460f-9e95-160bc46b984c	29	0	2023-07-14 12:21:40.838	2023-11-13 06:01:12.834
ef82691b-661a-4012-8332-c451079ff60c	dc659915-4204-486f-a91e-010721352352	27	0	2023-07-14 12:21:40.877	2023-10-17 06:42:36.409
bd4d513f-6d19-4a13-98f0-3ec2bf453583	db2f28bc-933b-4a4d-b850-e4cbcfee4782	27	0	2023-07-14 12:21:40.933	2023-11-12 06:22:22.139
68cef6a0-985a-4a3f-bbbe-82cbaa570dc5	e2ff6211-22b0-459e-8976-612c89675db6	25	0	2023-07-14 12:21:40.785	2023-11-08 05:41:37.949
cee89a8b-7d27-465d-be1c-cc3af5a170db	1140db3f-d07d-450f-88ab-26ad9b88f657	28	0	2023-07-14 12:21:40.716	2023-10-06 05:42:44.044
e38a2237-b993-428a-9928-15edc92b4a7c	a3246906-ea72-4d4a-8beb-eb87463ae71f	32	0	2023-07-14 12:21:40.957	2023-10-19 06:25:28.279
eb83e5f6-f4e7-4bfc-b837-9a88c2a861f5	d6a68749-90e9-404a-b304-3918c9f827d0	28	0	2023-07-14 12:21:40.843	2023-11-13 06:01:12.837
df03c776-74c9-445a-bdc0-0c78d26ac90d	fd4cd666-cb75-4ab0-9e7f-77dc1e0ebd7f	30	0	2023-07-14 12:21:40.849	2023-11-09 03:55:43.631
f7c45c4a-edbb-4b4c-a9f8-4d7a95fe2902	f49f756f-0e95-4fcb-8102-e0a82f07124f	27	0	2023-07-14 12:21:40.906	2023-11-13 06:01:12.831
03a757e2-6711-44d8-b24d-ffb620c52e7c	3311f813-d9ee-4d42-a981-a55089ded559	28	0	2023-07-14 12:21:40.726	2023-08-20 07:53:33.878
d2bca436-eeae-44a2-94d4-a466f2959de4	09b68251-c4e4-424b-879d-d4383971201e	25	0	2023-07-14 12:21:40.791	2023-11-09 03:55:43.623
8c570638-af29-4b90-8e38-b2a224bc2bf3	73c2f029-7376-4370-b5d4-2004722f7fd5	33	0	2023-07-14 12:21:40.969	2023-09-22 02:09:47.567
d88ad65b-a461-4176-85b1-98047b395830	c689fb09-d65f-4033-a4d2-36576db5d1e2	26	0	2023-07-14 12:21:40.773	2023-10-17 06:42:36.381
432e7e2e-6440-4e8d-a81c-cb0e4577482b	fc160bbd-a511-4a6f-9fe7-705f18ba25bf	23	0	2023-07-14 12:21:40.779	2023-11-09 03:55:43.625
4dedf618-0945-4d23-ba4b-5ad70c1b4d1a	f6cc83a0-b7f0-4195-bd76-c256db705889	35	0	2023-07-14 12:21:41.217	2023-07-14 12:21:41.217
6e731965-4c48-4b73-a1b7-702781445274	197bffb0-52ab-4511-96bf-75f7558e84ed	36	0	2023-07-14 12:21:41.223	2023-07-14 12:21:41.223
a8f15f28-becd-41df-b45b-f0463366c9a7	b13b1853-5f86-4f64-afd5-094f113b00a2	36	0	2023-07-14 12:21:41.23	2023-07-14 12:21:41.23
4cedccbc-bdc8-4f47-8f8a-9ab3baad4e1b	1fb9a8c3-c509-4ba1-b1b8-9273e76c8949	36	0	2023-07-14 12:21:41.236	2023-07-14 12:21:41.236
732076b7-9a0b-4844-b30a-51be2e209003	d35f0e96-b589-4d5b-bee6-2293a66c0a5a	36	0	2023-07-14 12:21:41.242	2023-07-14 12:21:41.242
59795575-5aeb-4f9f-98c3-b90ad88fdd86	2e625bc3-51dc-46cd-b39e-600b0730806f	36	0	2023-07-14 12:21:41.248	2023-07-14 12:21:41.248
ff790ed7-972d-4bfc-b457-1592df13f9c9	03617242-6e4f-4696-9a77-1662b111b195	28	0	2023-07-14 12:21:40.767	2023-11-17 03:15:56.752
41426789-de06-4ef8-93c2-dd1562bdb028	834b557d-c530-492d-9357-f827b547bb8f	29	0	2023-07-14 12:21:40.923	2023-11-24 01:13:11.105
11d0ba55-7178-4d08-bb88-778c4b7520ab	28763b44-00ed-4901-8793-aa8419c8aba2	29	0	2023-07-14 12:21:40.963	2023-11-24 01:13:11.16
5d5d8d3f-7248-44e1-a311-6ce9c1851dec	bd1ccedb-ef51-41f4-a9fb-12c69c6b9b61	26	0	2023-07-14 12:21:40.884	2023-12-04 04:27:46.861
2cd5b2e1-6501-4b1a-807c-1c4a209f629c	91f359f7-87e2-4e9c-b815-c1d5c765fbd2	23	2	2023-07-14 12:21:40.762	2023-12-07 09:08:39.953
9afd6bbf-8907-4443-b263-ae54f3b9ed38	718d732f-2215-4dd4-aee5-97051c596005	28	0	2023-07-14 12:21:40.889	2023-11-24 01:13:11.1
f11191f3-224d-411c-876c-0098a00e62bb	98bd82d9-e5bb-4765-abf6-4aec9962bd06	30	0	2023-07-14 12:21:40.827	2023-12-04 04:27:46.846
9143dd1e-ea39-4771-84c6-86658d94ff10	af2f2aeb-988b-40c6-a9e2-7a3cb1fafb09	24	1	2023-07-14 12:21:40.732	2023-12-08 00:29:19.534
901a85a7-5fca-4713-aa83-bce6cfd5215f	65733ada-1dc1-451f-ac4d-a2c9d17e095c	24	0	2023-07-14 12:21:40.755	2023-11-24 01:13:11.109
238349c9-7896-42cf-81eb-0436c6c36c93	674d7726-13be-4908-94d6-17718dbab53a	23	0	2023-07-14 12:21:40.71	2023-12-04 04:27:46.864
3a8061c9-4c50-45f8-8db6-bc58d30dd7e7	5f34c195-9245-4fa0-a7ac-c6e63ed8567e	27	0	2023-07-14 12:21:40.952	2023-11-22 06:13:46.437
f1a23c28-df50-4047-9afd-bd3d421de487	b2869ff2-7e91-4707-b410-b6b770a6c4e5	27	0	2023-07-14 12:21:40.939	2023-12-04 04:37:31.948
27d554e2-1960-4f54-99a6-803080aa16ce	5b03ef99-0943-48e2-be24-789ce920d690	18	1	2023-07-14 12:21:40.656	2023-12-11 10:50:20.963
0bb17fc6-9d29-4709-b975-767835a6a3ab	80ace21f-1eb5-4e08-b5ad-e6a9a50b977d	22	0	2023-07-14 12:21:40.895	2023-11-24 01:13:11.101
81a3f54b-3177-475a-bff5-8a5689c4a4a1	2ae5a1b9-a7fc-4ff2-bce6-59cbc1c8baf4	20	0	2023-07-14 12:21:40.744	2023-11-24 01:13:11.101
83f018fa-781f-4369-9a0a-f2017b303300	5fa859f4-b299-4660-88d6-4a86f2bb9153	28	0	2023-07-14 12:21:40.698	2023-12-04 04:27:46.845
400d10dc-dcc7-4ac5-9599-db984c186702	d091f328-618b-40d2-be4b-d16c62854782	22	1	2023-07-14 12:21:40.692	2023-12-04 04:27:46.846
b5643b09-72df-489d-af26-ef21a2164f0c	e9995766-fc8f-4b2d-bceb-543a6f46e065	36	0	2023-07-14 12:21:41.253	2023-07-14 12:21:41.253
3277c96d-4994-4012-9e9d-86acbf145d5d	7024b8db-d952-45d8-8ad9-fdf947dabcab	36	0	2023-07-14 12:21:41.259	2023-07-14 12:21:41.259
d517e3fd-c339-4de0-8276-b890853de2fd	2746cc8f-6348-4e7d-9dda-adc586acb643	36	0	2023-07-14 12:21:41.271	2023-07-14 12:21:41.271
443b38a2-c358-47d1-84c9-7a7c718f233d	c77df251-4f28-4fae-9c75-4805118f40b6	36	0	2023-07-14 12:21:41.277	2023-07-14 12:21:41.277
24da19cf-463a-4ee7-aef9-7505604fefdf	e5cffe5b-22b4-4d84-b71d-520e9950c107	36	0	2023-07-14 12:21:41.288	2023-07-14 12:21:41.288
07ad633b-686d-4c67-98ec-4df887beb0fe	12ada5f8-962f-40d5-9e2a-6d5cdb47fc01	36	0	2023-07-14 12:21:41.294	2023-07-14 12:21:41.294
3fa6e4d9-af0c-48ba-9354-b9bbb3e4492a	c4fd0791-d8c6-4554-8b6f-167181754d1b	36	0	2023-07-14 12:21:41.3	2023-07-14 12:21:41.3
03bcb98c-6908-4533-aa58-2ed0299561da	7df71d27-b812-4d63-a890-e6b62fecf9dc	36	0	2023-07-14 12:21:41.306	2023-07-14 12:21:41.306
14d4a7d2-85c5-4567-a218-c71f17a4753a	b43efd61-79bf-4dff-88b0-24407008ad2b	36	0	2023-07-14 12:21:41.312	2023-07-14 12:21:41.312
e5d54c7d-45ae-4357-a9df-85ffc08003d4	ff27db98-98fb-49aa-a55e-e1f0cb3270d9	36	0	2023-07-14 12:21:41.318	2023-07-14 12:21:41.318
3aac49df-0082-484e-ba6e-ab5a9b0d8efb	717016e7-86c1-4b9d-9d8a-abbb603a7eb9	36	0	2023-07-14 12:21:41.324	2023-07-14 12:21:41.324
6f81db96-c11d-4598-bf39-1c7532203d1f	0425646c-9ef6-46a1-895f-d33603bd3127	36	0	2023-07-14 12:21:41.329	2023-07-14 12:21:41.329
264e4047-2b12-4072-b49e-321f242bbce6	b5f69f00-641e-4317-bf69-66af15f1bb58	36	0	2023-07-14 12:21:41.336	2023-07-14 12:21:41.336
3c96133d-5ccd-4ba4-9d08-bba4e4667389	e79a3ad1-0a3f-4169-86e8-11111ec99d07	36	0	2023-07-14 12:21:41.342	2023-07-14 12:21:41.342
c3f96cc3-2b73-45ff-94e7-faac3626fcdc	c5738791-8d08-4b2b-b67e-982e4c98d9ea	36	0	2023-07-14 12:21:41.348	2023-07-14 12:21:41.348
7db51206-7cde-4fd6-8d2f-42bd57443773	6fa6c6ea-f689-401e-8a9e-69ce059f6d93	36	0	2023-07-14 12:21:41.353	2023-07-14 12:21:41.353
09606103-0267-4d47-b5c4-0c820b43c580	a9f9ba65-06c6-4912-8ba1-71a70e00c698	34	0	2023-07-14 12:21:41.195	2023-08-11 13:37:55.304
da946d67-79b3-438c-b47e-6a9ffbcbfb8c	7dab4f12-7e30-4952-82f1-9093d48c19b4	30	0	2023-07-14 12:21:41.078	2023-10-17 06:42:36.395
f03674db-47eb-44bb-9291-5af16aa06f13	49de437c-2231-412c-a285-73d09b71522f	31	0	2023-07-14 12:21:41.015	2023-11-08 05:41:37.907
acc91232-106e-4c5b-8d2c-8e6245d8cadf	ad6c7e9d-64c2-4502-b0de-9af77f9761ac	32	0	2023-07-14 12:21:41.091	2023-07-21 14:52:06.059
c7a0ac62-9e47-46af-a8e7-51c0a8550aff	42b0500f-c9f5-4df9-8dca-525aaacdbf8f	33	0	2023-07-14 12:21:41.131	2023-11-09 03:55:43.631
cd204999-045b-414e-a1ca-1c2535cba451	fb366f4d-2228-447c-9455-7a58b5d858f5	32	0	2023-07-14 12:21:41.166	2023-10-15 01:37:37.683
dad61626-9707-44f5-9d05-a0ce8fc5ce75	a30cb6d0-2b90-4261-ae54-b5db9ff16ecc	28	0	2023-07-14 12:21:41.06	2023-11-11 07:16:59.679
5acad53b-100a-4ab3-acb3-683c43cb2e5a	4fff5fc1-fbf2-43bb-8b9c-4ef06574929a	34	0	2023-07-14 12:21:41.177	2023-10-28 01:24:52.032
183feb2c-b223-4975-a7ee-a2ccf7637714	4e8153e6-4c71-4d15-b72e-fd65d45479f8	32	0	2023-07-14 12:21:41.172	2023-10-17 06:42:36.409
751b5f94-7bc9-4178-bc36-5a580584fadb	6e69126c-78a3-4270-a940-e89c30d3733d	35	0	2023-07-14 12:21:41.282	2023-08-11 08:53:53.436
c13d713c-b269-45cf-a316-a5c3902daf13	91f8763f-a8d1-424a-b638-ee08e8587e3d	33	0	2023-07-14 12:21:41.201	2023-08-11 08:53:34.777
8c7700d2-3c85-49fb-93d9-d54a01faa25b	0cdb2e12-4cb1-4319-b6ab-cbcc7d1423ce	32	0	2023-07-14 12:21:41.097	2023-07-21 14:52:06.053
a268e74d-0717-4a2e-a687-32012bf226df	89446203-abde-4ccc-875a-0128b0240721	34	0	2023-07-14 12:21:41.125	2023-09-23 03:48:11.791
68da2ee2-76fe-4b79-8d46-3f68ab8608cb	cb81fe51-27be-4176-bfc1-1b361d42ecd4	29	0	2023-07-14 12:21:41.103	2023-11-10 05:26:54.499
d65f3d64-f6b7-4017-a00a-2de561f18c59	58e6e3a2-797a-4562-b157-47b218b11cbc	27	0	2023-07-14 12:21:41.206	2023-10-12 07:58:34.077
52950f5b-f005-47c3-b894-f374f615ee70	28397014-e9a0-4c23-87d0-8a2c71ad7aa3	31	0	2023-07-14 12:21:41.189	2023-11-09 03:55:43.65
7a41151a-0346-4a1b-bb0e-cc3e31b8ab7e	fda0d9a7-9d58-49f2-831c-850775209d60	29	0	2023-07-14 12:21:41.009	2023-11-13 06:01:12.848
df1df21b-41a5-40bd-861a-fa1ec3a6acdb	2bff25a8-9c04-40f2-9d52-dd8d09f8aac8	30	0	2023-07-14 12:21:41.084	2023-10-17 06:42:36.411
724601ae-2345-4af9-9417-e6c5048c6f9a	f591dc20-ff79-4c65-9a98-53db7cd3ac65	29	0	2023-07-14 12:21:41.154	2023-11-08 05:41:37.922
c6bc91ee-0f04-4eda-82cd-03287f62860f	42581b4e-9a24-4cd1-a275-3464b8ff68b4	30	0	2023-07-14 12:21:41.027	2023-11-08 05:41:37.941
2d16c058-7792-4406-a400-80ca9aa6e6d8	d756feb1-5fb8-4af4-9242-20166ddc3fe2	35	0	2023-07-14 12:21:41.119	2023-08-09 05:25:32.154
a3b58581-4986-4c1a-8681-86cf8fc4acdb	074bc14f-dc06-4286-9b6a-41c5f37f77d2	27	0	2023-07-14 12:21:41.113	2023-11-12 06:22:22.134
5d735f50-8582-4014-a0c0-4eece8366532	b1dfc76d-360a-4419-9170-400bf674cdca	27	0	2023-07-14 12:21:41.038	2023-11-12 06:22:22.132
dc868b1d-b0d7-4532-ade8-0560c7544b6d	d64d8ce1-4225-4026-8c7c-ec774f5f7376	34	0	2023-07-14 12:21:41.16	2023-11-13 06:01:12.84
4c88f766-0c25-4a29-b3e8-3de479a7e2ab	5c9e6d39-338c-4cc1-814f-db5e36e7294f	29	0	2023-07-14 12:21:41.109	2023-11-08 02:53:09.079
fc3561ab-099c-43fe-8235-f8f399848c0a	4f622744-6a75-4a90-ac25-59bf4d943f0a	32	0	2023-07-14 12:21:41.003	2023-11-08 05:41:37.909
c0569543-ba4a-48fc-9f01-2f601072cd75	6cbbddaa-a205-493b-9d59-13a546614270	29	0	2023-07-14 12:21:41.032	2023-10-17 06:42:36.399
52c2a67c-feb0-4702-8ad9-8982a5d352c5	bb6a3e0c-188d-4bac-a0f6-a1c91fc871de	32	0	2023-07-14 12:21:41.148	2023-11-08 02:53:09.063
8af0755d-3ad6-43b8-819b-8c0028dd15ee	db1e3e5b-80cb-489d-a369-6e39f7ae8ce0	34	0	2023-07-14 12:21:41.265	2023-11-08 05:41:37.953
3f1997a9-2eb2-4e78-aa62-6575a5d320a0	e885e7b0-f51e-449c-ab42-22e6563cae4b	30	0	2023-07-14 12:21:41.049	2023-11-08 05:41:37.949
92310ca4-90f9-427d-89c8-30e695680fd2	c23ca408-3aaa-479d-a26f-ef6c2e4851cb	29	0	2023-07-14 12:21:41.137	2023-11-12 06:22:22.132
5d48bec1-4c5c-4bbb-9f0d-11962cb30cf6	e5669273-53e7-48ac-835f-0a93afd4c484	36	0	2023-07-14 12:21:41.358	2023-07-14 12:21:41.358
090e14d3-b162-4876-ac58-fe60087114da	d771fe84-4add-495a-aae7-358ef2117e73	36	0	2023-07-14 12:21:41.365	2023-07-14 12:21:41.365
bd75dabb-e9f7-48e2-a96e-9a9d0a48bd97	69e5cdf6-c093-4f1f-aa18-ccb8a95de933	36	0	2023-07-14 12:21:41.37	2023-07-14 12:21:41.37
7b0e1a04-e3fc-4700-8c89-2366cd29d61c	f8770680-f04f-4bbf-be70-a6e01a65ae17	36	0	2023-07-14 12:21:41.376	2023-07-14 12:21:41.376
fc3dbc05-2d42-474e-aa99-7055726f135f	cc6fe942-be3b-483c-9d8e-cb4f8818f548	36	0	2023-07-14 12:21:41.383	2023-07-14 12:21:41.383
54ed3bb9-01e7-4726-8ab2-d76d17422c3f	5129abd8-993e-4563-8cc2-f945499fb3aa	36	0	2023-07-14 12:21:41.389	2023-07-14 12:21:41.389
16f94a6a-4e81-4abb-b142-f275157eca8d	582fdf42-de6e-41e4-beef-46fe797ed1ef	36	0	2023-07-14 12:21:41.395	2023-07-14 12:21:41.395
c5dc052d-4467-48cc-ace2-e655b6c87540	2f75b41b-9b4a-499e-ba74-1a9535203e2f	36	0	2023-07-14 12:21:41.4	2023-07-14 12:21:41.4
822e9a1c-c2e0-4846-a6c1-a6ba9988af2a	58d9a9c4-d1b1-4f92-b9ec-0c7bf3d6354a	36	0	2023-07-14 12:21:41.406	2023-07-14 12:21:41.406
04e9e3ca-1920-41e4-b9eb-c59e13e5aab0	c5f65189-d34b-43cb-8cbc-c17566156b0a	36	0	2023-07-14 12:21:41.413	2023-07-14 12:21:41.413
9aeea111-fb0b-4ed8-862c-7d19537f5f19	40123385-1a35-46d0-aeca-e8e3a943622a	25	0	2023-07-14 12:21:41.071	2023-12-04 04:27:46.863
ee063c40-dc5d-4964-8364-41dd661d709e	74f4cc4c-5992-4518-ac80-41dff96c2249	28	0	2023-07-14 12:21:41.143	2023-11-24 01:13:11.11
ea8284a4-9e65-464f-837a-c9da9f6ce4d9	35a8e5c0-aa3c-41e3-80b1-8a1582432650	36	0	2023-07-14 12:21:41.419	2023-07-14 12:21:41.419
899f0d74-aa42-4443-a10b-ad539649b84d	2b3762a6-2fc8-4a5c-a759-56a50a4219d8	36	0	2023-07-14 12:21:41.425	2023-07-14 12:21:41.425
8018511a-dc36-4a22-8c0a-ce9e4ba5fd0f	aba904bb-c7a8-430e-ad9d-5ed1762eab65	36	0	2023-07-14 12:21:41.43	2023-07-14 12:21:41.43
70cd175f-2b7c-4898-aca3-334cf3f1ef36	83b5bf52-c2b9-48fc-b4b8-49dcf393e125	36	0	2023-07-14 12:21:41.435	2023-07-14 12:21:41.435
a94cdf1c-93b5-4c9c-9f24-e83e731cc4c6	5b49c6af-2dc8-4e87-bbf0-7f41612fe06d	36	0	2023-07-14 12:21:41.441	2023-07-14 12:21:41.441
cd0f8534-c290-4282-8269-f0c185d26afe	932e4409-c24d-4c1e-b4f5-37d9311b2350	36	0	2023-07-14 12:21:41.447	2023-07-14 12:21:41.447
b6e7ad22-eb49-4488-afc3-0208fd3413fe	86017b6f-c0a6-4601-bfa9-4c206c19e7ac	36	0	2023-07-14 12:21:41.452	2023-07-14 12:21:41.452
8e1d2a9d-af3d-4db1-998d-ff8bd30c221c	42ece2f2-7ba3-4b10-9e4f-65d472be87a2	36	0	2023-07-14 12:21:41.464	2023-07-14 12:21:41.464
ddea5f66-04c4-4b2a-9bb3-a24395506361	f15488bd-dbdb-414d-a1b3-3999569519be	36	0	2023-07-14 12:21:41.47	2023-07-14 12:21:41.47
852590e2-0068-4c75-b5a5-41009f489189	cd5915bb-a524-4073-8b7a-8e91961bfef6	36	0	2023-07-14 12:21:41.475	2023-07-14 12:21:41.475
6dbc6b8d-5cdb-4300-b949-47907743d9c9	ab152fce-24a7-4841-841d-dfcc28a9056b	36	0	2023-07-14 12:21:41.481	2023-07-14 12:21:41.481
03279dba-3a39-4309-b787-cfbf190b94b7	bc3243d6-46cc-4bb7-90be-f4277888d4ee	36	0	2023-07-14 12:21:41.487	2023-07-14 12:21:41.487
a9759e53-e029-419e-91d0-a35f775a2f93	94a0352f-548c-4577-90f7-cd79c32757b0	36	0	2023-07-14 12:21:41.493	2023-07-14 12:21:41.493
0c6c4e12-34ad-48cd-8e65-89d8a1f0ad69	48ee8906-aece-49be-a59a-db2b1ae25841	36	0	2023-07-14 12:21:41.498	2023-07-14 12:21:41.498
4b71771a-95ec-4bf9-9c7c-b594190f1da2	54e4ed17-c3b3-4f81-8f8b-95faee88e66f	36	0	2023-07-14 12:21:41.503	2023-07-14 12:21:41.503
072d58f5-dea4-4f1e-9ca5-1825f329b44d	01c4eb80-f0d1-461b-82e3-460b5be13bf9	36	0	2023-07-14 12:21:41.509	2023-07-14 12:21:41.509
ddc62ea9-32e7-46b1-9629-6e32d7ee2cc5	44db78be-05bb-40b2-8e09-e8fb5a650513	36	0	2023-07-14 12:21:41.515	2023-07-14 12:21:41.515
0d3c821e-b5c0-4cfb-9739-04b0ea7190b5	ad3a7a70-439f-4fc5-9ddd-6e275eae1e12	36	0	2023-07-14 12:21:41.521	2023-07-14 12:21:41.521
5db56469-5d5a-4197-af0c-cfbe7131bd47	8ecf1303-7a73-4f17-9a12-76b23a387c83	36	0	2023-07-14 12:21:41.526	2023-07-14 12:21:41.526
c1fa9359-6438-448d-bbed-210cd0bcaaf6	abdba6bd-8c86-4afa-919c-cb3d3cf075ca	36	0	2023-07-14 12:21:41.533	2023-07-14 12:21:41.533
3977d6bc-79d8-424e-8b90-8f2d4fac2d48	1e213d78-0641-4db7-99f6-c23d356bc014	36	0	2023-07-14 12:21:41.538	\N
9f46c42f-127e-4de2-8700-2145edff9504	db8eaf3b-f95a-4b30-b1ee-0228be1abf0d	36	0	2023-07-14 12:21:41.544	2023-07-14 12:21:41.544
d45de693-7f4f-4601-979b-46a41ccf6b99	b3fbff81-8b91-4c58-b788-aad57b9afba4	36	0	2023-07-14 12:21:41.549	2023-07-14 12:21:41.549
74794463-93e9-49a6-b14f-3286a7318998	7f940df3-91cb-49db-9587-5b577393afc2	36	0	2023-07-14 12:21:41.555	2023-07-14 12:21:41.555
2e26986a-99e7-4164-bbde-ee11d310ee00	1943f5f9-4473-4425-ad80-9c8587b034c1	36	0	2023-07-14 12:21:41.561	2023-07-14 12:21:41.561
9d4a1406-be00-4efb-8b9e-28a243d58248	7d10b369-1729-4dcf-81ac-70cd5ae54b8e	36	0	2023-07-14 12:21:41.566	2023-07-14 12:21:41.566
e7c8c784-c3f7-465d-8e57-bc675458da44	b84d039b-bad1-4648-bb2b-a60e2dc53c8e	36	0	2023-07-14 12:21:41.571	2023-07-14 12:21:41.571
0402045b-5c30-4380-b930-ed49175521cb	90eed5b7-0729-4659-b1d0-3df256ef82e1	36	0	2023-07-14 12:21:41.577	2023-07-14 12:21:41.577
e5d3c194-9631-4d5d-ac17-1e7062ebf37c	d51620fd-7036-464f-b58b-e8d13ad095b5	36	0	2023-07-14 12:21:41.583	2023-07-14 12:21:41.583
50b3173f-adef-4773-8b9e-c46a8a7d1402	af5edebd-19d0-4aa2-a2f9-c9685616c646	36	0	2023-07-14 12:21:41.588	2023-07-14 12:21:41.588
510c1638-c017-44bb-bf83-ec76cee8f77f	e294ac32-f961-4a76-856d-38d503853063	36	0	2023-07-14 12:21:41.595	2023-07-14 12:21:41.595
2a23a23b-8340-491b-b6f0-4c600b6c25af	3b0f73de-73e9-4591-99d9-026eff35a37f	36	0	2023-07-14 12:21:41.601	2023-07-14 12:21:41.601
7f516095-b7e4-44cb-a2aa-532108e200e6	4f2def71-ee2d-4134-9838-9b40dd35768d	36	0	2023-07-14 12:21:41.607	2023-07-14 12:21:41.607
7d0f52b3-d468-49de-9b61-57ab73dbf356	00891a9e-6363-41a1-98a6-9c04bc8fc8ad	36	0	2023-07-14 12:21:41.613	2023-07-14 12:21:41.613
57a6dd3f-e8fa-4de5-890b-792b9e074821	154182e9-ed42-4361-aac5-92ca90d72b73	36	0	2023-07-14 12:21:41.619	2023-07-14 12:21:41.619
ea7bb2dc-03b1-4320-9031-0a4d0f2055a4	2b90ab73-32c6-4c3e-8605-d38ea2eaf3a6	36	0	2023-07-14 12:21:41.625	2023-07-14 12:21:41.625
53d65778-db5e-47b8-aa04-5dfe7f577caa	cd9c9f38-8367-4ace-94d3-104545a85a03	36	0	2023-07-14 12:21:41.636	2023-07-14 12:21:41.636
b348112e-9b71-4c68-8c74-4bbf08d3f41c	0f678b08-d9e6-46f7-8411-a3eb93bc3b72	36	0	2023-07-14 12:21:41.642	2023-07-14 12:21:41.642
2a345c2e-12cd-40c9-8b8b-d722432f1d61	92c8d939-ec6d-4671-9210-656fc5ed58fa	36	0	2023-07-14 12:21:41.647	2023-07-14 12:21:41.647
2ce98e4d-1baf-4e72-af9e-85ccb24eab9e	7716d634-5aaa-48b7-944e-871e336cdd11	36	0	2023-07-14 12:21:41.653	2023-07-14 12:21:41.653
e617a649-0d2a-4bc9-8993-d4a3eba3f500	53658cf9-bb07-485f-abc7-16d20eaf07ff	36	0	2023-07-14 12:21:41.659	2023-07-14 12:21:41.659
ecfc2608-aa27-437d-9dc6-5fe0e80afdbe	8aabd880-8712-4cf6-98d5-d80d8dff9065	36	0	2023-07-14 12:21:41.664	\N
c8e94736-e18d-45e6-a15a-ad55a3a44fe2	1537d0b9-d64a-418b-831b-2eff539dd827	36	0	2023-07-14 12:21:41.67	2023-07-14 12:21:41.67
f4ddca88-85dd-4adc-b8db-4bc4aff182f6	56ee4b69-a52d-479a-b595-b0eff3b7f5f4	36	0	2023-07-14 12:21:41.676	2023-07-14 12:21:41.676
dc70c92a-f26c-4276-bbe5-977899a8acd9	7cf7bf9e-6480-42cd-9d02-f457e0106325	36	0	2023-07-14 12:21:41.681	2023-07-14 12:21:41.681
e21299a0-1a97-4798-95b8-25c8cb3eba2f	877884fd-1cbe-434a-bdb2-7fa33454a790	36	0	2023-07-14 12:21:41.687	2023-07-14 12:21:41.687
ba3d0e70-189e-455d-ba28-1cb9d3226591	2e20be61-3a29-47db-b5d8-aa8806ca08f3	36	0	2023-07-14 12:21:41.692	2023-07-14 12:21:41.692
a7a27bb3-56f4-4e67-8eca-2849bd57958c	61537699-3d20-4be6-ac2c-57d3b0ce81f7	36	0	2023-07-14 12:21:41.698	2023-07-14 12:21:41.698
601e6ed5-bf15-45d3-86af-1655d1b7e9c5	6fff7783-bc6a-414c-a045-a62c3d4fa86f	36	0	2023-07-14 12:21:41.703	2023-07-14 12:21:41.703
55189ab3-fd49-4908-8f50-035aab64f88f	50b9735e-be7f-4080-99c6-b06ff68726a7	36	0	2023-07-14 12:21:41.709	2023-07-14 12:21:41.709
a5fe80f4-aa40-4a65-80e7-4f588a3d9eb2	81b84d2b-2889-4b56-9e5b-1045ab659bad	36	0	2023-07-14 12:21:41.714	2023-07-14 12:21:41.714
3a175325-16f3-4516-b077-cba7fe1b241d	725e988d-6780-47b2-9b44-f83af2c3fca8	36	0	2023-07-14 12:21:41.721	2023-07-14 12:21:41.721
c9a3a810-0abb-489b-806e-fd13bfbc6b96	40838f37-da01-4279-9cfa-e7c1752a5735	36	0	2023-07-14 12:21:41.728	2023-07-14 12:21:41.728
690abe30-8b25-44f1-863c-871621a804aa	c2be90e2-bea4-41b4-8088-63cef889750c	36	0	2023-07-14 12:21:41.739	\N
4762bf66-4b1f-4f70-86f3-b2a154a6cd97	788d6c3a-dc03-4758-b3d9-5465c05edbf1	36	0	2023-07-14 12:21:41.745	2023-07-14 12:21:41.745
5698a3ac-58a5-42bc-9bd3-26563014937e	ca1b3103-d9cb-400e-b939-b1a575b78830	36	0	2023-07-14 12:21:41.751	2023-07-14 12:21:41.751
53692193-06b6-48cf-b9c1-6e5402dbdfc6	6047e9d3-472e-400f-8782-05c80f0c6771	36	0	2023-07-14 12:21:41.756	2023-07-14 12:21:41.756
74804c71-8439-4e70-a42d-bdf583c07a50	d15c088d-a090-4348-9504-4c3e96997317	36	0	2023-07-14 12:21:41.762	2023-07-14 12:21:41.762
02b02e9b-db3b-4680-8aa4-0530a4a84fc1	8ea8423f-8510-43ed-8dc9-b1672f42f2f7	36	0	2023-07-14 12:21:41.768	2023-07-14 12:21:41.768
e4e21716-fb86-44cd-9bea-1bedaf24f459	8089758f-83f2-4552-875b-9bf8d2220e45	36	0	2023-07-14 12:21:41.773	2023-07-14 12:21:41.773
1c93c648-08d2-4620-ba2a-77bd5e57389c	d7b6ecdf-c2de-4a8d-905a-3e7dc86dafd8	36	0	2023-07-14 12:21:41.779	2023-07-14 12:21:41.779
2443c0eb-c2a5-4e0d-b24f-44487070ad7a	56b821da-d1a0-4cdc-a9eb-8c979861e504	36	0	2023-07-14 12:21:41.784	\N
987ae0db-9aa9-40b9-a01c-0284d23a2bdf	9154771c-4d31-4d1e-a48a-49c10802ca7f	36	0	2023-07-14 12:21:41.789	2023-07-14 12:21:41.789
a55ad5a7-5bc2-4f91-b350-4978aeb60a31	37efb265-acbb-4979-ac31-123e0c80ddc4	36	0	2023-07-14 12:21:41.796	2023-07-14 12:21:41.796
c47e039e-861a-46fb-9355-ea0749a87cfd	f3fb6c4f-4f02-4c9d-ae78-c8b82e20e6b9	36	0	2023-07-14 12:21:41.801	2023-07-14 12:21:41.801
03660945-a8fe-4928-a5c3-66a02f43d860	d10ab048-7259-47eb-a4f5-959919a4b700	36	0	2023-07-14 12:21:41.807	2023-07-14 12:21:41.807
77970e21-2254-4265-8ac7-fad34fdc83f8	bb1bc1d9-8c29-4d43-af54-dd1423f2d38a	36	0	2023-07-14 12:21:41.813	2023-07-14 12:21:41.813
f7b4a7a8-4452-4df3-8ae7-5446312a87e9	76d4f04c-9ff4-499a-b337-59901006c0bf	36	0	2023-07-14 12:21:41.818	2023-07-14 12:21:41.818
48b764b0-c731-4d8c-8522-b5f4bf3359c0	f37369a3-1ad3-4569-a2c0-f8fb349ea7e6	36	0	2023-07-14 12:21:41.824	2023-07-14 12:21:41.824
15a1cad7-4f73-4b1c-be5a-85b9d5dbda84	e047136a-10de-440e-8ecf-f9e670a8b8ce	36	0	2023-07-14 12:21:41.835	2023-07-14 12:21:41.835
494f47b6-0e78-4c78-a744-fe3d498afda2	e7afd0a7-9b47-481b-8071-3e96863dec0f	36	0	2023-07-14 12:21:41.842	2023-07-14 12:21:41.842
d7710fcf-8592-4fdd-a941-2576d941a780	9e8e6050-b09a-4de3-a661-101609782338	36	0	2023-07-14 12:21:41.848	2023-07-14 12:21:41.848
b6bb8ff3-9d4b-40a5-b9cb-e46a87c32e84	6568987d-a559-4d06-ad69-0e896a0b018f	36	0	2023-07-14 12:21:41.854	2023-07-14 12:21:41.854
18e57dd5-e40f-4617-8859-7d860f71bf7c	aafe306c-2d6c-4df8-9464-a9bc9f681f78	36	0	2023-07-14 12:21:41.859	2023-07-14 12:21:41.859
9eb13c2b-77a1-4c4f-9a11-ecd082aacd21	175950af-4e37-4cf9-88b6-1bf3d721296c	36	0	2023-07-14 12:21:41.865	2023-07-14 12:21:41.865
74daab3f-3059-4f06-b480-19fb343cc61c	acdb145e-9f27-4bdb-adfe-dd25c9435498	36	0	2023-07-14 12:21:41.871	2023-07-14 12:21:41.871
2bd78a2e-000a-42b3-b8a0-c8ae13e81994	a8ee57ae-be9e-4bcf-b025-4abc96e45d65	36	0	2023-07-14 12:21:41.877	2023-07-14 12:21:41.877
27c8924f-fe16-49e2-bb5c-5fa511a82c95	84f9dfcd-6800-4900-bd25-6cf3ff55f7f4	36	0	2023-07-14 12:21:41.883	2023-07-14 12:21:41.883
da18bf01-17d3-49a8-abc7-cf8957273d26	7ec25321-54e2-4536-a2b6-7fc02f107a7c	36	0	2023-07-14 12:21:41.889	2023-07-14 12:21:41.889
3b36dbfe-b032-4f78-af63-82fcce17586a	a494d500-0933-4fcf-9f21-db5ff4287248	36	0	2023-07-14 12:21:41.894	2023-07-14 12:21:41.894
96b7aa1c-4bf4-4387-87af-2cc5b67343e3	57b4912f-2664-4a27-93cc-7f2dae822da3	36	0	2023-07-14 12:21:41.898	\N
6aec163b-f230-4132-bf8c-fdc71eeaa8c6	4daa2cc5-e484-45a0-b99b-b2bbcbf452d3	36	0	2023-07-14 12:21:41.904	\N
d9fdec66-9783-4d9a-81fb-b09ad7783a19	e92200a0-ec86-4e71-a78d-fc419e813bea	36	0	2023-07-14 12:21:41.909	2023-07-14 12:21:41.909
7dbf1076-4c52-4a0c-8d81-97f763b2d25c	269809d7-bc6d-41a9-8abb-bcd406b422f2	36	0	2023-07-14 12:21:41.915	2023-07-14 12:21:41.915
1af465fc-6fc0-4b95-935a-4aa682c13bde	c1a4d147-22e6-4461-837c-b63de505d7d0	36	0	2023-07-14 12:21:41.921	2023-07-14 12:21:41.921
ec9c7dbf-5af7-49c1-8a63-0b3ef32136f1	c3933f5a-63d6-4b78-ac54-eafbefd46265	36	0	2023-07-14 12:21:41.927	2023-07-14 12:21:41.927
33106949-ae7b-4f2e-a1c4-e858f2ff55b5	21774aab-0474-4c74-91c2-70edf00810f2	36	0	2023-07-14 12:21:41.933	2023-07-14 12:21:41.933
acb03d4b-38d8-499b-99eb-a25d4bb605f7	22ea4482-d8ca-44cf-b39d-563ce78da2bc	36	0	2023-07-14 12:21:41.938	2023-07-14 12:21:41.938
b994d5d5-46a3-4e73-b8e4-1347efed1cbd	cf3e638a-08d6-4edf-8e17-1a760c871a4d	36	0	2023-07-14 12:21:41.944	2023-07-14 12:21:41.944
7fbf104c-762c-4364-9c95-1e407b70b4ec	912eb30e-5cfc-4f48-99e0-fad19da55344	36	0	2023-07-14 12:21:41.95	2023-07-14 12:21:41.95
2f3f5a1a-c7cc-4a94-bf90-a93debfb81b3	8d50d2b1-e9a0-4532-a5cd-98a972fc2be2	36	0	2023-07-14 12:21:41.955	\N
14e0f60c-4b4b-48a4-b1d5-bc2035de9b83	28d5aa8f-d8e2-4213-8404-11a60cd9bcef	36	0	2023-07-14 12:21:41.96	\N
8112aaec-0e71-4f03-b646-70dac6642b24	d7355f08-0654-4560-8f22-fb6a9fb04c03	36	0	2023-07-14 12:21:41.966	2023-07-14 12:21:41.966
cec31a8d-6f74-411c-a9d5-85555f83f247	c0b6b026-3b6e-47be-abc7-464f96ba90d8	36	0	2023-07-14 12:21:41.973	2023-07-14 12:21:41.973
4b1dce3e-aac8-4d29-9f13-fe61a665ce15	4c1811c9-6345-4b6b-bcf1-5ff05f2a98f5	36	0	2023-07-14 12:21:41.979	2023-07-14 12:21:41.979
10ea10e1-a75e-4b4f-aaba-3e68b553924a	20d3564d-f976-4a0a-ad31-4d5cff6133ec	36	0	2023-07-14 12:21:41.986	2023-07-14 12:21:41.986
6eb4771b-e870-4da0-bc6f-4fd98007489d	c9c4e2ee-4b24-463d-89d4-82e90cc51257	36	0	2023-07-14 12:21:41.992	2023-07-14 12:21:41.992
65ab9020-af73-4fb5-8afd-cc0c5564b19c	bbab96c2-9637-40bd-a5aa-e2d74866ad5b	36	0	2023-07-14 12:21:41.998	\N
a6e05ecb-ce23-495a-9928-04a7433dbfee	aa86b955-0785-4d04-b3e0-a08408d6b0d4	36	0	2023-07-14 12:21:42.004	2023-07-14 12:21:42.004
90b542da-6500-4816-aba4-0c0389f5dc2c	1af2e637-13de-42b7-a2c8-97dbbe558d02	36	0	2023-07-14 12:21:42.011	2023-07-14 12:21:42.011
26098215-727a-44be-a3b7-e79c50c6aae7	85c25414-acc0-43be-95a4-76ea0477eb11	36	0	2023-07-14 12:21:42.016	\N
b553d0a5-09d9-42ec-a7df-51985288ae44	ad699d2d-fa80-4cae-b846-22461fc6f637	36	0	2023-07-14 12:21:42.023	2023-07-14 12:21:42.023
6fbfedda-e072-4985-ac3e-00745bf9b059	43891e21-8acf-40ac-ae80-831559b8dc65	36	0	2023-07-14 12:21:42.035	2023-07-14 12:21:42.035
2b2266e0-f163-483d-93ba-d236788e5fdd	4192c694-dfe7-4987-8f65-f0c86b8e42b3	36	0	2023-07-14 12:21:42.042	2023-07-14 12:21:42.042
dc370b5b-97d2-4268-9365-9f587e2c690d	297a6446-2ec9-4552-b92c-2aa300cbea98	36	0	2023-07-14 12:21:42.048	\N
f06b7f38-a117-4f9f-9265-d6ff20c1d644	bd710c7c-b3ef-4a95-aec6-3c28b95a5edf	36	0	2023-07-14 12:21:42.053	\N
eaa6bc31-288d-48f8-9670-4f24fd0606fe	737dde79-444d-4d48-a4fe-da59e6007523	36	0	2023-07-14 12:21:42.06	2023-07-14 12:21:42.06
a4ae1fca-5908-4d24-90d4-9464e26853ef	ae5d7c40-4a27-4d5e-8d14-0e5d8ae59050	36	0	2023-07-14 12:21:42.066	2023-07-14 12:21:42.066
1a5e0a33-928f-4f46-b860-0f75700fea18	a3c61194-c275-468b-9b88-d2bced68288a	36	0	2023-07-14 12:21:42.073	2023-07-14 12:21:42.073
e6e36058-fdc5-486b-9d76-a9672ad7185c	173e94ab-1303-4b79-8181-c3ecd4bb3b36	35	0	2023-07-14 12:21:41.734	2023-11-08 02:53:09.071
fb187ab0-7ad5-411c-bd9d-74309f816981	e52ad439-29e5-48be-81a5-9e4fcd0c6c5b	36	0	2023-07-14 12:21:42.079	2023-07-14 12:21:42.079
a5c93cab-6867-4d37-b0f1-d81eeef887ba	6e8a7863-21b7-48cc-9905-509117fc9c5c	36	0	2023-07-14 12:21:42.085	2023-07-14 12:21:42.085
ecf7058e-80b7-4ada-8492-aa1e8a2e89d0	17fb6082-cb40-458d-abc0-1a6579a44339	36	0	2023-07-14 12:21:42.09	\N
19f2519a-da90-4910-b3d8-f9b28dc23ff4	9f18a9ff-6824-4e36-9f33-0e3a80e5bc62	36	0	2023-07-14 12:21:42.096	2023-07-14 12:21:42.096
ab25222f-1614-4c1d-8372-6e9ff52b7c5d	893a5910-f44b-4677-8c67-5f7e3737557f	36	0	2023-07-14 12:21:42.102	\N
95ffa24e-a847-489f-b9be-086940a73bfe	d9333f27-d6ee-4e4e-81a3-29dffe6b266e	36	0	2023-07-14 12:21:42.109	2023-07-14 12:21:42.109
07e9cd41-3882-4cb6-b7c5-84bc36a3e909	2a47f500-534d-451d-b4f8-97b54eaa7cf3	36	0	2023-07-14 12:21:42.116	2023-07-14 12:21:42.116
ba6fc19b-63f9-47c9-8f09-b475bc880d89	a45ef98a-ebbb-496d-b775-e95739c82aee	36	0	2023-07-14 12:21:42.122	2023-07-14 12:21:42.122
641a0b72-f1ca-418b-84b1-4f71244bb16d	e9d112c5-2fba-4de5-877c-e2640b030429	36	0	2023-07-14 12:21:42.129	2023-07-14 12:21:42.129
278b1b4f-bf5b-48cf-bc4e-45aa357ed187	e6e47c59-a345-42d2-8e37-d0252a3c685b	36	0	2023-07-14 12:21:42.136	2023-07-14 12:21:42.136
de6fd3a7-f97b-4af8-ae3f-2104c2a51203	9871524f-e58d-4f5b-9a39-1fcceab0cfd7	36	0	2023-07-14 12:21:42.141	\N
90a8d3a2-b57e-4736-8264-3e0ec96b31e4	e521170d-6319-4880-a07f-2050f48a5dcd	36	0	2023-07-14 12:21:42.148	2023-07-14 12:21:42.148
9d1e88a5-0695-4cd8-b909-3047cdec8457	e65da901-e737-4e61-bb59-4dee1fce4903	36	0	2023-07-14 12:21:42.154	2023-07-14 12:21:42.154
d6c5f681-628b-4235-8873-a88e8d6f2879	c2f94a33-85a6-4491-bb8a-5b745c246029	36	0	2023-07-14 12:21:42.16	2023-07-14 12:21:42.16
d9a44197-4675-4cd9-8f1f-4c57a9730a7b	b4446414-c82d-4ae6-84a5-8b1c3423c0d4	36	0	2023-07-14 12:21:42.167	2023-07-14 12:21:42.167
280dfa23-9ffb-47c9-99bc-3d87bde0be81	f0bc1f54-032b-430f-a22f-885b8f68bd20	36	0	2023-07-14 12:21:42.174	2023-07-14 12:21:42.174
efd46b8c-123f-4c00-845e-153017f5a051	97e170b2-335c-4023-92f6-587af53cd966	36	0	2023-07-14 12:21:42.181	2023-07-14 12:21:42.181
fbd1193b-11a4-4019-a1bd-c4b880f858f0	93be610c-2219-4eed-9486-e4924beaed9a	36	0	2023-07-14 12:21:42.186	\N
5e3bf2a4-8d28-4661-9976-c0b8dfa37662	75e6991e-1f5a-4952-8eab-82752be30210	36	0	2023-07-14 12:21:42.192	2023-07-14 12:21:42.192
c6c7e47f-f5e5-454a-a2ae-4b0d8b152b43	21ac609d-9873-4104-8af2-4c1333e553db	36	0	2023-07-14 12:21:42.198	2023-07-14 12:21:42.198
460c51aa-aa0c-4b6a-8ab9-50c84ce046b4	50b4cef3-bc47-4e07-bad1-7507cc16a3fb	36	0	2023-07-14 12:21:42.204	2023-07-14 12:21:42.204
6e8d79d5-c12f-4a96-9f68-9216e9b78906	eed4612e-a1bf-4598-ba59-4fd81d1cd32d	36	0	2023-07-14 12:21:42.211	2023-07-14 12:21:42.211
367ac63b-a198-4ed5-8dbe-58fd81876166	2272fb42-714e-43e8-b14c-918270ba814a	36	0	2023-07-14 12:21:42.218	2023-07-14 12:21:42.218
27d9beeb-3fc1-4025-b150-b5461b4974d6	eeff1666-c5d4-42aa-8ef0-cde2cdd2b969	36	0	2023-07-14 12:21:42.224	2023-07-14 12:21:42.224
9f58c321-8642-4eb2-8297-4f64823dd386	ee2a6f28-fb30-47f4-917b-2ccf98323916	36	0	2023-07-14 12:21:42.23	2023-07-14 12:21:42.23
22ee45bf-0883-44c7-b793-78ed0d095746	25c751da-54de-4683-9c76-429cc849062e	36	0	2023-07-14 12:21:42.236	2023-07-14 12:21:42.236
8fa23d7d-fe78-47d7-8bed-88b55d30d536	c5200875-008b-49ee-95e0-97d3640cbbb4	36	0	2023-07-14 12:21:42.242	2023-07-14 12:21:42.242
b06ce1cb-31b3-4a0b-97e7-52ce6f9010e4	68b31f1c-5810-4548-bae4-262f5be1a193	36	0	2023-07-14 12:21:42.248	2023-07-14 12:21:42.248
4f5562ef-c2c1-436b-ac1c-cc9e808893ed	bcc17fd4-976d-4637-8e7c-d08e87f32b04	36	0	2023-07-14 12:21:42.254	2023-07-14 12:21:42.254
cb13fca3-4b2e-42ed-9e2e-bd850ea4eff9	7a6c5868-9ad8-482a-802b-2427728fd2ad	36	0	2023-07-14 12:21:42.26	2023-07-14 12:21:42.26
f737f37d-badf-4a3b-a926-d5ffcba2e784	ea8fef71-5a1b-421c-bfcf-89f2f17951f0	36	0	2023-07-14 12:21:42.266	2023-07-14 12:21:42.266
79d61cf1-97db-45b8-af7f-425ecd9f705b	531c56db-0fab-4e04-a569-c082fd7d416c	36	0	2023-07-14 12:21:42.27	\N
05bc3607-e7f7-4d01-9de5-b5f161a1cadd	675ddc4e-7100-42cd-acb2-2a951e5682aa	36	0	2023-07-14 12:21:42.276	2023-07-14 12:21:42.276
01f06282-93b9-4f1f-939c-8f215b8b40ab	287ea090-0b2a-4184-8b24-1b335673ef7e	36	0	2023-07-14 12:21:42.281	\N
de36da27-df1c-47e2-baf9-a7aa00478da1	d4dd3b8d-feef-414c-a538-92be779daa3f	36	0	2023-07-14 12:21:42.287	2023-07-14 12:21:42.287
1ad95b0a-b3a8-4384-9b08-7ee17200ee7a	666c8c03-420b-4353-b1f2-59e458deee90	36	0	2023-07-14 12:21:42.293	2023-07-14 12:21:42.293
50b2f9db-3ce4-474c-8057-5fba83f53b8d	3f1cd2a8-dd19-4522-ba1d-923fe1fb8a62	36	0	2023-07-14 12:21:42.299	2023-07-14 12:21:42.299
171bdde9-0a0f-47d7-a8c1-bf34eea9dbac	21f07170-de4c-4e33-a4ee-c5b02662f085	36	0	2023-07-14 12:21:42.305	2023-07-14 12:21:42.305
d01b4447-a315-43d2-a72b-5d0c6182a394	3b2e498e-fd04-40cf-8e7c-7d039c4956cb	36	0	2023-07-14 12:21:42.31	2023-07-14 12:21:42.31
ce029f54-7ab4-4618-9ae8-fed3ea766378	c03d4ede-569e-41c6-aafd-0b93ab9d9080	36	0	2023-07-14 12:21:42.316	2023-07-14 12:21:42.316
c13c5b91-aed3-4930-9173-9d0cf9b098f9	9080eec3-4743-480c-8873-e259b73064f5	36	0	2023-07-14 12:21:42.322	2023-07-14 12:21:42.322
1cb94a50-dd1c-410d-b7b2-da65198cc9de	27e3d083-2695-4c33-9372-beb6c2575c9a	36	0	2023-07-14 12:21:42.328	2023-07-14 12:21:42.328
4e6073df-b13e-49d8-96c8-4c170f082641	83d65a7a-517a-4fc8-81d0-c164f397e0d7	36	0	2023-07-14 12:21:42.333	2023-07-14 12:21:42.333
2c59edd4-8c0f-4b6e-98ac-c23e70ec2591	350ade1c-1401-4624-9019-3d4af7cd58ef	36	0	2023-07-14 12:21:42.34	2023-07-14 12:21:42.34
5f59dbd7-4798-43b6-8818-0e08aad7b0c9	32ff48c2-2599-4617-90c2-3a708c42b1c0	36	0	2023-07-14 12:21:42.347	2023-07-14 12:21:42.347
671f9cf8-a35a-47b2-b5fc-4346c973bdbd	de3cc11d-60d8-436d-85e2-f9eb9dff4b64	36	0	2023-07-14 12:21:42.353	2023-07-14 12:21:42.353
813a1987-833a-4fd2-a6c2-280b3f8e3862	a39b5ce9-a272-4057-96ef-574892f4c902	36	0	2023-07-14 12:21:42.359	2023-07-14 12:21:42.359
05b3097e-aeb5-46c5-b9d8-b7aac8e1dfb4	34ad3d09-04c4-4742-8d0e-636c9911b705	36	0	2023-07-14 12:21:42.365	2023-07-14 12:21:42.365
3492eb60-6d6a-4edd-9d05-0cffdaf7de48	20540d62-4f1c-46de-a26a-eebf606da62e	36	0	2023-07-14 12:21:42.371	2023-07-14 12:21:42.371
b43d160a-53f7-4bdb-9add-97db24272e07	aea2fe4d-d38b-4081-a1e4-e8709698c32d	36	0	2023-07-14 12:21:42.377	2023-07-14 12:21:42.377
de910f19-120b-4e2b-9c5f-35942d92f4c4	ab00abf8-c4db-4814-bbb4-5b60607626c1	36	0	2023-07-14 12:21:42.383	2023-07-14 12:21:42.383
bdcf822c-97be-49da-8e2a-2a63d48a0f45	05b57ebc-2271-4847-a183-ba6efa50363a	36	0	2023-07-14 12:21:42.389	2023-07-14 12:21:42.389
e302b863-695b-4ba8-8e96-51636cc770da	99e6d9c3-c00f-41f6-ad3b-069d662f61c9	36	0	2023-07-14 12:21:42.395	2023-07-14 12:21:42.395
aee91f19-1e3b-4d17-bd6e-c990d514e145	1bbe8294-1c88-4538-a9b0-30065d2e9460	36	0	2023-07-14 12:21:42.401	2023-07-14 12:21:42.401
91b0230a-68d0-4a1f-aea2-270237a4c044	05b19571-234b-4a3b-afff-416ea1acbdb0	36	0	2023-07-14 12:21:42.406	2023-07-14 12:21:42.406
8fc681f9-1c22-4928-9bf5-5baaf26b3bf9	f4afa11b-9d3b-4088-88b4-830f648d472c	36	0	2023-07-14 12:21:42.412	2023-07-14 12:21:42.412
85025b22-92a2-49cb-aa85-1f7d951879b3	fd6abb92-ad82-491a-92cd-2d6790a1fcff	36	0	2023-07-14 12:21:42.418	2023-07-14 12:21:42.418
203f0fd4-4512-480a-bf77-9e62caf4344a	db26ecd1-7a73-4ca2-ab26-253bd00b48ef	36	0	2023-07-14 12:21:42.424	2023-07-14 12:21:42.424
e79d3114-f03e-47e4-a59d-3e6eb9f0becd	1883297e-5445-4f0d-af44-67582c85724e	36	0	2023-07-14 12:21:42.43	2023-07-14 12:21:42.43
704f14ff-d084-46d5-9f76-ce13354a0a82	8aafeb43-bc26-4669-bd7d-011b12bb8e0d	36	0	2023-07-14 12:21:42.436	2023-07-14 12:21:42.436
74f176fe-0ab3-484d-90a2-9e7146314ceb	f6a2961e-288c-4912-ad37-0c6eb51d664a	36	0	2023-07-14 12:21:42.44	\N
d4cb4b65-8323-48ba-ab35-dada690bb3f8	0fd638df-1155-47f1-9909-d70973805f33	36	0	2023-07-14 12:21:42.446	2023-07-14 12:21:42.446
a692809f-547f-40bb-89c2-3b670ccd2e53	3e2d9e10-bd31-4ea8-9a34-52c1266f4039	36	0	2023-07-14 12:21:42.452	2023-07-14 12:21:42.452
790abe18-3a16-43a8-b0f6-8ef0bfc9bc5d	28fabb64-c648-44da-bda1-cbfa0d95f2ec	36	0	2023-07-14 12:21:42.458	2023-07-14 12:21:42.458
f26789c7-5b51-46c1-8d5a-848a19714a21	de3a696b-c07d-480c-8d69-3b444cdeef84	36	0	2023-07-14 12:21:42.463	2023-07-14 12:21:42.463
303f2ba8-906f-4720-89a4-4f0c33d22ddd	26609761-27b9-47e0-aed1-29ea37b86307	36	0	2023-07-14 12:21:42.469	2023-07-14 12:21:42.469
40c510ef-dbc2-4f88-8947-de4b65cb2462	556a34ab-6212-47f3-ab0e-f68f2d44bdc3	36	0	2023-07-14 12:21:42.474	2023-07-14 12:21:42.474
e41e5173-6f91-4a81-b38f-3b1fd0d45765	d0568df8-dda0-4cf1-9abc-a29508350191	36	0	2023-07-14 12:21:42.48	2023-07-14 12:21:42.48
42596a01-23fd-4f7b-a2c6-02c7fa1be689	bb35cbf4-2557-4a89-8cdf-f28bdf81e580	36	0	2023-07-14 12:21:42.484	\N
1f407f8a-b1ea-4fa7-b330-e0a39e7ec4a1	df2d2273-ea08-4f73-9a77-0cfb99bec429	36	0	2023-07-14 12:21:42.489	\N
80e55149-594c-4bec-9422-3e6526f69649	4cfd4865-b335-4e19-89e0-7b81f14cca11	36	0	2023-07-14 12:21:42.495	\N
a0a5fb4a-e67c-4f73-b485-4ffb15ff66f8	22070504-b248-4794-9377-2327e1fa6259	36	0	2023-07-14 12:21:42.501	2023-07-14 12:21:42.501
a6a68169-ee4b-4390-9277-19c5879e8b85	064decda-bb06-429e-8111-679c35681316	36	0	2023-07-14 12:21:42.507	2023-07-14 12:21:42.507
7afc5f7b-37dd-476a-be57-4f878c85ed60	e048bd6c-a65f-4c90-bf7f-cf03c1b06a90	36	0	2023-07-14 12:21:42.512	2023-07-14 12:21:42.512
13861731-5859-4180-a40c-f74268cd0bfd	7bb07689-1d69-43fe-8f08-9c2fcd7e3c45	36	0	2023-07-14 12:21:42.518	2023-07-14 12:21:42.518
2a1ebb33-b147-45ec-85ec-a102c041366f	adc6f36f-20b0-4177-8001-6a2a6d07fbdb	36	0	2023-07-14 12:21:42.523	2023-07-14 12:21:42.523
fd306c0f-ac63-43f8-a1c1-35ff3c650001	395da688-ff8a-4f08-ad18-ab494c2b654c	36	0	2023-07-14 12:21:42.528	\N
f8d0b630-2fe9-4c9c-a2cc-874996eccfbf	11a33a9e-1738-4c73-95d5-308ebeedc0f9	36	0	2023-07-14 12:21:42.534	2023-07-14 12:21:42.534
fc87e696-823f-4bb3-ae66-e94821685ddc	b5fff0ca-9f60-4278-9ed4-7cf1420da2e0	36	0	2023-07-14 12:21:42.539	\N
05e7d845-77ca-419f-ad5b-680e53dc36cf	4d2cbec6-ff18-4182-aecf-0e2902b6970f	36	0	2023-07-14 12:21:42.545	2023-07-14 12:21:42.545
2bce2c33-201f-4785-b138-d43e5835402d	e26e6aee-fa3e-4667-b3ad-3183e2664cb0	36	0	2023-07-14 12:21:42.55	\N
9398ee73-3842-4b33-bde4-1a6b88faf194	cac0987f-3e14-4b38-a6e1-59f4fe8206f7	36	0	2023-07-14 12:21:42.556	2023-07-14 12:21:42.556
98061245-b470-4de9-beba-6218fc32679a	a371753d-eac1-4ea9-912c-c27e6878772f	36	0	2023-07-14 12:21:42.561	\N
85f744eb-4ffd-4e91-933c-f2a82718e137	b8d4ada2-4f25-4695-869f-5994e3ff9f7d	36	0	2023-07-14 12:21:42.566	\N
020f5b23-8f32-4746-b573-5b14a59f9f2e	0b2236ea-4fb8-4b66-8a23-02044665339b	36	0	2023-07-14 12:21:42.571	\N
dffd0601-2ead-4df9-ae46-bd021ecd1028	fd1240b4-9d4a-4b24-99a9-ca3fd3d1644f	36	0	2023-07-14 12:21:42.576	\N
b27e6283-6040-4c72-bcb7-bd6c621c26e0	8a5072d0-aa3a-44e2-b483-f3bc4de6825c	36	0	2023-07-14 12:21:42.581	\N
1abf8f3d-1474-499f-ad86-fad61061c62c	e4363169-6f04-467a-83c0-efa0a64d7054	36	0	2023-07-14 12:21:42.586	\N
0563f231-2062-4209-a069-61cdfb52378d	585715a2-94ee-41d7-bd73-70259f4ae918	36	0	2023-07-14 12:21:42.592	2023-07-14 12:21:42.592
e00b7ede-5d46-4df6-b60e-2a9d2bf6f5ed	c55a745d-b176-440d-9838-1bfd10d7223d	36	0	2023-07-14 12:21:42.597	\N
e4493556-d640-4994-a4b5-1885f2af27cf	ea65e223-027a-488b-8178-1c73cbcf4979	36	0	2023-07-14 12:21:42.603	2023-07-14 12:21:42.603
7dc3da44-60f0-4f1b-b307-97601a260110	f13aa186-945f-4e10-a429-e936f841dccb	36	0	2023-07-14 12:21:42.608	\N
73868036-8fdc-4a46-a72f-4fff8c341faa	b53200bd-16bc-4b4a-81f2-9cc1d42d4931	36	0	2023-07-14 12:21:42.613	\N
92c86591-7789-4f6d-8cc4-7096432c8063	f0452433-0382-4956-9883-e471b888629c	36	0	2023-07-14 12:21:42.618	\N
a8b0e37e-f8ad-4181-b1e4-38e8bbb952fe	25054e9b-280c-406f-8290-3dd9fc84830f	36	0	2023-07-14 12:21:42.624	\N
26e73fec-f3d0-4a29-806b-b2e990181f74	3c5c9883-3b9f-45a4-ac2c-6fcdf3212415	36	0	2023-07-14 12:21:42.629	\N
0e4c1d1b-3f1f-45ed-941a-e4e741788eb8	55076c72-eccb-4dd7-99b2-5e42ddcce4dc	36	0	2023-07-14 12:21:42.634	\N
291c7df8-5b38-4eef-ae75-573131a33e70	54346e2f-8104-43f5-9d44-a1c02ce24f46	36	0	2023-07-14 12:21:42.639	\N
45ada195-b60b-4dd7-8254-e5eb0cb765aa	7a744620-1b44-49f7-a115-58d42f78ca10	36	0	2023-07-14 12:21:42.644	\N
8e41dd4a-98fc-491e-b3af-d5638017cf47	4e0873f6-f934-4410-b6e8-aa604b7341b5	36	0	2023-07-14 12:21:42.649	2023-07-14 12:21:42.649
3e09014d-d875-4f1a-b02d-b2be41090341	5221493c-260c-4494-8f00-601a92950dce	36	0	2023-07-14 12:21:42.654	\N
cece2c80-53ef-4bf1-a478-b43596913af8	13268378-7cd3-4327-9de9-0f9cd0d0e24c	36	0	2023-07-14 12:21:42.66	\N
c7c41bf4-e000-4714-9c28-b992c942f01f	11d249c8-fa62-4cc9-bdaa-36d0c5461d84	36	0	2023-07-14 12:21:42.665	\N
331d2c00-8177-4d90-90ca-20d6578d87b1	d25ecf0f-e9ae-4c34-a09d-bf6dedcead9f	36	0	2023-07-14 12:21:42.669	\N
a17de75a-18e6-4612-a54a-8f7805fcb64f	b7426eaa-81ba-46dd-958a-d78ac8bdafe9	36	0	2023-07-14 12:21:42.674	\N
25d0a808-a84b-4019-a410-040d37e256b2	e31fc0ea-1a75-42c1-8e7f-342559e432d1	36	0	2023-07-14 12:21:42.679	\N
1948b727-7b27-4f76-b5b2-73de4d8a924c	725755a1-0c93-45e7-b75b-a42a411bd255	36	0	2023-07-14 12:21:42.685	2023-07-14 12:21:42.685
4bee3c90-e9a4-4ae1-8773-637afa18af02	2196ca59-23ab-4f9c-8f70-dcc891350a19	36	0	2023-07-14 12:21:42.69	\N
0434e2d9-01dd-4552-b392-bfe8e8f62824	c99f847c-bfe4-4b96-89bb-a3fcaf63ee72	36	0	2023-07-14 12:21:42.695	2023-07-14 12:21:42.695
55d516e0-e68a-4836-b1ff-5b37d83826bd	eb3b2396-bd30-48ff-a344-32088dfb5500	36	0	2023-07-14 12:21:42.701	2023-07-14 12:21:42.701
a755c7df-cf65-4310-8ec1-66414ec423ca	54d9eec5-e395-4bb4-98be-c9150b704218	36	0	2023-07-14 12:21:42.707	2023-07-14 12:21:42.707
f069e551-7f17-4a1c-8a5b-4bbb79151b80	bfd3ccf2-5912-4ea9-9c66-8eb30c6cfddb	36	0	2023-07-14 12:21:42.713	2023-07-14 12:21:42.713
10f13481-8354-4d14-a35d-3ef76bfb13a3	7fbc3b89-0f1f-4691-ae81-1e70b1be9733	36	0	2023-07-14 12:21:42.719	2023-07-14 12:21:42.719
6ebe87f2-515e-4df4-8207-c62a4d561a38	43cd46d6-f192-47eb-95a9-a2783f5fac92	36	0	2023-07-14 12:21:42.724	2023-07-14 12:21:42.724
29866a56-96c2-4483-8233-1fb969c4e837	eb70e639-7ca0-40bc-b49e-4734b020e8c6	36	0	2023-07-14 12:21:42.729	2023-07-14 12:21:42.729
45e292ff-381c-45c4-b377-9854f2c675e3	ce163171-661e-45a0-8299-852239060ac3	36	0	2023-07-14 12:21:42.735	2023-07-14 12:21:42.735
9bf4a373-7b6d-44b1-8d01-50f323edce7e	04bd796d-e5d1-455a-b73c-956c8b855c6f	36	0	2023-07-14 12:21:42.748	2023-07-14 12:21:42.748
3bfeaf65-2506-4972-a2b3-d05e605d590f	c13a5f25-4437-4b8d-9b89-12abbd2dee7a	36	0	2023-07-14 12:21:42.754	2023-07-14 12:21:42.754
d7afa072-157a-45f3-96f7-b79e4684f4d0	9072e4f4-6e31-49c2-b840-c46f883486fb	36	0	2023-07-14 12:21:42.76	2023-07-14 12:21:42.76
3038ed68-7dd9-42d7-9620-504b1bc9f071	9431ef83-8a15-40e2-9192-2f35d3083d44	36	0	2023-07-14 12:21:42.765	2023-07-14 12:21:42.765
b96fd072-ac6d-4e39-b46a-2f6562736f7b	286f3f5c-cbe0-4055-96c9-79b6663dff27	36	0	2023-07-14 12:21:42.771	2023-07-14 12:21:42.771
6ef3636d-f5f8-4021-a59f-0de65d0226e9	63243e88-8217-4b6a-a546-b21c47c538bf	36	0	2023-07-14 12:21:42.777	2023-07-14 12:21:42.777
56039ce5-dce0-45b2-92d2-107c1d1bbe78	4bfc1d24-2793-4d31-938a-d8f2ff25bb98	36	0	2023-07-14 12:21:42.782	2023-07-14 12:21:42.782
5193c553-d6cd-4e8b-ab19-8a326fc1a3cc	4ce9c4a0-0072-413b-ab4a-5c2b5921e943	36	0	2023-07-14 12:21:42.788	2023-07-14 12:21:42.788
55ec527f-d791-49e5-8451-c796032863db	16ce1e36-f68a-481f-831d-95ee59447c5f	36	0	2023-07-14 12:21:42.794	2023-07-14 12:21:42.794
9c21b668-7e94-4391-ac97-678d58b8b278	3dee8ad4-59e8-46ae-bed1-a8f59833854f	36	0	2023-07-14 12:21:42.801	2023-07-14 12:21:42.801
83e4e4d2-2f91-4046-9be8-94e214b54828	e6cfaff7-6e4a-4e06-a5ea-861ae2cd0214	36	0	2023-07-14 12:21:42.807	2023-07-14 12:21:42.807
91eec508-2251-49e1-afaf-753b81d13585	fe659e41-5ad6-400a-96c6-55c6d96df571	36	0	2023-07-14 12:21:42.812	\N
685bc9ea-498a-485d-baca-233914a42ef1	d9d2e8c1-2e2c-4b12-9670-4e201a891dfb	36	0	2023-07-14 12:21:42.818	2023-07-14 12:21:42.818
5c9f27a6-b4af-4ff6-afbb-d326282854f7	1c5ae57f-d16e-418b-a8e5-2bd91ddecf62	36	0	2023-07-14 12:21:42.823	\N
76b9c512-73d2-4c44-b64c-5a92fee590a0	602c5c6e-a9fd-4060-a215-31263c6911b3	36	0	2023-07-14 12:21:42.829	2023-07-14 12:21:42.829
ca0233b6-1a33-4f0e-8969-8e60aeb6c04b	1df9c493-f210-45c5-b674-8b357878bf5d	36	0	2023-07-14 12:21:42.834	\N
7d949ae3-cda9-451f-acc6-ea2a4e4d2ddd	0bdd9958-cc59-4a75-923f-631f4ee944f3	36	0	2023-07-14 12:21:42.839	\N
e0a4d918-81c2-40de-b2af-10f6f344bde5	d8cb5f3e-5212-4edc-912f-9816de9394f7	36	0	2023-07-14 12:21:42.844	2023-07-14 12:21:42.844
79a4c23a-a6ee-4aa7-bf91-13c3a5caf5f5	0306b3fb-0261-44d3-85c6-a3e11e1b3fce	36	0	2023-07-14 12:21:42.85	2023-07-14 12:21:42.85
3352413e-fba5-4797-9d34-16ef804134e7	a09997df-b639-4e8f-97e5-2ba3b2ae3490	36	0	2023-07-14 12:21:42.855	\N
9dfdf1f9-7948-41c9-824b-9a5dc1f0249a	b22bb730-9074-4233-b05c-e289d89e8215	36	0	2023-07-14 12:21:42.86	\N
04ab6b82-7f7f-4db8-9f18-16e0f8210c28	17287de3-bfa2-445d-aba8-7e5ee380e53e	36	0	2023-07-14 12:21:42.865	\N
e122e904-351c-4eff-80a4-0036c0e2dc86	9a675017-d953-4f01-b78e-0e03a9a4fbf0	36	0	2023-07-14 12:21:42.87	\N
b850dca7-edac-41e8-bd2c-7493c37946f5	06c110eb-5c99-473e-bc29-3fcc9cd76045	36	0	2023-07-14 12:21:42.875	\N
755ee0cd-9ecf-4fd4-a151-e323911f278a	a702a1dd-efeb-4e33-9b94-660fe1702a52	36	0	2023-07-14 12:21:42.882	2023-07-14 12:21:42.882
cb645229-6a70-4adc-a7d3-1bf39a80fc96	9c02d719-f073-4719-9699-97d3f6053d17	36	0	2023-07-14 12:21:42.886	\N
2e6eb224-8213-401d-8808-a9d80d41a1d0	3fe19200-bce9-4ea3-a5b2-4a975b2d5ecf	36	0	2023-07-14 12:21:42.891	\N
54a2ac62-be0f-41cb-873a-b14682cc70ea	4966e3a7-64ac-4aa3-93fc-92c3a7cb2175	36	0	2023-07-14 12:21:42.896	\N
37188bfa-da83-48fb-b23a-dfce6641ca99	f986ba44-59ad-4ab6-aa61-eca803292358	36	0	2023-07-14 12:21:42.901	\N
ff95cd40-6955-4a75-96c0-1c4836be9acf	b63d4c23-c6f7-4f48-96f5-99dbb4e11bbc	36	0	2023-07-14 12:21:42.906	\N
d1f3a4fd-2a0f-413a-8d96-ff2a4939ee5e	c8b5b2d1-842c-4665-977d-c62a0f01f8ce	36	0	2023-07-14 12:21:42.911	\N
e4030952-bd92-479d-a89c-128b919dfc64	23aaf19b-dde9-4fed-92e9-81dec4b72ba4	36	0	2023-07-14 12:21:42.916	\N
10effe19-f884-4576-8022-ccff1088e2ca	bae84d88-7181-4053-b879-b46989235f1d	36	0	2023-07-14 12:21:42.921	\N
a1977e82-cd6b-44cc-94c1-69337a33bfb2	e5b68834-7553-4b14-8bc8-96b26dd0d169	36	0	2023-07-14 12:21:42.926	\N
0e7f2df7-9a45-4451-9534-e6745a7dc0a3	c205cd74-8a39-47c2-8c9c-4373b080e0f8	36	0	2023-07-14 12:21:42.933	2023-07-14 12:21:42.933
0369715b-3799-4d7d-9c44-61bb14986bea	bf98ffe0-8105-4c64-ad92-4e8738630622	36	0	2023-07-14 12:21:42.938	2023-07-14 12:21:42.938
a0cacaa0-7673-49ce-a5de-54e844b9888c	adcfc26f-4e80-4534-9167-59f694ae0bbc	36	0	2023-07-14 12:21:42.943	\N
df3c0093-ddc1-4028-8623-5e51b997e397	33ef104b-3b18-4802-bd70-8ac393168bd3	36	0	2023-07-14 12:21:42.948	\N
cc4892db-4876-46de-8e7c-25c5b7881e51	9c5d0e60-5b79-489b-8e72-81773d55603f	36	0	2023-07-14 12:21:42.953	\N
a94ddadb-7864-47dc-b52d-bd3e2c7e4214	1d42809a-c4b1-427e-9feb-cbe16eb22357	36	0	2023-07-14 12:21:42.958	\N
850f0915-5f9e-403d-9abd-fd86511fd709	4d68016f-90a4-4416-a830-e34d4ccc4170	36	0	2023-07-14 12:21:42.964	2023-07-14 12:21:42.964
c284a696-b5c1-4def-8289-041421aa7f57	39f30790-b432-476a-b510-0094ed72faf9	36	0	2023-07-14 12:21:42.968	\N
52a620a8-ed8e-4fb5-a5cd-34176d9e10ab	d7792974-e9fc-4db8-93cc-856c2a6b3c8d	36	0	2023-07-14 12:21:42.973	\N
7bc6ad2f-d196-43e6-9544-1bc20dd70596	5787d877-817d-4229-bdb3-ffc7d18808e5	36	0	2023-07-14 12:21:42.978	\N
583f224e-b85f-4903-8e0d-1b5807a1f3ab	8f12abc3-c1c8-48a0-a772-36c7fb2937f5	36	0	2023-07-14 12:21:42.983	\N
fddd2a09-a6ee-4718-a6d8-10605e19e6d6	8c1c6cde-c437-4611-8b85-f59c04db9912	36	0	2023-07-14 12:21:42.995	2023-07-14 12:21:42.995
567c7f23-8fca-4387-8c8f-7503981ab53d	c3b233f6-d730-41ce-80f0-51fa50b574a4	36	0	2023-07-14 12:21:43	\N
c86eb4f0-3c97-42b6-b515-5b02e97aed0d	52272b0d-6d76-4066-937b-75418e212a74	36	0	2023-07-14 12:21:43.005	\N
61f5766a-b679-427b-b696-23c6e77be6d5	bb6f92a6-fe43-4c9e-b9a2-cc63b997046d	36	0	2023-07-14 12:21:43.011	\N
d77acba3-c342-43db-aa52-f9c16b0bd2a1	9be28166-b7a4-4010-8a06-d795c2c1bf55	36	0	2023-07-14 12:21:43.018	2023-07-14 12:21:43.018
955860ad-6e2c-4722-934e-46f6c41cf5e8	157fd050-e9c7-4ac2-b43b-987151aeba9c	36	0	2023-07-14 12:21:43.022	\N
417a90a7-c91e-44e9-90a5-a5da5777ac67	412c79b7-f0c4-4664-9d84-444b77fd5bbb	36	0	2023-07-14 12:21:43.027	\N
56449ea2-cdde-47a5-815c-9a6acb0e8d6f	247f88a1-1b9b-4d3c-aad3-7bb9263d976d	36	0	2023-07-14 12:21:43.032	\N
8b26da73-54dc-4375-b907-e91285209c4f	7cceb40f-56f0-483c-a5bc-e88c69e0e5e8	36	0	2023-07-14 12:21:43.043	2023-07-14 12:21:43.043
8838efd6-fbce-4d73-b5c6-a5a6d4de2808	adb03bff-4f9b-47ae-9654-106891133a52	36	0	2023-07-14 12:21:43.049	2023-07-14 12:21:43.049
61ca64cc-de13-41dd-913d-cff4ab49e9e8	5414f3aa-5ea3-4b97-88cb-1e4acdf996c8	36	0	2023-07-14 12:21:43.055	2023-07-14 12:21:43.055
c005ade4-c8de-4457-84a6-8b0e6b5ebf87	d43a7bba-38be-414e-8c55-554ff2a0bf82	36	0	2023-07-14 12:21:43.061	2023-07-14 12:21:43.061
d24ae4b3-87a1-4877-ae19-5a2dea7385ad	8ddc1ccb-29b0-4c37-a826-d1e19f649ab1	36	0	2023-07-14 12:21:43.067	2023-07-14 12:21:43.067
6e589520-5eeb-45d6-9849-56a92bb88ed6	7f9552a5-bdc9-44d4-9d14-499b93737a24	36	0	2023-07-14 12:21:43.073	2023-07-14 12:21:43.073
85ef8e90-d8fe-4260-9964-0d14829ecb44	491228e7-2318-4043-b9ef-77057fac95c0	36	0	2023-07-14 12:21:43.079	2023-07-14 12:21:43.079
62a4459d-797c-419a-8554-73059ae4948d	7a68a7ae-719a-4c74-9b3e-315616e8dbe7	36	0	2023-07-14 12:21:43.084	2023-07-14 12:21:43.084
257f8d4a-ede1-4b1d-9e65-85b2552d1be4	9f0ab818-ea50-41cc-b6a7-2f829f3faae2	36	0	2023-07-14 12:21:43.09	2023-07-14 12:21:43.09
d9cb5fba-3e00-4817-b563-4a33ec20b1f1	438a6d7e-5dc2-441e-aff7-ad842ffd5601	36	0	2023-07-14 12:21:43.096	2023-07-14 12:21:43.096
99a949e3-3909-471c-911d-e7adf8ddba07	90fd8c72-8999-403f-9bd4-7436d2af4c6a	36	0	2023-07-14 12:21:43.101	2023-07-14 12:21:43.101
d5f4f6ea-3b20-40eb-ba92-d60992e5fc23	9a321b09-11ec-4a90-9504-759e9a3269ac	36	0	2023-07-14 12:21:43.123	2023-07-14 12:21:43.123
ed890594-51c2-4caf-b718-85150a6b93e6	853659fc-368a-4842-85f7-5051aabf91a3	34	0	2023-07-14 12:21:43.118	2023-11-09 03:55:43.652
9e0545ab-3b1c-47a9-af8a-6823a5ca15ec	345747ac-20a9-4fb9-b6f3-de41ba7213aa	34	0	2023-07-14 12:21:43.13	2023-11-09 03:55:43.66
5033a1ea-e2d4-4f5c-ba6f-a357b722fb6f	52af29ed-cd46-4691-be09-49a342ee1663	34	0	2023-07-14 12:21:43.107	2023-11-08 05:41:37.953
ffc57052-2452-4d6e-ab90-d73393b63a9b	45ad5059-250e-4525-aa66-eb95d21f165f	36	0	2023-07-14 12:21:43.136	2023-07-14 12:21:43.136
4b02de99-5f2f-4940-bca6-146576e65217	84007ba5-b897-433d-a764-4f5be9ac2931	36	0	2023-07-14 12:21:43.144	2023-07-14 12:21:43.144
8a4fb8ca-2e01-4c4c-ac2e-dfe9ef3f6622	6aeaa888-7f7b-4a09-81cc-e596998c96e8	36	0	2023-07-14 12:21:43.15	2023-07-14 12:21:43.15
0c37c795-48a7-4126-97ba-d446180d322d	8c01a18f-fda9-431a-aa89-b45f95af5470	36	0	2023-07-14 12:21:43.162	2023-07-14 12:21:43.162
d70469c8-e46b-4ea6-826c-84e86d3c4fc5	4a6f5bdc-177e-4128-9080-a205cd3a42ac	36	0	2023-07-14 12:21:43.168	\N
aa76fd63-40c7-4f53-8a08-d048148c8240	3122a21b-9612-4ed2-9b3c-25ba9f24e2f3	36	0	2023-07-14 12:21:43.174	2023-07-14 12:21:43.174
0d2fd71f-6be8-443f-b42c-cdfd5fa238c4	08dcd518-4078-4329-b9b0-4081679246a2	36	0	2023-07-14 12:21:43.179	\N
b2a2630c-cd50-42c5-ad4e-4e0b1305e88d	44edd45d-5c3d-4562-a028-bb255b67d492	36	0	2023-07-14 12:21:43.185	2023-07-14 12:21:43.185
2c6957f8-e924-43b5-9de1-6f36166fad80	44994f28-e612-4eb0-92f7-fcd8b4e5f600	36	0	2023-07-14 12:21:43.197	2023-07-14 12:21:43.197
ed594656-7e70-4f2a-b750-c75dcce50ac5	383c3111-5303-47af-9151-2bb299f0eb28	36	0	2023-07-14 12:21:43.219	2023-07-14 12:21:43.219
bf22a1cb-3809-4ce7-8e6f-44a0f1cda8e8	07e21d38-8a0a-448f-8761-a5c2786b29a2	36	0	2023-07-14 12:21:43.226	2023-07-14 12:21:43.226
e7811086-31b7-422f-a464-b64d554c2328	c2f6dcd3-529d-4ca4-b84c-b83c633e3ce2	36	0	2023-07-14 12:21:43.238	2023-07-14 12:21:43.238
d6b596f6-4460-4c77-a097-22679d22744b	130fc5ec-e7a8-4142-853e-d9be084c40b8	36	0	2023-07-14 12:21:43.245	2023-07-14 12:21:43.245
979e2bdb-a56c-4728-b7e0-4bb633bfe6f6	45860172-eb7e-4b58-906a-f487073b051b	36	0	2023-07-14 12:21:43.252	2023-07-14 12:21:43.252
ff643521-7522-4f2e-bcc3-b7327f94b07e	b2ff8c73-38dc-4d98-b54a-5f5bc6099598	36	0	2023-07-14 12:21:43.271	2023-07-14 12:21:43.271
f178a445-6c67-47e5-9527-4c399ea49d1a	7f72566b-2d68-43fc-a0c3-2a29baa3d370	36	0	2023-07-14 12:21:43.277	2023-07-14 12:21:43.277
d588166c-7aaf-48b0-9683-cb4efc182160	f4349416-f1f3-4522-ac2f-69c363418700	36	0	2023-07-14 12:21:43.284	2023-07-14 12:21:43.284
7f42abe6-376f-46e1-aca7-072dbdc0b621	b166f660-eea5-46b4-af50-e71d5554cd8e	36	0	2023-07-14 12:21:43.303	2023-07-14 12:21:43.303
a47d2508-805c-4466-8b25-d679b5206fe4	760d3855-65cf-48a8-b2fd-42fc02435802	36	0	2023-07-14 12:21:43.31	2023-07-14 12:21:43.31
dc428960-314e-40c2-983f-585663bc2244	fa564883-b05c-4e67-855c-e5e50adb00d9	36	0	2023-07-14 12:21:43.315	\N
ce051359-7fd1-4c82-8035-ed373d84a1b8	9e6dc627-b199-48d3-9253-fd8badb06070	36	0	2023-07-14 12:21:43.322	2023-07-14 12:21:43.322
ef81cb8c-5d6c-43e9-9f18-159572b42e66	45eaea86-0169-47ec-8e9e-ebecccf3fb23	36	0	2023-07-14 12:21:43.34	2023-07-14 12:21:43.34
4e7dec15-f12f-4b8d-828e-7da7ad3fd5db	eafc63bc-edd2-46e4-b96c-f3ccd9ea3056	36	0	2023-07-14 12:21:43.353	2023-07-14 12:21:43.353
c6cf0a40-3039-45f7-ab3a-06674735b0d6	d442a912-07d2-4bf7-87aa-eaabb9f3a31b	36	0	2023-07-14 12:21:43.359	2023-07-14 12:21:43.359
06212cfb-3c76-4c5d-9491-87ef35eb37ff	875188f6-51d5-44db-a801-0969bce3b98d	36	0	2023-07-14 12:21:43.366	2023-07-14 12:21:43.366
8c67361f-b376-4fd9-a6e3-7e35fb5e0ce4	ab7a00df-ac68-442c-9e7f-be5915ff83b3	36	0	2023-07-14 12:21:43.372	2023-07-14 12:21:43.372
e4b9562f-5931-4dad-b27b-198617bedc96	f21d945c-989d-4a81-862d-4bb67b4ec9c7	36	0	2023-07-14 12:21:43.383	\N
d49d3701-5a42-4e26-98ac-adb256389efd	6ab16e96-64c5-4b86-9999-494b68085604	36	0	2023-07-14 12:21:43.39	2023-07-14 12:21:43.39
679dc18d-cff6-414e-8edc-4ad6a176d0bc	c0cdefd1-2eff-45c5-8327-e3cd1c8e962e	36	0	2023-07-14 12:21:43.409	2023-07-14 12:21:43.409
feca7ed1-351f-43bc-aa5d-7f65e48ed8b0	8070208e-c1fe-49a3-9c02-d9e5939972e3	36	0	2023-07-14 12:21:43.415	2023-07-14 12:21:43.415
ff7ffd97-1c90-4757-b5cd-c227b7a45bf0	76da99ba-82aa-4918-8322-1057463d53bd	36	0	2023-07-14 12:21:43.421	2023-07-14 12:21:43.421
1f94425b-ac1b-4b9c-9fed-b18917ac4e80	48461ecb-7dad-40ba-a01e-c8fbe2ae4948	36	0	2023-07-14 12:21:43.433	2023-07-14 12:21:43.433
abc691fe-ffc3-492e-8964-dff8fe5f4e01	f70c5fcb-29fe-4e62-ab78-61dea7e5fb51	36	0	2023-07-14 12:21:43.44	2023-07-14 12:21:43.44
d804f26f-98ec-4848-beb8-465d112329bd	6640733e-16f4-42c6-9235-5f7f25e3155c	36	0	2023-07-14 12:21:43.451	\N
37d3ecc4-ad29-4684-90e9-02002b305abc	ec30d151-8593-46fd-b923-b3616d9719e4	36	0	2023-07-14 12:21:43.457	2023-07-14 12:21:43.457
1aa58b1f-7dda-41d3-97a0-cdaa68c48aef	e8c991cd-6d98-40fa-8e81-7e0a53e03abf	36	0	2023-07-14 12:21:43.463	2023-07-14 12:21:43.463
fafa5698-14c4-4959-adbc-087bd8908876	609abc9a-49ea-4fa9-a1ca-ee84182f9dc0	36	0	2023-07-14 12:21:43.474	\N
9dbd81af-3f10-40a9-8fd6-60bf783a6cbd	2257d6d5-15df-4768-8bbd-760f13b498b2	36	0	2023-07-14 12:21:43.485	\N
46cb1034-9a7a-41ff-a6cb-76f721c9f5b4	ecde2c82-9fd6-4684-98ab-ad2e0d429a78	36	0	2023-07-14 12:21:43.49	\N
8cacbc90-2086-47e0-a7c8-5f719595f5ff	5c8a925d-f7a7-4f68-bf85-73fb0ca789ee	36	0	2023-07-14 12:21:43.495	\N
54546875-19b7-4e56-a829-b82841c99652	9c1f343d-52a5-47d1-aa86-5f7794e29794	36	0	2023-07-14 12:21:43.5	\N
16e11255-1a69-4b86-b042-63fbcd8e25ba	f13791f7-4675-49d8-9891-f4da8d235718	36	0	2023-07-14 12:21:43.505	\N
0bbc1685-e788-41ba-9623-9865a20c831c	9a9d3acd-d50b-4b3b-be5e-9e88f0f80e0a	28	0	2023-07-14 12:21:43.378	2023-11-09 03:55:43.628
6186927f-0690-48e2-92d2-c4aacc383d6a	e3b0a020-b8a3-491d-9c41-c2ae36121ae4	34	0	2023-07-14 12:21:43.469	2023-10-17 06:42:36.427
35574b8c-6920-4b4a-83a2-db481e55064c	ff8fb21e-a82b-45db-b723-b97889e8afc6	34	0	2023-07-14 12:21:43.208	2023-11-08 05:41:37.941
f5a30e40-4944-4e1e-ae26-247a2c014137	1dedee5b-ce6b-453a-bde9-6f67a3decd92	34	0	2023-07-14 12:21:43.29	2023-11-08 05:41:37.949
e0aadd84-b6b3-44c3-a29c-8597e070aa4e	75710a8e-ba2c-4fc8-8136-b6da6640e55c	35	0	2023-07-14 12:21:43.156	2023-08-11 13:37:55.305
ec58c692-5f30-4cad-a4d9-0e24200c7a19	bea8c7be-5b7c-4dc3-80a8-ee675895e13f	34	0	2023-07-14 12:21:43.296	2023-11-09 03:55:43.655
cf56aa47-2192-41ae-bdc2-0cf3055ca4ff	fcefd6f0-be68-4cf4-8a3a-d12ba5498e92	34	0	2023-07-14 12:21:43.347	2023-11-09 03:55:43.646
31cce763-9567-4871-89d8-6cc58b00080b	506dbd51-8921-4902-9179-2d24d4cf1f45	35	0	2023-07-14 12:21:43.202	2023-08-17 03:37:04.677
14157646-f962-4cda-ad9b-f15f6a7207b7	835050bf-3867-45e7-a02d-bbe741aa1bb3	34	0	2023-07-14 12:21:43.213	2023-11-08 05:41:37.912
fba66ff0-77c7-48f4-8cee-47ef82f45d18	91e950d8-5582-40a9-881d-0d4e4233a05d	35	0	2023-07-14 12:21:43.446	2023-11-08 02:53:09.079
8130642f-7737-48e7-b688-9493e9c9e975	1574f83c-56c7-4bb1-b60f-b627ba701449	35	0	2023-07-14 12:21:43.259	2023-11-08 02:53:09.074
3e9cb3e3-5c92-426d-946d-1957657765e6	f2477f78-a9c3-4804-9575-5244a8a62e6b	33	0	2023-07-14 12:21:43.427	2023-11-08 05:41:37.907
e8949c8a-c551-4a0a-9c1b-997638a1cf1d	971ea270-5039-4851-9d86-a09a8e75c5b2	32	0	2023-07-14 12:21:43.328	2023-11-08 05:41:37.909
92ef0615-6efb-4be4-bce1-1dc572b9bf61	81c5aead-4092-47eb-a862-0f6d35222f3b	32	0	2023-07-14 12:21:43.334	2023-11-08 05:41:37.912
c00cde38-5517-4f81-add9-c5c37c8d2f1c	bc15a18d-3a86-41ac-a8d4-8fa8ed951788	32	0	2023-07-14 12:21:43.403	2023-11-08 05:41:37.922
f1326e6d-bdc8-4453-9996-2647b7a438ab	6abb20ad-f5da-478a-8d27-ba9fcc41f4bc	36	0	2023-07-14 12:21:43.509	\N
1a0f6ca4-df20-40dc-b296-9862766e0c48	83ef2d5d-6cd3-4fd4-a391-3db0449c6c04	36	0	2023-07-14 12:21:43.514	\N
28bb12dc-c111-4f06-9598-5ecd7921ba91	773926f6-16e1-422e-a4a4-e8ecc073d3a6	36	0	2023-07-14 12:21:43.519	\N
3f3dce4f-0f95-4a10-96f2-462f84dbdb7c	757a2777-fe75-486d-88c2-fcd63cd60511	36	0	2023-07-14 12:21:43.525	\N
b462eefc-b1bf-4931-8605-985c9ef134df	7849fa38-f55b-47dc-b123-b0cfa0baee4a	36	0	2023-07-14 12:21:43.529	\N
24e1c565-b2fa-49ad-a5f8-12930501f31c	df73852e-595e-4735-bde6-048cd014995d	36	0	2023-07-14 12:21:43.534	\N
47296772-fca9-4b3e-a84c-09dce8eb129d	161a47f0-fa82-461e-b974-06f69147e62b	36	0	2023-07-14 12:21:43.539	\N
dbd35013-be6b-4714-8e7a-5c6494d85a1a	3f40dcfc-e892-49e2-9878-c35fd3a9a442	36	0	2023-07-14 12:21:43.544	\N
2d6cd732-0701-4af6-9ee3-a1336a79a9e5	5921ebe8-2aa4-4af9-a470-0c06103aa6c8	36	0	2023-07-14 12:21:43.549	2023-07-14 12:21:43.549
7c2e560b-ad5c-49fb-9f5e-447c37756603	e65120ba-14f1-4838-bdd9-28324d945a55	36	0	2023-07-14 12:21:43.554	\N
9fbe71ed-48df-4ab2-9061-a55a57c05db8	2d58be9d-10a0-486d-9b6c-0b76b4cd9b7f	36	0	2023-07-14 12:21:43.565	\N
dc5a75a9-e9d4-46b3-803c-cbc95f1b1c52	179c3f54-084b-49c0-8bc9-bce0088c6bed	36	0	2023-07-14 12:21:43.569	\N
f48a2a6f-6af8-44fd-bdc1-668f046dd69f	15ee892d-d86f-46a0-8ba7-900a79996fc5	36	0	2023-07-14 12:21:43.574	\N
b43ea30d-8ac4-4baa-a1a4-0ac815c5bb29	b97f0068-cfb7-4ee9-bf3e-1fe7830ccc3e	36	0	2023-07-14 12:21:43.585	\N
f67c01d0-4258-4571-b6fe-59309ac332b9	dfc89883-0bf0-413d-a757-23cf2217bf93	36	0	2023-07-14 12:21:43.59	\N
dc42f809-abc1-464b-b9d4-f1e41b2f5cd8	f8ccc9a1-30dc-4033-b34a-dd5a34a6b79f	36	0	2023-07-14 12:21:43.596	\N
b4d79f20-c342-4a5b-bd7c-83e445ad0802	1aa3a202-0ad8-477b-bc9a-103548cca52b	36	0	2023-07-14 12:21:43.601	\N
cd9dbfc4-e006-4c3d-87c1-aa7587587b2c	74e16c3a-2242-4f49-a81e-9ea3babf9c82	36	0	2023-07-14 12:21:43.606	2023-07-14 12:21:43.606
983842fc-c65e-438c-94af-3f6b58830b6b	bd7d50e1-2e4d-4b9d-8468-62a39411c051	36	0	2023-07-14 12:21:43.612	2023-07-14 12:21:43.612
b036de7b-eff3-4da1-899f-3b5b0a5439e2	b89e93e5-ae1a-41ac-8839-7d9af5b2b743	36	0	2023-07-14 12:21:43.618	2023-07-14 12:21:43.618
82d478bd-7089-4820-8eb5-95729539d9e0	54d863db-e0de-48aa-aa30-de6571b1f731	36	0	2023-07-14 12:21:43.624	2023-07-14 12:21:43.624
ef83e255-abd4-4231-b0cb-228ecaad459e	e272fe3f-78a3-45ea-94e8-d1ab98697bfe	36	0	2023-07-14 12:21:43.642	2023-07-14 12:21:43.642
3f1b8233-5be9-45d3-94bf-0d85047c8258	c3383912-7f86-4b9c-a8e5-34c51994daa7	36	0	2023-07-14 12:21:43.648	2023-07-14 12:21:43.648
cadc6925-c147-49a2-98e4-41d057f00d4e	ba58637d-28d4-4069-81e1-de019afb713e	36	0	2023-07-14 12:21:43.654	2023-07-14 12:21:43.654
41baac93-4d74-44c1-abd5-f8565e2f108b	8f024973-acd0-443a-a730-f0e0304b9f74	36	0	2023-07-14 12:21:43.659	2023-07-14 12:21:43.659
4f93538a-6f47-4f3d-8c84-82b5ac0df353	4a08a05d-0952-42d6-a081-af8a24fee821	36	0	2023-07-14 12:21:43.665	2023-07-14 12:21:43.665
f5cb5d20-7180-4ac3-95f6-185972766edf	d6401cf1-175d-42f9-b84a-5c4f385a9d93	36	0	2023-07-14 12:21:43.677	2023-07-14 12:21:43.677
f83db389-09da-435e-84d7-f57ca5f65a73	a60bc086-f5ed-46bc-8f81-64bb74b7e367	36	0	2023-07-14 12:21:43.694	2023-07-14 12:21:43.694
d2e1a4f6-d26b-41ba-b9f5-5f79cb3053d8	76b044dd-27e6-4e82-9c66-eac6b2d0005f	36	0	2023-07-14 12:21:43.7	2023-07-14 12:21:43.7
7ab517ca-7d29-4a0f-8d39-32e63022b1e7	83aee2e8-2851-470e-bc28-ce2c2330a72e	36	0	2023-07-14 12:21:43.706	2023-07-14 12:21:43.706
c78472e8-69ec-4b27-bf45-cd2e97528a5d	de49c7da-6ac0-42a5-bbb1-8675074a3e2a	36	0	2023-07-14 12:21:43.712	2023-07-14 12:21:43.712
fdda99f4-0c6c-471f-9118-086f28028a39	631cf878-508c-43fa-abca-0879653194ba	36	0	2023-07-14 12:21:43.718	2023-07-14 12:21:43.718
de3fb78b-cfa6-4d65-a500-71d314507277	6720bdaa-dfc7-419b-add4-1b7b9180ebea	36	0	2023-07-14 12:21:43.723	2023-07-14 12:21:43.723
8a8a2dd3-d87f-44ad-a010-1b1c04c0e1fe	50a38de9-3992-43dd-a365-dd889f058802	36	0	2023-07-14 12:21:43.728	2023-07-14 12:21:43.728
45c77429-7bed-4fe3-9ca8-0f9d990f3273	1e08c0ad-862d-4b87-a3f7-e506e20d54d2	36	0	2023-07-14 12:21:43.734	2023-07-14 12:21:43.734
81e71e9a-cdf7-42bf-8f17-d0d5f79c8b82	4e8606d4-9294-422c-9119-a8e90758c3e4	36	0	2023-07-14 12:21:43.74	2023-07-14 12:21:43.74
6cee824e-625a-47cc-8922-f4fb8b17cb5f	ede3001d-29ce-4f0a-84a0-db51fef18069	36	0	2023-07-14 12:21:43.746	2023-07-14 12:21:43.746
40071303-eea8-4604-8bfd-b7c6ba1e1062	6eeb44ed-c963-4f01-9610-247ffe63fd68	36	0	2023-07-14 12:21:43.757	2023-07-14 12:21:43.757
10ab1603-ec7f-47df-bf51-3aabe3b19908	df2ca7f9-3730-4831-8f90-3da707e179da	36	0	2023-07-14 12:21:43.763	2023-07-14 12:21:43.763
aae30ff4-25de-4f86-b77c-0f0847af35af	fe3945fd-36ad-44aa-acce-654cfafbc13f	36	0	2023-07-14 12:21:43.769	2023-07-14 12:21:43.769
e8fc0c3a-0c55-4771-baab-ef3445fa9f14	a75f5339-6cda-4497-89ca-1758ba55aff5	36	0	2023-07-14 12:21:43.775	2023-07-14 12:21:43.775
9500222a-5f54-47d4-b053-b8cf6ce00825	632db9d2-4bd2-460c-9514-d74bb5e87762	36	0	2023-07-14 12:21:43.781	2023-07-14 12:21:43.781
20752413-72fa-4d19-8f44-6e6a7040dc88	0bd74f14-bc42-47dc-ba39-912895d0152b	36	0	2023-07-14 12:21:43.786	2023-07-14 12:21:43.786
3505d306-862d-4bcc-bc47-3ee196faa1dd	6a3a558f-20b6-4a4d-8931-8362464a3cd8	36	0	2023-07-14 12:21:43.792	2023-07-14 12:21:43.792
0c647d10-c1ab-4cdb-be67-643d5b5ee89f	86d0bdee-d881-4084-afe7-b2c4711144d8	36	0	2023-07-14 12:21:43.798	2023-07-14 12:21:43.798
43fc363c-fe43-4135-aafd-1c9b32f9d262	efb96196-6e66-44a8-8e2f-5e7037865ef4	36	0	2023-07-14 12:21:43.804	2023-07-14 12:21:43.804
913da34d-3ee3-419d-9af8-2a09fb712342	7100a80d-0a28-429f-9bb1-35cf8b897bba	36	0	2023-07-14 12:21:43.808	\N
1f6805c0-3c78-4894-b54b-56f2050acef5	06a17449-17dc-4202-8e20-cef2efc1d598	36	0	2023-07-14 12:21:43.813	\N
b3a18308-98f8-46b7-bfdf-6bf08418ebe2	3ad26f0e-1c28-4e25-b8f7-abb3902d6de0	36	0	2023-07-14 12:21:43.818	\N
aab928a3-c871-4d2b-8953-d3713ecb899b	9bfc3bee-729f-42c5-82df-ba3c282ab64b	36	0	2023-07-14 12:21:43.823	\N
cc26e356-4770-472f-b583-3494d0789674	0310bada-3e87-4d98-9835-c3fccea48539	36	0	2023-07-14 12:21:43.828	\N
268a8401-d538-414b-be86-2a5635bf051e	51fd02f7-ee0d-4e63-87ce-dd23db7b1aa2	36	0	2023-07-14 12:21:43.832	\N
409179fe-b851-42ff-bc86-3b6b7543f9d7	ffd69e2b-b0fe-4fe9-af6e-3ef8d75f1fbd	36	0	2023-07-14 12:21:43.837	\N
a4adc12f-4daf-438a-9916-3b0f65e5a244	a72aca7c-8889-4ebd-a8cc-d02a00626f66	32	0	2023-07-14 12:21:43.56	2023-07-21 14:52:06.033
773fe277-42da-44d4-a245-aec5ac9aa87a	e3cc7486-6412-403f-8501-109b516eb9dc	32	0	2023-07-14 12:21:43.58	2023-07-21 14:52:06.023
95adcf3d-3aa8-4841-ba1b-b6a728211754	7c22dc89-e61c-4496-af68-7faad9744af2	34	0	2023-07-14 12:21:43.637	2023-08-10 06:20:42.4
e81f85d5-4769-4aea-92fc-601aea4ab495	44a1d007-4a1b-4195-8622-2b6327ce7498	35	0	2023-07-14 12:21:43.682	2023-08-10 06:18:21.74
b906a007-a3a0-48f8-b658-97614a328ebb	eca5d8be-55b6-4090-90d6-22729dc92ba3	23	0	2023-07-14 12:21:40.686	2023-11-12 06:22:22.141
97421f53-f31c-4d2f-ba18-dcafa610fbae	c8da4369-5554-4e79-8479-0e76de556b9c	29	0	2023-07-14 12:21:41.021	2023-11-13 06:01:12.828
f05acb90-d9ca-43bd-89be-d80822cad215	bfa62633-feb2-43eb-8b99-6a7eb0d3566b	30	0	2023-07-14 12:21:41.066	2023-11-13 06:01:12.84
ec368152-3ac1-470c-8a14-771280b7d523	2f4605f7-ddc6-4ef8-bf83-667e575244d0	35	0	2023-07-14 12:21:43.688	2023-08-10 06:20:42.4
e7099885-9081-4026-b19c-b6a5bb88cae6	c1d4a056-16df-47d7-aae4-90231f2a4b6a	35	0	2023-07-27 09:00:16.15	2023-08-11 08:53:53.435
905df763-4f82-4cf8-a807-8b9e4cd428b7	66d97dda-fd2e-492d-8146-ca9512ac0e01	35	0	2023-07-14 12:21:41.458	2023-11-08 02:53:09.019
029d0236-98bb-4f9b-8257-58bc3494ada5	9be4d8ca-e4ac-4d1c-84a1-4cb262b2cc42	35	0	2023-07-14 12:21:43.191	2023-11-08 02:53:09.05
10fed4e0-b082-466f-be15-a040073701b6	09b97077-7d8f-439c-94b5-c66e2cc5a472	35	0	2023-07-14 12:21:43.232	2023-11-08 02:53:09.05
c2fd402d-8b86-40e8-836c-2844215e8351	93db068b-c731-4e13-9b0c-fc70dda20169	32	0	2023-07-14 12:21:43.113	2023-11-08 05:41:37.929
68a8f1cc-fe40-4708-b655-e3f86dfbf716	8019ade5-008c-4a71-8279-58344df330d8	32	0	2023-07-14 12:21:43.397	2023-11-08 05:41:37.929
dbde4961-f505-48c7-8025-694b24c49ce7	7a0e934c-fc3d-41eb-873d-082f881ce623	34	0	2023-07-14 12:21:41.631	2023-11-08 05:41:37.957
71dc4681-b570-485e-a498-1a3912a5d8be	17183098-78bd-44d0-8fab-05c422a0cf55	32	0	2023-07-14 12:21:43.671	2023-10-28 01:24:44.398
4921b365-f774-49d1-a4f4-e4397084b5cd	7dab0a8f-8959-4c6d-b4b1-0d2388ad0cc3	35	0	2023-07-14 12:21:42.742	2023-10-06 05:42:44.107
52aa56b3-4edc-43c0-a5f1-5ea42e1b6d03	af0e3623-e22e-41ef-b6a7-61bca53cd197	32	0	2023-07-14 12:21:43.63	2023-10-28 01:24:44.401
b4bd6e60-5fad-4d3b-8b69-6957a0c615b9	56b4ea55-2c8b-4d8c-a6ac-4fe7ac8ac4e8	29	0	2023-07-14 12:21:41.054	2023-10-28 01:24:44.438
2e60cf02-bf8e-4d16-bf4c-139a2029e5dc	179723a8-a43a-4009-89e7-c41c89176edf	25	0	2023-07-14 12:21:40.796	2023-11-09 03:55:43.629
46077719-aca5-4f70-b54b-d39823688cda	3220cc29-ba9a-4e3f-ae02-f937d32046bc	34	0	2023-07-14 12:21:43.481	2023-11-09 03:55:43.655
f33caea4-6fd2-4fde-ae94-0e0d73812a1a	be7a0bef-1088-4ce7-92b8-d6af714fb558	23	0	2023-07-14 12:21:40.675	2023-11-09 03:55:43.659
0ce1414f-95d1-44f6-867c-5597ba14b889	0851dfa7-9103-4755-a4ab-3ef6c08c044e	32	0	2023-07-14 12:21:43.038	2023-11-09 03:55:43.66
ccab3505-fe25-494a-8d6b-929a817bfa7b	d846c4c0-68c3-4045-9c4d-ff8eace3fa34	29	0	2023-07-14 12:21:41.212	2023-11-10 05:26:54.508
50ee47a4-0b55-4b7f-a127-bf6b0d3b7808	08c14b89-7efc-4446-b8e1-4fe6e92dafaf	29	0	2023-07-14 12:21:40.928	2023-12-04 04:27:46.861
bb0c07ef-4629-4bcb-aef5-c5c6548ceb98	e9af9870-2627-4e23-a475-47803342eaa4	28	0	2023-07-14 12:21:40.82	2023-11-24 01:13:11.109
5c63da78-e551-4971-b494-a5cbc4df3ad6	2688c238-b324-4e71-813a-b03702c1d33c	28	0	2023-07-14 12:21:41.183	2023-11-24 01:13:11.1
54d96281-5229-413b-b700-2933950b00b1	2abad29b-ba4d-4862-a4fe-5fb7c534da16	26	0	2023-07-14 12:21:40.912	2023-11-24 01:13:11.109
69eac86a-82cf-4f46-ad4d-87d53c52c482	2d79aa6d-0078-419d-bf33-dbddfaf33387	33	0	2023-07-14 12:21:41.829	2023-11-24 01:13:11.112
0dd21d2e-d858-4f5d-861d-571bbf4563f6	47938de6-4ee2-4504-a678-f827149a87fe	12	0	2023-07-14 12:21:40.651	2023-11-24 01:13:11.12
fbed6d8e-562a-4b83-be33-7d65c0daa006	680abf23-6e09-4ee0-8f10-5811d5c0ae8a	29	0	2023-07-14 12:21:40.986	2023-11-24 01:13:11.121
d980f860-1606-45a2-a14f-99a42f3add98	7f8cf876-27f4-4744-837b-6adda82ee68d	31	0	2023-07-14 12:21:41.043	2023-11-24 01:13:11.121
7655619b-ebb9-4021-9eef-d88da3dabf71	466019fb-284e-4818-84f2-a812078a3045	29	0	2023-07-14 12:21:43.265	2023-11-24 01:13:11.148
17ef47f2-6241-47a0-851c-3c5e8532de5e	a47b51bf-8167-4a7f-adfd-58dc5ef554f8	14	1	2023-07-14 12:21:40.668	2023-12-06 03:00:15.859
d857cf87-5407-4f83-9cf8-f5445ed2aed7	00e51059-cbac-4b69-8367-de4269873f20	24	1	2023-07-14 12:21:40.917	2023-12-08 12:34:04.701
0c3a1dfa-57d8-41ed-8503-fc6f8f97ab61	35d2aad3-e1b8-4b40-9a36-7aecc55e7bbd	35	1	2023-07-14 12:21:43.751	2023-12-16 16:34:31.681
530dbabf-ed53-4d30-ba5f-2f77f4846288	21507fd1-9303-415b-8b09-a841252985d3	34	2	2023-07-14 12:21:42.99	2023-12-16 16:30:07.214
8d8179e1-647c-46f3-9229-e4131a22b6bc	35282e55-cc08-4e9c-9e8b-0380fbd341bd	35	1	2023-07-14 12:21:42.029	2023-12-16 16:31:09.551
\.


--
-- TOC entry 3588 (class 0 OID 16538)
-- Dependencies: 227
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."User" (id, email, username, password, "googlePassword", role, phone, gender, "inKRR", enable, "createdAt", "updatedAt") FROM stdin;
bf4ce49c-572a-4174-af18-92561499a666	danarita@gmail.com	dana	$2a$10$JxLMZNzz5/nnrrC5wqkeSuHaoPmiE6qXKHNjQL3UnhGQFwLDzMzDe	\N	CUSTOMER	78895685	MALE	t	t	2023-07-14 12:21:38.648	2024-02-08 15:45:26.388
c70a7341-3015-498a-867c-5aad647beb49	kongpanhabot2000@gmail.com	Panha BoT	\N	$2a$10$1M2ELON8Kb3Rsb6nYod82eLxvk/hULxopWsOxJoJ0xUy0IiWTDwDK	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.653	2024-02-08 15:45:26.393
2b2badad-093f-4269-861b-3ecc18ccae0d	paingsimto@sbs.com	Paing Simto	$2a$10$/xINhZF6VeRZza86NnLpceJaBixSlc4YEWl1iABof4jq8/asSzQhW	\N	DRIVER	69737366	MALE	t	t	2023-07-14 12:21:38.658	2024-02-08 15:45:26.399
6972a602-301b-41ee-9c0c-98fb5711f61c	teyyinna@sbs.com	Tey Yinna	$2a$10$UZBz.RyjWCS39tbkmbohG.lq1pECOYS.hZim7HQYt.h/LICB/FFvW	\N	DRIVER	81655442	MALE	t	t	2023-07-14 12:21:38.664	2024-02-08 15:45:26.404
b83a332c-30c7-4ea3-b1ea-7b539de59736	kongbunly@sbs.com	Kong Bunly	$2a$10$pOr2hQVcyLv/gqoU9tX4VeQ.lHtuHRK218Uv/R4J5qE0WUQzrXFQG	\N	DRIVER	969686889	MALE	t	t	2023-07-14 12:21:38.669	2024-02-08 15:45:26.409
0f18f8ee-954a-4bac-a772-7d7a7a4688c7	o.akihiro522@gmail.com	å¤§è°·æ˜Žæ´‹	\N	$2a$10$IxA2ipEhNNnTuKvjNMos8uN63q9Z.gk6FIdmgdDa5bIMSfCiveIq.	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.673	2024-02-08 15:45:26.415
143dbb34-1644-4f2c-9e34-b063fab0d1d7	songrithy2244@gmail.com	Song Rithy	\N	$2a$10$FZSA.S3p0QLoiyHBCJwvguHKT6YhkGOBfODmotM1aYoCxtBXtlTca	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.678	2024-02-08 15:45:26.419
f5ce7c00-e05d-4fd8-8029-3c4b57db4c5c	techuyboy@gmail.com	Techuy Lav	\N	$2a$10$Af4jchFC1CWlLGP.Lb9cIOIcZJWMSlbUnUABnQm8gWITh/HRGFkCW	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.682	2024-02-08 15:45:26.424
a71f62cd-cd75-4fe3-b05a-8dbcc8378835	bora@sbs.com	Bora	$2a$10$ewqVc1zKfxdODT0OvizrRe.236C0OATErTbKkyipriYNTiKatoaIu	\N	DRIVER	12653177	MALE	t	t	2023-07-14 12:21:38.687	2024-02-08 15:45:26.429
de54b003-60a4-4003-b782-8add34fd6d86	saromsaravuthia@gmail.com	THiA VLOG	\N	$2a$10$lLi0Cl2rcmJAT9oBBDt6W.izCgePUNsFqGY38Hpa5z0sEm6vmYxle	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.692	2024-02-08 15:45:26.434
39df94b4-e962-4a7f-9dc8-b1d381653501	sreangvuthy19@gmail.com	sreang vuthy	\N	$2a$10$/mn0sN.43E18krxrOY0isO9u.mnSXbV4Ocyhq4ilgPpFrhYI33p2O	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.696	2024-02-08 15:45:26.438
60665637-cded-4de3-8422-cde59a36884d	sreangvuthy18@gmail.com	Sreang Vuthy	\N	$2a$10$WE3RMudWP0LxTSrOORruROOPQM86C3lWuCJX45GRo.XmgbaV4yz9a	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.701	2024-02-08 15:45:26.443
60e23362-b1e9-42ef-8b54-90aedb2a007a	keoboracy@sbs.com	Keo Boracy	$2a$10$lu23Sp72udvuPfyOMhatt.SEfjzxe0mqR9HD7lvIxUfpcPfbfF7.a	\N	DRIVER	15500099	MALE	t	t	2023-07-14 12:21:38.705	2024-02-08 15:45:26.447
e1e42c53-cc6d-4cf9-9a07-3c853dda5927	thearakim67@gmail.com	Thea Ra Vlogs	\N	$2a$10$CRqU8/YLPMk9SAscv6vToOAGvP7AVl8/EqbFFSLXj2NoV1xthSlVK	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.709	2024-02-08 15:45:26.451
32c1d36c-edfe-4c36-9175-b54ce7a86471	nobnisai123@gmail.com	nob nisai	\N	$2a$10$L5Chu/PXZOv1sRSEnlaed.9H1imSQDYaxYII97w43PW7zqADUoz8a	CUSTOMER	10959546	MALE	t	t	2023-07-14 12:21:38.714	2024-02-08 15:45:26.456
2c8b9006-11f4-4be4-a20f-ae937d0aafb1	cherishyourself19@gmail.com	Cherish Yourself	\N	$2a$10$lYQOtX5daWxP1Xh3nwoir.uwHwPMp0qvNH1IpokeKegxYvau1tTlS	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.719	2024-02-08 15:45:26.461
3716ab5c-f25a-4941-a70f-2acf7fcb116b	thanak126@gmail.com	Creative Records	\N	$2a$10$jWVTtopS9dM7vDAxnHSs9OZAJGEWeEXLnaUoXEk6FFke/CAlJXmQC	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.728	2024-02-08 15:45:26.47
904836b5-276b-4ea5-aee5-1972124ba444	chhunporchou@gmail.com	chhun porchou	\N	$2a$10$RGLtDWbEknmTTEOrytmXB.0G2qxUc1qgSSBIGj87L0uRtDThLiIHi	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.732	2024-02-08 15:45:26.475
a6adc0a0-46e6-47f5-b453-33ae114ae937	nuttaa2412@gmail.com	Nut Taa	\N	$2a$10$ooFIJHWQeMPwXmyqgPvNTu4.tcSzL9gQDpdVFNgzcZpfcdM3fLAkC	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.736	2024-02-08 15:45:26.479
2a5cfe62-7537-444d-a834-d33b02d261e2	piseykorn@gmail.com	Pisey Korn	\N	$2a$10$EpczIjMg8Ho2DJzIUAWyXueQY029U/raJV1kKoHXUhdYN80QNxRzO	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.741	2024-02-08 15:45:26.484
6bc1fcf9-3d74-4e04-bd81-d9203aeb8998	ahcrazy9@gmail.com	Ah Crazy	\N	$2a$10$4.aQV1dvohHLm1fmozB1COiArCs5fXDB3zqt4eGhQpAozM62Ih3A6	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.746	2024-02-08 15:45:26.489
4eec638b-c72e-461a-b477-f4580ae7bf0c	dukpidor123@gmail.com	John David	\N	$2a$10$CRloC1QLgtvrUnuL/RyOfOOroBl5OW4A2FtophZAqpPEWTSP2WjqK	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.75	2024-02-08 15:45:26.493
ee7e2951-1dc0-46ce-bc5a-fa670d13cc39	vouleang@gmail.com	Song Rithy	\N	$2a$10$9EXle.OPnHfn3cfqab/x7eGzovIR5ji2Lrg9w2wtLLyclWfciyn5O	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.755	2024-02-08 15:45:26.498
848828d9-3be0-42c8-b79d-b29431475074	rin@sbs.com	Rin	$2a$10$d4ly8zGWYRd5myyd1EgLJOSUNgy514VUK6daFq3oadduvI7.L8Eau	\N	DRIVER	89490218	MALE	t	t	2023-07-14 12:21:38.759	2024-02-08 15:45:26.502
b3e7ba4c-ff69-4292-8109-8da8cda97a62	hychhayrith71@gmail.com	Chhay Rith Hy	\N	$2a$10$I.CvPq1nD5RiVuiDZHa0j.Z5IVmRzOroJ4AYV6yaAKxNpz9.7JWu2	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.764	2024-02-08 15:45:26.507
ad0187c3-9f37-4d8c-ac4b-7ab2d3650ef6	somphors@sbs.com	somphors	$2a$10$6MCf76szWrdqvMgduWw8fetxGBTRUUJ1UIr1a7.xj9BRTUfHn.B4.	\N	DRIVER	89420903	MALE	t	t	2023-07-14 12:21:38.768	2024-02-08 15:45:26.511
916034f6-a188-4558-88a7-0c313c9b8ab2	keo.boracy500099@gmail.com	Boracy Keo	\N	$2a$10$Pt2u7X0JuCjfxfBxEjk/tekku0OP0rNZyI7NOqsMD6Xdef0mGUkgq	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.773	2024-02-08 15:45:26.517
e199c69d-5d57-48b5-856f-9c2ec315f4e9	olove2053@gmail.com	orange love	\N	$2a$10$072crRtq9YhGogqb4bZxm.Nq3XlRoIe1Xq0XUwzNqMDbEX795J5.6	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.778	2024-02-08 15:45:26.521
59756565-b44c-4adf-ba2b-efe404d1fedc	samnangsett@gmail.com	Samnang Sett	\N	$2a$10$0yyePlKbdURU2qewxTcjyecu8JJmCWvjc4S4ZFDWCCaB5f73affge	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.783	2024-02-08 15:45:26.526
975092a1-84ac-4791-b190-c459fa11cb51	vengtry.vt@gmail.com	Vengtry Tan	\N	$2a$10$ImIKNa1FQ.Ajo3W.UaaC3udRg4eNrjNnNQkwCSpDNK5UAMK3t2E8.	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.787	2024-02-08 15:45:26.532
1b045a04-fb7c-4ea2-8f49-dbb6c8e2ac4f	bunnysancambodia@gmail.com	Entertainment Cambodia	\N	$2a$10$XxgXYArgkdFQ4XZ2j5IvZOQYGlNMUdK2OqIq4zsvQYil9Ojxwfzwi	CUSTOMER	979204601	MALE	t	t	2023-07-14 12:21:38.792	2024-02-08 15:45:26.537
091555b9-d096-42da-9c26-fcccb3edb79a	nobnisai@gmail.com	Nob Nisai	\N	$2a$10$vR7qiTPz5BVT2XdgcKxaoOONDOLv5bnJo.7ChWo7Q77/KfsNUfXWS	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.801	2024-02-08 15:45:26.546
3b8c6e25-b8a4-4882-a4c1-2cd901e92e00	chhoysokunthaneth@gmail.com	Sokunthaneth Chhoy	\N	$2a$10$rgWmpbAO8vU8psNLj1X1oO6fxiHI5iA9NlBZVB5M0q9zhNdHvq6ou	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.805	2024-02-08 15:45:26.551
0758cb49-e550-474d-8d7f-25a5d3284b8d	maria.boklach@gmail.com	Maria Boklach	\N	$2a$10$lHSbmQy0BqVVhwZW9OC/W.G2KD6hspW3fYA0SSeSsHDaFo18XzHCi	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.81	2024-02-08 15:45:26.555
ee87ba85-6b58-4cd1-970f-3ed0705901fd	mrreach0@gmail.com	Mr Reach	\N	$2a$10$pBmQfNzVjb.6E3ZoM9plJOqgnzUTUr5hb2ggFV2WtFNKJq8Tm94tK	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.814	2024-02-08 15:45:26.561
f1c92a36-048c-4305-9d53-e6eabdd63da9	cheanataly10@gmail.com	Naly	$2a$10$MJbZZITQSsX8bUMLunYhiem7INMsKddevvOCWMINy9futuXM17.Jy	\N	CUSTOMER	969212916	MALE	t	t	2023-07-14 12:21:38.818	2024-02-08 15:45:26.565
7c65115e-6232-4522-b2f0-4cc297138e2d	paulchrisluke@gmail.com	Chris Luke	\N	$2a$10$H5zfyUe3FUiBw677csQC/en0CKwwKTEBMuR7DX39Ik4JLeJtI6GIG	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.009	2024-02-08 15:45:26.569
ce23a5c5-885f-4ad7-b536-315d519a4b5e	rasangela.w@gmail.com	Angela	$2a$10$UQTXvx5tjN11pSDSXipE3ObJlUbP/Z/NnNlNb28k2nJom4t.4F0py	\N	CUSTOMER	188882000	MALE	t	t	2023-07-14 12:21:38.828	2024-02-08 15:45:26.579
62a9ddc7-73e9-478b-bb71-e96bd9592a13	darasith4225@gmail.com	Darasith In	\N	$2a$10$/iZHEjDSx1juN62e8xCCcOExstoBC2owxAdrlWmbF8jPvYAD4lVx6	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.832	2024-02-08 15:45:26.583
fd552629-30e6-4c25-a1b8-fbdee9b1b558	oggywann@gmail.com	Ratanawan Thepanom	\N	$2a$10$PuWvUrh/YwoQ66PavgsZ7u4oVf.muEcv5LQiq39C5XuN6H.cJkI3.	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.837	2024-02-08 15:45:26.587
e700aa68-657a-48a1-86a9-71d2e172e4da	sophanonnun07@gmail.com	Sophanon Nun	\N	$2a$10$VbD/a6kRl6bTRXSKbpepUeOpyZxC9lOcok/5Ous9L3RVYDEv2o.3q	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.841	2024-02-08 15:45:26.591
d47c7aaa-0978-46ed-b073-f5d128518e33	suthirakprom81@gmail.com	Suthirak Prom	\N	$2a$10$zQd3cM0cU8LzmsbfdbSRseatZNcYLxw5LnoGuQGkTOEu7kCT7F7mW	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.845	2024-02-08 15:45:26.596
3ecc1de3-afaf-451a-a7a2-0968778c8afe	exselahoula@gmail.com	ex sela	\N	$2a$10$0L13OcSeglxGAB3S7VGdJOIBefyR/o9OhkzA6NC8MdUnEdQPVUnka	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.85	2024-02-08 15:45:26.601
b0e6ce80-c88e-4641-b94c-255b49f15da5	neuporng12@gmail.com	Kdam Brai	\N	$2a$10$U/QOUr3zWZFfKfzan8lEzev.CknQLOm014mzd.rnWSzoEvNaAScXK	CUSTOMER	882550515	MALE	t	t	2023-07-14 12:21:38.854	2024-02-08 15:45:26.606
1e2ca858-282e-4456-859e-29c56db255cd	sreysa0967358193@gmail.com	Lol Sreysa	\N	$2a$10$nqBBQ0PTtyhhTivpn87cf.51wngU6V3BB8D2rrLMS.yKUfcEqPV16	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.859	2024-02-08 15:45:26.61
05e18a2b-2ff4-43e4-a757-182d5568fc1a	basil.mbainto@gmail.com	Yuki Izuka	\N	$2a$10$K.nDV3UYNU77KBUk/ZMZoO4hWUzIjlaSJf3/dPwfUENp6HciH0jcS	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.863	2024-02-08 15:45:26.614
9bed47e5-0b97-41ec-bb46-731a50cfaac1	sokvireak2000@gmail.com	Vireak Sok	\N	$2a$10$DenGVvmvQIybjQXRmAY9Z.DJEgVVf3b5KZwjJ9Ka1cffW45ux/NIi	CUSTOMER	475826482	MALE	t	t	2023-07-14 12:21:38.868	2024-02-08 15:45:26.618
6f0f92d2-9fc2-417c-b2b2-492a0442355f	pichreamarun005@gmail.com	Arun Pich Ream	\N	$2a$10$I9RTjuei7QRI8wcbzsJ/g.t.mr0jUc3fqbwcWGxDOs.juUlX35kOC	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.873	2024-02-08 15:45:26.623
bcc3da79-6954-4536-9be4-44657bc4f3e0	thongmonyoudom@gmail.com	Safe Zone	\N	$2a$10$S0wwMvxbjudELr6llnurXevrcQPlVrvyC8Q4v4v6xRrylwTZoNS/O	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.877	2024-02-08 15:45:26.627
4d5d8170-54db-45a9-aeca-67fd6d48c70a	a2aitsolutions@asiato.asia	vKirirom A2A	\N	$2a$10$5L/0w6ZSpbqAFv7k3DmyZOrqAcH0rYl8WqTt8KzbkUoTn1uViA7gu	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.881	2024-02-08 15:45:26.631
71d26ac9-7dac-4066-9b15-e611e868f52d	visalsom538@gmail.com	SOM Visal	\N	$2a$10$U5WkjBex4nsYKd0kGVTlM.s/hi.x3QdHOBqjYgJ3bsmEEXLWFJ1We	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.886	2024-02-08 15:45:26.636
0575fc59-d2c2-4787-9719-40447e9ad712	khuoch@sbs.com	Khuoch	$2a$10$5sS.GH7eG8y4DlD0.bqbYe3jqbfQyWpLmTL0oQcd2.3VF0Wad/GIa	\N	DRIVER	93857205	MALE	t	t	2023-07-14 12:21:38.89	2024-02-08 15:45:26.641
193a3a3f-3a4f-41d0-ac3a-28566cb9bb22	pisal.sambo1997@gmail.com	Sambo Visal	\N	$2a$10$2NO8JIB6MQa2TTioo2WZhO.t72bWFDxeZ.cm5Ekr1TxHV/0jB87mG	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.899	2024-02-08 15:45:26.651
04cf7d4a-df6b-419a-8b11-6c92e4f18b7b	lynanthon@gmail.com	Thon Lynan	\N	$2a$10$3FQ1j14jzs5x3uex7wNVy.L0Sq3WUOzmC6FHM4y8u2I4cs0wRnQ4e	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.903	2024-02-08 15:45:26.655
7136ac55-b4ba-49c9-a33b-5593146b72cc	yo.matsukawa.kr@gmail.com	Yo Matsukawa	\N	$2a$10$NkKUordWoq5uz2Bpw4g.qeDigRlrvpI1mXoFEOW8iU05Z91mK23Ki	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.908	2024-02-08 15:45:26.66
d0e6dc90-e99a-4e41-a18f-12cc92877cca	Sbhawani208@gmail.com	Bunny	$2a$10$D62y5Q6sblvqS7FLbFWu7evr3rnDFkXIEUizkMjmD3fbwVWpnH2XC	\N	CUSTOMER	16766749	MALE	t	t	2023-07-14 12:21:38.913	2024-02-08 15:45:26.665
0aa32ed8-dd69-4d4f-9af2-44e0fa8b3ce0	metheany.98@gmail.com	Thorn Metheany	\N	$2a$10$hNrKQ6VWbQkdmBQ1wXaYRO5DhnBoW2ZlY.JdmxKQx2oEKimBWyhqm	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.917	2024-02-08 15:45:26.67
14bc6cd3-f65e-4ae2-80b2-eff16118a089	panhboth111@gmail.com	panhboth neak	\N	$2a$10$UCLMAc1fyPt1UsgFyegPjOiPoeVLTzMV0tSewsXKNlM0qZ7ZKahxS	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.922	2024-02-08 15:45:26.674
a33ca2ee-4320-4f2a-92dd-5804d8c2a38d	yukinasai123@gmail.com	Yuki Nasai	\N	$2a$10$FMd8s.Eye7BpgrhbBKpp1.5qHBqI2euE8eQ2pzriBryR8JvD2FSv.	CUSTOMER	10959546	MALE	t	t	2023-07-14 12:21:38.927	2024-02-08 15:45:26.679
a7cdcf32-90e5-4e7c-a11b-57864b83322b	yornpichnyty22@gmail.com	yornpich nyty	$2a$10$D850FID8FeGc54zq0v1biusvARblK6yVxXb9XshFYAgJ0L/9vkri.	$2a$10$36s6SkcZe/OsF2UVeeK42eO8n19GkBhjim95SymtGuT3Bqqr0UTDy	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.931	2024-02-08 15:45:26.684
385f9592-f0ac-4014-b048-6d3dac72f381	tomsohor55@gmail.com	tom Sohor	\N	$2a$10$isrrfdYU/ZLxxFD3iLJq5.8uFZC1jK50bc92zGlG5ET49SI.Hcozq	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.935	2024-02-08 15:45:26.69
338f3865-449d-49ff-b9a8-d47f4f458010	bunna@sbs.com	Phen Bunna	$2a$10$f3JrstruY.ahqwEr5QSTtOqmKQK0Ad5T7W20TNAvBF56v0LBxWwGK	\N	DRIVER	11707770	MALE	t	t	2023-07-14 12:21:38.94	2024-02-08 15:45:26.694
3ef809cd-8bf9-42fb-b508-d4d480d67491	oudom@sbs.com	Mon Oudom	$2a$10$Wcrhh.JbvGD2x1GV1AYj8.UhC727B1CtXH1bBcKVn.ozhdhhJcC.2	\N	DRIVER	964428828	MALE	t	t	2023-07-14 12:21:38.945	2024-02-08 15:45:26.699
a8dc4722-4c08-4e79-b39c-f560474cb7c2	creativebrilliant168@gmail.com	Creative Brilliant	\N	$2a$10$4AR3q1UhmRxY/TD919jxOOZJpXCqg.KFIHF/I.Z7MNglPa6EoJjvG	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.95	2024-02-08 15:45:26.704
1652c14c-d648-4df5-9364-cb87c310d9d3	Sath_sovireak@yahoo.com	Sath Sovireak	\N	$2a$10$q4JKWmufzcuzT8ttdixiFeQkdfhdjPHBO9x5U2bxJXJ5zENQ68VXu	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.955	2024-02-08 15:45:26.709
acc69773-acc0-4282-bdee-272a35dd2579	mouyleng25@gmail.com	Heng Mouyleng	\N	$2a$10$AoPwbeYnVl8qIhCYgaQJ4.Rjgvg0NkeKj8AM3IaCoVNeKsqRxSPtG	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.96	2024-02-08 15:45:26.713
c5616536-70b5-4c00-b241-bc5d913fe17b	panhboth14@gmail.com	Panhboth Neak	\N	$2a$10$.7t1fARa/.e.UdWxYIryue7sj6.aYnFLFTNbuHdFqDEkl6IW8aCke	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.965	2024-02-08 15:45:26.718
72bf90bd-a7ab-49f8-8fa8-300a8f1c2642	tha@sbs.com	Hun Tha	$2a$10$EoiC4VQSjXYuB1pJJQoL.eEBrK1Nr.t/Hwcys.WjBvfCzGL7WbfOC	\N	DRIVER	93919124	MALE	t	t	2023-07-14 12:21:38.969	2024-02-08 15:45:26.723
3faddc5e-57cc-4e8b-b021-5ee31b0c2f03	sovannarapich22@gmail.com	Sovannara Pich	\N	$2a$10$PxWXtQULtnm7.LIkw7mtyelwovRqahsX2AlIwzoruNjG1sF8Z9c46	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.979	2024-02-08 15:45:26.732
ddc9ad0c-e40a-4267-9450-0c705dbb239a	longsamann9999@gmail.com	Long Samann	\N	$2a$10$/tzXgfa/lWNwGQ7Y.wan3O4ixgUEhiuo2j2BzCOw0iqgehbE0rR02	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.985	2024-02-08 15:45:26.737
ff606822-89c5-4556-97c8-63319d6cd116	chhornvandate@gmail.com	chhorn vandate	\N	$2a$10$k4nqbl0/Z5cFTXVyhk/CO.xTYDRFS3XSMFcCM0sPC03OXoKNz4kW2	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.991	2024-02-08 15:45:26.742
f1f0f766-a85e-4d41-87c6-984ba291edec	mtanhl@yahoo.com	mtanhl	$2a$10$o46.AFuQZihh7w0I6xAwue5F27NciokpWN1hRIq97pZvyBX5075je	\N	CUSTOMER	8040597890	MALE	t	t	2023-07-14 12:21:38.995	2024-02-08 15:45:26.746
9e6402f8-d49b-4ccb-a4ce-9c276352d432	panhavadd@gmail.com	Duk Panhavad	\N	$2a$10$N4GVsxbHbTVSmmHWUNC5A.GNWnmE6M0ti9XK9HIX7DEV2ltzfK5Dq	CUSTOMER		MALE	t	t	2023-07-14 12:21:39	2024-02-08 15:45:26.75
2ce21f62-0498-437c-a187-dfd8a60e4e38	limchanpiseth@gmail.com	chanpiseth lim	\N	$2a$10$fIL/6wJzJqC0.hRvQY5lpOWGPCIMCa0aQV3/8XfC/xDiaEgpWqtUq	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.004	2024-02-08 15:45:26.755
0a61eaee-22f0-44e4-82b5-7edcaed9fd78	sokvannak@sbs.com	Sok Vannak	$2a$10$xUiqcvCam4pqGXIk/nAKG.m94NlAFYuocOcrMtikIh.zRxkB1e/2W	\N	DRIVER	77332779	MALE	t	t	2023-07-14 12:21:39.019	2024-02-08 15:45:26.763
2b990c9c-4dff-414e-9c8a-78a6448ee318	phokchanrithisak@gmail.com	Phok Chanrithisak	\N	$2a$10$ZXEM2tWMscbJiPjrc/5nnOHdLXW0Q7kmks2RgCQ2xE/P2lQD6mF4q	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.024	2024-02-08 15:45:26.767
1c2a1416-fab4-46dc-a3ab-dfe3a6d110bf	nang@sbs.com	Hun Nang	$2a$10$cPEw0gLCO./HxJIywWbENOK27oMfhLc1JOWnbJtn/eTg2eHOA752.	\N	DRIVER	12798111	MALE	t	t	2023-07-14 12:21:39.029	2024-02-08 15:45:26.771
f4250cee-c889-49bd-a69b-2734b8b11954	thai@sbs.com	Than Thai	$2a$10$0fbXhp.xfMUUa.KtvcVaNuMqkCaT4SxNb83IZS8N45MLHFNGTRDji	\N	DRIVER	17287858	MALE	t	t	2023-07-14 12:21:39.033	2024-02-08 15:45:26.776
37a845a3-3537-4183-a10b-25d7c4f922ac	vainkteshshekhawat007@gmail.com	pubg India	\N	$2a$10$R0edMEbAKUsDLHrq4XohYeiHqdqZJw.swSCm2DaslrXm38GPVjbq2	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.038	2024-02-08 15:45:26.781
7551bea2-f1a4-4244-897a-2b071315042c	mrreach9@gmail.com	Zed NightCore	\N	$2a$10$96jh807yUUwBaQTuzXupuOPkpSxoes6XIt.4U2WtuUrwOuJUMwltS	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.043	2024-02-08 15:45:26.785
07206a59-09fd-4e6d-a81d-33f949123ae0	hezuduf@freeweb.email	Rouen	$2a$10$NdfcYr2MoG1pQywAr1OKvetzkMPc35q4SMDd6eMuQteunUGEcQYRO	\N	CUSTOMER	98991534	MALE	t	t	2023-07-14 12:21:39.047	2024-02-08 15:45:26.79
83ec7e5c-ba5e-4224-8826-5395b286a145	booktheabout@gmail.com	about the book	\N	$2a$10$9hkvQXGFrBNqv/abVtLR.u8RYizujTa5oyjxXgD.emFK568B.iuzC	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.052	2024-02-08 15:45:26.795
59bd9395-b10c-47db-9d52-4e4418bde08d	soklengheang2015@gmail.com	Heang Sokleng	\N	$2a$10$0J99kNR6PBMb3F6EfMFxv.raW2jcr9fKQEiDq28ADtbZdEZxDGctG	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.056	2024-02-08 15:45:26.798
3d56810f-2e91-4264-844e-08d7626c9ddd	techuyboy2@gmail.com	FrenzyFunkie	\N	$2a$10$yQCeP9MupN7iP5wlQG8OJ.x6XIk896lMszH4rPjkPLBT/FGeoy.e.	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.061	2024-02-08 15:45:26.803
26fea8af-15f4-410b-87ed-d7913581d6ee	pedobearsenpai2@gmail.com	Not â€œThe Realâ€ Clone	\N	$2a$10$MU5nd4m3gWJJznRZSWLZQu9.GP/daRElX.0p4Atw4YjfdGq3owtve	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.066	2024-02-08 15:45:26.807
2c47c092-0b09-4ed2-b3b4-1fe0a8ca3e3b	sok.ream06@gmail.com	Sokream Phan	\N	$2a$10$4tEXjO7Sv2t1FORRquU5r.9Va6mYEd5Srb1go.xloWqncJOktxpcK	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.07	2024-02-08 15:45:26.811
25f9dc8f-6f7f-4233-80a5-01bc279857d1	phal@sbs.com	Heng Phal	$2a$10$yfFM0.8u9Za6DZ0yGGd69e527IUPn4GtSmf82a24/9Irge9yAeLWy	\N	DRIVER	15907582	MALE	t	t	2023-07-14 12:21:39.079	2024-02-08 15:45:26.82
0e9ab026-da30-4618-b4de-2e29b3a7b403	sivhour71@gmail.com	Siv Hour	\N	$2a$10$nMv3IMQrjqUwN23rcxnXR.Vyvm2U/ugMRZ0FvgdYHJ29hCFssQfhS	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.085	2024-02-08 15:45:26.826
8bd7a978-7c8f-45b7-9b2c-cb65c1fa9ed9	imjusthappyman@gmail.com	happyman	$2a$10$E9BLbbNyI3rgMWu3sFy5rO0VF3SOHKHBdkSmSZ6FikEKcA6tMifz6	\N	CUSTOMER	9324234234	MALE	t	t	2023-07-14 12:21:39.09	2024-02-08 15:45:26.831
6910e32c-d3f8-46cb-be9d-0fa16a61200b	chris.legaxy.28@gmail.com	Chris Legaxy	\N	$2a$10$G6UQzkdCcN2XxB/6jJf43.CCGswMeJMTsmPdyEl.yO4TSJFpIiZHi	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.095	2024-02-08 15:45:26.835
f8c19dca-7e5b-4c4f-87bd-6c2eb8933e02	teavengtieng@gmail.com	Vengtieng Tea	\N	$2a$10$jjKA/kIWCjca8xxhAAHntOhCu3QbcKUxVBA5Lu5/p.cM.3jWjWl76	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.1	2024-02-08 15:45:26.84
77444f1b-59fb-4f6d-a868-215e6d93442d	nathanzmthans@gmail.com	Dina Chanthan	\N	$2a$10$LQpaV8B6f/Qxdz4/GgMfk.NUsB6zjOXxF7Qp4v4bj5Bot9szEI2XK	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.105	2024-02-08 15:45:26.845
2e6bdb09-c11e-4d39-ac69-4cb993a9d5df	meassoknoy@gmail.com	Soknoy â€œGaara_KHâ€	\N	$2a$10$hmmbbeA7Ing6bsvvVVo1Z.9q0WO67YP/xRwMq..eYu.5RWmrdyJrm	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.11	2024-02-08 15:45:26.849
de3194d3-89cd-492d-84ac-fdad69989349	tevychhy7@gmail.com	Tevy Chhy	\N	$2a$10$rVonNjOocQ2A8YmrHmpFduby.CpGSuD3JL7kISr8Tf047vAVqvwpS	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.115	2024-02-08 15:45:26.854
e08c9428-d028-41e5-a5e7-3f285f90f4ce	samnang@sbs.com	Samnang	$2a$10$kYSt2IUaFacYUwz1K1SCn.GLM5wzV3Ef4kDDvXAlyOtIQHQRwld/G	\N	DRIVER	12798611	MALE	t	t	2023-07-14 12:21:39.121	2024-02-08 15:45:26.859
bdc97d97-7408-4a35-99a2-e811e32f1c2b	oukyulong@gmail.com	Ouk Yulong	\N	$2a$10$PVVf5yQDA4ST.Cf63.ti8eIzr6ghrkQ8v44uK37Xu6g3sI0Ccx5c2	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.126	2024-02-08 15:45:26.863
51b75e32-2d2d-492f-912a-250ac690d0c7	sereysoksan16@gmail.com	Soksan_official	\N	$2a$10$.DR/ToK.totDyTMC7t5x2uYo5wlLT2nPiqntiClnZVi2Q3x2ICegq	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.131	2024-02-08 15:45:26.868
f0c27457-c435-4e98-a6eb-b1595139ffb1	sabbe.kev@gmail.com	Sabk	$2a$10$ZAHlBxVZeJPgO54QrqODueCANlKxPTL.UUojzOM4Ogts1fx5covze	$2a$10$v5ncnaMj1j1NxLS9JwbHVurL7xYgPXGavO.p3WdGajbmuqAGxHHtG	CUSTOMER	16804404	MALE	t	t	2023-07-14 12:21:39.136	2024-02-08 15:45:26.874
e89b529e-0bc7-4e78-af9e-dac7d70d4099	visalyun1407@gmail.com	Visal Yun	\N	$2a$10$cO2N/nlEobMloTNp0TsWqO6hswN4zXlO06yMlvXikMbF0Ukigy9WC	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.141	2024-02-08 15:45:26.878
db956646-6a50-491d-9300-3376ec87b143	tansomnang07@gmail.com	Somnang Tan	\N	$2a$10$iaRLHYz0cMF7dECtP70HHOZX96q8ZmjuvJ1tMA.xzQNAjthIxLT5q	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.146	2024-02-08 15:45:26.883
c319d322-4539-4bb0-bc7b-f1f758a02cad	yrk53ramusalah@gmail.com	ã“ã‚Šã“ã‚Š	\N	$2a$10$cly6j4ROFPUcMv1L6A9lNeW.kxw9PBVX/VD.aCgwUndw7R2bV.5Gi	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.15	2024-02-08 15:45:26.888
ccdbe99e-85a7-4304-8057-ae41ac28e37d	kolbondith@gmail.com	kol bondith doung	\N	$2a$10$rwsDxLBMzjM01BV/cXGl9OeyecgURrGlf/kzeemWKHFZkmOxOgzMe	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.155	2024-02-08 15:45:26.893
ac3d9e04-a639-4efb-97a1-a1d1d005e2d7	leaphengty181020@gmail.com	Leapheng Ty	\N	$2a$10$o1orXbqzVYN8hP7P5naTMunNDAVI4FrPw1SBrW/vobCGx5Vi.M1u6	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.161	2024-02-08 15:45:26.897
c17f952d-23a7-49ff-b098-264f8fd64427	sangsonyrath@gmail.com	sang sonyrath	\N	$2a$10$YWa5pmG.3SzZAR1d8xp6bedF6oTl0.917/abYPMd6O40sfexDWxta	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.165	2024-02-08 15:45:26.901
91fc0bf3-fe71-4f72-8b71-5d60cda551a4	takoyaki974@gmail.com	traveler 1011	\N	$2a$10$L77ZzQbNWZSP8kl38ccjMucEqUMnZn0iJ9nSjuPHflDDtcOm0MYMK	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.17	2024-02-08 15:45:26.906
e5141c98-f0b9-41f5-b2b5-0d1d62fa1b7d	rayboost.custom32@gmail.com	ray	$2a$10$o.M7OYUi9IGbcyyase05QuK95Nnfn5/WmkUz4d02bvmiLdTJ2KUyC	\N	CUSTOMER	968262804	MALE	t	t	2023-07-14 12:21:39.18	2024-02-08 15:45:26.914
d7861827-9130-42ae-a873-39d0ec01ef12	raydark1325@gmail.com	ray R	\N	$2a$10$0hQLHYi8GhYioIGRnZjgre2ee67A33YyFzgN7jfC04xem8gBOzx1e	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.185	2024-02-08 15:45:26.919
32b9bf3f-b4ff-4947-b944-c938d90525a9	ma.chanveasna86@gmail.com	Ma Chanvesna	$2a$10$hMoym.LBYj8RoeTekt50ROeJHTuBCKLKMLC1eA5fMsUkwrUX/uvvi	$2a$10$bYU12fEXa3cNgEl6fgt/RuF2.Il.YeBuEjyhf8zRqnqH4Qvi4WwHS	CUSTOMER	86494972	MALE	t	t	2023-07-14 12:21:39.189	2024-02-08 15:45:26.923
08b956a5-f7d8-4cf6-bfbc-216ff58d14eb	peach0214.m@gmail.com	ã¿ã‚„ã•ãã‚‚ã‚‚ã‹	\N	$2a$10$b9dFMkHNaoEL.U0/MtBOPurzsnRBCONJx2mToldnT6cXgxyv4YF4S	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.194	2024-02-08 15:45:26.928
ec6dc7ec-5eee-407d-8a1e-edc1124adce0	chanreaksmeysrey@gmail.com	Srey Chanreaksmey	\N	$2a$10$usqES63w2cb2ulrvOflpduCRatB896QTICdJNoA7qxzBU6OZMJleK	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.2	2024-02-08 15:45:26.932
57102497-cbf1-4df7-8ea3-794e9e2bad7a	1223misora@gmail.com	ã‹ã‚“ã¹ã¿ãã‚‰	\N	$2a$10$vHBJT2ihLqp8fLUXbni5i./TguVIz45hBdCQj06mX0wHMS1VNCZxi	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.213	2024-02-08 15:45:26.941
cd50da09-ae91-4456-aa17-90884ab1ae3b	brunh@sbs.com	Khem Brunh	$2a$10$R5ULLrVoPR8xEznzwe7JVuxcOInc3zkl3.ebnA8ehOytyESLdlrRC	\N	DRIVER	11707770	MALE	t	t	2023-07-14 12:21:39.218	2024-02-08 15:45:26.945
af1fea14-2a0d-40eb-b086-7969f13a0c93	rii813@gmail.com	ã¤ã¶ã‚ã‚“	\N	$2a$10$WijCPoQMKTLu7DAbkOdOx.frlR3Qt9YeGYS06DY6Nuet7mD0bKwX2	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.224	2024-02-08 15:45:26.95
e8e95ef2-8676-4300-a40a-8aca8e44d66e	thearakim68@gmail.com	Kim Theara	\N	$2a$10$Xl5MNOUQ3tNDWPrWEKiHYupq5BhkItycLzf2IkTMdulfhODLBpfJ.	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.23	2024-02-08 15:45:26.954
db01abd7-d894-4373-b5a1-4e71d2566c46	junseu0417@gmail.com	KRR jy	\N	$2a$10$p6uCJZ.ucrCVE0nqBHf38eCvB.Damu0t2eo3JyfpxSC.oF2zpQJA.	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.235	2024-02-08 15:45:26.959
7b0f4128-a2cc-47ef-9f69-fc4eda20c4e6	p.panhachhean@gmail.com	Pisethpanha Chhean	\N	$2a$10$TpiNeygvGw//gQ2GhZs12efMfaBoAQyF2Q19XXCpJICZLyjEBcUyy	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.24	2024-02-08 15:45:26.964
9a40da8a-1dc7-4e62-b7b4-cdef433a8fae	amchhuny@gmail.com	chhuny am	\N	$2a$10$VQEFor8/4eQ9vvX4J7ssYuEPelbofTITvYYxLNFLUIQqnOr1W.joW	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.245	2024-02-08 15:45:26.969
dafe86a3-5cda-4133-bad0-2fd975b5051a	vornkiriratanak@gmail.com	Vorn Kiriratanak	\N	$2a$10$aFqlvwARw3zNbJStRJ/T7OWe1w42HNAtDFaWNcqAMNMe66yMdKSTy	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.251	2024-02-08 15:45:26.973
9217ec96-cb71-4ff6-8986-ef57ee095770	munyvorn050@gmail.com	Chea Vorn	\N	$2a$10$GoJFzhAfSC5/2Snj0o2cF.M/NQUJz.M4ug6Mlb9ciu3odbRk9SUzm	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.256	2024-02-08 15:45:26.978
13760dbe-a10d-4f6c-a274-b61960483476	tam.subtam@gmail.com	TAM SUB	\N	$2a$10$VOHg3qvVV4yF4.YVel8E/uN6PigYVZTWlOg5KgpkdtoIxOPrYV61e	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.262	2024-02-08 15:45:26.983
aff1a48d-797c-44c0-8190-cacc8f92133c	Sireyrathsok@gmail.com	Sok sireyrath	$2a$10$mGgqMW4B3CxYQgpQYOwvD.LXAGlwA/iRR54dB58AGEDH78SnMyFfK	\N	CUSTOMER	77971052	MALE	t	t	2023-07-14 12:21:39.267	2024-02-08 15:45:26.987
73961a87-36f1-4d0c-8479-c129a8171f7d	ratha@sbs.com	Chea Ratha	$2a$10$kqp6h/xxX4YUPD94q.qyouknJStvTczLXmBm4jlBBS25A33CBIZ9S	\N	DRIVER	11592434	MALE	t	t	2023-07-14 12:21:39.272	2024-02-08 15:45:26.992
f60ee515-0b19-4ed9-8ccc-1fd9d8d326c3	yu.aso.bi@gmail.com	YU OMORI	\N	$2a$10$5jpLCk2Fr.56g0dys4ijEO8TZr2nwtqkQjYCXtH1M/9szGee/vZsK	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.277	2024-02-08 15:45:26.997
761438ca-1107-4d9e-9f83-2ca639d7827e	socheat@sbs.com	Sok Socheat	$2a$10$RJ4FjYlwg.vvbO9B/nnFruvfZjjYWS00E58Z2LUtsQCoxjv1Q3dGW	\N	DRIVER	89979893	MALE	t	t	2023-07-14 12:21:39.287	2024-02-08 15:45:27.006
cc9ea9f5-6725-43a7-b144-fe625311909c	soeuk.khuoch@sbs.com	Soeuk Khuoch	$2a$10$ZQ/PcU/cE3.fohOyA7/lJeGeOaoOiq./hAuD6gcKUHKzzQ8usNv4y	\N	DRIVER	93857295	MALE	t	t	2023-07-14 12:21:39.292	2024-02-08 15:45:27.011
cd6778f2-737f-48f2-b4a2-2f4a52519607	chan@sbs.com	Sok Chan	$2a$10$DCbzRXHiYcqif6KCyZ0t2OgHxKFdClu8/rU08rX2qgbvr4oBp461m	\N	DRIVER	12851568	MALE	t	t	2023-07-14 12:21:39.297	2024-02-08 15:45:27.015
8de9623a-5f81-42d9-b21a-f18abb15a4e3	nakayamayuusuke19990621@gmail.com	ä¸­å±±å‹‡ä»‹	\N	$2a$10$pA3IHIWvSR/fREPwmbQRnehVVzCUS52MnlloC8n5NaRSk.PCwMlvC	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.302	2024-02-08 15:45:27.02
bae3de62-b4ac-4258-9d05-6c9790b4c141	kheansreythou19@gmail.com	Sreythou Khean	\N	$2a$10$.1bJqZp.RhwCUSFR4RJ5KeVIoxCnUEkrFTdsEiAxJZMThQeU1W6xa	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.307	2024-02-08 15:45:27.025
0cb4bba6-193b-4a85-b72e-5326e3ad46b0	kimsereyroth123morning@gmail.com	Kim Sereyroth	\N	$2a$10$yW1q5sSqSishb3AvpIotQeshThE2ZNDAi0vKHyk4k/jSbdFTfalVO	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.312	2024-02-08 15:45:27.03
90d67c39-e60b-41f5-ab0c-821b39f77384	loeng@sbs.com	Chan Soloeng	$2a$10$jvemYod1uoBMfu03YW8Ulu.OXiy944qPQ2ajZvOJzVQyMX15v5d6.	\N	DRIVER	78688699	MALE	t	t	2023-07-14 12:21:39.317	2024-02-08 15:45:27.034
118aed72-cc52-4097-8629-eb5ed3e3a8bb	phanethsorn@gmail.com	Phaneth Sorn	\N	$2a$10$ZfPZJ4nvFllQhBp1D/0AgeoNeEfWMqzszROzfQQaiYMZmiYqVA0i6	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.322	2024-02-08 15:45:27.038
fd3e76e6-84cb-49c0-acee-b241511060fd	lydaneth678@gmail.com	Ly Daneth	\N	$2a$10$hdInzl/sh4eyi5vQBn8NDeceB6N49MIUZQIG5OaeBYzBFu1WzpGZe	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.327	2024-02-08 15:45:27.043
8521a08b-5e2c-47b0-b960-926007857ef2	mosneang@gmail.com	neang mos	\N	$2a$10$6GFy8BDq4Ww.mt1jKPV2WesAMPQPdRipc9.mrkfoiWMRZhdaaU/g.	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.331	2024-02-08 15:45:27.047
53b03e87-b4d3-4446-a533-1f4903c9bcff	chnasjrern@gmail.com	Chnas Jrern	\N	$2a$10$YvyAecwhU7HIUopECCPG4epjK2w4vutZXdUCp.eanb.5Jiyw7hlka	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.335	2024-02-08 15:45:27.051
261be16d-9d6c-45b8-a33d-e7bccc3f3ae2	varathana12@gmail.com	va rathana	\N	$2a$10$bJtgkj0S0BwTluvbRKFe2ONK2lJoe4MhIb5nDJye3SxOPRH1u6AXi	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.34	2024-02-08 15:45:27.056
527dd3e3-5ffd-49fd-b899-93e6c35c831a	srun@sbs.com	Kim Srun	$2a$10$Ow4nJSKeRuTquZNFd4SxJ.TYBecpvJVar9d8jj96id9QHuI7Ll7b.	\N	DRIVER	77740550	MALE	t	t	2023-07-14 12:21:39.345	2024-02-08 15:45:27.061
b5e884e8-76a0-4e54-9186-d57ff6c2c64f	naaaaayuuuuu09@gmail.com	Yumi Nakahara	\N	$2a$10$BSgGTqdYwKPwgYSoCZhzJesejsLvi/5q0I8drJ8e/5B01Q8h/EbMS	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.35	2024-02-08 15:45:27.065
56bbc7e8-d465-424e-b82a-1dd91c403b83	cheasamnang@sbs.com	Chea Samnag	$2a$10$6jAm1ytg2vckfV6zVX7uIulgRCCG/Lfj2HI.t90Hzy2Jtwwv8/sBC	\N	DRIVER	12798611	MALE	t	t	2023-07-14 12:21:39.355	2024-02-08 15:45:27.069
31fdee9d-e17d-45fb-89aa-f87e9ef1a3fa	sethrina2018@gmail.com	Rina Seth	\N	$2a$10$3meyM2zIh7qs0HpDt.XO/eckoCY8rd4bstY/CC6Jk7UeQwmZND6zO	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.36	2024-02-08 15:45:27.074
23a86c01-37a9-475a-b8ba-2eba9f6e8cd9	mouylengheng25@gmail.com	Heng Mouyleng	\N	$2a$10$9dDCyy6SG/XAXblYiiywI.f0uvPrappqB8e5Z6.8L.oQmV5R7LOSq	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.369	2024-02-08 15:45:27.082
9a56bf6d-a15b-4a0a-977f-18c300a8f434	sotha@sbs.com	Ly sotha	$2a$10$i5sQ2JN5FzGWxUagNTghCOlm3KDoYqg0MRrxuw/Dh6i3wfrV227CC	\N	DRIVER	77842931	MALE	t	t	2023-07-14 12:21:39.374	2024-02-08 15:45:27.086
e067c226-d756-4568-a76b-451d3457271f	thou@sbs.com	Chan Thou	$2a$10$4MsJ3RdGfmtaAd//U/Mg5.RAFzF76NpU9tRmROLcJeb5W25FN8ZD6	\N	DRIVER	92408153	MALE	t	t	2023-07-14 12:21:39.379	2024-02-08 15:45:27.09
da655f4c-4ec4-478d-b187-34fa260734c8	bongbora@sbs.com	Pong Bora	$2a$10$NeL6d51TlW39nYtr7I3BaeNZukeF1ym/HOhRIz2r9/MpLChzfkeOq	\N	DRIVER	12653177	MALE	t	t	2023-07-14 12:21:39.384	2024-02-08 15:45:27.094
ac151a61-9546-4449-8aae-a9397c859e09	iamgeraldineanne@gmail.com	Geraldine Tan	\N	$2a$10$Vy4pJh166oNEIcsAqc89ueFy50j3xzDygrixCggPAzfdGgxg6Q6vy	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.389	2024-02-08 15:45:27.098
29767fb9-11aa-40e8-be4b-4d4f986da0b6	taravannuy@gmail.com	Taravann Uy	\N	$2a$10$NZ6nC854HWqh4kIeLZrTZ.ESyE/8Q3HJd.cShKPlm9SW4fnnRmzsa	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.394	2024-02-08 15:45:27.103
8eef5adf-05c8-4f6c-b1b1-9e23d3cb59d2	lychunvira@gmail.com	Vira	\N	$2a$10$85jA4t.JJsVqRMe8nShd8e5YqH2dcfZ0fgaFbPHP8xhWTrQCfY4s2	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.399	2024-02-08 15:45:27.108
119cba60-d3e7-4b1d-a972-c1af69324792	kenzab0411@gmail.com	Ken bekku	$2a$10$yMu3tPuWS/SHVpi64u.luuNkDNtrq6QEnUCtR2kGodcY5lNv/sP/6	$2a$10$DYDwE9xYPJsQJMxZaYkHy.0YYir2WSMVQtoqpTauJ3n5qqDc/VhEe	CUSTOMER	8666666666	MALE	t	t	2023-07-14 12:21:39.404	2024-02-08 15:45:27.112
cdb10698-feb4-4e38-9458-1bd62682b473	tengseavpor@gmail.com	Seavpor Teng	\N	$2a$10$hCAXmtXZdws/EXu/eL4cueCvKZ6Q8oaQHHmldwBRNAwFXuhGBf9yi	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.414	2024-02-08 15:45:27.122
6dfdb3c8-238e-45ff-be4d-f0745da25e10	vuthyzevo@gmail.com	THY ZEVO	\N	$2a$10$9TETlcQjnQwF4Myx3CKkRuvBz1hJcZUtpmREAZqcgA0.JiUU2nvCi	CUSTOMER	98820725	MALE	t	t	2023-07-14 12:21:39.425	2024-02-08 15:45:27.13
e20d88b0-9244-4f5f-a5ba-3ae5f016b52b	vandy@cbs.com	Keo Vandy	$2a$10$bWstxXoQDEm3.wWY1eW0J.nxv97jWYoqFZ0.K6xLia5ywBFVNwld6	\N	DRIVER	12787457	MALE	t	t	2023-07-14 12:21:39.433	2024-02-08 15:45:27.134
169a129d-de86-4c76-97ea-7d7f042c6c2d	chhunsokhom77@gmail.com	Chhun Sokhom	\N	$2a$10$BY.TJWMyDYmzx4HfLrwDsOM6JKlGEQ0Q6q7R/ZD92oEB4wr8ojjQi	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.438	2024-02-08 15:45:27.139
2e7bec3b-bb0f-4a10-9859-9d5a64d954c8	hickio@hotmail.com	hickio	$2a$10$ZnDXI78M9oHuMyBmKXoEmu2fmT3SNfvnou3lVN1JxIheB153JGYuG	\N	CUSTOMER	4254572748	MALE	t	t	2023-07-14 12:21:39.443	2024-02-08 15:45:27.143
eb4d6eb3-1dbf-4f27-9a08-7e941126c1c8	rseng143@gmail.com	Rathanak Seng	\N	$2a$10$kRWHU9Q0Mef8Q4bgQyUhc.xNaX4KT.MYv3u7nAzhFKhuHpDlR0U1e	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.448	2024-02-08 15:45:27.147
764ec087-f07a-4d79-a1ec-69327053df8d	dezodomo@gmail.com	Ztranger	\N	$2a$10$vMdLGjM0xfqYv0px0o91aOFH/rzSbZlH2GueJAw6hUQEJ/63KDGWa	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.453	2024-02-08 15:45:27.152
d3bd8039-8ce2-4897-9b2d-4728717b60a2	youksakmonysothea@gmail.com	sothea youk	\N	$2a$10$O8mfVz4FnFsQcfPSCLF8pOcsAB.TVaS.F7gj81uBhM3lhHk5VfoyG	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.458	2024-02-08 15:45:27.156
ad6f650a-35a4-4b29-b298-5e433eb22956	sprashbrothers@gmail.com	ã­ãšãƒŸãƒãƒª	\N	$2a$10$ktlq8ztfaAhGaOHqi1sps.7IOSzpnxUhEmc0Q0hRCwQzKkdhrKvnm	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.462	2024-02-08 15:45:27.16
468967b3-1841-49b1-a2b0-d9242614b636	kimheang@sbs.com	Kim Heang	$2a$10$JI6che9OLJYFjzhVOtUNv.S/KDvnkwxprYCr7BHpyvYN4z1xBmI/i	\N	DRIVER	77992674	MALE	t	t	2023-07-14 12:21:39.467	2024-02-08 15:45:27.164
c8a8f6a9-034d-4832-823e-1472c86a5486	sovannvathanaksay@gmail.com	Sovannvathanak Say	\N	$2a$10$g5KZka/YkhvxJyu8lC/pKeBN3fWB1/nYzEA/V1jhIu5RRcc1POYFm	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.471	2024-02-08 15:45:27.169
f0b2a434-be54-4f53-994e-a9ed82eab2cd	leykimteng@gmail.com	Kimteng Ley	\N	$2a$10$5YsbKQzrcUbge1fG21FMzu2rITqLpT7i5OMmQq9UExyM06ljPR/MC	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.475	2024-02-08 15:45:27.173
d6d6ad67-5ba6-4ae4-ae8d-79e09e62b8c2	ratanawan.thep@gmail.com	Ratanawan Thepanom	\N	$2a$10$TEkuNh0AvR/vjSfiOZsiROc7GnXY9saAZW4DEIZKV7R.CJ/wPfSVy	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.48	2024-02-08 15:45:27.177
36d9db1d-cb84-492d-9612-ec4de3f84b6e	maimom2222@gmail.com	Five to Seven	\N	$2a$10$7PrsT7hcL1JM9xZhEMVvGem67IIXa.kR61bW/39RePSIkGP1xinA2	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.484	2024-02-08 15:45:27.182
50200c15-886f-444d-90e6-d0dec0050164	chamroeun@sbs.com	Sok Chamroeun	$2a$10$.itPcXP2K4NSJ2yZzNDQRexq8FMqxrT0.iqpFbvKG6wOCbur1mo7u	\N	DRIVER	965443349	MALE	t	t	2023-07-14 12:21:39.489	2024-02-08 15:45:27.186
3f04996a-6c72-40c9-9b46-db0af3c22dfc	sopheak12n13@gmail.com	Sopheak Dy	\N	$2a$10$jcDsDIynI9o1ffotLeUC2OgkrzjLHxfOZNMP/V6Qn6BirMcx18i62	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.493	2024-02-08 15:45:27.19
afb4f979-ded2-4e42-a96e-134d02c59259	krouch@sbs.com	Prak Krouch	$2a$10$2bOEGIJbWqPW6rk.jTSjxOHKrDaBOMNPK0KUqa9EZn6EChh32Chwy	\N	DRIVER	69626768	MALE	t	t	2023-07-14 12:21:39.497	2024-02-08 15:45:27.195
64b52e7d-6e28-44c1-9692-5685e65a498b	mengsokheng@sbs.com	Meng Sokheng	$2a$10$wdHttK78FaHFGEWKQsQMuOYwtGZjoG1Wh7FQNVcQr2qzpF8Zaqdhy	\N	DRIVER	69230274	MALE	t	t	2023-07-14 12:21:39.506	2024-02-08 15:45:27.204
2891e90c-3d71-4abc-8c85-e5adf057f555	senty@sbs.com	Sen Ty	$2a$10$4Pp6XpYoIn.grwooelJMre/x8gLlugY9PaJDJPp84XYGwpDcUu91e	\N	DRIVER	10578778	MALE	t	t	2023-07-14 12:21:39.51	2024-02-08 15:45:27.208
679e24ae-a049-41c7-922d-079c18219f47	chivin@sbs.com	Vong Chivin	$2a$10$.OM9l09COQ2X2yXieT4UT.cGLUV/yuLaq6Xm3J6ODVwLez2PELs2W	\N	DRIVER	98944258	MALE	t	t	2023-07-14 12:21:39.515	2024-02-08 15:45:27.211
c051290c-838e-4cf0-94c6-6d8b9b1475f9	mao@sbs.com	Sue Mao	$2a$10$9uhMVo851UjhiyqhU3MbBOt9C2eNQb/5L9Q1VRy7IOHbu/C2AZF3K	\N	DRIVER	966081601	MALE	t	t	2023-07-14 12:21:39.519	2024-02-08 15:45:27.215
52f6e3c4-ecef-4bb7-87cc-3358f4466560	hournsovannara0604@gmail.com	Hourn Sovannara	\N	$2a$10$UPInY/DEmF1q/m.z8x0nYuuKpmVHo1SE8bSaBPKKMHtIiT7pzkzye	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.524	2024-02-08 15:45:27.22
df4c883f-38f5-4c1c-891c-0c5e4db615ef	leemmf0514@gmail.com	lee fajardo	\N	$2a$10$qUOXXtcTT2OZe7iqXwd60ejwhUj4Y.wW8/eI9xmxechdXPQ5HOOqK	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.529	2024-02-08 15:45:27.225
811e0385-f4f3-4b2b-b7b4-c45ad5d68f06	chris@whynot.earth	Chris Luke	\N	$2a$10$7bhoZb2bss8gIj9q6ViafOP3Hv0CV8C8vObbJin6mUD6jS5RDHQye	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.533	2024-02-08 15:45:27.229
8580a4e5-3169-40a1-bf8d-333f0697ff1c	veasna@sbs.com	Por Veasna	$2a$10$aw8wpFhTcVrVoRtFVIJua.NM/b0zA2rYFGeaqugibr6Yx3RR8shUS	\N	DRIVER	70581212	MALE	t	t	2023-07-14 12:21:39.537	2024-02-08 15:45:27.234
f2927252-55ce-4266-9d97-a71d9895f6ec	savin@sbs.com	Ven Savin	$2a$10$I1PpWj3od1T2obgkwPDjG.Bno.yJwUpNBC9hsxi5wrcFrG3M7mu9e	\N	DRIVER	965335588	MALE	t	t	2023-07-14 12:21:39.541	2024-02-08 15:45:27.24
0173745f-cd63-40ac-924f-8c00f71519bc	test@test.com	rathanak	$2a$10$PdxzD6ighKr1Lj03yw2Q6uWEmTIhWBssodiIowyjucXoGLnMeKsnG	\N	CUSTOMER	86574637	MALE	t	t	2023-07-14 12:21:39.546	2024-02-08 15:45:27.246
6a82418c-c7f2-42cd-aed1-b864342a1d44	test@nak.com	test	$2a$10$gEkY4WXvoJBkdMg986BBVe3mLCuUvAR51n2TOJVzgDpiJwZs8/JP2	\N	CUSTOMER	987654321	MALE	t	t	2023-07-14 12:21:39.55	2024-02-08 15:45:27.25
39b73a36-3f7c-4230-8828-efe6dc2d5ea9	so@sbs.com	E So	$2a$10$g36sNd3NI.tWGC/bXxpvHOMBT12.kWW4pwQlLNRvMs0T0X7k2fHXa	\N	DRIVER	10640775	MALE	t	t	2023-07-14 12:21:39.555	2024-02-08 15:45:27.255
627b5cdf-6ead-4aff-870a-ac7d1d8aab4b	alexablur007@gmail.com	Alexa Blur	\N	$2a$10$Ha4z9lkmq3eMk8DFWdEeCu/fy5qn8uP21mN0Iq7vNHBkrttaQU6Ae	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.56	2024-02-08 15:45:27.259
fb42ef4a-39e0-4f64-bfa6-7b6b1625dbe3	sokhengkaing10@gmail.com	Sok Heng Kaing	\N	$2a$10$5XK10E9.zizHiRQCMzmnQe6FTpF4n9iJ2ryoiGtKzmyqPwRHPFQGO	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.564	2024-02-08 15:45:27.264
d9010519-3230-4440-9e2d-c614e0507f31	heakrant123@gmail.com	Tsuyoshi Takagi	\N	$2a$10$x0LAxmGlazM9r7ocZSdJBevF4GAnhyoE2mENUojICAE9h.okW1WO.	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.569	2024-02-08 15:45:27.268
4ccd5be4-d354-480b-b411-de6e2ef182f0	seaklimlay01@gmail.com	Seaklim Lay	\N	$2a$10$g1mxMuqtvvRd0ZlCNnTpB.kbhT6JLqBTg1Y5uNkb8bTkkXhSGRPma	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.574	2024-02-08 15:45:27.271
57479900-654f-48b1-afa0-aa46daac26c6	tbrjpn@gmail.com	T Ash	\N	$2a$10$vsTCw0KQIyaCZxXXbZqt5O3f574AG8cUAUjWdgenawPWnptxh/cDS	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.582	2024-02-08 15:45:27.279
4dbbdad8-381f-4cd7-befe-2fe92a60584c	sapuu.ryuu@gmail.com	Miya Arasaki	\N	$2a$10$dlY1OuacnfTZf31vwXT3wuwaZDVaEUaPVjOcurQ9eikAJzjdoEzf.	CUSTOMER	99303263	MALE	t	t	2023-07-14 12:21:39.587	2024-02-08 15:45:27.283
9745c0ed-ae17-4aa8-b0ad-38197749f379	marine.kobayashi@gmail.com	marine	$2a$10$dDYZLRxI4Ub0Yw27qdaXquWv6Pm.mf6wYCihFyeZ5U60FZgYYXJSm	$2a$10$YusIcbgskrsOPrF9sQmzD.SN4G/ZadrIXNxnyljAPoPBDqh.bhH3e	CUSTOMER	99830855	MALE	t	t	2023-07-14 12:21:39.591	2024-02-08 15:45:27.288
2e81a7e5-31ec-4f05-9cda-f51b970b10f1	sereypichphan@gmail.com	Sreypich Phan	\N	$2a$10$l0WZZzoJI/OlqjCAhBE0..vRywrfV4fKqRwgFO4kpN2vm7Xb3fDRe	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.596	2024-02-08 15:45:27.292
6bb06091-9085-48d0-a269-61da83bb9f74	apichream@gmail.com	Arun Pich Ream	\N	$2a$10$zA5BG8IKuej3huHN.TQwOu6pwJbiny3tjXe1b/7MDVvz.J/9r2dr.	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.605	2024-02-08 15:45:27.301
f5723c86-06ec-471d-aaf8-178eeeaf6263	maimom61@gmail.com	Mom Mai	\N	$2a$10$XUwZ7z3iFm5UIHwApi5qpe/723OgL3VECvfFraJ9VAWiGo0b/Vyny	CUSTOMER	967969927	MALE	t	t	2023-07-14 12:21:39.61	2024-02-08 15:45:27.305
cf1b9a49-f7e0-48d1-af4d-689ea9c60cff	zachcaizermagsino@gmail.com	Zach Caizer Magsino	\N	$2a$10$ADmvbdTse/dR4hav8ODGv.IQSdwJNiLkLv61ZGqIu9LmOg1bLybmO	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.615	2024-02-08 15:45:27.309
ddd4f317-3bf3-40f2-a944-82b190700ad1	kimhorng2001@gmail.com	kim Horng	\N	$2a$10$Li0tptALDMgbu3mvDnb9melAeZOuIa0o1P3tGum08i/EfKFiNKy5K	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.62	2024-02-08 15:45:27.314
40202d17-158d-47a8-9b46-df41185629fc	clinicdiamond07@gmail.com	clinic diamond	\N	$2a$10$.6v4AyRe3OGfTjon6slhvu0H8DxeJfhgdyrn5kZhcwESGMF2sVFxu	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.624	2024-02-08 15:45:27.318
12ad6b7a-4dc0-4b1d-9165-38c204c1987a	tom.arasaki@gmail.com	Tom Arasaki	\N	$2a$10$1tKOws1NhpULPYN9mmkzKe7iffxp3MvFUzGKCnhEWHErvd28a8.gm	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.629	2024-02-08 15:45:27.322
ba219b91-9bd2-49bb-894b-963b25e1babe	chhornvantha12@gmail.com	Vantha Chhorn	\N	$2a$10$fG1Zkll962qFH9ZkGxtekeihBZkD5uY31C7/L77p8At0BkkWSxED6	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.633	2024-02-08 15:45:27.326
461cbd13-61ba-4581-b44c-89793fc63341	chreachhunneng@gmail.com	Chanchhunneng chrea	\N	$2a$10$GmUj8kzBqunJ3EcbybxmjeEi6WSwnpS3q598n/abBXgsXqpbhIqae	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.638	2024-02-08 15:45:27.332
768b68f7-803f-4a8d-98f4-842ea42b4528	udamvisal0790@gmail.com	Vi Sal	\N	$2a$10$FCM9qp8Gr4H0ajsJFHP9BOO1QBE.0ZFEjLCwAZbh4rrIeTVzC.D5K	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.642	2024-02-08 15:45:27.336
5aff7c5b-2ca2-429f-924f-49cea16a3054	sokpheaktra789@gmail.com	sok pheaktra	\N	$2a$10$thcQlh3uEop4Wi9pjGwR.eypML7qF5E/MhwM/uf9k5iKAvEyBwuze	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.647	2024-02-08 15:45:27.34
d0a65794-2df6-4356-ae35-0f3353f5c508	makototennis@gmail.com	Makoto Arami	\N	$2a$10$8Dx/4UIJy8y88qEiLBT.weOEOBx5baa4Sejvc7CeJ8vUUU2E5xSFy	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.656	2024-02-08 15:45:27.349
8078376c-4d8b-4fa0-a463-d33c7844bdec	ivlayhort@gmail.com	Iv Layhort	\N	$2a$10$nXTiMYbtMvvPlNmNAvCkjOXCeYlkbMJ0RlYZE2ZccAPxmrr/31Cmy	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.661	2024-02-08 15:45:27.353
4c30ecb2-70d5-45cd-84ea-970280efe8a2	yinmazatin22@gmail.com	yin mazatin	\N	$2a$10$YBLwLQkXv3k2jlMbXfw9.OmOcNIRKR2iicsPogGNZaZSDZR.IDLCa	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.666	2024-02-08 15:45:27.357
4507893f-3a2a-4cce-9ae7-80aac59af508	kimkimhun3@gmail.com	Kim Kimhun	\N	$2a$10$H98mX4.EcjFKvO3h4iW0VeujrDpSagEnvjolPXEq9tx.LB5vDCMGK	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.67	2024-02-08 15:45:27.361
0c325c08-01f0-45d0-9575-19e89f3d156e	koeurnsereyvatanak@gmail.com	Serey Vatanak Koeurn	\N	$2a$10$hoZgsL1S0ZzKKZrOkQp/eehnb7CJqJKajMU.n09PH4vMIPjczO92i	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.675	2024-02-08 15:45:27.365
b0208fc2-679f-4f87-bb5e-c7255a85e812	seyha@sbs.com	Bun Seyha	$2a$10$6b68Gl7hgslK/4plbrwo2edhuYbz2dPlV/2XInTeIqF85mQBHeI8G	\N	DRIVER	70984926	MALE	t	t	2023-07-14 12:21:39.679	2024-02-08 15:45:27.369
195472d3-7c1d-4c89-aa17-321834fcbf19	rothana@sbs.com	Chea Rothana	$2a$10$3kpsfqXHjnglbECaQl.Qt.WkXUv377l6WDfDgrKR5WUlsZjNEYh6i	\N	DRIVER	10585968	MALE	t	t	2023-07-14 12:21:39.684	2024-02-08 15:45:27.373
5dcc9273-5678-452c-a9d1-f9f94dedc4b7	borath@sbs.com	Borath	$2a$10$LdkXatPt6iiIcMf1pxZkIuzmBxO0HUYzTaORW5BxxO8QK9.7V5.l2	\N	DRIVER	969582082	MALE	t	t	2023-07-14 12:21:39.688	2024-02-08 15:45:27.378
8e9492e0-44e1-4fe5-a238-780d50905308	than@sbs.com	Than	$2a$10$ppFAoX/zg9Bbdt38f0eWNuNOGs09wrzsRCDsDJ34igGy2MdA/9Qly	\N	DRIVER	969777667	MALE	t	t	2023-07-14 12:21:39.693	2024-02-08 15:45:27.383
8acfb075-ad87-4fa5-b1b3-435af9e9ed16	sokhengchen@gmail.com	CHEN Sok Heng	\N	$2a$10$oDe7oacitERcJDsPhqF/3.rXVM3Jw1M/d7FL0b0N2L0f1U0xkk1ze	CUSTOMER	962415485	MALE	t	t	2023-07-14 12:21:39.697	2024-02-08 15:45:27.388
c44afb73-8480-43fb-bddc-279ae14e9bcb	sereylytakov@gmail.com	serey lyta kov	\N	$2a$10$fmfMn18wsbJve7nEi9nZFutD0hIWom6A/fmTsDcgPiwXaEuQZFI2a	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.702	2024-02-08 15:45:27.392
22768d8d-4d30-466d-825e-55aaf0f03a17	sokleng@sbs.com	Yin Sokleng	$2a$10$Fh/Jm96LNYVaxXmOYmyxbuh.sQhXwqDNlr2cYY.Q6dNKdRShW/3sy	\N	DRIVER	86498787	MALE	t	t	2023-07-14 12:21:39.706	2024-02-08 15:45:27.396
5ac0315d-cef7-40ff-8f13-858202897870	phansovanna18@gmail.com	Sovanna Phan	\N	$2a$10$NuPyx5lh2aaBqiZfAOi2zuA7UN/agCXL.gcK7q5x2Dkb2QjqNNWMy	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.71	2024-02-08 15:45:27.4
2bc5f450-a446-41f6-a389-d3893d3d974b	lil242231@gmail.com	Li Li	\N	$2a$10$1oWqHyzA6kLpM87osqPUjuTJUI8U5.B1ZCld9HTwRuUFtq22S6ZDa	CUSTOMER	967969927	MALE	t	t	2023-07-14 12:21:39.714	2024-02-08 15:45:27.404
02896cd0-920b-4858-9904-18b490b22d64	eko.kamama2@gmail.com	ãˆã“ã“	\N	$2a$10$N5aMiXOt2BDdNpvc.bo4UOJjSYqHoc0Jpw8RKipXTYeMBoXNPJ5RW	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.719	2024-02-08 15:45:27.409
857651c8-2c71-4bc9-9452-d26fb7cc6815	nisainob@gmail.com	Nisai Nob	\N	$2a$10$FE5cNbyNALnRHY8L/Tpd.u4RtkREaP0CpXQSBikM6o5Dv.ZlcxEfq	CUSTOMER	10959546	MALE	t	t	2023-07-14 12:21:39.724	2024-02-08 15:45:27.413
857d57fe-be40-4868-b956-25618e05c2ab	chakreyayan@gmail.com	Chakreya Yan	\N	$2a$10$cyki/o4l68gu6aDbKZ9gGOGIqcWff0u1eHuVMmg8xPWd3K7414cDa	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.728	2024-02-08 15:45:27.416
d4594493-49fe-48f4-8f97-6e561ebb1114	techuyboy12@gmail.com	Techuy Lav	\N	$2a$10$VjP6u5zQ9w6dGurNKNsyIex4zreZ2OhiopyDXFqh/0R7ZduVz3/oC	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.733	2024-02-08 15:45:27.421
3b0e2812-b940-4c8a-b208-bf1b6e594b4e	khepanha168@gmail.com	khe panha	\N	$2a$10$UvyVu7XGrAZxCsTMMF.BL.DhLMHdAt5JEAO3L3QNEhJsmOq5psXKm	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.737	2024-02-08 15:45:27.425
48a6eb49-af68-4c66-bea3-ff39b58b13df	loemkimhak@gmail.com	Kimhak Loem	\N	$2a$10$VRI7xYfORmE/8MamJ9HqR.QDdiqA0fTtYrZBSdgv4ywbZAuBJlTVa	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.741	2024-02-08 15:45:27.43
4a65fdb3-f19b-4787-855c-e8c74d14b7c8	s.vivorth3@gmail.com	vivorth	$2a$10$3cM8we.lszqh1vc8/Egoqes2yToIqqlUVmGtWLZ7QZBDL6LC5RJDu	\N	CUSTOMER	81228849	MALE	t	t	2023-07-14 12:21:39.746	2024-02-08 15:45:27.433
638b29da-b3f1-4a03-b366-6abfeab3f52f	nasaiyuki@gmail.com	Nasai Yuki	\N	$2a$10$PrItU1sMGg4bAYgotAq4muWUREWB629sB/rX2EkivTShDrZKkbAJW	CUSTOMER	10959546	MALE	t	t	2023-07-14 12:21:39.75	2024-02-08 15:45:27.438
32cab213-02a2-4644-9090-6c9a0101cf7a	helloworld@gmail.com	helloworld	$2a$10$5nFVv3pNUDu0cxJEM9D85uTaIo0OwE26cr6y7S2QHZ4DyY.1IixUK	\N	CUSTOMER	70958342	MALE	t	t	2023-07-14 12:21:39.754	2024-02-08 15:45:27.443
8612c096-6f37-45bc-94bc-19781699ebcd	dfasdfs@dfsdf.fsdf	sdfsfdsfsdf	$2a$10$PjXD.86lM34wLa2hD9F9MOTNkGcIHlK5xMA/FCjFcbU.hJlGNMZ.i	\N	CUSTOMER	1212121212	MALE	t	t	2023-07-14 12:21:39.759	2024-02-08 15:45:27.447
b4b39204-b3f7-4dc2-a78a-ec866ce6b3d3	sdf@slfs.cosd	sddflsfjl	$2a$10$1DxqG2rTZROxraybz1ytROR8zaREBovn8U4a0EnN90iTCmKKd0F8i	\N	CUSTOMER	903242343	MALE	t	t	2023-07-14 12:21:39.763	2024-02-08 15:45:27.451
5de82f4e-3582-4cce-806d-34d981288e68	tong@sbs.com	Ting Tong	$2a$10$XTu5HJ5USpXA.0BEQmV7/.AYgDSrdf3Xyu.c4lN9aw6S8GHUl0E8u	\N	DRIVER	966101899	MALE	t	t	2023-07-14 12:21:39.768	2024-02-08 15:45:27.456
9e536c81-d210-4ad8-899a-fed30f483f50	vigneshvky91@gmail.com	Vignesh Manoharan	\N	$2a$10$T8jEm.5SRxS.lH4k6QWuGOuGriAD4pBAy3qYjXJBEFeezKiLSAMcG	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.777	2024-02-08 15:45:27.464
96bd4bb8-ce81-4473-8318-b0e59297f483	viriyakoko@gmail.com	Viriya Houy	\N	$2a$10$w0HCcvRIQZbDViM4Auh1zOZld5.OrCuUG7BABRmd9vv.ZUmep9sr6	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.791	2024-02-08 15:45:27.474
c874f80e-a7cb-4f62-bb79-ad7002ea40e7	ny@sbs.com	Sok Ny	$2a$10$xguu75t0FlbAKf/utmxdbeKsVUG6lQnhBPNT9JK4lM2G1XQAYfa/q	\N	DRIVER	12628978	MALE	t	t	2023-07-14 12:21:39.796	2024-02-08 15:45:27.479
85f4d975-a485-454e-a048-049b7d8a193a	yinmazatin00@gmail.com	yinmazatin	$2a$10$nfUtbPpPk9291OWzBxgyBuQfwY7tIYXZNVwD2auUXMN3JH3fW8zOe	$2a$10$gctYn3CBKgx7vi7h2qalNudyybIWZf6NfZrOKPA/gL90BA2hY2Kx6	CUSTOMER	81307102	MALE	t	t	2023-07-14 12:21:39.805	2024-02-08 15:45:27.488
e2576780-50d7-4900-a265-aaa34a916e17	phon@sbs.com	Phon	$2a$10$6X9x8Vz1O2jj6qd2zDBhWuhqrcootr.SiVPFfdKbcxvbkUV1bw34u	\N	DRIVER	92388858	MALE	t	t	2023-07-14 12:21:39.81	2024-02-08 15:45:27.493
4e6f3e22-e2b2-41c3-baf6-d536e04b188a	molikaay77@gmail.com	momo mimi	\N	$2a$10$SU23li151JZ.XIV2CLJ2fOGPk.tLCAut3DrpvSldkqoMGqvzDMCoi	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.815	2024-02-08 15:45:27.497
5906676a-cb35-4fb2-b60f-a27b3bb11aaf	kanan@sbs.com	Kanan	$2a$10$wVlxZoeZIvl44zoSGe3cme/8pMsSVqfi5XT6mNA0DADy0syulZNXm	\N	DRIVER	81745959	MALE	t	t	2023-07-14 12:21:39.82	2024-02-08 15:45:27.501
6aa536bf-d6d0-46d4-87c8-38ede8a98db8	horn@sbs.com	Horn	$2a$10$a37KubaXpP65OPRtz0hoB.KJnWrpF6Hkd36GHkSZIjFAx95fohgau	\N	DRIVER	93606768	MALE	t	t	2023-07-14 12:21:39.825	2024-02-08 15:45:27.505
96b388af-29ed-4456-9b6b-2cd9c84b717d	vutha@sbs.com	Siv Vutha	$2a$10$fPpwz5e3Hwc94v/hxsZhyenhNs.dACBoBaBspbFBSCH.96RbNX.SO	\N	DRIVER	99993043	MALE	t	t	2023-07-14 12:21:39.829	2024-02-08 15:45:27.509
52de9971-31d0-4aff-ac66-e7a058ba2a24	vithyeasoros@gmail.com	rossovithyea	$2a$10$gyJ3Lx1MIGwKFAGUhqPUDOCWYV4H2tGMNxmta2rjSTQib1sBWF.KC	$2a$10$OidtxayeIuZ0uBAR29A76.CiQVj56LI/D8UueLT5bTJ2lftKr6Cna	CUSTOMER	85758978	MALE	t	t	2023-07-14 12:21:39.834	2024-02-08 15:45:27.513
fefa94f4-7c25-4620-bdcb-a4a3ff77e2d3	yuthneak86@gmail.com	yuth neak	\N	$2a$10$y2nbvkI69lTYC2qw/z/LqukQEbfM7HcBo5.jRkntOl9p26Cn6uBWy	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.839	2024-02-08 15:45:27.517
574021d9-904d-4dc7-a814-c11c2ed149e5	norakrattanak03@gmail.com	ážšáž¶áž‚áž¢áž¶áž…áž˜áŸážáž¾ Reactor	\N	$2a$10$grKuPsYsyEE9nhc4HH.qfeADGOqbuorsXVeep2SCvMZWfvuyuZjwe	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.844	2024-02-08 15:45:27.521
658c83ba-4e82-4a75-88e4-0de6e6238efb	chhuor.thaisan19@kit.com.kh	chhourthaisan	$2a$10$whjHkGjqm7yS13pVWJJRLOKHm34VfDPXTx/CYBjbXhRfePIImiJz2	\N	CUSTOMER	15466006	MALE	t	t	2023-07-14 12:21:39.849	2024-02-08 15:45:27.525
efe4b707-1eb3-4e85-8369-f12ab304bf13	hakrecorde70@gmail.com	SM Chea	\N	$2a$10$ouyI6tTClt1jnNxFzIPZ1utOUEWjROHjATdTjLdwEa.nA.vznD8TO	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.853	2024-02-08 15:45:27.529
8cc0ca84-f0b2-45e4-8cdb-13e8f4e9689a	cheng.mengly19@kit.edu.com	mengly	$2a$10$MdxKQxYz0WYOSKOkaqWgi.aU/qgKAFrW8K55DwWOwjBi6gLwf6Udu	\N	CUSTOMER	11428092	MALE	t	t	2023-07-14 12:21:39.858	2024-02-08 15:45:27.533
10781b58-b0a4-4087-9adb-29afc57543ba	sreyleakdeth002@gmail.com	Sreyleak Deth	\N	$2a$10$gUuhmH473h3uTphUPTLcA.3k1lWZjsObyV/4d/XUo.hodjNDpnDTe	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.863	2024-02-08 15:45:27.537
817e3d95-e81f-4fab-aad9-b82737d94c87	sotherny@gmail.com	Sotherny Kosal	\N	$2a$10$IRW1ni8tBFWUcebmTjgKrec1Hh55b5JOj5ZVDA4kjcN99QzUAUwxe	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.868	2024-02-08 15:45:27.541
5b808274-c2c9-4c4d-a9d9-567f823c9a17	pichsopha874@gmail.com	Sopha Pich	\N	$2a$10$XuvE4l.YpqcIRbl8rBqkUeDNjp8ydCLwNkRZ11fTvYrlJs0AHuFd6	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.873	2024-02-08 15:45:27.545
95660623-6eed-44c2-bd82-03e329ece377	sindaly123@gmail.com	sin daly	\N	$2a$10$Kg3sJLXFRmznCvpMku8bHu28WSYvD1h0XtgnYQtvyWrtwba/eEhT.	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.879	2024-02-08 15:45:27.549
d046bb49-af60-40e7-ae2a-a5e2b01520e6	techgirlscambodia@gmail.com	E-Lab Official	\N	$2a$10$nJk4R9D4H6BCsg4JZKajWumjkdZva4xJthVMr11Rn82yvA7TJesXO	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.889	2024-02-08 15:45:27.557
3d3be792-e14a-4a63-94bf-34525489971f	unmengtong@gmail.com	umt	$2a$10$8ZJiyNvYSFcPZFxvw0wfkuRIqK5y191JMzam0LH0tsF1TuHn0GVuu	\N	CUSTOMER	87831242	MALE	t	t	2023-07-14 12:21:39.895	2024-02-08 15:45:27.561
ee676bd9-31c6-4f3c-b3da-706b70122f2d	nagaboy09@gmail.com	Dark Thunder	\N	$2a$10$I8DxeAPNKSOXZAX0MdgdYOriHVy6e6TIejGjeaeI34gRAz6r5zssm	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.9	2024-02-08 15:45:27.566
48abc885-7464-4c6a-94fd-433429f1d13d	sokvansocheata77@gmail.com	sok vansocheata	\N	$2a$10$w8/eOozkymBuJelzj0zqMuSFQ5CrLfwj0Go2ne2XrfFPtYi5ubCii	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.906	2024-02-08 15:45:27.57
6dbcadf1-6345-446b-82a1-389237cb4a48	jonhjacksonyahoo123@gmail.com	KhmerGuitarPlayer	\N	$2a$10$lUzfqfWSEZ2Kjj.T9OCideE9d/hG6PK1WXcMjmCr3JyJ4rDesh1I6	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.911	2024-02-08 15:45:27.574
b9319ddd-66b6-41b2-a3a5-7eb49b9b4764	jinjason81@gmail.com	Jin Jason	\N	$2a$10$pmfwpOprbdLugGoVaiJK6eFzHfjGnW2nxmutVvo2ZxMsPpELVbN6O	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.916	2024-02-08 15:45:27.578
e35f4c26-2123-4a10-b791-859e8a11b4ca	n.chittaphon@gmail.com	nitaaaa	$2a$10$n8I3P2WrNMVynqfbv6Tu1uqeENU8cv4s.wGilQbuhMxDmkgqQ9lOu	\N	CUSTOMER	99311533	MALE	t	t	2023-07-14 12:21:39.921	2024-02-08 15:45:27.583
b5b022cf-503d-45a9-8751-0075dc714b2f	ryuji.oda@gmail.com	ryujioda	$2a$10$vKECbCnrM5/4TdaIo.Z6oOXKZWNs1T2.mvqWgM4Lka0H4X4luFGFO	\N	CUSTOMER	70624115	MALE	t	t	2023-07-14 12:21:39.926	2024-02-08 15:45:27.587
0fd4b340-eeee-4225-8b9a-5b01c136652c	voeunthavin86@gmail.com	Voeun Thavin	\N	$2a$10$my6XQmJNL1Y9tHj1tN0FHuBNZsii1qcpBXV9zgqo3uAoAag0Ebn36	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.932	2024-02-08 15:45:27.591
b9ffa1fe-6db6-4c96-a086-1eeeb4f6aa30	estelitalitob7@gmail.com	Estelita Litob	\N	$2a$10$nxofpMAw1kDjeR/OVOgaQelNhzk2J6ftLfqHtxR6pRQRR65GJQrfG	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.937	2024-02-08 15:45:27.595
78e7f610-5fff-4bb9-9727-5213bb3a7673	romdoulbou2015@gmail.com	Bou Romdoul	\N	$2a$10$eJWxK/169bVJugyTd2uH5.vKWdZCZwIC9C7aUDOtlvQCqb0kLoz2.	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.942	2024-02-08 15:45:27.599
7c78df1d-d005-4b2b-b3a3-8f8b8b2a2c35	sopheakdy23@gmail.com	Sopheak Dy	\N	$2a$10$PSA01N6LsnbO2jpNocKXZ.ViZ3YkVTclNUGdKTKVYEDcO/QmSc54S	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.947	2024-02-08 15:45:27.604
a66e45b6-4d57-4d74-b42e-df9e1b7662d1	b.syodo.z@gmail.com	kit lauro	\N	$2a$10$3kRBe62uuZFgWr1Z2fUmf.rOCVpt3EitWX6lA6FOYPviqj4KkiBuS	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.951	2024-02-08 15:45:27.608
0ce0fa93-f7f6-446f-96f6-615fb76bd611	sireyrathsok@gmail.com	sok sireyrath	\N	$2a$10$VlEcBD9VCvTqIMeB8Sh3oulV9mZZz0DM0a2oPxc7NV1SDVq4qIaPy	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.956	2024-02-08 15:45:27.613
7b6a2d99-3055-4850-9631-cf37d08ec4f6	borin@sbs.com	Borin	$2a$10$iBgCVemPeCkEPbUOEMQ/T.uui2ogLadkvPs/4uOUegCh3rz0g4umq	\N	DRIVER	969582082	MALE	t	t	2023-07-14 12:21:39.96	2024-02-08 15:45:27.617
e7f1d33f-f06c-459a-a248-2ea842afb3e7	khengchhaya1998@gmail.com	Kheng Chhaya	\N	$2a$10$oLaECUJcnoab2uv6rmxAveQTyM1mE7R.wpU1iGn5Vr7TACCBiLZyy	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.964	2024-02-08 15:45:27.622
8c72e738-4027-4bcb-9efe-8d3c5f70d005	badxx002@gmail.com	Gin Zeeker	\N	$2a$10$d3e/.B0vqSaCV19KlmAfy.7rGvek1LGl97zsLrngacC/OiSiTtPpu	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.969	2024-02-08 15:45:27.626
e421e6a0-6cb5-4e5f-835f-54a6d906c143	sheamusabra@gmail.com	Pagnarith Seam	\N	$2a$10$Fxf5kkcooM.TZ4a82jrZPeFcAFNt7Ux.kr6HjaKfalbavYMtSsqum	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.973	2024-02-08 15:45:27.63
b186e7c5-88f5-499f-8365-e4978a34909f	mara@sbs.com	Mara	$2a$10$xzHX2czAaXhxS7lpbE7KxeGE64C.trNtnWKo.51NTQBRCr9Amb26G	\N	DRIVER	92959273	MALE	t	t	2023-07-14 12:21:39.977	2024-02-08 15:45:27.634
57504b9b-0db1-49af-b72f-b0d9b7289517	lavymeng@gmail.com	Lavy Meng	\N	$2a$10$ZyQmSb9ZvSZ3.dsJzfj7UeNvTMOxJ0m6oi8.yATrPxd2NPh1GlaMS	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.987	2024-02-08 15:45:27.643
4c123ac9-eb8f-4f4c-890c-e61e54de9843	daneichum112233@gmail.com	Danei Chum	\N	$2a$10$nBwTnSFSOpVhQS4dnEbon.rRsvHWU5XmfNnTb26QeUydMqHss03H2	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.991	2024-02-08 15:45:27.647
371f5af8-b1a6-4540-8815-5cd7ea1c8761	pagnarithseam@yahoo.com	pagnarith	$2a$10$GRDuHSdHE9bHctOThj0m6eVLiFN5lpMAhgAQL.sB2KlHRXG171uk6	\N	CUSTOMER	81675567	MALE	t	t	2023-07-14 12:21:39.996	2024-02-08 15:45:27.651
575b05d6-098f-42bc-9bd5-b636a13dcd25	panha.ly07@gmail.com	Panha Ly	\N	$2a$10$8XPmZQ.hi16BOUxxbrF7GuwTcH1wE648BeYb0sREzdgsRhyYBz7Wm	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.001	2024-02-08 15:45:27.655
d3500035-d125-4c41-8445-ae1719d37d61	sokhonchhun12@gmail.com	Sokhon Chhun	\N	$2a$10$6wgYan.Hj0cCGtDfzuBFZ.nACQSgK6ukhL8r1kL2tqQoGEbQKf0Nq	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.005	2024-02-08 15:45:27.659
f789ba9d-7e29-4d69-aba6-a746bdd18881	thea@sbs.com	THEA	$2a$10$zrDNfg.ppyN7mc16hZy6eui.v8GDdZAhlWT.YGFB.rnZduU9aaEOC	\N	DRIVER	77980703	MALE	t	t	2023-07-14 12:21:40.009	2024-02-08 15:45:27.663
5a595640-c932-4354-93c7-515b8fd85d34	vanna@sbs.com	VANNA	$2a$10$FzdkYDlLB5dbr6f.d7gjF.FER.jUn/Bt0XbjGFPA/j.p1vreIjn5m	\N	DRIVER	12817287	MALE	t	t	2023-07-14 12:21:40.014	2024-02-08 15:45:27.667
327eeaaa-e258-42ee-8bc6-a16f06f64a8a	nat@sbs.com	NAT	$2a$10$/KTnZ5bv6lkFDj6oYaM5..rSV51af6yFMTSXaZ/IPAFR79/ntQKo.	\N	DRIVER	89393878	MALE	t	t	2023-07-14 12:21:40.018	2024-02-08 15:45:27.671
b64afd65-685e-4b1d-b983-df5717349802	pich@sbs.com	PICH	$2a$10$JbN3GXFibMBK7JlmhhL7ruyu1iKeUYZzkRtURYrB5kv0IY4VeKFUa	\N	DRIVER	966236513	MALE	t	t	2023-07-14 12:21:40.022	2024-02-08 15:45:27.675
f6cceb56-63ca-47cd-8453-6b8aed9d2192	chumdanei97@gmail.com	chum danei	\N	$2a$10$/XBpKvbmV/c9/l013/xt4ujNsaZ4PnXCJF6JJVlQ009n0s/Majbg.	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.031	2024-02-08 15:45:27.683
13086738-7f53-4eac-8b7e-5f2859119927	hoeurngluhen2021@gmail.com	Luhen Hoeurng	\N	$2a$10$svfimCJrRcdMvWlCd.t4.OXpdHYVyu4NnCU7sKe.PxBTqsvWzm71u	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.036	2024-02-08 15:45:27.687
ef78cf17-ceb3-4de0-9ee5-c406bf4387b6	viyuth1994@gmail.com	vith viyuth	\N	$2a$10$MvJs5.oHfzmkE8T9ueJM2.FS51IS2RCPiKUNbjzCofi8gsI.sjS5y	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.041	2024-02-08 15:45:27.69
ea2c8a95-a722-4700-9c8e-8f3d62247ab8	runjapan.info@gmail.com	æ‰æµ¦è˜­	\N	$2a$10$.9XCGde/C9fWeOOrBUoRVuN.tgkuQvuA/xi.0xDQMRI5/heaGBgGe	CUSTOMER	99833177	MALE	t	t	2023-07-14 12:21:40.045	2024-02-08 15:45:27.694
0eabce33-da5c-4b70-b9ba-74a587d7324c	kentakura211@gmail.com	LinJa-ãƒªãƒ³ã‚¸ãƒ£	\N	$2a$10$4kXL/pOedjdcIuuNpfoWkuJD/9kimPwDZP1Ro7L4mIR.A9Cn41cpK	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.049	2024-02-08 15:45:27.698
cf9d9a00-43bc-44a3-9811-7cca4cd3192d	sunkimhong321@gmail.com	M A O	\N	$2a$10$FZlHpg3c7YOCbNBpwuxAdOSeAGA7VPJZeLYgpQDTfSK.XKSr8ozVe	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.054	2024-02-08 15:45:27.702
f221c092-22f7-4a55-8feb-fe42e124d985	leang@sbs.com	Leang	$2a$10$YRh45qzfgULv35ooBrodcexbMZbqgXfZOkA0OfybmEvn7bdnWGva2	\N	DRIVER	964074959	MALE	t	t	2023-07-14 12:21:40.059	2024-02-08 15:45:27.707
66b720cc-d797-49b8-b037-c7ecefb868da	khidayet@gmail.com	adana	$2a$10$hTbd1JgIxmCG42JBUNGR1eNxGFpX727jCbkmWZugGPOU1g/JcXiOe	\N	CUSTOMER	70832602	MALE	t	t	2023-07-14 12:21:40.063	2024-02-08 15:45:27.711
5c4e5ac8-32b0-4d98-bc46-b4e3f902e5cd	chamnolthea54191@gmail.com	Chamnol Thea	\N	$2a$10$srW4JW2V5Fcm6e7KbSHHV.k7TUyDFc9eFlVqcHU4KeUdoq7ThcKgq	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.068	2024-02-08 15:45:27.715
4bed94f3-77ae-40a1-945b-6838bcafcc91	theanlaythorn@gmail.com	thorn theanlay	\N	$2a$10$1eJHznTNTysKl./nV/6ZwOAAz6keVSzT5kwdOOftCtFQ9BV28Fuju	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.072	2024-02-08 15:45:27.719
94b48649-3267-40f3-aec3-844504be45cd	ch_seyha@hotmail.com	pheak	$2a$10$Nen4qIPQGvgvZeLCRBC5yOA0HJwkF4LVpKvBD/5Lbgt3cq/EV7DPK	\N	CUSTOMER	17992088	MALE	t	t	2023-07-14 12:21:40.077	2024-02-08 15:45:27.723
094aa68a-8fb2-47a6-89e3-ac3501724433	chitra@sbs.com	Nang Chitra	$2a$10$.EOToWLWdykF1JEVt4jPeOxP6QkS1L68/LuF.toLwguA8.bpQ8ece	\N	DRIVER	967058079	MALE	t	t	2023-07-14 12:21:40.081	2024-02-08 15:45:27.727
4991a60b-33a7-4aac-b63a-c0ad6e421c20	suy.chakryya@gmail.com	Chakriya Suy	\N	$2a$10$HbZN8EDV4RZX9wop.rrXBun9ybfwTtwOrMIQ4Uk/yX3aqIsSm62oy	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.086	2024-02-08 15:45:27.732
85a95169-8e3b-44d4-ba70-0a07699fa91a	tsonitaa@gmail.com	Taurus sonitaa	\N	$2a$10$/NMSDVvmAe5osjRkj3Da.em5Y09ojcRqYbxWUsi79m0UgobFz5SQy	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.09	2024-02-08 15:45:27.736
bbbdef3e-2a9b-4bca-b7b7-7c5a6fb6cdfe	jongil.jeon@gmail.com	Jong-il Jeon	\N	$2a$10$SwZl/t3bMmFmLDno0N1eTe2Z0s50WtqW7N65Y6KWaXvucgOeVokdS	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.094	2024-02-08 15:45:27.741
5632e662-0e21-4bac-98cc-7b13971d6590	tola@sbs.com	Reth Tola	$2a$10$tHnc2MruHEqE/AXvXYkD0u49mBXk2572Z.SMnEuG0xn4YI4pfzJhu	\N	DRIVER	715151465	MALE	t	t	2023-07-14 12:21:40.103	2024-02-08 15:45:27.75
576fe6af-767e-44fc-8875-40c0e0592213	sophal@sbs.com	Yan Sophal	$2a$10$0l.natlxS4ICdEVUxVtZoO9xHyQTusTIPIxrGOEFakWINKRCZAiY2	\N	DRIVER	968870278	MALE	t	t	2023-07-14 12:21:40.107	2024-02-08 15:45:27.754
e2bcca4c-495d-48e8-b30a-c6e83e26df91	sokhomchhun15@gmail.com	Chhun Sokhom	\N	$2a$10$NedDUwQkHhDpPFrVObKytuHt1yPBDWc.g46f48yB07UXUOXRcl27C	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.111	2024-02-08 15:45:27.759
bb274cf4-3139-4617-8c03-994462b2ecce	taormina.bastien@gmail.com	Bastien Taormina	\N	$2a$10$Ygo2EAQMQw.V5uViQmDI1uIbuh9Y4.t.6NrVYZL8UqM4CsSEsm9zK	CUSTOMER	606826722	MALE	t	t	2023-07-14 12:21:40.116	2024-02-08 15:45:27.763
f8e52ba3-fe75-4a0c-92a7-ca2bfe7b12ac	jiyoon1979@gmail.com	ë°•ì§€ìœ¤	\N	$2a$10$W1gvnpeUJKpCZ2lCpXFyKe0pVrUMyhIGa7dgMRLC7Pp8/X2HJPEUK	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.121	2024-02-08 15:45:27.768
5a57ed00-d704-4a37-a207-5db9a9a5e7b6	somesa@sbs.com	Som Somesa	$2a$10$YHye2NeOSJvn85KU1m.Uv.YPI8CNEj3xsAzocT/4sEs4DVtzgXQaS	\N	DRIVER	69314241	MALE	t	t	2023-07-14 12:21:40.125	2024-02-08 15:45:27.772
07896e51-8229-4006-8325-0b62a9d34d3d	xenawinistoerfer@hotmail.com	livia	$2a$10$5WYDJ5NPiUl4lLWYSEYC4uUHZH0brZgHs8w2tvgC91DG8c85i0WJi	\N	CUSTOMER	968526674	MALE	t	t	2023-07-14 12:21:40.13	2024-02-08 15:45:27.776
b37b4f85-c8d2-499b-a940-9042550189f3	doungpei@gmail.com	Doung Pei	\N	$2a$10$CrOHJf6VClTMiEBGQf8VxO0r8Zp0.T/p1RKB8nsiUnVgGR.s7yYBi	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.135	2024-02-08 15:45:27.781
c337313f-df96-4e9d-9543-9c60f1f2af2b	blogapp90@gmail.com	blog app	\N	$2a$10$Gt4agIa7N5OoPvkq7Pfliu6fM6I1tX.TPU9ucNZ/Qxdh2bHN5cEm.	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.139	2024-02-08 15:45:27.786
c3a49556-93c2-4e1c-ba2b-4571ce041d6d	khorn@sbs.com	khorn	$2a$10$s7f0VlMfp6t.hI2N4XOgxua.V.rm.QB.d9g/0jJcLvjMc0QLnJCJe	\N	DRIVER	89441785	MALE	t	t	2023-07-14 12:21:40.143	2024-02-08 15:45:27.791
dc53d4a2-e160-4ae4-9b4c-4da60066bd70	eedyah0203@gmail.com	heidi banglag	\N	$2a$10$bjgVILq4nY9HNQ/ihzK7ou8CR/RQX84ewv0qjB/Kvg9qwVglbGoCS	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.148	2024-02-08 15:45:27.795
e4ba6750-81c3-4ca7-b848-a1b0c3cebd2f	mouodom@sbs.com	Mou Odom	$2a$10$RQcfJ2xw6qxBxVGsLtZWCeOa6edLMMv0LgEsniffJwcSQUGhz3R2m	\N	DRIVER	78882068	MALE	t	t	2023-07-14 12:21:40.152	2024-02-08 15:45:27.8
06a863c0-980d-4ac9-a82f-d36ea1c8b1b9	seilasok@sbs.com	Seila sok	$2a$10$N6EtYc02sUFwJgGwSPwqDuWNkYZelxLqE0Kbn97PGPHTNYMLiTGuq	\N	DRIVER	93300414	MALE	t	t	2023-07-14 12:21:40.157	2024-02-08 15:45:27.804
13b67709-beae-462b-944e-54729bb7f033	visothipong7772@gmail.com	Roth Samnangvisothipong	\N	$2a$10$DlF5XXcbsEWa5IZXEp45XeDm2RhjAICtdLxr93UafylOYPtzIc7He	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.162	2024-02-08 15:45:27.808
09df83dd-3b8d-4b8f-a24c-9530327c6b7c	sothykhieng@gmail.com	sothykh	$2a$10$A5QpIk6hvDDzmZ6RJ1DD1.uexW/Y8FBGxGMEce/RI3Wu0p3Nh/Df.	\N	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.171	2024-02-08 15:45:27.816
01952ae0-7134-43f8-95cc-f707c962d2fe	thontheanlay@gmail.com	theanlay Thon	\N	$2a$10$ESlmDG3LDmVE/21qgKL7reBL21y.wEsQaLv2uefwHX8zszY3Qp05O	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.176	2024-02-08 15:45:27.82
96de76fb-6399-4e44-8ba3-f8c0ba68075c	menglycheng2@gmail.com	Mengly Cheng	\N	$2a$10$LtjJAOo8afZb87b7UMnbGe6BOVrjV76e.RDVqt9NacqupAYf.meiW	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.181	2024-02-08 15:45:27.824
ca1af010-dab5-4085-b5cb-5cdc7a18c35f	udamvisal1901@gmail.com	Visal Udam	\N	$2a$10$IJHRqTOKr4nmfW2pOGZ2COob6LItv/1r8xrxqqj6i2WcMqDlQa5MC	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.185	2024-02-08 15:45:27.828
6c4f49d9-ad71-49b5-8970-24e4bc041db3	samoun@sbs.com	Som Oun	$2a$10$idohLFF6.IP76cKJfvVy2u71ASb9fCOhwsXBc65pmiOtirElsK/M2	\N	DRIVER	77582728	MALE	t	t	2023-07-14 12:21:40.19	2024-02-08 15:45:27.833
7315e69f-5c5a-44bd-b050-91327eb9d195	oudavid97@gmail.com	Ou David	\N	$2a$10$B7msUE/C2pwkhWTUozO7/eALJ8LQstcR81y43r5vN1iYh.kO64ayy	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.199	2024-02-08 15:45:27.841
3a015924-121e-4489-844b-7520d1fd92ad	darodalya@gmail.com	daro dalya	\N	$2a$10$aV9PeJfFdn7YC1CzMKk.c.wbnLZWQPTfj76wecOfc7PUXpoAegAyG	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.203	2024-02-08 15:45:27.845
f249e3c3-a18c-4494-be02-db37e3447986	chebcheb60@gmail.com	Cheb Cheb	\N	$2a$10$PpZNbTB6GDA07vVHxzueLOvoa3weXhqGfxH5/u9YtvNYKjKbqAln.	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.208	2024-02-08 15:45:27.849
789c9ddf-de93-479b-acad-8030afb00298	yukokanekar08@gmail.com	Yuko Kanekar	\N	$2a$10$ruDYOZKQYnEaB3bidmDMp.p3aKr2x3Ud3AtoDIJTex/jn/WbqZl/a	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.212	2024-02-08 15:45:27.853
51fa6060-a331-41c3-aa59-c29ada2e19cf	tuynarin@sbs.com	Tuy Narin	$2a$10$bmL4TlB23zFFmL4RScYUK.sAOCUI2Me7cOP3Pe1oOV5zrf3aovkqu	\N	DRIVER	89490218	MALE	t	t	2023-07-14 12:21:40.216	2024-02-08 15:45:27.857
89fa26c4-2047-46f8-95aa-a655af6b7f17	lychandara.730@gmail.com	Ly Chandara	\N	$2a$10$Uvyn/P5Q3wCR5ILCLFRl4.Y2LCNZBvK0wiTvWKZzPXRG2p0E72JPm	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.22	2024-02-08 15:45:27.861
684ab8e1-6bfc-4c0f-a2ab-134a7393ae8a	sreysalol18@gmail.com	Sak lo	\N	$2a$10$X3EB9FnnwTOqnqhPSMwcg.JBrs572sLeGH12HZAaHtTxFvYQzCJHq	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.225	2024-02-08 15:45:27.866
9ed09ca0-781f-471b-a238-d69552529c99	kannavkat2016@gmail.com	Vannak Tak	\N	$2a$10$Y4NQzHjyXuIttT68YQ3t/e3ynQUxg7Tek8YHDSpZ1BBQH7HWhIBPO	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.23	2024-02-08 15:45:27.871
45ec31fa-6963-42c7-a20d-ba806418be77	sisovattrayi@gmail.com	Sisovattra Yi	\N	$2a$10$bOLkzNbcUXcz2E1Wi0xS1ujXNOmbHTwwwF8.poaAKp9xzp85CY8my	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.234	2024-02-08 15:45:27.876
ce8cf1da-f4bb-4a36-a025-135db6d7d9ea	narin@sbs.com	Sok Narin	$2a$10$cXq2d38sDGtif6M0NPJJu.hewUX7CYluMqq4wFw9aamPa0bNbGs/q	\N	DRIVER	8940218	MALE	t	t	2023-07-14 12:21:40.239	2024-02-08 15:45:27.88
2a0fe2eb-5d21-4640-a1ec-3eab3d7f5691	kao@sbs.com	Touch Kao	$2a$10$C4m0KCBLe2R5JygB109t8.phTX6QksoEzdXa.PKT626jc.LazeX4m	\N	DRIVER	85382899	MALE	t	t	2023-07-14 12:21:40.243	2024-02-08 15:45:27.886
02b81041-6c40-4302-a321-d9942448db22	phann@sbs.com	Sok Phann	$2a$10$l7ueXzYECWLovLCR1iNhd.pytbaP/NhMiwQ2iQk1RHoY0X1H37x7a	\N	DRIVER	86603583	MALE	t	t	2023-07-14 12:21:40.247	2024-02-08 15:45:27.89
7042d43a-5d28-4ec5-b81d-3f833c15da6f	somoun@sbs.com	Heng Somoun	$2a$10$Qo/oGL265/kFI5cUru3DrODDGX9uMQ9kw4hSbM.5eh7MzYB.mppNG	\N	DRIVER	77582728	MALE	t	t	2023-07-14 12:21:40.251	2024-02-08 15:45:27.895
cfa9dc99-58c7-4f1c-89d7-b01e9869b629	kana20@gmail.com	kana12	$2a$10$PXceDl8ZG/ZXytkhLnB1Zu04mfMqWhAMhjdReflzYVW.v7V0VnF6G	\N	CUSTOMER	9736353	MALE	t	t	2023-07-14 12:21:40.256	2024-02-08 15:45:27.899
3b3a905f-8476-4335-b72f-fd2f99d3e98f	jcymclean@gmail.com	Jared McLean	\N	$2a$10$NF3It5tpmfx8UuWMgBJSK.Edl9rp2Qs/FNKiL5a0S8O.y1C/oed3O	CUSTOMER	93852373	MALE	t	t	2023-07-14 12:21:40.26	2024-02-08 15:45:27.904
172124d7-465e-47f9-a73d-3138a2a466b5	sreysa0966404824@gmail.com	siri sa	\N	$2a$10$rVXH3NJ5CY7V1fdmKT2s/uxfeGOuoRwm5ZWguDUBgufJzHAP0eELW	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.265	2024-02-08 15:45:27.908
b3bb5842-d623-4a05-92a3-11c66f213302	senrithney2@gmail.com	Ney Senrith	\N	$2a$10$ppo85WRPg3htwCzXLdmKyu6yGCkcG9Tys7yahsBl8u3DyMHAj2Ql.	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.269	2024-02-08 15:45:27.913
34a94828-a325-4e65-bba3-63b185c4c8ef	neak.cia@gmail.com	Neak Rin	\N	$2a$10$Bu2ucysmetwaCTBDoVmju.G2vcikNKtoJE6erA.lAL8C5NXmgotTe	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.274	2024-02-08 15:45:27.917
40db351d-5f46-4c44-ae7f-b271ead4a986	m.yuri0713@gmail.com	yuri	$2a$10$lpW3u/rgnd3/Qd4NH9JXUecQeM1hoWN5ICJ5vLKf3/Bi5YWso3GlS	\N	CUSTOMER	969727761	MALE	t	t	2023-07-14 12:21:40.283	2024-02-08 15:45:27.927
c3bca25f-cc80-48d1-9d7d-87ef693d1b97	pov@sbs.com	Thy Pov	$2a$10$jNVwMVN7l7NvzjagShJUgOV6FB3rACmmhZO9mZgfMf5MuA/y7sHHS	\N	DRIVER	81729225	MALE	t	t	2023-07-14 12:21:40.288	2024-02-08 15:45:27.931
1adcc413-1648-4750-add5-c2c459ad321d	hakrecorde7096@gmail.com	Ka Ka	\N	$2a$10$w9cKowbPNPzNsB/oI/xbj.g6YkIByEblWRctG5lwVbcPnDjAxaO.O	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.292	2024-02-08 15:45:27.935
13afd05f-c375-450f-8d17-eb721f3f7d51	uch@sbs.com	Prom Uch	$2a$10$EquDwLrEszq0ymaip74sxOeP9zkxHM/KKjeBbL1MGpIcguFX8CqCq	\N	DRIVER	95904768	MALE	t	t	2023-07-14 12:21:40.296	2024-02-08 15:45:27.939
86fa1f1f-86e7-4116-a367-788a5e14b718	laysara71@gmail.com	Lay Sara	\N	$2a$10$GFwAn4Fy/ZpLL9RGlvPHqepSf6SuFPdi4oYMq63PDrvejF.LhDnrW	CUSTOMER	77346663	MALE	t	t	2023-07-14 12:21:40.3	2024-02-08 15:45:27.943
8b8f8aa7-4844-48fb-ade4-e6ccccf55e06	neang@sbs.com	Thy Sokneang	$2a$10$sY.WS4UZoE2tWZ3gO33WZOEHs4byqrkNiS6nlcle/f3ZrfK5gzfI6	\N	DRIVER	17931414	MALE	t	t	2023-07-14 12:21:40.304	2024-02-08 15:45:27.947
f5ca0883-c719-46f2-8f8c-345034061c88	ra@sbs.com	Sok Chanra	$2a$10$JJSUa1p6BYZMsRw5ohpYB.h09ahVO3kZkHUQE2l8Hlt32jL3HQdhC	\N	DRIVER	89505349	MALE	t	t	2023-07-14 12:21:40.309	2024-02-08 15:45:27.951
7fa18a48-cfa8-453d-bc6c-3b0398784936	developers.vandate@gmail.com	Developers Vandate	\N	$2a$10$c6bLJciGakmJbFJ4f2pDbe7YBM4/W1HH4Ga.dACDRnWFBCAi5hY5W	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.313	2024-02-08 15:45:27.954
c3140d9c-210e-44e2-b178-908092f6639d	nethsokreth61@gmail.com	Sokreth Neth	\N	$2a$10$KLaRJQKeht0InMsVTIEtTuiiADDlUNi7daTUdwxFoenXpfZ.ZmZMO	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.318	2024-02-08 15:45:27.958
9f7bdc66-388e-4faa-8eaf-3e2d103c5bff	runjapan.ransugiura@gmail.com	æ‰æµ¦è˜­	\N	$2a$10$4cSPebTN7bfI6TynFgAtxOQRK3pb42OvAGgK9cMcqQ4XadL9A0Uo2	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.323	2024-02-08 15:45:27.962
8684283e-1e2a-4731-b93a-20bfddeb7157	churchill.st@gmail.com	kjones	$2a$10$774Tpv0x63hMfHCqScL94OTxRrk7jcm7N5LMKWrx0.Uo.lP/uqHiW	\N	CUSTOMER	2023848626	MALE	t	t	2023-07-14 12:21:40.328	2024-02-08 15:45:27.967
156f9353-f315-4519-92c0-7d678c349490	calthyliku@gmail.com	UNITED BLINK	\N	$2a$10$gkaLnjmmvJ8UNL7dgFA7z.OjSe.E.MBEXNnMbaOz5b39aRyyT5VuS	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.332	2024-02-08 15:45:27.971
17ada07f-c47f-4d75-9055-609512823973	pisethsem@gmail.com	Sem Piseth	\N	$2a$10$MBGJXtaYfnn1cUSiymC3h.amxyJmakgL.BgwJ1md9y40KXIGbxwFi	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.341	2024-02-08 15:45:27.98
50c0fd37-59d3-4b08-822e-00b896c5760e	verocambodia@gmail.com	veronique	$2a$10$CvYUxkXwO.rhuIIJNuSMPeBz8xqDMnbkCsK8cuK.4hfGHKi1EoFPO	\N	CUSTOMER	12254082	MALE	t	t	2023-07-14 12:21:40.345	2024-02-08 15:45:27.984
2749787f-eaf5-44f9-aec7-d94b8672caa1	cdpbyroncunan@gmail.com	byron cunan	\N	$2a$10$st42ll2DG4mBQvZK1kvsHOwLpmP783/nWLwhf1tJSvkZVgS6hKEyi	CUSTOMER	968529328	MALE	t	t	2023-07-14 12:21:40.355	2024-02-08 15:45:27.992
3bf329d5-35ad-46df-9e6b-eca9705e8226	joaan_foo@ican.edu.kh	Joaan Foo	\N	$2a$10$SFkO9DInm3.1FMA2vb.E7e16zqG7aMsg4wZvj9nroj8w/EpGL2fc6	CUSTOMER	77973502	MALE	t	t	2023-07-14 12:21:40.364	2024-02-08 15:45:28
44e78dd8-8bdf-419f-bc5c-bf55896562d8	chanthy2223@gmail.com	Theng Chanthy	\N	$2a$10$J5dvDqDwCKypkHvsZpkXT.5tl21YB.v9XA2WUhuRFdTYH8eXJrOR.	CUSTOMER	86805226	MALE	t	t	2023-07-14 12:21:40.368	2024-02-08 15:45:28.004
93177a13-5ba8-4d59-8991-8b1c9ee20b72	lin@sbs.com	Lin	$2a$10$zYYlWzmVFO4p2GA7IHPdzOyCOGSB41NXDyC3z57xS/P4xbS1kXYm.	\N	DRIVER	77887112	MALE	t	t	2023-07-14 12:21:40.372	2024-02-08 15:45:28.008
1c2d5854-e03e-4b1a-9c15-233cdbc94096	that@sbs.com	That	$2a$10$EGiNV1WP5cpt3LHaTRKAierYuvA.BzMYRvbawWRDLfbn3nBIIRtpW	\N	DRIVER	78966865	MALE	t	t	2023-07-14 12:21:40.376	2024-02-08 15:45:28.013
f2ab59d6-c4d5-4552-8e44-d1826f4fdb4f	llonamaweena@gmail.com	weena	$2a$10$iFWgUPyTsRC5Kjldje0m.uItDKnqeRxEPvWTpQcXNNQLd7op01.nC	\N	CUSTOMER	968712304	MALE	t	t	2023-07-14 12:21:40.381	2024-02-08 15:45:28.018
4904f6a3-ebf1-44eb-bb8a-6e6cd5b29e3e	nyyanty117@gmail.com	Yanty Ny	$2a$10$6Vr8piBwe.H7FnNVBd7TmOJQP40dX.K.y0ENRo0koaJLgGtRr.1L2	$2a$10$CHt.ICn3ZwYurjePSy/vY.FPtiETMhM0tMdNaS.Q7c7IZh3wE9HJW	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.386	2024-02-08 15:45:28.022
24d612bd-0f70-4f49-b312-f5e5ab46cbec	ped@sbs.com	Ped	$2a$10$AmEOAOHMOMVrFTDseBZD4.YaTi4D.Y49MZXYuZ9o3fch3VFD2WuuW	\N	DRIVER	78966865	MALE	t	t	2023-07-14 12:21:40.39	2024-02-08 15:45:28.027
f9bb0462-fa0b-4863-bb13-441fcdbb97bc	ingvankhinh45@gmail.com	Ing Vankhinh	\N	$2a$10$IwsnQPzIKwFa3VXCTxVnmuIQJnQN.47PuIMTqFYvG304jIU5MSbvK	CUSTOMER	968435508	MALE	t	t	2023-07-14 12:21:40.395	2024-02-08 15:45:28.031
04eab87c-d9c0-48f6-b17a-b7d8b89dbdd0	calnewport18@gmail.com	calnewport	$2a$10$ty1qBUMIT00JExrqhxRh1ef05qUuddHSvB0gSChqTG8hET6sUku8y	\N	CUSTOMER	984452145	MALE	t	t	2023-07-14 12:21:40.399	2024-02-08 15:45:28.035
f42c7c36-8b7f-48fb-bea9-b77ef99dbcd1	calnewport19@gmail.com	calnewport	$2a$10$sOrAWdNKMIFYod8ZCrxr3eYO0WdUUaX8.NVOV76ffOv5mhnWTFWOG	\N	CUSTOMER	194554865	MALE	t	t	2023-07-14 12:21:40.404	2024-02-08 15:45:28.039
18513307-e9cb-45ce-9509-f8662eeb3c59	calnewport20@gmail.com	calnewport	$2a$10$sJQ2u8bucdM.ySNb.tqzsuur.NwVZyb7BojDJ4aCNfI28JYnHmBka	\N	CUSTOMER	187845411	MALE	t	t	2023-07-14 12:21:40.408	2024-02-08 15:45:28.043
c7f0810d-0833-46c4-86e9-46ad795f4483	calnewport22@gmail.com	calnewport	$2a$10$paCsKy8CVgSMFWbCJnns9.X7/PGfEVx7lssjyx8lRILfSYGb1ycXS	\N	CUSTOMER	123545445	MALE	t	t	2023-07-14 12:21:40.412	2024-02-08 15:45:28.047
f064168e-9ca3-41d4-91c6-bfad00ee398f	calnewport23@gmail.com	calnewport	$2a$10$8jtjT65Ol2Ywv7rgjkWTc.uIHxSgh9KRr8H4KTjCDZ7eDo/fN5hWq	\N	CUSTOMER	147588412	MALE	t	t	2023-07-14 12:21:40.416	2024-02-08 15:45:28.051
476dd647-6de9-4d27-b74e-f6e92d31d9fc	sochanntreaou@gmail.com	ou sochanntrea	$2a$10$r6B3XKridNuL/0iIeDQX9um91Dr9HI17C0Bo37YSusJ.j/0Kt/2Cm	\N	CUSTOMER	95209144	MALE	t	t	2023-07-14 12:21:40.421	2024-02-08 15:45:28.056
c33248c8-07b1-4bef-a967-df38ceb2b9b3	sarysodaney@gmail.com	Sodaney Sary	\N	$2a$10$XEdYS8cw5YXBm72JcFEpZeZQdrDg7VMWyrzWQD.mr/Mtq5aKvr1/u	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.425	2024-02-08 15:45:28.06
5feb5172-0471-4ec5-a0ca-bcbbffda14f5	shahrizs10@gmail.com	Rz S	\N	$2a$10$t3hBTC1U.hSUJgFGIf7eauoTpJMRNuWRjKV79pTGNYyTxh0KE/1Oa	CUSTOMER	968169584	MALE	t	t	2023-07-14 12:21:40.43	2024-02-08 15:45:28.064
0d7bf6db-8751-4974-9a48-7a8056ee88e2	ly.chunvira@revorn.co.jp	Chunvira Ly	\N	$2a$10$ceTQykSkg/GksvzcgzW8fOjqrXZXX/eRXmCXD3DYSYUVa30XTFu76	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.435	2024-02-08 15:45:28.069
5dbc5ae6-ffe3-468d-aab8-fdf488d08c17	lysreypov1911@gmail.com	lysreypov	$2a$10$XGU7YSOJScsJwSC7.rUj1OE4E.mt.iHuUp9C5aaan8GtNE6/hBKES	\N	CUSTOMER	969192369	MALE	t	t	2023-07-14 12:21:40.439	2024-02-08 15:45:28.073
77105a3f-6fa8-459a-a70c-ad14a8d82f60	godfeelnopain160@gmail.com	Krisss	\N	$2a$10$80HsuYQDrrQatYW4BTdxC.bz2.iX295zSnkm7PxL63L53KY.stBLe	CUSTOMER	564654654	MALE	t	t	2023-07-14 12:21:40.444	2024-02-08 15:45:28.077
d8efbc39-25af-497e-ad72-bdad95ef46ec	visalrotanak7@gmail.com	Visalrotanak	\N	$2a$10$3TEQDq0zIab1GVY.b2jZFuJJlXDKgkt7lvc5o1vA1/4WamTw.6tzC	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.448	2024-02-08 15:45:28.081
e8ad2327-0e82-4463-8ac6-b69d0f432a2d	startup686868@gmail.com	Viet Nam Lets go	\N	$2a$10$Jaj9b1jkpvsv1g4N5TuZ6.L7bpQtNJ4QHUZksx3XL64Ydi.sV1F.m	CUSTOMER	972491864	MALE	t	t	2023-07-14 12:21:40.452	2024-02-08 15:45:28.085
9cf5fb2d-1bf4-4151-9204-bc3509da165a	longsomalyphoneshop93@gmail.com	Long Somaly	\N	$2a$10$0vyQUkRZZ3YirpuI7.RYtuwdZeM5QK3Vt1EUV.3I9h52m60Udxzva	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.456	2024-02-08 15:45:28.089
92273b61-3e7a-4761-820e-60911be55fdd	longsamann1111@gmail.com	Samann Long	\N	$2a$10$V8922lDP9xn81d5xPgYJauun9TbvKrqX.DZ8yDjn63zqlR3u6NpU6	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.46	2024-02-08 15:45:28.093
6e0dc227-6134-4138-b6fb-ae7d9e4a6f62	seihakrith.t@gmail.com	Seihakrith Tan	\N	$2a$10$QefDKPshpx.CeExNVz49Q.aoNByuMkQWLQI6o0qQtrE8H97wZbXYS	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.465	2024-02-08 15:45:28.097
424b8239-bc5d-4f51-8c47-9563af1218c3	panhavon90@gmail.com	panhavon	$2a$10$zkZgBv4GUNzilnup.79lseMI28z20zoVB2A1lsCLUWSLuCgdHoXze	\N	CUSTOMER	77596292	MALE	t	t	2023-07-14 12:21:40.47	2024-02-08 15:45:28.101
ab16e74c-a1f1-40bb-89bb-8540a4d0be7f	visidhreachoun@gmail.com	kkris	$2a$10$F6isYBS173Vex8fBVT8KfOmqifKBY0EMTV8et4695IBpK63g6e9Gq	\N	CUSTOMER	969264455	MALE	t	t	2023-07-14 12:21:40.479	2024-02-08 15:45:28.109
2886d14f-e343-4981-8150-841ac69435a3	syleeken@gmail.com	lee ken	\N	$2a$10$v1DWwLKzaslyc4A7664zxubhXVfeakDdf0xlK9GuzZMQrT4hmIYRm	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.484	2024-02-08 15:45:28.114
1e0d3d6f-d497-423a-988b-8f5191c2e884	venchanna22@gmail.com	Channa Ven	\N	$2a$10$ixvyb2pbETLJC9hsFR23CeM58yziKtqkvkNk0LvxCLR/CeB7SNZjS	CUSTOMER	5646745674	MALE	t	t	2023-07-14 12:21:40.488	2024-02-08 15:45:28.117
f60adec4-49a7-4180-b97c-bb26c7cff48a	sanbunnykit@gmail.com	Bunny San	\N	$2a$10$ct/VMNq7uh9JthhC6T2F6u4xg0j6GPXyyczEHeohMOUEwvAGFvp7i	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.492	2024-02-08 15:45:28.121
09659221-9841-4353-bc0a-dc6f848438b4	bestchoice.bsacc@gmail.com	Best Choice	\N	$2a$10$lovtn0oLAH9PoFfhsrqSH.4m4N9bRIpeI0fqsWm5vac2zmmen8Fp2	CUSTOMER	10959546	MALE	t	t	2023-07-14 12:21:40.496	2024-02-08 15:45:28.125
814d0a9e-eb03-42c6-99e2-238c86181162	sodavinchheng4679@gmail.com	Sodavin Chheng	\N	$2a$10$GGdA7Py1asm7JV01Q3zdVeOC30O6noGD.oNXrULzZUEq1TdTnoZCO	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.5	2024-02-08 15:45:28.129
82b5a84e-1ed0-4027-8aeb-5345f75a0865	ravisaneja.49@gmail.com	abc	$2a$10$lYADrrJudMrryCe5Y6LERuYsA5Zre5vdHY7F4dqShNjQ.iL1mN1b2	\N	CUSTOMER	967490521	MALE	t	t	2023-07-14 12:21:40.505	2024-02-08 15:45:28.133
4f24d554-f4a8-452b-9fb5-ea67ae7d3937	bbarrett@asianhope.org	facevalue	$2a$10$uiby5Y8DZbAPyqCtC6igM.fWgcZ6KTcGXZN70xDpZla1M62xdik0S	\N	CUSTOMER	89863739	MALE	t	t	2023-07-14 12:21:40.509	2024-02-08 15:45:28.137
46009ff8-f58f-4269-8dfa-0ad4e65b368e	samvisith.ios@gmail.com	VISITH SAM	\N	$2a$10$0JMvozPD38eNdcLOoHMNO.YolEnSTsDCXxDHA/VtCz1SHF/XcXPAu	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.514	2024-02-08 15:45:28.141
09e93eaa-30ea-4806-8a4f-68fc4a869d32	rintneak@gmail.com	neak	$2a$10$icYawG6PgeyfQhOjp4hJfu6zmQmwwoMdeKhPl91lntdf/8RFEl65m	\N	CUSTOMER	93857857	MALE	t	t	2023-07-14 12:21:40.519	2024-02-08 15:45:28.145
55f63bf3-6078-4b7a-bc77-bdee98487557	superAdmin@kit.edu.kh	Super Admin	$2b$10$O8fmuCNTWDwsMHvS2FANde4JAc1cTvVsVOIA3svJYE17QUac3BiMG	\N	SUPERADMIN	\N	MALE	t	t	2024-01-08 11:39:47.97	2024-02-08 15:45:28.15
6fe89cd6-a5a5-41bf-9c21-c39982ed3922	demo@kit.edu.kh	User Demo	$2b$10$wD5rsWV2IZbeM3v4h11k6.lhonLLKWXadoe0JkinDJnQ6jM5uNjZe	\N	STUDENT	\N	FEMALE	t	t	2024-02-06 08:06:22.424	\N
f5871ea9-a45b-407e-ba26-d6f69e24f642	air5th-mj@hanmail.net	ê¹€ë¯¼ì£¼	\N	$2a$10$IeM4vk2O5q97QdZ4WqukmuBnI8e1hV0hc8AY7hyrF63pzNjL45kg2	CUSTOMER	967083592	MALE	t	t	2023-07-14 12:21:40.528	2024-02-08 15:45:28.159
53697604-fee6-417a-b9e4-34bcfe7bc7d8	delete * from user;	wawawawa	$2a$10$TkHOOkubXRcs95SNOkXvXeodaOzFYBjtYibBdHIArnd8eWzG4HlMG	\N	CUSTOMER	123456789	MALE	t	t	2023-07-14 12:21:40.532	2024-02-08 15:45:28.163
bf355690-fd6e-4b6e-8ef2-e293da482e06	ryujisoccer0327@gmail.com	Ryuji Kokubu	\N	$2a$10$ZxGcfsinkvY6L6cNy7.vh.IJKkPYI/jcap0BkbKqWlwCLcPW5lJ0q	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.537	2024-02-08 15:45:28.167
2e5c2ab1-7e1d-402b-a801-a496defe19f5	mercy.gash0826@gmail.com	yam saberon	\N	$2a$10$TOU/jYEqV23SKjOe64GOmejzCydC0v5JkDk7PRqw7fy7HlBtzYm3G	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.541	2024-02-08 15:45:28.171
a90be607-9ea3-4f1d-8a5d-334b8618d372	cmagayta@yahoo.com	tinamari	$2a$10$N1nTaJXkXgYGJ6KPq9Cc2.YL4vuW6KU0vgGnP4RHDzZTExFJo/qNO	\N	CUSTOMER	93777232	MALE	t	t	2023-07-14 12:21:40.545	2024-02-08 15:45:28.177
48050c6b-5df4-49f9-aa5b-a7176ade46df	david.hav@gmail.com	dhav	$2a$10$TdA5f9JFT0oaJL33CxRRy.j6LBME1mKxCTyBsGM8lCc0aWDeBUGRe	\N	CUSTOMER	99699174	MALE	t	t	2023-07-14 12:21:40.554	2024-02-08 15:45:28.185
b2586066-acdc-452e-9f19-b851efd9a4f7	joyce.advertonly@gmail.com	nwkjouyce	$2a$10$IK9nbqYl/a55EZK6z8eiHuU8dmCmwdiQnb0wvLr7fQEYQWl/O9BSu	\N	CUSTOMER	87516561	MALE	t	t	2023-07-14 12:21:40.559	2024-02-08 15:45:28.189
28c68b63-8a38-477c-a39b-ee7799588fa4	myemail	myusername	$2a$10$.DZZoXaZujdVQXiIWVqNzeSaAEf6i72SZOcfX9sHiN22Fxzrrm/sW	\N	CUSTOMER	12345678	MALE	t	t	2023-07-14 12:21:40.563	2024-02-08 15:45:28.194
9bffcbd8-d305-4b0b-a9ea-700fb1bfc926	seigner.christian@gmail.com	cseig	$2a$10$f53WZa0njxv7n0rMKqcW/OChgvUJeCGl5GU5sAQjjpWwhyua.f8cu	\N	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.568	2024-02-08 15:45:28.198
87c79c83-3321-47b9-ae21-1bfaf63b32d4	yarany669@gmail.com	yanty	$2a$10$Us1Y2.zVMnCpCujl1lPk.uhcoW.JvkezAaNLMqVLUQJPm20tPrulO	\N	CUSTOMER	17651767	MALE	t	t	2023-07-14 12:21:40.573	2024-02-08 15:45:28.202
8600daed-36ab-48ca-8519-0cdada9ba497	cheaveychhorn@gmail.com	kettesak	$2a$10$lRrTwyvVV.rmdoSxlbQcUuElLKi.UuTgL4LwPWZBQXX76xQAfozA6	\N	CUSTOMER	15823298	MALE	t	t	2023-07-14 12:21:40.577	2024-02-08 15:45:28.207
ddfe9f1a-7aee-494e-ba78-dd048bccdfef	sos.sokleng@gmail.com	sossokleng	$2a$10$rmFCRfcieMz6bbxa3f1op.H8E.hlnhU7h/zCWjX6rX/qfABtqG.vK	\N	CUSTOMER	81322200	MALE	t	t	2023-07-14 12:21:40.581	2024-02-08 15:45:28.211
33a03037-c391-4fef-89fc-a8b5bf660e9c	wakaba20010304@gmail.com	wakaba	$2a$10$D/J1sR4RZV.q7.j4G5ydruItp9qe9JGaTG.lphh4UwT8cxWcQS1pa	\N	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.586	2024-02-08 15:45:28.215
dc0a9424-4569-4565-84eb-f9c113d7691e	sambathsothlimalove@gmail.com	sambath	$2a$10$K.v9j9xDg3Ig/qIeBrA2WuYs6JbBCeZOutVhQBC33sSxmxXn7SnV.	\N	CUSTOMER	10470824	MALE	t	t	2023-07-14 12:21:40.59	2024-02-08 15:45:28.219
714ce6ac-c1e4-4a8b-a26c-12627ba485c4	vghour@gmail.com	user	$2a$10$No4cmcvKHpEJ5fjG8Xm0HegxkFP4d27TVYzRK4sVwbzc2j7ytTzvK	\N	CUSTOMER	967521392	MALE	t	t	2023-07-14 12:21:40.595	2024-02-08 15:45:28.223
ad27d1d9-ad36-47e7-a549-f526ee58d73f	swethaa1492001@gmail.com	swethaa	$2a$10$FKiKD.LR8fb1usNkbaR5yOB60r7SUPzAL1LOQWLpUwwwpe9eGzG4m	\N	CUSTOMER	6381530542	MALE	t	t	2023-07-14 12:21:40.599	2024-02-08 15:45:28.227
f742f1a4-1ff5-4e87-a88a-2a191c4bae94	sereyvann24@gmail.com	sereyvann	$2a$10$dEuRir0vUuCx9zJYpOvXNemfqvI8MKOSQVn25FDSqftK2qUHlwmV2	\N	CUSTOMER	16622327	MALE	t	t	2023-07-14 12:21:40.603	2024-02-08 15:45:28.231
214a3df7-f077-44af-a23c-a10264644459	kimporneav27@gmail.com	kimporneav	$2a$10$/lwkCBw3A6RXCa4NoRL4t.GqcrPfG7WrHMVsWhUJvOXYN2sJDPfLq	\N	CUSTOMER	77354857	MALE	t	t	2023-07-14 12:21:40.607	2024-02-08 15:45:28.235
419d4339-3e9c-4dec-bc4c-5f82a220d894	hak.vichet22@gmail.com	hakvichet	$2a$10$zTmur4l1C6/Q0/xNg8cyvO6F2DBwGHlzhOFSIMAV4C.kSUkNHK6Oi	\N	CUSTOMER	95863190	MALE	t	t	2023-07-14 12:21:40.611	2024-02-08 15:45:28.239
0d0b998a-fa54-4ede-8658-332a845cadaf	cheachanraksmey19@gmail.com	ass	$2a$10$bDzcb/DaZMp8RhJymMTkXOHadPFoBHe1F3E5lh2l3.SWaeTV49O5u	\N	CUSTOMER	99309500	MALE	t	t	2023-07-14 12:21:40.616	2024-02-08 15:45:28.243
a06cc791-0834-4659-9428-97b17a1efe4a	ros22@gg.com	ros	$2a$10$IzuI7.ijLaRoe4ZB5b2Sq.rauejf.GJRTXTPlei9c6WB73IhA6kq2	\N	CUSTOMER	3223009302	MALE	t	t	2023-07-14 12:21:40.62	2024-02-08 15:45:28.247
1b93ba4d-e853-43cb-8960-6540ca2eea1f	kvetranoeurb171819@gmail.com	kve	$2a$10$QJ8ghRO8qnIJgOTv5tPZDeIUo1chD/UApbYrb1oGsmJMCF0Hxt.0u	\N	CUSTOMER	977466128	MALE	t	t	2023-07-14 12:21:40.63	2024-02-08 15:45:28.256
7e983cb3-ecfe-4334-bae5-9343a4c6ef75	hak.vichet23@gmail.com	hakvichet	$2a$10$DFJ1t4rSgukS/hTj2OJCxeTJ3rnHkwdYQxIJh2dAQyDyo6rqMIayi	\N	CUSTOMER	95863190	MALE	t	t	2023-07-14 12:21:40.634	2024-02-08 15:45:28.26
5b49c6af-2dc8-4e87-bbf0-7f41612fe06d	promsuthirak18@kit.edu.kh	Suthirak Prom	$2a$10$epYNTTfj/N1tavGXfSFVduAQgRrAwhf2aY50b6ZuACZBxdSxCAlSK	\N	STUDENT	98988213	MALE	t	f	2023-07-14 12:21:41.441	2024-02-08 15:45:28.264
b4446414-c82d-4ae6-84a5-8b1c3423c0d4	sengrathanak17@kit.edu.kh	Rathanak Seng	$2a$10$wBM61qEfmyD4dFUTqc8i8OD6iDrCeGUiTPxspQJyZTAYcDNwyKkia	\N	STUDENT	86574637	MALE	t	f	2023-07-14 12:21:42.167	2024-02-08 15:45:28.268
c689fb09-d65f-4033-a4d2-36576db5d1e2	dytithpanha21@kit.edu.kh	Panha Dytith	$2a$10$9cH.4SgR424IPgEV82pCQu8fbqeclAxS/QU2R3NS56WRGctOOS9GC	\N	STUDENT	11456768	MALE	t	f	2023-07-14 12:21:40.773	2024-02-08 15:45:28.271
eca5d8be-55b6-4090-90d6-22729dc92ba3	sophonndavy20@kit.edu.kh	Sophonn Davy	$2a$10$Bm/swqX.DsnD0/8uCgZPu.2.8IyQpBwZ9M6FS7EoWVlQdDhjVeQVi	\N	STUDENT	11111111	MALE	f	f	2023-07-14 12:21:40.686	2024-02-08 15:45:28.275
d9333f27-d6ee-4e4e-81a3-29dffe6b266e	ousochanntrea18@kit.edu.kh	Sochanntrea Ou	$2a$10$DpAuskSsqHaG71Azm4z4v.Jp2NlDwu5fuwNSFJoOyJw3PVPuIJsku	\N	STUDENT	95209144	MALE	t	f	2023-07-14 12:21:42.109	2024-02-08 15:45:28.279
4e8606d4-9294-422c-9119-a8e90758c3e4	sopheakvethya.syna22@kit.edu.kh	Syna SopheakVethya	$2a$10$Aq/eBQiDwEgQocEejTklZ.mafYTNHUghrY/MXpt.7cjNslN8newYW	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:43.74	2024-02-08 15:45:28.283
aea2fe4d-d38b-4081-a1e4-e8709698c32d	moulhengborann15@kit.edu.kh	Hengborann Moul	$2a$10$oe3oxWZjfa.rhbS1rE63YO0eUk52jKfKMHwImT7VQtfvK07OrTR7m	\N	STUDENT	706878307	MALE	t	f	2023-07-14 12:21:42.377	2024-02-08 15:45:28.288
2b3762a6-2fc8-4a5c-a759-56a50a4219d8	chhunporchou18@kit.edu.kh	Porchou Chhun	$2a$10$2EQc4m1qm9swTYOBmj67kO3D7tFrYA1hLCOe0i.QUccEfO6XTRdne	\N	STUDENT	977100730	MALE	t	f	2023-07-14 12:21:41.425	2024-02-08 15:45:28.292
6c9db7d1-f3f4-440f-91fa-504dd0254f52	nhimsovanmeta20@kit.edu.kh	Nhim Sovanmeta	$2a$10$eqgjjVzICpvD.a2yHh4yn.3YnxsHp0md1HKeNDeQbWWTaXWfU6WKK	\N	STUDENT	11111111	MALE	f	f	2023-07-14 12:21:40.662	2024-02-08 15:45:28.3
ab00abf8-c4db-4814-bbb4-5b60607626c1	kruychandara17@kit.edu.kh	Chandara Kruy	$2a$10$UG7BrRz6I3e5db4JuAD.B.Kh0HoaOCqbVzK0SuZddZXB4R3Hr2Ypa	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.383	2024-02-08 15:45:28.305
42581b4e-9a24-4cd1-a275-3464b8ff68b4	seng.ariya19@kit.edu.kh	Ariya Seng	$2b$10$hRKjNPoyHBhiar8j2dkMfuGEMjQAg1ggBlD9vWtRlaZHAmKM7qd6i	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.027	2024-02-08 15:45:28.309
c205cd74-8a39-47c2-8c9c-4373b080e0f8	huysophanna14@kit.edu.kh	Sophanna-KIT Huy	$2a$10$ScBGKNuHCTlNjWG23sD2Te9MqWxpW0q.uWzNbu1Pq8.PIlch7ycYm	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.933	2024-02-08 15:45:28.313
bf98ffe0-8105-4c64-ad92-4e8738630622	hengsokvisal14@kit.edu.kh	Sokvisal Heng	$2a$10$eoYx37IWskcglnayNTVH9eqCfwQ71A/maDoncRehml7tH7dp4WpDq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.938	2024-02-08 15:45:28.317
$2b$10$O8fmuCNTWDwsMHvS2FANde4JAc1cTvVsVOIA3svJYE17QUac3BiMt	superadmin@kit.edu.kh	Super Admin	$2b$10$ggIjSkZeKeam50Ki4sXEnOIwd9wwfOkIUAnKodKZqbgyEivTSIF3m	\N	SUPERADMIN	\N	MALE	t	t	2024-01-08 11:41:19.912	2024-02-06 08:12:21.626
6e69126c-78a3-4270-a940-e89c30d3733d	lydaneth18@kit.edu.kh	Daneth Ly	$2b$10$yQyxC13uuvBqrgPKB5/IcuqpEuFY.cFVkUBCgoZYEAiMAdpNoFzDu	\N	STAFF	\N	FEMALE	t	t	2023-07-14 12:21:41.282	2023-08-11 08:53:53.443
c4fd0791-d8c6-4554-8b6f-167181754d1b	chhysokuntevy18@kit.edu.kh	Sokuntevy Chhy	$2a$10$gQFGXheDZ27OUU/3rXuRCe3m3dPgH8vxohV0l2y3NoQBvIDOt8UKW	\N	STUDENT	61543925	MALE	t	f	2023-07-14 12:21:41.3	2024-02-08 15:45:28.325
c5738791-8d08-4b2b-b67e-982e4c98d9ea	yurikogoto18@kit.edu.kh	Yuriko Goto	$2a$10$H5WpYjZd/bQHAamD5qhrL.KgPIRO.of1HEvkdQEK9jOkZl7rBIHha	\N	STUDENT	98333825	MALE	t	f	2023-07-14 12:21:41.348	2024-02-08 15:45:28.329
bfd3ccf2-5912-4ea9-9c66-8eb30c6cfddb	marina.fujimoto19@kit.edu.kh	Marina Fujimoto	$2a$10$OLhc7Oh/.XOJULSbRmGLeuTSHPSNA.Sx/PjqMrTuTZiKy.NiceFdW	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.713	2024-02-08 15:45:28.334
c13a5f25-4437-4b8d-9b89-12abbd2dee7a	kenta.itakura19@kit.edu.kh	Kenta Itakura	$2a$10$xyQQ0jRtKi/3aEZsuJhrqu4qM95v2cp7VSX6V4CWa2MsfpYkYxwda	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.754	2024-02-08 15:45:28.338
d846c4c0-68c3-4045-9c4d-ff8eace3fa34	pohvichetrotha20@kit.edu.kh	Poh Vichet Rotha	$2b$10$Nnv5VncQZ3kFa0yWyoNgSuIvZP5cJ91KVEdOXIiV1YAZTw.P2ZgpS	\N	STUDENT	889561807	MALE	f	f	2023-07-14 12:21:41.212	2024-02-08 15:45:28.342
3311f813-d9ee-4d42-a981-a55089ded559	tepputhearin21@kit.edu.kh	Puthearin Tep	$2a$10$O58UYWdp.k0SBNNmo./kZ.Lbkh9xApvJ7kinQLdZDzgNev75qdA6K	\N	STUDENT	16784566	MALE	f	f	2023-07-14 12:21:40.726	2024-02-08 15:45:28.347
7e195416-d966-4255-ba5b-cfbd338ccbf5	yunsomphors20@kit.edu.kh	Yun Somphors	$2a$10$32sxtSeNkvJbKrD06RwSrOw/RGKtXHFl6OiwyvzDXS3.uZILQS77S	\N	STUDENT	12345678	MALE	t	f	2023-07-14 12:21:40.642	2024-02-08 15:45:28.351
af2f2aeb-988b-40c6-a9e2-7a3cb1fafb09	ryutoizuka20@kit.edu.kh	Ryuto Izuka	$2a$10$ai6zmp4/UYPp8okqXNDDGuhr6V1Yv7H6wfPrgKsVr7JDp5Exjg36W	\N	STUDENT	86578661	MALE	t	f	2023-07-14 12:21:40.732	2024-02-08 15:45:28.355
074bc14f-dc06-4286-9b6a-41c5f37f77d2	shamiso.p.nyajeka@kit.edu.kh	Dr Shamiso	$2a$10$PRggWVRjnQwyZywI3Dja.OC3zLVa5tqhbznaLOmAprxjF3LMVdGo.	\N	STAFF	967754792	MALE	t	t	2023-07-14 12:21:41.113	2024-02-08 15:45:28.359
be1b9bbc-b791-4b23-8df2-6ec9c6fd9e5e	hinayowatanabe20@kit.edu.kh	Hinayo Watanabe	$2a$10$.BnjODJzr9jQZrycpSOg3OvcyQmA6q3fUkusgfg/H6c/qMgp0vns2	\N	STUDENT	11111111	MALE	f	f	2023-07-14 12:21:40.832	2024-02-08 15:45:28.364
adc6f36f-20b0-4177-8001-6a2a6d07fbdb	khutsokunpidor14@kit.edu.kh	Sokun Pidor Khut	$2a$10$4AXYChDCr.nGx2ObR9nNiOnCofOB2bxdAwhRqV12GFH/eHMu5n4qe	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.523	2024-02-08 15:45:28.368
adb03bff-4f9b-47ae-9654-106891133a52	yeak.yeanmao19@kit.edu.kh	Yeanmao Yeak	$2a$10$BPhCT9r7DHa/9QdLxsdn.eCaVlJHhSWTXbiDXZs4JUs8ZodGGWkva	\N	STUDENT	92262966	MALE	t	f	2023-07-14 12:21:43.049	2024-02-08 15:45:28.372
b5f69f00-641e-4317-bf69-66af15f1bb58	ivlayhort18@kit.edu.kh	Layhort Iv	$2a$10$tCr7UaxHuO/4H0R6Tzc0WO2Px11CxDgd.VVBl/XFiJghZXivrOfUi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.336	2024-02-08 15:45:28.376
40838f37-da01-4279-9cfa-e7c1752a5735	vornkiriratanak17@kit.edu.kh	Kiriratanak Vorn	$2a$10$SRci8vztvueoQz1kS5gmc.9EssJqLagR3XGwW/Xm.XW5o6QjjjIKy	\N	STUDENT	15982533	MALE	t	f	2023-07-14 12:21:41.728	2024-02-08 15:45:28.385
e2ff6211-22b0-459e-8976-612c89675db6	chheng.pisey19@kit.edu.kh	pisey chheng	$2b$10$paQTTgx23OZ59hrQBV4MUOcdGXHPUfzgO3ikh167fTkbrAT9owcy2	\N	STUDENT	70290285	MALE	t	f	2023-07-14 12:21:40.785	2024-02-08 15:45:28.389
1e31af0a-a481-4a32-a3f1-3a47a88abfae	chea.rika19@kit.edu.kh	Chea Rika	$2a$10$5WF4xhl2n02bQEp6w3pC7.L1VSH8OYjzObGdZlE9YKD5IN7wSmSei	\N	STUDENT		MALE	t	f	2023-07-14 12:21:40.975	2024-02-08 15:45:28.393
834b557d-c530-492d-9357-f827b547bb8f	sanvensuor20@kit.edu.kh	San Vensuor	$2b$10$Rgp27yIyBCx7Igyct.Mu/uhpJY5F77ls6ZKVD8atTAkglqYDxVBZG	\N	STUDENT	11111111	MALE	f	f	2023-07-14 12:21:40.923	2024-02-08 15:45:28.396
65733ada-1dc1-451f-ac4d-a2c9d17e095c	heangmarady20@kit.edu.kh	Heang Marady	$2a$10$./Cw26DSIzU7iN/.kVNJEOD8YkyySCREeeaxLVN134cCFcXrITuYi	\N	STUDENT	11111111	MALE	f	f	2023-07-14 12:21:40.755	2024-02-08 15:45:28.401
7dab4f12-7e30-4952-82f1-9093d48c19b4	longchheang20@kit.edu.kh	Long Chheang	$2a$10$s7gKMJfkzJiDtBrClLZ/rOrjLxG2O8DnbUsJ4HA3eZ0wKl6Rqm3gS	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:41.078	2024-02-08 15:45:28.405
c03d4ede-569e-41c6-aafd-0b93ab9d9080	thonlynan17@kit.edu.kh	Lynan Thon	$2a$10$Hnhz7NHpJ.qfB2BNmIcC2uOyPSzp4tSV6ciq7eOpKj9y/PoAEQF4G	\N	STUDENT	965886466	MALE	t	f	2023-07-14 12:21:42.316	2024-02-08 15:45:28.409
2cf3a4df-3b54-445e-8532-4e4dfcc38f48	neavkimpor20@kit.edu.kh	Neav Kimpor	$2a$10$TJntx.ZAVyRAUrJblUNokudOnPcBEO7U1ufW6Waa3DKbZ15zcitxm	\N	STUDENT	77354857	MALE	f	f	2023-07-14 12:21:40.945	2024-02-08 15:45:28.412
40123385-1a35-46d0-aeca-e8e3a943622a	rossereyvann20@kit.edu.kh	Ros Sereyvann	$2a$10$EELocDJ2G2fjS0nVN4rt2uyNrd5WvHPAqpF936zL3.3fEYum6Okui	\N	STUDENT	16622327	MALE	t	f	2023-07-14 12:21:41.071	2024-02-08 15:45:28.416
e3cc7486-6412-403f-8501-109b516eb9dc	dara20@kit.edu.kh	dara	$2a$10$ikPj8kn/mmUyG2yHfwL3GOcsAHzC.fGOlby9Am.vrm8p/KFSJ8dxa	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.58	2024-02-08 15:45:28.42
4fff5fc1-fbf2-43bb-8b9c-4ef06574929a	kvet.ranoeurb19@kit.edu.kh	Ranoeurb Kvet	$2b$10$20eWx2/tE2sI.9bAmG7wpeJ3EPFQjQmN5QyJEb0sjlsQsjdhAX8iq	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.177	2024-02-08 15:45:28.424
5f34c195-9245-4fa0-a7ac-c6e63ed8567e	vongseiha20@kit.edu.kh	Vong Seiha	$2b$10$MOWMPOc5zoEXUdlbXDOXL.1YsN.1C6MwVwhXdP2zxgWis/GOtsY7W	\N	STUDENT	12345678	MALE	f	f	2023-07-14 12:21:40.952	2024-02-08 15:45:28.428
89446203-abde-4ccc-875a-0128b0240721	vong.ing19@kit.edu.kh	Vong Siev Ing	$2b$10$osXVM2q0VoLtkQ1cBbki7.zDMcG8LAF2aLe//a8GPyvqKfA9iOeNC	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.125	2024-02-08 15:45:28.432
b1dfc76d-360a-4419-9170-400bf674cdca	sarin.vuthipanha19@kit.edu.kh	Vuthipanha Sarin	$2a$10$A7wp4jdjxIZBtvrcJdkNrukc5UFGHy1miFoNC0TO4rfuvjWpRNfxm	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.038	2024-02-08 15:45:28.436
73c2f029-7376-4370-b5d4-2004722f7fd5	srey.reaksmey19@kit.edu.kh	Srey Chan Reaksmey	$2a$10$SdE5VSz0ZgOtx9ucoKq.5ePrbFsONTBNO0tyPJpYWEGO.Tjod/7d6	\N	STUDENT		MALE	f	f	2023-07-14 12:21:40.969	2024-02-08 15:45:28.441
4f622744-6a75-4a90-ac25-59bf4d943f0a	sin.daly19@kit.edu.kh	Daly Sin	$2b$10$4HSYy8jBaDMnIx2zsU9Hzu7yWb3onCtqKkFKul/VQn1V6fGG1ineK	\N	STUDENT	78596093	MALE	t	f	2023-07-14 12:21:41.003	2024-02-08 15:45:28.451
49de437c-2231-412c-a285-73d09b71522f	deth.sereyleak19@kit.edu.kh	Sereyleak Deth	$2b$10$POyFgqPpZGJLdViUZF5WLOO34WDV1u8tfKiplB2nMFTzfuS2eOkEG	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.015	2024-02-08 15:45:28.456
6fa6c6ea-f689-401e-8a9e-69ce059f6d93	asukakaho18@kit.edu.kh	Asuka Kaho	$2a$10$5qyg3//AA.D2cCLb56LtIuvJ1Y9qiNDpKymq4OD86kYd2GnFikmce	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.353	2024-02-08 15:45:28.461
69e5cdf6-c093-4f1f-aa18-ccb8a95de933	chhoysokunthaneth16@kit.edu.kh	Sokunthaneth Chhoy	$2a$10$2EjC0T993FzF/kmpgppu1OWKbEl50oOTN3G4hzs9swWDww3TN1BpK	\N	STUDENT	12509856	MALE	t	f	2023-07-14 12:21:41.37	2024-02-08 15:45:28.466
58e6e3a2-797a-4562-b157-47b218b11cbc	rithkimsour20@kit.edu.kh	Rith Kimsour	$2a$10$eHPFDcKP8HkSlNXQM1ZjxeZzuiy80MM3eCUaIuMddPSx7EgiqLHhW	\N	STUDENT	1111111	MALE	f	f	2023-07-14 12:21:41.206	2024-02-08 15:45:28.472
5c9e6d39-338c-4cc1-814f-db5e36e7294f	ouksarapich21@kit.edu.kh	Sarapich Ouk	$2b$10$lXnkgkpsIGjgCp37GpAmJe3sao.w274rcACvnEv0XoiRFs4kjqr.y	\N	STUDENT	12345678	MALE	t	f	2023-07-14 12:21:41.109	2024-02-08 15:45:28.477
680abf23-6e09-4ee0-8f10-5811d5c0ae8a	phalla.boramey19@kit.edu.kh	Boramey Phalla	$2a$10$TtbiDA.iAlG1yZqSoXME0.ce2Lg3KkUVt6el07Eq/QN7AL2lXXYsW	\N	STUDENT		MALE	f	f	2023-07-14 12:21:40.986	2024-02-08 15:45:28.49
6cbbddaa-a205-493b-9d59-13a546614270	suy.chakriya19@kit.edu.kh	Chakriya Suy	$2b$10$QFzkRBqD41Kjeck3hrh8NufIXkPPsG7PnlfRijCLCwfdS8U4/gE56	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.032	2024-02-08 15:45:28.494
7024b8db-d952-45d8-8ad9-fdf947dabcab	livsovannarith18@kit.edu.kh	Sovannarith Liv	$2a$10$E4BHVlqjV6OCCQP0RebpS.i7P43UkjRMwPBtxYZUbUlZoOH2AvpOC	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.259	2024-02-08 15:45:28.498
717016e7-86c1-4b9d-9d8a-abbb603a7eb9	laysongheng18@kit.edu.kh	Songheng Lay	$2a$10$Ro1Q9F5Jz991C7HNtvWL8.OwNPDiX/QU12YlGpTrXB53/cBLmmy8S	\N	STUDENT	10406690	MALE	t	f	2023-07-14 12:21:41.324	2024-02-08 15:45:28.503
8aabd880-8712-4cf6-98d5-d80d8dff9065	ryota.tateishi@kit.edu.kh	Ryota Tateishi	$2a$10$E9kwp5EKD6qDAZVTLFfYteaqbJsW9FrgAfR7nRuy5f1jSk72UFOh6	\N	STAFF	93659976	MALE	t	t	2023-07-14 12:21:41.664	2024-02-08 15:45:28.507
7f8cf876-27f4-4744-837b-6adda82ee68d	voeurn.vuthy19@kit.edu.kh	Vuthy Voeurn	$2a$10$xBvxDq9NfjV11pk1pBYRVuCJ.4gANMm0NCwnFN4KGTPqUh5iUlfra	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.043	2024-02-08 15:45:28.511
74f4cc4c-5992-4518-ac80-41dff96c2249	orn.siveng19@kit.edu.kh	Siv Eng Orn	$2b$10$sTu01UBszT1/1iERXUXQtuJfG8VF711/5Gw6/IolTkeyhDynoC1cG	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.143	2024-02-08 15:45:28.515
83b5bf52-c2b9-48fc-b4b8-49dcf393e125	nuolmakara16@kit.edu.kh	Makara Nuol	$2a$10$X9.4HRZhmYALcRfqhDigyu84rc91tUoQIQvflB6Zbs1.a2NC60FDa	\N	STUDENT	69228298	MALE	t	f	2023-07-14 12:21:41.435	2024-02-08 15:45:28.519
86017b6f-c0a6-4601-bfa9-4c206c19e7ac	nhimsovichea18@kit.edu.kh	Sovichea Nhim	$2a$10$5Il1cqQZt1anAYp2X2JDUeDN6Bho9j3Nb/KwUeQWSPkOsA/DTnkQi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.452	2024-02-08 15:45:28.523
7f940df3-91cb-49db-9587-5b577393afc2	somvisal16@kit.edu.kh	SOM Visal	$2a$10$ZDvg7QFq8mZeFGq2BU/JUuR7l0D8r.0CWIOhek8x7pOcEqcHF5CO6	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.555	2024-02-08 15:45:28.527
7d10b369-1729-4dcf-81ac-70cd5ae54b8e	oumengheang18@kit.edu.kh	Mengheang Ou	$2a$10$oKcYNZq8oW5m1j90KnuzIui5LLnmUBhwz8O8s/vC9kQVeb11hRFbu	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.566	2024-02-08 15:45:28.531
7a0e934c-fc3d-41eb-873d-082f881ce623	munylita18@kit.edu.kh	Lita Muny	$2b$10$r/Qgt5p4nX6SBaSsjBoR2.g8exE9TU6nsZwRPQERyIxRZuYMRF0Qu	\N	STUDENT	70228895	MALE	t	f	2023-07-14 12:21:41.631	2024-02-08 15:45:28.534
7716d634-5aaa-48b7-944e-871e336cdd11	kimtheara18@kit.edu.kh	Theara Kim	$2a$10$NnubF9q8ifOmjCGLyAoLGe8MHSP1lAkMaWsc/59sTc5pqFjQqrs2u	\N	STUDENT	89485885	MALE	t	f	2023-07-14 12:21:41.653	2024-02-08 15:45:28.538
c2be90e2-bea4-41b4-8088-63cef889750c	makoto.arami@kit.edu.kh	Makoto Arami	$2a$10$p3T7FlCjPYg61IjgDTuKgO2p57Z4pcwT7uFOZWiPbW/s8bsR98lN.	\N	STAFF		MALE	t	t	2023-07-14 12:21:41.739	2024-02-08 15:45:28.541
85c25414-acc0-43be-95a4-76ea0477eb11	toru.ashida@kit.edu.kh	Toru Ashida	$2a$10$D3G2TmbjMayhKQAA0O0ZF.mzYudrA9gxkD.KX5PHcue0OILhcpqla	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.016	2024-02-08 15:45:28.545
56b821da-d1a0-4cdc-a9eb-8c979861e504	shiraz.khurana@kit.edu.kh	Shiraz Khurana	$2a$10$XRi5JRd9dOS9jCDkJzPW0unPp5jeAfR21fZxD9JjMMPHyQL05sDOO	\N	STAFF		MALE	t	t	2023-07-14 12:21:41.784	2024-02-08 15:45:28.549
96df90ce-813d-4d1d-ad21-c110218a161d	suong.phengan19@kit.edu.kh	PhengAn Suong	$2a$10$1Yt1SO2.ZflAhVlX5q2JQ.FUd.rpAdpQY/nh4Ar/CgrJlwRkKsY0i	\N	STUDENT	77457547	MALE	f	f	2023-07-14 12:21:40.802	2024-02-08 15:45:28.553
98bd82d9-e5bb-4765-abf6-4aec9962bd06	chaukoldaravuth21@kit.edu.kh	Koldaravuth Chau	$2b$10$5amO2aFEEZSsE7USf7I7h.0FoxK1jVk1KN7J3ISwC1xD2d9jqPOrS	\N	STUDENT	10652362	MALE	t	f	2023-07-14 12:21:40.827	2024-02-08 15:45:28.557
88bfc3e3-b7bf-460f-9e95-160bc46b984c	seab.navin19@kit.edu.kh	Navin Seab	$2b$10$.OdgNoPh2cdOWvnO.nsFDO0WwQcsykphEnHct0ewa3vh8wqj6ylfO	\N	STUDENT		MALE	f	f	2023-07-14 12:21:40.838	2024-02-08 15:45:28.561
8d80f5a8-193c-40e1-ba3d-ec74c4420810	yin.chantha19@kit.edu.kh	Chantha Yin	$2a$10$3N.shBkQ.XgSogLoQPrXY.wTBXPPhiKzO3t2FjbfNTQrQX0lyi3vK	\N	STUDENT		MALE	t	f	2023-07-14 12:21:40.992	2024-02-08 15:45:28.566
94a0352f-548c-4577-90f7-cd79c32757b0	sokhomsovichea18@kit.edu.kh	Sovichea Sokhom	$2a$10$asrD8Eccuc4lMZDyEoffvuHnK.2mMLxT./8fY3eoeJs2PkvOfsmGe	\N	STUDENT	78988908	MALE	t	f	2023-07-14 12:21:41.493	2024-02-08 15:45:28.574
57b4912f-2664-4a27-93cc-7f2dae822da3	bhawanisingh.panwar@kit.edu.kh	Bhawani Singh panwar	$2a$10$FTIIPCUUAhxAqLFmyCKe8eI41nkgVh13VECFgBYTHiJhTJb2Mce8e	\N	STAFF		MALE	t	t	2023-07-14 12:21:41.898	2024-02-08 15:45:28.578
4daa2cc5-e484-45a0-b99b-b2bbcbf452d3	sothea.mol@kit.edu.kh	Sothea Mol	$2a$10$MdK.HRG4aMNEOFfQU1IknOvSMAnoy09rSSrScy//7Ji9kBYaNdPX.	\N	STAFF		MALE	t	t	2023-07-14 12:21:41.904	2024-02-08 15:45:28.583
8d50d2b1-e9a0-4532-a5cd-98a972fc2be2	mary.lovelle@kit.edu.kh	Mary Lovelle	$2a$10$EvYzOo6nMnOT9rYBrSRnL.6OiXnak.58la61snuBRlmyYtI7J5bE2	\N	STAFF		MALE	t	t	2023-07-14 12:21:41.955	2024-02-08 15:45:28.587
28d5aa8f-d8e2-4213-8404-11a60cd9bcef	pamela.hundana@kit.edu.kh	Pamela Hundana	$2a$10$wtIxPTLQi4h16jXp7Rxq0OSmMgaZVA5i1l1D4Yp4lkk2rrzx0JMZW	\N	STAFF		MALE	t	t	2023-07-14 12:21:41.96	2024-02-08 15:45:28.59
bbab96c2-9637-40bd-a5aa-e2d74866ad5b	sayaka.kedashiro@kit.edu.kh	Sayaka Kedashiro	$2a$10$fswgCLuoM/z/nuwaHPLt5uizFnnCRNmUVLoNyIjFj2HWLxK6XPtzW	\N	STAFF		MALE	t	t	2023-07-14 12:21:41.998	2024-02-08 15:45:28.595
297a6446-2ec9-4552-b92c-2aa300cbea98	chris.luke@kit.edu.kh	Chris Luke	$2a$10$fzGwvdsP2XHXatUqRHZ5zezDsjaYXsgCm/xrQdBaecyOwqJK/LL3C	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.048	2024-02-08 15:45:28.599
bd710c7c-b3ef-4a95-aec6-3c28b95a5edf	administrator@kit.edu.kh	Administrator KIT	$2a$10$oWDq7AaDCYvDboZpQzfLkOGcArye9KFqc7Pw/1TW/w4MWhQacf/PO	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.053	2024-02-08 15:45:28.603
17fb6082-cb40-458d-abc0-1a6579a44339	yuki.izuka@kit.edu.kh	Yuki Izuka	$2a$10$/60a9wQbpO8fmpow1J6bSO3VcGrHxZrVm8DJ/9WSlhc1KsVjR44.u	\N	STAFF	10315617	MALE	t	t	2023-07-14 12:21:42.09	2024-02-08 15:45:28.608
893a5910-f44b-4677-8c67-5f7e3737557f	sheryl.bsagyawen@kit.edu.kh	Sheryl B. Sagyawen	$2a$10$/9gqIeQhV78T7WhuqL7HjueRuIEKSsxIndHqJ9/b5aZnqz6b3StsG	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.102	2024-02-08 15:45:28.614
9871524f-e58d-4f5b-9a39-1fcceab0cfd7	bilal.amir@kit.edu.kh	Bilal Amir	$2a$10$l7Js/.XQXtAzj6kXdjnSPeDMjB7mXjs6LzN7rGQxftzEcplCnB6mK	\N	STAFF	66837150	MALE	t	t	2023-07-14 12:21:42.141	2024-02-08 15:45:28.618
93be610c-2219-4eed-9486-e4924beaed9a	minami.matsuba@kit.edu.kh	Minami Matsuba	$2a$10$9qV8LPNKiLEMxYsOr04HeeJVxTSadwsmNyzXLFvaLd03l6EO8r.iC	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.186	2024-02-08 15:45:28.623
a30cb6d0-2b90-4261-ae54-b5db9ff16ecc	kheng.pitou19@kit.edu.kh	Pitou Kheng	$2a$10$iSqAwa0HrZdTZoP/SyCLB.P8Ow15ciXMms4J6JCKL19XywaILweku	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.06	2024-02-08 15:45:28.627
a9f9ba65-06c6-4912-8ba1-71a70e00c698	san.thornen19@kit.edu.kh	Thornen San	$2a$10$InWX8NIVU8uphSN.lbWWvOlpCBNG22esIrDPsUXAzigfkmroX7Pji	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.195	2024-02-08 15:45:28.631
ab152fce-24a7-4841-841d-dfcc28a9056b	saromsaravuthia18@kit.edu.kh	Saravuthia Sarom	$2a$10$BP4o1ElgRwrIXlp22l10NOBI6Iv5B.32vOUv2gtFkOcu9eRa4kDIm	\N	STUDENT	89363653	MALE	t	f	2023-07-14 12:21:41.481	2024-02-08 15:45:28.636
ad3a7a70-439f-4fc5-9ddd-6e275eae1e12	hornkimhorng18@kit.edu.kh	Kimhorng Horn	$2a$10$cfUMtEaMLwNHmu2kOr4kMubU8SRlYHF1z14sI7YtjznxhrRfX3BtW	\N	STUDENT	15394490	MALE	t	f	2023-07-14 12:21:41.521	2024-02-08 15:45:28.64
531c56db-0fab-4e04-a569-c082fd7d416c	campbell.corinna@kit.edu.kh	Campbell Corinna Corinna	$2a$10$ampr8ydOB0hITuCONOW9J.pcrhkUlT3O1U82VBtFVCY6ixu0ptupK	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.27	2024-02-08 15:45:28.657
287ea090-0b2a-4184-8b24-1b335673ef7e	yo.matsukawa@kit.edu.kh	Yo Matsukawa	$2a$10$2HNi6RYQmgXgl1I9QcCns.H6PaTSWGaayOPJQSK2CAP6/cN3wSVOy	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.281	2024-02-08 15:45:28.661
b4948d5a-24e8-4434-b990-842c3cc8b71a	nel.sokchhunly19@kit.edu.kh	Sokchhunly Nel	$2b$10$IZMGH05rWbRTzM2Cz4KZPOPNMjncmzxQTx2VY74vNTb2UnmTKJpcy	\N	STUDENT		MALE	f	f	2023-07-14 12:21:40.86	2024-02-08 15:45:28.665
bfa62633-feb2-43eb-8b99-6a7eb0d3566b	huy.darapichchan19@kit.edu.kh	Darapichchan Huy	$2a$10$g.Y2HNvtgIbHCh0SVMyL2ebcv.ylsaZpEk3KnsQQmAvxDFNmd5twe	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.066	2024-02-08 15:45:28.669
c23ca408-3aaa-479d-a26f-ef6c2e4851cb	e.sokmean19@kit.edu.kh	Sokmean E	$2b$10$khtS4gmWDSD3fGJCW0z7/u2eBEBA3BiDwypUR.NNIUa5KEHbOaD6u	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.137	2024-02-08 15:45:28.673
bb6a3e0c-188d-4bac-a0f6-a1c91fc871de	krean.rathana19@kit.edu.kh	Rathana krean	$2b$10$2oNrHYhhzz4XjuP59Dkk8.YYset0w.qWpEe3yWVkSoCexQp14AFqO	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.148	2024-02-08 15:45:28.677
b13b1853-5f86-4f64-afd5-094f113b00a2	maimom15@kit.edu.kh	Mom Mai	$2a$10$lx8KCTlpoYJBL21gps6lmuXm1/cYgW2q2TLg1NWfNKphIFfiUYKyW	\N	STUDENT	967969927	MALE	t	f	2023-07-14 12:21:41.23	2024-02-08 15:45:28.681
b43efd61-79bf-4dff-88b0-24407008ad2b	limchansamnang18@kit.edu.kh	Chansamnang Lim	$2a$10$ZbljDpIAqZHhZQL82nIW9uVeGX3FqoJmYfmb9N6USlciJpb2dfVHS	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.312	2024-02-08 15:45:28.685
bd1ccedb-ef51-41f4-a9fb-12c69c6b9b61	pumsinin20@kit.edu.kh	Pum Sinin	$2b$10$Gq0znv.06DldCau.qpJ9QuNNM9RmkdCJp0Jx5/iVTvo/rq3Z3fqmG	\N	STUDENT	12345678	MALE	t	f	2023-07-14 12:21:40.884	2024-02-08 15:45:28.688
b2869ff2-7e91-4707-b410-b6b770a6c4e5	huotmonirith20@kit.edu.kh	Huot Monirith	$2b$10$tI4Ei7UyJXIJk5MoAh8K8ebBpm.Fy5PdSuUNzSVjhlwELlRRqErkO	\N	STUDENT	12345678	MALE	f	f	2023-07-14 12:21:40.939	2024-02-08 15:45:28.692
f6a2961e-288c-4912-ad37-0c6eb51d664a	onlineexaminationsystem@kit.edu.kh	Onlineexamination System	$2a$10$.bFb4mGHg87yv012NN2K..FHUtJzQ7sYaqaqWtcN6rnJvXOKTqzG2	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.44	2024-02-08 15:45:28.696
bb35cbf4-2557-4a89-8cdf-f28bdf81e580	estelita.litobcandae@kit.edu.kh	Estelita Litob Condae	$2a$10$A0VmZ8xBjxM7mjdv2in0/OaUg8O.b7v3AVdP13Hk7GaUSTUIwHaCG	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.484	2024-02-08 15:45:28.701
df2d2273-ea08-4f73-9a77-0cfb99bec429	kenzaburo.bekku@kit.edu.kh	Mr.Kenzaburo Bekku	$2a$10$ddu580bSRQWYtMVBTR7Zvu6sfP/5bm/mkRG1wzXI/8sBxrK8URQRa	\N	STAFF	93541930	MALE	t	t	2023-07-14 12:21:42.489	2024-02-08 15:45:28.704
4cfd4865-b335-4e19-89e0-7b81f14cca11	ngetphanny@kit.edu.kh	Phanny Nget	$2a$10$SSGem4y62.U3F0hkHzK9vevsCTiHPYyQiBIMyzwB.7fejyAh37/VK	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.495	2024-02-08 15:45:28.709
c77df251-4f28-4fae-9c75-4805118f40b6	sarysodaney18@kit.edu.kh	Sodaney Sary	$2a$10$zkn8NgI3QBi5yo6adRse9uZqpvJ5xXR31R8yM1Jd/X5GR9Sy9o2um	\N	STUDENT	16584452	MALE	t	f	2023-07-14 12:21:41.277	2024-02-08 15:45:28.714
395da688-ff8a-4f08-ad18-ab494c2b654c	naoya.yokota@kit.edu.kh	Naoya Yokota	$2a$10$Jbxc.NtwkyM/3Jo8BqqWmOXlbmagOktzRe9OD0j4adN5aIpCe4NUG	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.528	2024-02-08 15:45:28.718
e26e6aee-fa3e-4667-b3ad-3183e2664cb0	kitwebhosting@kit.edu.kh	KIT WEBHOSTING	$2a$10$nJ2yp5HBTq2jV4Sfnz4OVeAfJpdqy/C/FKLPtaD.PMTBwGX7pxB72	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.55	2024-02-08 15:45:28.726
a371753d-eac1-4ea9-912c-c27e6878772f	ryosuke.kosaka@kit.edu.kh	Ryosuke Kosaka	$2a$10$v5FTxCxPW/1aGJ3wTMDwDebLF.9KeoWHHkqSl3QnopZQSlmrblASy	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.561	2024-02-08 15:45:28.73
b8d4ada2-4f25-4695-869f-5994e3ff9f7d	vignesh.manoharan@kit.edu.kh	Vignesh Manoharan	$2a$10$BwTyBY9xN7W6VZYZnHfnd..duKRPq.HyAkrewfsIfMwyR2OS6p/ba	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.566	2024-02-08 15:45:28.734
0b2236ea-4fb8-4b66-8a23-02044665339b	ryunosuke.nagao@kit.edu.kh	Ryunosuke Nagao	$2a$10$j//nJPYqJnAN5rrIot.CHOr9nSsieKN9Ga0anVXBw//nq66/sZEK.	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.571	2024-02-08 15:45:28.739
fd1240b4-9d4a-4b24-99a9-ca3fd3d1644f	dinesh.rathore@kit.edu.kh	Dinesh Rathore	$2a$10$sQSrb.VcuO8KQSvs8hADT.mERke9dWDYXYi8oqXhuKntq5vGfsBU2	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.576	2024-02-08 15:45:28.743
8a5072d0-aa3a-44e2-b483-f3bc4de6825c	emiko.inokuchi@kit.edu.kh	Emiko Inokuchi	$2a$10$6CgyTbjfP6kERbfLJ9.NPuxCcKDdt.NxNnstvYqomtxyYFHw/xzqK	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.581	2024-02-08 15:45:28.748
e4363169-6f04-467a-83c0-efa0a64d7054	studentsaffair.info@kit.edu.kh	Students Affair Info	$2a$10$v0LeU.cVMjQDVPXsdQaWBuUjdicGFBvS4KXCKNAgRIY6JE3.Mu1q.	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.586	2024-02-08 15:45:28.752
c55a745d-b176-440d-9838-1bfd10d7223d	mariko.sadamatsu@kit.edu.kh	Mariko Sadamatsu	$2a$10$CtMFezVOPoe1Ed/Vw4iOUO5osbZBfdirPS78zrrfr3v90Nm0XzbGC	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.597	2024-02-08 15:45:28.757
f13aa186-945f-4e10-a429-e936f841dccb	vainktesh@kit.edu.kh	Vainktesh Shekhawat	$2a$10$v1d3nt52m3EQQQcaa.4eA.XWXSTQZsCWYSKxxFXhO0eJAvGEMwngO	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.608	2024-02-08 15:45:28.761
b53200bd-16bc-4b4a-81f2-9cc1d42d4931	hicki.okamoto@kit.edu.kh	Hicki Okamoto	$2a$10$t7.bi9mB/1jEry.lTFR0Me25D1/DtFXTT44wOcTbEEQ3yM0N1jHTK	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.613	2024-02-08 15:45:28.765
f0452433-0382-4956-9883-e471b888629c	kpi.monitoring@kit.edu.kh	KPI Monitoring	$2a$10$zlwZzj/fKWyu23r2k6ehp.CvPIRA2sohLAp6ZqkKyo0vk7VSDJh2e	\N	STAFF	99999999	MALE	t	t	2023-07-14 12:21:42.618	2024-02-08 15:45:28.77
25054e9b-280c-406f-8290-3dd9fc84830f	saranya.vignesh@kit.edu.kh	Saranya Vignesh	$2a$10$Hr5Zi6njSAjv7sKKCUsNnOBNEPWHa2MrJT0wuHq.63Tqegqny4gLm	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.624	2024-02-08 15:45:28.774
3c5c9883-3b9f-45a4-ac2c-6fcdf3212415	yu.omori@kit.edu.kh	Yu Omori	$2a$10$USXSOVGljp.TCmRhtS3TzO6myjFHu7AVNZI6iA.UNcubIW/2Oj06i	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.629	2024-02-08 15:45:28.778
55076c72-eccb-4dd7-99b2-5e42ddcce4dc	inokuchi.lily@kit.edu.kh	Inokuchi Lily	$2a$10$orThjs/8JWdGyTN99CXrVeBvwEekHF784jndRn2O4jtW2FAgLJH/.	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.634	2024-02-08 15:45:28.782
54346e2f-8104-43f5-9d44-a1c02ce24f46	inokuchi.keito@kit.edu.kh	Inokuchi Keito	$2a$10$ySJ6zysPa9AZLDM/2l.LReS6LsgxvTNe5Wr/7WPWupMtYffqrzFLa	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.639	2024-02-08 15:45:28.786
7a744620-1b44-49f7-a115-58d42f78ca10	raito.izuka@kit.edu.kh	Raito Izuka	$2a$10$iBVE3fvCi.qU3kcErqnC3./pqSaV58UIEOQlNS0c5ha9GJVF950J6	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.644	2024-02-08 15:45:28.791
5221493c-260c-4494-8f00-601a92950dce	hazem.alnajjar@kit.edu.kh	Hazem Alnajjar	$2a$10$nVuFtXEXlsAURc1Cs/wY7uaRYuYwK8a/5c7IroQk6FuSUTBLlhNQ2	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.654	2024-02-08 15:45:28.795
11d249c8-fa62-4cc9-bdaa-36d0c5461d84	logain.alnajjar@kit.edu.kh	logain alnajjar	$2a$10$5IEhwzy.XgoOvKZr84W4jOxY6yfqy1GuPHMHGZpgnvj3Idr8jooh6	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.665	2024-02-08 15:45:28.804
d25ecf0f-e9ae-4c34-a09d-bf6dedcead9f	leen.alnajjar@kit.edu.kh	leen alnajjar	$2a$10$3SXn4B3ZYJ0NPK8KdtSTVOMuQyTqHUo7HAawBFWhMgH/oXIj9wmuu	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.669	2024-02-08 15:45:28.808
f591dc20-ff79-4c65-9a98-53db7cd3ac65	nol.mono19@kit.edu.kh	Mono Nol	$2b$10$DIBQMAKFrpX9PcDq.AVm/eyAY3koQxVFXv/SRUqxCgQP641orkjcC	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.154	2024-02-08 15:45:28.811
b7426eaa-81ba-46dd-958a-d78ac8bdafe9	chester.magsino@kit.edu.kh	Chester Magsino	$2a$10$aZ3DVRHwPYF9nO3BzsMI8eSB8hr2egTluqgyI12PTfaHGh0m4Emq6	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.674	2024-02-08 15:45:28.815
e31fc0ea-1a75-42c1-8e7f-342559e432d1	zarmelcristine.magsino@kit.edu.kh	Zarmel.cristine Magsino	$2a$10$6J0IlCcQOwEMNKtl3p/.h.feJXJbUawui0YS37Q2i.WJEYDEF97AO	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.679	2024-02-08 15:45:28.819
2196ca59-23ab-4f9c-8f70-dcc891350a19	hodaka.omori@kit.edu.kh	Hodaka Omori	$2a$10$bTMDxtfjuGxRiunOKOSu6OY1k73Ni361.0NcbASL6OjM3C.WFlfXi	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.69	2024-02-08 15:45:28.823
ce163171-661e-45a0-8299-852239060ac3	wakaba.miura19@kit.edu.kh	Wakaba Miura	$2a$10$8b7PaVLRjV4BjHkB0aUwueHQRBhhUh.Dkp26xhfANJTRjyNO7hPh6	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.735	2024-02-08 15:45:28.827
286f3f5c-cbe0-4055-96c9-79b6663dff27	man.theavy19@kit.edu.kh	Man Theavy	$2a$10$dGua.DKtUCSgkvP9HMvZouK5VKPp5Zx2F5Tel35AxIv2aUxT284d2	\N	STUDENT	964321606	MALE	t	f	2023-07-14 12:21:42.771	2024-02-08 15:45:28.831
fe659e41-5ad6-400a-96c6-55c6d96df571	toma.omori@kit.edu.kh	Toma Omori	$2a$10$oUtgf49CqmuELKBX/Z3kuu53DHKHtHH57Qu3guO8uR5em4vW8kSp2	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.812	2024-02-08 15:45:28.835
1c5ae57f-d16e-418b-a8e5-2bd91ddecf62	zachcaizer.magsino@kit.edu.kh	zachcaizer magsino	$2a$10$CQIAesnWDhpEW79E71n5uORi3Dj/j/EBPRJJC91qCiEf6zljWHR/6	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.823	2024-02-08 15:45:28.839
1df9c493-f210-45c5-b674-8b357878bf5d	sayaka.izuka@kit.edu.kh	Sayaka Izuka	$2a$10$ESeOdY2VNqrKJkSANTEtb.VCCR0ve2f2qx.Sgef2pnvNPFPz2Uope	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.834	2024-02-08 15:45:28.844
b22bb730-9074-4233-b05c-e289d89e8215	dinesh.kumar@kit.edu.kh	Dinesh Kumar	$2a$10$vGt13Vw8N7CPoSTpnQZX1u9trPke6f0zqzJNuLdHIZGS21T.i6WGq	\N	STAFF	979502420	MALE	t	t	2023-07-14 12:21:42.86	2024-02-08 15:45:28.848
17287de3-bfa2-445d-aba8-7e5ee380e53e	prabha.gowtham@kit.edu.kh	Prabhakaran Gowthaman	$2a$10$6faGk/0uKtEXU6962VNksex1KsTsypu7Ithj7GGHRSroNDledHoWm	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.865	2024-02-08 15:45:28.852
9a675017-d953-4f01-b78e-0e03a9a4fbf0	kevin.sabbe@kit.edu.kh	Kevin Sabbe	$2a$10$7udRcKTSXU3A1wvjhdoYI.fhnPBytAbyDvkamBehK8cUsYLbyne9i	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.87	2024-02-08 15:45:28.855
06c110eb-5c99-473e-bc29-3fcc9cd76045	eiji.izuka@kit.edu.kh	Eiji Izuka	$2a$10$uMbVTaN1kuSBuJduVM0zKuU.oinJs.4xw27fsxTQkBu4lXhQRVNW6	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.875	2024-02-08 15:45:28.859
9c02d719-f073-4719-9699-97d3f6053d17	vkis.dormitory@kit.edu.kh	vKIS Dormitory	$2a$10$AJN2LvcZkOy8fAN42diGNedZYB0mu67WkK1rRG2eVNx.Q4LdIHK0y	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.886	2024-02-08 15:45:28.863
3fe19200-bce9-4ea3-a5b2-4a975b2d5ecf	geraldine.annetan@kit.edu.kh	GERALDINE ANNE TAN	$2a$10$JFh9x6q0CkkINPl5sTmo4.Xlq6zUE6djDAU6OOJy5Nc0BhAgJDywO	\N	STAFF	968952494	MALE	t	t	2023-07-14 12:21:42.891	2024-02-08 15:45:28.867
4966e3a7-64ac-4aa3-93fc-92c3a7cb2175	mark.joseph.merto@kit.edu.kh	Mark Joseph Merto	$2a$10$OfZcGAG8hFLjHb2VSeJxBOW3c2FIZmwmc4y6G7YX8IIQ9zs/Z1i1C	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.896	2024-02-08 15:45:28.871
f986ba44-59ad-4ab6-aa61-eca803292358	oem.sovann@kit.edu.kh	Sovan Oem	$2a$10$zWlK46D4HL2DoTzhJvdDv.smkZbEjdjH60lKWBMMG91AcUkPHpy1u	\N	STAFF	70887470	MALE	t	t	2023-07-14 12:21:42.901	2024-02-08 15:45:28.875
b63d4c23-c6f7-4f48-96f5-99dbb4e11bbc	jobify@kit.edu.kh	Jobify Company	$2a$10$xhDuqfFk10m2rINo6PAq7.D3wuWCV0np4pdLP4rmfhm.txZU6oJOq	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.906	2024-02-08 15:45:28.88
23aaf19b-dde9-4fed-92e9-81dec4b72ba4	geeta.tripathi@kit.edu.kh	geeta tripathi	$2a$10$Y1I8B49y0SgCJNR4vE1jKuCghDGp27Gajqjx0vlZj6BN4ttoiaptS	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.916	2024-02-08 15:45:28.889
bae84d88-7181-4053-b879-b46989235f1d	naoko.bekku@kit.edu.kh	Naoko Bekku	$2a$10$kT04HdO4yFMYLFul8BUMTuIj9wa8W4Pr3XbhqjpBtyJ7YdU04y/fi	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.921	2024-02-08 15:45:28.893
e5b68834-7553-4b14-8bc8-96b26dd0d169	kaoruko.bekku@kit.edu.kh	Kaoruko Bekku	$2a$10$ItOxQrgtDar31hro51INpOHYTPZ8irVLmm3dRBpTrArT2bYH4WJwa	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.926	2024-02-08 15:45:28.899
adcfc26f-4e80-4534-9167-59f694ae0bbc	fajardoliea.maemonforte@kit.edu.kh	Fajardo Liea Mae Monforte	$2a$10$8v84A1.eUuVyMTPUY7xGuuF.so5FuO2Gfjh8ptau5PEgp1ACCmTjS	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.943	2024-02-08 15:45:28.903
33ef104b-3b18-4802-bd70-8ac393168bd3	sudhir.shenai@kit.edu.kh	Sudhir Shenai	$2a$10$UIZqkR7UsOsWeedxlEY2Ie3kJme8WBrrQkX.vUHK3EtttE9LbixiS	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.948	2024-02-08 15:45:28.907
9c5d0e60-5b79-489b-8e72-81773d55603f	ashish.kumar@kit.edu.kh	Ashish Kumar	$2a$10$LBe8wUZYEf4U7efA0Pfpoud0yHL55o/DeDwTLLHeajtr5dsvPJSfe	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.953	2024-02-08 15:45:28.912
1d42809a-c4b1-427e-9feb-cbe16eb22357	kento.nakamura@kit.edu.kh	Kento Nakamura	$2a$10$dYPvhbdM96R34ZOsCKFdEOyCnYISnDGesE7/XWjmg453YtMghsyIO	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.958	2024-02-08 15:45:28.917
39f30790-b432-476a-b510-0094ed72faf9	marin.kobayashi@kit.edu.kh	Marin Kobayashi	$2a$10$9JHC0SAeTZshBfeTqXMa.elheW1kfavwk8bNpCaQDtHQpJ3JSUuOy	\N	STAFF	99830855	MALE	t	t	2023-07-14 12:21:42.968	2024-02-08 15:45:28.922
d7792974-e9fc-4db8-93cc-856c2a6b3c8d	miya.arasaki@kit.edu.kh	Miya Arasaki	$2a$10$BltnKKcOXNi0O2i9csVvGej.oqi6QjNIevnG8ho8ilEqfQkAzMBPS	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.973	2024-02-08 15:45:28.926
5787d877-817d-4229-bdb3-ffc7d18808e5	keen@kit.edu.kh	Keen VC	$2a$10$HeiicIbrws712QgEBB9.S.Ly56rtwT/NyuQZvORjJrp1biTq.EUgK	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.978	2024-02-08 15:45:28.93
8f12abc3-c1c8-48a0-a772-36c7fb2937f5	earlyphant@kit.edu.kh	Earlyphant KIT	$2a$10$sRUETwlizVQXr4hY/YntCuxA1MStWmdcx6MXRDpVYvpKnPk5r.ZJa	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.983	2024-02-08 15:45:28.935
c3b233f6-d730-41ce-80f0-51fa50b574a4	miki.arasaki@kit.edu.kh	Miki Arasaki	$2a$10$tgDonhYegorQLEquYV7IautJALbVAOoF1AsqZhvABfkUaGXKTMb8K	\N	STAFF		MALE	t	t	2023-07-14 12:21:43	2024-02-08 15:45:28.94
52272b0d-6d76-4066-937b-75418e212a74	sokheng.teng@kit.edu.kh	sokheng Teng	$2a$10$JQccO.bKSe/29HcrqQDfbuckiUK3H7lsRAFlrSsWv8T3/Cgve9qs6	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.005	2024-02-08 15:45:28.944
bb6f92a6-fe43-4c9e-b9a2-cc63b997046d	toma.arasaki@kit.edu.kh	Toma Arasaki	$2a$10$TuhoV52OUj5lGVMu/M.I/eXImGcptlUyHvL4DuD7VmF.29jXZDJam	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.011	2024-02-08 15:45:28.947
157fd050-e9c7-4ac2-b43b-987151aeba9c	aravindan.srinivasan@kit.edu.kh	Aravindan Srinivasan	$2a$10$TDkf8z5zdn3UWLISqGwoF.JEjgtt.kEdxYkUJ6Rh3mhHJeAi39UVK	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.022	2024-02-08 15:45:28.951
412c79b7-f0c4-4664-9d84-444b77fd5bbb	fsdfasddf@kit.edu.kh	asdfsdfsdf	$2a$10$RFvwFrD8v/HMvTx8HNAQG.frFt4phFNvZYrnHt35zqMav8BfUpc4m	\N	STAFF	123123123	MALE	t	t	2023-07-14 12:21:43.027	2024-02-08 15:45:28.955
db26ecd1-7a73-4ca2-ab26-253bd00b48ef	pichsovannara17@kit.edu.kh	Sovannara Pich	$2a$10$rxeBeKaPR33lkuANOgus..q9Y4/y8WfQ3xVcGcMuZzJMH/ZtEIiq6	\N	STUDENT	10318428	MALE	t	f	2023-07-14 12:21:42.424	2024-02-08 15:45:28.963
8ddc1ccb-29b0-4c37-a826-d1e19f649ab1	khlok.sonita19@kit.edu.kh	Sonita khlok	$2a$10$sVwvBKmKWS6qNsQ14Gi83u6EDC/DT4OWVB9Dvy3Oh5lTIT9D6pFAq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.067	2024-02-08 15:45:28.966
93db068b-c731-4e13-9b0c-fc70dda20169	huoy.viriya19@kit.edu.kh	viriya huoy	$2a$10$/0rXciQ1kT8ecdVdzaHDre8Vq4xDjczg4sRoMct2Ky.DxRuaQtIhm	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.113	2024-02-08 15:45:28.97
bc15a18d-3a86-41ac-a8d4-8fa8ed951788	kao.ratana19@kit.edu.kh	Ratana Kao	$2b$10$/fiy5Q1pdvPlaOfL.Os.CuIXeOCliWdrJGg8dbxRookWrVEjmIEI6	\N	STUDENT	\N	MALE	f	f	2023-07-14 12:21:43.403	2024-01-08 10:33:14.118
0310bada-3e87-4d98-9835-c3fccea48539	staff@test.com	staff demo	$2b$10$c6GbqMCFe3NF.bJ.cv.MMu5BZ0qCBzKNHmq7ph.JWKtLMrIdW8MgS	\N	STAFF	\N	MALE	t	t	2023-07-14 12:21:43.828	2024-01-08 12:00:03.443
773926f6-16e1-422e-a4a4-e8ecc073d3a6	batch_four_seven@kit.edu.kh	batch Batch_four_seven	$2a$10$noQw3Vu/338CvpuD5HKutO0vuH1v4PucoiecyQEAOC/j0pI0OLWSW	\N	STAFF	\N	MALE	f	f	2023-07-14 12:21:43.519	2024-02-08 15:45:26.318
757a2777-fe75-486d-88c2-fcd63cd60511	batch_seven_one@kit.edu.kh	pisey Batch_seven_one	$2a$10$bC3u9Pe0XHomd6iZe2sMouGYkiTTN44scYcr5O4XJV.8Q5I1atEdi	\N	STAFF	\N	MALE	f	f	2023-07-14 12:21:43.525	2024-02-08 15:45:26.322
7849fa38-f55b-47dc-b123-b0cfa0baee4a	batch_four_six@kit.edu.kh	batch Batch_four_six	$2a$10$i4x1sG59Ra3QZ5sd1sgvvebpI8HOIa7az9piUnB2nztHuMIs2qApW	\N	STAFF	\N	MALE	f	f	2023-07-14 12:21:43.529	2024-02-08 15:45:26.326
83ef2d5d-6cd3-4fd4-a391-3db0449c6c04	batch_six_one@kit.edu.kh	batch Batch_six_one	$2a$10$Xy4ZyYrJnfgmP6P57xdZw.EEY3PHQ4bPT4Q9eDwsJVwwTcBB0S4Gm	\N	STAFF	\N	MALE	f	f	2023-07-14 12:21:43.514	2024-02-08 15:45:26.329
6640733e-16f4-42c6-9235-5f7f25e3155c	batch_three_three@kit.edu.kh	batch three_three	$2a$10$9n4mFTJrYVyvbRezUTiU8e33lVwIh5/8pHxnQkwdt4of/6HH.ScVu	\N	STAFF	\N	MALE	f	f	2023-07-14 12:21:43.451	2024-02-08 15:45:26.333
dfc89883-0bf0-413d-a757-23cf2217bf93	pisethsem@kit.edu.kh	Piseth Sem	$2a$10$JN/vkCOzVIZomLdJsddgG.bGETqVoZMFYOvyhGLIpbYFXB4gBO5MC	\N	STAFF	\N	MALE	f	f	2023-07-14 12:21:43.59	2024-02-08 15:45:26.336
4a6f5bdc-177e-4128-9080-a205cd3a42ac	abegail.kio-isen@kit.edu.kh	Abegail Kio-isen	$2a$10$8D7PU5m9H5jiMnEwTrqWaOzsR/qfmQ6IkgCtwQnoAL7xnhBeUIlfW	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.168	2024-02-08 15:45:28.975
08dcd518-4078-4329-b9b0-4081679246a2	irene.don@kit.edu.kh	Irene Don	$2a$10$j2387bnV8H8G/oFpiSE2J..yC/imXGKCtXed7tk1IINyqABWbuXne	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.179	2024-02-08 15:45:28.979
fa564883-b05c-4e67-855c-e5e50adb00d9	chain@kit.edu.kh	Chain Solution	$2a$10$fdW2a18Nl3TYCjEIQLR/FeGHDAw7bmvqeIKJw/cfntd6Ut0pmymOe	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.315	2024-02-08 15:45:28.984
e3b0a020-b8a3-491d-9c41-c2ae36121ae4	san.phearom19@kit.edu.kh	Phearom San	$2a$10$DjmuGdgtMFqAgbVQJLIx4uyaV07sjXZrWL9NBBRnO2/dVBKHaNoke	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.469	2024-02-08 15:45:28.987
e9af9870-2627-4e23-a475-47803342eaa4	kimsereyvath20@kit.edu.kh	Kim Sereyvath	$2a$10$PvxrLDcKHBBNRxzNE51ane3igDPBF6loFTsMUqtuFoDuxTye8D7.a	\N	STUDENT	12345678	MALE	f	f	2023-07-14 12:21:40.82	2024-02-08 15:45:28.995
f21d945c-989d-4a81-862d-4bb67b4ec9c7	sharpmind@kit.edu.kh	sharp mind	$2a$10$E36nH8i5nn5r.D7oowjRveGAvpCmKgd6idDlOl9HvPSa8ZDZuMOHK	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.383	2024-02-08 15:45:28.999
1af2e637-13de-42b7-a2c8-97dbbe558d02	thornmetheany15@kit.edu.kh	Metheany Thorn	$2a$10$SjyhPw6kd9N.gm4xgsL13uS31RUS5Fko/PpMUVw4swwMXb3VcgNGC	\N	STUDENT	10683833	MALE	t	f	2023-07-14 12:21:42.011	2024-02-08 15:45:29.003
1bbe8294-1c88-4538-a9b0-30065d2e9460	phansovanna18@kit.edu.kh	Sovanna Phan	$2a$10$1PdQUNibP.8IVsDziuMGq.HPd2Tx7w4/slNGeC3OmSbq6l7g7Pv5.	\N	STUDENT	70252465	MALE	t	f	2023-07-14 12:21:42.401	2024-02-08 15:45:29.007
609abc9a-49ea-4fa9-a1ca-ee84182f9dc0	subtam@kit.edu.kh	Tam Sub	$2a$10$G7h.oVoaBn..Y884o5vgnObtyKjNf.O4fsL.REaIdPvDHQopsyCe2	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.474	2024-02-08 15:45:29.011
2257d6d5-15df-4768-8bbd-760f13b498b2	sochetra.rath@kit.edu.kh	Sochetra Rath	$2a$10$cDrpP3kYni5pLBDWBmqFyu/YUTmX3ZjL2Lid7UiRc5xYYWJY8cZTe	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.485	2024-02-08 15:45:29.015
ecde2c82-9fd6-4684-98ab-ad2e0d429a78	zeal@kit.edu.kh	Zeal Virtual Company	$2a$10$1plaeasNDRoky1uEAu3.Ru5.pPfg1cnvrgtkw.qbuTgWSFvZSWxHy	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.49	2024-02-08 15:45:29.02
5c8a925d-f7a7-4f68-bf85-73fb0ca789ee	cybersecurity@kit.edu.kh	cyber security	$2a$10$joLmfDpYzfqMNLzZa.n2.ejIEyzOb625rAUxcejzzhcAJqO58rEle	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.495	2024-02-08 15:45:29.024
9c1f343d-52a5-47d1-aa86-5f7794e29794	aruna.shankar@kit.edu.kh	aruna shankar	$2a$10$1PW2kJYz4b57fG2966HkB.EIXdunCRNN1vPrs7WV7M9Epi7.KjKlu	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.5	2024-02-08 15:45:29.029
6abb20ad-f5da-478a-8d27-ba9fcc41f4bc	coin@kit.edu.kh	kit coin	$2a$10$SzHdqxH84R2Qt2Xq7LNaW.8twivBgo3G/j0ByqvN29Q3tzHDSdObK	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.509	2024-02-08 15:45:29.033
df73852e-595e-4735-bde6-048cd014995d	casstack@kit.edu.kh	Casstack Co., Pte Ltd.	$2a$10$hhSp0O46qKrC26/CwqzSNO7m5PAKIIf8.peS70cLf82l0tPomvV0K	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.534	2024-02-08 15:45:29.037
161a47f0-fa82-461e-b974-06f69147e62b	yim.thol@kit.edu.kh	Thol Yim	$2a$10$qBP4ar2L0ZfWQQ39JRbq5OeUYLpKw1Y6ZZ/.1JT7SghXo4PQjwvd2	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.539	2024-02-08 15:45:29.041
3f40dcfc-e892-49e2-9878-c35fd3a9a442	noy.chhorvin@kit.edu.kh	Chhorvin Noy	$2a$10$KOIXCjrNRgikzsP3sLwNmuAu8NXnaBngtSaR2T/BIWFNTzqXDNTmG	\N	STAFF	89924144	MALE	t	t	2023-07-14 12:21:43.544	2024-02-08 15:45:29.045
509d5033-9f79-4638-9933-6086dd9f5d3e	shuttlebus@kit.edu.kh	admin	$2b$10$O8fmuCNTWDwsMHvS2FANde4JAc1cTvVsVOIA3svJYE17QUac3BiMG	\N	ADMIN	10959546	MALE	t	t	2023-07-14 12:21:39.786	2024-02-08 15:45:29.05
15ee892d-d86f-46a0-8ba7-900a79996fc5	petanque@kit.edu.kh	Lay Sara	$2a$10$tV2U3GTfMIbmXGnq0RO35uN2rRT4bmgzqkx6ci0dDyOZe32bnliIS	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.574	2024-02-08 15:45:29.059
b97f0068-cfb7-4ee9-bf3e-1fe7830ccc3e	ran.ishihara@kit.edu.kh	Ishihara Ran	$2a$10$Naz2cmNdF.4eSZgyCexENudD36UbLhLOSyUuCfmoqvqP0Lbp35WAy	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.585	2024-02-08 15:45:29.064
f8ccc9a1-30dc-4033-b34a-dd5a34a6b79f	panhavon.chea@kit.edu.kh	Panhavon Chea	$2a$10$1AfYMZSf8gGJLtmHuxJW..hXRj9eKDiZlPUM6hKM/vclsr6dcFj96	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.596	2024-02-08 15:45:29.068
1aa3a202-0ad8-477b-bc9a-103548cca52b	sopheap.liv@kit.edu.kh	Sopheap Liv	$2a$10$r913rO5rSb02C6pmBNgk1.Hoj6ZWXuJ.a8Ji5fk72qaY0JEjTjlMy	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.601	2024-02-08 15:45:29.073
197bffb0-52ab-4511-96bf-75f7558e84ed	dysopheak15@kit.edu.kh	Sopheak Dy	$2a$10$o7URnGakZ0VvjRVucbLB7.nHZ8nRKhGRMPmkQufcl6fogtAU.a2tS	\N	STUDENT	968847234	MALE	t	f	2023-07-14 12:21:41.223	2024-02-08 15:45:29.076
7df71d27-b812-4d63-a890-e6b62fecf9dc	lychunvira18@kit.edu.kh	Chunvira Ly	$2a$10$PfdHrXo1mHLSxdzUmUGn9ei8saY6RZFIxpxha/7sfZS1G2zXR1GmW	\N	STUDENT	98758566	MALE	t	f	2023-07-14 12:21:41.306	2024-02-08 15:45:29.08
cc6fe942-be3b-483c-9d8e-cb4f8818f548	ekokamamatsu18@kit.edu.kh	Eko Kamamatsu	$2a$10$9f.u0zYq40KijxlLVDV5F.8m/MQZAMoZmojm.Cy5MhnZ8S6igGA/W	\N	STUDENT	967638354	MALE	t	f	2023-07-14 12:21:41.383	2024-02-08 15:45:29.084
91f8763f-a8d1-424a-b638-ee08e8587e3d	maysokunlanita20@kit.edu.kh	May Sokunlanita	$2b$10$m2Tld5q0.3.XQjJOabfaIePkf1ZfXewj8cZSPlT4884P5bbVZNK/S	\N	STUDENT	11111111	MALE	f	f	2023-07-14 12:21:41.201	2024-02-08 15:45:29.088
7100a80d-0a28-429f-9bb1-35cf8b897bba	chouna.moa@kit.edu.kh	MOA CHOUNA	$2a$10$89Ze2zKitdnGWSgn4KE9k.WQwblv2VKa9UQFxSs7LeTd4d.m0M81u	\N	STAFF	11111111	MALE	t	t	2023-07-14 12:21:43.808	2024-02-08 15:45:29.092
06a17449-17dc-4202-8e20-cef2efc1d598	sokvibol.kea@kit.edu.kh	KEA SOKVIBOL	$2a$10$9XrH0osoc0wlqiMJVn96U.SFa/3pqq9adNkgHu1NbI.czEU25J8he	\N	STAFF	11111111	MALE	t	t	2023-07-14 12:21:43.813	2024-02-08 15:45:29.096
3ad26f0e-1c28-4e25-b8f7-abb3902d6de0	sokrom.pak@kit.edu.kh	sokrompak	$2a$10$vWSA0dBjMPcx3zp00q1MheJNxAkjOy0u4kXlUD3iYE7t7kTLDF8gG	\N	STAFF	9872223	MALE	t	t	2023-07-14 12:21:43.818	2024-02-08 15:45:29.1
b2660df3-c832-4245-8e93-b9db034c7e94	admin@kit.edu.kh	Admin Demo	$2b$10$aLl/1MtaD1vLWi4C1S4mJONVvk0I.NIu9KoDOHLAxH/ZFxfASLJeq	\N	ADMIN	\N	MALE	t	t	2023-12-14 10:06:00.2	2024-02-06 08:14:03.156
179c3f54-084b-49c0-8bc9-bce0088c6bed	batch_four_five@kit.edu.kh	batch Batch_four_five	$2a$10$.rNfdpvVcyW4oXG9CGQIAO/QoNeaKU1UkOIgLtkJlpY.bVdWS4ZXi	\N	STAFF	\N	MALE	f	f	2023-07-14 12:21:43.569	2024-02-08 15:45:26.342
f13791f7-4675-49d8-9891-f4da8d235718	batch_six_seven@kit.edu.kh	batch Batch_six_seven	$2a$10$eORbipPWMnY157zt7/lbhelbZXcoen4EJrp4cn5UlCnib5zOFmB02	\N	STAFF	\N	MALE	f	f	2023-07-14 12:21:43.505	2024-02-08 15:45:26.345
9bfc3bee-729f-42c5-82df-ba3c282ab64b	nan.chamnapleysak@kit.edu.kh	nanchamnapleysak	$2a$10$LsKKygsOzFWP1.0w7nn5L.HO2IWJczoEHM9hS4BAgw/NCJknYC50K	\N	STAFF	9872223	MALE	t	t	2023-07-14 12:21:43.823	2024-02-08 15:45:29.104
51fd02f7-ee0d-4e63-87ce-dd23db7b1aa2	hin.socheat@kit.edu.kh	Hin Socheat	$2a$10$tZbgyQsrr20FEcg4Z6eSBO5xiYWNymX07MumnbEKyJFOoVwqfK80y	\N	STAFF	12345678	MALE	t	t	2023-07-14 12:21:43.832	2024-02-08 15:45:29.108
ffd69e2b-b0fe-4fe9-af6e-3ef8d75f1fbd	hun.pisith@kit.edu.kh	Hun Pisith	$2a$10$rHyGHboyt5gysMaepMcdg.60Knqizm6qT9TBl5qFqF4GeiBxxup6G	\N	STAFF	11111111	MALE	t	t	2023-07-14 12:21:43.837	2024-02-08 15:45:29.112
dbec9d85-ed36-4bbb-8464-88128c099874	masamu.kamaga@kit.edu.kh	masamu kamaga	$2b$10$yl01mqIPoxbSRDBhaj2gY.KQq.B5qMd1XGJ6hRdqk8.RdZU1REHRO	\N	STAFF		MALE	t	t	2023-07-14 12:21:40.98	2024-02-08 15:45:29.116
a3246906-ea72-4d4a-8beb-eb87463ae71f	monchito.avila@kit.edu.kh	Monchito Alvila	$2b$10$HgImwCOq74c4rGyNdcF9LuVLpjGBg3WTg4eMH5AVgt6x5h2Sg03hG	\N	STAFF	12345678	MALE	f	t	2023-07-14 12:21:40.957	2024-02-08 15:45:29.12
01c4eb80-f0d1-461b-82e3-460b5be13bf9	soksireyrath18@kit.edu.kh	Sireyrath Sok	$2a$10$l53iU.y.jpqfndLekjm3Ie5sdc5vfyNROd0a3iw1OhUNqKSJGRLD2	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.509	2024-02-08 15:45:29.124
8019ade5-008c-4a71-8279-58344df330d8	som.vansereyrotha19@kit.edu.kh	vansereyrotha Som	$2b$10$mWodUOB7D2aPcZGV/cdlcOiMzpzMv2UYTOvOLJQwEl5bxjBFhc/W2	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.397	2024-02-08 15:45:29.128
20d3564d-f976-4a0a-ad31-4d5cff6133ec	tyleapheng17@kit.edu.kh	Leapheng Ty	$2a$10$rHeNMa3DBXww4cHkMDJJ.OryEo3H/T/g7uLoE.3QCcpVSRHax9y4m	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.986	2024-02-08 15:45:29.131
04bd796d-e5d1-455a-b73c-956c8b855c6f	taichi.yabe19@kit.edu.kh	Taichi Yabe	$2a$10$8Qdr02bMnSO6qIz4FtGl5OYvi2J68XE94CR8ZVh6QrWfKFXePCk1y	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.748	2024-02-08 15:45:29.135
0306b3fb-0261-44d3-85c6-a3e11e1b3fce	masaaki.ogihara19@kit.edu.kh	Masaaki Ogihara	$2a$10$NOSndEvBU.A9JWctkglZleEFFvsIYs6m1XHIE2oaO8XB45F81IBiS	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.85	2024-02-08 15:45:29.139
03617242-6e4f-4696-9a77-1662b111b195	amcheachamroeun20@kit.edu.kh	Am Cheachamroeun	$2b$10$H0rWhPLxuYK39pVh8CxTAO7D115pUqugW9jh8DMCySLXMurWWFiDy	\N	STUDENT	78220698	MALE	f	f	2023-07-14 12:21:40.767	2024-02-08 15:45:29.143
383c3111-5303-47af-9151-2bb299f0eb28	ouk.sovannratana19@kit.edu.kh	Sovannratana Ouk	$2a$10$uysNNLAQylghVDMQQfjxR.GWSzLmPxqZTK6YwS8WVEwhyQfF0QXLC	\N	STUDENT	69397796	MALE	t	f	2023-07-14 12:21:43.219	2024-02-08 15:45:29.147
54d9eec5-e395-4bb4-98be-c9150b704218	chhun.sokhom19@kit.edu.kh	Chhun Sokhom	$2b$10$V1MNNL7iYtSrf.M5h0Wk3.o4v.1jMjXGTdqJ/Zlstu672yc8OSLw.	\N	STUDENT	86773398	MALE	t	f	2023-07-14 12:21:42.707	2024-02-08 15:45:29.151
56b4ea55-2c8b-4d8c-a6ac-4fe7ac8ac4e8	khoeurn.kimleng19@kit.edu.kh	Kimleng Khoeurn	$2b$10$rvh6i2Q5h5sxXk15zmuuiejcgq641Et6OMbsbG3MwxspWkbhAoBSu	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.054	2024-02-08 15:45:29.156
00e51059-cbac-4b69-8367-de4269873f20	lorssyleang20@kit.edu.kh	Lors Syleang	$2b$10$vr8lKbqL/ipSjyKG2CudqeeXkS5iF08BIooe7S3ssgRzc2f4kOeK.	\N	STUDENT	95425354	MALE	f	f	2023-07-14 12:21:40.917	2024-02-08 15:45:29.161
5b03ef99-0943-48e2-be24-789ce920d690	soeuntongmeng20@kit.edu.kh	Tongmeng Soeun	$2a$10$u..C2kwXfbBrRCDo94uiNex1doj7ERTtdoKHS7cxQzJyGyrU.AwdK	\N	STUDENT		MALE	f	f	2023-07-14 12:21:40.656	2024-02-08 15:45:29.166
d091f328-618b-40d2-be4b-d16c62854782	sovannrathanak20@kit.edu.kh	Sovann Rathanak	$2a$10$NDcAMKJTFKoOouGtk3wpuex2wiw1IT3UR9bsy.ArsrBENVxwRPxuO	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:40.692	2024-02-08 15:45:29.17
3a14a4c0-7355-4b34-af81-ba8cac6ed89c	chom.sreyne19@kit.edu.kh	Sreyne Chom	$2b$10$wsun.stf6CySawKShrmhH.rSMWgDRGDuwy6p./eS2cazgSO9vVnGW	\N	STUDENT		MALE	f	f	2023-07-14 12:21:40.9	2024-02-08 15:45:29.174
0425646c-9ef6-46a1-895f-d33603bd3127	pichreamarun18@kit.edu.kh	Ream Arun Pich	$2a$10$OSP.9jwB0cNay8NqnyXFC.rB2ewsHy4UcsoU9rwqjkH1DZ0p8VghC	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.329	2024-02-08 15:45:29.178
2272fb42-714e-43e8-b14c-918270ba814a	kaingsokheng17@kit.edu.kh	Sokheng Kaing	$2a$10$gMFqkF8aP4ppc28tQUifB.2O4.4FFCSSKgAYFPqaSwg/WsH9ukT0a	\N	STUDENT	15724031	MALE	t	f	2023-07-14 12:21:42.218	2024-02-08 15:45:29.182
21507fd1-9303-415b-8b09-a841252985d3	dgk16@kit.edu.kh	DGK 16	$2a$10$R304p7pcChT9RnCLPYY2juD/26/4ea7w26NtlEUSxWYcqWD5f9AU6	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.99	2024-02-08 15:45:29.186
fcefd6f0-be68-4cf4-8a3a-d12ba5498e92	pav.munyoudoum19@kit.edu.kh	Munyoudoum Pav	$2a$10$baWpwvGNvVvC9B.HkUQOP.ckXtTf5TtCA6wh1zrmfJniCeCuustpe	\N	STUDENT	98348273	MALE	t	f	2023-07-14 12:21:43.347	2024-02-08 15:45:29.19
8b8cadc7-89cf-4f9e-95f9-7912ff9ab44c	chhornchanpiseth20@kit.edu.kh	Chhorn Chanpiseth	$2a$10$LkBQeQZf9JHQklYpga5WnOd3enqbo6F1cfIFl6ay.XUJU2HwcEotK	\N	STUDENT	11111111	MALE	f	f	2023-07-14 12:21:40.866	2024-02-08 15:45:29.194
674d7726-13be-4908-94d6-17718dbab53a	keolythenghuy21@kit.edu.kh	Lythenghuy Keo	$2b$10$VUh4INzGYKF8mWRqUysOCeq4D0kARBMvnv6PWUHsNM3Ta4zLn1ZxG	\N	STUDENT	77790075	MALE	t	f	2023-07-14 12:21:40.71	2024-02-08 15:45:29.199
e272fe3f-78a3-45ea-94e8-d1ab98697bfe	samviraksedh.mak22@kit.edu.kh	samviraksedhmak	$2a$10$FFkgFKxBJQlqE0pePgjeMeNDpRZuG94uPQYGnJIHQRy5PLYs3vD0G	\N	STUDENT	9872223	MALE	t	f	2023-07-14 12:21:43.642	2024-02-08 15:45:29.208
eafc63bc-edd2-46e4-b96c-f3ccd9ea3056	seila.singhaktep19@kit.edu.kh	Singhaktep Seila	$2a$10$yL9FiQCkNMKHDm5Bl.WSwu.Nb1YGPuCtQXrEuXcfcDxdCtJRGJbCa	\N	STUDENT	78230802	MALE	t	f	2023-07-14 12:21:43.353	2024-02-08 15:45:29.212
f4349416-f1f3-4522-ac2f-69c363418700	ly.kimlong19@kit.edu.kh	Kimlong Ly	$2a$10$vnvYcyr7II7Hjc7yS2U9I.l2dtZZNlHcIhp6MfdpsH6ta1UKbsPnS	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.284	2024-02-08 15:45:29.215
f70c5fcb-29fe-4e62-ab78-61dea7e5fb51	san.vensuor19@kit.edu.kh	Vensuor San	$2a$10$Ek8PFoc5WlJw8lFOd9C7/ebjPU8zdW3tcyAckTBN1tlp1rjbR6Ayi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.44	2024-02-08 15:45:29.219
fe3945fd-36ad-44aa-acce-654cfafbc13f	chamnane.amnar22@kit.edu.kh	Amnar Chamnane	$2a$10$U/WCdJNxVOXX9q1JOMA/ke9MoESHw5AReBNqeruRr8/nbbToS2oGO	\N	STUDENT	2399999	MALE	t	f	2023-07-14 12:21:43.769	2024-02-08 15:45:29.223
ff8fb21e-a82b-45db-b723-b97889e8afc6	ong.sophin19@kit.edu.kh	Sophin Ong	$2a$10$CLHuzll60U5llreljTx/ceXwZZxQbMIZgKsLxPwG2KxYE0etFFnUO	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.208	2024-02-08 15:45:29.227
ba58637d-28d4-4069-81e1-de019afb713e	roma.mao22@kit.edu.kh	romamao	$2a$10$INEWY3DQqplfjQBCeriJ9.CM3u1zXpCLvOV5ZSBUQRyu98CM9/w6O	\N	STUDENT	9872223	MALE	t	f	2023-07-14 12:21:43.654	2024-02-08 15:45:29.231
bd7d50e1-2e4d-4b9d-8468-62a39411c051	chintey.ley22@kit.edu.kh	chinteyley	$2a$10$AUdfXL7tR9ixvQw4V2DQ6Oq9w9mWngH8I0ut67DJSOmYx3Rp4Ug3e	\N	STUDENT	99999999	MALE	t	f	2023-07-14 12:21:43.612	2024-02-08 15:45:29.235
bea8c7be-5b7c-4dc3-80a8-ee675895e13f	doung.ratanaksambat19@kit.edu.kh	Ratanaksambat Doung	$2b$10$IL6MkZOCq7gNVOmM.3n8R.zx3L242hX..u9aIYRO9zkXvoCTjKVA.	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.296	2024-02-08 15:45:29.238
c2f6dcd3-529d-4ca4-b84c-b83c633e3ce2	srun.kimleang19@kit.edu.kh	Kimleang Srun	$2a$10$cjqN7UzU5ZvIq3Z0EgmdTeu/7.h7zXI3EF2FEMLyND/cF4D/eyUDm	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.238	2024-02-08 15:45:29.247
d6401cf1-175d-42f9-b84a-5c4f385a9d93	chihea.oeng22@kit.edu.kh	chiheaoeng	$2a$10$5w6.2fTIiQx/3WJ8PrpOXuLJNfNtkWpnyev/20693iTcF4D0lVSym	\N	STUDENT	9872223	MALE	t	f	2023-07-14 12:21:43.677	2024-02-08 15:45:29.25
2b90ab73-32c6-4c3e-8605-d38ea2eaf3a6	layseaklim15@kit.edu.kh	Seaklim Lay	$2a$10$nCjYOrEw0rnvCIE/BqIV9OGbczoEV001GTLquk14Keo0v.QLOp.Am	\N	STUDENT	16807025	MALE	t	f	2023-07-14 12:21:41.625	2024-02-08 15:45:29.258
21774aab-0474-4c74-91c2-70edf00810f2	yunvisal18@kit.edu.kh	Visal Yun	$2a$10$kHS6jQ74tPPECfxXq00IsO9cxDPiSo1shFcNighHTZ3NFmx9qpiuO	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.933	2024-02-08 15:45:29.262
2a47f500-534d-451d-b4f8-97b54eaa7cf3	simchhay17@kit.edu.kh	Chhay Sim	$2a$10$x/sl3BnhQPsrG1wUEJJ3d.iLb3Yep8nTb.F5Rt7C6uh6Xal05QLYq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.116	2024-02-08 15:45:29.266
21ac609d-9873-4104-8af2-4c1333e553db	hoeurnghen17@kit.edu.kh	Hen Hoeurng	$2a$10$uRUvWZRpEVfN8wAmc8AD8eTowr793tTAXJfOmfz6e0tfeWpsk08xO	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.198	2024-02-08 15:45:29.27
21f07170-de4c-4e33-a4ee-c5b02662f085	junnosukekobayashi18@kit.edu.kh	Junnosuke Kobayashi	$2a$10$fDbc15DHI4pObWi/VC/Nu.3w6YpsU9SvgPtkBmURGekXFBdELF9M.	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.305	2024-02-08 15:45:29.273
22070504-b248-4794-9377-2327e1fa6259	chhormchhatra16@kit.edu.kh	Chhatra Chhorm	$2a$10$8Wbac1hiXZwjg5FB9p9qx.1.SodPsqaSv0gSBLSlnWY6yuuBVusGq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.501	2024-02-08 15:45:29.277
2abad29b-ba4d-4862-a4fe-5fb7c534da16	horn.senghong19@kit.edu.kh	Senghong Horn	$2a$10$V6mhExvj8Sy/YZp27Fjjze0gACuNLvIeYi6kqfLFisvXb6BJy00U.	\N	STUDENT		MALE	f	f	2023-07-14 12:21:40.912	2024-02-08 15:45:29.281
42b0500f-c9f5-4df9-8dca-525aaacdbf8f	thorn.laysim19@kit.edu.kh	Laysim Thorn	$2b$10$Qf2W7W0bqlo2Jn/AYXd7FeiHPzVcjXhYzH7B1tkuB9vkyYY5KUtKu	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.131	2024-02-08 15:45:29.285
2e625bc3-51dc-46cd-b39e-600b0730806f	tanvengtry15@kit.edu.kh	Vengtry Tan	$2a$10$kQqlhxGQXz8s7hfhWE2gI.sCvR8DJ5cJ48aV7ZIXLrK0FqOetjNR6	\N	STUDENT	69490344	MALE	t	f	2023-07-14 12:21:41.248	2024-02-08 15:45:29.29
2f75b41b-9b4a-499e-ba74-1a9535203e2f	noupsovan18@kit.edu.kh	Sovan Noup	$2a$10$Z38haJdBIenwYwivPqOC7ecM8b0mo5/5PlXmIeT0EWJe435tw/PQm	\N	STUDENT	964794954	MALE	t	f	2023-07-14 12:21:41.4	2024-02-08 15:45:29.294
35a8e5c0-aa3c-41e3-80b1-8a1582432650	chhengsodavin18@kit.edu.kh	Sodavin Chheng	$2b$10$gakiTqL6rFzlmDoeFXfuaOPkHl23eR5QLYBk2eptHAApQ0tDc0m/i	\N	STUDENT	77977197	MALE	t	f	2023-07-14 12:21:41.419	2024-02-08 15:45:29.298
42ece2f2-7ba3-4b10-9e4f-65d472be87a2	neuporng18@kit.edu.kh	Orng Neup	$2a$10$tk.6H/Z.Zws/fF4E3GsZAumi3fPTz/eoKKAXrcGFX1Z.Ie.2u882C	\N	STUDENT	11316491	MALE	t	f	2023-07-14 12:21:41.464	2024-02-08 15:45:29.303
44db78be-05bb-40b2-8e09-e8fb5a650513	promvisal16@kit.edu.kh	Visal Prom	$2a$10$TRlN487bH.ZFKtWRvLELlOjUto4.tGk64KIQ7nyQ4aDNgsGQqh69a	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.515	2024-02-08 15:45:29.307
154182e9-ed42-4361-aac5-92ca90d72b73	eishinono18@kit.edu.kh	Eishin Ono	$2a$10$j/x/0S4UuU.jeQKcHVFqYuncRzpra0R4vtVIaYhwdrMK4XEjagJTS	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.619	2024-02-08 15:45:29.311
2e20be61-3a29-47db-b5d8-aa8806ca08f3	thepanomratanawan17@kit.edu.kh	Ratanawan Thepanom	$2a$10$FpH2LN2zD2VeO2GG4Q9yJOxycorNeNdnVIW2n.5zEYNobMjoiZngK	\N	STUDENT	81747980	MALE	t	f	2023-07-14 12:21:41.692	2024-02-08 15:45:29.315
37efb265-acbb-4979-ac31-123e0c80ddc4	yinmazatin16@kit.edu.kh	Mazatin Yin	$2a$10$DI3/CUFdxjD7rNWiTC8zlOh16YFXrt0SMzB8kR5analqSW/1rT4Ba	\N	STUDENT	86683137	MALE	t	f	2023-07-14 12:21:41.796	2024-02-08 15:45:29.319
2d79aa6d-0078-419d-bf33-dbddfaf33387	vannnary18@kit.edu.kh	Nary Vann	$2b$10$CpSnZ8YWkwAzNUN/nQOl.eD1EotUzAPYMi5qTHYmh4jlpQ4VRs1De	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.829	2024-02-08 15:45:29.323
43891e21-8acf-40ac-ae80-831559b8dc65	hengsenghak17@kit.edu.kh	SengHak Heng	$2a$10$lcCrqcRsZ6DW4bpOmTH.2.7LB5EAw33JYS/gyRQh7dheFLBUp1Afq	\N	STUDENT	77818325	MALE	t	f	2023-07-14 12:21:42.035	2024-02-08 15:45:29.331
3f1cd2a8-dd19-4522-ba1d-923fe1fb8a62	nakponler18@kit.edu.kh	Ponler Nak	$2a$10$XjL/MLem2CA2wvGrjJaNUes6UdB9RudBMWV793eiZnAkuguuQ2c5C	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.299	2024-02-08 15:45:29.336
3b2e498e-fd04-40cf-8e7c-7d039c4956cb	sousocheat16@kit.edu.kh	Socheat Sou	$2a$10$eMqhFLUTKUMhwKcxPeFnQOuIHZpqE6ZmeWJCphi4rJjz1880Y2gpO	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.31	2024-02-08 15:45:29.34
350ade1c-1401-4624-9019-3d4af7cd58ef	sinsovannmony18@kit.edu.kh	Sovannmony Sin	$2a$10$oj4wQuRaxGK7PsPYAl295.LGOGB37x6Tc5lD4ha7KphBEO.Msodny	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.34	2024-02-08 15:45:29.344
32ff48c2-2599-4617-90c2-3a708c42b1c0	kuochariya18@kit.edu.kh	Ariya Kuoch	$2a$10$9gJYJNRkSYlQvfXnu20G4e3O7hht0D8KrdzVoiCKZhXz.4tBpSq/m	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.347	2024-02-08 15:45:29.349
34ad3d09-04c4-4742-8d0e-636c9911b705	khengchhaya18@kit.edu.kh	Chhaya Kheng	$2a$10$sZ80LDeRtBQBIxaxS4/9uu6G9FeWaIERAlZ5h63rzTqrC33uWG016	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.365	2024-02-08 15:45:29.353
3e2d9e10-bd31-4ea8-9a34-52c1266f4039	yusukenakayama18@kit.edu.kh	Yusuke Nakayama	$2a$10$MDkFWlkUee6.sUa2ssjhtu1i4qczIyzx/.AasOKn2pZo7kz8G7HFq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.452	2024-02-08 15:45:29.357
43cd46d6-f192-47eb-95a9-a2783f5fac92	ryuji.kokubu19@kit.edu.kh	Ryuji Kokubu	$2a$10$rpCEovyuvbFfg9nf3RUMfurOOY1Ue3Oc8.5Cc6BxhRGj98DyogF6O	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.724	2024-02-08 15:45:29.361
3dee8ad4-59e8-46ae-bed1-a8f59833854f	saosophea18@kit.edu.kh	Sophea Sao	$2a$10$d7Z9nRYpaPnPqz2J0vvd9OWAArQI8i0VU.bvJWBdst9.pm5MHLj1.	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.801	2024-02-08 15:45:29.365
438a6d7e-5dc2-441e-aff7-ad842ffd5601	ryuji.oda19@kit.edu.kh	oda ryuji	$2a$10$30RURg/t9NhuZ5K0vDtWMek8lG3OlO0wbaiZiWOAjFWPnzUliLnb2	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.096	2024-02-08 15:45:29.368
345747ac-20a9-4fb9-b6f3-de41ba7213aa	y.sreylin19@kit.edu.kh	Sreylin Y	$2b$10$vmCPrwpbpvR9wZUlBLWtCuJxY7Th5S52wp22u87IHmumbK6.avs4e	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.13	2024-02-08 15:45:29.372
2f4605f7-ddc6-4ef8-bf83-667e575244d0	sinawatra.rith22@kit.edu.kh	sinawatrarith	$2a$10$ykB7nz0pqpqSdCi4VSY9keQ4NwKXaLdN5KCyUODfwy.jyEJ2hPpnm	\N	STUDENT	9872223	MALE	f	f	2023-07-14 12:21:43.688	2024-02-08 15:45:29.376
2bff25a8-9c04-40f2-9d52-dd8d09f8aac8	chhornkettesak20@kit.edu.kh	Chhorn Kettesak	$2a$10$Uhpb1dwBlz9tyR8C0EQve.fcCqfuJyiFTNiOhF3Ofc8joMwnB/IeO	\N	STUDENT	15823298	MALE	f	f	2023-07-14 12:21:41.084	2024-02-08 15:45:29.38
4e8153e6-4c71-4d15-b72e-fd65d45479f8	sroeun.doungchan19@kit.edu.kh	Doungchan Sroeun	$2a$10$tzTIrc0VrJldkKFGg522HuIHngGwnmcV2QLgfd8Zcp7EeivwXtVPS	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.172	2024-02-08 15:45:29.384
5129abd8-993e-4563-8cc2-f945499fb3aa	limchanpiseth18@kit.edu.kh	Chanpiseth Lim	$2a$10$f2rjC.i04aJVRR5m6sSlO.th0kEjMeqqfbKLShjHW2jcoJS/PuqNa	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.389	2024-02-08 15:45:29.388
582fdf42-de6e-41e4-beef-46fe797ed1ef	saysovannvathanak18@kit.edu.kh	Sovannvathanak Say	$2a$10$tMdtGF6IzTD7hiMuUVI9YertEQDZkzmdn50cpqcjndsx1r1vTPv0e	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.395	2024-02-08 15:45:29.393
48ee8906-aece-49be-a59a-db2b1ae25841	kimsereyroath18@kit.edu.kh	Sereyroath Kim	$2a$10$4S.dClwjDir/JHjk7MH9o.NyIk/rfJwvT9o.zCYQv8lQ/dMSr6W8S	\N	STUDENT	77705982	MALE	t	f	2023-07-14 12:21:41.498	2024-02-08 15:45:29.397
54e4ed17-c3b3-4f81-8f8b-95faee88e66f	senglongha16@kit.edu.kh	Longha Seng	$2a$10$bDXNrS.JPBUYBij8tKoarOs3zzrq58sCILSzHDNvHKhRhIToTaC6O	\N	STUDENT	86949421	MALE	t	f	2023-07-14 12:21:41.503	2024-02-08 15:45:29.401
50b9735e-be7f-4080-99c6-b06ff68726a7	hychhayrith17@kit.edu.kh	Chhayrith Hy	$2a$10$dF3HU600qU1/JwMtrkFK8uyHRKorGPUyO.fFMM453NYAdA0BiGSqi	\N	STUDENT	86642814	MALE	t	f	2023-07-14 12:21:41.709	2024-02-08 15:45:29.414
4d68016f-90a4-4416-a830-e34d4ccc4170	nwmonitoring14@kit.edu.kh	Network Team Monitoring	$2a$10$ZXOsb7B8cJbdVudItr5UKeX11.VabxDbsl15iwlfIreUVKI/kkCfG	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.964	2024-02-08 15:45:29.418
e9995766-fc8f-4b2d-bceb-543a6f46e065	tankimchhun16@kit.edu.kh	Kimchhun Tan	$2a$10$4SxPA0cXGd5Bl7zOBvy/duEI8YzfQjvsCZ1nSZnazinhRoXxCbBgW	\N	STUDENT	98952337	MALE	t	f	2023-07-14 12:21:41.253	2024-02-08 15:45:29.422
e79a3ad1-0a3f-4169-86e8-11111ec99d07	koeurnsereyvatanak18@kit.edu.kh	Serey Vatanak Koeurn	$2a$10$0TBr3k507ioQ8tMIHiNOBexb8aQHyoTh1.ya1tKGdv1cKMSwDKpq2	\N	STUDENT	886297000	MALE	t	f	2023-07-14 12:21:41.342	2024-02-08 15:45:29.427
e7afd0a7-9b47-481b-8071-3e96863dec0f	hournsovannara18@kit.edu.kh	Sovannara Hourn	$2a$10$P5tKTDojGYStktM6ycnhYuCbX/uLVo2tEHbKTEowqulsxKUehj2km	\N	STUDENT	15958841	MALE	t	f	2023-07-14 12:21:41.842	2024-02-08 15:45:29.431
e92200a0-ec86-4e71-a78d-fc419e813bea	kimmiratorimoonlight17@kit.edu.kh	Miirar	$2a$10$.p7TBQAPrsT/ctBnTC61iuC98M.95.kdKXArDPU1Coso8zFBuiMcO	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.909	2024-02-08 15:45:29.435
05b57ebc-2271-4847-a183-ba6efa50363a	chumdanei16@kit.edu.kh	Danei Chum	$2a$10$Y8CtDy6l2ppRqo0Caa6DJuFZ8JQdjB0zZY2iiK1uahAAxMGA52VB.	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.389	2024-02-08 15:45:29.44
e8c991cd-6d98-40fa-8e81-7e0a53e03abf	ly.panha19@kit.edu.kh	Panha Ly	$2a$10$C2.NXG7E7v6ynHOvs7bsgOaQv1Iq7ATnt3UpNg4zeUWC/dKc4EHtq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.463	2024-02-08 15:45:29.444
53658cf9-bb07-485f-abc7-16d20eaf07ff	subtam14@kit.edu.kh	Tam Sub	$2a$10$FH82XkNQ8/CRvehUuot1fuXKyyjv/XMLvzIgYjb6kxx2EjJloaVGi	\N	STUDENT	70405405	MALE	t	f	2023-07-14 12:21:41.659	2024-02-08 15:45:29.448
5414f3aa-5ea3-4b97-88cb-1e4acdf996c8	sun.kimhong19@kit.edu.kh	Kimhong Sun	$2a$10$T2Tr3PMsTrZshHjCtolohOFMPPEerdC8JC9d6on/VXdCFU4Sf54je	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.055	2024-02-08 15:45:29.453
491228e7-2318-4043-b9ef-77057fac95c0	ou.david19@kit.edu.kh	david ou	$2a$10$/VZiQSQDddkWezCs53CNueVarCUk3meOjuTxjnlH9iR/jlo9Lzddi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.079	2024-02-08 15:45:29.457
52af29ed-cd46-4691-be09-49a342ee1663	ny.sopheaktra19@kit.edu.kh	Sopheaktra Ny	$2b$10$t9IO7TVRk/yfwa3aFy6YFOdKPbz3rJY.nmgDkuMPIccL/WptHntjO	\N	STUDENT	889345080	MALE	t	f	2023-07-14 12:21:43.107	2024-02-08 15:45:29.461
45ad5059-250e-4525-aa66-eb95d21f165f	nhaem.noynith19@kit.edu.kh	Noynith Nhaem	$2a$10$gPPtdzo5LSWStGDSb6aCyuSnD1M49COPe1VfHPyDOVjjUxDGwc9Aq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.136	2024-02-08 15:45:29.466
45eaea86-0169-47ec-8e9e-ebecccf3fb23	phal.norakrattanak19@kit.edu.kh	Norakrattanak Phal	$2a$10$QkzZJRGlk8mVZg4/vxvemO76bfCa99jj/783vCNPwxJTihWQ.T886	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.34	2024-02-08 15:45:29.471
465f7607-be54-4947-90f1-aabf4355d623	hengratanakvisoth20@kit.edu.kh	RatanakVisoth Heng	$2a$10$or83hiFHiwe9g2PVhHlccesZokD7NZLWE3.L3m8yHYG3jhfV4FjLK	\N	STUDENT		MALE	f	f	2023-07-14 12:21:40.807	2024-02-08 15:45:29.475
4c1811c9-6345-4b6b-bcf1-5ff05f2a98f5	akihiroohtani18@kit.edu.kh	Akihiro Ohtani	$2a$10$HRqaF6ZcgVKSgsPtuB/WO.3gWG82gf2pFVbxrltpjDoNOVAtHITrW	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.979	2024-02-08 15:45:29.48
50b4cef3-bc47-4e07-bad1-7507cc16a3fb	henglongchhay18@kit.edu.kh	Long Chhay Heng	$2a$10$THm/KNi/i4sy1RyfP7DeEet7OX8Kmufzvp44Wu9KdCA2eLwr5Fzfi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.204	2024-02-08 15:45:29.484
4d2cbec6-ff18-4182-aecf-0e2902b6970f	lotratanak15@kit.edu.kh	Ratanak Lot	$2a$10$sbAXonbyN8cejNj48Hc4mOXeCxsYUGOxTZrAEEcghzjNwwSoFOJ1y	\N	STUDENT	886025859	MALE	t	f	2023-07-14 12:21:42.545	2024-02-08 15:45:29.493
4f2def71-ee2d-4134-9838-9b40dd35768d	sathsovireak18@kit.edu.kh	Sovireak Sath	$2a$10$4dya5/dOWERGT88RT6AhzOdG0HothD6KcmCF0YoVTChcTu/Z1Ul2y	\N	STUDENT	10898645	MALE	t	f	2023-07-14 12:21:41.607	2024-02-08 15:45:29.498
585715a2-94ee-41d7-bd73-70259f4ae918	hunvikran18@kit.edu.kh	Vikran Hun	$2a$10$3SiEmK96eQ3LdtyfmEkBQeeWt9vKm9tYnVL8OwqqgpEngfAgzzf8m	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.592	2024-02-08 15:45:29.501
4e0873f6-f934-4410-b6e8-aa604b7341b5	tomofumisuzuki18@kit.edu.kh	Tomofumi Suzuki	$2a$10$RlT8Ope9WUyU5GcshV1XE.0lE3zfoHZNwFM/RUAXMTTrXzVsMUk6u	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.649	2024-02-08 15:45:29.505
4ce9c4a0-0072-413b-ab4a-5c2b5921e943	misora.kanbe19@kit.edu.kh	Misora Kanbe	$2a$10$LA3wGBGRc7R8iuJja6JqVOn804RWAbYE2qKtgS/LX/u1vocTYknUi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.788	2024-02-08 15:45:29.51
61537699-3d20-4be6-ac2c-57d3b0ce81f7	chhormenghong17@kit.edu.kh	Menghong Chhor	$2a$10$LCOxBoqbVeCEe0Iy3TA46OmA0dKau5H9Nb5EpDqI5xelWfryotqNi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.698	2024-02-08 15:45:29.514
6fff7783-bc6a-414c-a045-a62c3d4fa86f	teavengtieng17@kit.edu.kh	Vengtieng Tea	$2a$10$3V5bATEI.kmIZDB2FtFrKOEukfQW7UO6IxAdWr.k/T2HNdx536j4.	\N	STUDENT	16326151	MALE	t	f	2023-07-14 12:21:41.703	2024-02-08 15:45:29.518
725e988d-6780-47b2-9b44-f83af2c3fca8	somtola16@kit.edu.kh	Tola Som	$2a$10$LYq..GT4lfryIi3LRWRS2uUesaXFwk1GtqGTOqYQ5ZkIqod9k4woq	\N	STUDENT	98590252	MALE	t	f	2023-07-14 12:21:41.721	2024-02-08 15:45:29.522
6047e9d3-472e-400f-8782-05c80f0c6771	sayching16@kit.edu.kh	Ching Say	$2a$10$j.GP5yB2FBAPv8fW7kUKHuxQ3.Se8tU4/g9ElT8rJadkHxMo8yJvC	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.756	2024-02-08 15:45:29.526
6568987d-a559-4d06-ad69-0e896a0b018f	hengkimhak18@kit.edu.kh	Kimhak Heng	$2a$10$53f0UxRcUyDzYUxWDVJ6kuCqXeBtKprcEE7OwYh8zA5SFOEx5R3tS	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.854	2024-02-08 15:45:29.53
737dde79-444d-4d48-a4fe-da59e6007523	tengseavpor17@kit.edu.kh	Seavpor Teng	$2a$10$W2dObYhg3crVhUqOYwS6QeeN.pjG0rdaIMns0W5jOfj3gYfbZORY2	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.06	2024-02-08 15:45:29.534
6e8a7863-21b7-48cc-9905-509117fc9c5c	pengputheareak18@kit.edu.kh	Putheareak Peng	$2a$10$xkqvyIjGu/MTHzg3DyTczOH9QeXOsGKrfCQ829V9y9FuY3N/5a2Vq	\N	STUDENT	17676790	MALE	t	f	2023-07-14 12:21:42.085	2024-02-08 15:45:29.538
68b31f1c-5810-4548-bae4-262f5be1a193	kitbunrong17@kit.edu.kh	Bunrong Kit	$2a$10$WWa9HYTo0RN9cK5CJKCKUO/945Hw0jEeMMrXCDHrvzpCgG.MMFkm.	\N	STUDENT	963757475	MALE	t	f	2023-07-14 12:21:42.248	2024-02-08 15:45:29.542
675ddc4e-7100-42cd-acb2-2a951e5682aa	narethmarchvenmey18@kit.edu.kh	Venmey Narethmarch	$2a$10$l7ntzSn7JCy7Fcntlw5TGelUvduyE3a1vVMyFmQzNQ30sB6RICk5K	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.276	2024-02-08 15:45:29.546
666c8c03-420b-4353-b1f2-59e458deee90	thaputhsopheak17@kit.edu.kh	Puthsopheak Tha	$2a$10$wNLjb.OPAW2TodxePWcecux3B8indEO63TDOCQIL.tnFSFKwIawri	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.293	2024-02-08 15:45:29.55
725755a1-0c93-45e7-b75b-a42a411bd255	sreanponleu18@kit.edu.kh	S.P Moon	$2a$10$YNUIp7o39/yJm0GZj/vQLOvVUppsyo0Fz5a8WWyJiL7P0hwFcoWK2	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.685	2024-02-08 15:45:29.554
602c5c6e-a9fd-4060-a215-31263c6911b3	riku.tanaka19@kit.edu.kh	Riku Tanaka	$2a$10$f.Ziws8H6cEzsQmiJBobEOb1wco1JRLLdoS7XgbQ3nXSBQLm53Whe	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.829	2024-02-08 15:45:29.558
5921ebe8-2aa4-4af9-a470-0c06103aa6c8	phalla.borormey19@kit.edu.kh	Borormey Phalla	$2a$10$RuokFHvuf3xMZMYqChYft.WtlNzDwpqCbtbM0uXaMK2j1mVPSC18u	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.549	2024-02-08 15:45:29.566
631cf878-508c-43fa-abca-0879653194ba	sokheng.soeng22@kit.edu.kh	Soeng Sokheng	$2a$10$61rAJhhJOq.0YAlRzUgxEODy2WA7TCaeq4JxoLO.Uucni32pdh1xq	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:43.718	2024-02-08 15:45:29.571
66d97dda-fd2e-492d-8146-ca9512ac0e01	doungkolbondith18@kit.edu.kh	Kolbondith Doung	$2b$10$wYzdpT5wrWwjuV4vEzl6W.dnPf3johWI91A.JflCggG0cPDLZGL7W	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.458	2024-02-08 15:45:29.58
81b84d2b-2889-4b56-9e5b-1045ab659bad	yanchakreya15@kit.edu.kh	Chakreya Yan	$2a$10$zin1roLDlw6YH4kXKrgTDuV9HJ5t18k4Xzt8r0gXkUvM6E0Q7gTwK	\N	STUDENT	965171375	MALE	t	f	2023-07-14 12:21:41.714	2024-02-08 15:45:29.584
8089758f-83f2-4552-875b-9bf8d2220e45	angsivhour18@kit.edu.kh	Sivhour Ang	$2a$10$D7MMQl8z.zxXX.wcbEzrqOhV.1NOdsgt0s54.JI6pexYNwkhHUE16	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.773	2024-02-08 15:45:29.592
76d4f04c-9ff4-499a-b337-59901006c0bf	sambovisal16@kit.edu.kh	Visal Sambo	$2a$10$C9SU7DkWe/Z1XHldfrTWBeV24Ma/Q31l425jUHJa.ymKed4QIe3z6	\N	STUDENT	10243263	MALE	t	f	2023-07-14 12:21:41.818	2024-02-08 15:45:29.596
84f9dfcd-6800-4900-bd25-6cf3ff55f7f4	pongchanny17@kit.edu.kh	Channy Pong	$2a$10$OzJ.Qe8jY4tQbQxuHCjAleHrq8QU8yBZNoTnwAHlQ8yP4IEQ4TgnS	\N	STUDENT	977219101	MALE	t	f	2023-07-14 12:21:41.883	2024-02-08 15:45:29.6
7ec25321-54e2-4536-a2b6-7fc02f107a7c	ingnoroleak18@kit.edu.kh	Noroleak Ing	$2a$10$92BvzxK.Pr15xP1IHSGBIuir7sV7e47xOczNyp4FlOcQ/.5gV1HUi	\N	STUDENT	77950102	MALE	t	f	2023-07-14 12:21:41.889	2024-02-08 15:45:29.604
75e6991e-1f5a-4952-8eab-82752be30210	sangsonyrath17@kit.edu.kh	Sonyratt Sang	$2a$10$FvpBc/ZcW5puB3eJGNyUOu/r/X4NPWiWYdgTMTrZRQDawLFwUdxjq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.192	2024-02-08 15:45:29.608
7a6c5868-9ad8-482a-802b-2427728fd2ad	soeunthynasothea16@kit.edu.kh	Thynasothea Soeun	$2a$10$sdifRJMfIR56A0TJHfdN0uJLZ6tcuzHu51N.ubMMS8TtvmUTOdJyu	\N	STUDENT	15804675	MALE	t	f	2023-07-14 12:21:42.26	2024-02-08 15:45:29.613
83d65a7a-517a-4fc8-81d0-c164f397e0d7	bornsothanak18@kit.edu.kh	Sothanak Born	$2a$10$Nj9dtx3hiAMqJzXSRtcp0OwTsdyQVsjIhs.u2O8tcizKBgV86aCyq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.333	2024-02-08 15:45:29.617
7bb07689-1d69-43fe-8f08-9c2fcd7e3c45	pavvanchhay14@kit.edu.kh	Vanchhay Pav	$2a$10$zJdi1ruua3SotXY/UttgAOJ3UrE/tRcw/1NP1httiinZQU/9K93pG	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.518	2024-02-08 15:45:29.622
7fbc3b89-0f1f-4691-ae81-1e70b1be9733	tasuku.nakagaki19@kit.edu.kh	Tasuku Nakagaki	$2a$10$oqSXHhudu4cl6fuSreyQFOl.z4yZOyxpM3vbMEWg/hb4xK/TZfPHK	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.719	2024-02-08 15:45:29.626
7cceb40f-56f0-483c-a5bc-e88c69e0e5e8	kay.sothearo19@kit.edu.kh	Sothearo Kay	$2a$10$x933bhrFrGlBOM/mA50wv..JWoIY8E1fXZVCn4QkO3nD5MZxmrffi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.043	2024-02-08 15:45:29.63
7f9552a5-bdc9-44d4-9d14-499b93737a24	phoung.bunnet19@kit.edu.kh	Bunneth Phoung	$2a$10$AcJeqilPAbL3pDpIjJobp.cN9t7jNrh2t8M8waIOO7tw.83BYm8Qm	\N	STUDENT	93479792	MALE	t	f	2023-07-14 12:21:43.073	2024-02-08 15:45:29.633
7a68a7ae-719a-4c74-9b3e-315616e8dbe7	ly.sreylin19@kit.edu.kh	sreylin ly	$2a$10$osi3/QwSYnbmW/lyMcI9ZeCSqBwPlG2Wrds8jTCHw6EM1zioogyOy	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.084	2024-02-08 15:45:29.638
853659fc-368a-4842-85f7-5051aabf91a3	kung.leakhana19@kit.edu.kh	Leakhana kung	$2b$10$arEZ8SiDwydcWDrgEOj.GOeUnajjKekSVUpXM9AV2LAvX9w1sGejy	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.118	2024-02-08 15:45:29.642
84007ba5-b897-433d-a764-4f5be9ac2931	yong.vuthivann19@kit.edu.kh	Vuthivann Yong	$2a$10$zvwrmvbghaJ7iZWfLTQldeZ9szbDxgcYHvaY2TsTg68twOE82jtrO	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.144	2024-02-08 15:45:29.646
75710a8e-ba2c-4fc8-8136-b6da6640e55c	hak.vichet19@kit.edu.kh	Vichet Hak	$2b$10$tDoitxO6Ohda6lMCC/NKIuuO2fqL0iphQ.THXv0XA1Y.Ab/Ab3VPq	\N	STUDENT	969403861	MALE	f	f	2023-07-14 12:21:43.156	2024-02-08 15:45:29.649
760d3855-65cf-48a8-b2fd-42fc02435802	khiev.boraty19@kit.edu.kh	Boraty Khiev	$2a$10$vjvg5KVIO6fnMApSUV6u3OPMuqPGqTNqHSc.3Ew5uAHNeVvs0TPGC	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.31	2024-02-08 15:45:29.653
80ace21f-1eb5-4e08-b5ad-e6a9a50b977d	kao.kanhchana19@kit.edu.kh	Kanhchana Kao	$2b$10$EcvEyrNuImBPDFwA7dl8WOoJRkgh7YjphDQ2Gz0b4gKZyoSYKKjUy	\N	STUDENT		MALE	f	f	2023-07-14 12:21:40.895	2024-02-08 15:45:29.657
58d9a9c4-d1b1-4f92-b9ec-0c7bf3d6354a	engsopha18@kit.edu.kh	Sopha Eng	$2a$10$xIZcmCi1iZTfg/2PnjIAoeE20JTiLwZXbs57OWk3xESBi2BCIFglW	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.406	2024-02-08 15:45:29.662
9154771c-4d31-4d1e-a48a-49c10802ca7f	kongpanhabot18@kit.edu.kh	Panhabot Kong	$2b$10$uZLvsf6qfUUk86/596j9jeQJVTRrAE5/vshea5wAAvB6b6X8IcP3e	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.789	2024-02-08 15:45:29.669
3122a21b-9612-4ed2-9b3c-25ba9f24e2f3	heng.voleak19@kit.edu.kh	Voleak Heng	$2a$10$GmwnamZRo4xlkUQDOWvLYeR/66fF.QpLc.sBjDzXTA0kmF.zgu.LK	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.174	2024-02-08 15:45:29.673
92c8d939-ec6d-4671-9210-656fc5ed58fa	sempeseth18@kit.edu.kh	Peseth Sem	$2a$10$MyEF6SIb8WCKxhf.nwxFkeIEPLXw0ebkfEkkuYdfSotMKDUjNaC8S	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.647	2024-02-08 15:45:29.677
912eb30e-5cfc-4f48-99e0-fad19da55344	setsamnang17@kit.edu.kh	Samnang	$2a$10$zqEXuhRY0dSNOk6bud1e2e3b0DJTQz7DmPSk8T.P2GsrpEubXYREm	\N	STUDENT	966192224	MALE	t	f	2023-07-14 12:21:41.95	2024-02-08 15:45:29.681
97e170b2-335c-4023-92f6-587af53cd966	varathana15@kit.edu.kh	Rathana Va	$2a$10$0DSMO30hZYXAXlvy9c62R.gYa2CR3286CHspnhBpuxGsDNTmF/1fK	\N	STUDENT	964568559	MALE	t	f	2023-07-14 12:21:42.181	2024-02-08 15:45:29.686
9080eec3-4743-480c-8873-e259b73064f5	cheanataly17@kit.edu.kh	Nataly Chea	$2a$10$z73JJNtbMavUAcxghf.ZrugHNI6mUmkCDguCLOShiZFaouo0Bfw8W	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.322	2024-02-08 15:45:29.69
99e6d9c3-c00f-41f6-ad3b-069d662f61c9	hoeurnlyhov16@kit.edu.kh	Lyhov Hoeurn	$2a$10$ZA/xOCFbI75fQ6GZFgxPeu.BHGNtxeUSluCrRrvBCZtWBMmtG2U2m	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.395	2024-02-08 15:45:29.695
8aafeb43-bc26-4669-bd7d-011b12bb8e0d	samvisith16@kit.edu.kh	Simon Sam	$2a$10$I3Gg/iAJtFba1p3wTjOq/.6pSRYlFvnOr5NB89n3tLj2xFc4ZuuNy	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.436	2024-02-08 15:45:29.701
9072e4f4-6e31-49c2-b840-c46f883486fb	rei.hirashima19@kit.edu.kh	Rei Hirashima	$2a$10$p7l2CClQsd3PihIPVS2ud.CBGRPEQ5Fad.lcHFT1.UhMj/QMUqjKK	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.76	2024-02-08 15:45:29.706
9431ef83-8a15-40e2-9192-2f35d3083d44	seiji.yoshitomi19@kit.edu.kh	Seiji Yoshitomi	$2a$10$PdhMREPQ4Qydm4YVy7Smt.Yyv4/UiitX83nGN9KjOz/XVuUhy6cru	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.765	2024-02-08 15:45:29.711
8c1c6cde-c437-4611-8b85-f59c04db9912	kenphanith14@kit.edu.kh	Phanith Ken	$2a$10$zzuWg.UGZmz4jgcMYeLaweFgmsynB4ZkObQe4RsK4JjV/i3fs7OvS	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.995	2024-02-08 15:45:29.716
9be28166-b7a4-4010-8a06-d795c2c1bf55	phansokrim14@kit.edu.kh	Sokrim Phan	$2a$10$fbpt8XIsWFT0DfTZfLzBleQKAuPDhRCIYxL0NUa2297vcRwgkt7uC	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.018	2024-02-08 15:45:29.721
90fd8c72-8999-403f-9bd4-7436d2af4c6a	phon.soklin19@kit.edu.kh	Soklin Phon	$2b$10$gyXIpwBZJwCILwzwE5H7TOf6FH/zeU0hNQC.m7vgaVO/FjWJr0rG.	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.101	2024-02-08 15:45:29.726
9a321b09-11ec-4a90-9504-759e9a3269ac	bun.ratanakvichea19@kit.edu.kh	ratanakvichea bun	$2a$10$4vbseUFYC.boWJ4IQz./BeY4Ub6BHq5zIwY83ooUiEbndQkda3ouu	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.123	2024-02-08 15:45:29.731
8c01a18f-fda9-431a-aa89-b45f95af5470	chhuor.thaisan19@kit.edu.kh	Thaisan Chhour	$2a$10$rPlut2i95Sx8WvvZ5oIXx.d.tjH/fNYRG6kEQ.7Uolq/Bj.yWZTUG	\N	STUDENT	15466006	MALE	t	f	2023-07-14 12:21:43.162	2024-02-08 15:45:29.735
875188f6-51d5-44db-a801-0969bce3b98d	oun.visidhreach19@kit.edu.kh	Visidhreach Oun	$2a$10$WT/9i9FEoHbiPLx7HROuceVq6qVWjFXHWCLSFTr7ErmsRngCKMFVi	\N	STUDENT	969264455	MALE	t	f	2023-07-14 12:21:43.366	2024-02-08 15:45:29.743
aafe306c-2d6c-4df8-9464-a9bc9f681f78	kornpisey15@kit.edu.kh	Pisey Korn	$2a$10$OKh9rOKGBRH0sheM2TD1neMhujPSa7rqU.7mlgL8kJ1uFDb8gFthC	\N	STUDENT	969000093	MALE	t	f	2023-07-14 12:21:41.859	2024-02-08 15:45:29.752
acdb145e-9f27-4bdb-adfe-dd25c9435498	songrithy18@kit.edu.kh	Rithy Song	$2a$10$/Co7oECOqHerfK55Z35AQObZAk9D4tLcVPFGXTsQMg7Dr/X1Yk66O	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.871	2024-02-08 15:45:29.756
a8ee57ae-be9e-4bcf-b025-4abc96e45d65	chreachanchhunneng18@kit.edu.kh	Chanchhunneng Chrea	$2a$10$5Oo9mwaLxyvukT8XAt0q2O5Kh.VDNksmPFaDm/8Qw5UpcLnTaCpbK	\N	STUDENT	70339911	MALE	t	f	2023-07-14 12:21:41.877	2024-02-08 15:45:29.76
a494d500-0933-4fcf-9f21-db5ff4287248	chheanpisethpanha17@kit.edu.kh	Pisethpanha Chhean	$2a$10$VtiD.WpcS4YQXi5Yh6Cd5eyknyte5aJK2T8MabB8IKi5wbnNwx/Oe	\N	STUDENT	98789838	MALE	t	f	2023-07-14 12:21:41.894	2024-02-08 15:45:29.765
aa86b955-0785-4d04-b3e0-a08408d6b0d4	yisisovattra18@kit.edu.kh	Sisovattra Yi	$2a$10$dT.ObHN2x7kRjbq8MuzCnOfioZ3hdjcdZ7q9CE50Qz6.1/BQuJRUS	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.004	2024-02-08 15:45:29.769
ad699d2d-fa80-4cae-b846-22461fc6f637	vansenhengmeanrith17@kit.edu.kh	Hengmeanrith Vansen	$2a$10$J6vHTd.t15srXsVqFeBGd.1hWsoQgT4a6Ivfu0K1MGe9XxfWXjpy.	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.023	2024-02-08 15:45:29.773
ae5d7c40-4a27-4d5e-8d14-0e5d8ae59050	songsokhavudthi17@kit.edu.kh	Sokha Vudthi Song	$2a$10$.LZtlihq28LQWgl8UxXM2uEy68Irod08Exb9vki7RNkH9QKM5LQS2	\N	STUDENT	70692888	MALE	t	f	2023-07-14 12:21:42.066	2024-02-08 15:45:29.777
9f18a9ff-6824-4e36-9f33-0e3a80e5bc62	sokvireak18@kit.edu.kh	Vireak Sok	$2a$10$CRrNdq4vdUubNFotoCgesesnk7UYphaAQjUUamW/gGNe8jXIFiLT6	\N	STUDENT	967361348	MALE	t	f	2023-07-14 12:21:42.096	2024-02-08 15:45:29.781
a45ef98a-ebbb-496d-b775-e95739c82aee	novsunheng18@kit.edu.kh	Sunheng Nov	$2a$10$BEGcPxWOFOr/WTOoas6E1.EMgi5GpaRSj37ZyhhQip0PrenolkX6S	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.122	2024-02-08 15:45:29.784
a39b5ce9-a272-4057-96ef-574892f4c902	chuonleangheng18@kit.edu.kh	Leangheng Chuon	$2a$10$6h8XxIwEFDtzyay8HHP3hOXAlfJwTyg6KSFoCXg.pQcjRpbQxGUz.	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.359	2024-02-08 15:45:29.788
a3c61194-c275-468b-9b88-d2bced68288a	chhunsokhon18@kit.edu.kh	Sokhon Chhun	$2a$10$CdXZfHzAvO0Dev5i.1QPoOYrCbRgVD4eS/JR19ysSY31df.Weli02	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.073	2024-02-08 15:45:29.796
877884fd-1cbe-434a-bdb2-7fa33454a790	sadethkimheng14@kit.edu.kh	Kimheng Sadeth	$2a$10$vgKv1g28U7jfmEiKFPxPZ.YZPlx9Ozu3xpwy9ZnBfj6Y90WpSYtwW	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.687	2024-02-08 15:45:29.801
90eed5b7-0729-4659-b1d0-3df256ef82e1	khyvireakpanha18@kit.edu.kh	VIREAKPANHA KHY	$2a$10$Nm8H0s0MEoh6GbGGKoEY.eTS8vLFt/x5.XBu0CmS7Ozi34u4Hz9eq	\N	STUDENT	973522860	MALE	t	f	2023-07-14 12:21:41.577	2024-02-08 15:45:29.805
8ea8423f-8510-43ed-8dc9-b1672f42f2f7	sereysoksan16@kit.edu.kh	Soksan Serey	$2a$10$ODEeOvQGI50zyny9BT8YXuaLa96XJEh8ELPHU5IFi/MqupukVU7Ju	\N	STUDENT	964645715	MALE	t	f	2023-07-14 12:21:41.768	2024-02-08 15:45:29.809
b3fbff81-8b91-4c58-b788-aad57b9afba4	chensokheng18@kit.edu.kh	Sokheng Chen	$2a$10$tvF5IwKnlN0fz6/3aIQ/NeDqUO59fs3nEZgcyAxOXyLRTUuAalmqW	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.549	2024-02-08 15:45:29.813
b84d039b-bad1-4648-bb2b-a60e2dc53c8e	heangsokleng16@kit.edu.kh	Sokleng Heang	$2a$10$Z7q.sKyoR.T5LHozGH8nROVwYA4WkDZOQPdzIOipMN4M5Z5mRo2xy	\N	STUDENT	81534300	MALE	t	f	2023-07-14 12:21:41.571	2024-02-08 15:45:29.818
af5edebd-19d0-4aa2-a2f9-c9685616c646	sounsenghout18@kit.edu.kh	Senghout Soun	$2a$10$VbKYeYY6ytNzbpocpm0.Puuzo5dBcUqU8qOpfCNWA.6K3HtQm/jly	\N	STUDENT	16851617	MALE	t	f	2023-07-14 12:21:41.588	2024-02-08 15:45:29.822
bb1bc1d9-8c29-4d43-af54-dd1423f2d38a	youksakmonysothea17@kit.edu.kh	Sakmonysothea Youk	$2a$10$euvlb4gHabRi1PSpHgAOJefcgQtXA6lfTJ5O7in3776h0LTMkX3da	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.813	2024-02-08 15:45:29.826
c1a4d147-22e6-4461-837c-b63de505d7d0	yeohsoonkeat18@kit.edu.kh	Soon Keat Yeoh	$2a$10$xhjznXe9tC6KcOJD6AHiDeGlPwbmeQGbGGOiQDPnQA3LOrpLqnr96	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.921	2024-02-08 15:45:29.829
c0b6b026-3b6e-47be-abc7-464f96ba90d8	maoyuklin18@kit.edu.kh	Yuklin Mao	$2a$10$k3/VDICaw4dGqcoOBGJRXezqVXJJ0R1AClfBJsu3x1P2sVDAAoKde	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.973	2024-02-08 15:45:29.833
2688c238-b324-4e71-813a-b03702c1d33c	meng.lavy19@kit.edu.kh	Lavy Meng	$2a$10$NwMe.StUHzUjUIRCwXg.p.4ylqOiwvoqYI.BL0KHOnAtO59KCw9a6	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.183	2024-02-08 15:45:29.837
28397014-e9a0-4c23-87d0-8a2c71ad7aa3	soth.sambath19@kit.edu.kh	Sambath Soth	$2a$10$mP3bNf6eFzm1wtoiIPtq1elQBH2kapFOoxdBOQVANjysLawfMUiye	\N	STUDENT	10470824	MALE	t	f	2023-07-14 12:21:41.189	2024-02-08 15:45:29.841
2746cc8f-6348-4e7d-9dda-adc586acb643	lavtechuy18@kit.edu.kh	Tech Uy Lav	$2a$10$PaXDO7U18eDbozmEH41kPew/M2lt6RWqx0qM1w5/QGMCBAFAA35xO	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.271	2024-02-08 15:45:29.845
269809d7-bc6d-41a9-8abb-bcd406b422f2	pechsokmeng17@kit.edu.kh	Sokmeng Pech	$2a$10$kq7sUOVkzq1gEMQhBhTM0ujL7WYjzr5wDjVF1X7k89AzV8/k5QJVq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.915	2024-02-08 15:45:29.849
22ea4482-d8ca-44cf-b39d-563ce78da2bc	thongmonyoudom15@kit.edu.kh	Mony Oudom Thong	$2a$10$97Ws7E8GJceeYmeGVN9swummNygZ9Lsgy1wt4cdNVslU4.IlZX3Wa	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.938	2024-02-08 15:45:29.854
25c751da-54de-4683-9c76-429cc849062e	kheansreythou17@kit.edu.kh	Sreythou Khean	$2a$10$5oikx7VQP5jOiFJpJyuZRudNU7mRC7yie5AIrty.mZU3bG7YX1n5i	\N	STUDENT	81931736	MALE	t	f	2023-07-14 12:21:42.236	2024-02-08 15:45:29.858
27e3d083-2695-4c33-9372-beb6c2575c9a	thymakra18@kit.edu.kh	Makra Thy	$2a$10$oggTfWg5SwjLTxTK/n78H.Btw5D0a4zeZMedYam2in2HoMyMHsUBW	\N	STUDENT	81500906	MALE	t	f	2023-07-14 12:21:42.328	2024-02-08 15:45:29.863
28fabb64-c648-44da-bda1-cbfa0d95f2ec	cheakimmunyvorn17@kit.edu.kh	Kimmunyvorn Chea	$2a$10$aqvbiJ/QetPX1p6wsmmZ3OfgfsSxV8/yWBhEOJc3aempCzhWzH9fG	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.458	2024-02-08 15:45:29.867
9f0ab818-ea50-41cc-b6a7-2f829f3faae2	amchhuny17@kit.edu.kh	Chhuny Am	$2a$10$w5eJKm1ymrmI9SNVy6e9KOe/LAoEDOEVm32GdozLYomnCzU9Hat8u	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.09	2024-02-08 15:45:29.875
9be4d8ca-e4ac-4d1c-84a1-4cb262b2cc42	chhum.makara19@kit.edu.kh	Makara Chhum	$2b$10$n1jE2jdcOUidIq6NO3ynyOkhlEVJCpdaja3bJuv./wxPsGSQDUV7e	\N	STUDENT	99783454	MALE	f	f	2023-07-14 12:21:43.191	2024-02-08 15:45:29.879
9e6dc627-b199-48d3-9253-fd8badb06070	yim.sunleang19@kit.edu.kh	Sunleang Yim	$2a$10$8O6WCeoCHtCJZuGXuTOfleAQfjOaXqDb/kYdxY8jc6tg9nfeUgG4m	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.322	2024-02-08 15:45:29.883
c9c4e2ee-4b24-463d-89d4-82e90cc51257	dinachanthan15@kit.edu.kh	Chanthan Dina	$2a$10$wZBq5I3I6T7F3DV/vldKe.2vsH3VmgExqxohyV8gjrfWySyEhBX1u	\N	STUDENT	8610966	MALE	t	f	2023-07-14 12:21:41.992	2024-02-08 15:45:29.887
c2f94a33-85a6-4491-bb8a-5b745c246029	soemsamrach15@kit.edu.kh	Samrach Soem	$2a$10$bQAWsVvy6Zwflw7yUK0bk./jKNRS3C61fb2VKCpjfj300q6sIx6Iy	\N	STUDENT	966619121	MALE	t	f	2023-07-14 12:21:42.16	2024-02-08 15:45:29.892
c5200875-008b-49ee-95e0-97d3640cbbb4	chhaylyheng15@kit.edu.kh	Lyheng Chhay	$2a$10$J90TH30TLnHjmCL77HHJDOU8xDjWVbZfm6Rp9V2BLp98RdpnJv1GG	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.242	2024-02-08 15:45:29.896
c8da4369-5554-4e79-8479-0e76de556b9c	ung.henglong19@kit.edu.kh	Henglong Ung	$2a$10$nAdH7koem9JfK3qNaNure.S9vC.k6bwFNBgrxnULWsS4ow9DpACpq	\N	STUDENT	78646939	MALE	f	f	2023-07-14 12:21:41.021	2024-02-08 15:45:29.901
63243e88-8217-4b6a-a546-b21c47c538bf	yumi.nakahara19@kit.edu.kh	Yumi Nakahara	$2a$10$WhP86CeGlh6wB/uKcTMYSOGTW.RpBKb.PZfyV61JyKRRYFxqQt.im	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.777	2024-02-08 15:45:29.905
f6ef71a7-3cd3-45d7-8236-128280ca1fc9	haiseanghor20@kit.edu.kh	Hai Seanghor Boyloy	$2b$10$VmgPo6a6sGm7FCIlHh.0.OWgKmLJmOdfgo7ryy1NJkbg2AtR4AOd.	\N	STUDENT	021313132	MALE	f	t	2023-07-14 12:21:40.872	2024-02-05 08:21:50.976
4bfc1d24-2793-4d31-938a-d8f2ff25bb98	momoka.miyazaki19@kit.edu.kh	Momoka Miyazaki	$2a$10$Dd0knVUXua9e7eIqa4cRkOtiNH2S8w8Yv/WzU.gzKki0zEzkUlaim	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.782	2024-02-08 15:45:29.913
a702a1dd-efeb-4e33-9b94-660fe1702a52	eishin.ono19@kit.edu.kh	Eishin Ono	$2a$10$clx20yNVrOznZKqNMZFhw.hc4Uk9YGdEjvBVJwBcaG3uRzUzSvrRu	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.882	2024-02-08 15:45:29.917
d64d8ce1-4225-4026-8c7c-ec774f5f7376	thy.saonan19@kit.edu.kh	Saonan Thy	$2a$10$Gspat347JXfoNGM0arm8SOGLv1fa/lkxJj9SkLzJAg4eP9jzmpadW	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.16	2024-02-08 15:45:29.921
cd5915bb-a524-4073-8b7a-8e91961bfef6	taingtheanchhing18@kit.edu.kh	Theanchhing Taing	$2a$10$/pNP7dYAL39Zyo8ABnv6e.HEvHSaaN6k4SyHl7/9x5Vz4fHsU1dbG	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.475	2024-02-08 15:45:29.929
d51620fd-7036-464f-b58b-e8d13ad095b5	khepanha18@kit.edu.kh	PANHA KHE	$2a$10$kB8QFKx34T3C7OKee0aXB.MivObnJNFzRfhEVWD50GXneCMBUUhnC	\N	STUDENT	92711992	MALE	t	f	2023-07-14 12:21:41.583	2024-02-08 15:45:29.933
cd9c9f38-8367-4ace-94d3-104545a85a03	phansokream14@kit.edu.kh	Sokream Phan	$2a$10$DLJQQKqF95904fSaPoO0s.CYsgju.j48Zslgf64GOWImaNkP/xs8K	\N	STUDENT	7741773	MALE	t	f	2023-07-14 12:21:41.636	2024-02-08 15:45:29.937
d15c088d-a090-4348-9504-4c3e96997317	pensereyotdom15@kit.edu.kh	Serey Otdom Pen	$2a$10$tOkyNgFGC3lBFPWaDMmLueeZE.FR9tN6KHs4JS/oGdgFxAwDfRcoe	\N	STUDENT	87307585	MALE	t	f	2023-07-14 12:21:41.762	2024-02-08 15:45:29.941
cac0987f-3e14-4b38-a6e1-59f4fe8206f7	haysokchandachet14@kit.edu.kh	Sokchandachet Hay	$2a$10$JtKq9HfETizStGgtLvKW2OvPmcxmgM2/hAAXhAXK2kLI4rpGCJjy.	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.556	2024-02-08 15:45:29.945
d10ab048-7259-47eb-a4f5-959919a4b700	loemkimhak15@kit.edu.kh	Kimhak Loem	$2a$10$ER3RKXw2v1ggJb7oKbPKyOPnCCkMp3YeyxqT4jik06gsYUrVLxxne	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.807	2024-02-08 15:45:29.95
cf3e638a-08d6-4edf-8e17-1a760c871a4d	haklay14@kit.edu.kh	Hak Lay	$2a$10$sealhGruWwfe6nCS.8m6aOAfMwjI7K6wbEgjc8kA53OwzMHLVhuMK	\N	STUDENT	70844129	MALE	t	f	2023-07-14 12:21:41.944	2024-02-08 15:45:29.954
d7355f08-0654-4560-8f22-fb6a9fb04c03	lychandara17@kit.edu.kh	Chandara Ly	$2a$10$vNlDICbXyg5mTymenrhhK.YyJKM2WEc6Hyr062rBy6xIUU28eH89u	\N	STUDENT	10610670	MALE	t	f	2023-07-14 12:21:41.966	2024-02-08 15:45:29.958
d0568df8-dda0-4cf1-9abc-a29508350191	nunsophanon15@kit.edu.kh	Sophanon Nun	$2a$10$PkF7552VwZujpy0WocPMD.ygnZa1XR6PDEWa9zhQ8X7ChRPV8Lx1S	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.48	2024-02-08 15:45:29.962
d43a7bba-38be-414e-8c55-554ff2a0bf82	thorn.theanlay19@kit.edu.kh	Theanlay Thorn	$2a$10$8MKp1W.s0j7o5B/zn7iEMeQUj5uVLQ2pEB4skzHoD8adOXJEweMjS	\N	STUDENT	968575739	MALE	t	f	2023-07-14 12:21:43.061	2024-02-08 15:45:29.965
d442a912-07d2-4bf7-87aa-eaabb9f3a31b	veng.mengsokun19@kit.edu.kh	Mengsokun Veng	$2a$10$IthSlR5AYqB.GHz3xU/ZQOpUmBkCOFKjg/cB9eZi3ah3yy7mdXgxi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.359	2024-02-08 15:45:29.969
cefc8313-6752-4fbc-bf0c-74e65c1150c3	heng.kevin19@kit.edu.kh	Kevin Heng	$2b$10$wIt1SR08SIAbq.ElghgxT.JD6t/IgogyjJ6Me0Q5IJoPBpVwW7FM2	\N	STUDENT		MALE	t	f	2023-07-14 12:21:40.997	2024-02-08 15:45:29.973
d756feb1-5fb8-4af4-9242-20166ddc3fe2	darodalya17@kit.edu.kh	Dalya Daro	$2a$10$IRkwTOzXvDe3uDDUpdh0POsx7i8I902HLic/e.RvP0wUQZmu68bya	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.119	2024-02-08 15:45:29.977
bcc17fd4-976d-4637-8e7c-d08e87f32b04	sunchenny17@kit.edu.kh	Jenny Sun	$2a$10$S1e98XbGxyk9P5h0iLWCTuHvwo2zzHdqSoE1r7ZmprXcD/bB3xGJm	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.254	2024-02-08 15:45:29.982
cb81fe51-27be-4176-bfc1-1b361d42ecd4	srunchina20@kit.edu.kh	Srun China	$2a$10$NKK.I.UVCdCSB5XBBjiUh.5dfu65DXz2.5rXm0sUIphOR/eMXui8K	\N	STUDENT	12345678	MALE	t	f	2023-07-14 12:21:41.103	2024-02-08 15:45:29.986
c99f847c-bfe4-4b96-89bb-a3fcaf63ee72	shogo.terashima19@kit.edu.kh	Shogo Terashima	$2a$10$4S/mr.ON2GbBxlhS3u5do.egH/uNR5RExXOF0Agdz4h7eJuKVE.x6	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.695	2024-02-08 15:45:29.991
c5f65189-d34b-43cb-8cbc-c17566156b0a	dukpidor18@kit.edu.kh	Pidor Duk	$2a$10$XGBmKTchrDSS9b1pgD7OVuoe3c8t.6rWyuBAGuAimBp471xfp.Rkq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.413	2024-02-08 15:45:29.994
c3933f5a-63d6-4b78-ac54-eafbefd46265	nethsokreth18@kit.edu.kh	Sokreth Neth	$2a$10$0RixnxgGvF1AGVthfmRriOPFEy8T8M2Dz6ltWURZUoKHsYCXXAm5m	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.927	2024-02-08 15:45:30.002
c3383912-7f86-4b9c-a8e5-34c51994daa7	lyvinthai.mao22@kit.edu.kh	lyvinthaimao	$2a$10$wcWREHd9VJurD3Vm0xhdou.VYE4WH9pdSJwrTLfagLcDSatIyKEmC	\N	STUDENT	9872223	MALE	t	f	2023-07-14 12:21:43.648	2024-02-08 15:45:30.006
db8eaf3b-f95a-4b30-b1ee-0228be1abf0d	seamsopagnarith18@kit.edu.kh	Sopagnarith Seam	$2a$10$iwU/fihE6ANemGW8w.4F1uQH6KKefjlSlTzRyrTem3j5BEFQpuZ8O	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.544	2024-02-08 15:45:30.01
d7b6ecdf-c2de-4a8d-905a-3e7dc86dafd8	phansreypich15@kit.edu.kh	Sreypich Phan	$2a$10$EFeC/Ygw9l1CXiC94aB2..QQBiB6uxQ7mg2.dcnOSvgigEwpnLhRe	\N	STUDENT	963863068	MALE	t	f	2023-07-14 12:21:41.779	2024-02-08 15:45:30.014
58f5f21f-5de4-4f26-9626-c01a48c3e5da	bouleapheng20@kit.edu.kh	Bou Leapheng	$2b$10$IQKac1HIpuaZFDlMQj1C5uzp2XDlqmDsoJkygnwVBNiI5.eFesx7K	\N	STUDENT	11111111	MALE	f	f	2023-07-14 12:21:40.813	2024-02-08 15:45:30.019
e047136a-10de-440e-8ecf-f9e670a8b8ce	longsamann16@kit.edu.kh	Samann Long	$2a$10$vBb3BF67pbQvcbbD0xAR/e4KgGdjKq06gNX.ZyYnTolupcWORSewm	\N	STUDENT	962190776	MALE	t	f	2023-07-14 12:21:41.835	2024-02-08 15:45:30.023
db2f28bc-933b-4a4d-b850-e4cbcfee4782	chimsovann20@kit.edu.kh	Chim Sovann	$2a$10$EYYJqiYKqTf1YVrzZMQ06OGUpIRih0656P8YP1OOhxAKZGUQFv9K.	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:40.933	2024-02-08 15:45:30.027
de3cc11d-60d8-436d-85e2-f9eb9dff4b64	sengsovanndy18@kit.edu.kh	Sovanndy Seng	$2a$10$PnfdmSjVU9d43UiOwLKZe.mVwN751qvm6rdTQCC4MGSFCigoDNnXi	\N	STUDENT	967863402	MALE	t	f	2023-07-14 12:21:42.353	2024-02-08 15:45:30.032
de3a696b-c07d-480c-8d69-3b444cdeef84	hengmouyleng18@kit.edu.kh	Mouyleng Heng	$2a$10$bC3UJmnu6qMqBKUQFeawc.YNbGSBxN3xhiXvND6cx9S.F8D8giqGW	\N	STUDENT	966510204	MALE	t	f	2023-07-14 12:21:42.463	2024-02-08 15:45:30.036
e048bd6c-a65f-4c90-bf7f-cf03c1b06a90	pannreachseyrana14@kit.edu.kh	Reachsey Rana Pann	$2a$10$tcIKA90XvRY8UP7hLNFIt.Ck540tig6TxTThl5oI7Pf9GIPgFkwye	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.512	2024-02-08 15:45:30.04
d9d2e8c1-2e2c-4b12-9670-4e201a891dfb	sari.mizuno19@kit.edu.kh	Sari Mizuno	$2a$10$VhVRXt3hVpDuctgVcvZ1sOiszN4eyyAyPGvO1BgpvLfYLLOxbRruC	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.818	2024-02-08 15:45:30.044
d8cb5f3e-5212-4edc-912f-9816de9394f7	kaito.yodogawa19@kit.edu.kh	Kaito Yodogawa	$2a$10$0SQUz0fykJC5N/W.jJAeDe6oOTcFZUjTWV1eXMaC8KjbXSuXbak2q	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.844	2024-02-08 15:45:30.048
de49c7da-6ac0-42a5-bbb1-8675074a3e2a	koloudom.siv22@kit.edu.kh	Siv Koloudom	$2a$10$zchpoHxWAbwIjCg3.Y25ROgN5.zvx3lV7ofgr0UFMHib59spb6WoO	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:43.712	2024-02-08 15:45:30.052
f49f756f-0e95-4fcb-8102-e0a82f07124f	sor.panharith19@kit.edu.kh	Panharith Sor	$2a$10$aD3f..F98lAbx3W3fiysbewRuOOFPpBiPUYFL0gO4q0DmZ.h26Oi.	\N	STUDENT		MALE	t	f	2023-07-14 12:21:40.906	2024-02-08 15:45:30.056
d4dd3b8d-feef-414c-a538-92be779daa3f	peldane17@kit.edu.kh	Dane Pel	$2a$10$K8U8Gw5mW3V.BP1q2.HYUu2ssEZE1NduzBWUqHOOtCPWc.V8h2VXq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.287	2024-02-08 15:45:30.06
fda0d9a7-9d58-49f2-831c-850775209d60	vin.chhana19@kit.edu.kh	Chhana Vin	$2a$10$7yk4WzXlsV02ZlpazFw.n.NMnMGhEnUmCCaBz9WDiHc27TWhRoG.m	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.009	2024-02-08 15:45:30.064
f6cc83a0-b7f0-4195-bd76-c256db705889	kanika.dorn22@kit.edu.kh	Dorn Kanika	$2a$10$paXJ2g64rnnPnF73OsIBPu35bdsjnT4BkCgw4/xcrpaWc.Eh4WcTS	\N	STUDENT	2399999	MALE	t	f	2023-07-14 12:21:41.217	2024-02-08 15:45:30.072
e5cffe5b-22b4-4d84-b71d-520e9950c107	indarasith18@kit.edu.kh	Darasith In	$2a$10$yqtEDDrry.yDEAbrRXkgW.smqIQDXJKPvlmB9lnBYoucY8bS3ILqq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.288	2024-02-08 15:45:30.076
e5669273-53e7-48ac-835f-0a93afd4c484	lolsreysa18@kit.edu.kh	Sreysa Lol	$2a$10$UH1xIJ5gRc58/m6kIi6YiO2w/URIIE3UOLyRXbFt2ZibuxjFOb/YW	\N	STUDENT	967358193	MALE	t	f	2023-07-14 12:21:41.358	2024-02-08 15:45:30.084
f8770680-f04f-4bbf-be70-a6e01a65ae17	oychanphallin15@kit.edu.kh	Chanphallin Oy	$2a$10$V3MSLTlxiPpmMnV3ScvcDewcr0jNY9n.QA.uBpgF3JyrOjgqEvMt6	\N	STUDENT	963302116	MALE	t	f	2023-07-14 12:21:41.376	2024-02-08 15:45:30.089
e294ac32-f961-4a76-856d-38d503853063	labdaro18@kit.edu.kh	Daro Lab	$2a$10$NMrz0qv9lapMcpFgdlWWLO1NZzT0vn4TX1a/aiX7e5ScXq4h9o.jG	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.595	2024-02-08 15:45:30.093
f3fb6c4f-4f02-4c9d-ae78-c8b82e20e6b9	oukyulong18@kit.edu.kh	Yulong Ouk	$2a$10$P.duxDRrrYiavle2ZkZsCe7lTk0f6kjWP1dHo.FOUEA5X195aZs6q	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.801	2024-02-08 15:45:30.097
e52ad439-29e5-48be-81a5-9e4fcd0c6c5b	sumsovann18@kit.edu.kh	Sovann Sum	$2a$10$2L5DhsT9UggSzv9Z1KTVBuyfhcGZ3oAR3P7xmCkAJ5TDUdHxFg/62	\N	STUDENT	712917272	MALE	t	f	2023-07-14 12:21:42.079	2024-02-08 15:45:30.101
e9d112c5-2fba-4de5-877c-e2640b030429	sannchamrouen17@kit.edu.kh	Chamrouen Sann	$2a$10$WIby12Z5gC/nieHc8wJDJ.nKbMQcZQODv.l0QEimzBrNzpounuC/i	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.129	2024-02-08 15:45:30.104
e6e47c59-a345-42d2-8e37-d0252a3c685b	sumsopha15@kit.edu.kh	Sopha Sum	$2a$10$Ao08jYEmuwvoqAnoxW8Rh.56M5l8SDQ3XC7.GO8D0SjS0jZmoRIYq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.136	2024-02-08 15:45:30.108
e521170d-6319-4880-a07f-2050f48a5dcd	sothybunthoeurn15@kit.edu.kh	IsMe Thoeurn	$2a$10$M7P7J1PFQ7tonJXaNlLZrO6AFTJFO97FEdYf.SJ6.zXgMb8EmEQU2	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.148	2024-02-08 15:45:30.112
e65da901-e737-4e61-bb59-4dee1fce4903	tansomnang17@kit.edu.kh	Somnang Tan	$2a$10$jVS0tmmNl5lEixu.9NpRfuTI6kv0u//0DYadiLxybR4V4UOkz5NAi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.154	2024-02-08 15:45:30.116
ea8fef71-5a1b-421c-bfcf-89f2f17951f0	meassoknoy18@kit.edu.kh	Soknoy Meas	$2a$10$bNIkUOCCIwzeYzsSckSHPuuHIcTC30EKKhwiJCr3oI6U7Ua1gGSMO	\N	STUDENT	10900479	MALE	t	f	2023-07-14 12:21:42.266	2024-02-08 15:45:30.121
f4afa11b-9d3b-4088-88b4-830f648d472c	sossokleng16@kit.edu.kh	Sokleng Sos	$2a$10$/w3UnndzqDHaJ.DwHVCy6.3EIdQVXc3Y0dlsfFb8CW7tQahxQgvZ.	\N	STUDENT	86322200	MALE	t	f	2023-07-14 12:21:42.412	2024-02-08 15:45:30.125
fd6abb92-ad82-491a-92cd-2d6790a1fcff	sokkakvey15@kit.edu.kh	Kakvey Sok	$2a$10$pbjkfhF85vMha1Gm2TQ..urY60C1kQuEAOYyse/na.yqygJ.RMgTu	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.418	2024-02-08 15:45:30.129
ea65e223-027a-488b-8178-1c73cbcf4979	rinkimhun18@kit.edu.kh	Kimhun Rin	$2a$10$jg2qv/1WThuIEJhn.lsPlexubmyszxWYVf3bfyRkAqZGrSSUVAyW2	\N	STUDENT	963195196	MALE	t	f	2023-07-14 12:21:42.603	2024-02-08 15:45:30.134
eb3b2396-bd30-48ff-a344-32088dfb5500	motone.adachi19@kit.edu.kh	Motone Adachi	$2a$10$vAq3JhE0OjL8sVD2ULtI1.uAyKKAScgApNFPW/UtR4yWZNk92iVme	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.701	2024-02-08 15:45:30.138
e6cfaff7-6e4a-4e06-a5ea-861ae2cd0214	ko.hasegawa19@kit.edu.kh	Ko Hasegawa	$2a$10$D7iHiwGvZkSrgPWwrbFhpetmO0LQCFhJVs1lz6xK.JZkTpWv/s30W	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.807	2024-02-08 15:45:30.142
d771fe84-4add-495a-aae7-358ef2117e73	kosalsotherny18@kit.edu.kh	Sotherny Kosal	$2a$10$.Rqb4QrWAQ9/Y1WmLV1tMO52BPem4JdZBOihQOzG7Sl1SmvNieyB6	\N	STUDENT	10882859	MALE	t	f	2023-07-14 12:21:41.365	2024-02-08 15:45:30.15
fc160bbd-a511-4a6f-9fe7-705f18ba25bf	narin.colin19@kit.edu.kh	Colin Narin	$2a$10$scAiNwOaLOYtBcupq.QXqey.UC6aEN6z/rRfvyLiCXEcsEPyGREgG	\N	STUDENT		MALE	f	f	2023-07-14 12:21:40.779	2024-02-08 15:45:30.155
81c5aead-4092-47eb-a862-0f6d35222f3b	thea.chamnol19@kit.edu.kh	Chamnol Thea	$2b$10$fjrzEQOl2MlsOP2VoHn8mecFSNv3.t/Z25xw3a8MAUr82oTIkCiDC	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.334	2024-02-08 15:45:30.159
20540d62-4f1c-46de-a26a-eebf606da62e	sokundeborey18@kit.edu.kh	Deborey Sokun	$2a$10$88B9k0aYYUdjAlDckhA6vO0JCgj/k/eqqeKmIwogDXRXQUdgyWyWK	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.371	2024-02-08 15:45:30.164
dc659915-4204-486f-a91e-010721352352	hinchanritheavuth20@kit.edu.kh	Hin Chanritheavuth	$2a$10$ULwMvBKfaGbuTEYpZtZi3uGxveM8JJShefwNZtDmbC4XCkBUdR7ga	\N	STUDENT	98294164	MALE	f	f	2023-07-14 12:21:40.877	2024-02-08 15:45:30.169
1dedee5b-ce6b-453a-bde9-6f67a3decd92	san.vivorth19@kit.edu.kh	Vivorth San	$2b$10$AFjSboahqUA61UHpxi82seypJfTT7lqYmCPWo2nZHt7wCj62usrJe	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.29	2024-02-08 15:45:30.173
be7a0bef-1088-4ce7-92b8-d6af714fb558	lim.huameng19@kit.edu.kh	Huameng Lim	$2a$10$Q/KzxP6Rb0VqwiXUPYWVc.nJRaWwuVGy9.kV/Req66iZulKIfFU9K	\N	STUDENT		MALE	t	f	2023-07-14 12:21:40.675	2024-02-08 15:45:30.178
933af6e4-2587-4737-b357-fdb71c12732d	thy.moyheang19@kit.edu.kh	Moyheang Thy	$2a$10$1xrtEY6DBddwI5.9zZvIUOk3L/XdC2HPEWXk8OmTRwOSlhL9F5aI.	\N	STUDENT		MALE	t	f	2023-07-14 12:21:40.68	2024-02-08 15:45:30.182
f5bdcfd9-8130-44bb-a0ad-aa03c5a36f63	long.hakly19@kit.edu.kh	Hakly Long	$2a$10$7PMbYo38l3fpeRjWwiFR6.amtdfBhdhgfdB0ZFhF.0rUW8P6n93pi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:40.704	2024-02-08 15:45:30.186
a47b51bf-8167-4a7f-adfd-58dc5ef554f8	horkimseur21@kit.edu.kh	Kimseur Hor	$2a$10$fj3Ktphunw/tGpauFVAmqevY8ynnHn2g6kI6RQHzLKrNQiysk3GDS	\N	STUDENT	85553477	MALE	t	f	2023-07-14 12:21:40.668	2024-02-08 15:45:30.19
ca22a660-ac87-4467-9cae-95e7d4a0f593	pheak.chanchivy19@kit.edu.kh	Chanchivy Pheak	$2b$10$pLwVBnQYomTttj3JADBnyu210sZdu/mAU9xFBu/EClvVj7EHkoDXi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:40.738	2024-02-08 15:45:30.193
2ae5a1b9-a7fc-4ff2-bce6-59cbc1c8baf4	lay.chivoanvimol19@kit.edu.kh	Chivoanvimol Lay	$2a$10$gswJfmvqdFWItK31EX0c0eIFQbS2DqfoCU5xN5yivuu6uGy3wpqWe	\N	STUDENT		MALE	f	f	2023-07-14 12:21:40.744	2024-02-08 15:45:30.197
d6a68749-90e9-404a-b304-3918c9f827d0	chea.chansineath19@kit.edu.kh	Chansineath Chea	$2b$10$Sj8PKt9Nvp7sZ.P6v.t9JOGyhpv2.nfiVUrT2DL1qMF8WTYADB1Km	\N	STUDENT		MALE	t	f	2023-07-14 12:21:40.843	2024-02-08 15:45:30.2
1fb9a8c3-c509-4ba1-b1b8-9273e76c8949	tomsohor18@kit.edu.kh	Sohor Tom	$2a$10$fvus7EINzqn3RlDVYGElKuJtamLt146O65Y99GL9dfVzqWunXVyI6	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.236	2024-02-08 15:45:30.204
3b0f73de-73e9-4591-99d9-026eff35a37f	sreangvuthy17@kit.edu.kh	VUTHY	$2a$10$Pccy53.X/CFPMtlaJsKf7.VjPrbcBXKw1Zt4nu1Wr3pGqrrM/SabO	\N	STUDENT	98820725	MALE	t	f	2023-07-14 12:21:41.601	2024-02-08 15:45:30.207
00891a9e-6363-41a1-98a6-9c04bc8fc8ad	houlasovansela18@kit.edu.kh	Sovansela Houla	$2a$10$sWM9I7nLZ1cFP2ytcSDUpuUWPEtbKHs.7yNdjg3FafLBORYBqCT2a	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.613	2024-02-08 15:45:30.212
1e08c0ad-862d-4b87-a3f7-e506e20d54d2	vannputhika.suon22@kit.edu.kh	Suon Vannputhika	$2b$10$MUmgQirSvf49OFHaJiNNau2tgGqxKUOvLq7xbFjBxqIHLy4zMCRhO	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:43.734	2024-02-08 15:45:30.216
3220cc29-ba9a-4e3f-ae02-f937d32046bc	ly.sreypov19@kit.edu.kh	Sreypov Ly	$2b$10$BlGBbLo0PGL4iZYhAIS12eaSkm14Skq97nOdrBvqOfzqamaCchOF6	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.481	2024-02-08 15:45:30.22
44994f28-e612-4eb0-92f7-fcd8b4e5f600	neak.vireakyuth19@kit.edu.kh	Vireakyuth Neak	$2a$10$lJi2bOR9TY29WD3bEsvygO8Silr/E0R9kDEc0WNYULYI3yt3YYep2	\N	STUDENT	78629628	MALE	t	f	2023-07-14 12:21:43.197	2024-02-08 15:45:30.228
718d732f-2215-4dd4-aee5-97051c596005	seakkimhour20@kit.edu.kh	Seak Kimhour	$2b$10$6j5iHhFNTy6vqIGESyIT1uOeQ5TXD8yY4iRHfJGlzFuqK5vMAnW6W	\N	STUDENT	\N	MALE	f	f	2023-07-14 12:21:40.889	2024-01-08 10:33:14.428
44edd45d-5c3d-4562-a028-bb255b67d492	huotratha14@kit.edu.kh	Ratha Huot	$2a$10$3bIBJX7u2XWnBbBUDM9Qhu4m824.aA4xknWUw3RKD0XQEkWz.p4t6	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.185	2024-02-08 15:45:30.236
45860172-eb7e-4b58-906a-f487073b051b	chea.chanraksmey19@kit.edu.kh	Chanraksmey Chea	$2a$10$5za0qheO7MJp1NrcNRsf3eY3dyUmzu6J6ZDFzWHM9n.zVH1MyLKTy	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.252	2024-02-08 15:45:30.24
466019fb-284e-4818-84f2-a812078a3045	chav.bunna19@kit.edu.kh	Bunna Chav	$2b$10$84Y2PHd5P/IxThLhhnAJ2upAkVQrtcfmmkb0i9gzE68sOlQU1qOUe	\N	STUDENT		MALE	f	f	2023-07-14 12:21:43.265	2024-02-08 15:45:30.244
48461ecb-7dad-40ba-a01e-c8fbe2ae4948	sok.vansocheata19@kit.edu.kh	Vansocheata Sok	$2a$10$jEylhUebjUuYbXVVYOy3euLh0/bnBGrceorpu609Fms8CdW6YY1P6	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.433	2024-02-08 15:45:30.248
4a08a05d-0952-42d6-a081-af8a24fee821	chanprasidh.nou22@kit.edu.kh	chanprasidhnou	$2a$10$KRwOf16DDUEuIdEwfkcdPe/Mi/0RAxpwreDjYHT3QMEB1wcXFxE1G	\N	STUDENT	9872223	MALE	t	f	2023-07-14 12:21:43.665	2024-02-08 15:45:30.252
506dbd51-8921-4902-9179-2d24d4cf1f45	ney.senrith19@kit.edu.kh	Senrith Ney	$2a$10$GSIdsP0q2uUstzEgFeNEjOcrFxMJNjtD8ouZ7CTMLLUg4cg1oN6kG	\N	STUDENT	15779765	MALE	f	f	2023-07-14 12:21:43.202	2024-02-08 15:45:30.257
50a38de9-3992-43dd-a365-dd889f058802	daroh.sou22@kit.edu.kh	Sou Daroh	$2a$10$RY6LfaWnUGJVjlOj7bl1qOVAQQE8zz8rDt4rNpy.cVkX54QXkgyIW	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:43.728	2024-02-08 15:45:30.262
54d863db-e0de-48aa-aa30-de6571b1f731	mady.lun22@kit.edu.kh	madylun	$2b$10$mSa9P8YN.pLdZpv7fGGzOeBjpIXqWvsmvyI.C/QwPuZb3FeYCTgb2	\N	STUDENT	9872223	MALE	t	f	2023-07-14 12:21:43.624	2024-02-08 15:45:30.266
6720bdaa-dfc7-419b-add4-1b7b9180ebea	rithmunny.sopheak22@kit.edu.kh	Sopheak Rithmunny	$2a$10$DAa97O07V7T33LwRBw7ok.3XZrthbvDR.xBDh156vFpmV3kasVTym	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:43.723	2024-02-08 15:45:30.274
6a3a558f-20b6-4a4d-8931-8362464a3cd8	sopheavid.eath22@kit.edu.kh	Eath Sopheavid	$2a$10$rDcT6HuVmWwVRJwTXCduL.T.yZU0FhrW/q6i/PdbQlUGobVXjJiYK	\N	STUDENT	2399999	MALE	t	f	2023-07-14 12:21:43.792	2024-02-08 15:45:30.278
6ab16e96-64c5-4b86-9999-494b68085604	pak.maneth19@kit.edu.kh	Maneth Pak	$2a$10$4BouR9O2tt.Mt/NSvLQUTOOUbLv6nldBbqGlhSKq4mj2AeWzBclGG	\N	STUDENT	93442385	MALE	t	f	2023-07-14 12:21:43.39	2024-02-08 15:45:30.282
6eeb44ed-c963-4f01-9610-247ffe63fd68	liya.moth22@kit.edu.kh	Moth Liya	$2a$10$sabn3amC9R0Z3nyAV3Qhg.2xWRD3qfyGYhnVV1mlXmEx6j8dIHSe6	\N	STUDENT	2399999	MALE	t	f	2023-07-14 12:21:43.757	2024-02-08 15:45:30.286
47938de6-4ee2-4504-a678-f827149a87fe	pich.rachana19@kit.edu.kh	Rachana Pich	$2a$10$u9tJyRevF0TmaXQr40W46e7aXpsTCGWm1d0bJWThfcZF.r5umfwBS	\N	STUDENT		MALE	f	f	2023-07-14 12:21:40.651	2024-02-08 15:45:30.291
ab7a00df-ac68-442c-9e7f-be5915ff83b3	sambath.vatana19@kit.edu.kh	Vatana Sambath	$2a$10$paWzkIbvy.lUVnSfdyJyJeIAS2Fe69nx6evZaGyji2OrcXfgtDGle	\N	STUDENT	968014567	MALE	t	f	2023-07-14 12:21:43.372	2024-02-08 15:45:30.295
af0e3623-e22e-41ef-b6a7-61bca53cd197	phanith.lim22@kit.edu.kh	phanithlim	$2b$10$Wrt2LK4/Y7F7/6dQmJsWu.A9x4KEggmiQbpHb5Fsx52yZUwwYNE0C	\N	STUDENT	9872223	MALE	f	f	2023-07-14 12:21:43.63	2024-02-08 15:45:30.299
08c14b89-7efc-4446-b8e1-4fe6e92dafaf	bansothea20@kit.edu.kh	Ban Sothea	$2a$10$DpLivdRYheGw93NtJeusC.jOGaEcgZfc2ViHDcYMQ3ynTWZxmAyym	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:40.928	2024-02-08 15:45:30.304
a72aca7c-8889-4ebd-a8cc-d02a00626f66	data20@kit.edu.kh	dara neth	$2a$10$N3LIP7K2zl1IWW6D1ChJUOMjI/H9sWMpHV2baPT2rx2x7akmMUiN6	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.56	2024-02-08 15:45:30.308
b2ff8c73-38dc-4d98-b54a-5f5bc6099598	than.lita19@kit.edu.kh	Lita Than	$2a$10$EFJI..6B9OnmevwDn95plepkwdemmP2pVRFi9ltAfAZQyPLbOt/76	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.271	2024-02-08 15:45:30.312
b89e93e5-ae1a-41ac-8839-7d9af5b2b743	kiriroath.lim22@kit.edu.kh	kiriroathlim	$2a$10$.FSVT9p3sQXUONfN/SORJerS5RhpSaYpqgPFuz6ZbGeT8iTV0xhDu	\N	STUDENT	9872223	MALE	t	f	2023-07-14 12:21:43.618	2024-02-08 15:45:30.316
130fc5ec-e7a8-4142-853e-d9be084c40b8	oeng.hokleng19@kit.edu.kh	HokLeng Oeng	$2a$10$KcYzC9LgRzG2Tb36Zp/SueWBvSUeAy5aZUwYZvwezIu62fWnzLUuG	\N	STUDENT	17781421	MALE	t	f	2023-07-14 12:21:43.245	2024-02-08 15:45:30.32
1140db3f-d07d-450f-88ab-26ad9b88f657	omaemasaki21@kit.edu.kh	Masaki Omae	$2a$10$BfQFlaSlcmkZQ.VNQQkNjOs0tlp0teDpePypkYxVYm3yx0ETGa40m	\N	STUDENT	2399999	MALE	f	f	2023-07-14 12:21:40.716	2024-02-08 15:45:30.324
74e16c3a-2242-4f49-a81e-9ea3babf9c82	ann.koem22@kit.edu.kh	annkoem	$2a$10$HEf3u0Hun8EGDd1qMJr7K.Sih2G402hAOPVr8YeynQXmICfOFrnFW	\N	STUDENT	999999999	MALE	t	f	2023-07-14 12:21:43.606	2024-02-08 15:45:30.328
91e950d8-5582-40a9-881d-0d4e4233a05d	roth.samnangvisothipong19@kit.edu.kh	Samnangvisothipong Roth	$2b$10$GlYZp0BT/.ECBsG/6SVLuurkXrfBExWnZ3Y31TLjE.AQVUCbafEyK	\N	STUDENT	10987772	MALE	f	f	2023-07-14 12:21:43.446	2024-02-08 15:45:30.332
09b68251-c4e4-424b-879d-d4383971201e	pech.sopha19@kit.edu.kh	Sopha Pech	$2b$10$OaiNDYfonR.X/nXVckO4FuryZX66cgpW8VqJwH.t6ytjWLTyoSzWO	\N	STUDENT		MALE	t	f	2023-07-14 12:21:40.791	2024-02-08 15:45:30.336
10b26249-f81b-4bd8-ab36-2d41b02dc9e1	srenghanritheasen21@kit.edu.kh	Hanritheasen Sreng	$2b$10$5YAmz7JNBCx1Q7glxF4vw.MBjdPvQXN63phaRbg4h3C1AlrnlwC6K	\N	STUDENT	2399999	MALE	f	f	2023-07-14 12:21:40.721	2024-02-08 15:45:30.339
76b044dd-27e6-4e82-9c66-eac6b2d0005f	panhavuth.san22@kit.edu.kh	San Panhavuth	$2a$10$gikWUwSICtWP/Kqr/DIBnujNFt2TydAi2TdjmL9Qou2a3vca43D6a	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:43.7	2024-02-08 15:45:30.343
76da99ba-82aa-4918-8322-1057463d53bd	leang.theara19@kit.edu.kh	Theara Leang	$2a$10$R9eRAHtFyDVFl69JDw95w.89sJY68zDog5OD9IYbZYV6k/LZCp/sG	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.421	2024-02-08 15:45:30.347
9a9d3acd-d50b-4b3b-be5e-9e88f0f80e0a	un.mengtong19@kit.edu.kh	Mengtong Un	$2a$10$kSxcdGwoVytdAX/rR1Ckfu.CV6Z2rlZn1.VkqhI/NBec.z0lhPbLa	\N	STUDENT	87868672	MALE	t	f	2023-07-14 12:21:43.378	2024-02-08 15:45:30.352
7c22dc89-e61c-4496-af68-7faad9744af2	sokunvoath.ly22@kit.edu.kh	sokunvoathly	$2a$10$91yjtBGF/kq83bQbGeTsb.Nj2WlkK0I.wKAixc1j1ZCJSLy3RC6Dm	\N	STUDENT	9872223	MALE	f	f	2023-07-14 12:21:43.637	2024-02-08 15:45:30.356
8070208e-c1fe-49a3-9c02-d9e5939972e3	rin.neak19@kit.edu.kh	Neak Rin	$2b$10$afxmzA55v5VSUY1E./t3x./1XBNDuO5sYFN97JsgLpptBzcPdruC.	\N	STUDENT	93857857	MALE	t	f	2023-07-14 12:21:43.415	2024-02-08 15:45:30.365
835050bf-3867-45e7-a02d-bbe741aa1bb3	seng.sophal19@kit.edu.kh	Sophal Seng	$2a$10$6YN2iFNoP.Bd17m24RRkHeTbMajdU8E1u5H5XTeefxbNxFZS/TdYW	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.213	2024-02-08 15:45:30.369
83aee2e8-2851-470e-bc28-ce2c2330a72e	soborinphannara.sim22@kit.edu.kh	Sim Soborinphannara	$2a$10$uNDbfLSBJ40k295Tor7UzuqnKSFh4tEioK00JznmEWLBwxTJXfBmG	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:43.706	2024-02-08 15:45:30.373
8f024973-acd0-443a-a730-f0e0304b9f74	panhavorn.nguon22@kit.edu.kh	panhavornnguon	$2a$10$1ahDTbu7PHuqNI3PZersOupqN97.FCClphXT1vRJdPCsqREpfG2w2	\N	STUDENT	9872223	MALE	t	f	2023-07-14 12:21:43.659	2024-02-08 15:45:30.377
a60bc086-f5ed-46bc-8f81-64bb74b7e367	mengheang.ros22@kit.edu.kh	Ros Mengheang	$2a$10$D0.WMyz1L8aI263y/lNWNuGTbffpzVBn6.441oJ.1X9NsttZU0p9q	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:43.694	2024-02-08 15:45:30.381
a75f5339-6cda-4497-89ca-1758ba55aff5	daivai.cheong22@kit.edu.kh	Cheong Daivai	$2a$10$taaUNdmj.OJLMeBRnVHaZeL19s51d21t1d0uJlYo012Seum/Ht5/6	\N	STUDENT	2399999	MALE	t	f	2023-07-14 12:21:43.775	2024-02-08 15:45:30.384
a09997df-b639-4e8f-97e5-2ba3b2ae3490	a2acallback.voip@kit.edu.kh	a2acallback voip	$2a$10$xzKZgUw4azu7Uixkz4FHf.kOc3kt8fN0D79v/OWHb925xOQ5BZ3.y	\N	STAFF	\N	MALE	f	f	2023-07-14 12:21:42.855	2024-02-08 15:45:26.305
2d58be9d-10a0-486d-9b6c-0b76b4cd9b7f	batch_six_six@kit.edu.kh	batch Batch_six_six	$2a$10$p5KjA0f9YlTnHX9KenkXGeWgYW8qF2rIz0V5q8.3YS6BpaI5.O1/q	\N	STAFF	\N	MALE	f	f	2023-07-14 12:21:43.565	2024-02-08 15:45:26.313
c1d4a056-16df-47d7-aae4-90231f2a4b6a	cloudny.cumayao@kit.edu.kh	Cloudny Cumayao	$2b$10$ceyue.ocgVgf61susiYe8eIrMJZaHSy8l2atzayYcG.XDtUSobNMu	\N	STAFF	\N	FEMALE	f	t	2023-07-27 09:00:16.15	2024-02-08 15:45:26.339
0bdd9958-cc59-4a75-923f-631f4ee944f3	kitinfo@kit.edu.kh	äº‹å‹™å±€ã‚­ãƒªãƒ­ãƒ å·¥ç§‘å¤§å­¦	$2a$10$0e2BuMDreufpeaS72aQQkeOngP7tHBS7PiC4Oop5Yt1PrrB8d8rcq	\N	STAFF	\N	MALE	f	f	2023-07-14 12:21:42.839	2024-02-08 15:45:26.348
f1374dc6-94d4-4ec8-a722-6c2637e294e2	sempeseth0963050057@gmail.com	Peseth Sem	\N	$2a$10$eWH.IwpEZIFZiDGHv6UXjO62Fxqn5dJaD3piwHFByMBuZdO2t3TxK	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.63	2024-02-08 15:45:26.378
064decda-bb06-429e-8111-679c35681316	chhornvandate16@kit.edu.kh	Vandate Chhorn	$2a$10$dxgo3N/XGvYXgPEQvW0G7emeH6emhJLmnlJJt97ZSeWHvB8kNMAX6	\N	STUDENT	8559623342	MALE	t	f	2023-07-14 12:21:42.507	2024-02-08 15:45:30.393
11a33a9e-1738-4c73-95d5-308ebeedc0f9	menratana14@kit.edu.kh	Ratana Men	$2a$10$7ycmajujPQqF103GbRMS7ODAaDTYJkUY.qijIxMf4SV9gjbnP8Q02	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.534	2024-02-08 15:45:30.397
0851dfa7-9103-4755-a4ab-3ef6c08c044e	tak.vannak19@kit.edu.kh	Vannak Tak	$2b$10$kyMlvSEB1wSXqwJeBK5tBelcOas4hIzLYEtGRQFEsN4zOk6VG1COG	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.038	2024-02-08 15:45:30.402
07e21d38-8a0a-448f-8761-a5c2786b29a2	pich.veasna19@kit.edu.kh	Veasna Pich	$2b$10$/.569mBORY4kIzvmKn8Q6u34/c6mZQB30AJRzonXn7k38l5Qud22q	\N	STUDENT	78934423	MALE	t	f	2023-07-14 12:21:43.226	2024-02-08 15:45:30.406
09b97077-7d8f-439c-94b5-c66e2cc5a472	sak.lysem19@kit.edu.kh	Lysem Sak	$2b$10$YmlGJIAenwsjBFBbBhZ9quakj.ME0n7qCQYs1uw7pCUNdSsnbfxIG	\N	STUDENT	969997089	MALE	f	f	2023-07-14 12:21:43.232	2024-02-08 15:45:30.41
0bd74f14-bc42-47dc-ba39-912895d0152b	ricky.davan22@kit.edu.kh	Davan Ricky	$2a$10$wjrcMrSkpDEwejOsoftnEe2m3iPwp7FvVRMx9elOPjgnar/91CRk6	\N	STUDENT	2399999	MALE	t	f	2023-07-14 12:21:43.786	2024-02-08 15:45:30.414
12ada5f8-962f-40d5-9e2a-6d5cdb47fc01	ichigotaga18@kit.edu.kh	Ichigo Taga	$2a$10$afeKv0hejVqZtEEtDNG9/ueGfz4SSl9W9B174TJhxqDP.cmkjlpju	\N	STUDENT	87940811	MALE	t	f	2023-07-14 12:21:41.294	2024-02-08 15:45:30.422
0f678b08-d9e6-46f7-8411-a3eb93bc3b72	tounphanhavireakboth18@kit.edu.kh	Phanhavireakboth Toun	$2a$10$hHkBNKRrgCTUgAl.RW.AXOfBmP0iI/E/9Ed79w2Dqc4uMoumgubLi	\N	STUDENT	95277784	MALE	t	f	2023-07-14 12:21:41.642	2024-02-08 15:45:30.426
05b19571-234b-4a3b-afff-416ea1acbdb0	ngorkimseng15@kit.edu.kh	Kimseng Ngor	$2a$10$8sfL7tHsiyGWXcw4mQiLkOm2V21WPn8KEJCjWy/za.dxi8ZjG/x3O	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.406	2024-02-08 15:45:30.43
0fd638df-1155-47f1-9909-d70973805f33	soksereiponna15@kit.edu.kh	Sereiponna Sok	$2a$10$FgksRlb1f4BTzd7QFhtP5e8UkVm/nfXkoPcZvrsfmwmT/Wc1QAKrO	\N	STUDENT	963929030	MALE	t	f	2023-07-14 12:21:42.446	2024-02-08 15:45:30.434
179723a8-a43a-4009-89e7-c41c89176edf	cheng.mengly19@kit.edu.kh	Mengly Cheng	$2a$10$EdHTUugP/y5mVBsW9eG5/u3/0mxaGQFzUW/3J.2O/YKIvvYX60eji	\N	STUDENT	11428092	MALE	t	f	2023-07-14 12:21:40.796	2024-02-08 15:45:30.439
1943f5f9-4473-4425-ad80-9c8587b034c1	heanvorthanak14@kit.edu.kh	Vorthanak Hean	$2a$10$LN10j691z1ty/n87MgZJiuCJRyG2d807tNkaTkeTYib433Qan56L6	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.561	2024-02-08 15:45:30.443
1537d0b9-d64a-418b-831b-2eff539dd827	nobnisai16@kit.edu.kh	Nisai Nob	$2a$10$XoUDsKb5cSdTor5YOzfJyOw8eeXe9/lkU0V5C5Hc8uKcW3Q4l.ip6	\N	STUDENT	10959546	MALE	t	f	2023-07-14 12:21:41.67	2024-02-08 15:45:30.447
173e94ab-1303-4b79-8181-c3ecd4bb3b36	thoeunsopheara18@kit.edu.kh	Sopheara Thoeun	$2b$10$lKyUdCFEZB9f5gIeykyQee6Db09VyM8CYJEizqS5TkBHFwC1MKB7q	\N	STUDENT		MALE	f	f	2023-07-14 12:21:41.734	2024-02-08 15:45:30.451
175950af-4e37-4cf9-88b6-1bf3d721296c	neakpanhboth18@kit.edu.kh	Panhboth Neak	$2a$10$UnuitS2KSOg7MjZ1Pj2W8uOCEPBjBAjD.1dYBbrWUDjxXmnc1HO/O	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.865	2024-02-08 15:45:30.455
1883297e-5445-4f0d-af44-67582c85724e	junseiyamamoto18@kit.edu.kh	Junsei Yamamoto	$2a$10$hhiSI/Iq7icQjVeJkvix1ecrBLzfQuhgZwIKu3D2g2UWVMKuT2TVi	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.43	2024-02-08 15:45:30.459
16ce1e36-f68a-481f-831d-95ee59447c5f	hikari.suda19@kit.edu.kh	Hikari Suda	$2a$10$9u5gVmtxOf5GG.1oxr9uMePbla/XY3FY69.33rh6h9zernM/66uAS	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.794	2024-02-08 15:45:30.463
1574f83c-56c7-4bb1-b60f-b627ba701449	tek.zanith19@kit.edu.kh	Zanith Tek	$2b$10$VHqFiOxHI6gt905ba2A7iuCfEjvZHFK0m9n08xZsL74emM2WAVY0i	\N	STUDENT	85930693	MALE	f	f	2023-07-14 12:21:43.259	2024-02-08 15:45:30.467
17183098-78bd-44d0-8fab-05c422a0cf55	eavheang.oeng22@kit.edu.kh	eavheangoeng	$2a$10$/nnBR7zLoZjkXHqAL9FuD.E1bP/zO1/hsl.cYQNpoVbseigSTTTcm	\N	STUDENT	9872223	MALE	f	f	2023-07-14 12:21:43.671	2024-02-08 15:45:30.471
4192c694-dfe7-4987-8f65-f0c86b8e42b3	nyyanty18@kit.edu.kh	Yanty Ny	$2a$10$7DSotqKGraH8jZiJs2WyO.iu80RU54kn1VRKAP/TyeZ3pIJ0sFhSK	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.042	2024-02-08 15:45:30.475
f09e7966-6ea2-4520-b933-744b35a147d3	chy.kimtong19@kit.edu.kh	Kimtong Chy	$2a$10$nx3XMUk4FTK0bG4C6SQsoe2Nvdp.qDDKh7I4gQmIexZ9p8T2fbdTG	\N	STUDENT	16622971	MALE	t	f	2023-07-14 12:21:40.749	2024-02-08 15:45:30.479
f15488bd-dbdb-414d-a1b3-3999569519be	udamvisal18@kit.edu.kh	Visal Udam	$2a$10$kK2PNd0dnvxDTS5/Z5Qbeuw44KV88KzxlEGnbCdT7jp1n96pv7K2m	\N	STUDENT	964078207	MALE	t	f	2023-07-14 12:21:41.47	2024-02-08 15:45:30.482
f37369a3-1ad3-4569-a2c0-f8fb349ea7e6	uonsokhuong18@kit.edu.kh	Sokhuong Uon	$2a$10$re3GyrWOvpA81eDIzjWgUOPGxNwRpSZQWZbdzi6OPKPI3mHpn3rYC	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.824	2024-02-08 15:45:30.486
f0bc1f54-032b-430f-a22f-885b8f68bd20	voeunthavin17@kit.edu.kh	Thavin Voeun	$2a$10$6qD3uMMmWcMl/4exhBNnoOWsd9m0HpYjAthe2GpizkBiJDm1UHXCK	\N	STUDENT	69252508	MALE	t	f	2023-07-14 12:21:42.174	2024-02-08 15:45:30.49
eed4612e-a1bf-4598-ba59-4fd81d1cd32d	hannmanich17@kit.edu.kh	Manich Hann	$2a$10$8picN5hZNzg5h.N8gup0TerznuUFA/K6aZhAa7GeI6v8WkbDp6kqe	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.211	2024-02-08 15:45:30.494
ee2a6f28-fb30-47f4-917b-2ccf98323916	sornphaneth16@kit.edu.kh	Phaneth Sorn	$2a$10$cH7tfGyUQ0X3AnvAjMTB0.bL1sXTraX7oILrrcGn9SWroafl1Ep0G	\N	STUDENT	98892321	MALE	t	f	2023-07-14 12:21:42.23	2024-02-08 15:45:30.502
eb70e639-7ca0-40bc-b49e-4734b020e8c6	ryunosuke.okuhira19@kit.edu.kh	Ryunosuke Okuhira	$2a$10$00s9B.bt3vc10bYRwMujxuOAGf2k.pC3N4nrcgay.NND0hYrb8p6y	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.729	2024-02-08 15:45:30.506
ec30d151-8593-46fd-b923-b3616d9719e4	chhoeurn.sokheng19@kit.edu.kh	Sokheng Chhoeurn	$2a$10$vDwGsjKPevUtAMO0uk7FFegkZEiKGtWOzXNiJva.DA19Q56oH6p4u	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.457	2024-02-08 15:45:30.509
ede3001d-29ce-4f0a-84a0-db51fef18069	mengheng.yun22@kit.edu.kh	Yun Mengheng	$2a$10$DYCJnAKTsc.KjcEw0SWmme4s1/jbe.S78koZd.Lo1Pf5PKBIyTiPO	\N	STUDENT	11111111	MALE	t	f	2023-07-14 12:21:43.746	2024-02-08 15:45:30.513
efb96196-6e66-44a8-8e2f-5e7037865ef4	kimkhimmengkheang.khorn22@kit.edu.kh	Khorn Kimkhimmengkheang	$2a$10$fufJYWY5oKPbELfY0V9ybOFM2e4JvSBtXV9EJbLon4dWs/GEaBOiy	\N	STUDENT	2399999	MALE	t	f	2023-07-14 12:21:43.804	2024-02-08 15:45:30.517
f2477f78-a9c3-4804-9575-5244a8a62e6b	lay.sophann19@kit.edu.kh	Sophann Lay	$2a$10$68VCHRwjhhtoNrGZyqtBo.ySdqxUrU1FLoVKAzqRLire/Tiy4gO.G	\N	STUDENT		MALE	f	f	2023-07-14 12:21:43.427	2024-02-08 15:45:30.52
97fc387a-7f37-41fe-b5ab-aa9216ff8a77	sethsreynin0963050057@gmail.com	Peseth Sem	\N	$2a$10$TIT70WL1t3IweuLfW3CoiuC1Hm7NtB74GrK1IELfVFdeDCMe4TX8e	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.643	2024-02-08 15:45:26.384
a01139f8-911d-46f9-9988-20b68bdc72ef	vansen.hengmeanrith@gmail.com	Vansen Hengmeanrith	\N	$2a$10$KwbKOz9uGzKLWgUfikfBUOO1ZX.XQTkS7gklKIOgc.HJii9OdbWKa	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.723	2024-02-08 15:45:26.465
ad3c8de5-0693-41fe-a12a-52d3b48dd2e2	yinmazatin21@gmail.com	zatin99999	$2a$10$9E.NT9F0g00ieILP5f5RI.2g7Rlh2AP6.IAmduh65j0vs1bhCIHsG	$2a$10$7YTUJmHtTlISmtUI7tlDs.z3gdWA3UXVm1Q0S92U0Yu.88EJYDL0u	CUSTOMER	85586683137	MALE	t	t	2023-07-14 12:21:38.796	2024-02-08 15:45:26.541
1b563125-d018-4ff7-af19-8d5ab042ac33	maria.boklach@ciaschool.edu.kh	Maria Boklach	\N	$2a$10$Sio3oIY3mFxshMRzj3V/0.hl18lZZbuEum0zsU1RN/0FJ8X/M4lJy	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.823	2024-02-08 15:45:26.574
6c31b01d-7291-4d2e-ac15-639185f69b89	bilal4life@gmail.com	Bilal Amir	\N	$2a$10$6cjhn4RleiFZnG7rxEZTAupasKGljJ2iKQEzAiNC6.OgDUq8BkbQm	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.895	2024-02-08 15:45:26.645
168da085-4e6a-4f1f-8c16-40d6c1681e60	sothybunthoeurn@gmail.com	Sothy Bunthoeurn	\N	$2a$10$IiuPD6FU.tIKuve9Cs6p8uwKuTzgYweeRHkBCqRXTcwMOkVbTre1G	CUSTOMER		MALE	t	t	2023-07-14 12:21:38.975	2024-02-08 15:45:26.728
26f83bd7-814b-4014-927e-8c93a234277f	vannak@sbs.com	vannk	$2a$10$CoFVs.pDFVVNQ2Rl1wgiL.BJDIlpwR8bG0JYcso4KZmo/ZEpCb8Q2	\N	DRIVER	77332779	MALE	t	t	2023-07-14 12:21:39.014	2024-02-08 15:45:26.759
e1ed41b7-fcfd-4fe8-9dc3-16fb9d821320	ryosukekosaka0127@gmail.com	RYOSUKE KOSAKA	$2a$10$rCVEXfg4AviYPKa0LXVgCOQfyKTKlpH5PXmEpPH3PTTNzrk8hI8tq	\N	CUSTOMER	8038326535	MALE	t	t	2023-07-14 12:21:39.074	2024-02-08 15:45:26.816
d4d1bee4-5858-413d-8501-438576d411c8	vongsieving@gmail.com	Siev Ing	$2a$10$GHQrAWjACyumAVaxFDms8O//GeTLrw5.NZbXbhDDPYJc2Ucqmgam2	$2a$10$adOYQEjbm/BsSS49mBJUxeHFyPSy6xR8z833ZQXGkAsal0bzNL6xy	CUSTOMER	69696828	MALE	t	t	2023-07-14 12:21:39.175	2024-02-08 15:45:26.91
2afe3a0e-a85c-44da-a10e-c3dfc6a80ca9	peach29.0619@gmail.com	å®®å´Žæ¡ƒ	\N	$2a$10$VSYSEPswBiJ50VXkrPnxR.RHttDRfNN7bYVpfLtpFkxilxCWdKG/y	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.207	2024-02-08 15:45:26.936
c7cf595e-7a30-4a0c-b611-7e8c14dec761	sokhavudthisong@gmail.com	Vudthi Song	\N	$2a$10$qmtQPHdON5szB75zHccpe..ImEAR/Bq3drX1ZdAJe5gKQ4hNafGJq	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.282	2024-02-08 15:45:27.001
aa796ce0-413e-4277-ad36-9b9fb51df2ad	lavenderbasil0606@gmail.com	Yuki Izuka	\N	$2a$10$zsyRVl1BxERglAhPPGRm6./Y7H1upeBDGt0vchTai5fWSYRXACnwm	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.365	2024-02-08 15:45:27.078
8ee0ceba-5557-4e9a-8897-2bd46cb341af	makaraprom69@gmail.com	makara prom	\N	$2a$10$sDW0xOAK5Py.BCjbtq6O5eIjMnsmTMg3dTE5FBnL2enO2dvFKrBjO	CUSTOMER	12345678	MALE	t	t	2023-07-14 12:21:39.409	2024-02-08 15:45:27.116
d9bc14af-a842-4452-b18d-639a6b42063e	miratorimoonlight@gmail.com	MiraToriMoonlight	\N	$2a$10$RuM9.thuDMJr.cmESx8IUOkugnLxbmOIApv688VyawSpN1jmcuR..	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.419	2024-02-08 15:45:27.125
33c20c28-4c4c-4649-8dc3-466c8334fe8c	sokheng@sbs.com	Sokheng	$2a$10$0y50MQzD0/Z2tTn0K2kEBubYsyzhuNzrgVo2Rx3Fg8nyCipwx34r2	\N	DRIVER	69230274	MALE	t	t	2023-07-14 12:21:39.502	2024-02-08 15:45:27.2
99e8546d-45da-4e6e-b0f6-b12eba890b03	sophasum02@gmail.com	Sopha Sum	\N	$2a$10$sYzPoAevbTIsyvJnQpDIieThpByoeA1tkgT2susvXM3noO7q74rpK	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.578	2024-02-08 15:45:27.275
5a232203-3430-4efa-ae8b-737f3843ae0c	dss143rathore@gmail.com	dinesh Rathore	\N	$2a$10$U8N0X3d9r50n744YPaySKeZPvqosNRJHTwhXm3Aj065fKfHHC2rj6	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.6	2024-02-08 15:45:27.297
7e8d8c6b-8643-48e4-a41d-635f89a340bc	kimteyley@gmail.com	Kimtey Ley	$2a$10$8aj12mMfqOPdkDAVLmsY1uQtJDf9feJRWt5tTrZF3klOkhIXSF2ge	$2a$10$HibiaSRtx4jn4UIhOKrtDO//YXkySdJsv3CqqUtYVK0TkvhXSkiFG	CUSTOMER	969972555	MALE	t	t	2023-07-14 12:21:39.651	2024-02-08 15:45:27.345
e0df823b-5567-42f6-a825-fb414becbfc6	simchhay65@gmail.com	Sim Chhay	\N	$2a$10$jsImFEIhLm1QF67Z6tMY.ur5ocdfB1E1i0mDVwzUNc1cmvD.Ssggi	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.772	2024-02-08 15:45:27.46
38fc16a7-1ba1-4ba7-b23f-7370d38cf962	godmeng14@gmail.com	Lim Huameng	\N	$2a$10$jGRAMHAqX8Dyy70fSvG86.tDfrNKMnN8lV3wFgypPBsvCJz6gizYC	CUSTOMER	87555087	MALE	t	t	2023-07-14 12:21:39.782	2024-02-08 15:45:27.469
68b1baf5-3fa4-4478-8f5f-4c74b7bbd20b	sir.ratanak@gmail.com	Vorn Kiriratanak	\N	$2a$10$GC52bpg2sz5bHXUWGl4UAOXOiHexMyoBFMYNY.64Zlaxtow.gFmfa	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.8	2024-02-08 15:45:27.483
e439263a-8704-4d13-9ceb-dc0bb84b0692	tekzanith@gmail.com	Tek Zanith	$2a$10$.oHDFNz4yETOI4HBsH0w0.R.PXUAh44bviJYvlW1SmhnPfk92XnQK	$2a$10$dGSJ8lv.7nAhoc9/ukGuHu7iRBtsCYI4LKqqt74aDNkQLjFSZbWIO	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.884	2024-02-08 15:45:27.553
7033587d-1fcc-4272-ab36-a6c1f977ce40	kkl.aravind@gmail.com	Aravindan Srinivasan	\N	$2a$10$G8toigR2c1VUw/MhM/o48.mw2tnvQHQkgs9Au.4fBB56qT5nvBpke	CUSTOMER		MALE	t	t	2023-07-14 12:21:39.982	2024-02-08 15:45:27.639
498f5467-031b-4892-8ae5-79f5b71dfdb4	kuy@sbs.com	KUY	$2a$10$eZEEKSDr3S82ojbXgLUyxukDlxZbTU9QFed/su7SuYxW/uUXX.nIC	\N	DRIVER	69315383	MALE	t	t	2023-07-14 12:21:40.027	2024-02-08 15:45:27.679
90ac374b-e443-4716-a7d9-e9656af0b790	chantha@sbs.com	Siv Chantha	$2a$10$A9VxHpV5oFdkWZIzh2ARFub64jYiervw4Lq91OxTu8sXQ/FurWhne	\N	DRIVER	962619999	MALE	t	t	2023-07-14 12:21:40.099	2024-02-08 15:45:27.745
f2daf226-26e3-41e2-980d-18c8c51c74d6	mototo126@gmail.com	Motone Adachi	\N	$2a$10$4l66XpXPVVT4xP5cOamWre8zWkb4DUZKOm8MWAhTyWzGp1Vt8iGmW	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.166	2024-02-08 15:45:27.812
a5c1f755-6c6e-47ff-9553-886a230c2c48	jen.jewett@gmail.com	jenjewett	$2a$10$D4oUxlITC4ptcz7AfUJgzOKhmae5oue56rEQ7nDoGzf8bvYrB98P.	\N	CUSTOMER	17966746	MALE	t	t	2023-07-14 12:21:40.194	2024-02-08 15:45:27.837
4edf5a2d-7673-49c5-92e6-065e673116a8	suzuki_y.kh@jtbap.com	Yuta Suzuki	\N	$2a$10$FdEddgyAlw42syuxdYHdYe2SZxOcdGjbc9CEYOAZ9TL06NV03dJiS	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.278	2024-02-08 15:45:27.922
78f0d1d0-dc11-40e4-af8e-29f477473bfe	norakrattanakphal@gmail.com	ážŸáž¶áž”áŸ‹áž‘áž»áž€ ážŸáž¾áž…	\N	$2a$10$uGxeA/if3wfNxGLSe2ohFujp9awSO4C2bv6DBkiB48/8o8Pg/6B8W	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.336	2024-02-08 15:45:27.976
c3de77fc-4084-473c-a30e-b268ea63cccc	beapuro1@gmail.com	bei	$2a$10$dvmmXKYKryIlo0LClJUynOrm3mVOJH5qpQerxBtxbSmBp2XLhoryq	\N	CUSTOMER	99821590	MALE	t	t	2023-07-14 12:21:40.35	2024-02-08 15:45:27.988
5b19817d-4c6b-47eb-a057-11754ec7cc0f	hinsocheat@gmail.com	Hin Socheat	$2a$10$oGUnACHgPBJmVRzbOOk/8.o85G9Ud4K/Uaw2pWtzw9K/LVfFdxtP2	$2a$10$kOUt4xpTTEFRl/TkyGEbv.edscbtIjRR2dwCQHQStDV1/Bi.WUdMq	CUSTOMER	96936569	MALE	t	t	2023-07-14 12:21:40.359	2024-02-08 15:45:27.996
e0b9b0ce-32ce-44fa-9249-4f037c712337	srun.kimleang24@gmail.com	srun kimleang	\N	$2a$10$VXVZ.54yyIpWw.B5faryDe0o/76B6C97U4T2P5nD.D8R8.SUYbg3e	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.474	2024-02-08 15:45:28.105
5250e3c3-6275-4047-954a-482c3acce023	amaladossleo@gmail.com	Leo Amaladoss	$2a$10$hw7QDB702qYnjKcwRV0HTOouAkrT58DWgsclVfPr7C1IZfubFC.vm	$2a$10$92JjNN3UUBHWsQD4hkQWi.GUWK/eZPhfrZpR/LcOrnan.c8cRZFkm	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.523	2024-02-08 15:45:28.154
0da26372-48ab-4a7a-947b-e651ca1b79b9	giardino.giulia00@gmail.com	Giulia Giardino	\N	$2a$10$WUNxwJjFlyKq123FjbNmbOrIFcVvQaXkSrilEfk2j.Sjja16PBMLa	CUSTOMER		MALE	t	t	2023-07-14 12:21:40.55	2024-02-08 15:45:28.181
95da5417-3369-42c6-a38f-ea191168d51a	shamiso.p.nyajeka@gmail.kit.edu.kh	shamiso	$2a$10$nrR2xl0FXg6p8XIWKRiF4.EW0arwG4PicitJbJJ8EpPIpiMYx3GVu	\N	CUSTOMER	967754792	MALE	t	t	2023-07-14 12:21:40.625	2024-02-08 15:45:28.252
b166f660-eea5-46b4-af50-e71d5554cd8e	yi.chandara19@kit.edu.kh	Chandara Yi	$2a$10$2Uk8s6tl.GlW0PFhQCBi8u/EV3NXz19wG1DH6txfjnNrpuPpiKj9O	\N	STUDENT	965842517	MALE	t	f	2023-07-14 12:21:43.303	2024-02-08 15:45:28.321
bc3243d6-46cc-4bb7-90be-f4277888d4ee	uytaravann18@kit.edu.kh	Taravann Uy	$2a$10$WjB1QX27tZKYtIwkTisi8OkMsD0Hceg6K/jKubyJ53TEZUY.zWodq	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.487	2024-02-08 15:45:28.381
28763b44-00ed-4901-8793-aa8419c8aba2	ma.chanvesna19@kit.edu.kh	Ma Chanvesna	$2b$10$tV0jbRCX.bH9Lij5Gy.uhuvQ3LOCiDxBte.n6JN.R.uTSi5b/lMHG	\N	STUDENT	86494972	MALE	f	f	2023-07-14 12:21:40.963	2024-02-08 15:45:28.446
1e213d78-0641-4db7-99f6-c23d356bc014	harvee.banglag@kit.edu.kh	Harvee Banglag	$2a$10$8gMXRaIZPBJF4oUfEU6cX.lVSdRKbC9O3E.yYj.2/3a7zFDqS4ho.	\N	STAFF	5586971730	MALE	t	t	2023-07-14 12:21:41.538	2024-02-08 15:45:28.481
74925e2d-6d3d-471e-8ce2-a8826c429d94	reasey.sereineath19@kit.edu.kh	SereiNeath Reasey	$2a$10$EnyMXPRKaH/nS3sxrYRR/OxO/rzT792b518Gr0VVr1gPrO9dOKNxq	\N	STUDENT	93616172	MALE	t	f	2023-07-14 12:21:40.854	2024-02-08 15:45:28.486
932e4409-c24d-4c1e-b4f5-37d9311b2350	ingvankhinh18@kit.edu.kh	Tut King	$2a$10$eU6cgAbU/8sH8iJoVyXeweixhnkTeDjJnTSOa4MV4dm.AEEhlWDJK	\N	STUDENT	968435508	MALE	t	f	2023-07-14 12:21:41.447	2024-02-08 15:45:28.57
abdba6bd-8c86-4afa-919c-cb3d3cf075ca	lyoddommony18@kit.edu.kh	Oddommony Ly	$2a$10$B18W2AAhJCHBdFa7vMJkKO6pPmpXE.zrpwu9dpXeR2J7.gUgpCkSq	\N	STUDENT	98221594	MALE	t	f	2023-07-14 12:21:41.533	2024-02-08 15:45:28.644
9e8e6050-b09a-4de3-a661-101609782338	leykimtang17@kit.edu.kh	Kimteng Ley	$2a$10$WTnOk5eSdbAhzSK.DkSRNupzDnpIC0FbGqZLiwEkxOzIYr7Sug0Ia	\N	STUDENT	966668587	MALE	t	f	2023-07-14 12:21:41.848	2024-02-08 15:45:28.648
ad6c7e9d-64c2-4502-b0de-9af77f9761ac	maotimong20@kit.edu.kh	Mao Timong	$2a$10$o27u4P3zjMl3I3kvGDN3yOzASZH0Q/PA4bzpNMR9yuGhCg3vh79Cy	\N	STUDENT	86773786	MALE	t	f	2023-07-14 12:21:41.091	2024-02-08 15:45:28.653
b5fff0ca-9f60-4278-9ed4-7cf1420da2e0	leo.fernandez@kit.edu.kh	Leo Fernandez	$2a$10$5IODp/pnTtL22JoDubFeOOShRFT82C7iP.ALVYeeWv7EmgEWXs8bK	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.539	2024-02-08 15:45:28.722
13268378-7cd3-4327-9de9-0f9cd0d0e24c	nadia.alrousan@kit.edu.kh	nadia alrousan	$2a$10$etGCMNmiPsUqJDdvp.bbS.BkdRWMHsDLqpEhO1zxOfmGr5ed8atte	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.66	2024-02-08 15:45:28.799
c8b5b2d1-842c-4665-977d-c62a0f01f8ce	kye.stevenson@kit.edu.kh	Kye Stevenson	$2a$10$V4r8d3XYrtHQPb..AzbqGuKXEskGE1BBTC5GwfhzpOc94tsZ0jXsi	\N	STAFF		MALE	t	t	2023-07-14 12:21:42.911	2024-02-08 15:45:28.884
247f88a1-1b9b-4d3c-aad3-7bb9263d976d	pleasecheckyoursystemagain.wedontdolikethat@kit.edu.kh	fuckhackednothack	$2a$10$PkDS18LNjNbNKMr7TjEVt.drsgk2MgZxyMA0Aw6FHYlmfL5hSdwK.	\N	STAFF	3234234234	MALE	t	t	2023-07-14 12:21:43.032	2024-02-08 15:45:28.958
fd4cd666-cb75-4ab0-9e7f-77dc1e0ebd7f	chhiv.bunchhean19@kit.edu.kh	Bunchhean Chhiv	$2b$10$zPcQcQ1UxwkdIYlRsmyKouSi8iHhNll3GnjuvbfDH8gUAZw1trqy2	\N	STUDENT		MALE	t	f	2023-07-14 12:21:40.849	2024-02-08 15:45:28.991
e65120ba-14f1-4838-bdd9-28324d945a55	heidi.bongabongbanglag@kit.edu.kh	HEIDI BONGABONG BANGLAG	$2a$10$3MoxMmbWwASEqMoqx5iXreEUI1niT1gpvZpygByNKDp3QNC3SSJkW	\N	STAFF		MALE	t	t	2023-07-14 12:21:43.554	2024-02-08 15:45:29.055
aba904bb-c7a8-430e-ad9d-5ed1762eab65	chorvisalrotanak18@kit.edu.kh	VISALROTANAK CHOR	$2a$10$WJgLIYbQGJc0BqmX4iOVjegoDH.xB5oNJ1uo46PuSEejdHTiqjNJu	\N	STUDENT	87952425	MALE	t	f	2023-07-14 12:21:41.43	2024-02-08 15:45:29.203
c0cdefd1-2eff-45c5-8327-e3cd1c8e962e	kong.sovankiry19@kit.edu.kh	Sovankiry Kong	$2a$10$kktoYeOmB1KRklpMHj5Y1eLhdQHdxBg5SKUqmK8XKp0nV9.kFab16	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.409	2024-02-08 15:45:29.242
df2ca7f9-3730-4831-8f90-3da707e179da	miliya.sokun22@kit.edu.kh	Sokun Miliya	$2a$10$EPEsVGyo8He0R9/uin8ivOSSVc5Q3YJZWFSX6GYxxhoziHgAA.xPO	\N	STUDENT	2399999	MALE	t	f	2023-07-14 12:21:43.763	2024-02-08 15:45:29.254
35282e55-cc08-4e9c-9e8b-0380fbd341bd	nhekpichpanharith17@kit.edu.kh	Panharith Nhekpich	$2a$10$1F/XSoZXuVxc5NaI1aOTnelZ/SF8kndhmw6yLsOSrPhJmDve9p/AC	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.029	2024-02-08 15:45:29.327
e885e7b0-f51e-449c-ab42-22e6563cae4b	lock.borethdevid19@kit.edu.kh	BorethDevid Lock	$2b$10$YuVlS8z.h.TfUX7SMUlPYeEplzveJA7OKaFNEpEAnSJewyKLL0NbK	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.049	2024-02-08 15:45:29.405
56ee4b69-a52d-479a-b595-b0eff3b7f5f4	longmakara15@kit.edu.kh	Makara Long	$2a$10$NyFh4/.f2wd8BkYyPIvSbu3KgLgOTeHyjM3Xkayg7YrhY06/WWY8G	\N	STUDENT	963474712	MALE	t	f	2023-07-14 12:21:41.676	2024-02-08 15:45:29.41
556a34ab-6212-47f3-ab0e-f68f2d44bdc3	sanysaksrieng16@kit.edu.kh	Sanysak Srieng	$2a$10$BzG2Iz.YrTq9cKCkZTShHukfJh6eQTnrnwWFZRr4jfaKXHUbSLDa.	\N	STUDENT		MALE	t	f	2023-07-14 12:21:42.474	2024-02-08 15:45:29.489
6aeaa888-7f7b-4a09-81cc-e596998c96e8	reth.sokmeta19@kit.edu.kh	Sokmeta Reth	$2a$10$nNVOkYmeeKf8f6buxt1l9eCE3FH/E7Uo/skZ578DIm8CKMJpk6Q9.	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.15	2024-02-08 15:45:29.561
7cf7bf9e-6480-42cd-9d02-f457e0106325	phonsokpheaktra18@kit.edu.kh	Sokpheaktra Phon	$2a$10$cuqW7tPVEBkFRGV6ZNq52uZG.2VuQwTPYy0OB9JHyKRleWeuhPX72	\N	STUDENT	85505505	MALE	t	f	2023-07-14 12:21:41.681	2024-02-08 15:45:29.575
788d6c3a-dc03-4758-b3d9-5465c05edbf1	sanbunny14@kit.edu.kh	Bunny San	$2a$10$M4ME0nC.3s2556RI8EqnD.AJ/OBXNgsd6/SVqa5n2P1PfmPoOYiaC	\N	STUDENT	979204601	MALE	t	f	2023-07-14 12:21:41.745	2024-02-08 15:45:29.588
5fa859f4-b299-4660-88d6-4a86f2bb9153	hangchanthavy20@kit.edu.kh	Hang Chanthavy	$2a$10$0FnzrlM/AhV85Bqpvg5GiOBDRH9EVB02HEcksQ/GGqnvRYCQuGcl6	\N	STUDENT	85894656	MALE	t	f	2023-07-14 12:21:40.698	2024-02-08 15:45:29.665
86d0bdee-d881-4084-afe7-b2c4711144d8	thavareak.hourseth22@kit.edu.kh	Hour Seth Thavareak	$2a$10$9MvwAuoY4gOxuUVaUsVSM.1F14E1SQ4fldkMkrxDhLK4pcQutB0LK	\N	STUDENT	2399999	MALE	t	f	2023-07-14 12:21:43.798	2024-02-08 15:45:29.739
91f359f7-87e2-4e9c-b815-c1d5c765fbd2	cheysreylin20@kit.edu.kh	Chey Sreylin	$2b$10$nEpIoWJbB9UX36qZ29Cd7OV5pFQnIyE4dWj7VzhAKxvkB53i9HR4e	\N	STUDENT	1111111	MALE	t	f	2023-07-14 12:21:40.762	2024-02-08 15:45:29.747
8ecf1303-7a73-4f17-9a12-76b23a387c83	khunthengputhirithea16@kit.edu.kh	Puthirithea Khuntheng	$2a$10$eFSGgOhixzWbPwHWx7vgF.yLEHjMaYO5E7T.3NOUKLsXmQ.pnFrkW	\N	STUDENT	10315858	MALE	t	f	2023-07-14 12:21:41.526	2024-02-08 15:45:29.792
26609761-27b9-47e0-aed1-29ea37b86307	phokchanrithisak16@kit.edu.kh	Phok Chanrithisak	$2a$10$Z.HTlehRCL3tuYCep4pGO..brDCusx8pcpj5feOc54LD0eZZyw76q	\N	STUDENT	86833970	MALE	t	f	2023-07-14 12:21:42.469	2024-02-08 15:45:29.871
7dab0a8f-8959-4c6d-b4b1-0d2388ad0cc3	ay.norakmolika19@kit.edu.kh	Ay Norakmolika	$2b$10$wJFoQPByF3WeKGv9OMaH.OQSmtppGDeBBrFXu70vsCbx7pMbSXKPO	\N	STUDENT		MALE	f	f	2023-07-14 12:21:42.742	2024-02-08 15:45:29.909
d35f0e96-b589-4d5b-bee6-2293a66c0a5a	chanratanak18@kit.edu.kh	Ratanak Chan	$2a$10$g3opyJZjJHLhvh.SVNxTLO45K/fmg/9FQb0AmdiXVKCwnGu4.Bgqu	\N	STUDENT	92555965	MALE	t	f	2023-07-14 12:21:41.242	2024-02-08 15:45:29.925
ca1b3103-d9cb-400e-b939-b1a575b78830	bouromdoul15@kit.edu.kh	Romdoul Bou	$2a$10$xbTxwyaXHkhEA3B8B/003OplGnqnUORHm6bXdbqATAgnTkVD3.Ab6	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.751	2024-02-08 15:45:29.998
fb366f4d-2228-447c-9455-7a58b5d858f5	yean.sovanvathana19@kit.edu.kh	Sovanvathana Yean	$2a$10$HKuJltV94/eUCZciXUthjORBtnLx2mqcNp/OozwhS0NzbOeW4W6HK	\N	STUDENT	16420165	MALE	f	f	2023-07-14 12:21:41.166	2024-02-08 15:45:30.068
ff27db98-98fb-49aa-a55e-e1f0cb3270d9	nhetlinna18@kit.edu.kh	Linna Nhet	$2a$10$JqScFFs5rHh7MFV4O3s.keQKBKlkHT3.B0GmhvpbqQXBy.1ZmuGfa	\N	STUDENT		MALE	t	f	2023-07-14 12:21:41.318	2024-02-08 15:45:30.081
db1e3e5b-80cb-489d-a369-6e39f7ae8ce0	hoksopheathireach18@kit.edu.kh	Sopheathireach Hok	$2b$10$wwNwXZ4aLW0gKuyVby1MQ.AhgapFTwnoZD55tC1VrnHd6EZpEhsxy	\N	STUDENT	886888885	MALE	t	f	2023-07-14 12:21:41.265	2024-02-08 15:45:30.146
35d2aad3-e1b8-4b40-9a36-7aecc55e7bbd	sireypich.chhorn22@kit.edu.kh	Chhorn Sireypich	$2a$10$lCc.Rgu621RIP.weURUY4usXv984u3ImMKRufShV6OQL1ebJw33dy	\N	STUDENT	2399999	MALE	t	f	2023-07-14 12:21:43.751	2024-02-08 15:45:30.224
44a1d007-4a1b-4195-8622-2b6327ce7498	nirandara.phally22@kit.edu.kh	nirandaraphally	$2a$10$fO7shXIcnwYS9WtuOBuDH.f9tUTlp0ucFuJFbidkwDqIf6ZHvXcMa	\N	STUDENT	85600700	MALE	f	f	2023-07-14 12:21:43.682	2024-02-08 15:45:30.232
632db9d2-4bd2-460c-9514-d74bb5e87762	lyhongleak.chhunny22@kit.edu.kh	Chhunny Lyhongleak	$2a$10$f.mszaFlJG9h8bz1niwQzepCATEivEjfLT/1LyIAbBCVQtWDYs4l.	\N	STUDENT	2399999	MALE	t	f	2023-07-14 12:21:43.781	2024-02-08 15:45:30.27
7f72566b-2d68-43fc-a0c3-2a29baa3d370	ros.sovithyea19@kit.edu.kh	Sovithyea Ros	$2a$10$E0qy3X9hpJ6MxTg48riX8.kr1vUy7/MwXYP11YPUHMhEcQz.lRsl2	\N	STUDENT		MALE	t	f	2023-07-14 12:21:43.277	2024-02-08 15:45:30.36
971ea270-5039-4851-9d86-a09a8e75c5b2	lim.kimsea19@kit.edu.kh	Kimsea Lim	$2a$10$uiU6Igq/kVUGQnAXOcE8MeSsL1iZi3dfrGg/JJIE80XkvS/ppTzaW	\N	STUDENT	81389464	MALE	f	f	2023-07-14 12:21:43.328	2024-02-08 15:45:30.388
0cdb2e12-4cb1-4319-b6ab-cbcc7d1423ce	sophatpiseth20@kit.edu.kh	Sophat Piseth	$2a$10$dbUXlm0JKyfiuSwwp.65ku3rWp66qb8P98FnikJVxSaci/Sdt/zwe	\N	STUDENT	12345678	MALE	t	f	2023-07-14 12:21:41.097	2024-02-08 15:45:30.418
eeff1666-c5d4-42aa-8ef0-cde2cdd2b969	dukpanhavad16@kit.edu.kh	Panhavad Duk	$2a$10$IQcQnsnouKJ6c4szLt8u6.6He6v5qCtgrYKGA6lP8qvOrMT1p2tTG	\N	STUDENT	86861593	MALE	t	f	2023-07-14 12:21:42.224	2024-02-08 15:45:30.498
\.


--
-- TOC entry 3589 (class 0 OID 16546)
-- Dependencies: 228
-- Data for Name: Waitting; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public."Waitting" (id, "userId", "scheduleId", "payStatus", status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3590 (class 0 OID 16554)
-- Dependencies: 229
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: sbs
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
901c7419-8f43-4ea9-9c57-2d41586d0651	f68a3e7749b129190d6517afbd98fbc35efbc37c3f01e60d761f955fa6fe055d	2024-01-06 08:16:48.457689+00	20240106081648_	\N	\N	2024-01-06 08:16:48.268672+00	1
84ec3a98-ec4b-4644-b8e6-d8a9e8473591	ca562110f08f461b4b65eff36edd33c44f1c0d70e7bb5fab4e347c786c284f95	2023-12-14 09:06:33.663243+00	20231214090633_	\N	\N	2023-12-14 09:06:33.478533+00	1
9d6db2d3-7e5b-452f-bd41-86c388ea6be0	14bc6a102fa8ffc465e40b61ed5565a33ec4667c93b4f2a5d33220a305132de6	2023-12-14 09:09:10.951835+00	20231214090910_	\N	\N	2023-12-14 09:09:10.932086+00	1
e937a7ba-e923-4c82-ba63-4073a35fafb1	98aa3f0032ad79b5156f33ea6c6f4ca6fe4fdbf6605bfb27342e483ac884a916	2023-07-14 12:21:33.563052+00	20230714122120_	\N	\N	2023-07-14 12:21:33.295634+00	1
\.


--
-- TOC entry 3339 (class 2606 OID 16606)
-- Name: AdminInfo AdminInfo_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."AdminInfo"
    ADD CONSTRAINT "AdminInfo_pkey" PRIMARY KEY (id);


--
-- TOC entry 3343 (class 2606 OID 16608)
-- Name: Batch Batch_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Batch"
    ADD CONSTRAINT "Batch_pkey" PRIMARY KEY (id);


--
-- TOC entry 3345 (class 2606 OID 16610)
-- Name: Booking Booking_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_pkey" PRIMARY KEY (id);


--
-- TOC entry 3349 (class 2606 OID 16612)
-- Name: Bus Bus_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Bus"
    ADD CONSTRAINT "Bus_pkey" PRIMARY KEY (id);


--
-- TOC entry 3352 (class 2606 OID 16614)
-- Name: Cancel Cancel_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Cancel"
    ADD CONSTRAINT "Cancel_pkey" PRIMARY KEY (id);


--
-- TOC entry 3354 (class 2606 OID 16616)
-- Name: Cost Cost_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Cost"
    ADD CONSTRAINT "Cost_pkey" PRIMARY KEY (id);


--
-- TOC entry 3357 (class 2606 OID 16618)
-- Name: CustomerInfo CustomerInfo_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."CustomerInfo"
    ADD CONSTRAINT "CustomerInfo_pkey" PRIMARY KEY (id);


--
-- TOC entry 3361 (class 2606 OID 16620)
-- Name: Departure Departure_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Departure"
    ADD CONSTRAINT "Departure_pkey" PRIMARY KEY (id);


--
-- TOC entry 3363 (class 2606 OID 16622)
-- Name: DriverInfo DriverInfo_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."DriverInfo"
    ADD CONSTRAINT "DriverInfo_pkey" PRIMARY KEY (id);


--
-- TOC entry 3366 (class 2606 OID 16624)
-- Name: GuestInfor GuestInfor_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."GuestInfor"
    ADD CONSTRAINT "GuestInfor_pkey" PRIMARY KEY (id);


--
-- TOC entry 3369 (class 2606 OID 16626)
-- Name: MainLocation MainLocation_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."MainLocation"
    ADD CONSTRAINT "MainLocation_pkey" PRIMARY KEY (id);


--
-- TOC entry 3371 (class 2606 OID 16628)
-- Name: ManualBooking ManualBooking_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."ManualBooking"
    ADD CONSTRAINT "ManualBooking_pkey" PRIMARY KEY (id);


--
-- TOC entry 3374 (class 2606 OID 16630)
-- Name: Schedule Schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_pkey" PRIMARY KEY (id);


--
-- TOC entry 3376 (class 2606 OID 16632)
-- Name: StaffInfo StaffInfo_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."StaffInfo"
    ADD CONSTRAINT "StaffInfo_pkey" PRIMARY KEY (id);


--
-- TOC entry 3379 (class 2606 OID 16634)
-- Name: StudentInfo StudentInfo_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."StudentInfo"
    ADD CONSTRAINT "StudentInfo_pkey" PRIMARY KEY (id);


--
-- TOC entry 3383 (class 2606 OID 16636)
-- Name: SubLocation SubLocation_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."SubLocation"
    ADD CONSTRAINT "SubLocation_pkey" PRIMARY KEY (id);


--
-- TOC entry 3386 (class 2606 OID 16638)
-- Name: SuperAdminInfo SuperAdminInfo_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."SuperAdminInfo"
    ADD CONSTRAINT "SuperAdminInfo_pkey" PRIMARY KEY (id);


--
-- TOC entry 3389 (class 2606 OID 16640)
-- Name: Ticket Ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Ticket"
    ADD CONSTRAINT "Ticket_pkey" PRIMARY KEY (id);


--
-- TOC entry 3393 (class 2606 OID 16642)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 3395 (class 2606 OID 16644)
-- Name: Waitting Waitting_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Waitting"
    ADD CONSTRAINT "Waitting_pkey" PRIMARY KEY (id);


--
-- TOC entry 3398 (class 2606 OID 16646)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3340 (class 1259 OID 16647)
-- Name: AdminInfo_userId_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "AdminInfo_userId_key" ON public."AdminInfo" USING btree ("userId");


--
-- TOC entry 3341 (class 1259 OID 16648)
-- Name: Batch_department_batchNum_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "Batch_department_batchNum_key" ON public."Batch" USING btree (department, "batchNum");


--
-- TOC entry 3346 (class 1259 OID 16649)
-- Name: Booking_userId_scheduleId_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "Booking_userId_scheduleId_key" ON public."Booking" USING btree ("userId", "scheduleId");


--
-- TOC entry 3347 (class 1259 OID 16650)
-- Name: Bus_model_plateNumber_driverName_driverContact_numOfSeat_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "Bus_model_plateNumber_driverName_driverContact_numOfSeat_key" ON public."Bus" USING btree (model, "plateNumber", "driverName", "driverContact", "numOfSeat");


--
-- TOC entry 3350 (class 1259 OID 16651)
-- Name: Bus_plateNumber_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "Bus_plateNumber_key" ON public."Bus" USING btree ("plateNumber");


--
-- TOC entry 3355 (class 1259 OID 16652)
-- Name: Cost_targetPeople_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "Cost_targetPeople_key" ON public."Cost" USING btree ("targetPeople");


--
-- TOC entry 3358 (class 1259 OID 16653)
-- Name: CustomerInfo_userId_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "CustomerInfo_userId_key" ON public."CustomerInfo" USING btree ("userId");


--
-- TOC entry 3359 (class 1259 OID 16654)
-- Name: Departure_fromId_destinationId_departureTime_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "Departure_fromId_destinationId_departureTime_key" ON public."Departure" USING btree ("fromId", "destinationId", "departureTime");


--
-- TOC entry 3364 (class 1259 OID 16655)
-- Name: DriverInfo_userId_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "DriverInfo_userId_key" ON public."DriverInfo" USING btree ("userId");


--
-- TOC entry 3367 (class 1259 OID 16656)
-- Name: MainLocation_mainLocationName_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "MainLocation_mainLocationName_key" ON public."MainLocation" USING btree ("mainLocationName");


--
-- TOC entry 3372 (class 1259 OID 16657)
-- Name: Schedule_departureId_date_busId_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "Schedule_departureId_date_busId_key" ON public."Schedule" USING btree ("departureId", date, "busId");


--
-- TOC entry 3377 (class 1259 OID 16658)
-- Name: StaffInfo_userId_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "StaffInfo_userId_key" ON public."StaffInfo" USING btree ("userId");


--
-- TOC entry 3380 (class 1259 OID 16659)
-- Name: StudentInfo_userId_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "StudentInfo_userId_key" ON public."StudentInfo" USING btree ("userId");


--
-- TOC entry 3381 (class 1259 OID 16660)
-- Name: SubLocation_mainLocationId_subLocationName_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "SubLocation_mainLocationId_subLocationName_key" ON public."SubLocation" USING btree ("mainLocationId", "subLocationName");


--
-- TOC entry 3384 (class 1259 OID 16661)
-- Name: SubLocation_subLocationName_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "SubLocation_subLocationName_key" ON public."SubLocation" USING btree ("subLocationName");


--
-- TOC entry 3387 (class 1259 OID 16662)
-- Name: SuperAdminInfo_userId_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "SuperAdminInfo_userId_key" ON public."SuperAdminInfo" USING btree ("userId");


--
-- TOC entry 3390 (class 1259 OID 16663)
-- Name: Ticket_userId_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "Ticket_userId_key" ON public."Ticket" USING btree ("userId");


--
-- TOC entry 3391 (class 1259 OID 16664)
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- TOC entry 3396 (class 1259 OID 16665)
-- Name: Waitting_userId_scheduleId_key; Type: INDEX; Schema: public; Owner: sbs
--

CREATE UNIQUE INDEX "Waitting_userId_scheduleId_key" ON public."Waitting" USING btree ("userId", "scheduleId");


--
-- TOC entry 3399 (class 2606 OID 16666)
-- Name: AdminInfo AdminInfo_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."AdminInfo"
    ADD CONSTRAINT "AdminInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3400 (class 2606 OID 16671)
-- Name: Booking Booking_scheduleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES public."Schedule"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3401 (class 2606 OID 16676)
-- Name: Booking Booking_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3402 (class 2606 OID 16681)
-- Name: Cancel Cancel_scheduleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Cancel"
    ADD CONSTRAINT "Cancel_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES public."Schedule"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3403 (class 2606 OID 16686)
-- Name: Cancel Cancel_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Cancel"
    ADD CONSTRAINT "Cancel_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3404 (class 2606 OID 16691)
-- Name: CustomerInfo CustomerInfo_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."CustomerInfo"
    ADD CONSTRAINT "CustomerInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3405 (class 2606 OID 16696)
-- Name: Departure Departure_destinationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Departure"
    ADD CONSTRAINT "Departure_destinationId_fkey" FOREIGN KEY ("destinationId") REFERENCES public."MainLocation"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3406 (class 2606 OID 16701)
-- Name: Departure Departure_dropLocationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Departure"
    ADD CONSTRAINT "Departure_dropLocationId_fkey" FOREIGN KEY ("dropLocationId") REFERENCES public."SubLocation"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3407 (class 2606 OID 16706)
-- Name: Departure Departure_fromId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Departure"
    ADD CONSTRAINT "Departure_fromId_fkey" FOREIGN KEY ("fromId") REFERENCES public."MainLocation"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3408 (class 2606 OID 16711)
-- Name: Departure Departure_pickupLocationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Departure"
    ADD CONSTRAINT "Departure_pickupLocationId_fkey" FOREIGN KEY ("pickupLocationId") REFERENCES public."SubLocation"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3409 (class 2606 OID 16716)
-- Name: DriverInfo DriverInfo_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."DriverInfo"
    ADD CONSTRAINT "DriverInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3410 (class 2606 OID 16721)
-- Name: GuestInfor GuestInfor_scheduleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."GuestInfor"
    ADD CONSTRAINT "GuestInfor_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES public."Schedule"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3411 (class 2606 OID 16726)
-- Name: ManualBooking ManualBooking_scheduleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."ManualBooking"
    ADD CONSTRAINT "ManualBooking_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES public."Schedule"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3412 (class 2606 OID 16731)
-- Name: Schedule Schedule_busId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_busId_fkey" FOREIGN KEY ("busId") REFERENCES public."Bus"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3413 (class 2606 OID 16736)
-- Name: Schedule Schedule_departureId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_departureId_fkey" FOREIGN KEY ("departureId") REFERENCES public."Departure"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3414 (class 2606 OID 16741)
-- Name: StaffInfo StaffInfo_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."StaffInfo"
    ADD CONSTRAINT "StaffInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3415 (class 2606 OID 16746)
-- Name: StudentInfo StudentInfo_batchId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."StudentInfo"
    ADD CONSTRAINT "StudentInfo_batchId_fkey" FOREIGN KEY ("batchId") REFERENCES public."Batch"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3416 (class 2606 OID 16751)
-- Name: StudentInfo StudentInfo_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."StudentInfo"
    ADD CONSTRAINT "StudentInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3417 (class 2606 OID 16756)
-- Name: SubLocation SubLocation_mainLocationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."SubLocation"
    ADD CONSTRAINT "SubLocation_mainLocationId_fkey" FOREIGN KEY ("mainLocationId") REFERENCES public."MainLocation"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3418 (class 2606 OID 16761)
-- Name: SuperAdminInfo SuperAdminInfo_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."SuperAdminInfo"
    ADD CONSTRAINT "SuperAdminInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3419 (class 2606 OID 16766)
-- Name: Ticket Ticket_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Ticket"
    ADD CONSTRAINT "Ticket_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3420 (class 2606 OID 16771)
-- Name: Waitting Waitting_scheduleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Waitting"
    ADD CONSTRAINT "Waitting_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES public."Schedule"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3421 (class 2606 OID 16776)
-- Name: Waitting Waitting_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sbs
--

ALTER TABLE ONLY public."Waitting"
    ADD CONSTRAINT "Waitting_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: sbs
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT CREATE ON SCHEMA public TO PUBLIC;


-- Completed on 2024-02-08 22:47:03

--
-- PostgreSQL database dump complete
--

