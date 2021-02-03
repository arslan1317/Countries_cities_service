--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

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
-- Name: app_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_settings (
    app_id bigint NOT NULL,
    setting_id bigint NOT NULL
);


ALTER TABLE public.app_settings OWNER TO postgres;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_logs (
    id bigint NOT NULL,
    event_id uuid NOT NULL,
    event json NOT NULL,
    reason text,
    dt timestamp with time zone DEFAULT now(),
    level character varying(12)
);


ALTER TABLE public.audit_logs OWNER TO postgres;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.audit_logs ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: autoreply_handles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autoreply_handles (
    id bigint NOT NULL,
    keyword character varying(164) NOT NULL,
    event character varying(164) NOT NULL,
    message text,
    dt timestamp with time zone NOT NULL,
    dtu timestamp with time zone,
    enabled boolean,
    "order" bigint DEFAULT 0
);


ALTER TABLE public.autoreply_handles OWNER TO postgres;

--
-- Name: autoreply_handles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.autoreply_handles ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.autoreply_handles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: campaign_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaign_attributes (
    id bigint NOT NULL,
    attribute_name character varying(512) NOT NULL,
    attribute_value text NOT NULL,
    attribute_type character varying(32) NOT NULL,
    campaign_id bigint NOT NULL,
    dt timestamp with time zone DEFAULT now() NOT NULL,
    dtu timestamp with time zone DEFAULT now()
);


ALTER TABLE public.campaign_attributes OWNER TO postgres;

--
-- Name: campaign_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.campaign_attributes ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.campaign_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: campaign_consumers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaign_consumers (
    id bigint NOT NULL,
    msisdn character varying(32) NOT NULL,
    campaign_id bigint NOT NULL,
    wt_status bigint DEFAULT 0,
    sent boolean DEFAULT false,
    status bigint DEFAULT 0,
    message_id bigint DEFAULT 0,
    dt timestamp with time zone NOT NULL,
    dtu timestamp with time zone
);


ALTER TABLE public.campaign_consumers OWNER TO postgres;

--
-- Name: campaign_consumers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.campaign_consumers ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.campaign_consumers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: campaigns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaigns (
    id bigint NOT NULL,
    name character varying(32) NOT NULL,
    description text,
    template_id bigint,
    message text,
    message_params json,
    begin_dt timestamp with time zone,
    activated boolean DEFAULT false,
    in_progress boolean DEFAULT false,
    consumers bigint DEFAULT 0,
    success bigint DEFAULT 0,
    failures bigint DEFAULT 0,
    wt_reads bigint DEFAULT 0,
    wt_responses bigint,
    dt timestamp with time zone NOT NULL,
    dtu timestamp with time zone,
    client_id bigint DEFAULT 0,
    created_by bigint NOT NULL,
    completed boolean DEFAULT false,
    displayed boolean DEFAULT true
);


ALTER TABLE public.campaigns OWNER TO postgres;

--
-- Name: campaigns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.campaigns ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.campaigns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: canned_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.canned_messages (
    id bigint NOT NULL,
    message_events json,
    message_name character varying,
    message_text text,
    message_params json,
    enabled boolean DEFAULT true NOT NULL,
    dt timestamp with time zone,
    dtu timestamp without time zone DEFAULT now() NOT NULL,
    client_id bigint DEFAULT 1 NOT NULL,
    message_type character varying(12),
    attachment_url text,
    creator bigint DEFAULT 0,
    attachment_type character varying(164),
    attachment_name character varying(512)
);


ALTER TABLE public.canned_messages OWNER TO postgres;

--
-- Name: canned_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.canned_messages ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.canned_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    id bigint NOT NULL,
    name character varying(512) NOT NULL,
    code character varying(4) NOT NULL,
    country_id bigint NOT NULL,
    enabled boolean,
    dt timestamp with time zone NOT NULL,
    dtu timestamp with time zone,
    creator bigint DEFAULT 0,
    client_id bigint DEFAULT 0
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cities ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: client_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_settings (
    client_id bigint,
    setting_id bigint
);


ALTER TABLE public.client_settings OWNER TO postgres;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id bigint NOT NULL,
    host character varying(64) NOT NULL,
    api_key character varying(64) NOT NULL,
    number character varying(64),
    uuid uuid,
    enc_salt character(32),
    max_token_count integer,
    enabled boolean,
    dt timestamp with time zone DEFAULT now(),
    dtu timestamp with time zone DEFAULT now() NOT NULL,
    bot_id character(36) NOT NULL
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.clients ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contact_group_number; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_group_number (
    group_id bigint,
    customer_id bigint
);


ALTER TABLE public.contact_group_number OWNER TO postgres;

--
-- Name: contact_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_groups (
    id bigint NOT NULL,
    title character varying(32) NOT NULL,
    description character varying(512),
    user_id bigint NOT NULL,
    client_id bigint NOT NULL,
    creator bigint NOT NULL,
    dt timestamp with time zone NOT NULL,
    dtu timestamp with time zone DEFAULT now(),
    enabled boolean DEFAULT true
);


ALTER TABLE public.contact_groups OWNER TO postgres;

--
-- Name: contact_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.contact_groups ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contact_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: conversation_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversation_groups (
    id bigint NOT NULL,
    group_id character varying(64) NOT NULL,
    creator bigint NOT NULL,
    client_id bigint NOT NULL,
    invite_link text,
    enabled boolean DEFAULT true,
    deleted boolean DEFAULT false,
    dt timestamp with time zone NOT NULL,
    dtu timestamp with time zone,
    group_icon text NOT NULL,
    user_id bigint DEFAULT 0 NOT NULL,
    subject character varying(64) NOT NULL,
    user_left boolean DEFAULT false,
    invite_enabled boolean DEFAULT false,
    group_members json,
    group_admins json
);


ALTER TABLE public.conversation_groups OWNER TO postgres;

--
-- Name: conversation_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.conversation_groups ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.conversation_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: conversation_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversation_templates (
    id bigint NOT NULL,
    template_params json,
    template_name character varying,
    template_text text,
    template_events json,
    enabled boolean DEFAULT true NOT NULL,
    approved boolean DEFAULT true NOT NULL,
    dt timestamp with time zone,
    dtu timestamp with time zone DEFAULT now() NOT NULL,
    client_id bigint DEFAULT 0 NOT NULL,
    template_tag character varying(64) NOT NULL,
    template_type character varying(12),
    attachment_url text,
    creator bigint DEFAULT 0
);


ALTER TABLE public.conversation_templates OWNER TO postgres;

--
-- Name: conversation_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.conversation_templates ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.conversation_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    id bigint NOT NULL,
    name character varying(512) NOT NULL,
    code character varying(4) NOT NULL,
    client_id bigint NOT NULL,
    enabled boolean DEFAULT true,
    dt timestamp with time zone NOT NULL,
    dtu timestamp with time zone,
    creator bigint DEFAULT 0
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.countries ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: customer_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_attributes (
    id bigint NOT NULL,
    attribute_name character varying(512) NOT NULL,
    attribute_value text NOT NULL,
    attribute_type character varying(32) NOT NULL,
    customer_id bigint NOT NULL,
    dt timestamp with time zone DEFAULT now() NOT NULL,
    dtu timestamp with time zone DEFAULT now(),
    "order" bigint DEFAULT 0
);


ALTER TABLE public.customer_attributes OWNER TO postgres;

--
-- Name: customer_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.customer_attributes ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id bigint NOT NULL,
    name character varying(512),
    number character varying(32) NOT NULL,
    number_hash double precision,
    email character varying(128),
    dt timestamp with time zone NOT NULL,
    dtu timestamp with time zone,
    client_id bigint NOT NULL,
    user_id bigint DEFAULT 0 NOT NULL,
    last_user bigint DEFAULT 0,
    chat_id character varying(32),
    blocked boolean DEFAULT false,
    reason character varying(512)
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.customers ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inbound_attachment_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inbound_attachment_attributes (
    id bigint NOT NULL,
    attribute_value text NOT NULL,
    attribute_type character varying(64) NOT NULL,
    attribute_name character varying(64) NOT NULL,
    attachment_id bigint NOT NULL,
    dt timestamp with time zone NOT NULL
);


ALTER TABLE public.inbound_attachment_attributes OWNER TO postgres;

--
-- Name: inbound_attachment_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inbound_attachment_attributes ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.inbound_attachment_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inbound_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inbound_attachments (
    id bigint NOT NULL,
    attachment_type character varying(32) NOT NULL,
    attachment_type_id bigint,
    message_id bigint NOT NULL,
    dt timestamp with time zone
);


ALTER TABLE public.inbound_attachments OWNER TO postgres;

--
-- Name: inbound_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inbound_attachments ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.inbound_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inbound_customer_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inbound_customer_contacts (
    id bigint NOT NULL,
    name character varying(164) NOT NULL,
    number character varying(32) NOT NULL,
    whatsapp_enabled boolean,
    attachment_id bigint NOT NULL,
    message_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id bigint,
    dt timestamp with time zone NOT NULL,
    dtu timestamp with time zone,
    contact_type character varying(32) NOT NULL
);


ALTER TABLE public.inbound_customer_contacts OWNER TO postgres;

--
-- Name: inbound_customer_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inbound_customer_contacts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.inbound_customer_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inbound_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inbound_messages (
    id bigint NOT NULL,
    message_id character varying(164) NOT NULL,
    number character varying(32) NOT NULL,
    type character varying(12) NOT NULL,
    message_body text NOT NULL,
    receiver character(36) NOT NULL,
    user_id bigint NOT NULL,
    client_id bigint NOT NULL,
    message_token_hash double precision,
    number_hash double precision,
    customer_id bigint NOT NULL,
    group_id bigint DEFAULT 0,
    received_at timestamp with time zone,
    attachment_id bigint DEFAULT 0
);


ALTER TABLE public.inbound_messages OWNER TO postgres;

--
-- Name: inbound_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inbound_messages ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.inbound_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: message_delivery_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_delivery_reports (
    id bigint NOT NULL,
    message_id character varying(64) NOT NULL,
    message_state character varying(32) NOT NULL,
    message_state_hash double precision NOT NULL,
    message_status character varying(32) NOT NULL,
    message_id_hash double precision NOT NULL,
    dt timestamp with time zone
);


ALTER TABLE public.message_delivery_reports OWNER TO postgres;

--
-- Name: message_delivery_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.message_delivery_reports ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.message_delivery_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: message_states; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_states (
    id bigint NOT NULL,
    state_text character varying(32) NOT NULL,
    default_state boolean DEFAULT false NOT NULL,
    state_hash double precision
);


ALTER TABLE public.message_states OWNER TO postgres;

--
-- Name: message_states_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.message_states ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.message_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: outbound_attachment_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.outbound_attachment_attributes (
    id bigint NOT NULL,
    attribute_value text NOT NULL,
    attribute_type character varying(64) NOT NULL,
    attribute_name character varying(64) NOT NULL,
    attachment_id bigint NOT NULL,
    dt timestamp with time zone NOT NULL
);


ALTER TABLE public.outbound_attachment_attributes OWNER TO postgres;

--
-- Name: outbound_attachment_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.outbound_attachment_attributes ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.outbound_attachment_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: outbound_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.outbound_attachments (
    id bigint NOT NULL,
    attachment_type character varying(64) NOT NULL,
    attachment_type_id bigint DEFAULT 0,
    message_id bigint NOT NULL,
    dt timestamp with time zone NOT NULL
);


ALTER TABLE public.outbound_attachments OWNER TO postgres;

--
-- Name: outbound_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.outbound_attachments ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.outbound_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: outbound_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.outbound_messages (
    id bigint NOT NULL,
    sender_id bigint NOT NULL,
    client_id bigint NOT NULL,
    message_id character varying(64),
    message_id_hash double precision,
    message_body text,
    message_status bigint,
    dt timestamp with time zone DEFAULT now() NOT NULL,
    dtu timestamp with time zone DEFAULT now(),
    message_type character varying(32) NOT NULL,
    receiver character varying(32),
    receiver_id bigint NOT NULL,
    group_id bigint DEFAULT 0,
    cb_details text,
    attachment_id bigint DEFAULT 0,
    campaign_id bigint DEFAULT 0
);


ALTER TABLE public.outbound_messages OWNER TO postgres;

--
-- Name: outbound_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.outbound_messages ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.outbound_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    method character varying(8) NOT NULL,
    description character varying(160),
    rule_set json NOT NULL,
    dt timestamp with time zone DEFAULT now() NOT NULL,
    dtu timestamp with time zone DEFAULT now(),
    enabled boolean DEFAULT true NOT NULL,
    consumer integer DEFAULT 0,
    title character varying(32),
    displayed boolean DEFAULT false
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.permissions ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    permission_id bigint,
    role_id bigint
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(32),
    description character varying(160),
    client_id bigint NOT NULL,
    dt timestamp with time zone DEFAULT now() NOT NULL,
    dtu timestamp with time zone DEFAULT now(),
    enabled boolean DEFAULT true NOT NULL,
    displayed boolean DEFAULT false
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.roles ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    id bigint NOT NULL,
    field_name character varying(32) NOT NULL,
    field_value text NOT NULL,
    field_type character varying(32) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    dt timestamp with time zone DEFAULT now() NOT NULL,
    dtu timestamp with time zone DEFAULT now()
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.settings ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attributes (
    id bigint NOT NULL,
    attribute_name character varying(512) NOT NULL,
    attribute_value text NOT NULL,
    attribute_type character varying(128) NOT NULL,
    user_id bigint DEFAULT 0 NOT NULL,
    dt timestamp with time zone DEFAULT now() NOT NULL,
    dtu timestamp with time zone,
    "order" bigint DEFAULT 0
);


