--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: characterachievements(integer); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION characterachievements(points integer) RETURNS TABLE(c_name character varying, c_points integer)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
	Return query
	SELECT c.name as c_name, c.achievements_points as c_points FROM characters c WHERE c.achievements_points > points;
END;
$$;


ALTER FUNCTION public.characterachievements(points integer) OWNER TO matthewmorales;

--
-- Name: characterarmorupgrade(character varying); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION characterarmorupgrade(char_name character varying) RETURNS TABLE(a_name character varying, a_lvl integer)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
	Return query
	SELECT a.name as a_name, a."itemLevel" as a_lvl FROM armors a WHERE a."itemLevel" > (SELECT armors."itemLevel" FROM armors WHERE id = (SELECT armor_id FROM characters WHERE name = char_name));
END;
$$;


ALTER FUNCTION public.characterarmorupgrade(char_name character varying) OWNER TO matthewmorales;

--
-- Name: characterlevel(integer); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION characterlevel(clevel integer) RETURNS TABLE(c_name character varying, c_level integer)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
	Return query
	SELECT c.name as c_name, c.level as c_level FROM characters c WHERE c.level = clevel;
END;
$$;


ALTER FUNCTION public.characterlevel(clevel integer) OWNER TO matthewmorales;

--
-- Name: charactermounts(character varying); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION charactermounts(character_name character varying) RETURNS TABLE(m_name character varying)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
	Return query
	SELECT m.name as m_name FROM mounts m, characters_mounts z WHERE z.mount_id = m.id AND z.character_id = (( SELECT characters.id
           FROM characters
          WHERE characters.name = character_name));
END;
$$;


ALTER FUNCTION public.charactermounts(character_name character varying) OWNER TO matthewmorales;

--
-- Name: characteroffhandupgrade(character varying); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION characteroffhandupgrade(char_name character varying) RETURNS TABLE(a_name character varying, a_lvl integer)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
	Return query
	SELECT a.name as a_name, a."itemLevel" as a_lvl FROM offhands a WHERE a."itemLevel" > (SELECT offhands."itemLevel" FROM offhands WHERE id = (SELECT offhand_id FROM characters WHERE name = char_name));
END;
$$;


ALTER FUNCTION public.characteroffhandupgrade(char_name character varying) OWNER TO matthewmorales;

--
-- Name: characterrealm(character varying); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION characterrealm(crealm character varying) RETURNS TABLE(c_name character varying, c_realm character varying)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
	Return query
	SELECT c.name as c_name, c.realm as c_realm FROM characters c WHERE c.realm = crealm;
END;
$$;


ALTER FUNCTION public.characterrealm(crealm character varying) OWNER TO matthewmorales;

--
-- Name: characterstats(character varying); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION characterstats(character_name character varying) RETURNS TABLE(c_name character varying, health integer, powertype character varying, power integer, strength integer, agility integer, intelligence integer, stamina integer)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
	Return query
	SELECT c.name as c_name, s.health, s."powerType", s.power, s.str, s.agi, s."int", s.sta FROM characters c, stats s WHERE c.name = character_name AND s.character_id = (SELECT id FROM characters WHERE characters.name = character_name);
END;
$$;


ALTER FUNCTION public.characterstats(character_name character varying) OWNER TO matthewmorales;

--
-- Name: charactertitles(character varying); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION charactertitles(character_name character varying) RETURNS SETOF character varying
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
	Return query
	SELECT t.name as t_name FROM titles t, characters_titles z WHERE z.title_id = t.id AND z.character_id = (( SELECT characters.id
           FROM characters
          WHERE characters.name = character_name));
END;
$$;


ALTER FUNCTION public.charactertitles(character_name character varying) OWNER TO matthewmorales;

--
-- Name: characterweaponupgrade(character varying); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION characterweaponupgrade(char_name character varying) RETURNS TABLE(a_name character varying, a_lvl integer)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
	Return query
	SELECT a.name as a_name, a."itemLevel" as a_lvl FROM mainhands a WHERE a."itemLevel" > (SELECT mainhands."itemLevel" FROM mainhands WHERE id = (SELECT mainhand_id FROM characters WHERE name = char_name));
END;
$$;


ALTER FUNCTION public.characterweaponupgrade(char_name character varying) OWNER TO matthewmorales;

--
-- Name: guildachievements(integer); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION guildachievements(points integer) RETURNS TABLE(g_name character varying, g_points integer)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
	Return query
	SELECT g.name as g_name, g."achievementPoints" as g_points FROM guilds g WHERE g."achievementPoints" > points;
END;
$$;


ALTER FUNCTION public.guildachievements(points integer) OWNER TO matthewmorales;

--
-- Name: guildroster(character varying); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION guildroster(guild_name character varying) RETURNS TABLE(c_name character varying, guild character varying)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
	Return query
	SELECT c.name as C_name, g.name as Guild FROM characters c, guilds g WHERE g.name = guild_name AND c.guild_id = (SELECT id FROM guilds WHERE name = guild_name);
END;
$$;


ALTER FUNCTION public.guildroster(guild_name character varying) OWNER TO matthewmorales;

--
-- Name: guildsize(integer); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION guildsize(size integer) RETURNS TABLE(g_name character varying)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
	Return query
	SELECT g.name as g_name FROM guilds g WHERE members >= size;
END;
$$;


ALTER FUNCTION public.guildsize(size integer) OWNER TO matthewmorales;

--
-- Name: updatedcharacter(); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION updatedcharacter() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
 UPDATE chracters SET updated_at = now() WHERE id = OLD.id;
 RETURN NEW;
END;
$$;


ALTER FUNCTION public.updatedcharacter() OWNER TO matthewmorales;

--
-- Name: updatedguild(); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION updatedguild() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
 UPDATE guilds SET updated_at = now() WHERE id = OLD.id;
 RETURN NEW;
END;
$$;


ALTER FUNCTION public.updatedguild() OWNER TO matthewmorales;

--
-- Name: updatedstats(); Type: FUNCTION; Schema: public; Owner: matthewmorales
--

CREATE FUNCTION updatedstats() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER COST 10
    AS $$
BEGIN
 UPDATE stats SET updated_at = now() WHERE id = OLD.id;
 RETURN NEW;
END;
$$;


