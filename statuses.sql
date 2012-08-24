--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: weather_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('weather_statuses_id_seq', 12, true);


--
-- Data for Name: weather_statuses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY weather_statuses (id, api_name, name, created_at, updated_at) FROM stdin;
1	Chance of Showers	raining	2012-08-24 18:32:52.866181	2012-08-24 18:32:52.866181
2	Chance of Storm	thunderstorm	2012-08-24 18:33:16.802782	2012-08-24 18:33:16.802782
3	chancerain	raining	2012-08-24 18:33:51.411333	2012-08-24 18:33:51.411333
4	chancetstorms	thunderstorm	2012-08-24 18:34:21.599991	2012-08-24 18:34:21.599991
5	clear	sunny	2012-08-24 18:34:58.055856	2012-08-24 18:34:58.055856
6	Fog	foggy	2012-08-24 18:35:18.533513	2012-08-24 18:35:18.533513
7	Mostly Sunny	sunny	2012-08-24 18:35:42.784999	2012-08-24 18:35:42.784999
8	mostlycloudy	cloudy	2012-08-24 18:36:11.08631	2012-08-24 18:36:11.08631
9	Partly Sunny	partly-cloudy	2012-08-24 18:36:42.768021	2012-08-24 18:36:42.768021
10	partlycloudy	partly-cloudy	2012-08-24 18:37:11.523822	2012-08-24 18:37:11.523822
11	Thunderstorm	thunderstorm	2012-08-24 18:37:30.492328	2012-08-24 18:37:30.492328
12	tstorms	thunderstorm	2012-08-24 18:37:46.000764	2012-08-24 18:37:46.000764
\.


--
-- PostgreSQL database dump complete
--