ALTER TABLE public.user_attributes OWNER TO postgres;

--
-- Name: user_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.user_attributes ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    user_id bigint,
    role_id bigint
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- Name: user_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_settings (
    user_id bigint NOT NULL,
    setting_id bigint NOT NULL
);


ALTER TABLE public.user_settings OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(512) NOT NULL,
    password character varying(164) NOT NULL,
    email character varying(512),
    number character varying(32),
    max_token_count integer DEFAULT 1 NOT NULL,
    enabled boolean DEFAULT false,
    client_id bigint NOT NULL,
    dt timestamp with time zone DEFAULT now() NOT NULL,
    dtu timestamp with time zone DEFAULT now(),
    enc_salt character(32) NOT NULL,
    default_receiver boolean DEFAULT false NOT NULL,
    creator bigint DEFAULT 0,
    displayed boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: app_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_settings (app_id, setting_id) FROM stdin;
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_logs (id, event_id, event, reason, dt, level) FROM stdin;
18	4b15f2d7-864b-41bd-b782-70b939f57f1d	{"clientId":"1","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","event_id":"4b15f2d7-864b-41bd-b782-70b939f57f1d","timestamp":1587066915552}	\N	2020-04-17 00:55:15.560662+05	\N
19	b46253b3-a7af-4a6b-9a35-9cdc6dc4cf9a	{"clientId":"1","userId":"1","message":"User with username [null] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"b46253b3-a7af-4a6b-9a35-9cdc6dc4cf9a","timestamp":1587111905016}	\N	2020-04-17 13:25:05.058002+05	info
20	9d4c5392-5992-49ce-9be1-facc7fec4dec	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"9d4c5392-5992-49ce-9be1-facc7fec4dec","timestamp":1587111906159}	\N	2020-04-17 13:25:06.196019+05	info
21	a97c308c-6ddd-4f92-b46f-26ea1511a81a	{"clientId":"1","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"a97c308c-6ddd-4f92-b46f-26ea1511a81a","timestamp":1587111910253}	\N	2020-04-17 13:25:10.26199+05	info
22	e6535643-59a7-4cd1-9e0a-29b10e2ae7ad	{"clientId":"1","userId":"1","message":"User with username [null] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"e6535643-59a7-4cd1-9e0a-29b10e2ae7ad","timestamp":1587148448093}	\N	2020-04-17 23:34:08.105902+05	info
23	84ce8020-f873-4d6b-af00-635de8c024bd	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"84ce8020-f873-4d6b-af00-635de8c024bd","timestamp":1587148527258}	\N	2020-04-17 23:35:27.268137+05	info
24	5eedd6b5-4caa-4fb0-b10c-58bd57218ab7	{"clientId":"1","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"5eedd6b5-4caa-4fb0-b10c-58bd57218ab7","timestamp":1587148531729}	\N	2020-04-17 23:35:31.73647+05	info
25	ef96c395-5fe8-45a9-9023-a1491f81db5b	{"clientId":"1","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"ef96c395-5fe8-45a9-9023-a1491f81db5b","timestamp":1587153617969}	\N	2020-04-18 01:00:18.006627+05	info
26	26d9a48d-723a-4b4b-9741-0fddd8ff6dea	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"26d9a48d-723a-4b4b-9741-0fddd8ff6dea","timestamp":1587153619745}	\N	2020-04-18 01:00:19.757606+05	info
27	90aba172-2f5c-4b15-9f38-7a6abb917c3f	{"clientId":"1","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"90aba172-2f5c-4b15-9f38-7a6abb917c3f","timestamp":1587153622714}	\N	2020-04-18 01:00:22.723778+05	info
28	d5590bda-ebd6-4d47-b303-69e38d8a58a3	{"clientId":"1","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"d5590bda-ebd6-4d47-b303-69e38d8a58a3","timestamp":1587153928389}	\N	2020-04-18 01:05:28.428723+05	info
29	e92f3277-4d42-4971-954f-de2edb695584	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"e92f3277-4d42-4971-954f-de2edb695584","timestamp":1587153930251}	\N	2020-04-18 01:05:30.263515+05	info
30	ed2080a9-e396-4260-8c49-784c3193c0f2	{"clientId":"1","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"ed2080a9-e396-4260-8c49-784c3193c0f2","timestamp":1587153933434}	\N	2020-04-18 01:05:33.448974+05	info
31	066fb3b3-3b5e-4229-add3-112f3950a248	{"userTokenId":"c46c60d2-3d5e-449d-9b56-5fc4918a19ca","clientId":"1","userId":"1","message":"User [admin] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"066fb3b3-3b5e-4229-add3-112f3950a248","timestamp":1587156490773}	\N	2020-04-18 01:48:10.788199+05	info
32	1e8e6894-751e-44db-adb3-6fe29a959117	{"userTokenId":"c46c60d2-3d5e-449d-9b56-5fc4918a19ca","clientId":"1","userId":"1","message":"User [admin] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"1e8e6894-751e-44db-adb3-6fe29a959117","timestamp":1587156493661}	\N	2020-04-18 01:48:13.671642+05	info
33	1fb1056c-3a85-47c5-9fe9-34d7a21f055d	{"userTokenId":"c46c60d2-3d5e-449d-9b56-5fc4918a19ca","clientId":"1","userId":"1","message":"User [admin] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"1fb1056c-3a85-47c5-9fe9-34d7a21f055d","timestamp":1587156497184}	\N	2020-04-18 01:48:17.194122+05	info
34	d99ce459-505d-4468-a7cb-ea1b41d88a28	{"type":"agent_online","clientId":"1","agentId":"1","event_id":"d99ce459-505d-4468-a7cb-ea1b41d88a28","timestamp":1587158500918}	\N	2020-04-18 02:21:40.927087+05	\N
35	66254c7a-f582-44a6-9096-4a24ac12dc5b	{"type":"agent_online","clientId":"1","agentId":"1","event_id":"66254c7a-f582-44a6-9096-4a24ac12dc5b","timestamp":1587159544129}	\N	2020-04-18 02:39:04.14136+05	\N
36	5254972a-f15e-44c5-95d4-381ea352735a	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"5254972a-f15e-44c5-95d4-381ea352735a","timestamp":1587163267351}	\N	2020-04-18 03:41:07.361125+05	info
37	7dce580c-76df-4c5d-9008-8b6afe303316	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"7dce580c-76df-4c5d-9008-8b6afe303316","timestamp":1587163270928}	\N	2020-04-18 03:41:10.936804+05	info
38	0bd90f2a-2c21-4000-a844-bfbd61c0b5e2	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"0bd90f2a-2c21-4000-a844-bfbd61c0b5e2","timestamp":1587163610585}	\N	2020-04-18 03:46:50.593596+05	info
39	620e5884-25f4-416f-98ce-0766ed30995a	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"620e5884-25f4-416f-98ce-0766ed30995a","timestamp":1587163635234}	\N	2020-04-18 03:47:15.242778+05	info
40	cf86d405-a635-4be4-a549-5f787d9aa7ad	{"userTokenId":"c46c60d2-3d5e-449d-9b56-5fc4918a19ca","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"cf86d405-a635-4be4-a549-5f787d9aa7ad","timestamp":1587163854575}	\N	2020-04-18 03:50:54.583108+05	info
41	4318fdb4-9a3d-4807-a1da-769027c4aa5c	{"userTokenId":"c46c60d2-3d5e-449d-9b56-5fc4918a19ca","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"4318fdb4-9a3d-4807-a1da-769027c4aa5c","timestamp":1587163934173}	\N	2020-04-18 03:52:14.18098+05	info
42	a8179d4c-6391-4a16-bb8c-26156d1cf7f9	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"a8179d4c-6391-4a16-bb8c-26156d1cf7f9","timestamp":1587163943788}	\N	2020-04-18 03:52:23.807674+05	info
43	290cee6e-322d-4be2-b616-aa820c198645	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"290cee6e-322d-4be2-b616-aa820c198645","timestamp":1587163959859}	\N	2020-04-18 03:52:39.866085+05	info
44	bae8d0d7-3e9a-4961-b544-fa8fc15fb7b2	{"clientId":"1","userId":"1","message":"User with username [null] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"bae8d0d7-3e9a-4961-b544-fa8fc15fb7b2","timestamp":1587166723003}	\N	2020-04-18 04:38:43.135892+05	info
45	e59b5154-d537-4954-8714-3f74edd20d22	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"e59b5154-d537-4954-8714-3f74edd20d22","timestamp":1587166724874}	\N	2020-04-18 04:38:44.882657+05	info
46	859584f7-5b17-4b50-bc19-676c2eca442d	{"clientId":"1","userTokenId":"a5d467de-a859-440a-b3c5-fba166b05df5","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"859584f7-5b17-4b50-bc19-676c2eca442d","timestamp":1587166727994}	\N	2020-04-18 04:38:48.001983+05	info
47	5e9c9f91-b7ed-4c94-be6d-dfd01eb57856	{"clientId":"1","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"5e9c9f91-b7ed-4c94-be6d-dfd01eb57856","timestamp":1587166848951}	\N	2020-04-18 04:40:48.988509+05	info
48	649ce9e1-7d00-4197-bff5-2e0cf6e01008	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"649ce9e1-7d00-4197-bff5-2e0cf6e01008","timestamp":1587166850670}	\N	2020-04-18 04:40:50.677561+05	info
49	9691da04-5dfb-441a-bf9d-8d67ceb18d30	{"clientId":"1","userTokenId":"f83495b8-b39d-47bd-a601-9b52ad52817b","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"9691da04-5dfb-441a-bf9d-8d67ceb18d30","timestamp":1587166864630}	\N	2020-04-18 04:41:04.638516+05	info
50	2a2d493b-3b41-40ba-acc1-068a1555fe78	{"clientId":"1","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"2a2d493b-3b41-40ba-acc1-068a1555fe78","timestamp":1587166887826}	\N	2020-04-18 04:41:27.865894+05	info
51	7ddabfe3-f7b1-4bf2-a8c0-b12be340c13b	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"7ddabfe3-f7b1-4bf2-a8c0-b12be340c13b","timestamp":1587166889665}	\N	2020-04-18 04:41:29.68636+05	info
52	fa6cc143-df4c-4cc9-9997-83fa77ff586f	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"fa6cc143-df4c-4cc9-9997-83fa77ff586f","timestamp":1587167726072}	\N	2020-04-18 04:55:26.088989+05	info
53	c085a789-34f8-4315-a93e-9de48df14f38	{"clientId":"1","userTokenId":"d5265396-a49e-4ac7-9cbc-a1cfca9288b7","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"c085a789-34f8-4315-a93e-9de48df14f38","timestamp":1587167729942}	\N	2020-04-18 04:55:29.95121+05	info
54	91ac34a5-b369-4874-8ac7-5d10e2a47c33	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"91ac34a5-b369-4874-8ac7-5d10e2a47c33","timestamp":1587200562567}	\N	2020-04-18 14:02:42.597351+05	info
55	98bc1503-8089-43af-83ad-76ed092f3173	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"98bc1503-8089-43af-83ad-76ed092f3173","timestamp":1587203427021}	\N	2020-04-18 14:50:27.030071+05	info
56	812bfbce-ca22-4649-afa2-e697629b17b3	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"812bfbce-ca22-4649-afa2-e697629b17b3","timestamp":1587203431423}	\N	2020-04-18 14:50:31.583031+05	info
57	93feb6bf-5467-4a0e-a7f3-6d1180895dde	{"clientId":"1","userId":"1","message":"User with username [null] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"93feb6bf-5467-4a0e-a7f3-6d1180895dde","timestamp":1587203560521}	\N	2020-04-18 14:52:40.558265+05	info
58	da27f4ac-9e1a-4031-a3a3-e1b7bfb69bc9	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"da27f4ac-9e1a-4031-a3a3-e1b7bfb69bc9","timestamp":1587203562116}	\N	2020-04-18 14:52:42.127864+05	info
59	48360f2e-7f8e-44ea-900f-38d4700024b6	{"clientId":"1","userTokenId":"755c2831-a741-4bae-959b-2cbcb0fc45d1","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"48360f2e-7f8e-44ea-900f-38d4700024b6","timestamp":1587203571364}	\N	2020-04-18 14:52:51.372436+05	info
60	31fd04f2-b859-4e99-9273-7e96674b18bf	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"31fd04f2-b859-4e99-9273-7e96674b18bf","timestamp":1587203581344}	\N	2020-04-18 14:53:01.357125+05	info
61	22c05d32-5711-4d6b-b2ff-b323f31b9f8a	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"22c05d32-5711-4d6b-b2ff-b323f31b9f8a","timestamp":1587216112859}	\N	2020-04-18 18:21:52.871516+05	info
62	a093c89a-eb8c-4271-9a80-d88931a6d935	{"clientId":"1","userTokenId":"3fdd3182-cdee-4f09-b10f-825e74214d87","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"a093c89a-eb8c-4271-9a80-d88931a6d935","timestamp":1587234177934}	\N	2020-04-18 23:22:57.943902+05	info
63	4fd098e4-de08-4ae2-955e-ad2bf99292f8	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"4fd098e4-de08-4ae2-955e-ad2bf99292f8","timestamp":1587234247090}	\N	2020-04-18 23:24:07.101424+05	info
64	0622081e-a353-4d00-b26e-1e05d5a66eee	{"clientId":"1","userTokenId":"93f4a03a-5b17-42ba-bdba-d5f7812defa2","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"0622081e-a353-4d00-b26e-1e05d5a66eee","timestamp":1587234250217}	\N	2020-04-18 23:24:10.234166+05	info
65	78fe3715-b29f-4279-aadd-bb72b63e76b4	{"userTokenId":"93f4a03a-5b17-42ba-bdba-d5f7812defa2","clientId":"1","userId":"1","message":"User [admin] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"78fe3715-b29f-4279-aadd-bb72b63e76b4","timestamp":1587236612375}	\N	2020-04-19 00:03:32.387784+05	info
66	07c5daf9-db23-4bd3-92be-fb4ffd96e590	{"userTokenId":"93f4a03a-5b17-42ba-bdba-d5f7812defa2","clientId":"1","userId":"1","message":"User [admin] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"07c5daf9-db23-4bd3-92be-fb4ffd96e590","timestamp":1587243830479}	\N	2020-04-19 02:03:50.495066+05	info
67	1de93413-d094-4403-a11c-405514e0ede1	{"clientId":"1","userTokenId":"93f4a03a-5b17-42ba-bdba-d5f7812defa2","userId":"1","message":"User Attribute fetch by user with username [admin]","title":"Fetch User Attribute","level":"info","event_id":"1de93413-d094-4403-a11c-405514e0ede1","timestamp":1587246106286}	\N	2020-04-19 02:41:46.295761+05	info
68	a3e2c8f6-b06e-4c2a-a822-a83dfcf9f74c	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"a3e2c8f6-b06e-4c2a-a822-a83dfcf9f74c","timestamp":1587251772191}	\N	2020-04-19 04:16:12.198387+05	info
69	a7078697-60a7-41f1-8dae-1bb333a2cf81	{"userTokenId":"93f4a03a-5b17-42ba-bdba-d5f7812defa2","clientId":"1","userId":"1","message":"User [admin] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"a7078697-60a7-41f1-8dae-1bb333a2cf81","timestamp":1587251830644}	\N	2020-04-19 04:17:10.819147+05	info
70	b253b68f-8548-47b4-9791-80cf63bf8590	{"userTokenId":"93f4a03a-5b17-42ba-bdba-d5f7812defa2","clientId":"1","userId":"1","message":"User [admin] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"b253b68f-8548-47b4-9791-80cf63bf8590","timestamp":1587251831229}	\N	2020-04-19 04:17:11.270771+05	info
71	88e2d484-988a-4bc6-bdbf-170245a145d9	{"userTokenId":"93f4a03a-5b17-42ba-bdba-d5f7812defa2","clientId":"1","userId":"1","message":"User [admin] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"88e2d484-988a-4bc6-bdbf-170245a145d9","timestamp":1587251841568}	\N	2020-04-19 04:17:21.576929+05	info
72	f6e1ce52-122b-472e-a5db-227b080e3260	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"f6e1ce52-122b-472e-a5db-227b080e3260","timestamp":1587306365004}	\N	2020-04-19 19:26:05.007392+05	info
73	861bb66d-4dc2-4497-aa03-912e51484cfa	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"861bb66d-4dc2-4497-aa03-912e51484cfa","timestamp":1587306478626}	\N	2020-04-19 19:27:58.628736+05	info
74	8c0da33b-5c79-417b-aca0-a67a5ed07f34	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"8c0da33b-5c79-417b-aca0-a67a5ed07f34","timestamp":1587306588717}	\N	2020-04-19 19:29:48.722882+05	info
75	1b851dac-492c-4e2e-9911-86f8f0084e91	{"clientId":"1","userTokenId":"d4e000a6-6aff-4492-bd78-4d9e02b11d2b","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"1b851dac-492c-4e2e-9911-86f8f0084e91","timestamp":1587306741106}	\N	2020-04-19 19:32:21.108933+05	info
76	e2e7df52-4039-4c19-abb8-eb184581f485	{"clientId":"1","userId":"1","message":"User with username [null] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"e2e7df52-4039-4c19-abb8-eb184581f485","timestamp":1587311947155}	\N	2020-04-19 20:59:07.185653+05	info
77	b2e6baf4-a57c-44d7-9a36-9c48e2f7bd85	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"b2e6baf4-a57c-44d7-9a36-9c48e2f7bd85","timestamp":1587312084857}	\N	2020-04-19 21:01:24.862932+05	info
78	29f95956-dcdb-442a-bc0e-cd363b2697aa	{"clientId":"1","userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"29f95956-dcdb-442a-bc0e-cd363b2697aa","timestamp":1587312115861}	\N	2020-04-19 21:01:55.864914+05	info
79	62b113dd-50bc-4986-aec6-03123670db24	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"62b113dd-50bc-4986-aec6-03123670db24","timestamp":1587316840306}	\N	2020-04-19 22:20:40.308418+05	info
80	5988bab4-d6d5-41c5-b8ef-32718fe8264e	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"5988bab4-d6d5-41c5-b8ef-32718fe8264e","timestamp":1587316841191}	\N	2020-04-19 22:20:41.193956+05	info
81	fa755a4d-3a91-4a00-846e-aadae229b0d1	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"fa755a4d-3a91-4a00-846e-aadae229b0d1","timestamp":1587317033318}	\N	2020-04-19 22:23:53.320613+05	info
82	3256890d-af69-45f3-b67e-54ca1494aec0	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"3256890d-af69-45f3-b67e-54ca1494aec0","timestamp":1587317034277}	\N	2020-04-19 22:23:54.278806+05	info
83	427406ad-5eed-42e0-8068-bda83d8e20ba	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"427406ad-5eed-42e0-8068-bda83d8e20ba","timestamp":1587317136872}	\N	2020-04-19 22:25:36.874177+05	info
84	f25a23ca-aa9e-434a-9327-18bba9cc3f5c	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"f25a23ca-aa9e-434a-9327-18bba9cc3f5c","timestamp":1587317138100}	\N	2020-04-19 22:25:38.102204+05	info
85	692778fc-1ee4-42fe-b101-cfdd9e5db7c9	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"Contact-Group with id [2] created by User with username [null]","title":"Create Contact-Group","level":"info","event_id":"692778fc-1ee4-42fe-b101-cfdd9e5db7c9","timestamp":1587317150244}	\N	2020-04-19 22:25:50.246408+05	info
86	6c44daa0-20cd-4a3b-b3c5-2497593d7d7d	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"6c44daa0-20cd-4a3b-b3c5-2497593d7d7d","timestamp":1587317150439}	\N	2020-04-19 22:25:50.441112+05	info
87	55159f54-f448-4bb7-9ac6-a998c06672d2	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"55159f54-f448-4bb7-9ac6-a998c06672d2","timestamp":1587317150469}	\N	2020-04-19 22:25:50.472042+05	info
88	509a8283-3a43-4b0e-9bb5-6adb517b79a3	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"509a8283-3a43-4b0e-9bb5-6adb517b79a3","timestamp":1587317153182}	\N	2020-04-19 22:25:53.185457+05	info
89	15441d0d-229a-443c-a4de-a6f8c245feae	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"15441d0d-229a-443c-a4de-a6f8c245feae","timestamp":1587317153542}	\N	2020-04-19 22:25:53.544836+05	info
90	3d5eb26f-b484-4238-9d9e-ab770bc6f283	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"3d5eb26f-b484-4238-9d9e-ab770bc6f283","timestamp":1587317154246}	\N	2020-04-19 22:25:54.24968+05	info
91	a4d61a9d-9a06-48c1-89fe-bf4ee74ed659	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"a4d61a9d-9a06-48c1-89fe-bf4ee74ed659","timestamp":1587317165531}	\N	2020-04-19 22:26:05.535796+05	info
92	72ac8208-8271-4ab4-ab11-ffa9c460225c	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"72ac8208-8271-4ab4-ab11-ffa9c460225c","timestamp":1587317166378}	\N	2020-04-19 22:26:06.38143+05	info
93	09866ed2-bca0-460b-b00c-c6b356f43e60	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"09866ed2-bca0-460b-b00c-c6b356f43e60","timestamp":1587317167290}	\N	2020-04-19 22:26:07.292749+05	info
94	29c25ebd-8f37-4669-8328-4d17f2ccdb98	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"29c25ebd-8f37-4669-8328-4d17f2ccdb98","timestamp":1587318093688}	\N	2020-04-19 22:41:33.691308+05	info
95	93ddb4c5-e0f1-4ad0-920c-97e4a803081f	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"93ddb4c5-e0f1-4ad0-920c-97e4a803081f","timestamp":1587318094680}	\N	2020-04-19 22:41:34.682012+05	info
96	b3de39fd-05e6-400f-9e32-341e9633e5b9	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"b3de39fd-05e6-400f-9e32-341e9633e5b9","timestamp":1587318095709}	\N	2020-04-19 22:41:35.712541+05	info
97	e931966c-3865-4aba-8a7d-43dd34435d76	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"e931966c-3865-4aba-8a7d-43dd34435d76","timestamp":1587319787165}	\N	2020-04-19 23:09:47.168073+05	info
98	c045e18b-8b48-4489-a78a-00a15bb06cbe	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"c045e18b-8b48-4489-a78a-00a15bb06cbe","timestamp":1587319788273}	\N	2020-04-19 23:09:48.275356+05	info
99	9eb13207-e11d-40c9-9d7a-7dc43742bb6c	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"9eb13207-e11d-40c9-9d7a-7dc43742bb6c","timestamp":1587319789147}	\N	2020-04-19 23:09:49.149056+05	info
100	02262dc8-c466-4de6-acfd-94fbf57a09a8	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"02262dc8-c466-4de6-acfd-94fbf57a09a8","timestamp":1587321274599}	\N	2020-04-19 23:34:34.604146+05	info
101	8d0be277-431f-43b0-b8a4-3b70f3eb392c	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"8d0be277-431f-43b0-b8a4-3b70f3eb392c","timestamp":1587321276724}	\N	2020-04-19 23:34:36.726968+05	info
102	7d44e9e1-9367-4cbf-8b02-40d1029779a5	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"7d44e9e1-9367-4cbf-8b02-40d1029779a5","timestamp":1587321276735}	\N	2020-04-19 23:34:36.737328+05	info
103	44241e7a-69d2-4e29-a239-fec296102596	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"44241e7a-69d2-4e29-a239-fec296102596","timestamp":1587321362824}	\N	2020-04-19 23:36:02.826666+05	info
104	dfe07bfb-63b6-4e2b-9c6d-e45ec6680905	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"dfe07bfb-63b6-4e2b-9c6d-e45ec6680905","timestamp":1587321363886}	\N	2020-04-19 23:36:03.888332+05	info
105	ed66d5a9-5469-4059-a813-91ff43663876	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"ed66d5a9-5469-4059-a813-91ff43663876","timestamp":1587321364943}	\N	2020-04-19 23:36:04.944824+05	info
106	9717005a-83c1-422e-9d38-60d5f075c08c	{"clientId":"1","userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","userId":"1","message":"User Attribute fetch by user with username [null]","title":"Fetch User Attribute","level":"info","event_id":"9717005a-83c1-422e-9d38-60d5f075c08c","timestamp":1587323197052}	\N	2020-04-20 00:06:37.05523+05	info
107	5aa61064-c1de-41ab-bf09-c1e186c88b6a	{"clientId":"1","userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","userId":"1","message":"User Attribute with attribute id [:1] updated by user with username [null]","title":"Update Attribute","level":"info","event_id":"5aa61064-c1de-41ab-bf09-c1e186c88b6a","timestamp":1587323325752}	\N	2020-04-20 00:08:45.754186+05	info
108	e116b856-409a-4ba4-b92f-84015df7e405	{"clientId":"1","userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","userId":"1","message":"User Attribute fetch by user with username [null]","title":"Fetch User Attribute","level":"info","event_id":"e116b856-409a-4ba4-b92f-84015df7e405","timestamp":1587323510044}	\N	2020-04-20 00:11:50.045969+05	info
109	8d55feb8-9ef3-41a0-bfc9-aeb32b1838f9	{"clientId":"1","userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","userId":"1","message":"User Attribute fetch by user with username [null]","title":"Fetch User Attribute","level":"info","event_id":"8d55feb8-9ef3-41a0-bfc9-aeb32b1838f9","timestamp":1587323600901}	\N	2020-04-20 00:13:20.904256+05	info
110	0c809549-741b-47a9-beaf-62ca8c1f842f	{"clientId":"1","userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","userId":"1","message":"User Attribute with attribute id [:1] updated by user with username [null]","title":"Update Attribute","level":"info","event_id":"0c809549-741b-47a9-beaf-62ca8c1f842f","timestamp":1587323618758}	\N	2020-04-20 00:13:38.760315+05	info
111	33b57bad-2775-4e7a-a9ce-7af23c6fa856	{"clientId":"1","userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","userId":"1","message":"User Attribute fetch by user with username [null]","title":"Fetch User Attribute","level":"info","event_id":"33b57bad-2775-4e7a-a9ce-7af23c6fa856","timestamp":1587323852522}	\N	2020-04-20 00:17:32.525278+05	info
112	ce337ab6-9133-4239-9ea3-f867541de1d7	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"ce337ab6-9133-4239-9ea3-f867541de1d7","timestamp":1587324361830}	\N	2020-04-20 00:26:01.832836+05	info
113	10426005-bdf6-4418-ab7f-4382faf6f466	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"10426005-bdf6-4418-ab7f-4382faf6f466","timestamp":1587324372344}	\N	2020-04-20 00:26:12.349155+05	info
114	bb3d4800-7d81-4e9b-bbd2-ad5c78dca178	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"bb3d4800-7d81-4e9b-bbd2-ad5c78dca178","timestamp":1587324687552}	\N	2020-04-20 00:31:27.555441+05	info
115	c025e856-97a6-436a-af28-09b67682aca7	{"userTokenId":"a835cafe-ccd2-4f98-9fef-7dfd95b8da1e","clientId":"1","userId":"1","message":"Canned Message [] created by user with username [null]","title":"Create Canned Message","level":"info","event_id":"c025e856-97a6-436a-af28-09b67682aca7","timestamp":1587325224549}	\N	2020-04-20 00:40:24.551613+05	info
116	11f50139-b6be-4b45-84f0-dab0945379a1	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"11f50139-b6be-4b45-84f0-dab0945379a1","timestamp":1587327057670}	\N	2020-04-20 01:10:57.673279+05	info
117	c35100e9-66e8-490a-98e1-f14f58fb648e	{"clientId":"1","userId":"1","message":"User with username [null] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"c35100e9-66e8-490a-98e1-f14f58fb648e","timestamp":1587327060342}	\N	2020-04-20 01:11:00.344309+05	info
118	963cefac-5490-4f46-9e45-4bc1d7412b0a	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"963cefac-5490-4f46-9e45-4bc1d7412b0a","timestamp":1587327092175}	\N	2020-04-20 01:11:32.179712+05	info
119	a3674ba5-6c4d-400a-b767-2d7ed3d4a6b8	{"clientId":"1","userTokenId":"183529e0-9121-4351-b5d5-d624ea3d3470","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"a3674ba5-6c4d-400a-b767-2d7ed3d4a6b8","timestamp":1587327368808}	\N	2020-04-20 01:16:08.809832+05	info
120	d332a3f7-9b20-4b0c-8a83-8f5bb4698d26	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"d332a3f7-9b20-4b0c-8a83-8f5bb4698d26","timestamp":1587327397833}	\N	2020-04-20 01:16:37.835179+05	info
121	205e1ef6-1d7d-4399-9473-0d02686ca3fd	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"205e1ef6-1d7d-4399-9473-0d02686ca3fd","timestamp":1587330790843}	\N	2020-04-20 02:13:10.845481+05	info
122	cff35cbd-afc6-467e-a633-77ea7e53d5e1	{"clientId":"1","userId":"1","message":"User with username [null] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"cff35cbd-afc6-467e-a633-77ea7e53d5e1","timestamp":1587330792590}	\N	2020-04-20 02:13:12.592971+05	info
123	8a33c8df-4ac3-470c-8224-e9a008f3239a	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"8a33c8df-4ac3-470c-8224-e9a008f3239a","timestamp":1587330794691}	\N	2020-04-20 02:13:14.695534+05	info
124	b6a4ed44-c746-4499-8965-50e4c30511b6	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"b6a4ed44-c746-4499-8965-50e4c30511b6","timestamp":1587330851356}	\N	2020-04-20 02:14:11.359481+05	info
125	95344188-decb-445f-93f7-90c1c4b5c97c	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"95344188-decb-445f-93f7-90c1c4b5c97c","timestamp":1587331076466}	\N	2020-04-20 02:17:56.469272+05	info
126	f6321f97-bd93-416f-8aad-86c4d3b9a415	{"clientId":"1","userTokenId":"5d1dc9b3-8556-4a02-bb81-3ec9aa699a1d","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"f6321f97-bd93-416f-8aad-86c4d3b9a415","timestamp":1587337316412}	\N	2020-04-20 04:01:56.415403+05	info
127	611d294f-e774-497e-8127-c886744d1be9	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"611d294f-e774-497e-8127-c886744d1be9","timestamp":1587337675876}	\N	2020-04-20 04:07:55.879608+05	info
128	57541181-fa56-41c0-80b5-4a304e3b24d4	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"57541181-fa56-41c0-80b5-4a304e3b24d4","timestamp":1587338016755}	\N	2020-04-20 04:13:36.758091+05	info
129	82bfd6ed-7666-43cf-b809-ea7c29f635a0	{"clientId":"1","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"82bfd6ed-7666-43cf-b809-ea7c29f635a0","timestamp":1587338018804}	\N	2020-04-20 04:13:38.80665+05	info
130	ee47cb09-e7a4-4ae8-82dc-b4914e55b6ac	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"ee47cb09-e7a4-4ae8-82dc-b4914e55b6ac","timestamp":1587338020707}	\N	2020-04-20 04:13:40.71091+05	info
131	c4224e52-a9ea-43d0-aa66-531c98618a47	{"clientId":"1","userTokenId":"4cb114a9-f07f-4b09-ad92-324463903ee8","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"c4224e52-a9ea-43d0-aa66-531c98618a47","timestamp":1587338902881}	\N	2020-04-20 04:28:22.883769+05	info
132	0a1e4124-cf18-4b5f-89be-80792c176261	{"clientId":"1","userId":"1","message":"User with username [null] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"0a1e4124-cf18-4b5f-89be-80792c176261","timestamp":1587343723725}	\N	2020-04-20 05:48:43.727683+05	info
133	e4647724-e1d2-4bbb-804d-346d55de3d64	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"e4647724-e1d2-4bbb-804d-346d55de3d64","timestamp":1587343725877}	\N	2020-04-20 05:48:45.881452+05	info
134	eb190aa2-4b9a-456b-8685-767fe0b31d7c	{"clientId":"1","clientTokenId":"5b417785-9895-442e-9493-78cf4b1498d6","resetToken":"ef67383a44e0","message":"New token [ef67383a44e0] generated and send on email [amustafa@its.com.pk]","title":"Generate Token","level":"info","event_id":"eb190aa2-4b9a-456b-8685-767fe0b31d7c","timestamp":1587343918823}	\N	2020-04-20 05:51:58.828747+05	info
135	ba1a87ee-b967-46d7-ac80-ab26984043f9	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"ba1a87ee-b967-46d7-ac80-ab26984043f9","timestamp":1588089902551}	\N	2020-04-28 21:05:02.556493+05	info
136	acee9756-b602-493d-a8c6-cc249002476b	{"clientId":"1","userTokenId":"ff4da3bc-eb50-4acb-ab34-d44ecab0d7fc","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"acee9756-b602-493d-a8c6-cc249002476b","timestamp":1588089931975}	\N	2020-04-28 21:05:31.977914+05	info
137	bda5bfec-21d2-4c4b-bfe1-cd06626bb247	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"bda5bfec-21d2-4c4b-bfe1-cd06626bb247","timestamp":1588090352492}	\N	2020-04-28 21:12:32.494611+05	info
138	224d2625-667a-42d3-b159-f26931626736	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"224d2625-667a-42d3-b159-f26931626736","timestamp":1588090559284}	\N	2020-04-28 21:15:59.288726+05	info
139	e8e936ac-e27f-480f-9d86-34ca92936566	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"e8e936ac-e27f-480f-9d86-34ca92936566","timestamp":1588090983821}	\N	2020-04-28 21:23:03.826281+05	info
140	a5e4d711-afbe-43ad-a67b-034f1f0604f0	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"a5e4d711-afbe-43ad-a67b-034f1f0604f0","timestamp":1588091272052}	\N	2020-04-28 21:27:52.055413+05	info
141	fae4cef1-5447-4606-85b2-cc6ab77072fa	{"clientId":"1","userTokenId":"d4d3c573-3d34-4ccf-9347-d15ebce6e592","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"fae4cef1-5447-4606-85b2-cc6ab77072fa","timestamp":1588091567695}	\N	2020-04-28 21:32:47.697263+05	info
142	ba262f75-7fef-4042-8274-b52a8c1f1b8e	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"ba262f75-7fef-4042-8274-b52a8c1f1b8e","timestamp":1588091579247}	\N	2020-04-28 21:32:59.249194+05	info
143	96638af8-fd92-458b-860f-28873d1c7104	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"96638af8-fd92-458b-860f-28873d1c7104","timestamp":1588091706052}	\N	2020-04-28 21:35:06.055783+05	info
144	950c3c6c-fc91-47b0-b5c1-ce4174420fcf	{"clientId":"1","userTokenId":"7f17e784-c63b-4fa2-bda4-3d791048a392","userId":"12","message":"User with username [agent1] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"950c3c6c-fc91-47b0-b5c1-ce4174420fcf","timestamp":1588091712076}	\N	2020-04-28 21:35:12.078203+05	info
145	f565e8af-bed2-4e8b-b11a-69e7af6acb22	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"f565e8af-bed2-4e8b-b11a-69e7af6acb22","timestamp":1588091736616}	\N	2020-04-28 21:35:36.619797+05	info
146	775738e1-e6fb-447b-a8e2-8dba9b1349e6	{"clientId":"1","userTokenId":"d4d3c573-3d34-4ccf-9347-d15ebce6e592","userId":"1","message":"Permission with id [8] created by User with username [admin].","title":"Create Permission","level":"info","event_id":"775738e1-e6fb-447b-a8e2-8dba9b1349e6","timestamp":1588092293182}	\N	2020-04-28 21:44:53.184698+05	info
147	ae27658f-052a-4509-9e93-878cb4f4cb72	{"clientId":"1","userTokenId":"d4d3c573-3d34-4ccf-9347-d15ebce6e592","userId":"1","message":"Permission with id [9] created by User with username [admin].","title":"Create Permission","level":"info","event_id":"ae27658f-052a-4509-9e93-878cb4f4cb72","timestamp":1588092401387}	\N	2020-04-28 21:46:41.390295+05	info
148	64f10994-ad02-4e61-aa11-4f9ca69420ba	{"clientId":"1","userTokenId":"d4d3c573-3d34-4ccf-9347-d15ebce6e592","userId":"1","message":"Role with id [64] updated by User with username [admin].","title":"Update Role","level":"info","event_id":"64f10994-ad02-4e61-aa11-4f9ca69420ba","timestamp":1588092540946}	\N	2020-04-28 21:49:00.948124+05	info
149	e8c10e70-f93f-4063-950d-0110238db45c	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"e8c10e70-f93f-4063-950d-0110238db45c","timestamp":1588092565145}	\N	2020-04-28 21:49:25.148331+05	info
150	7eb130de-5659-4a18-a8ed-e24556c41576	{"clientId":"1","userTokenId":"78b8ba98-e83f-4253-af4b-6d49056c486e","userId":"12","message":"User with username [agent1] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"7eb130de-5659-4a18-a8ed-e24556c41576","timestamp":1588092579374}	\N	2020-04-28 21:49:39.375831+05	info
151	a4284a4a-e614-4ccf-9b2a-4a6de813c30a	{"clientId":"1","userId":"12","message":"Agent with id [12] and client [1] came online","title":"Agent Online","level":"info","event_id":"a4284a4a-e614-4ccf-9b2a-4a6de813c30a","timestamp":1588092601301}	\N	2020-04-28 21:50:01.30347+05	info
152	e1d5270c-1754-4eaf-8fde-571c8ad39497	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"e1d5270c-1754-4eaf-8fde-571c8ad39497","timestamp":1588092739132}	\N	2020-04-28 21:52:19.135379+05	info
153	0e4cbf4f-908f-4764-a2aa-cd340ef8bd4d	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"0e4cbf4f-908f-4764-a2aa-cd340ef8bd4d","timestamp":1588092746348}	\N	2020-04-28 21:52:26.353559+05	info
154	218f7ffc-03ff-45b4-8978-11a06fb740c3	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"218f7ffc-03ff-45b4-8978-11a06fb740c3","timestamp":1588092764403}	\N	2020-04-28 21:52:44.41021+05	info
155	4db4e93f-87ea-468d-9565-5d57c99f6d0a	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"4db4e93f-87ea-468d-9565-5d57c99f6d0a","timestamp":1588092767630}	\N	2020-04-28 21:52:47.634865+05	info
156	22717423-d376-4cfe-81fa-549d4279ce32	{"clientId":"1","userTokenId":"6706c2da-73f2-4865-8d0c-49650c5bba21","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"22717423-d376-4cfe-81fa-549d4279ce32","timestamp":1588092771420}	\N	2020-04-28 21:52:51.423232+05	info
157	04f6a4fe-173c-4dae-b0a9-07d486003eb6	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"04f6a4fe-173c-4dae-b0a9-07d486003eb6","timestamp":1588092778047}	\N	2020-04-28 21:52:58.050055+05	info
158	e3ffeae1-f06e-4593-9cdc-4fd05326a40e	{"clientId":"1","userTokenId":"1a710c20-4ba9-4960-b1ed-3e111b42fbc6","userId":"12","message":"User with username [agent1] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"e3ffeae1-f06e-4593-9cdc-4fd05326a40e","timestamp":1588092909287}	\N	2020-04-28 21:55:09.288905+05	info
159	ccaa9181-3c45-478d-8a73-b817727c52ba	{"clientId":"1","userId":"12","message":"Agent with id [12] and client [1] came online","title":"Agent Online","level":"info","event_id":"ccaa9181-3c45-478d-8a73-b817727c52ba","timestamp":1588092914429}	\N	2020-04-28 21:55:14.431578+05	info
160	eec7db2b-f618-462e-9032-5bbec60c0f33	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"eec7db2b-f618-462e-9032-5bbec60c0f33","timestamp":1588093768792}	\N	2020-04-28 22:09:28.795725+05	info
161	578d7378-a3d8-4be7-8796-be62d7752c38	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"578d7378-a3d8-4be7-8796-be62d7752c38","timestamp":1588093775233}	\N	2020-04-28 22:09:35.237296+05	info
162	3f85ed37-eb38-41fc-a8d6-e8f8bc387a36	{"clientId":"1","userTokenId":"7bba7c7f-7e53-498d-98c0-fb8869c89d25","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"3f85ed37-eb38-41fc-a8d6-e8f8bc387a36","timestamp":1588093801075}	\N	2020-04-28 22:10:01.077976+05	info
163	fa53e387-d192-4500-9839-004c77726bfc	{"clientId":"1","userTokenId":"2168f4fd-ffe9-4a51-9e8f-22b15452f38b","userId":"12","message":"User with username [agent1] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"fa53e387-d192-4500-9839-004c77726bfc","timestamp":1588093811145}	\N	2020-04-28 22:10:11.148015+05	info
164	ba6d92f9-5933-49f3-aa4e-7b7783b73e65	{"clientId":"1","userId":"12","message":"Agent with id [12] and client [1] came online","title":"Agent Online","level":"info","event_id":"ba6d92f9-5933-49f3-aa4e-7b7783b73e65","timestamp":1588093884424}	\N	2020-04-28 22:11:24.42701+05	info
165	9e738058-5ac8-4651-8a4d-fe6aa61cdb96	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"9e738058-5ac8-4651-8a4d-fe6aa61cdb96","timestamp":1588093884434}	\N	2020-04-28 22:11:24.43694+05	info
166	2e6f80d0-b5a6-4bc8-a01f-92d494338377	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"2e6f80d0-b5a6-4bc8-a01f-92d494338377","timestamp":1588096501042}	\N	2020-04-28 22:55:01.043562+05	info
167	f1246df7-6dbe-46eb-9d77-275d86c9128f	{"clientId":"1","userId":"12","message":"Agent with id [12] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"f1246df7-6dbe-46eb-9d77-275d86c9128f","timestamp":1588096525761}	\N	2020-04-28 22:55:25.764991+05	info
168	292538d0-fd2e-448d-8afc-5e187973bd5b	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"292538d0-fd2e-448d-8afc-5e187973bd5b","timestamp":1588096525809}	\N	2020-04-28 22:55:25.811439+05	info
169	0178863f-0b00-4c58-8f6f-b4b0b80186df	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"0178863f-0b00-4c58-8f6f-b4b0b80186df","timestamp":1588096595490}	\N	2020-04-28 22:56:35.493818+05	info
170	9ad3afb9-4c57-47c7-bee2-609ddff4b37e	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"9ad3afb9-4c57-47c7-bee2-609ddff4b37e","timestamp":1588096633234}	\N	2020-04-28 22:57:13.238139+05	info
171	456f11e9-29fb-41ce-99b8-6f58f1ccc606	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"456f11e9-29fb-41ce-99b8-6f58f1ccc606","timestamp":1588096676108}	\N	2020-04-28 22:57:56.114038+05	info
172	9f377ba6-7d2f-4471-ad61-bdbdd4253ce0	{"clientId":"1","userTokenId":"b0f3e743-536b-4e54-84ec-e1e67a009f0b","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"9f377ba6-7d2f-4471-ad61-bdbdd4253ce0","timestamp":1588096680571}	\N	2020-04-28 22:58:00.574578+05	info
173	fe837883-ccb3-468e-aeba-63b16f4adb05	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"fe837883-ccb3-468e-aeba-63b16f4adb05","timestamp":1588096685990}	\N	2020-04-28 22:58:05.992981+05	info
174	e84c5600-4645-45ce-b361-f9b4240759a6	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"e84c5600-4645-45ce-b361-f9b4240759a6","timestamp":1588096695695}	\N	2020-04-28 22:58:15.698763+05	info
175	b7681fa8-9cf8-4a4c-ac70-57284818e631	{"clientId":"1","userTokenId":"677bbac0-e311-4cf4-8272-468fcea78e2d","userId":"12","message":"User with username [agent1] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"b7681fa8-9cf8-4a4c-ac70-57284818e631","timestamp":1588096700546}	\N	2020-04-28 22:58:20.548997+05	info
176	368891e7-33ae-4783-9107-69c693693cbd	{"clientId":"1","userId":"12","message":"Agent with id [12] and client [1] came online","title":"Agent Online","level":"info","event_id":"368891e7-33ae-4783-9107-69c693693cbd","timestamp":1588096704819}	\N	2020-04-28 22:58:24.821417+05	info
177	437486c7-9096-4f8a-8cd5-ffece646f773	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"437486c7-9096-4f8a-8cd5-ffece646f773","timestamp":1588098993937}	\N	2020-04-28 23:36:33.94+05	info
178	5db2ef58-f466-405c-8d87-dda8193ac20e	{"clientId":"1","userTokenId":"b0f3e743-536b-4e54-84ec-e1e67a009f0b","userId":"1","message":"User Attribute fetch by user with username [admin]","title":"Fetch User Attribute","level":"info","event_id":"5db2ef58-f466-405c-8d87-dda8193ac20e","timestamp":1588099039760}	\N	2020-04-28 23:37:19.763309+05	info
179	ec148af9-53f5-4084-849b-2373074ad697	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"ec148af9-53f5-4084-849b-2373074ad697","timestamp":1588608042506}	\N	2020-05-04 21:00:42.51187+05	info
180	775037e8-7fa8-4973-b04a-ce5daa13479a	{"clientId":"1","userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"775037e8-7fa8-4973-b04a-ce5daa13479a","timestamp":1588608046784}	\N	2020-05-04 21:00:46.786757+05	info
181	833ae92d-c686-4110-b8fe-c97f20eee6e2	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"833ae92d-c686-4110-b8fe-c97f20eee6e2","timestamp":1588622193481}	\N	2020-05-05 00:56:33.484359+05	info
182	e4ad7fcc-ad48-4fd5-8a55-12adb6bfdd80	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"e4ad7fcc-ad48-4fd5-8a55-12adb6bfdd80","timestamp":1588622391514}	\N	2020-05-05 00:59:51.517473+05	info
183	afdc77d6-1a76-4037-ac2f-45f3fddf463e	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"User with username [agent1] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"afdc77d6-1a76-4037-ac2f-45f3fddf463e","timestamp":1588622395268}	\N	2020-05-05 00:59:55.270811+05	info
184	902ee142-7307-49b2-847a-af9b4c671051	{"clientId":"1","userId":"12","message":"Agent with id [12] and client [1] came online","title":"Agent Online","level":"info","event_id":"902ee142-7307-49b2-847a-af9b4c671051","timestamp":1588622399422}	\N	2020-05-05 00:59:59.424552+05	info
185	168e615a-5a72-4dc1-ae8b-e4d272fa2200	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"168e615a-5a72-4dc1-ae8b-e4d272fa2200","timestamp":1588624835216}	\N	2020-05-05 01:40:35.218351+05	info
186	6a6f0a8e-eb95-4676-b8ea-0310151849c2	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"6a6f0a8e-eb95-4676-b8ea-0310151849c2","timestamp":1588625063481}	\N	2020-05-05 01:44:23.48466+05	info
187	da07bad3-1614-4d9e-8dcd-1f5020a4d66a	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"da07bad3-1614-4d9e-8dcd-1f5020a4d66a","timestamp":1588625231583}	\N	2020-05-05 01:47:11.584719+05	info
188	60dc2403-58b6-4e47-a2d7-98bb6be51836	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"60dc2403-58b6-4e47-a2d7-98bb6be51836","timestamp":1588625352984}	\N	2020-05-05 01:49:12.986602+05	info
189	bd9055ce-4563-43e4-b94a-65b65758304a	{"clientId":"3","userId":"1","message":"User with username [null] and client [undefined] has just logged off","title":"User Logout","level":"info","event_id":"bd9055ce-4563-43e4-b94a-65b65758304a","timestamp":1588625879003}	\N	2020-05-05 01:57:59.005387+05	info
190	99576bfe-cd84-4023-b8bb-a4eb94c6173f	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"99576bfe-cd84-4023-b8bb-a4eb94c6173f","timestamp":1588625880002}	\N	2020-05-05 01:58:00.005423+05	info
191	925bddaa-7ccc-4449-91fd-fddffe6c7bc0	{"clientId":"1","userTokenId":"4a6d00c8-2528-44f4-a2cd-c386be34798b","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"925bddaa-7ccc-4449-91fd-fddffe6c7bc0","timestamp":1588625883207}	\N	2020-05-05 01:58:03.2089+05	info
192	ca4d6ce6-d140-4071-aec7-65cd5a4a882a	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"ca4d6ce6-d140-4071-aec7-65cd5a4a882a","timestamp":1588625887319}	\N	2020-05-05 01:58:07.321298+05	info
193	933362f6-b00d-41f8-8bdd-b41a5e9d6c17	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"933362f6-b00d-41f8-8bdd-b41a5e9d6c17","timestamp":1588625893306}	\N	2020-05-05 01:58:13.308778+05	info
194	afd43252-5581-4db9-a4b6-1b4f7f3b0c1a	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"afd43252-5581-4db9-a4b6-1b4f7f3b0c1a","timestamp":1588625971101}	\N	2020-05-05 01:59:31.103483+05	info
195	6994c540-4892-433b-9879-90c1cb233012	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"6994c540-4892-433b-9879-90c1cb233012","timestamp":1588626729524}	\N	2020-05-05 02:12:09.526591+05	info
196	1cbeac08-3e59-4f3a-90ee-f0fc2a054ce7	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"1cbeac08-3e59-4f3a-90ee-f0fc2a054ce7","timestamp":1588626805564}	\N	2020-05-05 02:13:25.568137+05	info
197	0b4ad9b3-ffe2-430d-acd5-02808decb93c	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"0b4ad9b3-ffe2-430d-acd5-02808decb93c","timestamp":1588626805571}	\N	2020-05-05 02:13:25.575251+05	info
198	0243bb7a-1a89-4b83-abe2-0efce2162d7a	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"0243bb7a-1a89-4b83-abe2-0efce2162d7a","timestamp":1588626857690}	\N	2020-05-05 02:14:17.692397+05	info
199	6831df66-09fa-4dff-810e-f9b04df9e809	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"6831df66-09fa-4dff-810e-f9b04df9e809","timestamp":1588626925303}	\N	2020-05-05 02:15:25.305308+05	info
200	c0dc8de6-c223-44ff-bf6c-adcd7500ade2	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"c0dc8de6-c223-44ff-bf6c-adcd7500ade2","timestamp":1588626938296}	\N	2020-05-05 02:15:38.299444+05	info
201	cbbe3920-0130-4e34-ae54-9610d619b1f6	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"cbbe3920-0130-4e34-ae54-9610d619b1f6","timestamp":1588626938338}	\N	2020-05-05 02:15:38.34102+05	info
202	7f6aaf18-c964-473e-b7c8-8dc956b75b30	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"7f6aaf18-c964-473e-b7c8-8dc956b75b30","timestamp":1588627005736}	\N	2020-05-05 02:16:45.739166+05	info
203	706d0079-5efc-43cc-94a7-e681709cc841	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"706d0079-5efc-43cc-94a7-e681709cc841","timestamp":1588627108197}	\N	2020-05-05 02:18:28.200286+05	info
204	335317a5-f4c1-4b1b-8974-009c2f8947d8	{"clientId":"1","userTokenId":"4a6d00c8-2528-44f4-a2cd-c386be34798b","userId":"1","message":"User Attribute fetch by user with username [admin]","title":"Fetch User Attribute","level":"info","event_id":"335317a5-f4c1-4b1b-8974-009c2f8947d8","timestamp":1588627110614}	\N	2020-05-05 02:18:30.617251+05	info
205	f6940bbd-5489-418e-8ac6-4f6a8480d26c	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"f6940bbd-5489-418e-8ac6-4f6a8480d26c","timestamp":1588627113992}	\N	2020-05-05 02:18:33.994934+05	info
206	5caea560-66ce-4c72-9415-870dee9f3587	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"5caea560-66ce-4c72-9415-870dee9f3587","timestamp":1588627162412}	\N	2020-05-05 02:19:22.415367+05	info
207	6875f5e2-4012-49b9-802c-04bdf3ffafd8	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"6875f5e2-4012-49b9-802c-04bdf3ffafd8","timestamp":1588627278382}	\N	2020-05-05 02:21:18.384736+05	info
208	24141296-a992-42b4-a30d-1471d90aa15a	{"clientId":"1","userTokenId":"4a6d00c8-2528-44f4-a2cd-c386be34798b","userId":"1","message":"User Attribute fetch by user with username [admin]","title":"Fetch User Attribute","level":"info","event_id":"24141296-a992-42b4-a30d-1471d90aa15a","timestamp":1588627291469}	\N	2020-05-05 02:21:31.471895+05	info
209	047f9c11-0ee1-4bf4-b063-09f06d1a3e39	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"047f9c11-0ee1-4bf4-b063-09f06d1a3e39","timestamp":1588627309551}	\N	2020-05-05 02:21:49.55396+05	info
210	cb86ecf6-509d-4a36-b9f2-d0a99212b22b	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"cb86ecf6-509d-4a36-b9f2-d0a99212b22b","timestamp":1588627416703}	\N	2020-05-05 02:23:36.705109+05	info
211	39eb0f41-8a20-4625-979f-6d911fcfad97	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"39eb0f41-8a20-4625-979f-6d911fcfad97","timestamp":1588627420833}	\N	2020-05-05 02:23:40.836341+05	info
212	fd750735-4db2-4e54-b5d9-c78ad082f9e2	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"fd750735-4db2-4e54-b5d9-c78ad082f9e2","timestamp":1588627642773}	\N	2020-05-05 02:27:22.776088+05	info
213	36b06fd7-5fc3-4c7d-b201-b4c241480370	{"clientId":"1","userTokenId":"4a6d00c8-2528-44f4-a2cd-c386be34798b","userId":"1","message":"User Attribute fetch by user with username [admin]","title":"Fetch User Attribute","level":"info","event_id":"36b06fd7-5fc3-4c7d-b201-b4c241480370","timestamp":1588627680469}	\N	2020-05-05 02:28:00.476914+05	info
214	b2e88f37-cc50-491d-b130-bbcb867d4e75	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"b2e88f37-cc50-491d-b130-bbcb867d4e75","timestamp":1588628117176}	\N	2020-05-05 02:35:17.178608+05	info
215	c2d94edb-09f3-452b-ac9b-bb42fac01dd0	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"c2d94edb-09f3-452b-ac9b-bb42fac01dd0","timestamp":1588628174422}	\N	2020-05-05 02:36:14.423776+05	info
216	77f5a675-e408-4bb9-a630-4d5e4001470f	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"77f5a675-e408-4bb9-a630-4d5e4001470f","timestamp":1588628197729}	\N	2020-05-05 02:36:37.730837+05	info
217	d47731c6-532c-42ac-9a23-d171dd3bd4f5	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"d47731c6-532c-42ac-9a23-d171dd3bd4f5","timestamp":1588628286893}	\N	2020-05-05 02:38:06.894592+05	info
218	39a73162-9636-4ee7-a69f-5d5914f2a8a3	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"39a73162-9636-4ee7-a69f-5d5914f2a8a3","timestamp":1588628300868}	\N	2020-05-05 02:38:20.869938+05	info
219	c7ff3e56-0620-4c62-9a3d-43986e30e6e5	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"c7ff3e56-0620-4c62-9a3d-43986e30e6e5","timestamp":1588628354668}	\N	2020-05-05 02:39:14.670423+05	info
220	cc70dd56-5749-44ab-94dc-8efd8db7c716	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"cc70dd56-5749-44ab-94dc-8efd8db7c716","timestamp":1588628564156}	\N	2020-05-05 02:42:44.158933+05	info
221	f4f597e7-560d-41ff-affb-0a75acb02031	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"f4f597e7-560d-41ff-affb-0a75acb02031","timestamp":1588628578242}	\N	2020-05-05 02:42:58.244393+05	info
222	41827bf9-216f-444a-ac23-6d220be245db	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"41827bf9-216f-444a-ac23-6d220be245db","timestamp":1588628609818}	\N	2020-05-05 02:43:29.8199+05	info
223	dbd33766-85a5-4db3-a7c2-013d65df2d1f	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"dbd33766-85a5-4db3-a7c2-013d65df2d1f","timestamp":1588628639299}	\N	2020-05-05 02:43:59.301768+05	info
224	6ec75fc2-05b6-4402-8c61-c32d9e9f9b6b	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"6ec75fc2-05b6-4402-8c61-c32d9e9f9b6b","timestamp":1588628700437}	\N	2020-05-05 02:45:00.500583+05	info
225	0fd08805-d4ad-4a2d-8734-9d04bcb2fae3	{"clientId":"1","userTokenId":"52f832ba-45ed-4298-9d7d-eeac7eb9144c","userId":"12","message":"Customer Attribute updated by User with username [agent1]","title":"Update Customer-Attribute","level":"info","event_id":"0fd08805-d4ad-4a2d-8734-9d04bcb2fae3","timestamp":1588628765533}	\N	2020-05-05 02:46:05.535328+05	info
226	31ca36e7-d268-4c55-9551-f70bb83751a2	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"Canned Message [Video Canned] created by user with username [null]","title":"Create Canned Message","level":"info","event_id":"31ca36e7-d268-4c55-9551-f70bb83751a2","timestamp":1588630092453}	\N	2020-05-05 03:08:12.455359+05	info
227	0c7a2518-f595-4787-8c01-e0d080d4d4d0	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"Canned Message [Document Canned] created by user with username [null]","title":"Create Canned Message","level":"info","event_id":"0c7a2518-f595-4787-8c01-e0d080d4d4d0","timestamp":1588630348329}	\N	2020-05-05 03:12:28.330786+05	info
228	81818a23-495c-4cd5-9c5b-686c4425995e	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"Canned Message with id [19] updated by User with username [null]","title":"Update Canned Message","level":"info","event_id":"81818a23-495c-4cd5-9c5b-686c4425995e","timestamp":1588630354829}	\N	2020-05-05 03:12:34.830976+05	info
229	85a7965c-56ae-4e0f-9b5c-3529d31a6fe9	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"Canned Message [Doc Can] created by user with username [null]","title":"Create Canned Message","level":"info","event_id":"85a7965c-56ae-4e0f-9b5c-3529d31a6fe9","timestamp":1588661056258}	\N	2020-05-05 11:44:16.260439+05	info
230	d6287b1c-7b55-445f-aec7-e1edee4c4f5d	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"Canned Message [Documents] created by user with username [null]","title":"Create Canned Message","level":"info","event_id":"d6287b1c-7b55-445f-aec7-e1edee4c4f5d","timestamp":1588661098782}	\N	2020-05-05 11:44:58.784303+05	info
231	64d13e15-59e8-4e97-b017-707d19f68907	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"Canned Message [ads assdf sdf ] created by user with username [null]","title":"Create Canned Message","level":"info","event_id":"64d13e15-59e8-4e97-b017-707d19f68907","timestamp":1588661284709}	\N	2020-05-05 11:48:04.711593+05	info
232	3524c606-1168-4670-b07f-88e388c59f3b	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"Canned Message [hjgkjhgkjg] created by user with username [null]","title":"Create Canned Message","level":"info","event_id":"3524c606-1168-4670-b07f-88e388c59f3b","timestamp":1588662507327}	\N	2020-05-05 12:08:27.331111+05	info
233	d99f124c-89d9-4922-b706-ff9b5f185047	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"Canned Message [fdgdgdfgdfg] created by user with username [null]","title":"Create Canned Message","level":"info","event_id":"d99f124c-89d9-4922-b706-ff9b5f185047","timestamp":1588663039987}	\N	2020-05-05 12:17:19.990619+05	info
234	a8a10fb9-8957-48e4-a02e-3408b106e4f5	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"Canned Message [sfasdfasdfasdf] created by user with username [null]","title":"Create Canned Message","level":"info","event_id":"a8a10fb9-8957-48e4-a02e-3408b106e4f5","timestamp":1588663109765}	\N	2020-05-05 12:18:29.771553+05	info
235	5ac9942c-cea1-4dac-b559-b455a0b0e36e	{"userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","clientId":"1","userId":"1","message":"User [null] fetch all records of Contact-Group","title":"Fetch Contact-Group","level":"info","event_id":"5ac9942c-cea1-4dac-b559-b455a0b0e36e","timestamp":1588713920265}	\N	2020-05-06 02:25:20.268437+05	info
236	98f2a402-b623-46d5-bb2e-fc625b0b577e	{"clientId":"1","userTokenId":"2c994e73-9b58-480e-bf21-bb82e40b9458","userId":"1","message":"Customer Attribute updated by User with username [null]","title":"Update Customer-Attribute","level":"info","event_id":"98f2a402-b623-46d5-bb2e-fc625b0b577e","timestamp":1588713930894}	\N	2020-05-06 02:25:30.896711+05	info
237	8e53a97d-dbbf-47c4-9e7a-053093dd4d10	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"8e53a97d-dbbf-47c4-9e7a-053093dd4d10","timestamp":1588792653944}	\N	2020-05-07 00:17:33.947038+05	info
238	0f1bcd34-07f9-417d-8df7-1b5e61ceb5b1	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"0f1bcd34-07f9-417d-8df7-1b5e61ceb5b1","timestamp":1588792657143}	\N	2020-05-07 00:17:37.14643+05	info
239	bb468360-1f17-45f8-a09e-bcef559a33fe	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] went offline","title":"Agent Offline","level":"info","event_id":"bb468360-1f17-45f8-a09e-bcef559a33fe","timestamp":1588792899082}	\N	2020-05-07 00:21:39.085556+05	info
240	a6d0fb65-e8ce-4c7f-ae0f-bb68e36ac2a7	{"clientId":"1","userId":"1","message":"User with username [null] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged off","title":"User Logout","level":"info","event_id":"a6d0fb65-e8ce-4c7f-ae0f-bb68e36ac2a7","timestamp":1588792901084}	\N	2020-05-07 00:21:41.087941+05	info
241	92be4876-9055-496d-9ec4-ddfac59bb435	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"92be4876-9055-496d-9ec4-ddfac59bb435","timestamp":1588792902394}	\N	2020-05-07 00:21:42.398141+05	info
242	d800790a-5727-46df-aa4d-99179580ab38	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"d800790a-5727-46df-aa4d-99179580ab38","timestamp":1588792916130}	\N	2020-05-07 00:21:56.134152+05	info
243	5b66ed9d-8b53-4751-b476-39fd19ac633e	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"5b66ed9d-8b53-4751-b476-39fd19ac633e","timestamp":1588792945981}	\N	2020-05-07 00:22:25.988156+05	info
244	a1368460-9071-497a-92ab-6ade48230d9b	{"clientId":"1","userTokenId":"51036394-581c-4d05-8330-370bb727dd61","userId":"1","message":"User with username [admin] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"a1368460-9071-497a-92ab-6ade48230d9b","timestamp":1588792948906}	\N	2020-05-07 00:22:28.90922+05	info
245	b8aaaa3e-635a-4e80-8e42-bdf8b464db76	{"clientId":"1","userId":"1","message":"Agent with id [1] and client [1] came online","title":"Agent Online","level":"info","event_id":"b8aaaa3e-635a-4e80-8e42-bdf8b464db76","timestamp":1588792954046}	\N	2020-05-07 00:22:34.048982+05	info
246	76e1a3f4-899b-41c1-8b20-258f199b9402	{"clientId":"1","message":"Client with uuid [9162d620-455e-4006-8e39-ca6fae12c040] and api key [704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828] has just authenticated","title":"Client Authentication","level":"info","event_id":"76e1a3f4-899b-41c1-8b20-258f199b9402","timestamp":1588792982988}	\N	2020-05-07 00:23:02.992054+05	info
247	08c12ec4-c89e-4e02-a3de-eb7e00c68744	{"clientId":"1","userTokenId":"70ae16cb-229b-4a52-a91a-1c92688230ad","userId":"12","message":"User with username [agent1] and client [9162d620-455e-4006-8e39-ca6fae12c040] has just logged in","title":"User Login","level":"info","event_id":"08c12ec4-c89e-4e02-a3de-eb7e00c68744","timestamp":1588792988732}	\N	2020-05-07 00:23:08.735714+05	info
248	16faace5-aebc-4066-88a1-5faa290ed562	{"clientId":"1","userId":"12","message":"Agent with id [12] and client [1] came online","title":"Agent Online","level":"info","event_id":"16faace5-aebc-4066-88a1-5faa290ed562","timestamp":1588792992443}	\N	2020-05-07 00:23:12.445044+05	info
\.


--
-- Data for Name: autoreply_handles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.autoreply_handles (id, keyword, event, message, dt, dtu, enabled, "order") FROM stdin;
1	new_customer	send_message	Welcome to terminus!	2020-05-07 00:38:25.081045+05	\N	t	0
2	default	send_message	Welcome to Terminus, please select the following options to proceed,\\n\\n1) Talk to agent\\n2) News	2020-05-07 00:41:04.217316+05	\N	t	0
3	1	forward		2020-05-07 02:21:14.481968+05	\N	t	0
4	2	send_message	Please https://its.com.pk for news!	2020-05-07 02:21:34.977156+05	\N	t	0
5	agent_assigned	send_message	An agent has connected with you and will respond shortly	2020-05-07 02:50:31.104288+05	\N	t	0
\.