ALTER FUNCTION public.updatedstats() OWNER TO matthewmorales;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: guilds; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE guilds (
    id integer NOT NULL,
    name character varying,
    realm character varying,
    battlegroup character varying,
    members integer,
    "achievementPoints" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.guilds OWNER TO wow_db;

--
-- Name: Guilds Over 2k Achv; Type: VIEW; Schema: public; Owner: matthewmorales
--

CREATE VIEW "Guilds Over 2k Achv" AS
 SELECT guilds.name,
    guilds.realm,
    guilds."achievementPoints"
   FROM guilds
  WHERE (guilds."achievementPoints" > 2000);


ALTER TABLE public."Guilds Over 2k Achv" OWNER TO matthewmorales;

--
-- Name: characters; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE characters (
    id integer NOT NULL,
    name character varying,
    locale character varying,
    realm character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    level integer,
    gender character varying,
    char_class integer,
    race integer,
    achievements_points integer,
    honorable_kills integer,
    battle_group character varying,
    faction character varying,
    guild_id integer,
    armor_id integer,
    tabard_id integer,
    mainhand_id integer,
    offhand_id integer,
    stat_id integer,
    title_id integer,
    mount_id integer,
    trinket_id integer,
    ring_id integer,
    neckpiece_id integer
);


ALTER TABLE public.characters OWNER TO wow_db;

--
-- Name: characters_mounts; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE characters_mounts (
    character_id integer NOT NULL,
    mount_id integer NOT NULL
);


ALTER TABLE public.characters_mounts OWNER TO wow_db;

--
-- Name: mounts; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE mounts (
    id integer NOT NULL,
    name character varying,
    "isFlying" boolean,
    "isGround" boolean,
    "isAquatic" boolean,
    "isJumping" boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "spellId" integer
);


ALTER TABLE public.mounts OWNER TO wow_db;

--
-- Name: Nalias Mounts; Type: VIEW; Schema: public; Owner: matthewmorales
--

CREATE VIEW "Nalias Mounts" AS
 SELECT m.name
   FROM mounts m,
    characters_mounts z
  WHERE ((z.mount_id = m.id) AND (z.character_id = ( SELECT characters.id
           FROM characters
          WHERE ((characters.name)::text = 'Nalía'::text))));


ALTER TABLE public."Nalias Mounts" OWNER TO matthewmorales;

--
-- Name: stats; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE stats (
    id integer NOT NULL,
    health integer,
    "powerType" character varying,
    power integer,
    str integer,
    agi integer,
    "int" integer,
    sta integer,
    crit double precision,
    haste double precision,
    mastery double precision,
    "bonusArmor" integer,
    "spellPower" integer,
    armor integer,
    parry double precision,
    block double precision,
    "attackPower" integer,
    "mainHandDps" double precision,
    "rangedAttackPower" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    character_id integer
);


ALTER TABLE public.stats OWNER TO wow_db;

--
-- Name: Nalias Stats; Type: VIEW; Schema: public; Owner: matthewmorales
--

CREATE VIEW "Nalias Stats" AS
 SELECT c.name,
    s.id,
    s.health,
    s."powerType",
    s.power,
    s.str,
    s.agi,
    s."int",
    s.sta,
    s.crit,
    s.haste,
    s.mastery,
    s."bonusArmor",
    s."spellPower",
    s.armor,
    s.parry,
    s.block,
    s."attackPower",
    s."mainHandDps",
    s."rangedAttackPower",
    s.created_at,
    s.updated_at,
    s.character_id
   FROM characters c,
    stats s
  WHERE (((c.name)::text = 'Nalía'::text) AND (s.character_id = ( SELECT characters.id
           FROM characters
          WHERE ((characters.name)::text = 'Nalía'::text))));


ALTER TABLE public."Nalias Stats" OWNER TO matthewmorales;

--
-- Name: Over Nine Thousand; Type: VIEW; Schema: public; Owner: matthewmorales
--

CREATE VIEW "Over Nine Thousand" AS
 SELECT characters.name,
    characters.realm,
    characters.locale
   FROM characters
  WHERE (characters.achievements_points > 9000);


ALTER TABLE public."Over Nine Thousand" OWNER TO matthewmorales;

--
-- Name: Reformation Roster; Type: VIEW; Schema: public; Owner: matthewmorales
--

CREATE VIEW "Reformation Roster" AS
 SELECT c.name AS "character",
    c.level
   FROM characters c,
    guilds g
  WHERE (c.guild_id IN ( SELECT guilds.id
           FROM guilds
          WHERE ((guilds.name)::text = 'Reformation'::text)));


ALTER TABLE public."Reformation Roster" OWNER TO matthewmorales;

--
-- Name: armors; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE armors (
    id integer NOT NULL,
    name character varying,
    quality integer,
    "itemLevel" integer,
    armor integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    context character varying
);


ALTER TABLE public.armors OWNER TO wow_db;

--
-- Name: armors_id_seq; Type: SEQUENCE; Schema: public; Owner: wow_db
--

CREATE SEQUENCE armors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.armors_id_seq OWNER TO wow_db;

--
-- Name: armors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wow_db
--

ALTER SEQUENCE armors_id_seq OWNED BY armors.id;


--
-- Name: characters_id_seq; Type: SEQUENCE; Schema: public; Owner: wow_db
--

CREATE SEQUENCE characters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.characters_id_seq OWNER TO wow_db;

--
-- Name: characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wow_db
--

ALTER SEQUENCE characters_id_seq OWNED BY characters.id;


--
-- Name: characters_titles; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE characters_titles (
    character_id integer NOT NULL,
    title_id integer NOT NULL
);


ALTER TABLE public.characters_titles OWNER TO wow_db;

--
-- Name: guilds_id_seq; Type: SEQUENCE; Schema: public; Owner: wow_db
--

CREATE SEQUENCE guilds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guilds_id_seq OWNER TO wow_db;

--
-- Name: guilds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wow_db
--

ALTER SEQUENCE guilds_id_seq OWNED BY guilds.id;


--
-- Name: mainhands; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE mainhands (
    id integer NOT NULL,
    name character varying,
    quality integer,
    "itemLevel" integer,
    context character varying,
    dps double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.mainhands OWNER TO wow_db;

--
-- Name: mainhands_id_seq; Type: SEQUENCE; Schema: public; Owner: wow_db
--

CREATE SEQUENCE mainhands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mainhands_id_seq OWNER TO wow_db;

--
-- Name: mainhands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wow_db
--

ALTER SEQUENCE mainhands_id_seq OWNED BY mainhands.id;


--
-- Name: mounts_id_seq; Type: SEQUENCE; Schema: public; Owner: wow_db
--

CREATE SEQUENCE mounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mounts_id_seq OWNER TO wow_db;

--
-- Name: mounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wow_db
--

ALTER SEQUENCE mounts_id_seq OWNED BY mounts.id;


--
-- Name: neckpieces; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE neckpieces (
    id integer NOT NULL,
    name character varying,
    icon character varying,
    quality integer,
    "itemLevel" integer,
    armor integer,
    context character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.neckpieces OWNER TO wow_db;

--
-- Name: neckpieces_id_seq; Type: SEQUENCE; Schema: public; Owner: wow_db
--

CREATE SEQUENCE neckpieces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.neckpieces_id_seq OWNER TO wow_db;

--
-- Name: neckpieces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wow_db
--

ALTER SEQUENCE neckpieces_id_seq OWNED BY neckpieces.id;


--
-- Name: offhands; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE offhands (
    id integer NOT NULL,
    name character varying,
    quality integer,
    "itemLevel" integer,
    armor integer,
    context character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    dps double precision
);


ALTER TABLE public.offhands OWNER TO wow_db;

--
-- Name: offhands_id_seq; Type: SEQUENCE; Schema: public; Owner: wow_db
--

CREATE SEQUENCE offhands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offhands_id_seq OWNER TO wow_db;

--
-- Name: offhands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wow_db
--

ALTER SEQUENCE offhands_id_seq OWNED BY offhands.id;


--
-- Name: rings; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE rings (
    id integer NOT NULL,
    name character varying,
    icon character varying,
    quality integer,
    "itemLevel" integer,
    armor integer,
    context character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.rings OWNER TO wow_db;

--
-- Name: rings_id_seq; Type: SEQUENCE; Schema: public; Owner: wow_db
--

CREATE SEQUENCE rings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rings_id_seq OWNER TO wow_db;

--
-- Name: rings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wow_db
--

ALTER SEQUENCE rings_id_seq OWNED BY rings.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO wow_db;

--
-- Name: stats_id_seq; Type: SEQUENCE; Schema: public; Owner: wow_db
--

CREATE SEQUENCE stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stats_id_seq OWNER TO wow_db;

--
-- Name: stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wow_db
--

ALTER SEQUENCE stats_id_seq OWNED BY stats.id;


--
-- Name: tabards; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE tabards (
    id integer NOT NULL,
    name character varying,
    quality integer,
    "itemLevel" integer,
    context character varying,
    armor integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.tabards OWNER TO wow_db;

--
-- Name: tabards_id_seq; Type: SEQUENCE; Schema: public; Owner: wow_db
--

CREATE SEQUENCE tabards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tabards_id_seq OWNER TO wow_db;

--
-- Name: tabards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wow_db
--

ALTER SEQUENCE tabards_id_seq OWNED BY tabards.id;


--
-- Name: titles; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE titles (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.titles OWNER TO wow_db;

--
-- Name: titles_id_seq; Type: SEQUENCE; Schema: public; Owner: wow_db
--

CREATE SEQUENCE titles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.titles_id_seq OWNER TO wow_db;

--
-- Name: titles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wow_db
--

ALTER SEQUENCE titles_id_seq OWNED BY titles.id;


--
-- Name: trinkets; Type: TABLE; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE TABLE trinkets (
    id integer NOT NULL,
    name character varying,
    quality integer,
    "itemLevel" integer,
    armor integer,
    context character varying,
    icon character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.trinkets OWNER TO wow_db;

--
-- Name: trinkets_id_seq; Type: SEQUENCE; Schema: public; Owner: wow_db
--

CREATE SEQUENCE trinkets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trinkets_id_seq OWNER TO wow_db;

--
-- Name: trinkets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wow_db
--

ALTER SEQUENCE trinkets_id_seq OWNED BY trinkets.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY armors ALTER COLUMN id SET DEFAULT nextval('armors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY characters ALTER COLUMN id SET DEFAULT nextval('characters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY guilds ALTER COLUMN id SET DEFAULT nextval('guilds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY mainhands ALTER COLUMN id SET DEFAULT nextval('mainhands_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY mounts ALTER COLUMN id SET DEFAULT nextval('mounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY neckpieces ALTER COLUMN id SET DEFAULT nextval('neckpieces_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY offhands ALTER COLUMN id SET DEFAULT nextval('offhands_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY rings ALTER COLUMN id SET DEFAULT nextval('rings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY stats ALTER COLUMN id SET DEFAULT nextval('stats_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY tabards ALTER COLUMN id SET DEFAULT nextval('tabards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY titles ALTER COLUMN id SET DEFAULT nextval('titles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY trinkets ALTER COLUMN id SET DEFAULT nextval('trinkets_id_seq'::regclass);


--
-- Data for Name: armors; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY armors (id, name, quality, "itemLevel", armor, created_at, updated_at, context) FROM stdin;
115582	Blackhand's Chestguard	4	685	368	2015-12-13 09:53:08.500954	2015-12-13 09:53:08.500954	raid-heroic
124172	Pious Raiment	4	701	145	2015-12-13 09:53:18.724443	2015-12-13 09:53:18.724443	raid-normal
115566	Battleplate of Guiding Light	4	685	368	2015-12-13 09:53:28.455574	2015-12-13 09:53:28.455574	raid-heroic
113982	Chestguard of the Siegemaker	4	685	232	2015-12-13 09:53:42.686674	2015-12-13 09:53:42.686674	raid-heroic
115550	Arcanoshatter Robes	4	685	129	2015-12-13 09:53:54.052542	2015-12-13 09:53:54.052542	raid-heroic
124317	Demongaze Chestplate	4	735	429	2015-12-13 09:55:12.625299	2015-12-13 09:55:12.625299	raid-mythic
128072	Bulging Chain Vest	4	685	232	2015-12-13 09:55:33.585047	2015-12-13 09:55:33.585047	raid-finder
124570	Felcast Robes of the Peerless	3	650	101	2015-12-13 09:55:48.636846	2015-12-13 09:55:48.636846	dungeon-heroic
22416	Dreadnaught Breastplate	4	92	60	2015-12-13 10:05:06.889301	2015-12-13 10:05:06.889301	
\.


--
-- Name: armors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wow_db
--

SELECT pg_catalog.setval('armors_id_seq', 1, false);


--
-- Data for Name: characters; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY characters (id, name, locale, realm, created_at, updated_at, level, gender, char_class, race, achievements_points, honorable_kills, battle_group, faction, guild_id, armor_id, tabard_id, mainhand_id, offhand_id, stat_id, title_id, mount_id, trinket_id, ring_id, neckpiece_id) FROM stdin;
1	Nalía	en_US	Sargeras	2015-12-13 09:53:09.453048	2015-12-13 09:53:09.453048	100	Female	1	1	12435	9361	Shadowburn	Alliance	1	115582	5976	113927	113666	1	\N	\N	113893	113922	113923
2	Kínzie	en_US	Sargeras	2015-12-13 09:53:18.794965	2015-12-13 09:53:18.794965	100	Female	5	11	8105	3956	Shadowburn	Alliance	1	124172	\N	124364	113879	2	\N	\N	113986	124192	113890
3	Gram	en_US	Sargeras	2015-12-13 09:53:28.639	2015-12-13 09:53:28.639	100	Male	2	1	9755	17240	Shadowburn	Alliance	1	115566	52252	113927	113666	3	\N	\N	113893	113963	113923
4	Celesine	en_US	Sargeras	2015-12-13 09:53:42.834854	2015-12-13 09:53:42.834854	100	Female	7	11	12435	695	Shadowburn	Alliance	1	113982	35279	113607	113653	4	\N	\N	113986	118304	113598
5	Saturas	en_US	Sargeras	2015-12-13 09:53:54.229076	2015-12-13 09:53:54.229076	100	Male	8	1	12655	31781	Shadowburn	Alliance	1	115550	\N	124380	\N	5	\N	\N	124228	124192	109955
6	Syzlakk	en_US	Sargeras	2015-12-13 09:55:12.747537	2015-12-13 09:55:12.747537	100	Male	6	3	10215	29109	Shadowburn	Alliance	2	124317	\N	124360	\N	6	\N	\N	124236	124634	124216
7	Seedoo	en_US	Sargeras	2015-12-13 09:55:33.940822	2015-12-13 09:55:33.940822	100	Female	7	11	16755	31464	Shadowburn	Alliance	2	128072	\N	124631	129846	7	\N	\N	113859	118306	124212
8	Ghostchant	en_US	Sargeras	2015-12-13 09:55:48.892679	2015-12-13 09:55:48.892679	100	Female	5	1	12975	2	Shadowburn	Alliance	2	124570	\N	105690	\N	8	\N	\N	133596	95138	124608
9	Xav	en_US	Sen'Jin	2015-12-13 10:05:07.139957	2015-12-13 10:05:07.139957	100	Female	1	25	13615	18607	Bloodlust	Alliance	3	22416	\N	116454	19019	9	\N	\N	127401	128117	124610
\.


--
-- Name: characters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wow_db
--

SELECT pg_catalog.setval('characters_id_seq', 9, true);


--
-- Data for Name: characters_mounts; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY characters_mounts (character_id, mount_id) FROM stdin;
1	120968
1	44178
1	44225
1	44689
1	85430
1	87781
1	43986
1	94292
1	89391
1	44223
1	43956
1	29468
1	51954
1	44843
1	43953
1	44151
1	32319
1	43951
1	63044
1	89362
1	54811
1	31830
1	29227
1	115484
1	52200
1	73766
1	85429
1	62298
1	87782
1	87802
1	87803
1	29745
1	37828
1	87804
1	87801
1	29746
1	87805
1	29747
1	82811
1	46756
1	44707
1	32314
1	37012
1	98618
1	43958
1	51955
1	45801
1	79802
1	44413
1	49636
1	32316
1	32768
1	43955
1	44160
1	32317
1	87783
1	45802
1	65891
1	32318
1	31832
1	29229
1	76889
1	19030
1	25473
1	33977
1	18786
1	18777
1	18766
1	18787
1	46758
1	25528
1	18772
1	72146
1	18767
1	46759
1	73839
1	18776
1	25529
1	25527
1	72145
1	18902
1	46762
1	35513
1	18773
1	18785
1	18778
1	18774
1	37719
1	63045
1	31834
1	29230
1	44168
1	44235
1	46763
1	43954
1	76755
1	44177
1	89390
1	31836
1	29231
1	69846
1	44230
1	87795
1	2411
1	87796
1	8595
1	21218
1	87797
1	28481
1	5872
1	5655
1	25471
1	25470
1	29744
1	5864
1	82765
1	13321
1	21323
1	73838
1	2414
1	87799
1	29743
1	87800
1	89363
1	8563
1	25472
1	8632
1	47100
1	8631
1	8629
1	13322
1	54465
1	5873
1	21324
2	54797
2	34060
2	46109
3	47179
3	45725
3	43952
3	32858
3	81354
3	29467
3	29471
3	33999
3	63125
3	109013
3	71665
3	116794
3	93168
3	93385
3	82453
3	0
5	69747
5	29465
5	35906
5	116659
5	128311
5	115363
5	28915
5	29228
5	44558
5	116661
5	94291
5	116767
5	95416
5	128706
5	128526
5	116769
5	21321
5	116656
5	116662
5	116676
5	116675
5	116774
5	116784
5	116658
6	32458
6	123974
6	128422
6	128425
6	127140
6	50818
6	104246
6	116792
6	104269
6	40775
6	116791
6	116667
6	116671
6	116655
7	68823
7	77067
7	69230
7	62901
7	63039
7	30480
7	69213
7	60954
7	43959
7	43961
7	91802
7	77069
7	69224
7	64998
7	49044
7	68824
7	34061
7	77068
7	62900
7	13086
7	44554
8	93662
8	90710
8	89307
8	98405
8	118515
8	87769
8	89154
8	108883
8	106246
8	90711
8	95564
8	116383
8	84101
8	94293
8	89305
8	78924
8	87773
8	116660
8	94231
8	104253
8	49290
8	83086
8	87768
8	89306
8	104208
8	85666
8	90712
8	54860
8	116669
8	116666
8	87251
8	116663
9	33809
9	95341
9	44164
9	43516
9	49096
9	85870
9	45693
9	44175
9	19902
\.


--
-- Data for Name: characters_titles; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY characters_titles (character_id, title_id) FROM stdin;
1	81
1	74
1	75
1	78
1	113
1	121
1	124
1	129
1	130
1	133
1	134
1	135
1	137
1	140
1	143
1	146
1	147
1	148
1	149
1	155
1	156
1	164
1	165
1	168
1	172
1	173
1	175
1	176
1	189
1	190
1	227
1	228
1	229
1	285
1	303
1	287
1	316
1	382
1	338
1	351
1	438
3	63
3	64
3	77
3	131
3	278
5	3
5	320
5	415
6	226
6	342
7	79
7	84
7	126
7	132
7	141
7	142
7	166
7	174
7	191
7	195
7	196
7	198
7	199
7	267
7	276
7	315
7	333
8	314
8	317
8	384
8	387
9	53
9	120
9	122
9	139
9	158
9	159
9	160
9	161
9	170
9	386
\.


--
-- Data for Name: guilds; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY guilds (id, name, realm, battlegroup, members, "achievementPoints", created_at, updated_at) FROM stdin;
1	Reformation	Sargeras	Shadowburn	24	940	2015-12-13 09:53:09.204963	2015-12-13 09:53:09.204963
2	Midwinter	Sargeras	Shadowburn	407	2625	2015-12-13 09:55:12.722126	2015-12-13 09:55:12.722126
3	Premonition	Sen'jin	Bloodlust	292	1880	2015-12-13 10:05:07.096906	2015-12-13 10:05:07.096906
\.


--
-- Name: guilds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wow_db
--

SELECT pg_catalog.setval('guilds_id_seq', 3, true);


--
-- Data for Name: mainhands; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY mainhands (id, name, quality, "itemLevel", context, dps, created_at, updated_at) FROM stdin;
113927	Kromog's Brutal Fist	4	691	raid-heroic	411.730770000000007	2015-12-13 09:53:09.169653	2015-12-13 09:53:09.169653
124364	Fallen Warlord's Mindcarver	4	710	raid-heroic	245.555560000000014	2015-12-13 09:53:18.78411	2015-12-13 09:53:18.78411
113607	Butcher's Terrible Tenderizer	4	676	raid-heroic	179.13042999999999	2015-12-13 09:53:42.823195	2015-12-13 09:53:42.823195
124380	Spur of the Great Devourer	4	710	raid-heroic	316.03449999999998	2015-12-13 09:53:54.195363	2015-12-13 09:53:54.195363
124360	Hellrender	4	746	raid-mythic	884.166699999999992	2015-12-13 09:55:12.718675	2015-12-13 09:55:12.718675
124631	Baleful Scepter of the Aurora	4	695		213.4375	2015-12-13 09:55:33.874348	2015-12-13 09:55:33.874348
105690	Hellscream's War Staff	7	620		136.515150000000006	2015-12-13 09:55:48.842423	2015-12-13 09:55:48.842423
116454	Steelforged Saber of the Savage	3	630	trade-skill	233.269239999999996	2015-12-13 10:05:07.075293	2015-12-13 10:05:07.075293
\.


--
-- Name: mainhands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wow_db
--

SELECT pg_catalog.setval('mainhands_id_seq', 1, false);


--
-- Data for Name: mounts; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY mounts (id, name, "isFlying", "isGround", "isAquatic", "isJumping", created_at, updated_at, "spellId") FROM stdin;
120968	Chauffeured Mekgineer's Chopper	f	t	t	t	2015-12-13 09:53:08.659557	2015-12-13 09:53:08.659557	179245
44178	Albino Drake	t	t	t	t	2015-12-13 09:53:08.663374	2015-12-13 09:53:08.663374	60025
44225	Armored Brown Bear	f	t	t	t	2015-12-13 09:53:08.666467	2015-12-13 09:53:08.666467	60114
44689	Armored Snowy Gryphon	t	t	t	t	2015-12-13 09:53:08.670091	2015-12-13 09:53:08.670091	61229
85430	Azure Cloud Serpent	t	t	t	t	2015-12-13 09:53:08.67329	2015-12-13 09:53:08.67329	123992
87781	Azure Riding Crane	f	t	t	t	2015-12-13 09:53:08.676087	2015-12-13 09:53:08.676087	127174
43986	Black Drake	t	t	t	t	2015-12-13 09:53:08.679084	2015-12-13 09:53:08.679084	59650
94292	Black Primal Raptor	f	t	t	t	2015-12-13 09:53:08.681903	2015-12-13 09:53:08.681903	138642
89391	Black Riding Goat	f	t	t	t	2015-12-13 09:53:08.684786	2015-12-13 09:53:08.684786	130138
44223	Black War Bear	f	t	t	t	2015-12-13 09:53:08.687903	2015-12-13 09:53:08.687903	60118
43956	Black War Mammoth	f	t	t	t	2015-12-13 09:53:08.691782	2015-12-13 09:53:08.691782	59785
29468	Black War Steed	f	t	t	t	2015-12-13 09:53:08.696284	2015-12-13 09:53:08.696284	22717
51954	Bloodbathed Frostbrood Vanquisher	t	t	t	t	2015-12-13 09:53:08.698855	2015-12-13 09:53:08.698855	72808
44843	Blue Dragonhawk	t	t	t	t	2015-12-13 09:53:08.702263	2015-12-13 09:53:08.702263	61996
43953	Blue Drake	t	t	t	t	2015-12-13 09:53:08.705932	2015-12-13 09:53:08.705932	59568
44151	Blue Proto-Drake	t	t	t	t	2015-12-13 09:53:08.709033	2015-12-13 09:53:08.709033	59996
32319	Blue Riding Nether Ray	t	t	t	t	2015-12-13 09:53:08.714079	2015-12-13 09:53:08.714079	39803
43951	Bronze Drake	t	t	t	t	2015-12-13 09:53:08.717267	2015-12-13 09:53:08.717267	59569
63044	Brown Riding Camel	f	t	t	t	2015-12-13 09:53:08.71953	2015-12-13 09:53:08.71953	88748
89362	Brown Riding Goat	f	t	t	t	2015-12-13 09:53:08.721871	2015-12-13 09:53:08.721871	130086
54811	Celestial Steed	t	t	t	t	2015-12-13 09:53:08.725789	2015-12-13 09:53:08.725789	75614
31830	Cobalt Riding Talbuk	f	t	t	t	2015-12-13 09:53:08.729186	2015-12-13 09:53:08.729186	39315
29227	Cobalt War Talbuk	f	t	t	t	2015-12-13 09:53:08.732243	2015-12-13 09:53:08.732243	34896
115484	Core Hound	f	t	t	t	2015-12-13 09:53:08.735772	2015-12-13 09:53:08.735772	170347
52200	Crimson Deathcharger	f	t	t	t	2015-12-13 09:53:08.739037	2015-12-13 09:53:08.739037	73313
73766	Darkmoon Dancing Bear	f	t	t	t	2015-12-13 09:53:08.741524	2015-12-13 09:53:08.741524	103081
85429	Golden Cloud Serpent	t	t	t	t	2015-12-13 09:53:08.74483	2015-12-13 09:53:08.74483	123993
62298	Golden King	f	t	t	t	2015-12-13 09:53:08.747706	2015-12-13 09:53:08.747706	90621
87782	Golden Riding Crane	f	t	t	t	2015-12-13 09:53:08.750553	2015-12-13 09:53:08.750553	127176
87802	Great Black Dragon Turtle	f	t	t	t	2015-12-13 09:53:08.753491	2015-12-13 09:53:08.753491	127295
87803	Great Blue Dragon Turtle	f	t	t	t	2015-12-13 09:53:08.757062	2015-12-13 09:53:08.757062	127302
29745	Great Blue Elekk	f	t	t	t	2015-12-13 09:53:08.760185	2015-12-13 09:53:08.760185	35713
37828	Great Brewfest Kodo	f	t	t	t	2015-12-13 09:53:08.763286	2015-12-13 09:53:08.763286	49379
87804	Great Brown Dragon Turtle	f	t	t	t	2015-12-13 09:53:08.76609	2015-12-13 09:53:08.76609	127308
87801	Great Green Dragon Turtle	f	t	t	t	2015-12-13 09:53:08.7703	2015-12-13 09:53:08.7703	127293
29746	Great Green Elekk	f	t	t	t	2015-12-13 09:53:08.778847	2015-12-13 09:53:08.778847	35712
87805	Great Purple Dragon Turtle	f	t	t	t	2015-12-13 09:53:08.781695	2015-12-13 09:53:08.781695	127310
29747	Great Purple Elekk	f	t	t	t	2015-12-13 09:53:08.784341	2015-12-13 09:53:08.784341	35714
82811	Great Red Dragon Turtle	f	t	t	t	2015-12-13 09:53:08.787453	2015-12-13 09:53:08.787453	120822
46756	Great Red Elekk	f	t	t	t	2015-12-13 09:53:08.790832	2015-12-13 09:53:08.790832	65637
44707	Green Proto-Drake	t	t	t	t	2015-12-13 09:53:08.793541	2015-12-13 09:53:08.793541	61294
32314	Green Riding Nether Ray	t	t	t	t	2015-12-13 09:53:08.796664	2015-12-13 09:53:08.796664	39798
37012	Headless Horseman's Mount	t	t	t	t	2015-12-13 09:53:08.799738	2015-12-13 09:53:08.799738	48025
98618	Hearthsteed	t	t	t	t	2015-12-13 09:53:08.802402	2015-12-13 09:53:08.802402	142073
43958	Ice Mammoth	f	t	t	t	2015-12-13 09:53:08.805443	2015-12-13 09:53:08.805443	59799
51955	Icebound Frostbrood Vanquisher	t	t	t	t	2015-12-13 09:53:08.80843	2015-12-13 09:53:08.80843	72807
45801	Ironbound Proto-Drake	t	t	t	t	2015-12-13 09:53:08.811242	2015-12-13 09:53:08.811242	63956
79802	Jade Cloud Serpent	t	t	t	t	2015-12-13 09:53:08.814279	2015-12-13 09:53:08.814279	113199
44413	Mekgineer's Chopper	f	t	t	t	2015-12-13 09:53:08.817127	2015-12-13 09:53:08.817127	60424
49636	Onyxian Drake	t	t	t	t	2015-12-13 09:53:08.819582	2015-12-13 09:53:08.819582	69395
32316	Purple Riding Nether Ray	t	t	t	t	2015-12-13 09:53:08.823257	2015-12-13 09:53:08.823257	39801
32768	Raven Lord	f	t	t	t	2015-12-13 09:53:08.82628	2015-12-13 09:53:08.82628	41252
43955	Red Drake	t	t	t	t	2015-12-13 09:53:08.832174	2015-12-13 09:53:08.832174	59570
44160	Red Proto-Drake	t	t	t	t	2015-12-13 09:53:08.835121	2015-12-13 09:53:08.835121	59961
32317	Red Riding Nether Ray	t	t	t	t	2015-12-13 09:53:08.838901	2015-12-13 09:53:08.838901	39800
87783	Regal Riding Crane	f	t	t	t	2015-12-13 09:53:08.842046	2015-12-13 09:53:08.842046	127177
45802	Rusted Proto-Drake	t	t	t	t	2015-12-13 09:53:08.845354	2015-12-13 09:53:08.845354	63963
65891	Sandstone Drake	t	t	t	t	2015-12-13 09:53:08.849022	2015-12-13 09:53:08.849022	93326
32318	Silver Riding Nether Ray	t	t	t	t	2015-12-13 09:53:08.851503	2015-12-13 09:53:08.851503	39802
31832	Silver Riding Talbuk	f	t	t	t	2015-12-13 09:53:08.854464	2015-12-13 09:53:08.854464	39317
29229	Silver War Talbuk	f	t	t	t	2015-12-13 09:53:08.857779	2015-12-13 09:53:08.857779	34898
76889	Spectral Gryphon	t	t	t	t	2015-12-13 09:53:08.860621	2015-12-13 09:53:08.860621	107516
19030	Stormpike Battle Charger	f	t	t	t	2015-12-13 09:53:08.863358	2015-12-13 09:53:08.863358	23510
25473	Swift Blue Gryphon	t	t	t	t	2015-12-13 09:53:08.865959	2015-12-13 09:53:08.865959	32242
33977	Swift Brewfest Ram	f	t	t	t	2015-12-13 09:53:08.868886	2015-12-13 09:53:08.868886	43900
18786	Swift Brown Ram	f	t	t	t	2015-12-13 09:53:08.87731	2015-12-13 09:53:08.87731	23238
18777	Swift Brown Steed	f	t	t	t	2015-12-13 09:53:08.879994	2015-12-13 09:53:08.879994	23229
18766	Swift Frostsaber	f	t	t	t	2015-12-13 09:53:08.882076	2015-12-13 09:53:08.882076	23221
18787	Swift Gray Ram	f	t	t	t	2015-12-13 09:53:08.8855	2015-12-13 09:53:08.8855	23239
46758	Swift Gray Steed	f	t	t	t	2015-12-13 09:53:08.888106	2015-12-13 09:53:08.888106	65640
25528	Swift Green Gryphon	t	t	t	t	2015-12-13 09:53:08.891375	2015-12-13 09:53:08.891375	32290
18772	Swift Green Mechanostrider	f	t	t	t	2015-12-13 09:53:08.894494	2015-12-13 09:53:08.894494	23225
72146	Swift Lovebird	f	t	t	t	2015-12-13 09:53:08.897665	2015-12-13 09:53:08.897665	102350
18767	Swift Mistsaber	f	t	t	t	2015-12-13 09:53:08.901858	2015-12-13 09:53:08.901858	23219
46759	Swift Moonsaber	f	t	t	t	2015-12-13 09:53:08.905213	2015-12-13 09:53:08.905213	65638
73839	Swift Mountain Horse	f	t	t	t	2015-12-13 09:53:08.908426	2015-12-13 09:53:08.908426	103196
18776	Swift Palomino	f	t	t	t	2015-12-13 09:53:08.911399	2015-12-13 09:53:08.911399	23227
25529	Swift Purple Gryphon	t	t	t	t	2015-12-13 09:53:08.920756	2015-12-13 09:53:08.920756	32292
25527	Swift Red Gryphon	t	t	t	t	2015-12-13 09:53:08.923725	2015-12-13 09:53:08.923725	32289
72145	Swift Springstrider	f	t	t	t	2015-12-13 09:53:08.926478	2015-12-13 09:53:08.926478	102349
18902	Swift Stormsaber	f	t	t	t	2015-12-13 09:53:08.929469	2015-12-13 09:53:08.929469	23338
46762	Swift Violet Ram	f	t	t	t	2015-12-13 09:53:08.932623	2015-12-13 09:53:08.932623	65643
35513	Swift White Hawkstrider	f	t	t	t	2015-12-13 09:53:08.935747	2015-12-13 09:53:08.935747	46628
18773	Swift White Mechanostrider	f	t	t	t	2015-12-13 09:53:08.939624	2015-12-13 09:53:08.939624	23223
18785	Swift White Ram	f	t	t	t	2015-12-13 09:53:08.942308	2015-12-13 09:53:08.942308	23240
18778	Swift White Steed	f	t	t	t	2015-12-13 09:53:08.945177	2015-12-13 09:53:08.945177	23228
18774	Swift Yellow Mechanostrider	f	t	t	t	2015-12-13 09:53:08.947949	2015-12-13 09:53:08.947949	23222
37719	Swift Zhevra	f	t	t	t	2015-12-13 09:53:08.950851	2015-12-13 09:53:08.950851	49322
63045	Tan Riding Camel	f	t	t	t	2015-12-13 09:53:08.953859	2015-12-13 09:53:08.953859	88749
31834	Tan Riding Talbuk	f	t	t	t	2015-12-13 09:53:08.957248	2015-12-13 09:53:08.957248	39318
29230	Tan War Talbuk	f	t	t	t	2015-12-13 09:53:08.960133	2015-12-13 09:53:08.960133	34899
44168	Time-Lost Proto-Drake	t	t	t	t	2015-12-13 09:53:08.96287	2015-12-13 09:53:08.96287	60002
44235	Traveler's Tundra Mammoth	f	t	t	t	2015-12-13 09:53:08.967385	2015-12-13 09:53:08.967385	61425
46763	Turbostrider	f	t	t	t	2015-12-13 09:53:08.970446	2015-12-13 09:53:08.970446	65642
43954	Twilight Drake	t	t	t	t	2015-12-13 09:53:08.973416	2015-12-13 09:53:08.973416	59571
76755	Tyrael's Charger	t	t	t	t	2015-12-13 09:53:08.977443	2015-12-13 09:53:08.977443	107203
44177	Violet Proto-Drake	t	t	t	t	2015-12-13 09:53:08.980133	2015-12-13 09:53:08.980133	60024
89390	White Riding Goat	f	t	t	t	2015-12-13 09:53:08.982645	2015-12-13 09:53:08.982645	130137
31836	White Riding Talbuk	f	t	t	t	2015-12-13 09:53:08.985296	2015-12-13 09:53:08.985296	39319
29231	White War Talbuk	f	t	t	t	2015-12-13 09:53:08.988459	2015-12-13 09:53:08.988459	34897
69846	Winged Guardian	t	t	t	t	2015-12-13 09:53:08.991257	2015-12-13 09:53:08.991257	98727
44230	Wooly Mammoth	f	t	t	t	2015-12-13 09:53:08.994385	2015-12-13 09:53:08.994385	59791
87795	Black Dragon Turtle	f	t	t	t	2015-12-13 09:53:08.997389	2015-12-13 09:53:08.997389	127286
2411	Black Stallion	f	t	t	t	2015-12-13 09:53:09.007969	2015-12-13 09:53:09.007969	470
87796	Blue Dragon Turtle	f	t	t	t	2015-12-13 09:53:09.011574	2015-12-13 09:53:09.011574	127287
8595	Blue Mechanostrider	f	t	t	t	2015-12-13 09:53:09.014534	2015-12-13 09:53:09.014534	10969
21218	Blue Qiraji Battle Tank	f	t	t	t	2015-12-13 09:53:09.019425	2015-12-13 09:53:09.019425	25953
87797	Brown Dragon Turtle	f	t	t	t	2015-12-13 09:53:09.022345	2015-12-13 09:53:09.022345	127288
28481	Brown Elekk	f	t	t	t	2015-12-13 09:53:09.027458	2015-12-13 09:53:09.027458	34406
5872	Brown Ram	f	t	t	t	2015-12-13 09:53:09.030303	2015-12-13 09:53:09.030303	6899
5655	Chestnut Mare	f	t	t	t	2015-12-13 09:53:09.033463	2015-12-13 09:53:09.033463	6648
25471	Ebon Gryphon	t	t	t	t	2015-12-13 09:53:09.036964	2015-12-13 09:53:09.036964	32239
25470	Golden Gryphon	t	t	t	t	2015-12-13 09:53:09.039784	2015-12-13 09:53:09.039784	32235
29744	Gray Elekk	f	t	t	t	2015-12-13 09:53:09.042483	2015-12-13 09:53:09.042483	35710
5864	Gray Ram	f	t	t	t	2015-12-13 09:53:09.045506	2015-12-13 09:53:09.045506	6777
82765	Green Dragon Turtle	f	t	t	t	2015-12-13 09:53:09.048612	2015-12-13 09:53:09.048612	120395
13321	Green Mechanostrider	f	t	t	t	2015-12-13 09:53:09.052284	2015-12-13 09:53:09.052284	17453
21323	Green Qiraji Battle Tank	f	t	t	t	2015-12-13 09:53:09.055004	2015-12-13 09:53:09.055004	26056
73838	Mountain Horse	f	t	t	t	2015-12-13 09:53:09.057571	2015-12-13 09:53:09.057571	103195
2414	Pinto	f	t	t	t	2015-12-13 09:53:09.060387	2015-12-13 09:53:09.060387	472
87799	Purple Dragon Turtle	f	t	t	t	2015-12-13 09:53:09.063391	2015-12-13 09:53:09.063391	127289
29743	Purple Elekk	f	t	t	t	2015-12-13 09:53:09.066422	2015-12-13 09:53:09.066422	35711
87800	Red Dragon Turtle	f	t	t	t	2015-12-13 09:53:09.069055	2015-12-13 09:53:09.069055	127290
89363	Red Flying Cloud	t	t	f	t	2015-12-13 09:53:09.072186	2015-12-13 09:53:09.072186	130092
8563	Red Mechanostrider	f	t	t	t	2015-12-13 09:53:09.07505	2015-12-13 09:53:09.07505	10873
25472	Snowy Gryphon	t	t	t	t	2015-12-13 09:53:09.078125	2015-12-13 09:53:09.078125	32240
8632	Spotted Frostsaber	f	t	t	t	2015-12-13 09:53:09.082363	2015-12-13 09:53:09.082363	10789
47100	Striped Dawnsaber	f	t	t	t	2015-12-13 09:53:09.085445	2015-12-13 09:53:09.085445	66847
8631	Striped Frostsaber	f	t	t	t	2015-12-13 09:53:09.08846	2015-12-13 09:53:09.08846	8394
8629	Striped Nightsaber	f	t	t	t	2015-12-13 09:53:09.091862	2015-12-13 09:53:09.091862	10793
13322	Unpainted Mechanostrider	f	t	t	t	2015-12-13 09:53:09.09601	2015-12-13 09:53:09.09601	17454
54465	Vashj'ir Seahorse	f	f	t	f	2015-12-13 09:53:09.099546	2015-12-13 09:53:09.099546	75207
5873	White Ram	f	t	t	t	2015-12-13 09:53:09.102551	2015-12-13 09:53:09.102551	6898
21324	Yellow Qiraji Battle Tank	f	t	t	t	2015-12-13 09:53:09.105351	2015-12-13 09:53:09.105351	26055
54797	Frosty Flying Carpet	t	t	t	t	2015-12-13 09:53:18.745178	2015-12-13 09:53:18.745178	75596
34060	Flying Machine	t	t	t	t	2015-12-13 09:53:18.75979	2015-12-13 09:53:18.75979	44153
46109	Sea Turtle	f	t	t	t	2015-12-13 09:53:18.764912	2015-12-13 09:53:18.764912	64731
47179	Argent Charger	f	t	t	t	2015-12-13 09:53:28.493293	2015-12-13 09:53:28.493293	66906
45725	Argent Hippogryph	t	t	t	t	2015-12-13 09:53:28.497161	2015-12-13 09:53:28.497161	63844
43952	Azure Drake	t	t	t	t	2015-12-13 09:53:28.499715	2015-12-13 09:53:28.499715	59567
32858	Azure Netherwing Drake	t	t	t	t	2015-12-13 09:53:28.502529	2015-12-13 09:53:28.502529	41514
81354	Azure Water Strider	f	t	t	t	2015-12-13 09:53:28.510418	2015-12-13 09:53:28.510418	118089
29467	Black War Ram	f	t	t	t	2015-12-13 09:53:28.515442	2015-12-13 09:53:28.515442	22720
29471	Black War Tiger	f	t	t	t	2015-12-13 09:53:28.518006	2015-12-13 09:53:28.518006	22723
33999	Cenarion War Hippogryph	t	t	t	t	2015-12-13 09:53:28.522203	2015-12-13 09:53:28.522203	43927
63125	Dark Phoenix	t	t	t	t	2015-12-13 09:53:28.526787	2015-12-13 09:53:28.526787	88990
109013	Dread Raven	t	t	t	t	2015-12-13 09:53:28.529581	2015-12-13 09:53:28.529581	155741
71665	Flametalon of Alysrazor	f	t	t	t	2015-12-13 09:53:28.532262	2015-12-13 09:53:28.532262	101542
116794	Garn Nighthowl	f	t	t	t	2015-12-13 09:53:28.535027	2015-12-13 09:53:28.535027	171851
93168	Grand Armored Gryphon	t	t	t	t	2015-12-13 09:53:28.539082	2015-12-13 09:53:28.539082	135416
93385	Grand Gryphon	t	t	t	t	2015-12-13 09:53:28.542243	2015-12-13 09:53:28.542243	136163
82453	Jeweled Onyx Panther	t	t	t	t	2015-12-13 09:53:28.551908	2015-12-13 09:53:28.551908	120043
0	Charger	f	t	t	t	2015-12-13 09:53:28.593179	2015-12-13 09:53:28.593179	23214
69747	Amani Battle Bear	f	t	t	t	2015-12-13 09:53:54.086883	2015-12-13 09:53:54.086883	98204
29465	Black Battlestrider	f	t	t	t	2015-12-13 09:53:54.090073	2015-12-13 09:53:54.090073	22719
35906	Black War Elekk	f	t	t	t	2015-12-13 09:53:54.093498	2015-12-13 09:53:54.093498	48027
116659	Bloodhoof Bull	f	t	t	t	2015-12-13 09:53:54.096786	2015-12-13 09:53:54.096786	171620
128311	Coalfist Gronnling	f	t	t	t	2015-12-13 09:53:54.100566	2015-12-13 09:53:54.100566	189364
115363	Creeping Carpet	f	t	t	t	2015-12-13 09:53:54.104378	2015-12-13 09:53:54.104378	169952
28915	Dark Riding Talbuk	f	t	t	t	2015-12-13 09:53:54.106672	2015-12-13 09:53:54.106672	39316
29228	Dark War Talbuk	f	t	t	t	2015-12-13 09:53:54.109145	2015-12-13 09:53:54.109145	34790
44558	Magnificent Flying Carpet	t	t	t	t	2015-12-13 09:53:54.119479	2015-12-13 09:53:54.119479	61309
116661	Mottled Meadowstomper	f	t	t	t	2015-12-13 09:53:54.12193	2015-12-13 09:53:54.12193	171622
94291	Red Primal Raptor	f	t	t	t	2015-12-13 09:53:54.124346	2015-12-13 09:53:54.124346	138641
116767	Sapphire Riverbeast	f	t	t	t	2015-12-13 09:53:54.127218	2015-12-13 09:53:54.127218	171824
95416	Sky Golem	t	t	t	t	2015-12-13 09:53:54.130594	2015-12-13 09:53:54.130594	134359
128706	Soaring Skyterror	t	t	t	t	2015-12-13 09:53:54.133526	2015-12-13 09:53:54.133526	191633
128526	Deathtusk Felboar	f	t	t	t	2015-12-13 09:53:54.150428	2015-12-13 09:53:54.150428	190977
116769	Mudback Riverbeast	f	t	t	t	2015-12-13 09:53:54.156535	2015-12-13 09:53:54.156535	171826
21321	Red Qiraji Battle Tank	f	t	t	t	2015-12-13 09:53:54.163225	2015-12-13 09:53:54.163225	26054
116656	Trained Icehoof	f	t	t	t	2015-12-13 09:53:54.168908	2015-12-13 09:53:54.168908	171617
116662	Trained Meadowstomper	f	t	t	t	2015-12-13 09:53:54.171699	2015-12-13 09:53:54.171699	171623
116676	Trained Riverwallow	f	t	t	t	2015-12-13 09:53:54.174235	2015-12-13 09:53:54.174235	171638
116675	Trained Rocktusk	f	t	t	t	2015-12-13 09:53:54.176665	2015-12-13 09:53:54.176665	171637
116774	Trained Silverpelt	f	t	t	t	2015-12-13 09:53:54.179049	2015-12-13 09:53:54.179049	171831
116784	Trained Snarler	f	t	t	t	2015-12-13 09:53:54.181402	2015-12-13 09:53:54.181402	171841
116658	Tundra Icehoof	f	t	t	t	2015-12-13 09:53:54.183588	2015-12-13 09:53:54.183588	171619
32458	Ashes of Al'ar	t	t	t	t	2015-12-13 09:55:12.653091	2015-12-13 09:55:12.653091	40192
123974	Corrupted Dreadwing	t	t	t	t	2015-12-13 09:55:12.659773	2015-12-13 09:55:12.659773	183117
128422	Grove Warden	t	t	t	t	2015-12-13 09:55:12.663281	2015-12-13 09:55:12.663281	189999
128425	Illidari Felstalker	f	t	t	t	2015-12-13 09:55:12.667103	2015-12-13 09:55:12.667103	189998
127140	Infernal Direwolf	f	t	t	t	2015-12-13 09:55:12.671229	2015-12-13 09:55:12.671229	186305
50818	Invincible	t	t	t	t	2015-12-13 09:55:12.674206	2015-12-13 09:55:12.674206	72286
104246	Kor'kron War Wolf	f	t	t	t	2015-12-13 09:55:12.676864	2015-12-13 09:55:12.676864	148396
116792	Sunhide Gronnling	f	t	t	t	2015-12-13 09:55:12.682	2015-12-13 09:55:12.682	171849
104269	Thundering Onyx Cloud Serpent	t	t	t	t	2015-12-13 09:55:12.686019	2015-12-13 09:55:12.686019	148476
40775	Winged Steed of the Ebon Blade	t	t	t	t	2015-12-13 09:55:12.689374	2015-12-13 09:55:12.689374	54729
116791	Challenger's War Yeti	f	t	t	t	2015-12-13 09:55:12.692061	2015-12-13 09:55:12.692061	171848
116667	Rocktusk Battleboar	f	t	t	t	2015-12-13 09:55:12.695786	2015-12-13 09:55:12.695786	171628
116671	Wild Goretusk	f	t	t	t	2015-12-13 09:55:12.698497	2015-12-13 09:55:12.698497	171633
116655	Witherhide Cliffstomper	f	t	t	t	2015-12-13 09:55:12.70165	2015-12-13 09:55:12.70165	171616
68823	Armored Razzashi Raptor	f	t	t	t	2015-12-13 09:55:33.665595	2015-12-13 09:55:33.665595	96491
77067	Blazing Drake	t	t	t	t	2015-12-13 09:55:33.676588	2015-12-13 09:55:33.676588	107842
69230	Corrupted Fire Hawk	t	t	t	t	2015-12-13 09:55:33.686738	2015-12-13 09:55:33.686738	97560
62901	Drake of the East Wind	t	t	t	t	2015-12-13 09:55:33.692724	2015-12-13 09:55:33.692724	88335
63039	Drake of the West Wind	t	t	t	t	2015-12-13 09:55:33.696	2015-12-13 09:55:33.696	88741
30480	Fiery Warhorse	f	t	t	t	2015-12-13 09:55:33.698867	2015-12-13 09:55:33.698867	36702
69213	Flameward Hippogryph	t	t	t	t	2015-12-13 09:55:33.702127	2015-12-13 09:55:33.702127	97359
60954	Fossilized Raptor	f	t	t	t	2015-12-13 09:55:33.705203	2015-12-13 09:55:33.705203	84751
43959	Grand Black War Mammoth	f	t	t	t	2015-12-13 09:55:33.709819	2015-12-13 09:55:33.709819	61465
43961	Grand Ice Mammoth	f	t	t	t	2015-12-13 09:55:33.712632	2015-12-13 09:55:33.712632	61470
91802	Jade Pandaren Kite	t	t	t	t	2015-12-13 09:55:33.725748	2015-12-13 09:55:33.725748	133023
77069	Life-Binder's Handmaiden	t	t	t	t	2015-12-13 09:55:33.729179	2015-12-13 09:55:33.729179	107845
69224	Pureblood Fire Hawk	t	t	t	t	2015-12-13 09:55:33.733447	2015-12-13 09:55:33.733447	97493
64998	Spectral Steed	f	t	t	t	2015-12-13 09:55:33.744364	2015-12-13 09:55:33.744364	92231
49044	Swift Alliance Steed	f	t	t	t	2015-12-13 09:55:33.747838	2015-12-13 09:55:33.747838	68057
68824	Swift Zulian Panther	f	t	t	t	2015-12-13 09:55:33.796306	2015-12-13 09:55:33.796306	96499
34061	Turbo-Charged Flying Machine	t	t	t	t	2015-12-13 09:55:33.805255	2015-12-13 09:55:33.805255	44151
77068	Twilight Harbinger	t	t	t	t	2015-12-13 09:55:33.812093	2015-12-13 09:55:33.812093	107844
62900	Volcanic Stone Drake	t	t	t	t	2015-12-13 09:55:33.818171	2015-12-13 09:55:33.818171	88331
13086	Winterspring Frostsaber	f	t	t	t	2015-12-13 09:55:33.827763	2015-12-13 09:55:33.827763	17229
44554	Flying Carpet	t	t	t	t	2015-12-13 09:55:33.837872	2015-12-13 09:55:33.837872	61451
93662	Armored Skyscreamer	t	t	t	t	2015-12-13 09:55:48.673526	2015-12-13 09:55:48.673526	136400
90710	Ashen Pandaren Phoenix	t	t	t	t	2015-12-13 09:55:48.6766	2015-12-13 09:55:48.6766	132117
89307	Blue Shado-Pan Riding Tiger	f	t	t	t	2015-12-13 09:55:48.686964	2015-12-13 09:55:48.686964	129934
98405	Brawler's Burly Mushan Beast	f	t	t	t	2015-12-13 09:55:48.689673	2015-12-13 09:55:48.689673	142641
118515	Cindermane Charger	t	t	t	t	2015-12-13 09:55:48.695687	2015-12-13 09:55:48.695687	171847
87769	Crimson Cloud Serpent	t	t	t	t	2015-12-13 09:55:48.700348	2015-12-13 09:55:48.700348	127156
89154	Crimson Pandaren Phoenix	t	t	t	t	2015-12-13 09:55:48.703608	2015-12-13 09:55:48.703608	129552
108883	Dustmane Direwolf	f	t	t	t	2015-12-13 09:55:48.708098	2015-12-13 09:55:48.708098	171844
106246	Emerald Hippogryph	t	t	t	t	2015-12-13 09:55:48.710901	2015-12-13 09:55:48.710901	149801
90711	Emerald Pandaren Phoenix	t	t	t	t	2015-12-13 09:55:48.71343	2015-12-13 09:55:48.71343	132118
95564	Golden Primal Direhorn	f	t	t	t	2015-12-13 09:55:48.717397	2015-12-13 09:55:48.717397	140249
116383	Gorestrider Gronnling	f	t	t	t	2015-12-13 09:55:48.721037	2015-12-13 09:55:48.721037	171436
84101	Grand Expedition Yak	f	t	t	t	2015-12-13 09:55:48.724491	2015-12-13 09:55:48.724491	122708
94293	Green Primal Raptor	f	t	t	t	2015-12-13 09:55:48.730538	2015-12-13 09:55:48.730538	138643
89305	Green Shado-Pan Riding Tiger	f	t	t	t	2015-12-13 09:55:48.740777	2015-12-13 09:55:48.740777	129932
78924	Heart of the Aspects	t	t	t	t	2015-12-13 09:55:48.746958	2015-12-13 09:55:48.746958	110051
87773	Heavenly Crimson Cloud Serpent	t	t	t	t	2015-12-13 09:55:48.75047	2015-12-13 09:55:48.75047	127161
116660	Ironhoof Destroyer	f	t	t	t	2015-12-13 09:55:48.753609	2015-12-13 09:55:48.753609	171621
94231	Jade Primordial Direhorn	f	t	t	t	2015-12-13 09:55:48.756247	2015-12-13 09:55:48.756247	138426
104253	Kor'kron Juggernaut	f	t	t	t	2015-12-13 09:55:48.759034	2015-12-13 09:55:48.759034	148417
49290	Magic Rooster	f	t	t	t	2015-12-13 09:55:48.763182	2015-12-13 09:55:48.763182	65917
83086	Obsidian Nightwing	t	t	t	t	2015-12-13 09:55:48.7659	2015-12-13 09:55:48.7659	121820
87768	Onyx Cloud Serpent	t	t	t	t	2015-12-13 09:55:48.768541	2015-12-13 09:55:48.768541	127154
89306	Red Shado-Pan Riding Tiger	f	t	t	t	2015-12-13 09:55:48.773088	2015-12-13 09:55:48.773088	129935
104208	Spawn of Galakras	t	t	t	t	2015-12-13 09:55:48.778872	2015-12-13 09:55:48.778872	148392
85666	Thundering Jade Cloud Serpent	t	t	t	t	2015-12-13 09:55:48.790914	2015-12-13 09:55:48.790914	124408
90712	Violet Pandaren Phoenix	t	t	t	t	2015-12-13 09:55:48.800304	2015-12-13 09:55:48.800304	132119
54860	X-53 Touring Rocket	t	t	t	t	2015-12-13 09:55:48.803659	2015-12-13 09:55:48.803659	75973
116669	Armored Razorback	f	t	t	t	2015-12-13 09:55:48.806822	2015-12-13 09:55:48.806822	171630
116666	Blacksteel Battleboar	f	t	t	t	2015-12-13 09:55:48.810315	2015-12-13 09:55:48.810315	171627
87251	Geosynchronous World Spinner	t	t	t	t	2015-12-13 09:55:48.818337	2015-12-13 09:55:48.818337	126508
116663	Shadowhide Pearltusk	f	t	t	t	2015-12-13 09:55:48.824578	2015-12-13 09:55:48.824578	171624
33809	Amani War Bear	f	t	t	t	2015-12-13 10:05:06.964853	2015-12-13 10:05:06.964853	43688
95341	Armored Bloodwing	t	t	t	t	2015-12-13 10:05:06.967965	2015-12-13 10:05:06.967965	139595
44164	Black Proto-Drake	t	t	t	t	2015-12-13 10:05:06.971564	2015-12-13 10:05:06.971564	59976
43516	Brutal Nether Drake	t	t	t	t	2015-12-13 10:05:06.976326	2015-12-13 10:05:06.976326	58615
49096	Crusader's White Warhorse	f	t	t	t	2015-12-13 10:05:06.979534	2015-12-13 10:05:06.979534	68187
85870	Imperial Quilen	t	t	t	t	2015-12-13 10:05:06.984778	2015-12-13 10:05:06.984778	124659
45693	Mimiron's Head	t	t	t	t	2015-12-13 10:05:06.988971	2015-12-13 10:05:06.988971	63796
44175	Plagued Proto-Drake	t	t	t	t	2015-12-13 10:05:06.992081	2015-12-13 10:05:06.992081	60021
19902	Swift Zulian Tiger	f	t	t	t	2015-12-13 10:05:07.004569	2015-12-13 10:05:07.004569	24252
\.


--
-- Name: mounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wow_db
--

SELECT pg_catalog.setval('mounts_id_seq', 1, false);


--
-- Data for Name: neckpieces; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY neckpieces (id, name, icon, quality, "itemLevel", armor, context, created_at, updated_at) FROM stdin;
113923	Fiery Links of Courage	inv_6_0raid_necklace_3a	4	691	0	raid-heroic	2015-12-13 09:53:09.138909	2015-12-13 09:53:09.138909
113890	Feldspar's Control Choker	inv_6_0raid_necklace_2b	4	706	0	raid-mythic	2015-12-13 09:53:18.777782	2015-12-13 09:53:18.777782
113598	Champion's Medallion	inv_6_0raid_necklace_4a	4	670	0	raid-heroic	2015-12-13 09:53:42.8147	2015-12-13 09:53:42.8147
109955	Demonbinder Cabochon	inv_60dungeon_neck2a	4	705	0	dungeon-mythic	2015-12-13 09:53:54.190342	2015-12-13 09:53:54.190342
124216	Bolt-Latched Felsteel Gorget	inv_6_2raid_necklace_1a	4	730	0	raid-mythic	2015-12-13 09:55:12.711752	2015-12-13 09:55:12.711752
124212	Vial of Immiscible Liquid	inv_6_2raid_necklace_3d	4	700	0	raid-normal	2015-12-13 09:55:33.867147	2015-12-13 09:55:33.867147
124608	Vexed Pendant of the Strategist	inv_misc_necklace_6_0_005	3	650	0	dungeon-heroic	2015-12-13 09:55:48.835775	2015-12-13 09:55:48.835775
124610	Vexed Chain of the Harmonious	inv_misc_necklace_6_0_012	4	675	0		2015-12-13 10:05:07.048434	2015-12-13 10:05:07.048434
\.


--
-- Name: neckpieces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wow_db
--

SELECT pg_catalog.setval('neckpieces_id_seq', 1, false);


--
-- Data for Name: offhands; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY offhands (id, name, quality, "itemLevel", armor, context, created_at, updated_at, dps) FROM stdin;
113666	Absalom's Bloody Bulwark	4	685	783	raid-mythic	2015-12-13 09:53:09.180358	2015-12-13 09:53:09.180358	0
113879	Caged Living Ooze	4	685	0	raid-heroic	2015-12-13 09:53:18.787627	2015-12-13 09:53:18.787627	0
113653	Maw of Souls	4	670	771	raid-heroic	2015-12-13 09:53:42.827187	2015-12-13 09:53:42.827187	0
129846	Mazthoril Honor Shield	3	675	775	timewalker	2015-12-13 09:55:33.87777	2015-12-13 09:55:33.87777	0
19019	Thunderfury, Blessed Blade of the Windseeker	5	80	0		2015-12-13 10:05:07.086119	2015-12-13 10:05:07.086119	8.39473699999999923
\.


--
-- Name: offhands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wow_db
--

SELECT pg_catalog.setval('offhands_id_seq', 1, false);


--
-- Data for Name: rings; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY rings (id, name, icon, quality, "itemLevel", armor, context, created_at, updated_at) FROM stdin;
113922	Seal of Unquenchable Flame	inv_ringwod_d5_1	4	706	0	raid-mythic	2015-12-13 09:53:09.128716	2015-12-13 09:53:09.128716
124192	Loathful Encrusted Band	inv_6_2raid_ring_4d	4	700	0	raid-normal	2015-12-13 09:53:18.773592	2015-12-13 09:53:18.773592
113963	Siege Bomber's Band	inv_ringwod_d4_1	4	700	0	raid-mythic	2015-12-13 09:53:28.597405	2015-12-13 09:53:28.597405
118304	Spellbound Solium Band of the Immortal Spirit	inv_misc_6oring_greenlv3	4	690	0	quest-reward	2015-12-13 09:53:42.80257	2015-12-13 09:53:42.80257
124634	Thorasus, the Stone Heart of Draenor	inv_60legendary_ring1c	5	795	0	quest-reward	2015-12-13 09:55:12.708513	2015-12-13 09:55:12.708513
118306	Spellbound Runic Band of the All-Seeing Eye	inv_misc_6oring_purplelv4	4	715	0	quest-reward	2015-12-13 09:55:33.86393	2015-12-13 09:55:33.86393
95138	Signet of the Shado-Pan Assault	inv_jewelry_ring_167	4	522	0		2015-12-13 09:55:48.833112	2015-12-13 09:55:48.833112
128117	Stone Runeband	inv_misc_60raid_ring_2c	4	685	0	raid-finder	2015-12-13 10:05:07.037598	2015-12-13 10:05:07.037598
\.


--
-- Name: rings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wow_db
--

SELECT pg_catalog.setval('rings_id_seq', 1, false);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY schema_migrations (version) FROM stdin;
20151213081005
20151129223009
20151129223517
20151129225737
20151129225911
20151129230440
20151129231630
20151129235706
20151130002222
20151201022145
20151206234654
20151206235226
20151207030304
20151207030810
20151207031808
20151207031926
20151207032857
20151207033015
20151207034047
20151207034100
20151207034604
20151207044941
20151207045650
20151207050002
20151207051043
20151207053249
20151207064342
20151213071118
20151213071209
20151213071405
20151213071449
20151213072101
20151213072303
20151213072456
20151213072853
20151213072945
20151213073129
20151213073153
20151213073409
20151213073427
20151213080025
20151213091651
20151213092459
\.


--
-- Data for Name: stats; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY stats (id, health, "powerType", power, str, agi, "int", sta, crit, haste, mastery, "bonusArmor", "spellPower", armor, parry, block, "attackPower", "mainHandDps", "rangedAttackPower", created_at, updated_at, character_id) FROM stdin;
1	377880	rage	120	4349	889	711	6298	11.3909090000000006	9.82222699999999982	45.1636349999999993	1115	711	4099	22.8836419999999983	27.2547989999999984	7109	2951.44950000000017	0	2015-12-13 09:53:09.156893	2015-12-13 09:53:09.798649	1
2	343920	mana	160000	909	1129	4895	5732	17.5909079999999989	15.5222320000000007	21.1490919999999996	0	6912	917	0	0	0	288.519900000000007	0	2015-12-13 09:53:18.780937	2015-12-13 09:53:18.802981	2
3	480180	mana	32000	4404	455	1042	8003	13.4090919999999993	15.8444369999999992	15.9090910000000001	879	1042	3888	25.8747830000000008	39.0381399999999985	6123	2598.20649999999978	0	2015-12-13 09:53:28.600761	2015-12-13 09:53:28.681976	3
4	277560	mana	160000	692	1346	3986	4626	9.03636400000000073	15.7449949999999994	67.6363699999999994	0	5455	2112	0	3	1346	660.478939999999966	0	2015-12-13 09:53:42.818398	2015-12-13 09:53:42.838902	4
5	333300	mana	160000	647	889	4774	5555	8.98181800000000052	12.2888950000000001	66.7912749999999988	0	6789	867	0	0	0	363.117279999999994	0	2015-12-13 09:53:54.192386	2015-12-13 09:53:54.269079	5
6	569640	runic-power	100	7254	1067	568	9494	26.7636360000000018	14.7183150000000005	57.1363640000000004	0	568	3368	33.0427099999999996	0	7254	3493.81320000000005	0	2015-12-13 09:55:12.71502	2015-12-13 09:55:12.778182	6
7	298740	mana	160000	692	1346	4613	4979	11.7818170000000002	22.068321000000001	97.0508999999999986	0	6363	2157	0	3	1346	740.895260000000007	0	2015-12-13 09:55:33.86973	2015-12-13 09:55:34.044899	7
8	193920	mana	160000	843	1067	3265	3232	9.29091000000000022	11.5216600000000007	38.3522760000000034	0	4135	517	0	0	0	157.974199999999996	0	2015-12-13 09:55:48.838262	2015-12-13 09:55:48.9773	8
9	145320	rage	100	2394	887	710	2422	8.61818199999999912	0	12.5618169999999996	0	710	348	13.5709230000000005	3	2406	1279.67789999999991	12	2015-12-13 10:05:07.063459	2015-12-13 10:05:07.177505	9
\.


--
-- Name: stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wow_db
--

SELECT pg_catalog.setval('stats_id_seq', 9, true);


--
-- Data for Name: tabards; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY tabards (id, name, quality, "itemLevel", context, armor, created_at, updated_at) FROM stdin;
5976	Guild Tabard	1	1	vendor	0	2015-12-13 09:53:09.191942	2015-12-13 09:53:09.191942
52252	Tabard of the Lightbringer	4	80	quest-reward	0	2015-12-13 09:53:28.605856	2015-12-13 09:53:28.605856
35279	Tabard of Summer Skies	3	1		0	2015-12-13 09:53:42.831273	2015-12-13 09:53:42.831273
\.


--
-- Name: tabards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wow_db
--

SELECT pg_catalog.setval('tabards_id_seq', 1, false);


--
-- Data for Name: titles; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY titles (id, name, created_at, updated_at) FROM stdin;
81	%s the Seeker	2015-12-13 09:53:08.522457	2015-12-13 09:53:08.522457
74	Elder %s	2015-12-13 09:53:08.525456	2015-12-13 09:53:08.525456
75	Flame Warden %s	2015-12-13 09:53:08.527838	2015-12-13 09:53:08.527838
78	%s the Explorer	2015-12-13 09:53:08.532492	2015-12-13 09:53:08.532492
113	%s of Gnomeregan	2015-12-13 09:53:08.535665	2015-12-13 09:53:08.535665
121	Twilight Vanquisher %s	2015-12-13 09:53:08.538129	2015-12-13 09:53:08.538129
124	%s the Hallowed	2015-12-13 09:53:08.543573	2015-12-13 09:53:08.543573
129	%s, Champion of the Frozen Wastes	2015-12-13 09:53:08.547176	2015-12-13 09:53:08.547176
130	Ambassador %s	2015-12-13 09:53:08.549437	2015-12-13 09:53:08.549437
133	Brewmaster %s	2015-12-13 09:53:08.551699	2015-12-13 09:53:08.551699
134	Merrymaker %s	2015-12-13 09:53:08.554132	2015-12-13 09:53:08.554132
135	%s the Love Fool	2015-12-13 09:53:08.556485	2015-12-13 09:53:08.556485
137	Matron %s	2015-12-13 09:53:08.558968	2015-12-13 09:53:08.558968
140	%s of the Nightfall	2015-12-13 09:53:08.561434	2015-12-13 09:53:08.561434
143	%s Jenkins	2015-12-13 09:53:08.563598	2015-12-13 09:53:08.563598
146	%s of the Exodar	2015-12-13 09:53:08.566123	2015-12-13 09:53:08.566123
147	%s of Darnassus	2015-12-13 09:53:08.568393	2015-12-13 09:53:08.568393
148	%s of Ironforge	2015-12-13 09:53:08.570713	2015-12-13 09:53:08.570713
149	%s of Stormwind	2015-12-13 09:53:08.573037	2015-12-13 09:53:08.573037
155	%s the Noble	2015-12-13 09:53:08.575671	2015-12-13 09:53:08.575671
156	Crusader %s	2015-12-13 09:53:08.57876	2015-12-13 09:53:08.57876
164	Starcaller %s	2015-12-13 09:53:08.582072	2015-12-13 09:53:08.582072
165	%s the Astral Walker	2015-12-13 09:53:08.591512	2015-12-13 09:53:08.591512
168	%s the Pilgrim	2015-12-13 09:53:08.594757	2015-12-13 09:53:08.594757
172	%s the Patient	2015-12-13 09:53:08.601429	2015-12-13 09:53:08.601429
173	%s the Light of Dawn	2015-12-13 09:53:08.604076	2015-12-13 09:53:08.604076
175	%s the Kingslayer	2015-12-13 09:53:08.606822	2015-12-13 09:53:08.606822
176	%s of the Ashen Verdict	2015-12-13 09:53:08.609536	2015-12-13 09:53:08.609536
189	Assistant Professor %s	2015-12-13 09:53:08.612281	2015-12-13 09:53:08.612281
190	Associate Professor %s	2015-12-13 09:53:08.614558	2015-12-13 09:53:08.614558
227	%s, Defender of a Shattered World	2015-12-13 09:53:08.617114	2015-12-13 09:53:08.617114
228	Dragonslayer %s	2015-12-13 09:53:08.619746	2015-12-13 09:53:08.619746
229	%s, Blackwing's Bane	2015-12-13 09:53:08.6224	2015-12-13 09:53:08.6224
285	%s, Savior of Azeroth	2015-12-13 09:53:08.624965	2015-12-13 09:53:08.624965
303	Farmer %s	2015-12-13 09:53:08.627564	2015-12-13 09:53:08.627564
287	%s, Destroyer's End	2015-12-13 09:53:08.630257	2015-12-13 09:53:08.630257
316	%s the Tranquil Master	2015-12-13 09:53:08.633111	2015-12-13 09:53:08.633111
382	%s, Conqueror of Orgrimmar	2015-12-13 09:53:08.635604	2015-12-13 09:53:08.635604
338	%s the Wakener	2015-12-13 09:53:08.638114	2015-12-13 09:53:08.638114
351	%s the Hordebreaker	2015-12-13 09:53:08.640309	2015-12-13 09:53:08.640309
438	%s the Savage Hero	2015-12-13 09:53:08.642339	2015-12-13 09:53:08.642339
63	%s of the Shattered Sun	2015-12-13 09:53:28.467705	2015-12-13 09:53:28.467705
64	%s, Hand of A'dal	2015-12-13 09:53:28.471328	2015-12-13 09:53:28.471328
77	%s the Exalted	2015-12-13 09:53:28.475137	2015-12-13 09:53:28.475137
131	%s the Argent Champion	2015-12-13 09:53:28.479645	2015-12-13 09:53:28.479645
278	Firelord %s	2015-12-13 09:53:28.487491	2015-12-13 09:53:28.487491
3	Sergeant %s	2015-12-13 09:53:54.064444	2015-12-13 09:53:54.064444
320	Tamer %s	2015-12-13 09:53:54.079441	2015-12-13 09:53:54.079441
415	Talon King %s	2015-12-13 09:53:54.082041	2015-12-13 09:53:54.082041
226	%s of the Four Winds	2015-12-13 09:55:12.643535	2015-12-13 09:55:12.643535
342	%s, Storm's End	2015-12-13 09:55:12.649324	2015-12-13 09:55:12.649324
79	%s the Diplomat	2015-12-13 09:55:33.599619	2015-12-13 09:55:33.599619
84	Chef %s	2015-12-13 09:55:33.60313	2015-12-13 09:55:33.60313
126	%s of the Alliance	2015-12-13 09:55:33.607954	2015-12-13 09:55:33.607954
132	%s, Guardian of Cenarius	2015-12-13 09:55:33.611658	2015-12-13 09:55:33.611658
141	%s the Immortal	2015-12-13 09:55:33.616218	2015-12-13 09:55:33.616218
142	%s the Undying	2015-12-13 09:55:33.619454	2015-12-13 09:55:33.619454
166	%s, Herald of the Titans	2015-12-13 09:55:33.626483	2015-12-13 09:55:33.626483
174	%s, Bane of the Fallen King	2015-12-13 09:55:33.630226	2015-12-13 09:55:33.630226
191	Professor %s	2015-12-13 09:55:33.634059	2015-12-13 09:55:33.634059
195	Private %s	2015-12-13 09:55:33.63648	2015-12-13 09:55:33.63648
196	Corporal %s	2015-12-13 09:55:33.638832	2015-12-13 09:55:33.638832
198	Master Sergeant %s	2015-12-13 09:55:33.643116	2015-12-13 09:55:33.643116
199	Sergeant Major %s	2015-12-13 09:55:33.645414	2015-12-13 09:55:33.645414
267	%s, Avenger of Hyjal	2015-12-13 09:55:33.649095	2015-12-13 09:55:33.649095
276	%s the Flamebreaker	2015-12-13 09:55:33.651938	2015-12-13 09:55:33.651938
315	%s, Master of the Ways	2015-12-13 09:55:33.657675	2015-12-13 09:55:33.657675
333	Brawler %s	2015-12-13 09:55:33.660707	2015-12-13 09:55:33.660707
314	%s the Undaunted	2015-12-13 09:55:48.659159	2015-12-13 09:55:48.659159
317	%s, Delver of the Vaults	2015-12-13 09:55:48.661806	2015-12-13 09:55:48.661806
384	%s, Hellscream's Downfall	2015-12-13 09:55:48.664467	2015-12-13 09:55:48.664467
387	%s the Proven Healer	2015-12-13 09:55:48.66689	2015-12-13 09:55:48.66689
53	%s, Champion of the Naaru	2015-12-13 10:05:06.91047	2015-12-13 10:05:06.91047
120	%s the Magic Seeker	2015-12-13 10:05:06.917395	2015-12-13 10:05:06.917395
122	%s, Conqueror of Naxxramas	2015-12-13 10:05:06.920605	2015-12-13 10:05:06.920605
139	Obsidian Slayer %s	2015-12-13 10:05:06.9264	2015-12-13 10:05:06.9264
158	%s, Death's Demise	2015-12-13 10:05:06.933075	2015-12-13 10:05:06.933075
159	%s the Celestial Defender	2015-12-13 10:05:06.9352	2015-12-13 10:05:06.9352
160	%s, Conqueror of Ulduar	2015-12-13 10:05:06.937365	2015-12-13 10:05:06.937365
161	%s, Champion of Ulduar	2015-12-13 10:05:06.939538	2015-12-13 10:05:06.939538
170	Grand Crusader %s	2015-12-13 10:05:06.943708	2015-12-13 10:05:06.943708
386	%s the Proven Defender	2015-12-13 10:05:06.951522	2015-12-13 10:05:06.951522
\.


--
-- Name: titles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wow_db
--

SELECT pg_catalog.setval('titles_id_seq', 1, false);


--
-- Data for Name: trinkets; Type: TABLE DATA; Schema: public; Owner: wow_db
--

COPY trinkets (id, name, quality, "itemLevel", armor, context, icon, created_at, updated_at) FROM stdin;
113893	Blast Furnace Door	4	685	0	raid-heroic	inv_misc_trinket6oih_ironskull1	2015-12-13 09:53:09.118122	2015-12-13 09:53:09.118122
113986	Auto-Repairing Autoclave	4	700	0	raid-mythic	inv_misc_trinket6oih_orb3	2015-12-13 09:53:18.769301	2015-12-13 09:53:18.769301
124228	Desecrated Shadowmoon Insignia	4	705	0	raid-heroic	achievement_dungeon_shadowmoonhideout	2015-12-13 09:53:54.187586	2015-12-13 09:53:54.187586
124236	Unending Hunger	4	741	0	raid-mythic	spell_deathknight_gnaw_ghoul	2015-12-13 09:55:12.705438	2015-12-13 09:55:12.705438
113859	Quiescent Runestone	4	655	0	raid-normal	inv_misc_trinket6oog_talisman2	2015-12-13 09:55:33.860803	2015-12-13 09:55:33.860803
133596	Orb of Voidsight	7	715	0		inv_icon_shadowcouncilorb_purple	2015-12-13 09:55:48.830109	2015-12-13 09:55:48.830109
127401	Tormented Skull	4	660	0		spell_shadow_skull	2015-12-13 10:05:07.026789	2015-12-13 10:05:07.026789
\.


--
-- Name: trinkets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wow_db
--

SELECT pg_catalog.setval('trinkets_id_seq', 1, false);


--
-- Name: armors_pkey; Type: CONSTRAINT; Schema: public; Owner: wow_db; Tablespace: 
--

ALTER TABLE ONLY armors
    ADD CONSTRAINT armors_pkey PRIMARY KEY (id);


--
-- Name: characters_pkey; Type: CONSTRAINT; Schema: public; Owner: wow_db; Tablespace: 
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (id);


--
-- Name: guilds_pkey; Type: CONSTRAINT; Schema: public; Owner: wow_db; Tablespace: 
--

ALTER TABLE ONLY guilds
    ADD CONSTRAINT guilds_pkey PRIMARY KEY (id);


--
-- Name: mainhands_pkey; Type: CONSTRAINT; Schema: public; Owner: wow_db; Tablespace: 
--

ALTER TABLE ONLY mainhands
    ADD CONSTRAINT mainhands_pkey PRIMARY KEY (id);


--
-- Name: mounts_pkey; Type: CONSTRAINT; Schema: public; Owner: wow_db; Tablespace: 
--

ALTER TABLE ONLY mounts
    ADD CONSTRAINT mounts_pkey PRIMARY KEY (id);


--
-- Name: neckpieces_pkey; Type: CONSTRAINT; Schema: public; Owner: wow_db; Tablespace: 
--

ALTER TABLE ONLY neckpieces
    ADD CONSTRAINT neckpieces_pkey PRIMARY KEY (id);


--
-- Name: offhands_pkey; Type: CONSTRAINT; Schema: public; Owner: wow_db; Tablespace: 
--

ALTER TABLE ONLY offhands
    ADD CONSTRAINT offhands_pkey PRIMARY KEY (id);


--
-- Name: rings_pkey; Type: CONSTRAINT; Schema: public; Owner: wow_db; Tablespace: 
--

ALTER TABLE ONLY rings
    ADD CONSTRAINT rings_pkey PRIMARY KEY (id);


--
-- Name: stats_pkey; Type: CONSTRAINT; Schema: public; Owner: wow_db; Tablespace: 
--

ALTER TABLE ONLY stats
    ADD CONSTRAINT stats_pkey PRIMARY KEY (id);


--
-- Name: tabards_pkey; Type: CONSTRAINT; Schema: public; Owner: wow_db; Tablespace: 
--

ALTER TABLE ONLY tabards
    ADD CONSTRAINT tabards_pkey PRIMARY KEY (id);


--
-- Name: titles_pkey; Type: CONSTRAINT; Schema: public; Owner: wow_db; Tablespace: 
--

ALTER TABLE ONLY titles
    ADD CONSTRAINT titles_pkey PRIMARY KEY (id);


--
-- Name: trinkets_pkey; Type: CONSTRAINT; Schema: public; Owner: wow_db; Tablespace: 
--

ALTER TABLE ONLY trinkets
    ADD CONSTRAINT trinkets_pkey PRIMARY KEY (id);


--
-- Name: index_characters_mounts_on_character_id_and_mount_id; Type: INDEX; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE INDEX index_characters_mounts_on_character_id_and_mount_id ON characters_mounts USING btree (character_id, mount_id);


--
-- Name: index_characters_mounts_on_mount_id_and_character_id; Type: INDEX; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE INDEX index_characters_mounts_on_mount_id_and_character_id ON characters_mounts USING btree (mount_id, character_id);


--
-- Name: index_characters_titles_on_character_id_and_title_id; Type: INDEX; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE INDEX index_characters_titles_on_character_id_and_title_id ON characters_titles USING btree (character_id, title_id);


--
-- Name: index_characters_titles_on_title_id_and_character_id; Type: INDEX; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE INDEX index_characters_titles_on_title_id_and_character_id ON characters_titles USING btree (title_id, character_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: wow_db; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: update_character; Type: TRIGGER; Schema: public; Owner: wow_db
--

CREATE TRIGGER update_character BEFORE UPDATE ON characters FOR EACH ROW EXECUTE PROCEDURE updatedcharacter();


--
-- Name: update_guild; Type: TRIGGER; Schema: public; Owner: wow_db
--

CREATE TRIGGER update_guild BEFORE UPDATE ON guilds FOR EACH ROW EXECUTE PROCEDURE updatedguild();


--
-- Name: update_stats; Type: TRIGGER; Schema: public; Owner: wow_db
--

CREATE TRIGGER update_stats BEFORE UPDATE ON stats FOR EACH ROW EXECUTE PROCEDURE updatedstats();


--
-- Name: fk_rails_0075dc6eec; Type: FK CONSTRAINT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT fk_rails_0075dc6eec FOREIGN KEY (title_id) REFERENCES titles(id);


--
-- Name: fk_rails_25eaebba10; Type: FK CONSTRAINT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT fk_rails_25eaebba10 FOREIGN KEY (mount_id) REFERENCES mounts(id);


--
-- Name: fk_rails_41915b30a4; Type: FK CONSTRAINT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY stats
    ADD CONSTRAINT fk_rails_41915b30a4 FOREIGN KEY (character_id) REFERENCES characters(id);


--
-- Name: fk_rails_687bc5ed46; Type: FK CONSTRAINT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT fk_rails_687bc5ed46 FOREIGN KEY (guild_id) REFERENCES guilds(id);


--
-- Name: fk_rails_77bca82e4c; Type: FK CONSTRAINT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT fk_rails_77bca82e4c FOREIGN KEY (ring_id) REFERENCES rings(id);


--
-- Name: fk_rails_7fdaff3f8c; Type: FK CONSTRAINT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT fk_rails_7fdaff3f8c FOREIGN KEY (tabard_id) REFERENCES tabards(id);


--
-- Name: fk_rails_862e0c9998; Type: FK CONSTRAINT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT fk_rails_862e0c9998 FOREIGN KEY (mainhand_id) REFERENCES mainhands(id);


--
-- Name: fk_rails_901f597dba; Type: FK CONSTRAINT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT fk_rails_901f597dba FOREIGN KEY (trinket_id) REFERENCES trinkets(id);


--
-- Name: fk_rails_969880a114; Type: FK CONSTRAINT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT fk_rails_969880a114 FOREIGN KEY (armor_id) REFERENCES armors(id);


--
-- Name: fk_rails_af7e67cb06; Type: FK CONSTRAINT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT fk_rails_af7e67cb06 FOREIGN KEY (offhand_id) REFERENCES offhands(id);


--
-- Name: fk_rails_d50a1f4d21; Type: FK CONSTRAINT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT fk_rails_d50a1f4d21 FOREIGN KEY (neckpiece_id) REFERENCES neckpieces(id);


--
-- Name: fk_rails_fefc172ea6; Type: FK CONSTRAINT; Schema: public; Owner: wow_db
--

ALTER TABLE ONLY characters
    ADD CONSTRAINT fk_rails_fefc172ea6 FOREIGN KEY (stat_id) REFERENCES stats(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: matthewmorales
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM matthewmorales;
GRANT ALL ON SCHEMA public TO matthewmorales;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