--
-- Data for Name: campaign_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaign_attributes (id, attribute_name, attribute_value, attribute_type, campaign_id, dt, dtu) FROM stdin;
\.


--
-- Data for Name: campaign_consumers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaign_consumers (id, msisdn, campaign_id, wt_status, sent, status, message_id, dt, dtu) FROM stdin;
67	923463312526	10	2	t	0	205	2020-03-13 21:47:09.947577+05	2020-03-13 23:29:03.397412+05
68	923158173127	10	2	t	0	206	2020-03-13 21:47:09.94918+05	2020-03-13 23:29:03.406057+05
81	923463312526	17	2	t	0	209	2020-03-14 01:36:13.142986+05	2020-03-14 01:47:01.899016+05
82	923158173127	17	2	t	0	210	2020-03-14 01:36:13.144703+05	2020-03-14 01:47:01.904033+05
75	923463312526	14	2	t	0	211	2020-03-14 01:30:42.453868+05	2020-03-14 01:48:21.877987+05
76	923158173127	14	2	t	0	212	2020-03-14 01:30:42.455706+05	2020-03-14 01:48:21.883608+05
69	9.23E+11	11	0	f	0	0	2020-03-13 22:00:46.536849+05	\N
70	9.23158E+11\r\n	11	0	f	0	0	2020-03-13 22:00:46.539977+05	\N
5	Year	3	0	f	0	0	2020-03-13 20:15:47.293092+05	\N
6	Industry_aggregation_NZSIOC	3	0	f	0	0	2020-03-13 20:15:47.294739+05	\N
7	Industry_code_NZSIOC	3	0	f	0	0	2020-03-13 20:15:47.295754+05	\N
8	Industry_name_NZSIOC	3	0	f	0	0	2020-03-13 20:15:47.296734+05	\N
9	Units	3	0	f	0	0	2020-03-13 20:15:47.297774+05	\N
10	Variable_code	3	0	f	0	0	2020-03-13 20:15:47.298758+05	\N
11	Variable_name	3	0	f	0	0	2020-03-13 20:15:47.299568+05	\N
12	Variable_category	3	0	f	0	0	2020-03-13 20:15:47.300336+05	\N
30	Variable_category	4	0	f	0	0	2020-03-13 20:17:30.754505+05	\N
31	Value	4	0	f	0	0	2020-03-13 20:17:30.755402+05	\N
32	Industry_code_ANZSIC06\r\n2018	4	0	f	0	0	2020-03-13 20:17:30.756193+05	\N
33	Level 1	4	0	f	0	0	2020-03-13 20:17:30.756928+05	\N
34	99999	4	0	f	0	0	2020-03-13 20:17:30.757651+05	\N
35	All industries	4	0	f	0	0	2020-03-13 20:17:30.758381+05	\N
36	Dollars (millions)	4	0	f	0	0	2020-03-13 20:17:30.759134+05	\N
37	H01	4	0	f	0	0	2020-03-13 20:17:30.759963+05	\N
38	Total income	4	0	f	0	0	2020-03-13 20:17:30.760947+05	\N
39	Financial performance	4	0	f	0	0	2020-03-13 20:17:30.761653+05	\N
40	691859	4	0	f	0	0	2020-03-13 20:17:30.762316+05	\N
83	923463312526	18	2	t	0	207	2020-03-14 01:40:32.214575+05	2020-03-14 01:40:42.14225+05
84	923158173127	18	2	t	0	208	2020-03-14 01:40:32.216397+05	2020-03-14 01:40:42.146468+05
77	923463312526	15	2	t	0	215	2020-03-14 01:34:13.327854+05	2020-03-14 01:52:21.75298+05
78	923158173127	15	2	t	0	216	2020-03-14 01:34:13.330229+05	2020-03-14 01:52:21.758435+05
71	9.23E+11	12	0	f	0	0	2020-03-13 22:04:13.964497+05	\N
72	9.23158E+11\r\n	12	0	f	0	0	2020-03-13 22:04:13.971277+05	\N
52	99999	5	0	f	0	0	2020-03-13 20:29:40.261181+05	\N
53	All industries	5	0	f	0	0	2020-03-13 20:29:40.261924+05	\N
54	Dollars (millions)	5	0	f	0	0	2020-03-13 20:29:40.262714+05	\N
55	H01	5	0	f	0	0	2020-03-13 20:29:40.263769+05	\N
56	Total income	5	0	f	0	0	2020-03-13 20:29:40.265975+05	\N
57	Financial performance	5	0	f	0	0	2020-03-13 20:29:40.267362+05	\N
58	691859	5	0	f	0	0	2020-03-13 20:29:40.26846+05	\N
59	923463312526	6	0	f	0	0	2020-03-13 20:42:02.431912+05	\N
61	923463312526	7	0	f	0	0	2020-03-13 20:42:12.050325+05	\N
63	923463312526	8	0	f	0	0	2020-03-13 20:43:38.098345+05	\N
60	923158173127	6	0	f	0	0	2020-03-13 20:42:02.433669+05	\N
62	923158173127	7	0	f	0	0	2020-03-13 20:42:12.052094+05	\N
64	923158173127	8	0	f	0	0	2020-03-13 20:43:38.100042+05	\N
65	9.23E+11	9	0	f	0	0	2020-03-13 21:10:08.441712+05	\N
4	923158173127	2	2	t	2	203	2020-03-13 15:50:06.705983+05	2020-03-13 23:29:03.312038+05
3	923463312526	2	2	t	2	204	2020-03-13 15:50:06.702099+05	2020-03-13 23:29:03.318765+05
79	923463312526	16	2	t	0	213	2020-03-14 01:35:21.655958+05	2020-03-14 01:50:43.837018+05
80	923158173127	16	2	t	0	214	2020-03-14 01:35:21.65786+05	2020-03-14 01:50:43.841906+05
73	9.23E+11	13	0	f	0	0	2020-03-13 22:20:00.816121+05	\N
74	9.23158E+11\r\n	13	0	f	0	0	2020-03-13 22:20:00.819004+05	\N
66	9.23158E+11\r\n	9	0	f	0	0	2020-03-13 21:10:08.44332+05	\N
13	Value	3	0	f	0	0	2020-03-13 20:15:47.301136+05	\N
14	Industry_code_ANZSIC06\r\n2018	3	0	f	0	0	2020-03-13 20:15:47.301887+05	\N
15	Level 1	3	0	f	0	0	2020-03-13 20:15:47.302617+05	\N
16	99999	3	0	f	0	0	2020-03-13 20:15:47.303499+05	\N
17	All industries	3	0	f	0	0	2020-03-13 20:15:47.304343+05	\N
18	Dollars (millions)	3	0	f	0	0	2020-03-13 20:15:47.305123+05	\N
19	H01	3	0	f	0	0	2020-03-13 20:15:47.306143+05	\N
20	Total income	3	0	f	0	0	2020-03-13 20:15:47.307226+05	\N
21	Financial performance	3	0	f	0	0	2020-03-13 20:15:47.308011+05	\N
22	691859	3	0	f	0	0	2020-03-13 20:15:47.308741+05	\N
23	Year	4	0	f	0	0	2020-03-13 20:17:30.746461+05	\N
27	Units	4	0	f	0	0	2020-03-13 20:17:30.751656+05	\N
24	Industry_aggregation_NZSIOC	4	0	f	0	0	2020-03-13 20:17:30.748307+05	\N
25	Industry_code_NZSIOC	4	0	f	0	0	2020-03-13 20:17:30.749498+05	\N
26	Industry_name_NZSIOC	4	0	f	0	0	2020-03-13 20:17:30.750626+05	\N
28	Variable_code	4	0	f	0	0	2020-03-13 20:17:30.752671+05	\N
29	Variable_name	4	0	f	0	0	2020-03-13 20:17:30.753554+05	\N
41	Year	5	0	f	0	0	2020-03-13 20:29:40.250394+05	\N
42	Industry_aggregation_NZSIOC	5	0	f	0	0	2020-03-13 20:29:40.251986+05	\N
43	Industry_code_NZSIOC	5	0	f	0	0	2020-03-13 20:29:40.253039+05	\N
44	Industry_name_NZSIOC	5	0	f	0	0	2020-03-13 20:29:40.253949+05	\N
45	Units	5	0	f	0	0	2020-03-13 20:29:40.254787+05	\N
46	Variable_code	5	0	f	0	0	2020-03-13 20:29:40.255824+05	\N
47	Variable_name	5	0	f	0	0	2020-03-13 20:29:40.257015+05	\N
48	Variable_category	5	0	f	0	0	2020-03-13 20:29:40.257931+05	\N
49	Value	5	0	f	0	0	2020-03-13 20:29:40.258834+05	\N
50	Industry_code_ANZSIC06\r\n2018	5	0	f	0	0	2020-03-13 20:29:40.259684+05	\N
51	Level 1	5	0	f	0	0	2020-03-13 20:29:40.260505+05	\N
\.


--
-- Data for Name: campaigns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaigns (id, name, description, template_id, message, message_params, begin_dt, activated, in_progress, consumers, success, failures, wt_reads, wt_responses, dt, dtu, client_id, created_by, completed, displayed) FROM stdin;
18	Another New One	Another One	1	\N	\N	2020-03-14 01:40:40.002+05	t	t	2	0	0	0	\N	2020-03-14 01:40:32.211261+05	2020-03-14 01:40:42.147565+05	1	1	t	t
17	Another New	Another	1	\N	\N	2020-03-14 01:47:00.012+05	t	t	2	0	0	0	\N	2020-03-14 01:36:13.140242+05	2020-03-14 01:47:01.905203+05	1	1	t	t
14	Test Campaign	Testing Campaigns	1	\N	\N	2020-03-14 01:48:20.003+05	t	t	2	0	0	0	\N	2020-03-14 01:30:42.450451+05	2020-03-14 01:48:21.885186+05	1	1	t	\N
16	New Campaign	New Test Campaign	1	\N	\N	2020-03-14 01:50:40.007+05	t	t	2	0	0	0	\N	2020-03-14 01:35:21.653148+05	2020-03-14 01:50:43.843479+05	1	1	t	t
15	Another Test	Testing	1	\N	\N	2020-03-14 01:52:20.002+05	t	f	2	1	0	1	\N	2020-03-14 01:34:13.324981+05	2020-03-14 01:52:21.759729+05	1	1	t	t
\.


--
-- Data for Name: canned_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.canned_messages (id, message_events, message_name, message_text, message_params, enabled, dt, dtu, client_id, message_type, attachment_url, creator, attachment_type, attachment_name) FROM stdin;
17	\N		Testing canned image messages	""	t	2020-04-20 00:40:24.538015+05	2020-04-20 00:40:24.538015	1	image	https://file.ac/21euCO1oZvAUu-R7xK-Ysw/1587325210937_Capture.PNG	1	\N	\N
18	\N	Video Canned	Testing video canned messages	""	t	2020-05-05 03:08:12.44993+05	2020-05-05 03:08:12.44993	1	video	https://file.ac/0A5hsYkQjQM/1588630083460_WhatsAppVideo2020-02-28at08.01.57.mp4	1	\N	\N
19	\N	Document Canned	Document Canned Message	""	t	2020-05-05 03:12:28.327464+05	2020-05-05 03:12:28.327464	1	document	https://file.ac/0ysqcNqs-jw/1588630342259_Tariq-Ahmed-Resume...pdf	1	\N	\N
20	\N	Doc Can	Send Doc Canned	""	t	2020-05-05 11:44:16.252533+05	2020-05-05 11:44:16.252533	1	document	https://file.ac/MueDPM3jgas/1588661025016_Whatsappfindings20thApril2020.docx	1		\N
21	\N	Documents	sdf sdfs dfsd sdfsdf sdf	""	t	2020-05-05 11:44:58.777699+05	2020-05-05 11:44:58.777699	1	document	https://file.ac/dsXgT5f9k_I/1588661087821_FSQA.docx	1		\N
22	\N	ads assdf sdf 		""	f	2020-05-05 11:48:04.704115+05	2020-05-05 11:48:04.704115	1	document	https://file.ac/9a-oAiPiqz0/1588661165728_FSQA.docx	1		\N
23	\N	hjgkjhgkjg		""	f	2020-05-05 12:08:27.317938+05	2020-05-05 12:08:27.317938	1	document	https://file.ac/Xgppu4kNCmo/1588662497537_FSQA.docx	1	application/vnd.openxmlformats-officedocument.wordprocessingml.document	\N
24	\N	fdgdgdfgdfg	asdasdadasd	""	t	2020-05-05 12:17:19.982437+05	2020-05-05 12:17:19.982437	1	document	https://file.ac/HCK0V0mMJ-Y/1588663029002_FSQA.docx	1	application/vnd.openxmlformats-officedocument.wordprocessingml.document	\N
25	\N	sfasdfasdfasdf	sdfsdfsdfsdfsdfdfs	""	t	2020-05-05 12:18:24.052848+05	2020-05-05 12:18:24.052848	1	document	https://file.ac/-IV5B_qGB3E/1588663080006_FSQA.docx	1	application/vnd.openxmlformats-officedocument.wordprocessingml.document	1588663080006_FSQA.docx
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (id, name, code, country_id, enabled, dt, dtu, creator, client_id) FROM stdin;
1	Karachi	KHI	1	t	2020-05-06 02:15:35.960993+05	\N	1	1
2	Lahore	LHR	1	t	2020-05-06 02:17:45.184453+05	\N	1	1
3	Islamabad	ISL	1	t	2020-05-06 02:23:26.046604+05	\N	1	1
\.


--
-- Data for Name: client_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_settings (client_id, setting_id) FROM stdin;
1	1
1	3
3	2
3	4
1	5
3	5
1	6
3	6
1	7
1	8
1	9
1	10
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id, host, api_key, number, uuid, enc_salt, max_token_count, enabled, dt, dtu, bot_id) FROM stdin;
1	localhost	704952ded8eba109c4f242c6796d1ba7d23f01eaa4ca9b6166c55506f497e828	923463312526	9162d620-455e-4006-8e39-ca6fae12c040	b5486bb8daa1b497838f617d85d75d23	1	t	2020-02-13 16:50:44.155224+05	2020-02-13 16:50:44.155224+05	0bdfb269-e6f4-4f96-8e92-471b456806b2
3	localhost	797526a6e491ec43bbe290a54193f25f5ea15f7514e84a853d8d501009b0ba11	923152084863	6f360ee5-730b-43d5-84f3-c2522d726eae	69198138186645a8ba7330e8da18ba8c	1	t	2020-03-31 13:28:38.121398+05	2020-03-31 13:28:38.121398+05	0c9eec11-4896-4793-a9b3-571683915ac5
\.


--
-- Data for Name: contact_group_number; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_group_number (group_id, customer_id) FROM stdin;
\.


--
-- Data for Name: contact_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_groups (id, title, description, user_id, client_id, creator, dt, dtu, enabled) FROM stdin;
\.


--
-- Data for Name: conversation_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversation_groups (id, group_id, creator, client_id, invite_link, enabled, deleted, dt, dtu, group_icon, user_id, subject, user_left, invite_enabled, group_members, group_admins) FROM stdin;
29	group:447537454158-1587307303	1	1	https://chat.whatsapp.com/GN3ohaDfbBW3COa2gvSa8o	t	f	2020-04-19 19:41:44.717943+05	2020-04-19 20:26:20.501643+05	default_group_icon.png	1	ITS Test Group 2 Updated	f	f	["923463312526","447537454158"]	["447537454158"]
\.


--
-- Data for Name: conversation_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversation_templates (id, template_params, template_name, template_text, template_events, enabled, approved, dt, dtu, client_id, template_tag, template_type, attachment_url, creator) FROM stdin;
1	null	Demo Template	Welcome to the demo!	\N	t	t	2020-02-21 17:48:52.976156+05	2020-02-21 17:48:52.976156+05	1	get_started	text	\N	0
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.countries (id, name, code, client_id, enabled, dt, dtu, creator) FROM stdin;
1	Pakistan	PK	1	t	2020-05-06 01:46:04.694875+05	\N	1
\.


--
-- Data for Name: customer_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_attributes (id, attribute_name, attribute_value, attribute_type, customer_id, dt, dtu, "order") FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, name, number, number_hash, email, dt, dtu, client_id, user_id, last_user, chat_id, blocked, reason) FROM stdin;
\.


--
-- Data for Name: inbound_attachment_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inbound_attachment_attributes (id, attribute_value, attribute_type, attribute_name, attachment_id, dt) FROM stdin;
\.


--
-- Data for Name: inbound_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inbound_attachments (id, attachment_type, attachment_type_id, message_id, dt) FROM stdin;
\.


--
-- Data for Name: inbound_customer_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inbound_customer_contacts (id, name, number, whatsapp_enabled, attachment_id, message_id, customer_id, user_id, group_id, dt, dtu, contact_type) FROM stdin;
\.


--
-- Data for Name: inbound_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inbound_messages (id, message_id, number, type, message_body, receiver, user_id, client_id, message_token_hash, number_hash, customer_id, group_id, received_at, attachment_id) FROM stdin;
\.


--
-- Data for Name: message_delivery_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_delivery_reports (id, message_id, message_state, message_state_hash, message_status, message_id_hash, dt) FROM stdin;
\.


--
-- Data for Name: message_states; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_states (id, state_text, default_state, state_hash) FROM stdin;
2	queued	t	\N
3	sent	f	\N
4	delivered	f	\N
5	dispatched	f	\N
6	read	f	\N
7	failed	f	\N
\.


--
-- Data for Name: outbound_attachment_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.outbound_attachment_attributes (id, attribute_value, attribute_type, attribute_name, attachment_id, dt) FROM stdin;
\.


--
-- Data for Name: outbound_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.outbound_attachments (id, attachment_type, attachment_type_id, message_id, dt) FROM stdin;
\.


--
-- Data for Name: outbound_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.outbound_messages (id, sender_id, client_id, message_id, message_id_hash, message_body, message_status, dt, dtu, message_type, receiver, receiver_id, group_id, cb_details, attachment_id, campaign_id) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, method, description, rule_set, dt, dtu, enabled, consumer, title, displayed) FROM stdin;
9	BACK	Grant Agent Backend Access	["edit_customer","delete_customer","toggle_customer","list_customer","detail_customer"]	2020-04-28 21:46:41.377253+05	2020-04-28 21:46:41.377253+05	t	2	Agent Backend Access	t
5	FRONT	\N	["/countries", "/cities","/dashboard","/role-management","/conversations","/contact-book","/permissions","/roles","/compose","/groups","/group-details","/user-management","/whatsapp-templates","/canned-messages","/group-conversation","/campaigns","/profile","/block-list", "/reports/chat", "/reports/campaigns", "/reports/broadcasts", "/reports/agents", "/contact-groups", "/application-activity-logs", "/agents-conversation-history"]	2020-04-13 21:07:58.930906+05	2020-04-13 21:07:58.930906+05	t	3	Full Frontend Permissions	f
4	BACK	\N	["edit_user","create_user","view_user","view_own_user","delete_user","delete_own_user","toggle_user","toggle_own_user","list_user","list_own_user","view_user_details","view_own_user_details","edit_role","create_role","delete_role","toggle_role","list_role","view_role_details","edit_permission","create_permission","delete_permission","toggle_permission","list_permission","view_permission_details","edit_message_state","create_message_state","delete_message_state","toggle_message_state","list_message_state","detail_message_state","edit_client","create_client","delete_client","toggle_client","list_client","detail_client","edit_canned","create_canned","delete_canned","toggle_canned","list_canned","detail_canned","edit_campaign","create_campaign","delete_campaign","toggle_campaign","list_campaign","detail_campaign","edit_template","create_template","delete_template","approve_template","list_template","detail_template","edit_wtgroup","create_wtgroup","delete_wtgroup","toggle_wtgroup","list_wtgroup","detail_wtgroup","edit_customer","delete_customer","toggle_customer","list_customer","detail_customer"]	2020-04-13 21:07:10.643179+05	2020-04-13 21:07:10.643179+05	t	2	Full Backend Permissions	f
7	FRONT	Grant agent frontend access	["/conversations","/contact-book","/dashboard","/block-list","/profile"]	2020-04-15 17:13:39.174077+05	2020-04-15 17:13:39.174077+05	t	3	Agent Frontend Access	t
3	APP	\N	["receive_call","send_audio","send_video","send_image","send_document","send_canned","record_audio","can_block","export_chat","email_chat","shift_chat","view_reports","view_own_report","view_others_report","view_profile","edit_profile", "access_conversation_actions", "view_dashboard_stats"]	2020-04-13 21:06:00.940891+05	2020-04-13 21:06:00.940891+05	t	1	Full Application Permissions	f
8	APP	Grant agent application feature access	["receive_call","send_audio","send_video","send_image","send_document","send_canned","record_audio","can_block","export_chat","email_chat","shift_chat","shift_chat_to_manager","escalate_chat","view_agent_activity","view_all_chats","view_profile","edit_profile","view_activity_logs","access_conversation_actions","access_chat_context_menu","view_others_report","view_own_report","view_reports"]	2020-04-28 21:44:53.170386+05	2020-04-28 21:44:53.170386+05	t	1	Agent Application Access	t
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (permission_id, role_id) FROM stdin;
3	61
4	61
5	61
\N	\N
7	64
9	64
8	64
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, description, client_id, dt, dtu, enabled, displayed) FROM stdin;
61	Superuser	Application Superuser With All Privileges	1	2020-04-13 21:11:12.945469+05	2020-04-13 21:11:12.945469+05	t	f
64	Agent	Helpdesk Representative	1	2020-04-15 19:17:26.930602+05	2020-04-15 19:17:26.930602+05	t	t
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, field_name, field_value, field_type, enabled, dt, dtu) FROM stdin;
1	wt_api	https://eu1.whatsapp.api.sinch.com/whatsapp/v1	string	t	2020-04-01 11:46:18.467336+05	2020-04-01 11:46:18.467336+05
3	wt_auth_header	Authorization: Bearer YgXMZKMrsg.e555iVHpmn.PZDCjaUAp8	string	t	2020-04-01 11:46:18.467336+05	2020-04-01 11:46:18.467336+05
4	wt_auth_header	xt-api-key:4495ed30fd064f5426bb5d3fccc070cecda8c1350d724a2921621b8a6d884c15	string	t	2020-04-01 11:46:18.467336+05	2020-04-01 11:46:18.467336+05
2	wt_api	http://localhost:4000/v1	string	t	2020-04-01 11:46:18.467336+05	2020-04-01 11:46:18.467336+05
5	max_calls_per_agent	10	number	t	2020-04-12 13:51:47.577431+05	2020-04-12 13:51:47.577431+05
6	agent_idle_seconds	20	number	t	2020-04-14 00:32:33.229191+05	2020-04-14 00:32:33.229191+05
7	client_logo	https://file.ac/21euCO1oZvBb8uCVjHbzGw/1587330626704_wc-logo.jpg	string	t	2020-04-19 19:28:47.983872+05	2020-04-19 19:28:47.983872+05
8	autoreply	true	boolean	t	2020-05-04 00:28:42.072862+05	2020-05-04 00:28:42.072862+05
9	segregated_queues	true	boolean	t	2020-05-04 19:50:49.546624+05	2020-05-04 19:50:49.546624+05
10	queue_segregation_key	city	string	t	2020-05-04 19:51:13.289425+05	2020-05-04 19:51:13.289425+05
\.


--
-- Data for Name: user_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attributes (id, attribute_name, attribute_value, attribute_type, user_id, dt, dtu, "order") FROM stdin;
1	firstname	Admin	string	1	2020-04-20 00:06:33.798222+05	2020-04-20 00:13:38.732637+05	0
2	lastname	Account	string	1	2020-04-20 00:06:33.798222+05	2020-04-20 00:13:38.736736+05	0
3	age	30	number	1	2020-04-20 00:06:33.798222+05	2020-04-20 00:13:38.739352+05	0
4	gender	Male	string	1	2020-04-20 00:06:33.798222+05	2020-04-20 00:13:38.741448+05	0
5	address	Admin Address	string	1	2020-04-20 00:06:33.798222+05	2020-04-20 00:13:38.744755+05	0
6	cnic	4220148908607	string	1	2020-04-20 00:06:33.798222+05	2020-04-20 00:13:38.746894+05	0
7	dob	13/01/1988	string	1	2020-04-20 00:06:33.798222+05	2020-04-20 00:13:38.749036+05	0
8	image	https://file.ac/21euCO1oZvCctpa3Q-XSYg/1587323607470_asd3434dfcvb.PNG	string	1	2020-04-20 00:12:28.8876+05	2020-04-20 00:13:38.751049+05	0
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (user_id, role_id) FROM stdin;
1	61
12	64
\.


--
-- Data for Name: user_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_settings (user_id, setting_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password, email, number, max_token_count, enabled, client_id, dt, dtu, enc_salt, default_receiver, creator, displayed) FROM stdin;
12	agent1	afa8cdbb321ff1e2b2cf9c3b8012b163f5c01824bf9cb596d360eb4285b74b32	agen1@its.com.pk	03152084863	1	t	1	2020-04-15 20:23:18.060308+05	2020-04-15 20:23:18.060308+05	4e8f1a69be98311e02c5f190d581e47f	f	1	t
1	admin	9a39873216cdf7860561aff39460abb294260fa3d513a81ee3918b754d7ad628	amustafa@its.com.pk	03312737076	-1	t	1	2020-02-15 15:58:58.778513+05	2020-02-15 15:58:58.778513+05	055178eb2cd1168710d9dbcf474e12b2	t	0	f
\.


--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 248, true);


--
-- Name: autoreply_handles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.autoreply_handles_id_seq', 5, true);


--
-- Name: campaign_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.campaign_attributes_id_seq', 1, false);


--
-- Name: campaign_consumers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.campaign_consumers_id_seq', 84, true);


--
-- Name: campaigns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.campaigns_id_seq', 18, true);


--
-- Name: canned_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.canned_messages_id_seq', 25, true);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_id_seq', 3, true);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 3, true);


--
-- Name: contact_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_groups_id_seq', 2, true);


--
-- Name: conversation_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversation_groups_id_seq', 29, true);


--
-- Name: conversation_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversation_templates_id_seq', 11, true);


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.countries_id_seq', 1, true);


--
-- Name: customer_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_attributes_id_seq', 608, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 108, true);


--
-- Name: inbound_attachment_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inbound_attachment_attributes_id_seq', 353, true);


--
-- Name: inbound_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inbound_attachments_id_seq', 115, true);


--
-- Name: inbound_customer_contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inbound_customer_contacts_id_seq', 5, true);


--
-- Name: inbound_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inbound_messages_id_seq', 640, true);


--
-- Name: message_delivery_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.message_delivery_reports_id_seq', 1, false);


--
-- Name: message_states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.message_states_id_seq', 7, true);


--
-- Name: outbound_attachment_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.outbound_attachment_attributes_id_seq', 359, true);


--
-- Name: outbound_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.outbound_attachments_id_seq', 100, true);


--
-- Name: outbound_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.outbound_messages_id_seq', 325, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 9, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 64, true);


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settings_id_seq', 10, true);


--
-- Name: user_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_attributes_id_seq', 8, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 12, true);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: autoreply_handles autoreply_handles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autoreply_handles
    ADD CONSTRAINT autoreply_handles_pkey PRIMARY KEY (id);


--
-- Name: campaign_consumers campaign_consumers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaign_consumers
    ADD CONSTRAINT campaign_consumers_pkey PRIMARY KEY (id);


--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (id);


--
-- Name: canned_messages canned_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canned_messages
    ADD CONSTRAINT canned_messages_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contact_groups contact_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_groups
    ADD CONSTRAINT contact_groups_pkey PRIMARY KEY (id);


--
-- Name: conversation_templates conversation_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation_templates
    ADD CONSTRAINT conversation_templates_pkey PRIMARY KEY (id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: inbound_messages inbound_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inbound_messages
    ADD CONSTRAINT inbound_messages_pkey PRIMARY KEY (id);


--
-- Name: user_attributes user_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attributes
    ADD CONSTRAINT user_attributes_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

