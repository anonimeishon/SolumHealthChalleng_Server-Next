--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 17.4

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
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: EvaluationType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."EvaluationType" AS ENUM (
    'HUMAN',
    'LLM'
);


ALTER TYPE public."EvaluationType" OWNER TO postgres;

--
-- Name: SentimentValue; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."SentimentValue" AS ENUM (
    'very_positive',
    'positive',
    'neutral',
    'negative',
    'very_negative'
);


ALTER TYPE public."SentimentValue" OWNER TO postgres;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: Agent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Agent" (
    id integer NOT NULL,
    external_id text NOT NULL,
    "companyId" integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Agent" OWNER TO postgres;

--
-- Name: Agent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Agent_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Agent_id_seq" OWNER TO postgres;

--
-- Name: Agent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Agent_id_seq" OWNED BY public."Agent".id;


--
-- Name: Call; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Call" (
    id integer NOT NULL,
    external_id text NOT NULL,
    "companyId" integer NOT NULL,
    transcript text,
    "agentId" integer NOT NULL,
    "startDate" timestamp(3) without time zone NOT NULL,
    "endDate" timestamp(3) without time zone NOT NULL,
    duration_seconds integer NOT NULL,
    recording_url text NOT NULL,
    customer_identifier text,
    call_type text,
    call_status text,
    reason_for_call text,
    department text,
    service_provided text,
    ended_reason text,
    customer_name text,
    dob text,
    insurance text
);


ALTER TABLE public."Call" OWNER TO postgres;

--
-- Name: Call_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Call_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Call_id_seq" OWNER TO postgres;

--
-- Name: Call_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Call_id_seq" OWNED BY public."Call".id;


--
-- Name: Company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Company" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Company" OWNER TO postgres;

--
-- Name: Company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Company_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Company_id_seq" OWNER TO postgres;

--
-- Name: Company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Company_id_seq" OWNED BY public."Company".id;


--
-- Name: HumanEvaluation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."HumanEvaluation" (
    id integer NOT NULL,
    "callId" integer NOT NULL,
    "evaluatorId" integer NOT NULL,
    "timestamp" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    overall_score double precision,
    politeness_score integer,
    resolution_status boolean,
    accuracy_rating text,
    clarity_score integer,
    empathy_score integer,
    adherence_to_script boolean,
    problem_solved boolean,
    overall_comment text,
    status text
);


ALTER TABLE public."HumanEvaluation" OWNER TO postgres;

--
-- Name: HumanEvaluation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."HumanEvaluation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."HumanEvaluation_id_seq" OWNER TO postgres;

--
-- Name: HumanEvaluation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."HumanEvaluation_id_seq" OWNED BY public."HumanEvaluation".id;


--
-- Name: LlmEvaluation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LlmEvaluation" (
    id integer NOT NULL,
    "callId" integer NOT NULL,
    "timestamp" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    overall_score double precision,
    politeness_score integer,
    resolution_status boolean,
    accuracy_rating text,
    clarity_score integer,
    empathy_score integer,
    problem_solved boolean,
    llm_summary text,
    llm_sentiment text,
    call_type text,
    call_type_confidence double precision,
    call_type_reasoning text,
    feedback text,
    outcome_confidence double precision,
    outcome_reasoning text,
    protocol_confidence double precision,
    protocol_reasoning text,
    sentiment_confidence double precision,
    sentiment_reasoning text,
    vapi_score double precision,
    adherence_to_script double precision
);


ALTER TABLE public."LlmEvaluation" OWNER TO postgres;

--
-- Name: LlmEvaluation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."LlmEvaluation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."LlmEvaluation_id_seq" OWNER TO postgres;

--
-- Name: LlmEvaluation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."LlmEvaluation_id_seq" OWNED BY public."LlmEvaluation".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    role text NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: Agent id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agent" ALTER COLUMN id SET DEFAULT nextval('public."Agent_id_seq"'::regclass);


--
-- Name: Call id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call" ALTER COLUMN id SET DEFAULT nextval('public."Call_id_seq"'::regclass);


--
-- Name: Company id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Company" ALTER COLUMN id SET DEFAULT nextval('public."Company_id_seq"'::regclass);


--
-- Name: HumanEvaluation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HumanEvaluation" ALTER COLUMN id SET DEFAULT nextval('public."HumanEvaluation_id_seq"'::regclass);


--
-- Name: LlmEvaluation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LlmEvaluation" ALTER COLUMN id SET DEFAULT nextval('public."LlmEvaluation_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	9d1ca40b-9c9c-468a-a835-507047b2b4fd	{"action":"user_confirmation_requested","actor_id":"65386eae-b1c7-498f-9edb-d4a27c45a8e8","actor_username":"sebastianmperea@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-23 06:17:42.171487+00	
00000000-0000-0000-0000-000000000000	d560dd88-01e4-420f-aea5-fac7377f1592	{"action":"user_signedup","actor_id":"65386eae-b1c7-498f-9edb-d4a27c45a8e8","actor_username":"sebastianmperea@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-05-23 06:18:11.446822+00	
00000000-0000-0000-0000-000000000000	2786fa2b-e3c0-449f-98d9-aa8c8bc519a5	{"action":"login","actor_id":"65386eae-b1c7-498f-9edb-d4a27c45a8e8","actor_username":"sebastianmperea@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider_type":"email"}}	2025-05-23 06:18:11.928294+00	
00000000-0000-0000-0000-000000000000	c26c9558-00c8-44cd-9a85-587842974b9a	{"action":"token_refreshed","actor_id":"65386eae-b1c7-498f-9edb-d4a27c45a8e8","actor_username":"sebastianmperea@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-23 14:44:05.737019+00	
00000000-0000-0000-0000-000000000000	6a3fd185-d1f4-4318-b5ca-2e0fe4566c84	{"action":"token_revoked","actor_id":"65386eae-b1c7-498f-9edb-d4a27c45a8e8","actor_username":"sebastianmperea@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-23 14:44:05.74036+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
65386eae-b1c7-498f-9edb-d4a27c45a8e8	65386eae-b1c7-498f-9edb-d4a27c45a8e8	{"sub": "65386eae-b1c7-498f-9edb-d4a27c45a8e8", "email": "sebastianmperea@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-05-23 06:17:42.165223+00	2025-05-23 06:17:42.165278+00	2025-05-23 06:17:42.165278+00	fc551963-9a97-46a1-94e4-430660d5a78e
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
24f6d423-59f0-4ee5-a93f-02091936a6a9	2025-05-23 06:18:11.943292+00	2025-05-23 06:18:11.943292+00	email/signup	3b37fcfb-122d-44e8-86b9-05a73755fd5f
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	1	2mgrioz26kf3	65386eae-b1c7-498f-9edb-d4a27c45a8e8	t	2025-05-23 06:18:11.931599+00	2025-05-23 14:44:05.740934+00	\N	24f6d423-59f0-4ee5-a93f-02091936a6a9
00000000-0000-0000-0000-000000000000	2	mfkvhozz2ajn	65386eae-b1c7-498f-9edb-d4a27c45a8e8	f	2025-05-23 14:44:05.743466+00	2025-05-23 14:44:05.743466+00	2mgrioz26kf3	24f6d423-59f0-4ee5-a93f-02091936a6a9
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
24f6d423-59f0-4ee5-a93f-02091936a6a9	65386eae-b1c7-498f-9edb-d4a27c45a8e8	2025-05-23 06:18:11.928949+00	2025-05-23 14:44:05.748839+00	\N	aal1	\N	2025-05-23 14:44:05.748752	Next.js Middleware	186.170.52.153	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	65386eae-b1c7-498f-9edb-d4a27c45a8e8	authenticated	authenticated	sebastianmperea@gmail.com	$2a$10$vQc/sOGuRWtfMjs6hmCXX.LihkwDD3rLb0KLrCH4a7wwQQnOemqM2	2025-05-23 06:18:11.448557+00	\N		2025-05-23 06:17:42.183692+00		\N			\N	2025-05-23 06:18:11.928867+00	{"provider": "email", "providers": ["email"]}	{"sub": "65386eae-b1c7-498f-9edb-d4a27c45a8e8", "email": "sebastianmperea@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-05-23 06:17:42.139133+00	2025-05-23 14:44:05.745998+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: Agent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Agent" (id, external_id, "companyId", name) FROM stdin;
13	653fe3ea-5c24-439a-9a4b-0b17d78e3577	11	653fe3ea-5c24-439a-9a4b-0b17d78e3577
14	Golden Gate Hands Therapy	12	Golden Gate Hands Therapy
15	d403f6ab-9f5d-4a40-81c1-c2877b216d7c	13	d403f6ab-9f5d-4a40-81c1-c2877b216d7c
\.


--
-- Data for Name: Call; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Call" (id, external_id, "companyId", transcript, "agentId", "startDate", "endDate", duration_seconds, recording_url, customer_identifier, call_type, call_status, reason_for_call, department, service_provided, ended_reason, customer_name, dob, insurance) FROM stdin;
828	b3b71c74-e2ec-4d34-8ae0-e49e13502a53	11	\N	13	2025-01-21 20:13:54.549	2025-01-21 20:13:58.269	3	https://storage.vapi.ai/b3b71c74-e2ec-4d34-8ae0-e49e13502a53-1737490440774-65fdee3e-528f-4960-8829-befae25eac18-mono.wav	14155393048	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
829	a3bccb57-964d-43f9-9c6c-2696a8d28aa2	11	\N	13	2025-01-21 23:52:00.636	2025-01-21 23:52:54.928	54	https://storage.vapi.ai/a3bccb57-964d-43f9-9c6c-2696a8d28aa2-1737503577435-cd707f1f-42e9-4f26-b845-3161c6cee2d2-mono.wav	15717818166	\N	\N	\N	\N	\N	assistant-ended-call	\N	\N	\N
830	d4b3d343-556a-406c-9437-7952b2296899	11	\N	13	2025-01-22 14:38:58.92	2025-01-22 14:39:21.865	22	https://storage.vapi.ai/d4b3d343-556a-406c-9437-7952b2296899-1737556764374-a3a21a9a-82cc-4d30-8c14-0407c3936af0-mono.wav	15713287585	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
831	ee758d7a-495c-4b5f-b110-3df98fcf320e	11	\N	13	2025-01-22 16:12:34.846	2025-01-22 16:13:17.696	42	https://storage.vapi.ai/ee758d7a-495c-4b5f-b110-3df98fcf320e-1737562400200-ae9635ea-a68b-471e-8e5d-cec2a1f42370-mono.wav	19176268612	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
832	134281b2-1b84-4efb-94ca-a37c528b5c7c	11	\N	13	2025-01-22 20:49:40.154	2025-01-22 20:49:47.728	7	https://storage.vapi.ai/134281b2-1b84-4efb-94ca-a37c528b5c7c-1737578990232-07fae7ec-876d-405b-b83f-4696a3e54429-mono.wav	18047438403	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
833	01041491-93aa-49db-a2f7-9447937283f8	11	\N	13	2025-01-22 21:05:45.6	2025-01-22 21:06:02.274	16	https://storage.vapi.ai/01041491-93aa-49db-a2f7-9447937283f8-1737579964780-d7b09d5f-f7ce-4c56-8f40-0c87df38994f-mono.wav	17722180490	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
834	39286c42-0f21-4fb6-8ecd-4a15b0ebcc2b	11	\N	13	2025-01-23 13:10:31.95	2025-01-23 13:11:10.959	39	https://storage.vapi.ai/39286c42-0f21-4fb6-8ecd-4a15b0ebcc2b-1737637873465-30322a97-e1d4-462b-a2ec-6d5362da5581-mono.wav	13018071851	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
835	51166dfe-91e6-487b-87d5-6dc9aa1e144b	11	\N	13	2025-01-23 14:53:17.535	2025-01-23 14:53:40.687	23	https://storage.vapi.ai/51166dfe-91e6-487b-87d5-6dc9aa1e144b-1737644023192-7c2a2d94-c263-49f7-9bc4-c94bf6685995-mono.wav	17722180490	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
836	e3bdb8c8-2e15-4348-ab0c-91edf357e055	11	\N	13	2025-01-23 16:28:23.819	2025-01-23 16:28:58.262	34	https://storage.vapi.ai/e3bdb8c8-2e15-4348-ab0c-91edf357e055-1737649740766-97920528-dc15-441b-806b-c4aa89963b87-mono.wav	13212136650	\N	\N	\N	\N	\N	silence-timed-out	\N	\N	\N
837	359d7910-8e51-479b-a8e5-225f7bb4f2d1	11	\N	13	2025-01-23 17:56:43.508	2025-01-23 17:57:01.573	18	https://storage.vapi.ai/359d7910-8e51-479b-a8e5-225f7bb4f2d1-1737655024077-e110cdec-992f-4a25-a9f6-42bd797807af-mono.wav	13018071851	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
838	5db5684d-0355-496a-9057-176b91988756	11	\N	13	2025-01-23 21:06:19.182	2025-01-23 21:07:00.712	41	https://storage.vapi.ai/5db5684d-0355-496a-9057-176b91988756-1737666423220-1084ce65-f8c0-45ac-b95a-09b0a23ab6a7-mono.wav	19565171998	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
839	9f821eec-8077-4ffa-b22e-71f3991254d2	11	\N	13	2025-01-23 21:46:08.282	2025-01-23 21:46:58.427	50	https://storage.vapi.ai/9f821eec-8077-4ffa-b22e-71f3991254d2-1737668820931-0f99a722-c022-4d27-afa1-a467f38107ac-mono.wav	15717752952	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
840	6f381c33-6140-4191-857b-897a70cfd9ba	11	\N	13	2025-01-24 00:19:04.484	2025-01-24 00:19:30.618	26	https://storage.vapi.ai/6f381c33-6140-4191-857b-897a70cfd9ba-1737677973125-0fd0e471-5f05-4bf1-bb78-6104f04e3b26-mono.wav	15108284000	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
841	7b5341f7-f39a-4240-ab79-482e623cb66d	11	\N	13	2025-01-24 00:23:22.84	2025-01-24 00:23:43.031	20	https://storage.vapi.ai/7b5341f7-f39a-4240-ab79-482e623cb66d-1737678225539-458b0419-d962-4ff0-9418-86dee9eb0ca5-mono.wav	15108284000	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
842	ff2d7006-add9-4039-ba30-14970b7d3817	11	\N	13	2025-01-24 14:20:24.297	2025-01-24 14:20:56.585	32	https://storage.vapi.ai/ff2d7006-add9-4039-ba30-14970b7d3817-1737728459091-927ca271-20ce-4ff1-b232-2be8e1269602-mono.wav	16466428353	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
843	72753bc2-2b3d-427f-a29b-391b868eab29	11	\N	13	2025-01-24 15:15:54.542	2025-01-24 15:16:27.774	33	https://storage.vapi.ai/72753bc2-2b3d-427f-a29b-391b868eab29-1737731790281-84e8c751-09ea-4038-883d-e483898245bd-mono.wav	17209861217	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
844	9cedab41-0ec8-463f-837d-ac091aad7b6e	11	\N	13	2025-01-24 15:49:37.889	2025-01-24 15:50:06.57	28	https://storage.vapi.ai/9cedab41-0ec8-463f-837d-ac091aad7b6e-1737733809076-424c0770-3843-4538-a7aa-e4b6b362b0aa-mono.wav	17039342400	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
845	741e08c5-2616-4496-9687-49c3d22a847c	11	\N	13	2025-01-24 17:04:20.923	2025-01-24 17:04:46.474	25	https://storage.vapi.ai/741e08c5-2616-4496-9687-49c3d22a847c-1737738288983-527bacd9-5e5c-4658-9285-12a906ec7014-mono.wav	16462168533	\N	\N	\N	\N	\N	assistant-ended-call	\N	\N	\N
846	af1ed7a1-febf-4c62-b700-a639431ed242	11	\N	13	2025-01-24 20:27:20.904	2025-01-24 20:27:49.856	28	https://storage.vapi.ai/af1ed7a1-febf-4c62-b700-a639431ed242-1737750472361-f4e52363-79a5-4849-9adb-74a9abb35a70-mono.wav	17209861217	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
847	89f2fcf1-57ab-415f-abad-5fe5548bb602	11	\N	13	2025-01-24 20:44:51.095	2025-01-24 20:46:28.285	97	https://storage.vapi.ai/89f2fcf1-57ab-415f-abad-5fe5548bb602-1737751590792-de813882-bf4a-4ce3-ad27-33d19f30393b-mono.wav	15408789948	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
848	07c92473-2988-4df5-a269-be204e4a60fd	11	\N	13	2025-01-24 21:03:13.766	2025-01-24 21:06:13.382	179	https://storage.vapi.ai/07c92473-2988-4df5-a269-be204e4a60fd-1737752775897-f0109215-9c74-4342-a9f1-9cefe79fa30b-mono.wav	17034031541	\N	\N	\N	\N	\N	assistant-ended-call	\N	\N	\N
849	17a67647-d616-42da-97cb-5497f5c4d52d	11	\N	13	2025-01-24 22:07:45.271	2025-01-24 22:08:06.611	21	https://storage.vapi.ai/17a67647-d616-42da-97cb-5497f5c4d52d-1737756489117-a19bfeb2-b303-4c3b-8985-53bb4e934d38-mono.wav	17033363606	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
850	74bf5f09-a5c0-4140-979d-4143a3da7621	11	\N	13	2025-01-24 22:50:58.546	2025-01-24 22:51:03.312	4	https://storage.vapi.ai/74bf5f09-a5c0-4140-979d-4143a3da7621-1737759065815-371579bd-f639-4235-80a5-a851b64162ef-mono.wav	17076017088	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
851	18843a14-cfd5-4634-9121-e13b4cb20aac	11	\N	13	2025-01-27 13:55:41.976	2025-01-27 13:56:01.644	19	https://storage.vapi.ai/18843a14-cfd5-4634-9121-e13b4cb20aac-1737986164148-30c79640-239b-4370-bbc9-ab5aaf3516d5-mono.wav	14103680085	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
852	4cf713d4-4ea7-407f-b6f1-136a2f2440f3	11	\N	13	2025-01-27 14:32:57.071	2025-01-27 14:33:43.318	46	https://storage.vapi.ai/4cf713d4-4ea7-407f-b6f1-136a2f2440f3-1737988425823-6bf252b9-25e7-479d-84a8-4af5e86b3863-mono.wav	15737460592	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
853	6317bc44-78ff-47b5-9de1-687f5530356e	11	\N	13	2025-01-27 16:12:31.745	2025-01-27 16:14:04.85	93	https://storage.vapi.ai/6317bc44-78ff-47b5-9de1-687f5530356e-1737994447355-dbc0f463-e567-4d46-be94-54e5518a7e40-mono.wav	15714603764	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
854	5676cc8c-8745-434a-8eb0-a17620b4e184	11	\N	13	2025-01-27 17:06:58.485	2025-01-27 17:10:53.826	235	https://storage.vapi.ai/5676cc8c-8745-434a-8eb0-a17620b4e184-1737997856338-8c7763cb-54e7-4233-b4e1-d7558fd0c9d6-mono.wav	17035054220	\N	\N	\N	\N	\N	assistant-ended-call	\N	\N	\N
855	0f77c066-27a0-434e-9dd3-a10b4c08f723	11	\N	13	2025-01-27 19:52:29.066	2025-01-27 19:53:21.212	52	https://storage.vapi.ai/0f77c066-27a0-434e-9dd3-a10b4c08f723-1738007603722-c69f55f9-b62a-4c9c-90e2-876a2c540cf4-mono.wav	15713963523	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
856	c989cc82-faae-4479-b2a8-658aa4d3ca63	11	\N	13	2025-01-27 23:29:02.22	2025-01-27 23:29:16.903	14	https://storage.vapi.ai/c989cc82-faae-4479-b2a8-658aa4d3ca63-1738020559407-5e19e451-5150-49ee-8d93-f27376fec8ef-mono.wav	15619446905	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
857	1460dd06-6886-4a3f-8b46-b6ee2dd59604	11	\N	13	2025-01-28 16:18:18.942	2025-01-28 16:19:07.961	49	https://storage.vapi.ai/1460dd06-6886-4a3f-8b46-b6ee2dd59604-1738081150466-4d5e616a-bbb1-46ab-a618-a4fae4c34353-mono.wav	17209861217	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
858	47c84c17-af68-443b-9df7-33cc8c1cfe69	11	\N	13	2025-01-28 17:00:54.554	2025-01-28 17:01:11.947	17	https://storage.vapi.ai/47c84c17-af68-443b-9df7-33cc8c1cfe69-1738083674452-eb6dee98-7c4a-43a0-90ec-5c6c20cc8fc7-mono.wav	14103680085	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
859	f832fbdd-9151-41d5-9937-de1c79b89a35	11	\N	13	2025-01-28 17:51:05.816	2025-01-28 17:51:22.028	16	https://storage.vapi.ai/f832fbdd-9151-41d5-9937-de1c79b89a35-1738086684533-46b12d98-37ed-4d6b-a395-df5d932ca0a4-mono.wav	15677575941	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
860	d61ccd2f-a8fd-4c7e-8927-30459f99c771	11	\N	13	2025-01-28 18:17:47.804	2025-01-28 18:21:00.056	192	https://storage.vapi.ai/d61ccd2f-a8fd-4c7e-8927-30459f99c771-1738088462562-b9c85db7-8fa3-4e6d-97e0-8963e475e6d2-mono.wav	17032203340	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
861	d1fdc0fe-c547-47cd-af0e-d7ac677d1bbd	11	\N	13	2025-01-28 19:19:36.552	2025-01-28 19:20:21.143	44	https://storage.vapi.ai/d1fdc0fe-c547-47cd-af0e-d7ac677d1bbd-1738092023652-bfaafe01-e159-41ba-9a01-51b6b07aea58-mono.wav	17209861217	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
862	36a4400b-c652-4ddf-b7fb-16145d0b0312	11	\N	13	2025-01-29 00:09:54.75	2025-01-29 00:10:28.808	34	https://storage.vapi.ai/36a4400b-c652-4ddf-b7fb-16145d0b0312-1738109431312-c3ec776e-504f-43bb-82b5-43325c52240d-mono.wav	15717818188	\N	\N	\N	\N	\N	silence-timed-out	\N	\N	\N
863	38139b75-156f-417e-a677-0961fe373f63	11	\N	13	2025-01-29 18:45:44.327	2025-01-29 18:46:17.732	33	https://storage.vapi.ai/38139b75-156f-417e-a677-0961fe373f63-1738176380236-3b792ec8-906d-491d-9a62-59b56a04b224-mono.wav	15023189986	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
864	e02ff58c-56ae-4d6a-bb3d-01bc3f3f5087	11	\N	13	2025-01-29 22:53:16.153	2025-01-29 22:53:50.234	34	https://storage.vapi.ai/e02ff58c-56ae-4d6a-bb3d-01bc3f3f5087-1738191232739-3e95ac49-b385-41b4-9f08-544cae2b9450-mono.wav	18666223696	\N	\N	\N	\N	\N	silence-timed-out	\N	\N	\N
865	1345f621-bb88-4218-812b-343c59ec494a	11	\N	13	2025-01-29 22:58:59.192	2025-01-29 22:59:33.249	34	https://storage.vapi.ai/1345f621-bb88-4218-812b-343c59ec494a-1738191575752-678db807-49b1-4569-92f6-94497708a0f5-mono.wav	18666223696	\N	\N	\N	\N	\N	silence-timed-out	\N	\N	\N
866	0849f755-2b0d-4b80-ac1e-4e5623deb874	11	\N	13	2025-01-29 23:04:42.905	2025-01-29 23:05:17.038	34	https://storage.vapi.ai/0849f755-2b0d-4b80-ac1e-4e5623deb874-1738191919542-85a9807e-348d-44e5-adc4-cd3bdf42221f-mono.wav	18666223696	\N	\N	\N	\N	\N	silence-timed-out	\N	\N	\N
867	14f4cae9-14af-4985-9b85-71967e4545f3	11	\N	13	2025-01-29 23:10:27.504	2025-01-29 23:11:01.61	34	https://storage.vapi.ai/14f4cae9-14af-4985-9b85-71967e4545f3-1738192264113-aea6666c-64ac-46b5-8e28-c7a1f5c7c273-mono.wav	18666223696	\N	\N	\N	\N	\N	silence-timed-out	\N	\N	\N
868	ffadfaea-99df-4961-9cdb-64264ac8bc40	11	\N	13	2025-01-29 23:16:09.358	2025-01-29 23:16:43.424	34	https://storage.vapi.ai/ffadfaea-99df-4961-9cdb-64264ac8bc40-1738192605929-910f8dcd-4e5c-4f05-910f-d767791dacf1-mono.wav	18666223696	\N	\N	\N	\N	\N	silence-timed-out	\N	\N	\N
869	4dd63ce0-856d-4cc0-806f-314d58ff20c2	11	\N	13	2025-01-30 01:37:10.979	2025-01-30 01:37:22.989	12	https://storage.vapi.ai/4dd63ce0-856d-4cc0-806f-314d58ff20c2-1738201045500-ad2b1480-826b-4704-a647-5c56475528b6-mono.wav	17036560023	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
870	903dd484-96f9-415c-b835-30d6a6b55dfa	11	\N	13	2025-01-30 13:35:34.472	2025-01-30 13:36:01.969	27	https://storage.vapi.ai/903dd484-96f9-415c-b835-30d6a6b55dfa-1738244164475-86dad47a-b2ac-4405-aaba-347edef877d1-mono.wav	12403745445	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
871	c097830f-8522-4235-8e5a-c58021c7fb6f	11	\N	13	2025-01-30 14:10:32.712	2025-01-30 14:11:56.553	83	https://storage.vapi.ai/c097830f-8522-4235-8e5a-c58021c7fb6f-1738246319059-7a8203ed-eb32-41c9-8659-3eafe19fea80-mono.wav	15713075225	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
872	df053447-18c5-4e57-be98-14f838bf34b6	11	\N	13	2025-01-30 19:43:03.943	2025-01-30 19:43:13.119	9	https://storage.vapi.ai/df053447-18c5-4e57-be98-14f838bf34b6-1738266195622-cbd4f151-b3ba-4091-8c8c-888109897f1c-mono.wav	16462168533	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
873	7d6d8b0e-1d50-4813-8b80-e4e418405e8e	11	\N	13	2025-01-31 15:21:09.012	2025-01-31 15:21:12.476	3	https://storage.vapi.ai/7d6d8b0e-1d50-4813-8b80-e4e418405e8e-1738336874980-06c41c02-2c46-4444-87c8-8188831ef65a-mono.wav	19547434255	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
874	0a43f9ab-19c6-446f-aa41-7837b468f915	11	\N	13	2025-01-31 16:44:26.264	2025-01-31 16:45:00.396	34	https://storage.vapi.ai/0a43f9ab-19c6-446f-aa41-7837b468f915-1738341902900-4c0c93a9-8e96-421c-b52d-dcaa9e8fc4cc-mono.wav	13212136650	\N	\N	\N	\N	\N	silence-timed-out	\N	\N	\N
875	b31b17fa-6ca4-43a9-addf-60342607175a	11	\N	13	2025-01-31 17:30:12.353	2025-01-31 17:30:46.488	34	https://storage.vapi.ai/b31b17fa-6ca4-43a9-addf-60342607175a-1738344648992-edb2053c-a5e2-4429-b59e-ca11d3b29a1f-mono.wav	14096999919	\N	\N	\N	\N	\N	silence-timed-out	\N	\N	\N
876	65eef440-51fe-4e83-a538-3b5de9272430	11	\N	13	2025-01-31 18:59:38.974	2025-01-31 18:59:46.474	7	https://storage.vapi.ai/65eef440-51fe-4e83-a538-3b5de9272430-1738349988984-2ca75585-6782-4b31-b197-05de6ddc6e13-mono.wav	19546710231	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
877	33ea3fdf-aa16-4223-8dcb-92886d9bd430	11	\N	13	2025-01-31 18:58:57.113	2025-01-31 19:00:29.498	92	https://storage.vapi.ai/33ea3fdf-aa16-4223-8dcb-92886d9bd430-1738350032006-f1c54076-ddd8-446f-a448-21ee5dab9c7a-mono.wav	15402227819	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
878	ab9107df-32dc-4d87-9130-e55cfd056222	11	\N	13	2025-01-31 19:08:15.062	2025-01-31 19:09:11.73	56	https://storage.vapi.ai/ab9107df-32dc-4d87-9130-e55cfd056222-1738350554238-7ba14e14-eab0-4779-903f-9c00672b4145-mono.wav	15404223259	\N	\N	\N	\N	\N	silence-timed-out	\N	\N	\N
879	bf25a70f-82ce-4587-8d10-d7e9ac8eef96	11	\N	13	2025-01-31 20:29:21.914	2025-01-31 20:30:15.246	53	https://storage.vapi.ai/bf25a70f-82ce-4587-8d10-d7e9ac8eef96-1738355417757-48865c51-1c8b-4804-9fac-c8a996bc00c6-mono.wav	16462168533	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
880	a9b3bc0b-5d68-44d9-815b-56f650282607	11	\N	13	2025-01-31 23:04:36.614	2025-01-31 23:04:45.307	8	https://storage.vapi.ai/a9b3bc0b-5d68-44d9-815b-56f650282607-1738364687811-77e55d88-e24a-47be-a71f-c2826c61afca-mono.wav	16606333632	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
881	baaec537-cc1c-4715-9fd5-472ad7b33b2e	11	\N	13	2025-02-02 13:32:35.523	2025-02-02 13:32:46.308	10	https://storage.vapi.ai/baaec537-cc1c-4715-9fd5-472ad7b33b2e-1738503168811-28a9277f-040d-4f1f-bca9-76b82d68dc08-mono.wav	16462168533	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
882	0a8f3f8e-99a9-4a6e-a4fd-e6d23f7955b3	11	\N	13	2025-02-03 13:46:13.686	2025-02-03 13:46:36.444	22	https://storage.vapi.ai/0a8f3f8e-99a9-4a6e-a4fd-e6d23f7955b3-1738590398949-7e697196-4c15-465a-9f99-329a520b3dbd-mono.wav	15713510310	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
883	92548d80-6814-4fd6-ad2b-34eeb68279b2	11	\N	13	2025-02-03 14:03:49.533	2025-02-03 14:04:16.72	27	https://storage.vapi.ai/92548d80-6814-4fd6-ad2b-34eeb68279b2-1738591459226-dd969f31-3e53-425f-ada6-80423b047992-mono.wav	12156170325	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
884	bb643cf8-f639-40ce-bb61-dc07a8200406	11	\N	13	2025-02-03 14:17:35.785	2025-02-03 14:17:56.116	20	https://storage.vapi.ai/bb643cf8-f639-40ce-bb61-dc07a8200406-1738592278628-a1205028-86ed-4cc3-8949-22477f6d3870-mono.wav	17033570569	\N	\N	\N	\N	\N	pipeline-error-eleven-labs-500-server-error	\N	\N	\N
885	67627c1d-1db7-4dc9-b091-25beacae2fa4	11	\N	13	2025-02-03 16:07:18.498	2025-02-03 16:08:13.759	55	https://storage.vapi.ai/67627c1d-1db7-4dc9-b091-25beacae2fa4-1738598896262-0be82822-e290-43b3-be7d-7e8092b0064d-mono.wav	19547434255	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
886	2d3bf53b-d977-40af-a1f1-73dd117a2eac	11	\N	13	2025-02-03 18:40:29.437	2025-02-03 18:40:50.89	21	https://storage.vapi.ai/2d3bf53b-d977-40af-a1f1-73dd117a2eac-1738608053395-5cafe2b2-3c51-4353-9e9a-fddf9113e65a-mono.wav	16462168533	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
887	7a9e2428-1f30-4914-b5f4-d71ec58f79b7	11	\N	13	2025-02-03 22:21:51.354	2025-02-03 22:23:15.515	84	https://storage.vapi.ai/7a9e2428-1f30-4914-b5f4-d71ec58f79b7-1738621398029-ffa5f2d3-e955-48f8-90f6-ef21ac3d57db-mono.wav	14155393048	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
888	36821782-53c4-4bbf-88db-8d390496d64b	11	\N	13	2025-02-04 14:25:13.059	2025-02-04 14:25:30.906	17	https://storage.vapi.ai/36821782-53c4-4bbf-88db-8d390496d64b-1738679133411-3cdd7f9e-181a-452a-86d6-2d627ed8edd3-mono.wav	15714258221	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
889	c911d314-e070-4c8e-b722-8f094425656c	11	\N	13	2025-02-04 15:10:47.931	2025-02-04 15:11:18.413	30	https://storage.vapi.ai/c911d314-e070-4c8e-b722-8f094425656c-1738681880919-6e2b22cc-36e9-4920-be79-5c654f4ca64f-mono.wav	17036086035	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
890	692197d3-2d0d-40a4-9d0a-e940a98541b0	11	\N	13	2025-02-04 16:00:50.195	2025-02-04 16:02:13.346	83	https://storage.vapi.ai/692197d3-2d0d-40a4-9d0a-e940a98541b0-1738684935856-4fb793f8-2abd-460e-acfa-813b154a63e9-mono.wav	12092159738	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
891	8490a04a-8ee3-4b3a-b233-ed5459bded63	11	\N	13	2025-02-04 16:39:02.354	2025-02-04 16:39:02.354	0	https://storage.vapi.ai/8490a04a-8ee3-4b3a-b233-ed5459bded63-1738687144858-e60c6b94-bf56-4040-a5e8-c82f79648203-mono.wav	14692835948	\N	\N	\N	\N	\N	customer-did-not-answer	\N	\N	\N
892	f49edb46-8d29-4fae-bd27-ce03261f398d	11	\N	13	2025-02-04 17:29:50.141	2025-02-04 17:30:11.297	21	https://storage.vapi.ai/f49edb46-8d29-4fae-bd27-ce03261f398d-1738690213806-cba8a8bf-2d71-4e47-970c-b99565f68859-mono.wav	16233041277	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
893	27881063-a936-403b-951b-b31119d1bd8b	11	\N	13	2025-02-04 18:06:38.919	2025-02-04 18:07:58.635	79	https://storage.vapi.ai/27881063-a936-403b-951b-b31119d1bd8b-1738692481142-3ba37ddc-8092-4050-a30a-04daa30e833b-mono.wav	19592590521	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
894	19bd5087-f803-4afb-bea4-264f9e64af91	11	\N	13	2025-02-04 18:08:47.231	2025-02-04 18:09:08.687	21	https://storage.vapi.ai/19bd5087-f803-4afb-bea4-264f9e64af91-1738692551192-83a65799-2509-4e56-a355-433c03915291-mono.wav	17722180490	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
895	1049a897-8f18-4054-b207-a2ae611b389b	11	\N	13	2025-02-04 18:34:10.977	2025-02-04 18:34:57.99	47	https://storage.vapi.ai/1049a897-8f18-4054-b207-a2ae611b389b-1738694100508-ed6d5eb8-437c-4453-84d3-357dad9802e6-mono.wav	17209861217	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
896	edf4a64d-0a13-48e0-b65c-d70c70a7718c	11	\N	13	2025-02-04 18:36:36.184	2025-02-04 18:36:57.295	21	https://storage.vapi.ai/edf4a64d-0a13-48e0-b65c-d70c70a7718c-1738694219802-59cc8f3b-5aea-45da-ab05-6824e8bcb59e-mono.wav	17209861217	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
897	5d72aeb6-5dda-4fa2-ae9a-6e3efd7c3196	11	\N	13	2025-02-04 19:59:52.542	2025-02-04 20:00:19.135	26	https://storage.vapi.ai/5d72aeb6-5dda-4fa2-ae9a-6e3efd7c3196-1738699221641-d7711060-1b1a-426b-824d-7785d2595373-mono.wav	15405506874	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
898	4446eceb-b36f-49fe-9b31-12eef540ae7f	11	\N	13	2025-02-04 20:48:16.451	2025-02-04 20:49:01.616	45	https://storage.vapi.ai/4446eceb-b36f-49fe-9b31-12eef540ae7f-1738702144122-66846a9d-f2f3-4ec8-a53b-a0071216e531-mono.wav	15713851625	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
899	60e1f61a-6c55-4ad1-a14c-daf91d572479	11	\N	13	2025-02-05 00:44:21.036	2025-02-05 00:46:44.121	143	https://storage.vapi.ai/60e1f61a-6c55-4ad1-a14c-daf91d572479-1738716406628-137f501f-4d78-4eb6-ae4a-e457797b1f90-mono.wav	17865041814	\N	\N	\N	\N	\N	assistant-ended-call	\N	\N	\N
900	c29ae47a-02da-40e3-ba55-7f7f059d9041	11	\N	13	2025-02-05 16:16:07.092	2025-02-05 16:16:26.778	19	https://storage.vapi.ai/c29ae47a-02da-40e3-ba55-7f7f059d9041-1738772189284-c5127621-bbc8-4dd4-bf5d-73281f00d427-mono.wav	16462168533	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
901	01f0d5ee-e8fe-4af8-8a15-df9de2a6da90	11	\N	13	2025-02-05 16:50:54.152	2025-02-05 16:51:04.832	10	https://storage.vapi.ai/01f0d5ee-e8fe-4af8-8a15-df9de2a6da90-1738774267335-5787495f-9c03-4523-a432-260f4d6d3eb6-mono.wav	16462168533	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
902	af907180-7729-482c-8021-5da158828e24	11	\N	13	2025-02-05 16:57:45.017	2025-02-05 16:58:19.056	34	https://storage.vapi.ai/af907180-7729-482c-8021-5da158828e24-1738774701562-d0658c5f-d5d4-44a3-bd6a-597e06c5eef9-mono.wav	16468894043	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
903	e4747a93-d559-4ef3-a97d-ff9747ceb2f5	11	\N	13	2025-02-05 18:20:07.115	2025-02-05 18:20:23.838	16	https://storage.vapi.ai/e4747a93-d559-4ef3-a97d-ff9747ceb2f5-1738779626343-30e3b57b-7669-4bbe-a34c-743339a1eb74-mono.wav	19176268612	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1009	29cdf67a-3daf-477b-9ebe-94970c5e39df	13	\N	15	2025-03-25 18:19:39.825	2025-03-25 18:20:32.166	52	https://storage.vapi.ai/29cdf67a-3daf-477b-9ebe-94970c5e39df-1742926834670-70fdbce1-988e-493d-8b36-557d90e2d590-mono.wav	17862660222	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1010	22e13b8d-3668-4d09-baf6-3c77cf05f90b	13	\N	15	2025-03-25 18:21:13.842	2025-03-25 18:21:43.394	29	https://storage.vapi.ai/22e13b8d-3668-4d09-baf6-3c77cf05f90b-1742926905901-5edbff21-622d-43df-b153-681fed535099-mono.wav	17862136477	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1011	c197418a-a125-4d39-b48f-19d42b193520	13	\N	15	2025-03-25 18:25:29.532	2025-03-25 18:25:42.146	12	https://storage.vapi.ai/c197418a-a125-4d39-b48f-19d42b193520-1742927144652-de42ade0-884e-4b50-9718-12aaf14f9801-mono.wav	18133005328	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1012	a4829966-d2a7-4a71-8414-6012058008e8	13	\N	15	2025-03-25 18:25:38.04	2025-03-25 18:25:57.974	19	https://storage.vapi.ai/a4829966-d2a7-4a71-8414-6012058008e8-1742927160482-200ccea5-bfe2-4ab9-8d19-16e8fd190e1e-mono.wav	19546249517	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
1013	1d288f02-aa4f-4e9c-b81f-fd2f685d74e9	13	\N	15	2025-03-25 18:28:41.149	2025-03-25 18:29:02.461	21	https://storage.vapi.ai/1d288f02-aa4f-4e9c-b81f-fd2f685d74e9-1742927344965-161fa785-571c-4dac-b723-ad90d4ef7c5a-mono.wav	13058341820	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1014	3b541127-bcd9-47cd-a0b2-16a23381cd92	13	\N	15	2025-03-25 18:28:28.192	2025-03-25 18:29:01.202	33	https://storage.vapi.ai/3b541127-bcd9-47cd-a0b2-16a23381cd92-1742927343736-5da0aa29-f865-479f-a283-5768c0de6641-mono.wav	14422561169	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1015	a1effba6-53c1-4dae-82c0-81a086ee6097	13	\N	15	2025-03-25 18:30:56.059	2025-03-25 18:31:45.08	49	https://storage.vapi.ai/a1effba6-53c1-4dae-82c0-81a086ee6097-1742927507586-bdd91e1f-94ae-47ba-86b9-63487f265274-mono.wav	17863064320	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1016	7add80e0-7bf0-45a6-889e-479338b37579	13	\N	15	2025-03-25 18:31:48.721	2025-03-25 18:32:34.79	46	https://storage.vapi.ai/7add80e0-7bf0-45a6-889e-479338b37579-1742927557295-1c0573a4-3af9-4f4f-aec5-24a109998ecb-mono.wav	17867501514	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1017	33c62acf-1b89-4fa6-9bc3-d832336455ef	13	\N	15	2025-03-25 18:36:58.673	2025-03-25 18:37:22.142	23	https://storage.vapi.ai/33c62acf-1b89-4fa6-9bc3-d832336455ef-1742927844647-199d0b53-a91b-4da1-900a-307e450b00e3-mono.wav	17868397055	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1018	0717182c-bdac-48b5-8187-334e90a58626	13	\N	15	2025-03-25 18:47:24.871	2025-03-25 18:47:57.807	32	https://storage.vapi.ai/0717182c-bdac-48b5-8187-334e90a58626-1742928480311-f145df04-dea4-4de7-a2b0-3b904af77efa-mono.wav	19545152776	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1019	f3263d28-a9fe-4ba6-964b-e6af9bc9eb1d	13	\N	15	2025-03-25 18:48:47.378	2025-03-25 18:49:14.045	26	https://storage.vapi.ai/f3263d28-a9fe-4ba6-964b-e6af9bc9eb1d-1742928556550-917403da-d57f-43a4-9c4a-923d899ad7cf-mono.wav	17868397055	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1020	292e0b8f-266d-4f54-b4c2-a82eb0eea328	13	\N	15	2025-03-25 18:49:31.156	2025-03-25 18:50:10.145	38	https://storage.vapi.ai/292e0b8f-266d-4f54-b4c2-a82eb0eea328-1742928612653-533cb966-4893-40cf-bc8d-f15a93b88528-mono.wav	17862660222	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
904	f4ba25c3-5a44-48c4-957d-b4dea434b8f6	12	\N	14	2024-11-14 18:37:04.862	2024-11-14 18:37:12.129	6	https://storage.vapi.ai/f4ba25c3-5a44-48c4-957d-b4dea434b8f6-1731609434636-46054e74-9824-4315-bc42-0e81f06a0358-mono.wav	18137693880	inboundPhoneCall	\N		\N	\N	customer-ended-call			
905	b4c10b9b-5272-449f-8493-94d910d922fa	12	\N	14	2024-11-14 19:21:50.812	2024-11-14 19:23:55.716	123	https://storage.vapi.ai/b4c10b9b-5272-449f-8493-94d910d922fa-1731612238222-9b36ee93-0137-45f7-97a0-d1a43ce4d322-mono.wav	14153098530	inboundPhoneCall	\N		\N	\N	customer-ended-call			
906	d814fe25-d555-4a99-9c38-945eb1852fa2	12	\N	14	2024-11-14 19:34:25.383	2024-11-14 19:35:18.349	51	https://storage.vapi.ai/d814fe25-d555-4a99-9c38-945eb1852fa2-1731612920853-fb62005f-bbba-42c0-bb97-d97a93ff70b2-mono.wav	18666972680	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
907	84703b64-dd02-4fd6-b427-95948e68bc92	12	\N	14	2024-11-14 19:37:19.763	2024-11-14 19:38:41.598	80	https://storage.vapi.ai/84703b64-dd02-4fd6-b427-95948e68bc92-1731613124101-9f49cb5f-5937-4873-809d-7b9271767438-mono.wav	18666972680	inboundPhoneCall	\N		\N	\N	customer-ended-call			
908	f64203e1-68c0-4c03-b073-0cd5a62e28bc	12	\N	14	2024-11-14 19:39:40.509	2024-11-14 19:41:03.872	81	https://storage.vapi.ai/f64203e1-68c0-4c03-b073-0cd5a62e28bc-1731613266375-39fe4a9b-2665-49b0-8e06-601bd651a0fd-mono.wav	18666972680	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
909	b2bfdee6-acda-490b-9bb2-2f1206b2e895	12	\N	14	2024-11-14 19:41:41.977	2024-11-14 19:42:03.636	20	https://storage.vapi.ai/b2bfdee6-acda-490b-9bb2-2f1206b2e895-1731613326148-03462cf1-66cd-4e36-b3f0-ced45d1579e6-mono.wav	14155656136	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
910	647e57b0-39a1-4d67-9dd7-f384f74ccf17	12	\N	14	2024-11-14 19:42:57.365	2024-11-14 19:43:16.849	18	https://storage.vapi.ai/647e57b0-39a1-4d67-9dd7-f384f74ccf17-1731613399352-a1d30c9d-480c-4394-92cd-40425df9441f-mono.wav	14155656136	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
911	1c92c8d3-bc27-4e64-8b19-a566ac0bd3e5	12	\N	14	2024-11-14 20:21:00.174	2024-11-14 20:22:45.767	104	https://storage.vapi.ai/1c92c8d3-bc27-4e64-8b19-a566ac0bd3e5-1731615768274-9358b65c-55ab-424f-ad12-ca236d44820c-mono.wav	14153074015	inboundPhoneCall	\N		\N	\N	customer-ended-call			
912	5e95eb0f-dfba-46bd-bb59-938e3db1048a	12	\N	14	2024-11-14 20:50:07.294	2024-11-14 20:52:14.088	125	https://storage.vapi.ai/5e95eb0f-dfba-46bd-bb59-938e3db1048a-1731617536592-ab2889c0-70e3-4a5e-a9da-c0a580fe08a3-mono.wav	14156061222	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
913	1b1ac281-2b4f-4754-900d-6f5d57ab0d0e	12	\N	14	2024-11-14 21:08:50.524	2024-11-14 21:09:35.842	43	https://storage.vapi.ai/1b1ac281-2b4f-4754-900d-6f5d57ab0d0e-1731618578346-11184022-1597-41bd-9beb-2584f952c742-mono.wav	15302854045	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
914	4a1b6903-a6fd-4488-a78a-9f35c26ff3c6	12	\N	14	2024-11-14 21:49:08.131	2024-11-14 21:49:41.532	32	https://storage.vapi.ai/4a1b6903-a6fd-4488-a78a-9f35c26ff3c6-1731620984038-22e68631-eab0-43fa-9c1e-cf793ac852e3-mono.wav	18002259675	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
915	ff2622e2-b457-47fb-9e11-6f36e62b3538	12	\N	14	2024-11-14 22:12:30.246	2024-11-14 22:12:46.573	15	https://storage.vapi.ai/ff2622e2-b457-47fb-9e11-6f36e62b3538-1731622369077-e32eed1f-5fa8-4d0b-ae3d-5649af825a69-mono.wav	14158479678	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
916	13153494-85eb-4c16-889e-3087acba66ab	12	\N	14	2024-11-14 22:45:05.898	2024-11-14 22:45:48.28	41	https://storage.vapi.ai/13153494-85eb-4c16-889e-3087acba66ab-1731624350789-8d7c5751-dac7-4caf-adba-a24ef6c118c3-mono.wav	14153537999	inboundPhoneCall	\N		\N	\N	customer-ended-call			
917	d7ecbbdc-64c8-4bec-af65-5a71f92c1dd2	12	\N	14	2024-11-14 22:45:54.414	2024-11-14 22:46:54.659	59	https://storage.vapi.ai/d7ecbbdc-64c8-4bec-af65-5a71f92c1dd2-1731624417163-b6495e37-42c1-418e-8a78-c5b387e77a7a-mono.wav	14153537999	inboundPhoneCall	\N		\N	\N	customer-ended-call			
918	c2ff6fe1-7225-42bb-90b3-ddef9e91bbca	12	\N	14	2024-11-14 22:53:11.852	2024-11-14 22:53:33.861	17	https://storage.vapi.ai/c2ff6fe1-7225-42bb-90b3-ddef9e91bbca-1731624816364-676d8795-4fd8-4b52-9877-9e8636a517b5-mono.wav		webCall	\N		\N	\N	customer-ended-call			
919	ac36cee8-1b0e-4674-824c-519110b31077	12	\N	14	2024-11-14 22:57:36.632	2024-11-14 22:57:47.308	9	https://storage.vapi.ai/ac36cee8-1b0e-4674-824c-519110b31077-1731625069815-72541c46-e18e-4928-945a-917824edac95-mono.wav	14157459694	inboundPhoneCall	\N		\N	\N	customer-ended-call			
920	5bd5d7f6-ad52-4fca-9ca7-98b67cb9171d	12	\N	14	2024-11-14 22:59:27.925	2024-11-14 23:00:40.943	72	https://storage.vapi.ai/5bd5d7f6-ad52-4fca-9ca7-98b67cb9171d-1731625243453-68b68a47-0ac6-45ed-8701-061b32835ee1-mono.wav	14157459694	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
921	d65736b0-810c-4d7b-b770-cceeda33702d	12	\N	14	2024-11-15 16:41:29.352	2024-11-15 16:42:17.215	46	https://storage.vapi.ai/d65736b0-810c-4d7b-b770-cceeda33702d-1731688939723-5635e718-f64f-47f8-ad6e-203363bea57c-mono.wav	14153075354	inboundPhoneCall	\N		\N	\N	silence-timed-out			
922	0f2dbb95-f476-4f41-8f24-1082af6ba1f2	12	\N	14	2024-11-15 16:43:01.1	2024-11-15 16:44:00.753	58	https://storage.vapi.ai/0f2dbb95-f476-4f41-8f24-1082af6ba1f2-1731689043266-2098cd38-1938-4c1a-86a3-64d3c740cd88-mono.wav	14153075354	inboundPhoneCall	\N		\N	\N	silence-timed-out			
923	f1fac656-0049-4ac0-9d22-fd382782f2d1	12	\N	14	2024-11-15 16:44:21.545	2024-11-15 16:45:08.486	45	https://storage.vapi.ai/f1fac656-0049-4ac0-9d22-fd382782f2d1-1731689110990-4278b44f-6522-493b-9dee-91b405b586d4-mono.wav	14153075354	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
924	8bd95c7a-92f3-4efa-8eb0-c579bd7b773d	12	\N	14	2024-11-15 17:03:09.471	2024-11-15 17:03:40.953	30	https://storage.vapi.ai/8bd95c7a-92f3-4efa-8eb0-c579bd7b773d-1731690223462-b3486ac9-793d-411f-a236-572318b48f35-mono.wav	13473847040	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
925	72c25026-20e5-42b9-8615-9b6fda11865e	12	\N	14	2024-11-15 17:12:17.781	2024-11-15 17:13:05.644	46	https://storage.vapi.ai/72c25026-20e5-42b9-8615-9b6fda11865e-1731690788148-032bef7d-68e0-48a9-80f9-b1c0cc2dab0c-mono.wav	14155648990	inboundPhoneCall	\N		\N	\N	silence-timed-out			
926	29faaaf8-6a5f-42ac-b248-98fb5be81d2d	12	\N	14	2024-11-15 17:17:44.304	2024-11-15 17:18:14.944	29	https://storage.vapi.ai/29faaaf8-6a5f-42ac-b248-98fb5be81d2d-1731691097448-b490fbc6-7559-4e19-97de-91696ebfdd0d-mono.wav	18776725679	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
927	c692525b-1a7d-45ca-9941-3ea0e711bd68	12	\N	14	2024-11-15 17:27:41.148	2024-11-15 17:29:18.689	96	https://storage.vapi.ai/c692525b-1a7d-45ca-9941-3ea0e711bd68-1731691761193-8bfe19f3-603f-49e4-852f-e75325152b9f-mono.wav	19253276777	inboundPhoneCall	\N		\N	\N	customer-ended-call			
928	b83d7157-a7af-448c-a286-e779db4a5b68	12	\N	14	2024-11-15 17:40:38.658	2024-11-15 17:41:40.736	61	https://storage.vapi.ai/b83d7157-a7af-448c-a286-e779db4a5b68-1731692503250-c0728d65-043a-41bd-9053-f252104acc96-mono.wav	14158464078	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
929	3e76a7cd-35b3-4d9b-84b1-577992434790	12	\N	14	2024-11-15 17:51:54.087	2024-11-15 17:52:18.96	23	https://storage.vapi.ai/3e76a7cd-35b3-4d9b-84b1-577992434790-1731693174579-16c17630-f146-4b76-bee5-040fd746aa0e-mono.wav	19494846960	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
930	4038d3c6-ae6d-4e7e-8956-36d683fb597c	12	\N	14	2024-11-15 17:55:37.384	2024-11-15 17:56:57.48	79	https://storage.vapi.ai/4038d3c6-ae6d-4e7e-8956-36d683fb597c-1731693419984-aa45cc41-c0a9-4456-97de-b1b01b069053-mono.wav	14152364901	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
931	08284468-f0f5-4b01-aa40-fae28e76eea5	12	\N	14	2024-11-15 18:11:47.396	2024-11-15 18:12:37.888	49	https://storage.vapi.ai/08284468-f0f5-4b01-aa40-fae28e76eea5-1731694360392-7a156715-7b06-46b2-b40c-1d15186b859f-mono.wav	14157868728	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
932	4242f691-afe2-411e-a7a4-286c30630e6a	12	\N	14	2024-11-15 18:18:39.9	2024-11-15 18:18:53.401	12	https://storage.vapi.ai/4242f691-afe2-411e-a7a4-286c30630e6a-1731694735910-a5b89ed5-448c-4c46-a46f-5b3dc8bda23a-mono.wav	14842328757	inboundPhoneCall	\N		\N	\N	customer-ended-call			
933	bd443240-7718-4b83-b613-14b414cbef2b	12	\N	14	2024-11-15 18:22:15.897	2024-11-15 18:26:21.746	244	https://storage.vapi.ai/bd443240-7718-4b83-b613-14b414cbef2b-1731695184253-bdf1f0ec-8dc2-4134-9bf4-204fbdd6630c-mono.wav	14157868728	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
934	858909ae-b8c4-4ce2-82e2-cbe8b8e897f7	12	\N	14	2024-11-15 18:28:05.18	2024-11-15 18:28:39.928	33	https://storage.vapi.ai/858909ae-b8c4-4ce2-82e2-cbe8b8e897f7-1731695322432-df71b449-ee04-4e8d-ab27-654bb5b1d55c-mono.wav	14158122282	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
935	9d86b191-83a3-4961-ae68-e8e68370599c	12	\N	14	2024-11-15 18:38:52.096	2024-11-15 18:39:49.671	56	https://storage.vapi.ai/9d86b191-83a3-4961-ae68-e8e68370599c-1731695992175-7f8b0141-388d-4550-843f-a4e1a56b01e3-mono.wav	16505378438	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
936	a4173fac-7536-4f7f-b302-c6c8fe2bfc31	12	\N	14	2024-11-15 19:00:12.539	2024-11-15 19:00:33.493	19	https://storage.vapi.ai/a4173fac-7536-4f7f-b302-c6c8fe2bfc31-1731697235999-a325aa34-aa28-48f7-87f2-3ba3f6dcc10f-mono.wav	19085027654	inboundPhoneCall	\N		\N	\N	customer-ended-call			
937	dc724755-42be-4657-9af4-f85a60fb70d3	12	\N	14	2024-11-15 19:00:41.343	2024-11-15 19:01:10.476	28	https://storage.vapi.ai/dc724755-42be-4657-9af4-f85a60fb70d3-1731697272979-58016456-049b-46c9-b1af-79eacc1abb11-mono.wav	14156135116	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
938	1b538a0b-ff43-4494-8f0d-ece895eff159	12	\N	14	2024-11-15 19:01:56.05	2024-11-15 19:02:18.681	20	https://storage.vapi.ai/1b538a0b-ff43-4494-8f0d-ece895eff159-1731697341184-912aa8eb-dde9-4435-b633-a87dcef10a56-mono.wav	14156135116	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
939	554612ae-0662-49fc-9da9-4d25921ddf0c	12	\N	14	2024-11-15 19:31:21.261	2024-11-15 19:32:10.67	48	https://storage.vapi.ai/554612ae-0662-49fc-9da9-4d25921ddf0c-1731699133181-3bd1b2ad-8423-4c37-a67a-0dc94a8f0d7e-mono.wav	12098140356	inboundPhoneCall	\N		\N	\N	customer-ended-call			
940	4b334ed6-eadc-46c9-82f7-466e85885758	12	\N	14	2024-11-15 19:35:34.156	2024-11-15 19:36:18.132	43	https://storage.vapi.ai/4b334ed6-eadc-46c9-82f7-466e85885758-1731699380636-3cb67dcc-3c2e-426d-b357-96fc1af83d13-mono.wav	12133143031	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
941	b0e199c8-24d1-4a1b-a33b-4bca145aef1a	12	\N	14	2024-11-15 19:34:21.934	2024-11-15 19:36:17.676	114	https://storage.vapi.ai/b0e199c8-24d1-4a1b-a33b-4bca145aef1a-1731699380179-2842c4d5-90f1-4f14-8c89-d75e5b6f934e-mono.wav	14157568649	inboundPhoneCall	\N		\N	\N	customer-ended-call			
942	df876b42-4ea7-4b6f-9082-d84043b9d62c	12	\N	14	2024-11-15 19:41:29.021	2024-11-15 19:43:06.085	95	https://storage.vapi.ai/df876b42-4ea7-4b6f-9082-d84043b9d62c-1731699788594-0f2d4682-e329-4def-ab36-d840dbfb6e65-mono.wav	14153855881	inboundPhoneCall	\N		\N	\N	customer-ended-call			
943	f6a37fb6-6587-4180-b7ce-bb0346492475	12	\N	14	2024-11-15 19:50:08.436	2024-11-15 19:50:59.305	49	https://storage.vapi.ai/f6a37fb6-6587-4180-b7ce-bb0346492475-1731700261809-d3e637e8-6eac-4a2c-8155-57d1aba7bbe5-mono.wav	14152253825	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
944	2799910c-d4ca-455a-beee-b0ad29c3dba7	12	\N	14	2024-11-15 20:19:13.79	2024-11-15 20:19:35.606	20	https://storage.vapi.ai/2799910c-d4ca-455a-beee-b0ad29c3dba7-1731701978109-72468388-4650-4b25-ac4c-1c3c4184f2f1-mono.wav	19257856384	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
945	c5b6958d-c32e-4549-b3c2-8bcd44da643e	12	\N	14	2024-11-15 20:21:21.708	2024-11-15 20:21:43.976	21	https://storage.vapi.ai/c5b6958d-c32e-4549-b3c2-8bcd44da643e-1731702106481-99b26753-6fc8-4430-bb34-ada314a12ed6-mono.wav	15155260244	inboundPhoneCall	\N		\N	\N	assistant-ended-call			
946	78524452-8694-40d6-b931-40a1c988045f	12	\N	14	2024-11-15 20:23:37.207	2024-11-15 20:24:21.062	42	https://storage.vapi.ai/78524452-8694-40d6-b931-40a1c988045f-1731702263566-dd91bf70-d3ca-4472-93ec-ba444b12b350-mono.wav	14153075354	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
947	23a91872-c51f-486a-ace9-9db5f531779e	12	\N	14	2024-11-15 20:46:08.144	2024-11-15 20:46:43.301	34	https://storage.vapi.ai/23a91872-c51f-486a-ace9-9db5f531779e-1731703605806-eba0f26e-80dd-4f78-84f6-073cfaae7161-mono.wav	18005532155	inboundPhoneCall	\N		\N	\N	silence-timed-out			
948	a54787dc-ade3-477e-8709-a56cf81456ed	12	\N	14	2024-11-15 21:15:15.744	2024-11-15 21:16:06.836	50	https://storage.vapi.ai/a54787dc-ade3-477e-8709-a56cf81456ed-1731705369341-945ed8a0-a761-4a04-99f9-eb839c11387c-mono.wav	14159996848	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
949	03499951-bb92-4434-abac-175f8a44d520	12	\N	14	2024-11-15 21:21:57.586	2024-11-15 21:22:42.95	44	https://storage.vapi.ai/03499951-bb92-4434-abac-175f8a44d520-1731705765454-1d172f5b-6529-45e1-8d26-640c90180b50-mono.wav	14159230992	inboundPhoneCall	\N		\N	\N	customer-ended-call			
950	20e4d184-7f61-430b-842a-0143bd70d8eb	12	\N	14	2024-11-15 22:42:56.779	2024-11-15 22:43:25.329	27	https://storage.vapi.ai/20e4d184-7f61-430b-842a-0143bd70d8eb-1731710607832-42361acc-47e3-4660-9f9b-a2fd3718851c-mono.wav	14152549511	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
951	220f30c0-030e-4f99-a17f-9a5408ae15c9	12	\N	14	2024-11-16 00:08:33.083	2024-11-16 00:08:48.273	14	https://storage.vapi.ai/220f30c0-030e-4f99-a17f-9a5408ae15c9-1731715730776-d745c6ed-922e-4cdc-9a98-3b3b0444fc9f-mono.wav	15625950900	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
952	391deb6f-c306-4b43-8f27-128c16a11718	12	\N	14	2024-11-16 00:09:19.223	2024-11-16 00:09:42.032	21	https://storage.vapi.ai/391deb6f-c306-4b43-8f27-128c16a11718-1731715784535-73f5833b-ab23-46e8-b247-737029e7522a-mono.wav	15625950900	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
953	ea7e1057-c918-45bf-8e71-c412c6f11fb1	12	\N	14	2024-11-16 00:29:41.801	2024-11-16 00:30:27.06	44	https://storage.vapi.ai/ea7e1057-c918-45bf-8e71-c412c6f11fb1-1731717029568-a6bab984-020e-4298-8ba9-9012aec3b558-mono.wav	17735102695	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
954	bff8f143-6871-4177-ac09-8871cd272f9a	12	\N	14	2024-11-16 00:31:32.042	2024-11-16 00:32:00.631	27	https://storage.vapi.ai/bff8f143-6871-4177-ac09-8871cd272f9a-1731717123135-e35051c8-e756-45d7-89ba-04576c437777-mono.wav	17735102695	inboundPhoneCall	\N		\N	\N	assistant-forwarded-call			
955	0e312426-0fa2-48d0-aa94-fb99f73af0c0	12	\N	14	2024-11-18 00:18:56.13	2024-11-18 00:20:33.043	95	https://storage.vapi.ai/0e312426-0fa2-48d0-aa94-fb99f73af0c0-1731889235551-62d565d4-3f60-41ad-ba8c-3291c4efab2d-mono.wav	17865041814	inboundPhoneCall	\N	New Client - Insurance Pay	\N	\N	assistant-forwarded-call	JorgeCastilla	March 17 2001	Medicare
956	1ebece31-d381-4660-856d-55e7f5e9ed06	12	\N	14	2024-11-18 15:40:58.753	2024-11-18 15:41:27.885	28	https://storage.vapi.ai/1ebece31-d381-4660-856d-55e7f5e9ed06-1731944490389-f7b69884-bede-4946-9631-a7abb917d629-mono.wav	18002259675	inboundPhoneCall	\N	Authorization and Referral Inquiry	\N	\N	assistant-forwarded-call	BlaiseRhodes		MedRisk
957	5f731869-74e5-400e-85f8-ddebee114699	12	\N	14	2024-11-18 16:32:34.697	2024-11-18 16:33:13.462	37	https://storage.vapi.ai/5f731869-74e5-400e-85f8-ddebee114699-1731947595968-05c19296-a2aa-4926-8f8a-1622466adcd1-mono.wav	17632743899	inboundPhoneCall	\N	Authorization and Referral Inquiry	\N	\N	assistant-forwarded-call			UnitedHealthcare
958	9631cedd-50cd-475a-9dc0-061f3a08179e	12	\N	14	2024-11-18 16:34:32.949	2024-11-18 16:35:08.911	35	https://storage.vapi.ai/9631cedd-50cd-475a-9dc0-061f3a08179e-1731947711416-03bf2dbe-72af-4a6b-8fea-c57d216cb789-mono.wav	17632743899	inboundPhoneCall	\N	Payment and Insurance Inquiry (Non-New Client)	\N	\N	assistant-forwarded-call			UnitedHealthcare
959	a93f9949-01fc-4363-99d0-ae336e842f5d	12	\N	14	2024-11-18 16:40:52.276	2024-11-18 16:41:27.455	34	https://storage.vapi.ai/a93f9949-01fc-4363-99d0-ae336e842f5d-1731948089961-bde34c82-becf-47f0-a16e-c4a6ce00c4f5-mono.wav	17632743899	inboundPhoneCall	\N	Payment and Insurance Inquiry (Non-New Client)	\N	\N	assistant-forwarded-call			UnitedHealthcare insurance
960	bfe6282b-b06e-49ba-a040-1fbd863663be	12	\N	14	2024-11-18 18:54:21.186	2024-11-18 18:56:05.027	102	https://storage.vapi.ai/bfe6282b-b06e-49ba-a040-1fbd863663be-1731956167531-414b8532-7c3c-4017-91b4-346895cbba6c-mono.wav	18002259675	inboundPhoneCall	\N	Authorization and Referral Inquiry	\N	\N	silence-timed-out	JanineLevin		Med
961	0fbe69ad-879a-434a-91a9-080f0420bc96	12	\N	14	2024-11-18 16:52:06.524	2024-11-18 16:52:26.846	19	https://storage.vapi.ai/0fbe69ad-879a-434a-91a9-080f0420bc96-1731948749351-7e5a8c90-910c-436a-b16d-f3070553690b-mono.wav	17158706517	inboundPhoneCall	\N	General or Miscellaneous Inquiry	\N	\N	assistant-forwarded-call	MariaMarquez		Liberty Mutual Work Comp
962	5cdd2f5d-a52c-4e9c-bf41-2ca6d62ec368	12	\N	14	2024-11-18 16:58:05.539	2024-11-18 16:58:35.399	28	https://storage.vapi.ai/5cdd2f5d-a52c-4e9c-bf41-2ca6d62ec368-1731949117903-69cb6287-6fcd-453c-8e1e-b31805c7f1c5-mono.wav	17632743899	inboundPhoneCall	\N	Payment and Insurance Inquiry (Non-New Client)	\N	\N	assistant-forwarded-call			
963	cd15c23c-582a-40a8-a814-120ad8b95959	12	\N	14	2024-11-18 16:59:24.971	2024-11-18 16:59:47.515	21	https://storage.vapi.ai/cd15c23c-582a-40a8-a814-120ad8b95959-1731949190019-c70e1ac6-0606-44c1-8e06-fe67294fa0c6-mono.wav	17158706517	inboundPhoneCall	\N	Appointment Management (Existing Clients)	\N	\N	assistant-forwarded-call			
964	8902f729-b37f-4e98-be86-d5af993edf9a	12	\N	14	2024-11-18 16:59:26.742	2024-11-18 16:59:48.426	20	https://storage.vapi.ai/8902f729-b37f-4e98-be86-d5af993edf9a-1731949190930-872171b2-2f26-4fb4-80ed-47e0e8519892-mono.wav	17632743899	inboundPhoneCall	\N	Payment and Insurance Inquiry (Non-New Client)	\N	\N	assistant-forwarded-call			
965	d29100d4-ac93-42c0-a3f0-f15deb162b9a	13	\N	15	2025-03-25 12:00:07.718	2025-03-25 12:02:02.634	114	https://storage.vapi.ai/d29100d4-ac93-42c0-a3f0-f15deb162b9a-1742904125139-89304bbb-d97e-482e-adfc-263c885306e3-mono.wav	17868310458	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
966	49a371e8-c286-417a-9973-ab122775477c	13	\N	15	2025-03-25 12:47:29.817	2025-03-25 12:47:30.107	0	https://storage.vapi.ai/49a371e8-c286-417a-9973-ab122775477c-1742906852608-b45f6ff4-9ff1-4c8c-b2a8-71f7559aaffe-mono.wav	17867154063	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
967	10fc96e1-705c-4af0-9b1b-6c7936efdb49	13	\N	15	2025-03-25 13:27:17.649	2025-03-25 13:27:49.968	32	https://storage.vapi.ai/10fc96e1-705c-4af0-9b1b-6c7936efdb49-1742909272473-23eddc4c-5d4a-4905-99d0-daa82513dd67-mono.wav	17867991874	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
968	bada2553-8eee-4f28-8622-e01dc6aa7180	13	\N	15	2025-03-25 13:37:25.084	2025-03-25 13:37:44.871	19	https://storage.vapi.ai/bada2553-8eee-4f28-8622-e01dc6aa7180-1742909867385-039ac23e-23c2-449c-9c01-e5a7dfd45c45-mono.wav	13055283427	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
969	aa5f6531-02b9-4e7f-805b-8c56f7e5b3ba	13	\N	15	2025-03-25 12:11:28.233	2025-03-25 12:12:44.265	76	https://storage.vapi.ai/aa5f6531-02b9-4e7f-805b-8c56f7e5b3ba-1742904766772-e9112f69-74ae-4411-87af-23bafe6b6a40-mono.wav	17864872150	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
970	19e92531-1942-427c-b1d1-03d746907059	13	\N	15	2025-03-25 13:44:28.158	2025-03-25 13:44:53.685	25	https://storage.vapi.ai/19e92531-1942-427c-b1d1-03d746907059-1742910296192-0531eeb5-4fec-475b-bcd7-086195ef6d5f-mono.wav	13056880811	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
971	282ffbd3-7249-4c11-9601-7608800a72fb	13	\N	15	2025-03-25 12:13:38.213	2025-03-25 12:14:13.355	35	https://storage.vapi.ai/282ffbd3-7249-4c11-9601-7608800a72fb-1742904855860-21e73652-a79e-4c0a-be6f-be96da7c4382-mono.wav	17862345467	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
972	80ba19a8-a866-4611-8e21-5b627a9b7e29	13	\N	15	2025-03-25 13:50:37.533	2025-03-25 13:50:57.333	19	https://storage.vapi.ai/80ba19a8-a866-4611-8e21-5b627a9b7e29-1742910659858-5940b9d8-7a70-4a2c-9e1b-1d0a030b78f9-mono.wav	13057883622	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
973	4ec83d0a-8718-44fc-a365-bacea2b5592d	13	\N	15	2025-03-25 13:51:50.216	2025-03-25 13:51:56.232	6	https://storage.vapi.ai/4ec83d0a-8718-44fc-a365-bacea2b5592d-1742910718733-261d023e-5658-44e5-9e05-7904b355ab36-mono.wav	17862342697	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
974	6db92b83-7792-4915-8b5b-a756714b7b0e	13	\N	15	2025-03-25 13:55:53.451	2025-03-25 13:56:09.909	16	https://storage.vapi.ai/6db92b83-7792-4915-8b5b-a756714b7b0e-1742910972411-8b4ff62c-8a50-4808-b675-b3f108e2944b-mono.wav	17867716385	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
975	eae81d4f-7cec-4772-94ce-09c36dcbc721	13	\N	15	2025-03-25 13:58:05.316	2025-03-25 13:58:53.769	48	https://storage.vapi.ai/eae81d4f-7cec-4772-94ce-09c36dcbc721-1742911136274-c0ccf055-5dd5-4d91-80bd-ea1249026dff-mono.wav	19542032799	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
976	326e5cdb-352c-443b-b915-5d144de7d209	13	\N	15	2025-03-25 14:00:24.239	2025-03-25 14:00:50.178	25	https://storage.vapi.ai/326e5cdb-352c-443b-b915-5d144de7d209-1742911252681-af993145-f012-415c-a2f4-a7aada91cc7b-mono.wav	19548995724	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
977	3c268459-1075-4da4-a4b1-77a00f6b108e	13	\N	15	2025-03-25 14:01:39.029	2025-03-25 14:02:53.098	74	https://storage.vapi.ai/3c268459-1075-4da4-a4b1-77a00f6b108e-1742911375602-15398fb0-d043-45fa-95c6-0d25ffab0250-mono.wav	13053848753	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
978	3613571d-229d-4e17-89e8-147fb25c1287	13	\N	15	2025-03-25 13:58:19.347	2025-03-25 14:00:38.218	138	https://storage.vapi.ai/3613571d-229d-4e17-89e8-147fb25c1287-1742911240723-b1e1f8ae-df50-494e-b5cd-6ca16c3d58de-mono.wav	17863265681	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
979	b131c55d-db99-428e-8800-c8a763883fc1	13	\N	15	2025-03-25 14:07:13.252	2025-03-25 14:07:55.173	41	https://storage.vapi.ai/b131c55d-db99-428e-8800-c8a763883fc1-1742911677686-88788a5e-b59b-4f09-b334-4b4343b1b6b2-mono.wav	17862267413	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
980	18eb78cf-b908-460a-b6dd-f49ae42afe13	13	\N	15	2025-03-25 14:13:24.144	2025-03-25 14:13:55.422	31	https://storage.vapi.ai/18eb78cf-b908-460a-b6dd-f49ae42afe13-1742912037926-c6e2dc92-f890-498c-b568-3b6d15133852-mono.wav	19547583242	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
981	dcc84025-0628-425f-9ba3-8afaac98836a	13	\N	15	2025-03-25 14:21:43.349	2025-03-25 14:22:41.8	58	https://storage.vapi.ai/dcc84025-0628-425f-9ba3-8afaac98836a-1742912564325-32aa4e9c-951f-40e8-a05a-a62bff891ead-mono.wav	17864475316	\N	\N	\N	\N	\N	silence-timed-out	\N	\N	\N
982	d9421007-9dcf-41c8-9a33-dc3dd086675f	13	\N	15	2025-03-25 14:50:44.424	2025-03-25 14:51:23.946	39	https://storage.vapi.ai/d9421007-9dcf-41c8-9a33-dc3dd086675f-1742914286450-8eaf476f-ff0e-4a9e-870c-e1f2fa64048f-mono.wav	18134249512	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
983	e7f00fa8-4e01-43b9-808a-10b60fd7984e	13	\N	15	2025-03-25 14:54:25.48	2025-03-25 14:54:49.378	23	https://storage.vapi.ai/e7f00fa8-4e01-43b9-808a-10b60fd7984e-1742914491884-c6a5d81f-b539-4747-84d1-a96c4405db9b-mono.wav	13057668678	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
984	d5e0797e-3462-4dbe-9707-acfd08a81383	13	\N	15	2025-03-25 14:55:29.843	2025-03-25 14:56:04.364	34	https://storage.vapi.ai/d5e0797e-3462-4dbe-9707-acfd08a81383-1742914566869-94144796-dabe-44fd-8312-540737559212-mono.wav	17866892403	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
985	89cc86d5-a008-405e-b298-5a825e50d298	13	\N	15	2025-03-25 15:05:00.748	2025-03-25 15:05:20.543	19	https://storage.vapi.ai/89cc86d5-a008-405e-b298-5a825e50d298-1742915123047-65e2b405-39e5-43bc-b95d-6a5ba5069fdd-mono.wav	17862392736	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
986	f307ab32-a3f0-4ed8-9990-f4e4f55adf10	13	\N	15	2025-03-25 15:13:57.629	2025-03-25 15:14:11.333	13	https://storage.vapi.ai/f307ab32-a3f0-4ed8-9990-f4e4f55adf10-1742915653837-2c760d14-186e-492a-8e1a-daab83f5efef-mono.wav	17863481062	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
987	2e4e8e49-f386-4032-ad73-8bc4c505712d	13	\N	15	2025-03-25 15:14:13.881	2025-03-25 15:14:33.532	19	https://storage.vapi.ai/2e4e8e49-f386-4032-ad73-8bc4c505712d-1742915676037-4fb92c5f-bf57-4c66-a5eb-ab4ab6755588-mono.wav	17863481062	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
988	16f6c263-cbe6-4288-bbc3-d7bce2b2afa7	13	\N	15	2025-03-25 15:23:32.678	2025-03-25 15:24:07.832	35	https://storage.vapi.ai/16f6c263-cbe6-4288-bbc3-d7bce2b2afa7-1742916250336-f10f04da-9e69-4077-b647-b4cd6ff06048-mono.wav	17869351452	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
989	3f5d3ca9-b7d7-4465-a91a-84ffc3efd1be	13	\N	15	2025-03-25 15:29:45.768	2025-03-25 15:30:18.309	32	https://storage.vapi.ai/3f5d3ca9-b7d7-4465-a91a-84ffc3efd1be-1742916620814-a2684f8e-a99b-43b6-8ba0-370c685b2b6e-mono.wav	17863327589	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
990	583b4b4b-f60c-4add-9860-f601db3bdc33	13	\N	15	2025-03-25 15:42:23.488	2025-03-25 15:43:33.311	69	https://storage.vapi.ai/583b4b4b-f60c-4add-9860-f601db3bdc33-1742917415816-cd4b9ff6-6f3b-4595-99c2-bbcc539be6b7-mono.wav	19548319027	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
991	bb655c31-5a52-4aec-81bd-b21ae85d85e8	13	\N	15	2025-03-25 16:14:13.079	2025-03-25 16:15:26.05	72	https://storage.vapi.ai/bb655c31-5a52-4aec-81bd-b21ae85d85e8-1742919328559-0a437311-68ba-41af-b253-629fd22ed102-mono.wav	17862660222	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
992	bba5d8d5-6925-4f7b-ba43-c77a200c0cac	13	\N	15	2025-03-25 16:26:11.575	2025-03-25 16:27:13.565	61	https://storage.vapi.ai/bba5d8d5-6925-4f7b-ba43-c77a200c0cac-1742920036070-8cc8097f-92f3-495d-aa9b-9539f4155d41-mono.wav	16452219866	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
993	a7495c4d-cbeb-4515-a843-3c314f8d7e44	13	\N	15	2025-03-25 16:49:04.815	2025-03-25 16:49:09.518	4	https://storage.vapi.ai/a7495c4d-cbeb-4515-a843-3c314f8d7e44-1742921352019-2ff86aea-7187-4eb5-9d79-724a0dd90b03-mono.wav	17865368283	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
994	99f6eb7e-32a6-43e8-984a-ede200fee1c3	13	\N	15	2025-03-25 16:51:36.583	2025-03-25 16:52:04.356	27	https://storage.vapi.ai/99f6eb7e-32a6-43e8-984a-ede200fee1c3-1742921526860-6ddf95ca-363c-45c1-94d2-1ca7d184f9a5-mono.wav	17865368283	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
995	f4f8a995-cc38-4fd6-bb49-a935e36f4f3d	13	\N	15	2025-03-25 17:10:46.1	2025-03-25 17:11:15.642	29	https://storage.vapi.ai/f4f8a995-cc38-4fd6-bb49-a935e36f4f3d-1742922678145-b5755d1a-4616-4b4e-b38e-7d41718a7b05-mono.wav	17869229955	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
996	f2c34e93-c38d-4694-8c6e-92552c17cc86	13	\N	15	2025-03-25 17:15:05.375	2025-03-25 17:16:09.741	64	https://storage.vapi.ai/f2c34e93-c38d-4694-8c6e-92552c17cc86-1742922972246-61af4501-38d6-49c1-9276-44959251a7d8-mono.wav	13057488234	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
997	8caf099d-4b16-42bc-9f75-d0e2ddb46a06	13	\N	15	2025-03-25 17:19:32.761	2025-03-25 17:19:58.624	25	https://storage.vapi.ai/8caf099d-4b16-42bc-9f75-d0e2ddb46a06-1742923201157-38e30a10-b4d7-471b-b3f2-cf93fdbf7614-mono.wav	17862136477	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
998	4ba32115-38ce-466c-8a95-da85a9bda815	13	\N	15	2025-03-25 15:07:47.725	2025-03-25 15:08:20.973	33	https://storage.vapi.ai/4ba32115-38ce-466c-8a95-da85a9bda815-1742915303477-42ee7a88-1bf8-4e63-8436-37436c7098c0-mono.wav	13015419278	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
999	0e9a2bd5-4dcc-4e63-94b8-456ecc65ff0b	13	\N	15	2025-03-25 15:26:04.333	2025-03-25 15:26:40.012	35	https://storage.vapi.ai/0e9a2bd5-4dcc-4e63-94b8-456ecc65ff0b-1742916402517-68cae7ff-28d3-42c2-868e-b299eee05466-mono.wav	17864319070	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1000	19e022b3-e91c-4614-b71d-7c8525cc1a84	13	\N	15	2025-03-25 17:25:55.308	2025-03-25 17:26:23.971	28	https://storage.vapi.ai/19e022b3-e91c-4614-b71d-7c8525cc1a84-1742923586475-25321bae-8e37-4aca-ab97-af10eb335564-mono.wav	17869351452	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1001	951ce125-e6a2-4422-9d50-6e8a1fbcc83a	13	\N	15	2025-03-25 17:40:25.804	2025-03-25 17:40:43.201	17	https://storage.vapi.ai/951ce125-e6a2-4422-9d50-6e8a1fbcc83a-1742924445705-98e2007b-5852-4699-86c4-ba6422913e4e-mono.wav	17867077789	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
825	fd1f469d-96d3-4c23-ae7f-742221c268b1	11	\N	13	2025-01-18 00:17:58.551	2025-01-18 00:18:32.672	34	https://storage.vapi.ai/fd1f469d-96d3-4c23-ae7f-742221c268b1-1737159515181-204637b0-a9a5-45ad-b04e-34c262fdd358-mono.wav	18885746007	\N	\N	\N	\N	\N	silence-timed-out	\N	\N	\N
826	12d13044-fe3b-460f-89c1-7487f6bca58d	11	\N	13	2025-01-20 22:10:52.027	2025-01-20 22:11:11.062	19	https://storage.vapi.ai/12d13044-fe3b-460f-89c1-7487f6bca58d-1737411073571-c471a6fb-b85e-43a6-bc85-7123ccb5aa09-mono.wav	18885746007	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
827	4ded2407-d9f8-45a7-899d-2c59170dadb3	11	\N	13	2025-01-21 01:18:56.924	2025-01-21 01:19:02.821	5	https://storage.vapi.ai/4ded2407-d9f8-45a7-899d-2c59170dadb3-1737422345324-0742ce56-e997-4ade-8800-fed01a8e4dd4-mono.wav	16016270114	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
1002	44986e2d-9441-4a5f-bc24-357188135cba	13	\N	15	2025-03-25 17:41:05.639	2025-03-25 17:41:46.771	41	https://storage.vapi.ai/44986e2d-9441-4a5f-bc24-357188135cba-1742924509275-26f3f338-18f8-4fd3-9a5a-a4cf96e67710-mono.wav	17867077789	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1003	95356a49-8343-4e1e-9d8f-1c41808ae192	13	\N	15	2025-03-25 17:48:31.327	2025-03-25 17:49:00.762	29	https://storage.vapi.ai/95356a49-8343-4e1e-9d8f-1c41808ae192-1742924943280-9570ad03-fedf-47db-91db-2fd501896466-mono.wav	17863338756	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1004	84887f4a-8b41-4c61-b7ea-c08cedb67c44	13	\N	15	2025-03-25 17:57:50.906	2025-03-25 17:58:03.119	12	https://storage.vapi.ai/84887f4a-8b41-4c61-b7ea-c08cedb67c44-1742925485624-19221933-25c2-485f-ab9f-a7ebe238979e-mono.wav	19542032387	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1005	965b33ee-f3fc-4a89-ad0b-02208a4c3aa7	13	\N	15	2025-03-25 17:59:06.304	2025-03-25 17:59:46.738	40	https://storage.vapi.ai/965b33ee-f3fc-4a89-ad0b-02208a4c3aa7-1742925589242-2f6b3c54-a093-49d8-9795-a4a192052780-mono.wav	13868982127	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1006	5001ff9d-2dc1-466b-a08d-e1959fc6c538	13	\N	15	2025-03-25 18:06:26.193	2025-03-25 18:06:56.97	30	https://storage.vapi.ai/5001ff9d-2dc1-466b-a08d-e1959fc6c538-1742926019474-62f850ca-97c6-4712-865a-6f3756da2ea2-mono.wav	13058348692	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1007	febedc31-6a6e-4ed9-bfc9-eb70bb82f93f	13	\N	15	2025-03-25 18:10:37.952	2025-03-25 18:10:42.323	4	https://storage.vapi.ai/febedc31-6a6e-4ed9-bfc9-eb70bb82f93f-1742926244824-c79da837-3e40-44e1-a28c-58aa2cc033cf-mono.wav	13868982127	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
1008	6842c9af-7ea5-440b-83da-ae0d0a0419be	13	\N	15	2025-03-25 18:19:34.322	2025-03-25 18:19:59.665	25	https://storage.vapi.ai/6842c9af-7ea5-440b-83da-ae0d0a0419be-1742926802171-8fb5e29c-a8d9-4c4d-b71c-1910263cf554-mono.wav	13059028694	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1021	d8d468d1-6571-4179-8d65-2a9e64e9d894	13	\N	15	2025-03-25 18:50:20.429	2025-03-25 18:50:41.722	21	https://storage.vapi.ai/d8d468d1-6571-4179-8d65-2a9e64e9d894-1742928644227-f34064eb-df06-41f8-a1b0-d2280c6459cb-mono.wav	13056008361	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1022	8c990d88-0eb2-4390-b2d3-dcb8e6389a9a	13	\N	15	2025-03-25 18:57:12.531	2025-03-25 18:58:01.732	49	https://storage.vapi.ai/8c990d88-0eb2-4390-b2d3-dcb8e6389a9a-1742929084255-5ff94519-8831-410f-bc7a-2317447c65b1-mono.wav	17866679268	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1023	1e135eac-352f-466b-8929-a7a598e1f685	13	\N	15	2025-03-25 18:58:53.463	2025-03-25 18:59:19.999	26	https://storage.vapi.ai/1e135eac-352f-466b-8929-a7a598e1f685-1742929162505-c70e79fc-071a-4609-9ea6-9c149f1c1607-mono.wav	17542048349	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
824	95688f4f-7f46-4493-93c3-42fc172a2008	11	\N	13	2025-01-16 17:20:47.617	2025-01-16 17:23:43.374	175	https://storage.vapi.ai/95688f4f-7f46-4493-93c3-42fc172a2008-1737048225887-97378bed-50e0-40b6-87f1-c12b4d448895-mono.wav	14153761745	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
1024	b93cef81-3179-471c-a902-b785da9d6bf4	13	\N	15	2025-03-25 18:59:23.365	2025-03-25 18:59:41.651	18	https://storage.vapi.ai/b93cef81-3179-471c-a902-b785da9d6bf4-1742929184157-29ec9259-845e-4cba-b8bc-ee2e53ead022-mono.wav	17542048349	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1025	ac30fe94-14bc-4bc3-a89f-7ef07467f825	13	\N	15	2025-03-25 17:13:52.138	2025-03-25 17:14:58.27	66	https://storage.vapi.ai/ac30fe94-14bc-4bc3-a89f-7ef07467f825-1742922900776-2bfee947-1381-49e4-aa85-b17a971966cc-mono.wav	18133712782	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1026	288321c2-21dc-4c69-a7e1-c0443d1b2ece	13	\N	15	2025-03-25 19:01:28.815	2025-03-25 19:01:56.278	27	https://storage.vapi.ai/288321c2-21dc-4c69-a7e1-c0443d1b2ece-1742929318782-eb095400-ae58-425e-94b9-7613c92f48fd-mono.wav	17542048349	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1027	88000545-66f2-455c-bfc4-5325b6de8850	13	\N	15	2025-03-25 19:07:28.135	2025-03-25 19:07:47.331	19	https://storage.vapi.ai/88000545-66f2-455c-bfc4-5325b6de8850-1742929669852-a1f5cd43-8674-4947-a830-b0b5b473578d-mono.wav	17869421807	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1028	76b782f2-5cfc-4458-8c5b-78f5c569615a	13	\N	15	2025-03-25 19:07:35.593	2025-03-25 19:07:53.335	17	https://storage.vapi.ai/76b782f2-5cfc-4458-8c5b-78f5c569615a-1742929675839-58659ee1-0849-4431-b293-6f2408e6f341-mono.wav	13054971186	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
1029	2cc33649-0058-4bb5-9118-11b4d5d142cf	13	\N	15	2025-03-25 19:09:20.576	2025-03-25 19:09:54.821	34	https://storage.vapi.ai/2cc33649-0058-4bb5-9118-11b4d5d142cf-1742929797326-887e6fc1-5c73-4021-8aa6-63fe1544fd53-mono.wav	13054971186	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1030	51c7d15c-e391-4f69-87cd-5b6ae53ae211	13	\N	15	2025-03-25 19:23:24.245	2025-03-25 19:23:59.572	35	https://storage.vapi.ai/51c7d15c-e391-4f69-87cd-5b6ae53ae211-1742930642076-f8339f73-82de-4f7f-b38e-ab75d715e854-mono.wav	17869733692	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1031	bece5e57-0189-4a65-bc0e-263096e9d6a2	13	\N	15	2025-03-25 19:25:38.727	2025-03-25 19:26:20.175	41	https://storage.vapi.ai/bece5e57-0189-4a65-bc0e-263096e9d6a2-1742930782688-dd5814d3-0160-4724-89d2-a7fca783d6ca-mono.wav	13056740654	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
1032	e0022f36-3fe4-46e5-8697-69cca637e229	13	\N	15	2025-03-25 19:29:36.415	2025-03-25 19:29:49.111	12	https://storage.vapi.ai/e0022f36-3fe4-46e5-8697-69cca637e229-1742930991616-f2268e30-605e-4cbf-9267-9f5cdd80f801-mono.wav	17869733692	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1033	d018e42a-28a5-4737-8fce-07ca3df2bb63	13	\N	15	2025-03-25 19:32:57.019	2025-03-25 19:33:36.438	39	https://storage.vapi.ai/d018e42a-28a5-4737-8fce-07ca3df2bb63-1742931218952-631d1b53-e10c-486c-bf89-c5d8d3e7da67-mono.wav	13053008448	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1034	8af8effd-4cae-426a-8b12-fd510259c53a	13	\N	15	2025-03-25 19:42:22.434	2025-03-25 19:42:45.274	22	https://storage.vapi.ai/8af8effd-4cae-426a-8b12-fd510259c53a-1742931767778-0bfbd579-bbff-4cbd-a1e2-64614a1765f2-mono.wav	13053330891	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1035	2ba6e087-0f04-4384-9fa3-9d97333fdcaf	13	\N	15	2025-03-25 19:45:03.823	2025-03-25 19:45:08.723	4	https://storage.vapi.ai/2ba6e087-0f04-4384-9fa3-9d97333fdcaf-1742931911223-519f0139-6a6a-49fa-ae86-6ae89ada4afe-mono.wav	19549881862	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
1036	563ec7e1-a6a8-446b-89fe-cc4e754b9cd6	13	\N	15	2025-03-25 19:44:48.561	2025-03-25 19:45:34.656	46	https://storage.vapi.ai/563ec7e1-a6a8-446b-89fe-cc4e754b9cd6-1742931937160-b58ee88e-cf70-4bd0-838e-44eba79463e1-mono.wav	16452215593	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1037	5802c9e9-760b-44d9-aa1e-6bbc975e093e	13	\N	15	2025-03-25 19:50:13.241	2025-03-25 19:50:48.97	35	https://storage.vapi.ai/5802c9e9-760b-44d9-aa1e-6bbc975e093e-1742932251475-b331bad3-2939-4e3c-aa50-e7f80d144265-mono.wav	16452237856	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1038	52d119c6-9879-41d0-bbe1-a5455a64ce05	13	\N	15	2025-03-25 19:51:35.089	2025-03-25 19:52:02.904	27	https://storage.vapi.ai/52d119c6-9879-41d0-bbe1-a5455a64ce05-1742932325424-81c14d19-2af6-4b90-ab48-beaf27f8f017-mono.wav	17862034356	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1039	96b09c85-531c-4f4b-8dbb-e93d866f241d	13	\N	15	2025-03-25 20:03:54.717	2025-03-25 20:05:07.757	73	https://storage.vapi.ai/96b09c85-531c-4f4b-8dbb-e93d866f241d-1742933110261-fa2203d5-4bea-4c3e-9ff9-a0bbfaf8afaf-mono.wav	17862677446	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1040	f9f632d4-d5ee-4397-b446-278ec16155a3	13	\N	15	2025-03-25 20:07:04.03	2025-03-25 20:07:44.105	40	https://storage.vapi.ai/f9f632d4-d5ee-4397-b446-278ec16155a3-1742933266608-2fb23011-c0fe-40b8-8ea8-d0b78ae73b21-mono.wav	17868574751	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1041	26b2b057-629f-46f4-98b1-fb3cbcd128e1	13	\N	15	2025-03-25 20:11:54.597	2025-03-25 20:12:19.509	24	https://storage.vapi.ai/26b2b057-629f-46f4-98b1-fb3cbcd128e1-1742933542027-c0f4f283-898f-49b6-a190-6697469a0ec9-mono.wav	17864161876	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1042	43f23b74-2eaf-40bc-a52a-1b300b3d9ec9	13	\N	15	2025-03-25 20:14:06.4	2025-03-25 20:14:38.297	31	https://storage.vapi.ai/43f23b74-2eaf-40bc-a52a-1b300b3d9ec9-1742933680802-11f0447c-bdfb-4cb7-958d-f840cc4fd67b-mono.wav	17542044014	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1043	9ade35ae-de75-4603-b6c1-cf0b642e491d	13	\N	15	2025-03-25 20:24:42.789	2025-03-25 20:25:03.792	21	https://storage.vapi.ai/9ade35ae-de75-4603-b6c1-cf0b642e491d-1742934306301-3ac097df-876f-4258-bfe1-56aeb75995f3-mono.wav	17869351452	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1044	3543e651-ae19-400a-8949-d1031ea40654	13	\N	15	2025-03-25 20:26:06.167	2025-03-25 20:26:26.141	19	https://storage.vapi.ai/3543e651-ae19-400a-8949-d1031ea40654-1742934388649-c464afca-094f-4071-85ff-27593ce0a1b5-mono.wav	17867317191	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1045	e65d73b3-0894-42c2-b3a4-f6b7597162f1	13	\N	15	2025-03-25 20:26:08.37	2025-03-25 20:26:28.235	19	https://storage.vapi.ai/e65d73b3-0894-42c2-b3a4-f6b7597162f1-1742934390749-76403d5d-074d-4312-81b2-8474be0b57c4-mono.wav	13057336333	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1046	e3bcd1da-b937-4581-b52f-f581a5ea49bf	13	\N	15	2025-03-25 20:30:26.546	2025-03-25 20:30:55.044	28	https://storage.vapi.ai/e3bcd1da-b937-4581-b52f-f581a5ea49bf-1742934657553-81492639-a0cb-4d95-89a0-747c903e5fbb-mono.wav	17862186047	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1047	9ed7bc4d-be18-4a91-a212-e7452ee591ba	13	\N	15	2025-03-25 20:34:20.217	2025-03-25 20:35:05.846	45	https://storage.vapi.ai/9ed7bc4d-be18-4a91-a212-e7452ee591ba-1742934908352-eedd8182-0274-4e5a-b19c-3520a9bfc459-mono.wav	17862177049	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
1048	5a374a04-bec1-4972-8f06-6638530f2a01	13	\N	15	2025-03-25 20:35:10.188	2025-03-25 20:35:25.637	15	https://storage.vapi.ai/5a374a04-bec1-4972-8f06-6638530f2a01-1742934928156-4a61b27c-1039-4d30-a365-c5cc43c69b31-mono.wav	17862177049	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
1049	d4cc3526-353f-42d7-a4f1-eadf04a6fdde	13	\N	15	2025-03-25 20:36:02.693	2025-03-25 20:36:10.905	8	https://storage.vapi.ai/d4cc3526-353f-42d7-a4f1-eadf04a6fdde-1742934973407-b3f31faf-535c-4519-a3c0-6757e8f92e79-mono.wav	17862177049	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
1050	1ffb206c-6731-4cf5-9a73-e066c96cd9c5	13	\N	15	2025-03-25 20:35:35.765	2025-03-25 20:35:59.322	23	https://storage.vapi.ai/1ffb206c-6731-4cf5-9a73-e066c96cd9c5-1742934961827-2f4f1c70-1c54-40b1-986d-89b57de9e984-mono.wav	17862177049	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
1051	564e98f8-a6ba-47b2-a99d-0d202e113bd3	13	\N	15	2025-03-25 20:37:28.531	2025-03-25 20:37:55.879	27	https://storage.vapi.ai/564e98f8-a6ba-47b2-a99d-0d202e113bd3-1742935078383-116db637-764b-4e1e-ab37-c568f251ed81-mono.wav	17862671275	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1052	b3af7461-684a-4935-a48c-87d3aab8671e	13	\N	15	2025-03-25 20:38:09.882	2025-03-25 20:38:45.48	35	https://storage.vapi.ai/b3af7461-684a-4935-a48c-87d3aab8671e-1742935127991-8506c3ef-5d02-4601-a8de-807bce47d826-mono.wav	17862177049	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1053	53109e35-9916-4647-8250-99ec4447ce96	13	\N	15	2025-03-25 20:54:30.976	2025-03-25 20:55:08.65	37	https://storage.vapi.ai/53109e35-9916-4647-8250-99ec4447ce96-1742936111154-15337142-eafb-448b-b1fa-422ad30069b9-mono.wav	17176787751	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1054	5c697ebe-dc93-47b4-a34a-775ec623db61	13	\N	15	2025-03-25 21:18:17.279	2025-03-25 21:19:05.522	48	https://storage.vapi.ai/5c697ebe-dc93-47b4-a34a-775ec623db61-1742937548027-0196112b-298d-4760-b075-ad99590be3b3-mono.wav	17866068957	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1055	670080ce-7dce-40cb-b6ec-52fffbd03dc8	13	\N	15	2025-03-25 21:22:36.168	2025-03-25 21:22:55.994	19	https://storage.vapi.ai/670080ce-7dce-40cb-b6ec-52fffbd03dc8-1742937778498-faaa0e06-1bf4-4b18-a855-a89eda06c9ba-mono.wav	17866358426	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1056	21ccf1ff-d1d4-42a9-8fb6-3763f73451d3	13	\N	15	2025-03-25 21:42:35.553	2025-03-25 21:43:07.919	32	https://storage.vapi.ai/21ccf1ff-d1d4-42a9-8fb6-3763f73451d3-1742938990424-d1b6f330-63d6-4331-ae53-04c09837c840-mono.wav	13054956568	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1057	ac3d61af-3ebb-4f20-ac38-4a4748ea1b64	13	\N	15	2025-03-26 12:23:43.316	2025-03-26 12:24:30.138	46	https://storage.vapi.ai/ac3d61af-3ebb-4f20-ac38-4a4748ea1b64-1742991872659-c278610d-d10e-463a-bb89-04d80db76eef-mono.wav	16452230494	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1058	a6c3e0d6-be01-4b3b-b2c9-cf8dbdf9114c	13	\N	15	2025-03-26 12:41:07.54	2025-03-26 12:41:51.5	43	https://storage.vapi.ai/a6c3e0d6-be01-4b3b-b2c9-cf8dbdf9114c-1742992914055-51c85f5a-da91-4523-8369-7764592c272c-mono.wav	17863396480	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1059	5095d280-47da-4505-94b2-63f88b675042	13	\N	15	2025-03-26 12:52:30.806	2025-03-26 12:53:03.857	33	https://storage.vapi.ai/5095d280-47da-4505-94b2-63f88b675042-1742993586360-57f20027-a0cc-4ff1-a8c0-459d3fabcdd8-mono.wav	17862184820	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1060	6b01206e-122c-43f3-8cfa-afceaf8ab12f	13	\N	15	2025-03-26 12:58:44.201	2025-03-26 12:59:07.116	22	https://storage.vapi.ai/6b01206e-122c-43f3-8cfa-afceaf8ab12f-1742993949621-adf63cbe-5fc6-4ce8-8031-b77d649d785b-mono.wav	17865360718	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1061	a6a2db27-76f7-4196-ae35-f3b20339dc17	13	\N	15	2025-03-26 13:07:19.941	2025-03-26 13:07:56.332	36	https://storage.vapi.ai/a6a2db27-76f7-4196-ae35-f3b20339dc17-1742994478838-3262d4ff-9c21-4937-976c-995fbca4b495-mono.wav	17865570654	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1062	8d58340a-80d0-4b4b-b3fd-bb57fe5bfe0b	13	\N	15	2025-03-26 13:08:18.351	2025-03-26 13:08:45.804	27	https://storage.vapi.ai/8d58340a-80d0-4b4b-b3fd-bb57fe5bfe0b-1742994528328-ce16e8f2-704f-4776-8a12-61833ff92ae2-mono.wav	17866241607	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1063	68704373-0666-43e0-ba61-9187600ca157	13	\N	15	2025-03-26 13:19:44.664	2025-03-26 13:20:13.328	28	https://storage.vapi.ai/68704373-0666-43e0-ba61-9187600ca157-1742995215834-5377d2b8-6927-441f-a646-6d033e6c49d8-mono.wav	17862034356	\N	\N	\N	\N	\N	assistant-forwarded-call	\N	\N	\N
1064	57f9eafb-2dca-41d0-8e06-f8baf08b2ee0	13	\N	15	2025-03-26 13:21:43.845	2025-03-26 13:21:47.299	3	https://storage.vapi.ai/57f9eafb-2dca-41d0-8e06-f8baf08b2ee0-1742995309800-18d1aab7-d4dc-49cb-97e1-f3e97fef46c7-mono.wav	17867078595	\N	\N	\N	\N	\N	customer-ended-call	\N	\N	\N
\.


--
-- Data for Name: Company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Company" (id, name) FROM stdin;
8	Clinic A - Comprehensive LLM Data
9	Clinic B - QA Evaluations
10	Clinic C - Basic Evaluations
11	Clinic
12	Clinic - Clinic B Data
13	Clinic - Clinic A Data
\.


--
-- Data for Name: HumanEvaluation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."HumanEvaluation" (id, "callId", "evaluatorId", "timestamp", overall_score, politeness_score, resolution_status, accuracy_rating, clarity_score, empathy_score, adherence_to_script, problem_solved, overall_comment, status) FROM stdin;
342	824	164	2025-05-24 03:02:16.8	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
343	825	164	2025-05-24 03:02:17.413	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
344	826	164	2025-05-24 03:02:17.935	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
345	827	164	2025-05-24 03:02:18.37	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
346	828	164	2025-05-24 03:02:18.816	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
347	829	164	2025-05-24 03:02:19.345	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
348	830	164	2025-05-24 03:02:19.867	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
349	831	164	2025-05-24 03:02:20.392	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
350	832	164	2025-05-24 03:02:20.824	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
351	833	164	2025-05-24 03:02:21.371	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
352	834	164	2025-05-24 03:02:21.906	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
353	835	164	2025-05-24 03:02:22.437	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
354	836	164	2025-05-24 03:02:22.87	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
355	837	164	2025-05-24 03:02:23.397	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
356	838	164	2025-05-24 03:02:23.919	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
357	839	164	2025-05-24 03:02:24.447	\N	\N	\N	true	\N	\N	\N	t	Llamada de una AI	QA Done
358	840	164	2025-05-24 03:02:24.967	\N	\N	\N	false	\N	\N	\N	f		QA Done
359	841	164	2025-05-24 03:02:25.496	\N	\N	\N	false	\N	\N	\N	f	Llamada para GGHT	QA Done
360	842	164	2025-05-24 03:02:26.018	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
361	843	164	2025-05-24 03:02:26.573	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
362	844	164	2025-05-24 03:02:27.101	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
363	845	164	2025-05-24 03:02:27.629	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
364	846	164	2025-05-24 03:02:28.161	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
365	847	164	2025-05-24 03:02:28.725	\N	\N	\N	false	\N	\N	\N	f	Annie dijo que no aceptamos UHC	QA Done
366	848	164	2025-05-24 03:02:29.256	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
367	849	164	2025-05-24 03:02:29.778	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
368	850	164	2025-05-24 03:02:30.205	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
369	851	164	2025-05-24 03:02:30.808	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
370	852	164	2025-05-24 03:02:31.328	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
371	853	164	2025-05-24 03:02:31.856	\N	\N	\N	true	\N	\N	\N	t	La pregunta que la chica hizo (if an autism spectrum diagnosis is required) se le puede preguntar al staff  para que podamos responderla en otra llamada futura	QA Done
372	854	164	2025-05-24 03:02:32.386	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
373	855	164	2025-05-24 03:02:32.911	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
374	856	164	2025-05-24 03:02:33.343	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
375	857	164	2025-05-24 03:02:33.882	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
376	858	164	2025-05-24 03:02:34.411	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
377	859	164	2025-05-24 03:02:34.931	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
378	860	164	2025-05-24 03:02:35.452	\N	\N	\N	true	\N	\N	\N	t	La persona queria saber si necesitaba un referral aun pagando out of pocket. Esto podemos preguntarlo a la clinica para poder responderlo y asi no tener que transferirla. Creeria que no lo necesita ya que esta pagando on her own	QA Done
379	861	164	2025-05-24 03:02:35.983	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
380	862	164	2025-05-24 03:02:36.431	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
381	863	164	2025-05-24 03:02:36.964	\N	\N	\N	false	\N	\N	\N	f	La persona queria saber cual es la disponibilidad o lista de espera por ABA services. Annie pudo decir aqui. "We do not have a waitlist. Services can typically begin within 2 to 3 weeks after receiving authorization from your insurance provider"	QA Done
382	864	164	2025-05-24 03:02:37.404	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
383	865	164	2025-05-24 03:02:37.833	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
384	866	164	2025-05-24 03:02:38.281	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
385	867	164	2025-05-24 03:02:38.719	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
386	868	164	2025-05-24 03:02:39.164	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
387	869	164	2025-05-24 03:02:39.681	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
388	870	164	2025-05-24 03:02:40.196	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
389	871	164	2025-05-24 03:02:40.716	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
390	872	164	2025-05-24 03:02:41.167	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
391	873	164	2025-05-24 03:02:41.631	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
392	874	164	2025-05-24 03:02:42.076	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
393	875	164	2025-05-24 03:02:42.556	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
394	876	164	2025-05-24 03:02:43.082	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
395	877	164	2025-05-24 03:02:43.606	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
396	878	164	2025-05-24 03:02:44.137	\N	\N	\N	false	\N	\N	\N	f	La persona respondió que esta llamando on behalf of someone else y Annie no dijo nada se quedó callada y no la ayudó ni continuó. La llamada terminó después de eso. Hubo silencio. Annie deberia pedir que repita o si pude confirmar para poder seguir con la llamada. 	QA Done
397	879	164	2025-05-24 03:02:44.937	\N	\N	\N	false	\N	\N	\N	f	Las direcciones las deberia decir mas organizado ya que como las dice no se entiende, debe ser mas clara. Algo como tenemos dos locaciones una esta en Warrenton at 5306... y la otra esta en Fairfax y asi. Annie no ofreció transferir al paciente para ver si desde el front desk lo ayudaban con su request de "directory"	QA Done
398	880	164	2025-05-24 03:02:45.38	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
399	881	164	2025-05-24 03:02:45.918	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
400	882	164	2025-05-24 03:02:46.473	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
401	883	164	2025-05-24 03:02:47.007	\N	\N	\N	true	\N	\N	\N	t	Puede Annie preguntar en cual location esta la persona y proveerle con especificaciones en vez de transferirla? Podriamos preguntarle las especificaciones al cliente para que los pacientes puedan llegar sin problema a la locacion. 	QA Done
402	884	164	2025-05-24 03:02:47.533	\N	\N	\N	true	\N	\N	\N	t	La llamada se cortó	QA Done
403	885	164	2025-05-24 03:02:47.966	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
404	886	164	2025-05-24 03:02:48.493	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
405	887	164	2025-05-24 03:02:49.018	\N	\N	\N	false	\N	\N	\N	f	La persona preguntó si teniamos una wait list y Annie no dió respuesta. The AI deberia decir lo siguiente cuando pregunten eso "No, we are currently accepting clients without any waiting period."	QA Done
406	888	164	2025-05-24 03:02:49.554	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
407	889	164	2025-05-24 03:02:50.081	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
408	890	164	2025-05-24 03:02:50.597	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
409	891	164	2025-05-24 03:02:51.031	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
410	892	164	2025-05-24 03:02:51.582	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
411	893	164	2025-05-24 03:02:52.156	\N	\N	\N	true	\N	\N	\N	t	Its a recording. Call from Walmart. 	QA Done
412	894	164	2025-05-24 03:02:52.682	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
413	895	164	2025-05-24 03:02:53.198	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
414	896	164	2025-05-24 03:02:53.735	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
495	977	165	2025-05-24 03:24:02.797	\N	\N	\N	Fail	\N	\N	\N	\N	Transcriber Problem, not much to do	Transcriber
415	897	164	2025-05-24 03:02:54.265	\N	\N	\N	false	\N	\N	\N	f	La persona dijo que nosotros la llamamos y Annie no ofreció transferirla al front desk para que la ayudaran y asi saber porque la llamamos sino que mas bien dijo que tal vez fue un error y que ella podia ayudar sobre autism, developmental delays or behavior therapy	QA Done
416	898	164	2025-05-24 03:02:54.789	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
417	899	164	2025-05-24 03:02:55.316	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
418	900	164	2025-05-24 03:02:55.842	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
419	901	164	2025-05-24 03:02:56.299	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
420	902	164	2025-05-24 03:02:56.827	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
421	903	164	2025-05-24 03:02:57.361	\N	\N	\N	true	\N	\N	\N	t	N/A	QA Done
422	904	165	2025-05-24 03:23:23.426	\N	\N	\N		\N	\N	\N	\N		Done
423	905	166	2025-05-24 03:23:24.132	\N	\N	\N		\N	\N	\N	\N		Done
424	906	166	2025-05-24 03:23:24.672	\N	\N	\N		\N	\N	\N	\N		Done
425	907	166	2025-05-24 03:23:25.191	\N	\N	\N		\N	\N	\N	\N	Jorge was calling on behalf ot the insurance and seems to be confused. I think we need to incorporate a use case when the insurance agent is calling on behalf of the client	Done
426	908	165	2025-05-24 03:23:25.705	\N	\N	\N		\N	\N	\N	\N		Done
427	909	165	2025-05-24 03:23:26.251	\N	\N	\N		\N	\N	\N	\N		Done
428	910	165	2025-05-24 03:23:26.783	\N	\N	\N		\N	\N	\N	\N	Jorge was calling on behalf ot the insurance and seems to be confused. I think we need to incorporate a use case when the insurance agent is calling on behalf of the client	Done
429	911	166	2025-05-24 03:23:27.316	\N	\N	\N		\N	\N	\N	\N	Vapi doesn't answer and communication is difficult. I think vapi was down for quite some time	Done
430	912	165	2025-05-24 03:23:27.823	\N	\N	\N		\N	\N	\N	\N		Done
431	913	165	2025-05-24 03:23:28.328	\N	\N	\N		\N	\N	\N	\N		Done
432	914	165	2025-05-24 03:23:28.856	\N	\N	\N		\N	\N	\N	\N		Done
433	915	166	2025-05-24 03:23:29.38	\N	\N	\N		\N	\N	\N	\N	We need to be able to provide the address of the clinic. In this case, transferring the call is not that useful	Done
434	916	165	2025-05-24 03:23:29.911	\N	\N	\N		\N	\N	\N	\N		Done
435	917	165	2025-05-24 03:23:30.432	\N	\N	\N		\N	\N	\N	\N		Done
436	918	166	2025-05-24 03:23:30.935	\N	\N	\N		\N	\N	\N	\N	PHONE number is not showing up here	Done
437	919	165	2025-05-24 03:23:31.447	\N	\N	\N		\N	\N	\N	\N		Done
438	920	165	2025-05-24 03:23:31.979	\N	\N	\N		\N	\N	\N	\N		Done
439	921	165	2025-05-24 03:23:32.511	\N	\N	\N		\N	\N	\N	\N		Done
440	922	165	2025-05-24 03:23:33.018	\N	\N	\N		\N	\N	\N	\N		Done
441	923	165	2025-05-24 03:23:33.529	\N	\N	\N		\N	\N	\N	\N		Done
442	924	165	2025-05-24 03:23:34.044	\N	\N	\N		\N	\N	\N	\N		Done
443	925	165	2025-05-24 03:23:34.594	\N	\N	\N		\N	\N	\N	\N		Done
444	926	165	2025-05-24 03:23:35.109	\N	\N	\N		\N	\N	\N	\N		Done
445	927	165	2025-05-24 03:23:35.628	\N	\N	\N		\N	\N	\N	\N		Done
446	928	165	2025-05-24 03:23:36.142	\N	\N	\N		\N	\N	\N	\N		Done
447	929	165	2025-05-24 03:23:36.688	\N	\N	\N		\N	\N	\N	\N		Done
448	930	165	2025-05-24 03:23:37.22	\N	\N	\N		\N	\N	\N	\N		Done
449	931	165	2025-05-24 03:23:37.732	\N	\N	\N		\N	\N	\N	\N		Done
450	932	165	2025-05-24 03:23:38.239	\N	\N	\N		\N	\N	\N	\N		Done
451	933	165	2025-05-24 03:23:38.842	\N	\N	\N		\N	\N	\N	\N		Done
452	934	165	2025-05-24 03:23:39.391	\N	\N	\N		\N	\N	\N	\N		Done
453	935	166	2025-05-24 03:23:39.9	\N	\N	\N		\N	\N	\N	\N	If the service is not treated at the GGHT clinic, we would not need to transfer the call. At first, it was correct, but then it didn't provide the correct response	Done
454	936	165	2025-05-24 03:23:40.413	\N	\N	\N		\N	\N	\N	\N		Done
455	937	165	2025-05-24 03:23:40.935	\N	\N	\N		\N	\N	\N	\N		Done
456	938	165	2025-05-24 03:23:41.446	\N	\N	\N		\N	\N	\N	\N		Done
457	939	165	2025-05-24 03:23:41.976	\N	\N	\N		\N	\N	\N	\N		Done
458	940	166	2025-05-24 03:23:42.512	\N	\N	\N		\N	\N	\N	\N	PI Links no la aceptamos, no deberíamos transferir esa llamada	Done
459	941	166	2025-05-24 03:23:43.022	\N	\N	\N		\N	\N	\N	\N	No tomo bien el nombre, también cuando dijo workers compensation, debería de preguntarle qué tipo de aseguradora   	Done
460	942	165	2025-05-24 03:23:43.529	\N	\N	\N		\N	\N	\N	\N		Done
461	943	165	2025-05-24 03:23:44.054	\N	\N	\N		\N	\N	\N	\N		Done
462	944	165	2025-05-24 03:23:44.58	\N	\N	\N		\N	\N	\N	\N		Done
463	945	165	2025-05-24 03:23:45.094	\N	\N	\N		\N	\N	\N	\N		Done
464	946	166	2025-05-24 03:23:45.611	\N	\N	\N		\N	\N	\N	\N	Loop the new client, no entendió. La persona dijo claramente que era new client y de ahí le pregunto si quería re-schedule o cancel	Done
465	947	165	2025-05-24 03:23:46.121	\N	\N	\N		\N	\N	\N	\N		Done
466	948	165	2025-05-24 03:23:46.64	\N	\N	\N		\N	\N	\N	\N		Done
467	949	166	2025-05-24 03:23:47.165	\N	\N	\N		\N	\N	\N	\N	FAX NUMBER WAS CORRECT IN THE KNOWLEDGE BASE, BUT the agent gave an incorrect FAX NUMBER	Done
468	950	165	2025-05-24 03:23:47.695	\N	\N	\N		\N	\N	\N	\N		Done
469	951	165	2025-05-24 03:23:48.207	\N	\N	\N		\N	\N	\N	\N		Done
470	952	165	2025-05-24 03:23:48.726	\N	\N	\N		\N	\N	\N	\N		Done
471	953	165	2025-05-24 03:23:49.244	\N	\N	\N		\N	\N	\N	\N		Done
472	954	165	2025-05-24 03:23:49.779	\N	\N	\N		\N	\N	\N	\N		Done
473	955	164	2025-05-24 03:23:50.287	\N	\N	\N		\N	\N	\N	\N		Done
474	956	166	2025-05-24 03:23:50.792	\N	\N	\N		\N	\N	\N	\N	Annie transfer inmediately without asking any information or clarifying the request.	Done
475	957	167	2025-05-24 03:23:51.395	\N	\N	\N		\N	\N	\N	\N	Annie transfer inmediately without asking any information or clarifying the request. In this case, we should say the email for handling all the request through email. 	Done
476	958	167	2025-05-24 03:23:51.95	\N	\N	\N		\N	\N	\N	\N	It says one moment please, two times, sounds weird. In this case, we should say the email for handling all the request through email. 	Feedback Not clear
477	959	167	2025-05-24 03:23:52.546	\N	\N	\N		\N	\N	\N	\N		NA
478	960	166	2025-05-24 03:23:53.059	\N	\N	\N		\N	\N	\N	\N	Annie didn't understood the type of insurance. Transferred the call inmediately without clarifying, didn't transfer the call and say weird things	Done
479	961	167	2025-05-24 03:23:53.658	\N	\N	\N		\N	\N	\N	\N		NA
480	962	166	2025-05-24 03:23:54.181	\N	\N	\N		\N	\N	\N	\N	Annie didn't transfer the call to the billing department	Done
481	963	166	2025-05-24 03:23:54.716	\N	\N	\N		\N	\N	\N	\N	Annie got cut off in the middle of words, repeated one moment please really weird	Done
482	964	167	2025-05-24 03:23:55.236	\N	\N	\N		\N	\N	\N	\N		NA
483	965	165	2025-05-24 03:23:56.69	\N	\N	\N	Pass	\N	\N	\N	\N		\N
484	966	165	2025-05-24 03:23:57.212	\N	\N	\N	Pass	\N	\N	\N	\N		\N
485	967	165	2025-05-24 03:23:57.733	\N	\N	\N	Pass	\N	\N	\N	\N		\N
486	968	165	2025-05-24 03:23:58.24	\N	\N	\N	Pass	\N	\N	\N	\N		\N
487	969	165	2025-05-24 03:23:58.761	\N	\N	\N	Pass	\N	\N	\N	\N		\N
488	970	165	2025-05-24 03:23:59.286	\N	\N	\N	Pass	\N	\N	\N	\N		\N
489	971	165	2025-05-24 03:23:59.823	\N	\N	\N	Pass	\N	\N	\N	\N	Está llamada en verdad no fue un general request, El evaluation se equivoco, aunque dio un mal score, lo cual es bueno. El agent debio haber pedido clarificación sobre Da	Transcriber
490	972	165	2025-05-24 03:24:00.339	\N	\N	\N	Pass	\N	\N	\N	\N		\N
491	973	165	2025-05-24 03:24:00.768	\N	\N	\N	Pass	\N	\N	\N	\N		\N
492	974	165	2025-05-24 03:24:01.201	\N	\N	\N	Pass	\N	\N	\N	\N		\N
493	975	165	2025-05-24 03:24:01.747	\N	\N	\N	Pass	\N	\N	\N	\N	La persona No queria hablar con AI, estaba gritandole a otra persona y no quiso clarificar lo que quería, Pienso que no pudimos hacer mucho más, Lo unico es usar una voz menos robotica	Don't want AI
494	976	165	2025-05-24 03:24:02.279	\N	\N	\N	Pass	\N	\N	\N	\N		\N
496	978	165	2025-05-24 03:24:03.308	\N	\N	\N	Fail	\N	\N	\N	\N	Transcriber, Vapi and Interruption problems, also it's hard to understand the person. Not much to do	Transcriber
497	979	165	2025-05-24 03:24:03.828	\N	\N	\N	Pass	\N	\N	\N	\N		\N
498	980	165	2025-05-24 03:24:04.356	\N	\N	\N	Pass	\N	\N	\N	\N		\N
499	981	165	2025-05-24 03:24:04.886	\N	\N	\N	Fail	\N	\N	\N	\N	Either the customer Hang up or Vapi just end the call for no reason	Vapi
500	982	165	2025-05-24 03:24:05.396	\N	\N	\N	Pass	\N	\N	\N	\N		\N
501	983	165	2025-05-24 03:24:05.912	\N	\N	\N	Pass	\N	\N	\N	\N		\N
502	984	165	2025-05-24 03:24:06.456	\N	\N	\N	Pass	\N	\N	\N	\N		\N
503	985	165	2025-05-24 03:24:06.992	\N	\N	\N	Pass	\N	\N	\N	\N		\N
504	986	165	2025-05-24 03:24:07.522	\N	\N	\N	Fail	\N	\N	\N	\N	Persona Colgo, a lo mejor porque sintio que era AI	Don't want AI
505	987	165	2025-05-24 03:24:08.026	\N	\N	\N	Pass	\N	\N	\N	\N		\N
506	988	165	2025-05-24 03:24:08.539	\N	\N	\N	Fail	\N	\N	\N	\N		Vapi
507	989	165	2025-05-24 03:24:09.153	\N	\N	\N	Pass	\N	\N	\N	\N		\N
508	990	165	2025-05-24 03:24:09.681	\N	\N	\N	Fail	\N	\N	\N	\N		Pending
509	991	165	2025-05-24 03:24:10.203	\N	\N	\N	Pass	\N	\N	\N	\N		\N
510	992	165	2025-05-24 03:24:10.719	\N	\N	\N	Fail	\N	\N	\N	\N		Pending
511	994	165	2025-05-24 03:24:11.567	\N	\N	\N	Pass	\N	\N	\N	\N	Everything okay User seem confused	Done
512	995	165	2025-05-24 03:24:12.099	\N	\N	\N	Pass	\N	\N	\N	\N		\N
513	996	165	2025-05-24 03:24:12.626	\N	\N	\N	Pass	\N	\N	\N	\N		Pending
514	997	165	2025-05-24 03:24:13.145	\N	\N	\N	Pass	\N	\N	\N	\N		\N
515	998	165	2025-05-24 03:24:13.657	\N	\N	\N	Pass	\N	\N	\N	\N		\N
516	999	165	2025-05-24 03:24:14.179	\N	\N	\N	Pass	\N	\N	\N	\N		\N
517	1000	165	2025-05-24 03:24:14.702	\N	\N	\N	Pass	\N	\N	\N	\N		\N
518	1001	165	2025-05-24 03:24:15.227	\N	\N	\N	Pass	\N	\N	\N	\N	Person Just End the call, we did everything okay	Done
519	1002	165	2025-05-24 03:24:15.745	\N	\N	\N	Pass	\N	\N	\N	\N		\N
520	1003	165	2025-05-24 03:24:16.256	\N	\N	\N	Pass	\N	\N	\N	\N		\N
521	1004	165	2025-05-24 03:24:16.802	\N	\N	\N	Pass	\N	\N	\N	\N		Pending
522	1005	165	2025-05-24 03:24:17.338	\N	\N	\N	Pass	\N	\N	\N	\N		\N
523	1006	165	2025-05-24 03:24:17.856	\N	\N	\N	Pass	\N	\N	\N	\N		\N
524	1008	165	2025-05-24 03:24:18.703	\N	\N	\N	Fail	\N	\N	\N	\N		Pending
525	1009	165	2025-05-24 03:24:19.234	\N	\N	\N	Pass	\N	\N	\N	\N		\N
526	1010	165	2025-05-24 03:24:19.773	\N	\N	\N	Pass	\N	\N	\N	\N		Pending
527	1011	165	2025-05-24 03:24:20.283	\N	\N	\N	Pass	\N	\N	\N	\N		\N
528	1012	165	2025-05-24 03:24:20.805	\N	\N	\N	Fail	\N	\N	\N	\N	We did everything okay but the user just hang up	Don't want AI
529	1013	165	2025-05-24 03:24:21.317	\N	\N	\N	Pass	\N	\N	\N	\N		\N
530	1014	165	2025-05-24 03:24:21.874	\N	\N	\N	Pass	\N	\N	\N	\N		\N
531	1015	165	2025-05-24 03:24:22.401	\N	\N	\N	Pass	\N	\N	\N	\N		\N
532	1016	165	2025-05-24 03:24:22.919	\N	\N	\N	Pass	\N	\N	\N	\N		\N
533	1017	165	2025-05-24 03:24:23.431	\N	\N	\N	Pass	\N	\N	\N	\N		\N
534	1018	165	2025-05-24 03:24:24.027	\N	\N	\N	Pass	\N	\N	\N	\N		\N
535	1019	165	2025-05-24 03:24:24.572	\N	\N	\N	Pass	\N	\N	\N	\N	La persona no se que idoma habla pero ni yo le entiendo	Capo 0
536	1020	165	2025-05-24 03:24:25.083	\N	\N	\N	Pass	\N	\N	\N	\N		\N
537	1021	165	2025-05-24 03:24:25.595	\N	\N	\N	Pass	\N	\N	\N	\N		\N
538	1022	165	2025-05-24 03:24:26.115	\N	\N	\N	Pass	\N	\N	\N	\N		Don't want AI
539	1023	165	2025-05-24 03:24:26.628	\N	\N	\N	Fail	\N	\N	\N	\N	My office instead of Front office	Transcriber
540	1024	165	2025-05-24 03:24:27.158	\N	\N	\N	Pass	\N	\N	\N	\N		\N
541	1025	165	2025-05-24 03:24:28.254	\N	\N	\N	Pass	\N	\N	\N	\N		\N
542	1026	165	2025-05-24 03:24:28.79	\N	\N	\N	Pass	\N	\N	\N	\N		\N
543	1027	165	2025-05-24 03:24:29.324	\N	\N	\N	Pass	\N	\N	\N	\N		\N
544	1028	165	2025-05-24 03:24:29.849	\N	\N	\N	Fail	\N	\N	\N	\N		Don't want AI
545	1029	165	2025-05-24 03:24:30.368	\N	\N	\N	Pass	\N	\N	\N	\N		\N
546	1030	165	2025-05-24 03:24:30.873	\N	\N	\N	Pass	\N	\N	\N	\N		\N
547	1031	165	2025-05-24 03:24:31.39	\N	\N	\N	Fail	\N	\N	\N	\N		Don't want AI
548	1032	165	2025-05-24 03:24:31.918	\N	\N	\N	Pass	\N	\N	\N	\N		\N
549	1033	165	2025-05-24 03:24:32.445	\N	\N	\N	Pass	\N	\N	\N	\N		\N
550	1034	165	2025-05-24 03:24:32.972	\N	\N	\N	Pass	\N	\N	\N	\N		\N
551	1036	165	2025-05-24 03:24:33.829	\N	\N	\N	Pass	\N	\N	\N	\N		\N
552	1037	165	2025-05-24 03:24:34.391	\N	\N	\N	Pass	\N	\N	\N	\N		\N
553	1038	165	2025-05-24 03:24:34.917	\N	\N	\N	Pass	\N	\N	\N	\N		\N
554	1039	165	2025-05-24 03:24:35.442	\N	\N	\N	Pass	\N	\N	\N	\N		\N
555	1040	165	2025-05-24 03:24:35.956	\N	\N	\N	Pass	\N	\N	\N	\N		\N
556	1041	165	2025-05-24 03:24:36.472	\N	\N	\N	Pass	\N	\N	\N	\N		\N
557	1042	165	2025-05-24 03:24:37.018	\N	\N	\N	Pass	\N	\N	\N	\N		\N
558	1043	165	2025-05-24 03:24:37.548	\N	\N	\N	Pass	\N	\N	\N	\N		\N
559	1044	165	2025-05-24 03:24:38.081	\N	\N	\N	Pass	\N	\N	\N	\N		\N
560	1045	165	2025-05-24 03:24:38.587	\N	\N	\N	Pass	\N	\N	\N	\N		\N
561	1046	165	2025-05-24 03:24:39.222	\N	\N	\N	Fail	\N	\N	\N	\N	Transcriber output castle instead of cancel	Transcriber
562	1047	165	2025-05-24 03:24:39.763	\N	\N	\N	Fail	\N	\N	\N	\N		Capo 0
563	1048	165	2025-05-24 03:24:40.284	\N	\N	\N	Fail	\N	\N	\N	\N		Transcriber
564	1050	165	2025-05-24 03:24:41.143	\N	\N	\N	Fail	\N	\N	\N	\N		Transcriber
565	1051	165	2025-05-24 03:24:41.686	\N	\N	\N	Pass	\N	\N	\N	\N		\N
566	1052	165	2025-05-24 03:24:42.217	\N	\N	\N	Pass	\N	\N	\N	\N		\N
567	1053	165	2025-05-24 03:24:42.748	\N	\N	\N	Pass	\N	\N	\N	\N		\N
568	1054	165	2025-05-24 03:24:43.263	\N	\N	\N	Pass	\N	\N	\N	\N		Capo 0
569	1055	165	2025-05-24 03:24:43.783	\N	\N	\N	Pass	\N	\N	\N	\N		\N
570	1056	165	2025-05-24 03:24:44.342	\N	\N	\N	Pass	\N	\N	\N	\N		\N
571	1057	165	2025-05-24 03:24:44.873	\N	\N	\N	\N	\N	\N	\N	\N		\N
572	1058	165	2025-05-24 03:24:45.464	\N	\N	\N	\N	\N	\N	\N	\N		\N
573	1059	165	2025-05-24 03:24:45.98	\N	\N	\N	\N	\N	\N	\N	\N		\N
574	1060	165	2025-05-24 03:24:46.493	\N	\N	\N	\N	\N	\N	\N	\N		\N
575	1061	165	2025-05-24 03:24:47.018	\N	\N	\N	\N	\N	\N	\N	\N		Pending
576	1062	165	2025-05-24 03:24:47.628	\N	\N	\N	\N	\N	\N	\N	\N		\N
577	1063	165	2025-05-24 03:24:48.144	\N	\N	\N	\N	\N	\N	\N	\N		\N
\.


--
-- Data for Name: LlmEvaluation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LlmEvaluation" (id, "callId", "timestamp", overall_score, politeness_score, resolution_status, accuracy_rating, clarity_score, empathy_score, problem_solved, llm_summary, llm_sentiment, call_type, call_type_confidence, call_type_reasoning, feedback, outcome_confidence, outcome_reasoning, protocol_confidence, protocol_reasoning, sentiment_confidence, sentiment_reasoning, vapi_score, adherence_to_script) FROM stdin;
410	824	2025-05-24 03:02:16.621	\N	\N	\N	\N	\N	\N	\N	The caller, Lucia, contacted ABC behavior to schedule an in-home appointment for her daughter Alejandra, a new patient. They discussed insurance coverage (Blue Cross Blue Shield), language preference (English), and availability (mornings). The call concluded with the AI representative promising to send an intake form via text for additional information.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
411	825	2025-05-24 03:02:17.328	\N	\N	\N	\N	\N	\N	\N	I apologize, but there isn't enough information in the provided transcript to create a meaningful 2-3 sentence summary. The transcript only contains a greeting from Annie at ABC behavior, without any context about the purpose of the call or the caller's response. More details would be needed to summarize the call effectively.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
412	826	2025-05-24 03:02:17.846	\N	\N	\N	\N	\N	\N	\N	The call is between Annie from ABC behavior and a caller named Ed. Annie greets Ed and asks if he's calling for himself or someone else, but the call appears to end abruptly before Ed can fully respond.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
413	829	2025-05-24 03:02:19.257	\N	\N	\N	\N	\N	\N	\N	The caller dialed the wrong number, attempting to reach someone named Stephanie but instead reached Annie at ABC Behavior. After realizing the mistake, the caller declined assistance or transfer, and the call ended politely.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
414	830	2025-05-24 03:02:19.779	\N	\N	\N	\N	\N	\N	\N	Sarah Lucas called ABC Behavior and spoke with Annie. The call had just begun, with Annie asking if Sarah was calling for herself or someone else.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
415	831	2025-05-24 03:02:20.301	\N	\N	\N	\N	\N	\N	\N	Karen from Achieve Pediatric Therapy called to follow up on a potential collaboration with ABC behavior to provide occupational therapy and speech services for their clients. The call was transferred to the appropriate team to discuss the collaboration further.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
416	833	2025-05-24 03:02:21.284	\N	\N	\N	\N	\N	\N	\N	The caller asked to speak with Rebecca Gonzalez. The representative, Annie from ABC behavior, informed the caller that they would need to transfer the call to another team for assistance. The caller agreed to the transfer.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
417	834	2025-05-24 03:02:21.819	\N	\N	\N	\N	\N	\N	\N	A representative from Kaiser Permanente's Utilization Management department called ABC Behavior regarding a faxing receipt. Upon realizing they were speaking to a virtual assistant named Annie, they requested to be transferred to the appropriate team for assistance. Annie proceeded to transfer the call.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
418	835	2025-05-24 03:02:22.347	\N	\N	\N	\N	\N	\N	\N	The caller asked to speak with Christian Maddox. The AI representative, Annie from ABC Behavior, explained that she handles intake, scheduling, and service inquiries, and offered to transfer the call to someone who could assist with the specific request. The caller agreed to be transferred.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
419	837	2025-05-24 03:02:23.306	\N	\N	\N	\N	\N	\N	\N	The caller requested to speak with someone. The AI agent, Annie from ABC Behavior, offered to transfer the call to another team for additional assistance, which the caller accepted.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
420	838	2025-05-24 03:02:23.832	\N	\N	\N	\N	\N	\N	\N	Sam Carter from Therapy PM called ABC Behavior seeking to connect with the team responsible for Medex, a practice management tool for therapy clinics. The call was transferred to the appropriate team for further assistance.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
421	839	2025-05-24 03:02:24.36	\N	\N	\N	\N	\N	\N	\N	The caller, Chloe, contacted ABC Behavior regarding health insurance plans and subsidies through the Insure Me Marketplace. She attempted to discuss plan updates and comparisons, but the AI representative was unable to assist with these matters and offered to transfer the call to someone who could help.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
422	840	2025-05-24 03:02:24.878	\N	\N	\N	\N	\N	\N	\N	A caller mistakenly contacted ABC Behavior, thinking they had reached Golden Gate Hampervy. The representative, Annie, clarified that they had reached the wrong number and explained ABC Behavior's services. The caller then ended the conversation without requiring further assistance.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
423	841	2025-05-24 03:02:25.406	\N	\N	\N	\N	\N	\N	\N	The caller requested to speak with Stephanie. The representative, Annie from ABC Behavior, offered to transfer the call to another team for additional assistance. The caller agreed to the transfer and asked for the name of the practice before the call was transferred.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
424	842	2025-05-24 03:02:25.932	\N	\N	\N	\N	\N	\N	\N	The caller inquired about speech therapy services for their 3.5-year-old son at ABC Behavior. The representative informed them that they don't offer speech therapy but offered to refer the caller to someone who could assist. The call ended with the representative preparing to transfer the caller to the appropriate person.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
425	843	2025-05-24 03:02:26.483	\N	\N	\N	\N	\N	\N	\N	Rick from Translational Excellence called ABC Behavior inquiring about a potential interest in language services, based on recent online research activity. He requested to speak with someone in HR or operations, and the call was subsequently transferred to the appropriate department.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
426	844	2025-05-24 03:02:27.013	\N	\N	\N	\N	\N	\N	\N	The caller inquired about Spanish-speaking providers at ABC Behavior. The representative, Annie, offered to transfer the call to someone who could assist with this specific request, and the caller agreed. The call was then transferred to the appropriate department.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
427	845	2025-05-24 03:02:27.54	\N	\N	\N	\N	\N	\N	\N	The caller dialed the wrong number, reaching ABC Behavior instead of their intended recipient. The representative, Annie, politely informed the caller that if they needed assistance with autism, developmental delays, or behavior therapy services, they could call back. The call was then ended.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
428	846	2025-05-24 03:02:28.073	\N	\N	\N	\N	\N	\N	\N	Greg from Translational Excellence called ABC Behavior to reconfirm Anayeli's email address, which he believes he recorded incorrectly during a previous conversation. The initial representative, Annie, offered to transfer Greg to another team for further assistance.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
429	847	2025-05-24 03:02:28.635	\N	\N	\N	\N	\N	\N	\N	Edna Guzman called ABC Behavior to book an appointment for her son Julian Lopez, who is a new client seeking autism services. However, the call ended when it was discovered that ABC Behavior does not work with Edna's insurance provider, UnitedHealthcare.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
430	848	2025-05-24 03:02:29.158	\N	\N	\N	\N	\N	\N	\N	The call was between Annie from ABC Behavior and Naim Khan, who was inquiring about ABA therapy for his son, Zigod Banzai. Annie gathered basic information including insurance details (Kaiser), preferred service type (in-home), and availability (evenings). She informed Naim that an intake form would be sent via text for additional information.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
431	849	2025-05-24 03:02:29.691	\N	\N	\N	\N	\N	\N	\N	Hannah, Mohammed's mother, called ABC Behavior regarding an emergency situation and inquired about picking up her son. The initial representative, Annie, determined she needed to transfer the call to another team for further assistance. The call was then transferred.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
432	851	2025-05-24 03:02:30.638	\N	\N	\N	\N	\N	\N	\N	Sam from Coverol called ABC Behavior seeking to speak with Stephanie Maddox. The AI assistant, Annie, offered to transfer the call to another team for additional assistance, which Sam accepted.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
433	852	2025-05-24 03:02:31.24	\N	\N	\N	\N	\N	\N	\N	The caller inquired about adult ADHD testing services, which the virtual assistant Annie informed were not offered. Upon realizing they were speaking to an AI, the caller requested to speak with a real person. Annie agreed to transfer the call to a human representative.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
458	892	2025-05-24 03:02:51.488	\N	\N	\N	\N	\N	\N	\N	A caller contacted ABC behavior requesting to speak with someone who manages security, specifically mentioning cameras and alarms. The representative, Claire, offered to transfer the call to the appropriate team, which the caller accepted.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
434	853	2025-05-24 03:02:31.768	\N	\N	\N	\N	\N	\N	\N	The caller inquired about EBA (likely ABA - Applied Behavior Analysis) services on behalf of someone else, but was hesitant to provide patient details. They specifically asked if an autism spectrum diagnosis is required to start ABA services, but the representative was unsure and offered to forward the query to someone more knowledgeable.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
435	854	2025-05-24 03:02:32.297	\N	\N	\N	\N	\N	\N	\N	Jessica Henderson called ABC Behavior seeking an evaluation for her daughter Clementine, who is showing signs of autism and developmental delays. After discussing insurance and payment options, Jessica opted for private pay services and expressed interest in both in-home and clinic-based therapy at the Warrington location, with a preference for afternoon appointments on Monday through Thursday.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
436	855	2025-05-24 03:02:32.825	\N	\N	\N	\N	\N	\N	\N	Lee Anthem Jewel called on behalf of existing client Danielle Provinter. The caller initially had difficulty providing his full name clearly. The AI representative, Annie from ABC behavior, indicated she may need to transfer the call to the appropriate team for further assistance.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
437	857	2025-05-24 03:02:33.786	\N	\N	\N	\N	\N	\N	\N	Maine from Translation at Zealand called ABC Behavior to inquire about their potential interest in language services, specifically translation. The caller didn't have specific contact information, so Annie, the representative, offered to transfer the call to a more appropriate team for assistance.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
438	858	2025-05-24 03:02:34.321	\N	\N	\N	\N	\N	\N	\N	The caller requested to speak with Stephanie Maddox. Annie from ABC behavior offered to transfer the call to another team, which the caller agreed to.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
439	859	2025-05-24 03:02:34.845	\N	\N	\N	\N	\N	\N	\N	The caller requested to speak with Christian Maddox. The representative, Annie from ABC behavior, offered to transfer the call to another team for additional assistance. The caller agreed to the transfer.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
440	860	2025-05-24 03:02:35.363	\N	\N	\N	\N	\N	\N	\N	The caller, Jessica, is seeking behavioral therapy services for her child, Jordan Niesbonder. She is interested in self-pay, in-home services during late afternoons or evenings, preferably at the Fairfax location. Jessica agreed to commit to the recommended therapy hours but had questions about referral requirements for out-of-pocket payments, which the representative couldn't answer and offered to transfer the call.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
441	861	2025-05-24 03:02:35.894	\N	\N	\N	\N	\N	\N	\N	Anayeli Gomez called ABC behavior for assistance. The AI representative had difficulty understanding her name and asked if she was a new client. Upon learning she was not a new client, the AI decided to transfer the call to another team for further help.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
442	863	2025-05-24 03:02:36.877	\N	\N	\N	\N	\N	\N	\N	Myra from TRICARE East called to inquire about the availability or waitlist for ABA services in Hagerstown, Maryland. Annie from ABC Behavior offered to transfer the call to a more appropriate team to address Myra's inquiry, which Myra accepted.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
443	869	2025-05-24 03:02:39.595	\N	\N	\N	\N	\N	\N	\N	A caller mistakenly dialed ABC Behavior and spoke with Annie. Upon realizing their error, they apologized for the wrong number and ended the call.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
444	870	2025-05-24 03:02:40.109	\N	\N	\N	\N	\N	\N	\N	The caller requested to speak with Poonam Balraj Sabnani. After confirming the call was being recorded, the AI representative offered to transfer the call to another team. The caller agreed, and the call was transferred.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
445	871	2025-05-24 03:02:40.628	\N	\N	\N	\N	\N	\N	\N	A caseworker named Lexi McCracci called about setting up ABA therapy for a 7-year-old foster child with autism who recently moved from Tennessee to Virginia. The child's insurance is still in the process of switching from Tennessee to Virginia Medicaid, and Lexi inquired about the possibility of starting therapy before the insurance transition is complete. The call was transferred to someone who could provide more detailed information on this specific situation.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
446	876	2025-05-24 03:02:42.996	\N	\N	\N	\N	\N	\N	\N	A customer service representative named Annie from ABC Behavior answered a call. The caller quickly realized they had dialed the wrong number and apologized before ending the call.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
447	877	2025-05-24 03:02:43.518	\N	\N	\N	\N	\N	\N	\N	The caller, a grandparent of a child with Anthem insurance, is seeking guidance on how to better understand and support their grandson who lives with them. The representative from ABC Behavior explains that while they don't offer specific grandparent-focused meetings, they can look into available resources or transfer the caller to someone who might have more information.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
448	878	2025-05-24 03:02:44.048	\N	\N	\N	\N	\N	\N	\N	The caller inquired about assessments for autism in adult females. The representative confirmed that their organization specializes in services related to autism, developmental delays, and behavior therapy. The call ended with the representative asking if the caller was seeking services for themselves or someone else.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
449	879	2025-05-24 03:02:44.579	\N	\N	\N	\N	\N	\N	\N	The caller inquired about directory information for ABC Behavior. The AI assistant provided addresses for two office locations in Warrenton and Fairfax, Virginia, and offered an email address for further assistance.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
450	882	2025-05-24 03:02:46.383	\N	\N	\N	\N	\N	\N	\N	Abigail Yaldington called ABC Behavior for training related to a behavior technician position. The initial representative, Claire, determined she needed to transfer Abigail to another team for further assistance. Abigail agreed to the transfer.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
451	883	2025-05-24 03:02:46.917	\N	\N	\N	\N	\N	\N	\N	A new employee called for their first day of orientation but was unable to locate the office from the parking lot. The AI representative, unable to provide specific directions, offered to transfer the call to someone who could assist with finding the location.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
452	884	2025-05-24 03:02:47.446	\N	\N	\N	\N	\N	\N	\N	The caller attempted to communicate a request but was unclear. The representative, Claire from ABC behavior, asked for clarification. The caller then requested for someone to pick a plan, though the context remains vague.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
453	886	2025-05-24 03:02:48.406	\N	\N	\N	\N	\N	\N	\N	The caller requested to speak with David Marax. The representative, Claire from ABC behavior, offered to transfer the call to another team for additional assistance. The caller agreed, and the call was transferred.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
454	887	2025-05-24 03:02:48.93	\N	\N	\N	\N	\N	\N	\N	The caller inquired about services for their child diagnosed with autism, asking about waitlists and accepted insurance providers. They specifically asked about the intake process for UnitedHealthcare and whether a referral is needed, which the representative confirmed is typically required.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
455	888	2025-05-24 03:02:49.466	\N	\N	\N	\N	\N	\N	\N	The caller requested to speak with someone who speaks Spanish. The representative, Claire, was unsure if they had Spanish-speaking staff available but offered to forward the request to someone who could assist. The caller agreed to this suggestion.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
456	889	2025-05-24 03:02:49.994	\N	\N	\N	\N	\N	\N	\N	A caller contacted ABC behavior but was expecting to speak with Aetna. The representative, Claire, offered to transfer the call to the appropriate team or individual. The caller agreed to the transfer.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
457	890	2025-05-24 03:02:50.509	\N	\N	\N	\N	\N	\N	\N	The caller initially claimed to be from different offices, causing confusion. After clarification, the AI representative provided information about ABC Behavior's office locations in Warrenton and Fairfax, Virginia. The caller then stated it was a confirmation call and ended the conversation.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
459	893	2025-05-24 03:02:52.067	\N	\N	\N	\N	\N	\N	\N	A caller claiming to be Michael from Walmart repeatedly informs about a pre-authorized purchase of a PlayStation 5 with special edition and Pulse 3D headset for $919.45 from the recipient's Walmart account. The caller instructs to press 1 to cancel the order or connect with customer support.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
460	894	2025-05-24 03:02:52.598	\N	\N	\N	\N	\N	\N	\N	Claire from ABC behavior answered the call and asked how she could assist. The caller inquired about the availability of Heather Jones. Claire then offered to transfer the call to another team for additional help, which the caller agreed to.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
461	895	2025-05-24 03:02:53.11	\N	\N	\N	\N	\N	\N	\N	Greg from Translation Excellence called ABC behavior regarding Aetna Yelli Gomez. Due to communication difficulties and Greg being a new client, the representative decided to transfer the call to another team for further assistance.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
462	896	2025-05-24 03:02:53.646	\N	\N	\N	\N	\N	\N	\N	The caller requested to speak with Anna Gomez. The AI representative, Claire from ABC behavior, offered to transfer the call to another team for assistance. The caller agreed, and the call was transferred.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
463	897	2025-05-24 03:02:54.178	\N	\N	\N	\N	\N	\N	\N	The call appears to be a wrong number or mistaken connection. A virtual assistant named Claire from ABC Behavior introduced herself, but the recipient was confused as they hadn't initiated the call. Claire acknowledged the mistake and offered assistance with autism-related matters before the transcript ends.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
464	898	2025-05-24 03:02:54.702	\N	\N	\N	\N	\N	\N	\N	The caller is seeking information about adult ABA services for a 35-year-old male client, which is beyond the age range typically served by ABC behavior. The representative, Claire, is unsure about specific organizations that provide such services for adults over 21 but offers to forward the request to someone who might be able to assist. The caller agrees to have the request forwarded.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
465	899	2025-05-24 03:02:55.227	\N	\N	\N	\N	\N	\N	\N	The caller, Ore Castilla, contacted ABC Behavior to book an appointment for behavior therapy for Carlos. They provided insurance information for UnitedHealthcare, expressed interest in both in-home and clinic-based services in the evenings, and agreed to commit to the recommended therapy schedule.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
466	900	2025-05-24 03:02:55.755	\N	\N	\N	\N	\N	\N	\N	The caller requested to speak with Christian Manox. The representative, Claire from ABC Behavior, offered to transfer the call to another team for assistance. The caller agreed, and the call was transferred.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
467	902	2025-05-24 03:02:56.739	\N	\N	\N	\N	\N	\N	\N	Nahir called ABC Behavior seeking ABA therapy for her son in the morning. When the AI assistant offered to help, Nahir requested to speak with a human representative instead. The call was then transferred to a live agent.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
468	903	2025-05-24 03:02:57.271	\N	\N	\N	\N	\N	\N	\N	The caller requested to speak with Sam. The representative, Claire from ABC behavior, offered to transfer the call to another team for additional assistance. The caller agreed, and the call was transferred.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
469	904	2025-05-24 03:23:23.164	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy answered the phone. The caller had not yet stated their reason for calling.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
470	905	2025-05-24 03:23:24.046	\N	\N	\N	\N	\N	\N	\N	The call summarizes a new patient, Heidi Hoefer, contacting Golden Gate Hand Therapy to schedule an appointment for a sprained left ring finger. She opts to use her Blue Shield insurance, which the clinic accepts, and is informed that insurance appointments are typically booked a month out. The clinic will send her an intake form via text message.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
471	906	2025-05-24 03:23:24.586	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate hand therapy received a call from Jorge at OneCall regarding scheduling an appointment for a patient. Annie was unable to confirm specific appointment availability but offered to transfer Jorge to the front desk for more information.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
472	907	2025-05-24 03:23:25.107	\N	\N	\N	\N	\N	\N	\N	Jorge, a new patient calling from OneCall, contacted Golden Gate Hand Therapy to book an appointment for hand therapy. Annie, the receptionist, explained that a prior authorization would be needed since Jorge is with OneCall, and began collecting his information to set up the appointment.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
473	908	2025-05-24 03:23:25.62	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy answered a call from someone looking to set up an appointment for a new client needing hand physical therapy. After gathering some initial information, the caller requested to be transferred to a live agent to verify additional details, and Annie agreed to transfer them to the front desk department.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
474	909	2025-05-24 03:23:26.136	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy answered the call and offered assistance. The caller requested to speak with someone, so Annie offered to transfer the call to the front desk department. The caller agreed, and Annie proceeded with the transfer.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
475	910	2025-05-24 03:23:26.695	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy answered the call and offered assistance. The caller requested to speak to someone, so Annie offered to transfer the call to the front desk department.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
476	911	2025-05-24 03:23:27.225	\N	\N	\N	\N	\N	\N	\N	The caller is seeking an appointment at Golden Gate hand therapy as a new client. There appears to be some communication difficulties, with the caller repeatedly saying "Hello?" and seeming unsure about their specific condition. The receptionist attempts to gather more information but is unable to determine the caller's exact needs.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
477	912	2025-05-24 03:23:27.739	\N	\N	\N	\N	\N	\N	\N	A caller inquired about making an appointment for his wife at Golden Gate Hand Therapy's Mill Valley office for hand pain treatment. The clinic doesn't accept Covered California insurance, so they discussed self-pay rates, including package discounts. The caller agreed to proceed with the cash payment option and was transferred to the front desk.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
478	913	2025-05-24 03:23:28.243	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy received a call from Jack at Spark Medical billing regarding credentialing and medical billing services. Annie explained she wasn't the appropriate person to discuss these services and offered to transfer Jack to the front desk department for more information.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
479	914	2025-05-24 03:23:28.771	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy received a call from Erica at MediRisk inquiring about scheduling an appointment for a patient named Yolanda Ramirez. Unable to access appointment schedules directly, Annie offered to transfer the call to the front desk department, which Erica accepted.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
480	915	2025-05-24 03:23:29.296	\N	\N	\N	\N	\N	\N	\N	A patient named Don Hart called Golden Gate hand therapy, informing them he had a 2:15 appointment but was unable to locate the office. Annie, the receptionist, offered to transfer the call to the front desk for assistance.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
481	916	2025-05-24 03:23:29.829	\N	\N	\N	\N	\N	\N	\N	A caller from UCSF inquired about Golden Gate Hand Therapy's acceptance of Imperial Health insurance. The representative informed them that they do not accept Imperial Health, but offered self-pay options with rates ranging from $210 to $250 per visit, including package discounts for multiple visits.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
482	917	2025-05-24 03:23:30.347	\N	\N	\N	\N	\N	\N	\N	A new client called Golden Gate Hand Therapy seeking treatment for carpal tunnel syndrome. The clinic informed the client they don't accept their insurance (Imperial Health) and offered cash pay options, but the call ended without scheduling an appointment.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
483	918	2025-05-24 03:23:30.848	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy called to offer assistance. The caller expressed interest in making an appointment, though their response was somewhat unclear or incomplete.		webCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
484	919	2025-05-24 03:23:31.362	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy answered the phone. The caller had not yet stated the reason for their call.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
485	920	2025-05-24 03:23:31.885	\N	\N	\N	\N	\N	\N	\N	A new client called Golden Gate Hand Therapy to schedule an appointment for a possible hand sprain. Initially considering using insurance, they opted for the cash payment option to get an earlier appointment. The caller was informed of the self-pay rates and package discounts before being transferred to the front desk to complete the booking.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
486	921	2025-05-24 03:23:32.427	\N	\N	\N	\N	\N	\N	\N	A caller contacted Golden Gate Hand Therapy to make an appointment. The receptionist, Annie, asked if they were a new or existing client, but the caller's response was unclear. The conversation ended without scheduling an appointment or clarifying the caller's status.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
487	922	2025-05-24 03:23:32.933	\N	\N	\N	\N	\N	\N	\N	A new client called Golden Gate Hand Therapy to make an appointment for a hand wound. The receptionist, Annie, asked about the client's condition and inquired whether they would be using insurance or paying cash for the visit.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
488	923	2025-05-24 03:23:33.445	\N	\N	\N	\N	\N	\N	\N	A new patient called Golden Gate Hand Therapy seeking an appointment. There was confusion when the caller mentioned "Samsung," as the clinic specializes in upper extremity disorders. The call ended with the AI transferring the caller to the front desk department.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
489	924	2025-05-24 03:23:33.96	\N	\N	\N	\N	\N	\N	\N	A caller contacted Golden Gate Hand Therapy and requested to speak with the business owner. The receptionist, Annie, was unsure about the availability of the owner but offered to transfer the call to someone who could provide more information. The caller agreed to be transferred.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
490	925	2025-05-24 03:23:34.496	\N	\N	\N	\N	\N	\N	\N	A caller contacted Golden Gate Hand Therapy and spoke with Annie. The caller seemed confused, asking if they had reached "Maloney," to which Annie reiterated her identity and offered assistance.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
491	926	2025-05-24 03:23:35.024	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy received a call from Nat at 1 Call requesting therapy updates for patient Leima Rivera Flores. As Annie was uncertain about the information, she offered to transfer the call to someone who could assist, which Nat accepted.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
492	927	2025-05-24 03:23:35.543	\N	\N	\N	\N	\N	\N	\N	John from Health Physician called Golden Gate Hand Therapy to inquire about available appointments for a new patient with trigger finger. The clinic accepts Blue Cross Blue Shield insurance but typically books insurance appointments a month in advance, with earlier availability for cash pay clients.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
493	928	2025-05-24 03:23:36.051	\N	\N	\N	\N	\N	\N	\N	A new client called Golden Gate Hand Therapy to make an appointment for hand arthritis treatment, with a referral from Dr. Mark Stavant. Upon realizing they were speaking to a virtual receptionist, the caller requested to speak with a real person. The call was then transferred to the front desk department.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
494	929	2025-05-24 03:23:36.602	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy answered a call from Tim, who was looking for Melanie. As Annie was unsure about availability, she offered to transfer Tim to the front desk department for more information, which Tim accepted.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
495	930	2025-05-24 03:23:37.128	\N	\N	\N	\N	\N	\N	\N	The caller, Luke from Quick Access Capital, initially thought he was speaking to a human receptionist but became confused when informed it was a virtual assistant. He requested to speak with Melanie, and despite some confusion about the nature of the AI, the virtual receptionist offered to transfer the call to someone who could help reach Melanie.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
496	931	2025-05-24 03:23:37.648	\N	\N	\N	\N	\N	\N	\N	A caller contacted Golden Gate Hand Therapy requesting to speak with staff. The receptionist, Annie, offered to transfer the call to the appropriate department. After confirming the caller's request, Annie proceeded to transfer the call to the front desk.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
497	932	2025-05-24 03:23:38.154	\N	\N	\N	\N	\N	\N	\N	A representative from Golden Gate Hand Therapy answered a call from someone inquiring about web development and marketing services. The caller thanked the representative for connecting, but no further details about the services or request were discussed in this brief exchange.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
498	933	2025-05-24 03:23:38.759	\N	\N	\N	\N	\N	\N	\N	The caller, Kim Chiu Chow, is trying to update their insurance information with Golden Gate Hand Therapy. Due to language barriers and the caller's age, they are having difficulty understanding the email address provided for sending the updated insurance details. The representative attempts to slowly spell out the email address multiple times.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
499	934	2025-05-24 03:23:39.283	\N	\N	\N	\N	\N	\N	\N	A caller contacted Golden Gate Hand Therapy to make an appointment. The AI assistant, Annie, attempted to gather information but the caller expressed a desire to speak with a human. Annie then transferred the call to the front desk department.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
500	935	2025-05-24 03:23:39.816	\N	\N	\N	\N	\N	\N	\N	A caller inquired about new patient acceptance and insurance coverage at Golden Gate Hand Therapy. The receptionist, Annie, explained that they specialize in upper extremity disorders and do not treat neck pain. The call ended with Annie offering to transfer the caller to the front desk for more information.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
501	936	2025-05-24 03:23:40.33	\N	\N	\N	\N	\N	\N	\N	A caller requested to speak with Melanie at Golden Gate Hand Therapy. Annie, who answered the call, was unsure about Melanie's availability but offered to transfer the call to someone who could provide more information.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
502	937	2025-05-24 03:23:40.847	\N	\N	\N	\N	\N	\N	\N	Jason Phillips called Golden Gate Hand Therapy to confirm the time of his Monday morning appointment. The receptionist, Annie, offered to transfer him to the front desk department for appointment confirmation. Jason agreed to the transfer.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
503	938	2025-05-24 03:23:41.359	\N	\N	\N	\N	\N	\N	\N	A patient called Golden Gate Hand Therapy to confirm their appointment for the following week. Annie, the receptionist, asked if they were an existing client and offered to transfer the call to someone who could assist with appointment confirmation.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
504	939	2025-05-24 03:23:41.882	\N	\N	\N	\N	\N	\N	\N	The caller inquired about whether Golden Gate Hand Therapy accepts TRICARE insurance with a referral. Annie, the representative, informed the caller that they do not accept TRICARE insurance but offered information about self-pay rates. The caller declined and ended the call.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
505	940	2025-05-24 03:23:42.419	\N	\N	\N	\N	\N	\N	\N	Alex from AnyCloyers called Golden Gate Hand Therapy to inquire about occupational hand therapy services for a new client with a referral. Alex specifically asked if the clinic accepts PI leads. The receptionist, Annie, confirmed they offer occupational hand therapy but was unsure about PI leads, so she offered to transfer the call to someone who could provide more information.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
506	941	2025-05-24 03:23:42.935	\N	\N	\N	\N	\N	\N	\N	Melvin Smith, a new client, called Golden Gate Hand Therapy to make an appointment for a hand condition covered by workers' compensation. The receptionist collected his basic information and informed him that an intake form would be sent via text message, with the scheduling team to follow up shortly to complete the process and set an appointment at their San Francisco location.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
507	942	2025-05-24 03:23:43.445	\N	\N	\N	\N	\N	\N	\N	The caller inquired about scheduling post-surgical hand therapy for their son's RCL repair. The receptionist informed them that while they accept insurance, there's typically a month-long wait, with earlier appointments available for cash pay clients. However, the caller's HealthNet insurance is not accepted by the clinic.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
508	943	2025-05-24 03:23:43.968	\N	\N	\N	\N	\N	\N	\N	The caller mistakenly thought they were speaking to a recording and was confused when they reached a live person instead of Kelly, whom they were expecting. After some initial confusion, the caller requested to speak with Kelly, and the receptionist offered to transfer the call to someone who could assist further.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
509	944	2025-05-24 03:23:44.495	\N	\N	\N	\N	\N	\N	\N	A patient called Golden Gate Hand Therapy to pay their bill. The receptionist, Annie, was unsure how to process the payment and offered to transfer the call to someone who could assist. The caller agreed to be transferred.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
510	945	2025-05-24 03:23:45.008	\N	\N	\N	\N	\N	\N	\N	A representative from Golden Gate Hand Therapy answered a call, but was interrupted by an automated message claiming to be about the business's Google account. The call appears to be a potential scam or unsolicited marketing attempt, and was quickly ended by the representative.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
511	946	2025-05-24 03:23:45.518	\N	\N	\N	\N	\N	\N	\N	A caller contacted Golden Gate Hand Therapy to make an appointment but had difficulty communicating their needs clearly. After several attempts to clarify the caller's status and intentions, the AI assistant offered to transfer the call to the front desk department, which the caller accepted.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
512	947	2025-05-24 03:23:46.035	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate hand therapy answered the call and asked how she could help the caller. No other information was provided in this brief transcript.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
513	948	2025-05-24 03:23:46.556	\N	\N	\N	\N	\N	\N	\N	David Finkelstein, an existing client, called Golden Gate hand therapy to schedule an appointment with Alison at their new Mill Valley location. Annie, the receptionist, offered to transfer David to the front desk department to assist with scheduling.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
514	949	2025-05-24 03:23:47.081	\N	\N	\N	\N	\N	\N	\N	Euna from Dr. Joshua Gordon's office called Golden Gate Hand Therapy to inquire about the fax number for sending referrals to their Mill Valley location. Annie provided the fax number 415-383-1418 and offered further assistance if needed.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
515	950	2025-05-24 03:23:47.61	\N	\N	\N	\N	\N	\N	\N	A caller contacted Golden Gate Hand Therapy to schedule an appointment as an existing client. The receptionist, Annie, offered to transfer the call to the front desk department to assist with booking the appointment.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
516	951	2025-05-24 03:23:48.12	\N	\N	\N	\N	\N	\N	\N	The caller requested to speak with the medical records department or Melanie. Annie, from Golden Gate hand therapy, offered to transfer the call to the front desk department.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
517	952	2025-05-24 03:23:48.641	\N	\N	\N	\N	\N	\N	\N	A patient called Golden Gate hand therapy seeking assistance with medical records. After being initially transferred without success, they spoke with Annie who offered to transfer them again. Annie then proceeded to transfer the caller to the front desk department for further help.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
518	953	2025-05-24 03:23:49.161	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy received a call from Mihira Palinkovic, an existing client who wanted to schedule an appointment for the following week. Due to communication difficulties, Annie offered to transfer Mihira to the front desk department to assist with scheduling the appointment.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
519	954	2025-05-24 03:23:49.693	\N	\N	\N	\N	\N	\N	\N	A caller contacted Golden Gate Hand Therapy after being disconnected during a previous attempt to make an appointment. The receptionist, Annie, apologized for the inconvenience and offered to transfer the caller again to schedule their appointment. The caller agreed to be transferred.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
520	955	2025-05-24 03:23:50.199	\N	\N	\N	\N	\N	\N	\N	Jorge, a new client, called to book an appointment for a broken finger at Golden Gate Hand Therapy. He initially considered cash payment but opted to use his Medicare insurance with secondary coverage and a doctor's referral. After providing his personal information, Jorge was transferred to the front desk to complete the scheduling process.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
521	956	2025-05-24 03:23:50.707	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy received a call from Blaise, who works for MedRisk, regarding a workers' compensation patient named Karen Rhodes. When asked for insurance details, Blaise corrected their name to Cedric and was then transferred to the front desk for further assistance.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
522	957	2025-05-24 03:23:51.309	\N	\N	\N	\N	\N	\N	\N	A representative from UnitedHealthcare called Golden Gate Hand Therapy to update insurance information for a patient. The caller was transferred to the front desk department to provide the correct insurance details.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
523	958	2025-05-24 03:23:51.84	\N	\N	\N	\N	\N	\N	\N	A caller contacted Golden Gate Hand Therapy to update insurance information for a member. The caller confirmed they had UnitedHealthcare insurance. The receptionist, Annie, then transferred the call to the front desk department to handle the insurance update request.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
524	959	2025-05-24 03:23:52.456	\N	\N	\N	\N	\N	\N	\N	A patient called Golden Gate hand therapy to update their insurance information. They confirmed having UnitedHealthcare insurance. The receptionist, Annie, then transferred the call to the front desk department to handle the insurance update.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
525	960	2025-05-24 03:23:52.967	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy received a call from Janine at Med regarding workers' compensation for patient Hannah Timber Levin. After some clarification, Annie determined that a prior authorization was needed for workers' compensation cases and transferred the call to another department for further assistance.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
526	961	2025-05-24 03:23:53.479	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate hand therapy received a call from Anne, a nurse from Liberty Mutual Work Comp. Anne was inquiring about the attendance of a patient named Maria Marquez for therapy. Annie then offered to transfer the call to the front desk department for further assistance.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
527	962	2025-05-24 03:23:54.097	\N	\N	\N	\N	\N	\N	\N	The call is between Annie from Golden Gate Hand Therapy and Heather from UnitedHealthcare Medicare Advantage. Heather requests to speak with someone in the billing department, but Annie informs her that they don't accept Medicare Advantage UHC plans. Despite this, Heather insists on speaking with billing, so Annie transfers her to the front desk.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
528	963	2025-05-24 03:23:54.631	\N	\N	\N	\N	\N	\N	\N	Anne from Liberty Mutual called Golden Gate hand therapy after being disconnected earlier. She requested to speak with the appointment desk, and Annie from Golden Gate hand therapy offered to transfer her to the front desk department.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
529	964	2025-05-24 03:23:55.147	\N	\N	\N	\N	\N	\N	\N	Annie from Golden Gate Hand Therapy answered the call and offered assistance. The caller requested to speak with a billing representative, and Annie agreed to transfer the call to the front desk department to handle the billing inquiry.		inboundPhoneCall	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
530	965	2025-05-24 03:23:56.501	\N	\N	\N	\N	\N	\N	t	The caller inquired about the location of their appointment with Always Keep Progressing. The representative provided information about the two clinic locations in Miami but ultimately offered to transfer the caller to the scheduling department for specific appointment details.	neutral	APPOINTMENT_ADJUSTMENT	0.9	The caller is asking about a change in appointment ('cambio de cita') and the location of an appointment ('ubicación de cita'). They mention receiving a message about an appointment yesterday. This clearly falls under appointment adjustment as they are seeking information about an existing appointment.	Valentina handled the core requirements of the protocol well by identifying the appointment adjustment request, providing some information from the knowledge base, asking for transfer permission, and executing the transfer correctly. However, there were some areas for improvement: 1) The initial Spanish response had an awkward phrase 'puedes dar más?' that seemed incomplete, 2) There was some fragmentation in responses with interruptions, 3) When providing location information, the speech pattern was somewhat disjointed with numbers spelled out individually rather than naturally, and 4) She could have more clearly explained that the scheduling team could help with the specific appointment location rather than just general location information.	0.95	The agent successfully transferred the call to +17867056064 as required by the expected outcome. The transfer was made after understanding the caller needed information about their appointment location, which falls under the scheduling team's responsibilities.	1	{"explanation_score":"Valentina handled the core requirements of the protocol well by identifying the appointment adjustment request, providing some information from the knowledge base, asking for transfer permission, and executing the transfer correctly. However, there were some areas for improvement: 1) The initial Spanish response had an awkward phrase 'puedes dar más?' that seemed incomplete, 2) There was some fragmentation in responses with interruptions, 3) When providing location information, the speech pattern was somewhat disjointed with numbers spelled out individually rather than naturally, and 4) She could have more clearly explained that the scheduling team could help with the specific appointment location rather than just general location information.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client appropriately and attempted to understand their needs. When the client spoke Spanish, she correctly switched to Spanish and tried to clarify what the client needed regarding an appointment."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that this was an appointment adjustment request when the client mentioned 'cambio de cita' (appointment change) and 'ubicación de cita' (appointment location). She appropriately used the knowledge base tool to look up location information."},{"name":"Transfer Permission","completed":true,"details":"Valentina asked for permission to transfer the call to the scheduling team with 'Parece que nuestro equipo de programación puede ayudarte con esa información. ¿Te gustaría que transfiera tu llamada a ellos?'"},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation from the client, Valentina correctly used the transferCall function with the appropriate number for the scheduling team (+17867056064)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed as the client agreed to the transfer, but Valentina did attempt to provide location information before determining a transfer was necessary."}]}	1	{"explanation":"The customer is primarily task-focused, seeking information about their appointment location. Their messages are brief and direct, without expressing strong emotions. Even when they say 'Okay' or 'Yes', these are simple acknowledgments rather than emotional responses. The conversation shows a customer with a practical need rather than displaying positive or negative emotional states.","key_indicators":["Hola. Buenos días.","¿Aló?","Amiga, a mí me me pasaron ayer un mensaje","para una cita","cambio de cita","ubicación de cita","Okay.","Yes.","Quiero saber dónde es la cita."]}	\N	85
531	967	2025-05-24 03:23:57.648	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing asking if they spoke Spanish, then requested to reschedule a Cigna appointment. The representative confirmed they spoke Spanish and informed the caller they would be transferred to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	0.8	The caller requested 'Reprogramar Cigna' which translates to 'Reschedule Cigna' in English, indicating they want to change an existing appointment. The mention of Cigna (an insurance provider) suggests this is about rescheduling an appointment that's covered by Cigna insurance. The call was transferred to the scheduling department, which aligns with appointment adjustment needs.	Valentina handled most aspects of this appointment adjustment call well, particularly demonstrating language flexibility by switching to Spanish when requested and correctly identifying the appointment rescheduling need. She properly transferred the call to the scheduling team and provided clear closing instructions. However, she missed a critical step by not asking for permission before transferring the call, which is explicitly required in the protocol. This oversight reduces the overall score, as obtaining consent before transferring is an important part of providing good customer service and following proper call handling procedures.	1	The expected outcome was to transfer the call to scheduling team at +17867056064, which was successfully done. The assistant recognized the caller's request to reschedule a Cigna appointment in Spanish and properly transferred the call to the correct number.	1	{"explanation_score":"Valentina handled most aspects of this appointment adjustment call well, particularly demonstrating language flexibility by switching to Spanish when requested and correctly identifying the appointment rescheduling need. She properly transferred the call to the scheduling team and provided clear closing instructions. However, she missed a critical step by not asking for permission before transferring the call, which is explicitly required in the protocol. This oversight reduces the overall score, as obtaining consent before transferring is an important part of providing good customer service and following proper call handling procedures.","steps_completed":4,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally, asked how she could help, and followed up appropriately when the initial response was vague ('Hello?'). She demonstrated adaptability by recognizing the language preference request."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client needed to reschedule an appointment with Cigna insurance when the client stated 'Reprogramar Cigna' (Reschedule Cigna)."},{"name":"Transfer Permission","completed":false,"details":"Valentina did not explicitly ask for permission to transfer the call to the scheduling team. She should have asked something like '¿Quieres que te transfiera al equipo de programación?' before proceeding with the transfer."},{"name":"Transfer Execution","completed":true,"details":"Valentina correctly transferred the call to the scheduling team at +17867056064, which is the appropriate department for appointment adjustments."},{"name":"Alternative Closure","completed":true,"details":"Valentina provided appropriate closure by informing the client that she was forwarding the call and instructing them to stay on the line."}]}	1	{"explanation":"The customer is brief and direct, primarily focused on their task of rescheduling an appointment with Cigna. They ask if Spanish is available, apologize, and then state their purpose. There are no emotional indicators of either positive or negative sentiment - they are simply trying to accomplish a specific task.","key_indicators":["Hello?","Hi. Uh, do you speak Spanish? Sorry.","Reprogramar Cigna."]}	\N	80
532	968	2025-05-24 03:23:58.154	\N	\N	\N	\N	\N	\N	t	The caller requested to be connected to the scheduling department. After confirming the request, the representative transferred the call to the appropriate department.	neutral	APPOINTMENT_ADJUSTMENT	0.7	The caller specifically asked for the scheduling department and agreed to be transferred there. While the exact nature of their scheduling need isn't specified, the scheduling department typically handles appointment adjustments, cancellations, or confirmations. Without more specific information, this appears to be appointment-related, but not necessarily for a new client or a new appointment for an existing client.	Valentina handled this appointment adjustment request perfectly. She identified the client's need for the scheduling department immediately, asked for permission to transfer, and executed the transfer to the correct number once permission was granted. Her responses were concise and professional, avoiding unnecessary questions or information. The closing statement appropriately informed the client about what to expect next.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully completed. The assistant correctly identified the caller's need, confirmed the transfer, and used the transferCall tool with the exact destination number specified in the conditions.	1	{"explanation_score":"Valentina handled this appointment adjustment request perfectly. She identified the client's need for the scheduling department immediately, asked for permission to transfer, and executed the transfer to the correct number once permission was granted. Her responses were concise and professional, avoiding unnecessary questions or information. The closing statement appropriately informed the client about what to expect next.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally and asked how she could help. When the client provided a vague request for 'Scheduling department', she correctly proceeded to the next step without unnecessary questions."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client needed the scheduling department, which handles appointment adjustments. She didn't need to explicitly state this was an appointment adjustment since the client directly requested the scheduling department."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call with 'May I transfer your call to them?' which follows the protocol exactly."},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation, Valentina correctly used the transferCall function with the proper phone number (+17867056064) for the scheduling team."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed since the client agreed to the transfer, but Valentina did properly close the interaction by informing the client that the call was being forwarded and to stay on the line."}]}	1	{"explanation":"The customer is being direct and brief, simply requesting to be connected to the scheduling department. There are no emotional indicators in their messages, just task-focused communication. This appears to be a straightforward service request without any positive or negative emotional content.","key_indicators":["Scheduling department.","Yes."]}	\N	100
533	969	2025-05-24 03:23:58.673	\N	\N	\N	\N	\N	\N	t	The caller inquired about therapy services for babies covered by their Cigna insurance. The representative confirmed they accept Cigna for speech, occupational, and feeding therapies, and the caller requested to be transferred to the reception team for further assistance.	neutral	NEW_CLIENT_SPANISH	0.9	The caller is inquiring about therapy services for babies, asking about insurance coverage with Cigna, and the entire conversation is conducted in Spanish. This indicates a new client seeking information about starting therapy services in Spanish.	Valentina performed excellently by correctly identifying Spanish as the preferred language, recognizing this was a new client inquiry about therapy services and insurance coverage, and following the proper protocol for Spanish-speaking new clients by requesting permission to transfer and executing the transfer to the front desk. The only minor issue was the somewhat confusing response to the client's 'See for follow-up' comment, which Valentina interpreted as needing additional help rather than clarifying what the client meant. This slight misinterpretation is the only reason for not giving a perfect score.	1	The call was successfully transferred to +13055175439, which matches exactly with the expected outcome condition 'Transfer to +13055175439'.	1	{"explanation_score":"Valentina performed excellently by correctly identifying Spanish as the preferred language, recognizing this was a new client inquiry about therapy services and insurance coverage, and following the proper protocol for Spanish-speaking new clients by requesting permission to transfer and executing the transfer to the front desk. The only minor issue was the somewhat confusing response to the client's 'See for follow-up' comment, which Valentina interpreted as needing additional help rather than clarifying what the client meant. This slight misinterpretation is the only reason for not giving a perfect score.","steps_completed":6,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally with 'Hi, this is Always Keep Progressing. How can I help you today?' which was an appropriate opening that invited the client to share their needs."},{"name":"Language Identification","completed":true,"details":"Valentina correctly identified that the client preferred Spanish when they asked 'Maybe you speak Spanish?' and immediately switched to Spanish with 'Hola, claro que sí, hablo español. ¿En qué puedo ayudarte hoy?'"},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client was interested in therapy services for babies and was asking about insurance coverage, which falls under the new client category."},{"name":"Transfer Permission","completed":true,"details":"Valentina appropriately asked for permission to transfer the call with '¿Te gustaría que transfiera tu llamada al equipo de recepción para que puedan asistirte mejor?'"},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation ('Sí'), Valentina correctly used the transferCall function to transfer the call to the front desk at +13055175439 as per protocol for Spanish-speaking new clients."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed as the client agreed to the transfer, but Valentina was prepared to handle the interaction appropriately had the transfer been declined."}]}	1	{"explanation":"The customer is primarily task-focused, seeking information about insurance coverage for baby therapy services. Their messages are brief and direct, showing no clear emotional indicators of satisfaction or dissatisfaction. They're simply trying to get information and schedule a follow-up, switching between languages but maintaining a neutral, practical tone throughout.","key_indicators":["Hello? Maybe you speak Spanish?","Quería preguntarte cómo funcionaban las terapias tenían convenio con el seguro que yo tengo. Que tenían terapia para bebés.","China Cigna.","Same","See for follow-up.","Sí."]}	\N	95
534	970	2025-05-24 03:23:59.197	\N	\N	\N	\N	\N	\N	t	The caller inquired if Always Keep Progressing provides services for adults and was informed that their therapy services are primarily for children. The caller acknowledged this information and declined further assistance.	neutral	GENERAL_INQUIRY	0.9	The caller is asking a basic question about whether the practice serves adults, which is a general inquiry about the services offered. The receptionist was able to answer the question with available information, and the call ended after the caller received this information.	Valentina handled most aspects of this brief interaction well. She correctly identified the inquiry type, provided an accurate answer about the practice's focus on children, and maintained a professional tone. However, she didn't get to complete a proper closure with an explicit offer of additional help before the caller ended the conversation. The incomplete sentence about adult therapy options suggests she was trying to be helpful by providing alternatives, but she didn't get to finish her thought. For improvement, Valentina should try to be more concise in her responses to ensure she can complete important protocol elements like proper closure before callers potentially end the conversation.	0.9	The agent correctly answered the client's question about whether the service sees adults, confirming they primarily serve children. The client's question was fully addressed, and the client indicated they had no further questions with 'No. Thank you.' No transfer to the front desk was needed as the agent was able to handle the inquiry directly.	1	{"explanation_score":"Valentina handled most aspects of this brief interaction well. She correctly identified the inquiry type, provided an accurate answer about the practice's focus on children, and maintained a professional tone. However, she didn't get to complete a proper closure with an explicit offer of additional help before the caller ended the conversation. The incomplete sentence about adult therapy options suggests she was trying to be helpful by providing alternatives, but she didn't get to finish her thought. For improvement, Valentina should try to be more concise in her responses to ensure she can complete important protocol elements like proper closure before callers potentially end the conversation.","steps_completed":3,"total_steps":4,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the caller professionally with the practice name and offered help, which was appropriate for starting the conversation."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that this was a general inquiry about whether the practice serves adults."},{"name":"Answer Questions","completed":true,"details":"Valentina accurately confirmed that the practice primarily serves children, which directly answered the caller's question. However, she started to offer additional information about adult therapy options but was cut off mid-sentence."},{"name":"Closure","completed":false,"details":"Valentina did not explicitly ask if there was anything else she could help with before the caller ended the conversation. She began to offer additional assistance but didn't complete her closing statement before the caller said 'No. Thank you.'"}]}	1	{"explanation":"The customer is direct and brief throughout the conversation, asking a simple question about services and responding with short acknowledgments. There are no clear emotional indicators of either positive or negative sentiment. The brevity appears to be task-focused rather than indicating frustration.","key_indicators":["Hi. You guys don't see adults? No.","Okay.","No. Thank you."]}	\N	85
535	971	2025-05-24 03:23:59.728	\N	\N	\N	\N	\N	\N	t	The caller requested to speak with a representative, specifically for Diego Marshall. After confirming they needed the reception team, the AI agreed to transfer the call to the front desk.	neutral	GENERAL_INQUIRY_TRANSFER	0.6	The caller is speaking Spanish and requesting to speak with a representative. They mention 'Para de Diego Marshall' which seems to be a location or specific department. The caller doesn't specify the exact nature of their inquiry, but they need to be transferred to the front desk, suggesting they have a question that cannot be answered immediately by the current assistant. This best fits GENERAL_INQUIRY_TRANSFER, though with limited information about the specific purpose of the call.	Valentina handled the language transition well and correctly identified this as a general inquiry requiring front desk assistance. She properly asked for permission before transferring and executed the transfer correctly. However, she missed two critical steps: she did not attempt to understand or answer the specific inquiry about 'Diego Marshall' before transferring, and she failed to use the Knowledge Base tool to search for relevant information that might have resolved the inquiry without a transfer. These missed opportunities to provide direct assistance lowered the overall score significantly.	1	The expected outcome was achieved as the call was successfully transferred to +13055175439, which matches the required condition. The assistant correctly identified the need to transfer to the front desk and executed the transfer.	1	{"explanation_score":"Valentina handled the language transition well and correctly identified this as a general inquiry requiring front desk assistance. She properly asked for permission before transferring and executed the transfer correctly. However, she missed two critical steps: she did not attempt to understand or answer the specific inquiry about 'Diego Marshall' before transferring, and she failed to use the Knowledge Base tool to search for relevant information that might have resolved the inquiry without a transfer. These missed opportunities to provide direct assistance lowered the overall score significantly.","steps_completed":5,"total_steps":7,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the caller professionally and asked how she could help. When the caller requested to speak with a representative in Spanish, she appropriately asked for more information to determine the right department."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified this as a general inquiry when the caller mentioned 'Para de Diego Marshall' (likely referring to a person or location), which falls under the general inquiry category requiring front desk assistance."},{"name":"Answer Questions","completed":false,"details":"Valentina did not attempt to answer any questions before proceeding to transfer. She should have tried to understand what specific information the caller needed about Diego Marshall before deciding to transfer."},{"name":"Call Knowledge Base","completed":false,"details":"Valentina did not use the queryKnowledgeBase tool to search for information about 'Diego Marshall' before transferring the call. This was a missed opportunity to potentially resolve the inquiry directly."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call to the front desk team, following protocol."},{"name":"Transfer Execution","completed":true,"details":"After receiving permission, Valentina correctly used the transferCall function with the appropriate front desk number (+13055175439)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed as the caller agreed to the transfer, but Valentina did provide appropriate closure by informing the caller that the call was being forwarded and to stay on the line."}]}	1	{"explanation":"The customer is direct and brief throughout the conversation, simply requesting to speak with a representative and confirming when asked if they want their call transferred. There are no emotional indicators in their messages - they are purely task-focused, seeking to be connected to a specific department.","key_indicators":["Necesito habla con un representante.","Para de Diego Marshall.","Sí. Por favor."]}	\N	75
536	972	2025-05-24 03:24:00.252	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to cancel an appointment. After requesting to cancel, they agreed to be transferred to the scheduling department who could assist with their request.	neutral	APPOINTMENT_ADJUSTMENT	0.9	The caller explicitly states they want to 'Cancel and appointment' which clearly falls under the APPOINTMENT_ADJUSTMENT category that covers canceling, rescheduling, or confirming appointments. The agent transfers them to the scheduling department, confirming this is the appropriate categorization.	Valentina handled this appointment cancellation request perfectly, following all required protocols. She correctly identified the request type as an appointment adjustment, asked for permission to transfer, used the correct transfer number, and provided appropriate closure to the interaction. There were no missed steps or areas for improvement in this interaction.	1	The expected outcome was to transfer the call to scheduling team at +17867056064, which was successfully completed. The assistant recognized the need to transfer the call and used the transferCall tool with the correct destination number.	1	{"explanation_score":"Valentina handled this appointment cancellation request perfectly, following all required protocols. She correctly identified the request type as an appointment adjustment, asked for permission to transfer, used the correct transfer number, and provided appropriate closure to the interaction. There were no missed steps or areas for improvement in this interaction.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally and asked how she could help, which was appropriate for opening the conversation."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client's request to cancel an appointment falls under appointment adjustment, which should be handled by the scheduling team."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call to the scheduling team, following protocol exactly as required."},{"name":"Transfer Execution","completed":true,"details":"After receiving permission, Valentina correctly used the transferCall function with the proper phone number (+17867056064) for the scheduling team."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed in this conversation since the client agreed to the transfer, but Valentina did properly close the interaction by informing the client that their call was being forwarded and to stay on the line."}]}	1	{"explanation":"The customer is being direct and task-focused, simply requesting to cancel an appointment and confirming they want to be transferred. There are no emotional indicators in their brief responses that would suggest either positive or negative sentiment.","key_indicators":["Cancel and appointment.","Yes, please."]}	\N	100
537	975	2025-05-24 03:24:01.658	\N	\N	\N	\N	\N	\N	t	The caller requested an appointment but expressed frustration about speaking with an automated system, stating they "need a rib" and don't want to talk to a machine. The call was transferred to the front desk team for human assistance.	negative	GENERAL_INQUIRY_TRANSFER	0.6	The caller seems to be having difficulty communicating clearly and expresses a desire to speak with a human rather than an automated system. They mention 'appointment' and 'Sedone' (possibly a name) but don't provide clear details. When asked clarifying questions, they respond with 'No' and then request to speak to a person rather than a 'machine'. The call was transferred to the front desk, suggesting this is a general inquiry that couldn't be resolved with the available information.	Valentina handled the basic greeting well and ultimately transferred the call to the right department. However, she made several key mistakes: she misinterpreted the caller's intent initially, didn't recognize the frustration in the caller's tone, failed to ask for permission before transferring, and spent too much time trying to clarify appointment details when the caller clearly wanted to speak to a human. The transfer was correctly executed, but the path to get there was inefficient and potentially frustrating for the caller.	1	The expected outcome was achieved as the assistant successfully transferred the call to +13055175439, which matches the required condition for this call type.	1	{"explanation_score":"Valentina handled the basic greeting well and ultimately transferred the call to the right department. However, she made several key mistakes: she misinterpreted the caller's intent initially, didn't recognize the frustration in the caller's tone, failed to ask for permission before transferring, and spent too much time trying to clarify appointment details when the caller clearly wanted to speak to a human. The transfer was correctly executed, but the path to get there was inefficient and potentially frustrating for the caller.","steps_completed":3,"total_steps":7,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client appropriately and attempted to understand their needs. When faced with unclear responses, she tried to clarify what the caller wanted."},{"name":"Request Type","completed":false,"details":"Valentina misidentified the request type. She initially assumed it was about scheduling an appointment, but the caller's responses were unclear and eventually indicated they wanted to speak to a human, not a machine - which is a general inquiry/transfer request."},{"name":"Answer Questions","completed":false,"details":"There were no specific questions about the practice to answer, but Valentina didn't recognize that the caller was frustrated and simply wanted to speak to a human representative."},{"name":"Call Knowledge Base","completed":false,"details":"Valentina did not use the queryKnowledgeBase tool before transferring. However, in this case, it wasn't necessary as the caller simply wanted to speak to a human."},{"name":"Transfer Permission","completed":false,"details":"Valentina did not explicitly ask for permission to transfer the call. According to the protocol, she should have said something like 'May I transfer your call?' before proceeding with the transfer."},{"name":"Transfer Execution","completed":true,"details":"Valentina correctly transferred the call to the front desk at the appropriate number (+13055175439) once she understood the caller wanted to speak with a human."},{"name":"Alternative Closure","completed":true,"details":"Not applicable as the transfer was executed."}]}	1	{"explanation":"The customer shows clear frustration with the automated system, explicitly stating they don't want to talk to a machine. Their responses are brief and somewhat disjointed, indicating possible frustration with the communication process. The final message directly expresses dissatisfaction with the AI interaction.","key_indicators":["I need a rib. Don't want to talk to no machine."]}	\N	65
550	988	2025-05-24 03:24:08.452	\N	\N	\N	\N	\N	\N	f	The call was very brief with the user only saying "My dear" and "Hello?" while the AI representative from Always Keep Progressing attempted to offer assistance but received minimal engagement.	neutral	MISCALANEOUS	0.9	The caller only says 'My dear' and 'Hello?' without providing any specific request or information. There is no clear indication of the purpose of the call, making it impossible to categorize into any of the more specific call types. This clearly falls into the miscellaneous category as it doesn't fit any other defined category.	Protocol evaluation skipped for MISCALANEOUS call type.	0.9	The expected outcome was not achieved. The caller didn't clearly state their need, and the assistant didn't attempt to determine if they could handle the issue directly or transfer the call to the front desk at +13055175439. The conversation ended prematurely without resolution or transfer.	1	{"explanation_score":"Protocol evaluation skipped for MISCALANEOUS call type.","steps_completed":0,"total_steps":0,"steps":[]}	1	{"explanation":"The customer's messages are very brief and contain no clear emotional indicators. The phrases 'My dear' and 'Hello?' are simply conversational openers without expressing any particular sentiment. This appears to be a task-focused interaction where the user is just initiating conversation.","key_indicators":["My dear.","Hello?"]}	\N	0
538	976	2025-05-24 03:24:02.182	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to inform them they were running late for their appointment at Sundesk. After confirming the caller needed the front desk, the representative transferred the call to the appropriate department.	neutral	TIME_SENSITIVE	0.9	The caller states they are 'running late', which is clearly a time-sensitive matter requiring immediate attention. This is a classic example of a TIME_SENSITIVE call where the patient needs to inform the practice about a delay to their appointment.	Valentina handled this time-sensitive call perfectly, following all required protocols. She properly identified the vague initial response, asked for clarification, correctly categorized 'running late' as a time-sensitive matter, asked permission to transfer, and executed the transfer to the correct number. Her responses were concise and professional throughout, and she provided clear instructions to the caller about staying on the line during the transfer.	1	The expected outcome was to transfer the call to the front desk at +13055175439, which was successfully completed. The assistant recognized the caller's need, confirmed they wanted to be transferred, and then executed the transfer to the correct number.	1	{"explanation_score":"Valentina handled this time-sensitive call perfectly, following all required protocols. She properly identified the vague initial response, asked for clarification, correctly categorized 'running late' as a time-sensitive matter, asked permission to transfer, and executed the transfer to the correct number. Her responses were concise and professional throughout, and she provided clear instructions to the caller about staying on the line during the transfer.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally, asked how she could help, and when faced with the vague response 'Sundesk', she appropriately asked for more details to clarify the request."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that 'Running late' was a time-sensitive matter that should be handled by the front desk team, following the protocol for time-sensitive inquiries."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call with 'May I transfer you?' which follows the protocol exactly."},{"name":"Transfer Execution","completed":true,"details":"After receiving consent, Valentina correctly used the transferCall function with the proper front desk number (+13055175439) as specified in the protocol for time-sensitive matters."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed since the caller agreed to the transfer, but Valentina did properly close the interaction by informing the caller that they were being forwarded to the front desk and to stay on the line."}]}	1	{"explanation":"The customer is being very brief and direct, which indicates they're focused on a specific task rather than expressing emotion. They simply state 'Sundesk' and 'Running late' followed by a confirmation 'Yes' - this brevity suggests they're in a hurry but doesn't necessarily indicate negative feelings toward the service. This appears to be purely task-focused communication without emotional indicators.","key_indicators":["Sundesk.","Running late.","Yes."]}	\N	100
539	977	2025-05-24 03:24:02.712	\N	\N	\N	\N	\N	\N	f	The caller attempted to make an appointment for their son at the Always Keep Progressing clinic but had difficulty communicating clearly. After several attempts to clarify the type of therapy needed, the caller agreed to be transferred to the front desk for further assistance.	neutral	NEW_CLIENT_ENGLISH	0.4	The caller mentions wanting to make an appointment for their son and the assistant identifies them as a new client. However, there are significant communication difficulties as the caller's responses are unclear and don't directly answer questions about therapy type. This could also be MISCALANEOUS due to the communication challenges, but the initial intent appears to be setting up a new client appointment before communication broke down.	Valentina handled the initial steps of the conversation well by greeting the client, identifying them as a new client seeking services for their son, and attempting to determine the type of therapy needed. However, the conversation revealed communication difficulties as the client's responses were unclear or nonsensical (responding with words like 'Nuclei', 'Pizza', 'Derby', etc.). Valentina made appropriate attempts to clarify but ultimately recognized the need to transfer the call to the front desk team. While this was the right decision given the circumstances, she was unable to complete most of the required intake steps due to the communication barriers. The score reflects her good handling of the situation despite challenges, but acknowledges that the full protocol could not be completed.	0.9	The assistant did not collect necessary information or send an intake form. The conversation had communication difficulties, and the assistant ended up transferring the call to the front desk instead of completing the intake process.	1	{"explanation_score":"Valentina handled the initial steps of the conversation well by greeting the client, identifying them as a new client seeking services for their son, and attempting to determine the type of therapy needed. However, the conversation revealed communication difficulties as the client's responses were unclear or nonsensical (responding with words like 'Nuclei', 'Pizza', 'Derby', etc.). Valentina made appropriate attempts to clarify but ultimately recognized the need to transfer the call to the front desk team. While this was the right decision given the circumstances, she was unable to complete most of the required intake steps due to the communication barriers. The score reflects her good handling of the situation despite challenges, but acknowledges that the full protocol could not be completed.","steps_completed":6,"total_steps":11,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally and asked how she could help, which was appropriate for starting the conversation."},{"name":"Language Identification","completed":true,"details":"Valentina correctly identified that the client was speaking English and continued with the intake process accordingly."},{"name":"Request Type","completed":true,"details":"Valentina recognized that the client wanted to make an appointment, which falls under new client services."},{"name":"Client Type Determination","completed":true,"details":"Valentina appropriately asked if the caller was a new client and correctly identified them as such."},{"name":"Service Inquiry","completed":true,"details":"Valentina asked about the type of therapy services and provided options (speech, occupational, feeding, music, and art therapy)."},{"name":"Patient Information","completed":false,"details":"Valentina did not collect basic patient information such as the son's age or specific concerns, though she did acknowledge the appointment was for the caller's son."},{"name":"Insurance Process","completed":false,"details":"Valentina did not inquire about insurance or explain the insurance verification process."},{"name":"Referral Check","completed":false,"details":"Valentina did not ask if the client had a referral form from their doctor."},{"name":"Intake Process","completed":false,"details":"Valentina did not offer to start the intake process or explain next steps."},{"name":"Contact Information","completed":false,"details":"Valentina did not confirm the caller's name, phone number, or best time to contact."},{"name":"Closure","completed":true,"details":"Valentina appropriately recognized communication difficulties and offered to transfer the call to the front desk, which she did successfully after getting client confirmation."}]}	1	{"explanation":"The customer appears to be having difficulty communicating clearly, possibly due to language barriers, confusion, or technical issues. Their responses are brief and sometimes don't directly address the questions, but there are no clear indicators of negative emotions like frustration or anger. When offered to be transferred to the front desk, they respond with 'Thank you. Yes,' which shows basic politeness but not strong positive sentiment.","key_indicators":["I have an applet I wanna make an appointment for my son.","Nuclei.","Pizza.","This Derby.","Um, is the wafer wall. Order.","Thank you. Yes."]}	\N	55
540	978	2025-05-24 03:24:03.221	\N	\N	\N	\N	\N	\N	f	The caller requested to speak with an agent or department, specifically mentioning "servicios" and something about a portal. The AI identified that the authorizations department would be most appropriate and informed the caller they would be transferred there.	neutral	MISCALANEOUS	0.4	The conversation is very fragmented and unclear. The caller speaks in Spanish but provides minimal information about their actual needs. They mention something about a 'departamento en un portal' (department in a portal), but there's not enough context to determine what specific service they're seeking. The assistant attempted to transfer to authorizations, but there's insufficient evidence from the caller's statements to confirm this was the correct call type. I considered AUTHORIZATION as a possibility based on the portal reference, but the information is too limited to make a definitive determination.	Protocol evaluation skipped for MISCALANEOUS call type.	0.9	The agent transferred the call to +17865410923, but the expected outcome specified transferring to +13055175439 if the agent couldn't handle the request directly. The transfer was made to an incorrect number.	1	{"explanation_score":"Protocol evaluation skipped for MISCALANEOUS call type.","steps_completed":0,"total_steps":0,"steps":[]}	1	{"explanation":"The customer's messages are brief and task-focused, with no clear emotional indicators. They appear to be seeking assistance with connecting to a department or service, mixing English and Spanish in their responses. The brevity suggests they recognize they're interacting with an automated system and are being direct rather than expressing frustration.","key_indicators":["Valor o un agente","That 1.","8. Alright.","Servicios yet. And","Yes,","departamento en un portal, ¿qué departamento? Y","Okay,"]}	\N	0
541	979	2025-05-24 03:24:03.734	\N	\N	\N	\N	\N	\N	t	The caller requested to schedule a speech therapy appointment for their daughter in Spanish. The AI representative acknowledged the language preference and transferred the call to the front desk for Spanish assistance.	neutral	NEW_CLIENT_SPANISH	0.8	The caller is speaking Spanish and specifically states 'Quiero sacar una cita para mi hija de terapia de lenguaje' which translates to 'I want to make an appointment for my daughter for speech therapy.' This indicates they are seeking to establish speech therapy services in Spanish. While they are requesting an appointment, there is no indication they are an existing client, so this appears to be a new client inquiry in Spanish.	Valentina handled most aspects of the protocol correctly, including proper greeting, language identification, request type identification, and executing the transfer to the correct department. The main area for improvement is that she did not explicitly ask for permission before transferring the call, which is a required step in the protocol. She also could have responded in Spanish immediately after the client said 'Hola?' instead of asking for clarification in English. However, she did correctly identify the need to transfer a Spanish-speaking new client to the front desk team and executed this properly, providing a clear explanation to the client about the transfer in both languages.	1	The expected outcome was to transfer the call to front desk at +13055175439, which was successfully done. The assistant recognized the caller needed Spanish assistance and properly transferred the call to the specified number.	1	{"explanation_score":"Valentina handled most aspects of the protocol correctly, including proper greeting, language identification, request type identification, and executing the transfer to the correct department. The main area for improvement is that she did not explicitly ask for permission before transferring the call, which is a required step in the protocol. She also could have responded in Spanish immediately after the client said 'Hola?' instead of asking for clarification in English. However, she did correctly identify the need to transfer a Spanish-speaking new client to the front desk team and executed this properly, providing a clear explanation to the client about the transfer in both languages.","steps_completed":5,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client appropriately with 'Hi, this is Always Keep Progressing. How can I help you today?' and attempted to clarify when the initial response was unclear."},{"name":"Language Identification","completed":true,"details":"Valentina correctly identified that the client was speaking Spanish when they said 'Hola?' and the client explicitly mentioned 'Spanish' before continuing in Spanish."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client was requesting speech therapy services for their daughter ('Quiero sacar una cita para mi hija de terapia de lenguaje')."},{"name":"Transfer Permission","completed":false,"details":"Valentina did not explicitly ask for permission to transfer the call. According to the protocol, she should have asked something like 'Me puedes dar más información para transferirte al departamento adecuado?' or directly asked if she could transfer the call."},{"name":"Transfer Execution","completed":true,"details":"Valentina correctly transferred the call to the Front Desk at +13055175439, which is the appropriate action for Spanish-speaking new clients according to the protocol."},{"name":"Alternative Closure","completed":true,"details":"This step was not applicable as the transfer was executed, but Valentina did provide appropriate closure by informing the client about the transfer in both Spanish and English."}]}	1	{"explanation":"The customer is simply trying to communicate in Spanish after initial confusion. They are making a straightforward request for a language therapy appointment for their daughter. There are no emotional indicators of frustration, anger, or particular happiness - just a practical request for service.","key_indicators":["Hola?","Spanish. Quiero sacar una cita para mi hija de terapia de lenguaje"]}	\N	85
542	980	2025-05-24 03:24:04.269	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to adjust an existing appointment. After confirming the caller's needs, the representative transferred the call to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	0.9	The caller explicitly stated they need to 'adjust' an appointment when asked if they were looking to schedule a new appointment or adjust an existing one. This clearly indicates they want to modify an existing appointment, which falls under the APPOINTMENT_ADJUSTMENT category.	Valentina handled this appointment adjustment request excellently, following all the required steps in the protocol. She properly identified the vague request, asked for clarification, correctly determined this was an appointment adjustment needing the scheduling team, requested permission to transfer, and executed the transfer with the correct number. The only minor issue was a small grammatical error in the transfer permission request ('You like me to transfer' instead of 'Would you like me to transfer'), but this didn't impact the effectiveness of the interaction.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully completed. The assistant correctly identified the caller's need to adjust scheduling, offered the transfer, and executed it to the exact number specified in the conditions.	1	{"explanation_score":"Valentina handled this appointment adjustment request excellently, following all the required steps in the protocol. She properly identified the vague request, asked for clarification, correctly determined this was an appointment adjustment needing the scheduling team, requested permission to transfer, and executed the transfer with the correct number. The only minor issue was a small grammatical error in the transfer permission request ('You like me to transfer' instead of 'Would you like me to transfer'), but this didn't impact the effectiveness of the interaction.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally, asked how she could help, and when the client provided a vague request ('Scheduling'), she appropriately asked for more details to clarify what specific scheduling assistance was needed."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client needed to adjust an existing appointment based on the client's response of 'Adjust', which falls under appointment adjustment that should be handled by the scheduling team."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call to the scheduling team with 'You like me to transfer your call to them?' (though there was a minor grammatical error missing 'Would')."},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation from the client, Valentina correctly used the transferCall function with the proper phone number for the scheduling team (+17867056064) as specified in the protocol."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed since the client agreed to the transfer, but Valentina did properly close the interaction by informing the client that the call was being forwarded and instructing them to stay on the line."}]}	1	{"explanation":"The customer is being very direct and brief throughout the conversation, using single-word responses ('Scheduling', 'Adjust', 'Yes'). This indicates a task-focused approach rather than expressing any particular emotion. There are no indicators of frustration, dissatisfaction, happiness, or gratitude - just straightforward communication to accomplish a specific task.","key_indicators":["Scheduling","Adjust","Yes."]}	\N	95
543	981	2025-05-24 03:24:04.796	\N	\N	\N	\N	\N	\N	f	The caller attempted to communicate with Always Keep Progressing but was difficult to understand, first saying "Mama, Swiss Bunny" and then requesting Spanish language assistance. The representative was unable to understand the initial request and asked for clarification.	neutral	NEW_CLIENT_SPANISH	0.5	The caller requested 'Spanish, please' which indicates they need Spanish language services. While this suggests they need Spanish assistance, there's not enough information to determine exactly what type of service they need. I've classified this as NEW_CLIENT_SPANISH with medium-low confidence because new client inquiries are common, but it could also be any of the other Spanish service categories. The limited information makes it difficult to determine the specific nature of their request.	Valentina only completed the initial greeting correctly (15 points). The critical failure was not recognizing and responding to the Spanish language request, which is explicitly mentioned in the protocol. According to the instructions, when a client speaks Spanish, Valentina should immediately switch to Spanish and transfer them to the front desk team at +13055175439. This language barrier prevented the conversation from progressing to identify the client's needs, request transfer permission, execute the transfer, or reach an appropriate closure. For improvement, Valentina should be programmed to immediately recognize language requests and respond accordingly, especially since the instructions state she speaks both Spanish and English.	0.95	The expected outcome was to transfer the caller to the front desk at +13055175439, but no transfer was initiated during the conversation. The assistant did not recognize the caller's request or offer to transfer them.	1	{"explanation_score":"Valentina only completed the initial greeting correctly (15 points). The critical failure was not recognizing and responding to the Spanish language request, which is explicitly mentioned in the protocol. According to the instructions, when a client speaks Spanish, Valentina should immediately switch to Spanish and transfer them to the front desk team at +13055175439. This language barrier prevented the conversation from progressing to identify the client's needs, request transfer permission, execute the transfer, or reach an appropriate closure. For improvement, Valentina should be programmed to immediately recognize language requests and respond accordingly, especially since the instructions state she speaks both Spanish and English.","steps_completed":1,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client appropriately with 'Hi, this is Always Keep Progressing. How can I help you today?' and attempted to clarify when the client's response was unclear with 'Could you clarify or provide more details about what you need help with?'"},{"name":"Language Identification","completed":false,"details":"Valentina failed to recognize and respond in Spanish when the client explicitly requested 'Spanish, please.' According to the protocol, she should have immediately switched to Spanish."},{"name":"Request Type","completed":false,"details":"The conversation did not progress far enough to identify the request type, as Valentina did not properly address the language barrier first."},{"name":"Transfer Permission","completed":false,"details":"Valentina did not ask for permission to transfer the call to the front desk team, which is required for Spanish-speaking new clients."},{"name":"Transfer Execution","completed":false,"details":"No transfer was executed to the front desk at +13055175439, which is required for Spanish-speaking clients."},{"name":"Alternative Closure","completed":false,"details":"The conversation did not reach a closure point, as the language barrier was not properly addressed."}]}	1	{"explanation":"The customer's messages are brief and direct, with no clear emotional indicators. They appear to be testing the system or requesting a language change to Spanish, but don't express any positive or negative emotions. This brevity likely indicates task-focused communication rather than emotional engagement.","key_indicators":["Hello?","Mama, Swiss Bunny.","Spanish, please."]}	\N	15
544	982	2025-05-24 03:24:05.305	\N	\N	\N	\N	\N	\N	t	A representative from Aetna called Always Keep Progressing to inquire if they offer fish therapy. The representative was informed that they don't provide fish therapy but rather speech, occupational, feeding, music, and art therapy, after which they declined further information.	neutral	GENERAL_INQUIRY	0.9	The caller from Aetna is asking if the practice offers fish therapy, which is a general question about the services provided by the practice. This clearly falls under GENERAL_INQUIRY as they are seeking information about the practice's services, and the question was answered with available information. The caller did not indicate they were a new client seeking services, an existing client, or asking about billing or other specific matters.	Valentina handled this general inquiry excellently, following all required steps of the protocol. She correctly identified that the caller was asking about a service (fish therapy) that AKP doesn't offer, politely informed them of this fact, and provided information about available services instead. She maintained professionalism throughout, closed appropriately, and when faced with an ambiguous statement at the end ('It is that'), she properly asked for clarification. The only minor improvement could be to perhaps ask if there was anything else she could help with before closing the first time, though she did address this by asking for clarification when the caller made an additional comment.	0.9	The assistant correctly informed the caller that they don't offer fish therapy and provided information about the services they do offer. When the caller said 'No. Thank you,' the assistant appropriately concluded the call. When the caller made an unclear statement ('It is that'), the assistant asked for clarification. The assistant solved the client's question about whether they offer fish therapy before concluding the interaction.	1	{"explanation_score":"Valentina handled this general inquiry excellently, following all required steps of the protocol. She correctly identified that the caller was asking about a service (fish therapy) that AKP doesn't offer, politely informed them of this fact, and provided information about available services instead. She maintained professionalism throughout, closed appropriately, and when faced with an ambiguous statement at the end ('It is that'), she properly asked for clarification. The only minor improvement could be to perhaps ask if there was anything else she could help with before closing the first time, though she did address this by asking for clarification when the caller made an additional comment.","steps_completed":4,"total_steps":4,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the caller professionally, identified herself as representing Always Keep Progressing, and asked how she could help. This was a clear and appropriate opening."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified this as a general inquiry about services. When the caller asked about 'fish therapy,' she recognized this as a service inquiry and responded appropriately."},{"name":"Answer Questions","completed":true,"details":"Valentina correctly informed the caller that fish therapy is not offered and provided information about the services that are available (speech, occupational, feeding, music, and art therapy). She also offered to provide more information if desired."},{"name":"Closure","completed":true,"details":"Valentina thanked the caller and closed the conversation professionally. When the caller made an unclear statement ('It is that'), she appropriately asked for clarification to ensure she understood the caller's needs."}]}	1	{"explanation":"The customer's messages are brief and direct, indicating a task-focused interaction rather than an emotional one. They appear to be making an inquiry about services, and when informed that fish therapy isn't offered, they politely end the conversation with a simple 'No. Thank you.' Their final message 'It is that' is ambiguous but doesn't convey strong emotion. This pattern suggests a neutral, business-like interaction.","key_indicators":["Hello. This is Aetna. I'm calling to see if this is fish therapy.","No. Thank you.","It is that."]}	\N	95
545	983	2025-05-24 03:24:05.822	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to report a late arrival and was transferred to the front desk department after confirming they needed assistance with this matter.	neutral	TIME_SENSITIVE	0.9	The caller clearly states 'Late arrival' which indicates they are informing the practice that they will be arriving late for an appointment. This is a time-sensitive matter that requires immediate attention from the front desk, making it a clear TIME_SENSITIVE call type.	Valentina handled this time-sensitive call perfectly, following all required protocols. She quickly recognized the nature of the request despite initial vagueness, correctly identified it as a time-sensitive matter requiring front desk assistance, properly asked for permission to transfer, and executed the transfer to the correct number. Her responses were concise and professional throughout, and she provided appropriate closure by informing the caller about the transfer.	1	The expected outcome was to transfer the call to the front desk at +13055175439, which was successfully done. The assistant correctly identified the need for a transfer and used the transferCall tool with the exact destination number specified in the conditions.	1	{"explanation_score":"Valentina handled this time-sensitive call perfectly, following all required protocols. She quickly recognized the nature of the request despite initial vagueness, correctly identified it as a time-sensitive matter requiring front desk assistance, properly asked for permission to transfer, and executed the transfer to the correct number. Her responses were concise and professional throughout, and she provided appropriate closure by informing the caller about the transfer.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally and asked how she could help. When faced with a vague request ('Make arrival'), she began to clarify but the client quickly provided more specific information ('Late arrival')."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that 'Late arrival' is a time-sensitive matter that should be handled by the front desk team, in accordance with the protocol for time-sensitive inquiries."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call with 'May I transfer your call to them?' which follows the protocol exactly."},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation, Valentina correctly used the transferCall function with the proper front desk number (+13055175439) as specified in the protocol for time-sensitive matters."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed since the caller agreed to the transfer, but Valentina did properly close the interaction by informing the caller that they were being forwarded to the front desk."}]}	1	{"explanation":"The customer is being very brief and direct, using minimal words to communicate their need about a late arrival. This appears to be task-focused communication without emotional indicators. They respond with simple confirmation when asked if they want to be transferred. This directness suggests they're focused on solving their issue efficiently rather than expressing any particular emotion.","key_indicators":["Make arrival.","Late arrival.","Yes."]}	\N	100
546	984	2025-05-24 03:24:06.344	\N	\N	\N	\N	\N	\N	t	The caller requested to speak with someone named Priscila. The AI greeted them in Spanish and then transferred the call to the front desk reception team who could connect them with the specific person they were asking for.	neutral	LOOKING_FOR_SOMEONE	0.9	The caller clearly states 'Con Priscila' which translates to 'With Priscila', indicating they are specifically looking to speak with someone named Priscila. This is a straightforward request to speak with a specific person, which falls directly under the LOOKING_FOR_SOMEONE category.	Valentina handled most aspects of this call well, including greeting the caller professionally, recognizing the Spanish language need, identifying that the caller was looking for a specific person, and correctly transferring to the front desk. The main area for improvement is that she did not explicitly ask for permission before transferring the call, which is a required step in the protocol. While she did inform the caller about the transfer, obtaining consent first would have been more aligned with the guidelines. Otherwise, her handling of the multilingual interaction and proper use of the transfer function were strengths.	1	The call was successfully transferred to +13055175439, which matches the expected outcome of 'Transfer to front desk'. The agent correctly identified the need to transfer the call and used the transferCall tool with the correct destination number.	1	{"explanation_score":"Valentina handled most aspects of this call well, including greeting the caller professionally, recognizing the Spanish language need, identifying that the caller was looking for a specific person, and correctly transferring to the front desk. The main area for improvement is that she did not explicitly ask for permission before transferring the call, which is a required step in the protocol. While she did inform the caller about the transfer, obtaining consent first would have been more aligned with the guidelines. Otherwise, her handling of the multilingual interaction and proper use of the transfer function were strengths.","steps_completed":4,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the caller professionally and asked how she could help. When the caller responded in Spanish, she appropriately switched to Spanish and asked for more information to determine how to direct the call."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the caller was looking for a specific person (Priscila) based on the caller's response 'Con Priscila'."},{"name":"Transfer Permission","completed":false,"details":"Valentina did not explicitly ask for permission to transfer the call. According to the protocol, she should have asked something like '¿Puedo transferirte?' before proceeding with the transfer."},{"name":"Transfer Execution","completed":true,"details":"Valentina correctly used the transferCall function to transfer the call to the front desk at +13055175439, which is the appropriate action for someone looking for a specific person."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't necessary as the transfer was executed, but Valentina did provide a proper closure by informing the caller that she was being transferred and to stay on the line."}]}	1	{"explanation":"The customer's messages are brief and purely task-focused. They simply greet with 'Sí, buenos días' and then state they want to speak with someone named 'Priscila'. There are no emotional indicators in either direction - no signs of frustration or happiness. This appears to be a straightforward request for a transfer to a specific person.","key_indicators":["Sí, buenos días.","Con Priscila"]}	\N	85
547	985	2025-05-24 03:24:06.899	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to confirm an appointment. After the caller requested confirmation, the representative offered to transfer them to the scheduling department, which the caller accepted.	neutral	APPOINTMENT_ADJUSTMENT	0.9	The caller explicitly stated they want to 'Confirm an appointment,' which falls directly under the APPOINTMENT_ADJUSTMENT category that includes confirming appointments for existing clients. This is a clear and straightforward request that matches this category definition.	Valentina handled this appointment confirmation request excellently, following all required protocols. She correctly identified the request type, asked for permission to transfer, and executed the transfer to the right department with the correct phone number. The only minor improvement would be to fix the small grammatical error in her transfer offer ('can you with confirming' instead of 'can assist you with confirming'), but this didn't impact the effectiveness of the interaction. Overall, this was a very well-handled call that efficiently directed the client to the appropriate department.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully completed. The assistant recognized the need for a transfer, confirmed with the user, and executed the transfer to the correct number.	1	{"explanation_score":"Valentina handled this appointment confirmation request excellently, following all required protocols. She correctly identified the request type, asked for permission to transfer, and executed the transfer to the right department with the correct phone number. The only minor improvement would be to fix the small grammatical error in her transfer offer ('can you with confirming' instead of 'can assist you with confirming'), but this didn't impact the effectiveness of the interaction. Overall, this was a very well-handled call that efficiently directed the client to the appropriate department.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally and asked how she could help, which was appropriate. When the client stated they wanted to confirm an appointment, she understood the request without needing to ask for clarification."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that confirming an appointment falls under appointment adjustments that should be handled by the scheduling team."},{"name":"Transfer Permission","completed":true,"details":"Valentina appropriately asked for permission to transfer the call to the scheduling team, following protocol."},{"name":"Transfer Execution","completed":true,"details":"After receiving permission, Valentina correctly used the transferCall function with the proper phone number for the scheduling team (+17867056064)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed since the client agreed to the transfer, but Valentina did properly close the interaction by informing the client that their call was being forwarded and to stay on the line."}]}	1	{"explanation":"The customer is being direct and task-focused, using minimal responses to accomplish their goal of confirming an appointment. There are no emotional indicators in their brief messages, just practical communication to complete their task.","key_indicators":["Confirm an appointment.","Yes."]}	\N	95
548	986	2025-05-24 03:24:07.428	\N	\N	\N	\N	\N	\N	f	The call was very brief, with the representative from Always Keep Progressing greeting the caller and offering assistance, but the caller only responded with "Oigo" (Spanish for "I hear") and did not continue the conversation.	neutral	GENERAL_INQUIRY	0.4	The caller only said 'Oigo' which means 'I hear' in Spanish, indicating they can hear the assistant but haven't yet stated their purpose for calling. Without any specific request or question from the caller, I'm classifying this as a GENERAL_INQUIRY with low confidence. Alternative possibilities include NEW_CLIENT_SPANISH or any other category, as the caller has not provided enough information to determine their specific need.	Valentina only completed the initial greeting correctly but failed to recognize and respond to the Spanish word 'Oigo' (I hear), despite being instructed that she speaks both English and Spanish. According to the protocol, when a caller speaks Spanish, Valentina should respond in Spanish and ask for more information to determine the appropriate department for transfer. The conversation stalled after the caller's first response, resulting in a poor user experience. To improve, Valentina should have recognized the Spanish language cue and continued the conversation in Spanish, asking for more details about the caller's needs.	0.9	The conversation was extremely brief and the agent did not solve any client questions. The user only said 'Oigo' (which means 'I hear' in Spanish) and the agent did not have an opportunity to address any concerns or transfer the call if needed. The expected outcome of solving client questions was not achieved.	1	{"explanation_score":"Valentina only completed the initial greeting correctly but failed to recognize and respond to the Spanish word 'Oigo' (I hear), despite being instructed that she speaks both English and Spanish. According to the protocol, when a caller speaks Spanish, Valentina should respond in Spanish and ask for more information to determine the appropriate department for transfer. The conversation stalled after the caller's first response, resulting in a poor user experience. To improve, Valentina should have recognized the Spanish language cue and continued the conversation in Spanish, asking for more details about the caller's needs.","steps_completed":1,"total_steps":4,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina properly greeted the caller with the practice name and asked how she could help, which is appropriate for beginning the conversation."},{"name":"Request Type","completed":false,"details":"Valentina did not have the opportunity to identify the request type as the caller only said 'Oigo' (Spanish for 'I hear'). This indicates the caller might be Spanish-speaking, but Valentina did not acknowledge this or attempt to respond in Spanish."},{"name":"Answer Questions","completed":false,"details":"No questions were asked by the caller that required answering. However, Valentina missed an opportunity to acknowledge that the caller spoke Spanish and offer assistance in that language, despite being instructed that she speaks both English and Spanish."},{"name":"Closure","completed":false,"details":"The conversation did not progress to a point where closure was appropriate, as Valentina did not respond to the caller's Spanish statement."}]}	1	{"explanation":"The customer's single-word response 'Oigo' is brief and direct, which suggests they are being task-focused rather than expressing any particular emotion. There are no clear indicators of positive or negative sentiment in this very limited interaction.","key_indicators":["Oigo."]}	\N	25
549	987	2025-05-24 03:24:07.94	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to request a schedule change in Spanish. After confirming this was a scheduling matter, the AI representative forwarded the call to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	0.9	The caller clearly states 'Necesito cambiar eh, un horario' which translates to 'I need to change a schedule/appointment time.' This is a direct request to modify an existing appointment, which falls under the APPOINTMENT_ADJUSTMENT category for existing clients looking to reschedule appointments in Spanish.	Valentina handled this Spanish-language appointment adjustment request very well, correctly identifying the request type and following the proper protocol for transferring to the scheduling team. The assistant demonstrated appropriate language skills by responding in Spanish to the Spanish-speaking client. The only minor improvement could be in the transfer permission step, where Valentina could have more explicitly asked 'Would you like me to transfer your call to them?' as specified in the protocol, rather than just implying the transfer. However, the client clearly understood and consented, so the interaction was still successful.	1	The expected outcome was to transfer the call to scheduling team at +17867056064, which was successfully done. The agent recognized the caller needed to change a schedule, identified the need for transfer, and correctly transferred the call to the specified number.	1	{"explanation_score":"Valentina handled this Spanish-language appointment adjustment request very well, correctly identifying the request type and following the proper protocol for transferring to the scheduling team. The assistant demonstrated appropriate language skills by responding in Spanish to the Spanish-speaking client. The only minor improvement could be in the transfer permission step, where Valentina could have more explicitly asked 'Would you like me to transfer your call to them?' as specified in the protocol, rather than just implying the transfer. However, the client clearly understood and consented, so the interaction was still successful.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally and asked how she could help, which was appropriate for opening the conversation."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client was requesting an appointment change ('Necesito cambiar eh, un horario' means 'I need to change a schedule/appointment') and recognized this as an appointment adjustment that should be handled by the scheduling team."},{"name":"Transfer Permission","completed":true,"details":"Valentina implied the need for transfer by stating 'Parece que nuestro equipo de programación puede ayudarte con eso' (It seems our scheduling team can help you with that), and the client confirmed with 'Sí' (Yes), giving permission for the transfer."},{"name":"Transfer Execution","completed":true,"details":"Valentina correctly used the transferCall function with the appropriate number (+17867056064) for the scheduling team as specified in the protocol for appointment adjustments."},{"name":"Alternative Closure","completed":true,"details":"Since the client agreed to the transfer, Valentina appropriately informed them that the call was being forwarded and instructed them to stay on the line, which is a proper closure for a transfer scenario."}]}	1	{"explanation":"The customer is being direct and task-focused, simply stating their need to change a schedule and confirming with a brief 'Sí.' There are no emotional indicators in their messages, positive or negative. This appears to be a straightforward service request without emotional content.","key_indicators":["Necesito cambiar eh, un horario.","Sí."]}	\N	95
551	989	2025-05-24 03:24:09.067	\N	\N	\N	\N	\N	\N	t	The caller requested assistance in Spanish regarding a document. After confirming they needed help with documentation, the agent offered to transfer them to the front desk, which the caller accepted.	neutral	GENERAL_INQUIRY	0.5	The caller requested help 'para un documento' (for a document) in Spanish, which appears to be a general inquiry about documentation. However, the request is very brief and lacks specifics about what type of document they need or why. This could potentially be MISCALANEOUS or even BILLING (if it's a billing document), but with the limited information provided, GENERAL_INQUIRY seems most appropriate as they're asking for assistance with documentation from the practice.	Valentina handled the language switch appropriately and correctly identified this as a document request that needed transfer to the front desk. She followed protocol by asking for permission before transferring. The main area for improvement is in the closure - she should have asked if there was anything else she could help with before proceeding with the transfer, even though the caller had already given permission to transfer. The transfer itself was executed correctly using the proper tool and phone number.	0.9	The agent correctly identified that the caller needed help with a document and needed Spanish assistance. Since the caller requested a transfer, the agent appropriately transferred them to the front desk, which aligns with the expected outcome of 'transfer to front desk if needed' when unable to directly solve the issue.	1	{"explanation_score":"Valentina handled the language switch appropriately and correctly identified this as a document request that needed transfer to the front desk. She followed protocol by asking for permission before transferring. The main area for improvement is in the closure - she should have asked if there was anything else she could help with before proceeding with the transfer, even though the caller had already given permission to transfer. The transfer itself was executed correctly using the proper tool and phone number.","steps_completed":3,"total_steps":4,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the caller professionally and asked how she could help. When the caller requested Spanish, she immediately accommodated by switching to Spanish and asked for more information about their needs."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that this was a general inquiry about documentation ('Para un documento'). She recognized this was a front desk matter that required transfer."},{"name":"Answer Questions","completed":true,"details":"Valentina understood that the document request needed to be handled by the front desk team. She didn't need to use the Knowledge Base as this was a straightforward transfer situation."},{"name":"Closure","completed":false,"details":"Valentina did not ask if there was anything else she could help with before transferring the call. She simply stated she was forwarding the call to the front desk."}]}	1	{"explanation":"The customer is being direct and brief, simply requesting service in Spanish and asking for help with a document. There are no emotional indicators in their messages, just task-focused communication. The brevity indicates a purely functional interaction rather than negative sentiment.","key_indicators":["Sí. Español, por favor.","Para un documento","Por favor,"]}	\N	85
552	990	2025-05-24 03:24:09.594	\N	\N	\N	\N	\N	\N	f	The caller seemed confused during the conversation, initially mentioning they were "doing the meeting" and later referring to "listing clothes." They expressed uncertainty about their needs, eventually stating they were "reviewing the phone and maybe the 1" without providing clear information about what assistance they required.	neutral	MISCALANEOUS	0.9	The caller's statements are unclear and don't fit into any of the specific categories. They make disjointed comments like 'I'm doing the meeting,' 'Just listing your clothes,' and 'I need phone 1 to talk.' These statements don't indicate a specific therapy-related request, appointment need, billing question, or any other categorizable purpose. The conversation lacks coherence and a clear purpose, making MISCALANEOUS the appropriate classification.	Protocol evaluation skipped for MISCALANEOUS call type.	0.9	The expected outcome was not achieved. The caller's requests were unclear and confusing, but when they mentioned 'phone 1 to talk' and seemed to need assistance that couldn't be handled directly, the agent should have offered to transfer them to the front desk at +13055175439. Instead, the agent continued trying to clarify the caller's needs without offering the transfer.	1	{"explanation_score":"Protocol evaluation skipped for MISCALANEOUS call type.","steps_completed":0,"total_steps":0,"steps":[]}	1	{"explanation":"The customer's messages are brief and somewhat disjointed, but don't show clear positive or negative emotions. They appear to be exploring or testing the system rather than expressing frustration or satisfaction. Their responses indicate some confusion but not emotional distress.","key_indicators":["I'm doing the meeting.","I'm doing well. Hello?","Just listing your clothes. That's what I'm telling you. Okay.","What was that?","I need, um, phone 1 to talk.","I I don't know. I'm just reviewing the phone and maybe the 1."]}	\N	0
553	991	2025-05-24 03:24:10.114	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing regarding scheduling and identified themselves as an existing client. The representative offered to transfer the call to the scheduling department, which the caller accepted.	neutral	APPOINTMENT_ADJUSTMENT	0.6	The caller identifies themselves as an 'existing' client and mentions 'scheduling', which suggests they want to make changes to an existing appointment. However, they don't specify exactly what they want to do with their appointment (schedule new, reschedule, cancel, etc.), which is why I'm using a medium confidence score. NEW_APPOINTMENT_EXISTING_CLIENT was also considered, but without clear indication they want to book a new appointment versus modify an existing one, APPOINTMENT_ADJUSTMENT seems more appropriate as a general category for existing client scheduling needs.	The assistant followed the protocol correctly by identifying an existing client with a scheduling need and transferring to the appropriate department. However, there were some issues with conversation flow: the assistant seemed confused when the client only said 'Scheduling' and asked multiple questions at once ('Are you a new client or an existing 1? Are you still there?'). There was also a minor error in phrasing ('existing appointment' instead of 'existing client'). The final transfer message had a typo ('Am forwarding' instead of 'I am forwarding'). These small issues affected clarity but the core protocol was followed correctly.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully done. The assistant identified the caller as an existing client needing scheduling assistance and properly transferred the call to the specified number.	1	{"explanation_score":"The assistant followed the protocol correctly by identifying an existing client with a scheduling need and transferring to the appropriate department. However, there were some issues with conversation flow: the assistant seemed confused when the client only said 'Scheduling' and asked multiple questions at once ('Are you a new client or an existing 1? Are you still there?'). There was also a minor error in phrasing ('existing appointment' instead of 'existing client'). The final transfer message had a typo ('Am forwarding' instead of 'I am forwarding'). These small issues affected clarity but the core protocol was followed correctly.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client appropriately and attempted to gather information about their needs. When faced with a vague 'Scheduling' response, the assistant tried to clarify by asking follow-up questions about client status."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified that this was an appointment adjustment request for an existing client, which should be handled by the scheduling team."},{"name":"Transfer Permission","completed":true,"details":"The assistant properly asked for permission to transfer the call with: 'It seems that our scheduling team can assist you with that. Would you like me to transfer your call to them?'"},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation ('Yeah'), the assistant correctly used the transferCall function with the proper scheduling team number (+17867056064)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed as the client agreed to the transfer, but the assistant was prepared to handle this scenario based on their protocol adherence throughout the conversation."}]}	1	{"explanation":"The customer is being very brief and task-focused throughout the conversation, using minimal responses like 'Scheduling', 'Yes', 'Existing', and 'Yeah'. There are no emotional indicators in their messages, either positive or negative. This appears to be a purely functional interaction where the customer is seeking scheduling assistance in an efficient manner.","key_indicators":["Scheduling","Yes.","Existing.","Yeah."]}	\N	85
554	992	2025-05-24 03:24:10.628	\N	\N	\N	\N	\N	\N	f	A new client called Always Keep Progressing requesting to speak with a representative about service. After minimal details were provided, the caller was transferred to the front desk team.	neutral	NEW_CLIENT_ENGLISH	0.6	The caller identifies themselves as a new client saying 'I'm a new client' and is requesting to speak with a representative. While they don't explicitly state they want to start therapy services, as a new client seeking to speak with a representative at a therapy practice, this most closely aligns with NEW_CLIENT_ENGLISH. The confidence is moderate because the caller doesn't specifically mention therapy services, but they do clearly state they are a new client seeking assistance.	Valentina handled the initial greeting and client type determination well, but made a premature decision to transfer the call without fully exploring the client's needs. The client was somewhat resistant, repeatedly asking to speak with a representative, but Valentina could have made one more attempt to understand their specific service needs before transferring. There was also a grammatical error in her response ('This way I can Got it'). The transfer itself was executed correctly using the appropriate tool. For improvement, Valentina should try to gather at least basic information about the client's service needs before offering to transfer, even with resistant clients, and should ensure responses are grammatically correct.	0.8	The assistant did not collect necessary information or offer/send an intake form to the client. Instead, they transferred the call to the front desk without gathering details or offering the intake form as required by the expected outcome.	1	{"explanation_score":"Valentina handled the initial greeting and client type determination well, but made a premature decision to transfer the call without fully exploring the client's needs. The client was somewhat resistant, repeatedly asking to speak with a representative, but Valentina could have made one more attempt to understand their specific service needs before transferring. There was also a grammatical error in her response ('This way I can Got it'). The transfer itself was executed correctly using the appropriate tool. For improvement, Valentina should try to gather at least basic information about the client's service needs before offering to transfer, even with resistant clients, and should ensure responses are grammatically correct.","steps_completed":4,"total_steps":11,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client appropriately and asked how she could help. When the client was vague ('I need to speak with a representative'), she correctly asked for more details."},{"name":"Language Identification","completed":true,"details":"Valentina correctly identified that the client was speaking English and continued the conversation in English."},{"name":"Request Type","completed":false,"details":"Valentina did not properly identify the request type. The client only mentioned 'service' and wanting to speak with a representative, but Valentina didn't probe further to understand what specific service they needed."},{"name":"Client Type Determination","completed":true,"details":"Valentina successfully confirmed that the caller was a new client."},{"name":"Service Inquiry","completed":false,"details":"Valentina attempted to ask about the type of therapy services, but didn't complete this step as the client insisted on speaking with a representative."},{"name":"Patient Information","completed":false,"details":"Valentina did not collect any patient information as the conversation was redirected to transferring the call."},{"name":"Insurance Process","completed":false,"details":"The conversation did not reach this step as Valentina decided to transfer the call before discussing insurance."},{"name":"Referral Check","completed":false,"details":"The conversation did not reach this step as Valentina decided to transfer the call before asking about referrals."},{"name":"Intake Process","completed":false,"details":"The conversation did not reach this step as Valentina decided to transfer the call before explaining the intake process."},{"name":"Contact Information","completed":false,"details":"Valentina did not collect or confirm any contact information before transferring the call."},{"name":"Closure","completed":true,"details":"Valentina properly closed the interaction by informing the client that she was transferring them to the front desk and instructing them to stay on the line."}]}	1	{"explanation":"The customer is direct and task-focused throughout the conversation, indicating they recognize they're interacting with an automated system. They consistently express a single goal of speaking with a representative without showing clear emotional indicators of frustration or satisfaction. Their brief responses are typical of someone trying to efficiently navigate an automated system rather than showing negative sentiment.","key_indicators":["I need to speak with a representative.","Yeah. I'm a new client. Connect me with a representative.","To speak for the representative, this is I need to speak","Yeah."]}	\N	55
555	994	2025-05-24 03:24:11.482	\N	\N	\N	\N	\N	\N	f	The caller connected with Always Keep Progressing but didn't have a specific request or question. After brief hesitation and an apology, the caller ended the conversation without discussing any particular issue.	neutral	MISCALANEOUS	0.9	The caller doesn't express any specific request or purpose for the call. They simply say 'Hello?', 'I'm sorry', and 'Okay. Bye.' without stating any reason for calling. Since this doesn't fit into any of the other defined categories and there's no clear purpose to the call, it's best classified as MISCALANEOUS.	Protocol evaluation skipped for MISCALANEOUS call type.	0.9	The caller ended the conversation without stating their need, so the agent couldn't determine if they needed to handle the issue directly or transfer to the front desk. The expected outcome requires either providing assistance or transferring to +13055175439, neither of which occurred.	1	{"explanation_score":"Protocol evaluation skipped for MISCALANEOUS call type.","steps_completed":0,"total_steps":0,"steps":[]}	1	{"explanation":"The customer's messages are brief and minimal, showing neither clear positive nor negative emotions. Their responses of 'Hello?', 'Oh, okay. I'm sorry.' and 'Okay. Bye.' indicate a basic, task-focused interaction without emotional investment. The apology appears to be a social nicety rather than expressing actual distress, and the farewell is standard and neutral.","key_indicators":["Hello?","Oh, okay. I'm sorry.","Okay. Bye."]}	\N	0
556	995	2025-05-24 03:24:12.009	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing in Spanish to cancel an appointment. After the caller confirmed they wanted to cancel an appointment, the agent offered to transfer them to the scheduling department, which the caller accepted.	neutral	APPOINTMENT_ADJUSTMENT	0.9	The caller clearly states 'Cancelar una cita' which translates to 'Cancel an appointment' in English. This is a straightforward request to cancel an existing appointment, which falls directly under the APPOINTMENT_ADJUSTMENT category that covers cancellations, rescheduling, or confirming appointments in either English or Spanish.	Valentina handled this appointment cancellation request perfectly. She demonstrated excellent language adaptability by switching to Spanish, correctly identified the request type as an appointment adjustment, properly asked for permission to transfer, executed the transfer to the correct department number, and provided a clear closing statement. There were no protocol violations or missed steps in this interaction.	1	The expected outcome was to transfer the call to scheduling team at +17867056064, which was successfully done. The assistant recognized the caller's need to cancel an appointment and properly transferred the call to the specified number.	1	{"explanation_score":"Valentina handled this appointment cancellation request perfectly. She demonstrated excellent language adaptability by switching to Spanish, correctly identified the request type as an appointment adjustment, properly asked for permission to transfer, executed the transfer to the correct department number, and provided a clear closing statement. There were no protocol violations or missed steps in this interaction.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally and when the client responded in Spanish, she immediately switched to Spanish to accommodate them, showing good language adaptability."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client wanted to cancel an appointment ('Cancelar una cita') which falls under appointment adjustment that should be handled by the scheduling team."},{"name":"Transfer Permission","completed":true,"details":"Valentina appropriately asked for permission to transfer the call in Spanish ('¿Te gustaría que transfiera tu llamada?') after identifying the need to connect with the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation ('Sí'), Valentina correctly used the transferCall function with the proper scheduling team number (+17867056064) as specified in the protocol."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed since the client agreed to the transfer, but Valentina did properly close the interaction by informing the client that they were being transferred to the scheduling department."}]}	1	{"explanation":"The customer is being direct and brief throughout the conversation, simply stating their need to cancel an appointment and confirming they want their call transferred. There are no emotional indicators in their messages, just task-focused communication.","key_indicators":["Hola,","Cancelar una cita.","Sí."]}	\N	100
557	996	2025-05-24 03:24:12.537	\N	\N	\N	\N	\N	\N	t	The caller, Mr. Desmond, made unclear requests about "seeking sponge" and "people who pick Spanish," leading to communication difficulties. The representative offered to transfer the call to the front desk team for better assistance.	neutral	MISCALANEOUS	0.8	The caller's statements are unclear and don't fit into any of the specific categories. They mention 'Mr. Desmond', 'seek sponge', and 'pick Spanish', but these phrases don't clearly indicate a new client inquiry, appointment request, billing question, or any other specific category. The disjointed and unclear nature of the communication suggests this falls into the miscellaneous category.	Protocol evaluation skipped for MISCALANEOUS call type.	0.9	The assistant correctly transferred the call to the front desk (+13055175439) when they couldn't understand or directly handle the caller's request, which aligns with the expected outcome for this call type.	1	{"explanation_score":"Protocol evaluation skipped for MISCALANEOUS call type.","steps_completed":0,"total_steps":0,"steps":[]}	1	{"explanation":"The customer's messages are brief and somewhat unclear, but don't show clear emotional indicators of frustration or satisfaction. They appear to be trying to communicate a need but there may be a language barrier or communication difficulty. The brevity suggests task-focused communication rather than emotional expression.","key_indicators":["Mr. Desmond","I need people to seek sponge.","And you people who pick Spanish?","Just pick up sponge."]}	\N	0
558	997	2025-05-24 03:24:13.057	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing requesting an appointment. After identifying as an existing client, they agreed to be transferred to the scheduling team.	neutral	APPOINTMENT_ADJUSTMENT	0.5	The caller only says 'Appointment' and 'Resisting' (which may be a transcription error for 'existing'). This suggests they are an existing client with an appointment-related need. Since they don't specify wanting a new appointment, it's more likely they want to adjust an existing one, but the limited information makes it difficult to determine with high confidence. NEW_APPOINTMENT_EXISTING_CLIENT was also considered.	Valentina followed the appointment adjustment protocol correctly by identifying the request type, asking for transfer permission, and executing the transfer to the scheduling team. However, there were some minor issues: (1) She didn't fully clarify what the client meant by 'Resisting' which was likely a speech-to-text error for 'existing', (2) There were some grammatical errors in her responses ('can you with your appointment' instead of 'can assist you with your appointment'), and (3) The final transfer message was cut off ('I am forwarding your call to the schedule Please stay on the line' instead of 'scheduling team'). These small communication issues slightly reduced clarity but didn't prevent successful handling of the call.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully done. The assistant recognized the appointment request, offered to transfer the call, and then executed the transfer to the correct number when the user agreed.	1	{"explanation_score":"Valentina followed the appointment adjustment protocol correctly by identifying the request type, asking for transfer permission, and executing the transfer to the scheduling team. However, there were some minor issues: (1) She didn't fully clarify what the client meant by 'Resisting' which was likely a speech-to-text error for 'existing', (2) There were some grammatical errors in her responses ('can you with your appointment' instead of 'can assist you with your appointment'), and (3) The final transfer message was cut off ('I am forwarding your call to the schedule Please stay on the line' instead of 'scheduling team'). These small communication issues slightly reduced clarity but didn't prevent successful handling of the call.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client appropriately and asked how she could help. When the client provided a vague response ('Appointment'), she attempted to gather more information by asking if they were a new or existing client."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client's request was related to appointment adjustment when the client mentioned 'Resisting' (likely meaning 'existing' client with appointment needs)."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call to the scheduling team, following protocol by saying 'Would you like me to transfer your call to them?'"},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation from the client, Valentina correctly used the transferCall function with the appropriate scheduling team number (+17867056064)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed as the client agreed to the transfer, but Valentina did provide a proper closing statement informing the client that their call was being forwarded."}]}	1	{"explanation":"The customer is being very brief and task-focused throughout the conversation, simply stating what they need ('Appointment', 'Resisting', 'Yes') without expressing any clear positive or negative emotions. This directness appears to be purely functional communication rather than indicating any particular emotional state.","key_indicators":["Appointment","Resisting","Yes."]}	\N	85
563	1002	2025-05-24 03:24:15.653	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing requesting to speak with a receptionist to complete an appointment. After clarifying their needs, the agent offered to transfer them to the scheduling department, which the caller accepted.	neutral	NEW_APPOINTMENT_EXISTING_CLIENT	0.7	The caller states 'I need to complete an appointment' which indicates they want to book/schedule an appointment. The phrasing suggests they are an existing client looking to set up a new appointment rather than a new client inquiring about services. While they initially asked for the receptionist, their clarification about needing to complete an appointment makes this most likely a scheduling request from an existing client.	Valentina handled most aspects of this call correctly, including greeting the client, clarifying vague requests, identifying the appointment-related nature, asking for transfer permission, and executing the transfer properly. However, she missed a critical step in the protocol by not verifying whether the client was new or existing, which is essential for proper routing of appointment requests. This verification is particularly important as existing clients should be transferred to the scheduling team while new clients would require an intake process. This oversight reduced the overall effectiveness of the call handling.	1	The expected outcome was to transfer the call to scheduling team at +17867056064, which was successfully done. The assistant correctly identified the caller's need to complete an appointment, offered to transfer to the scheduling team, and executed the transfer to the exact number specified in the conditions.	1	{"explanation_score":"Valentina handled most aspects of this call correctly, including greeting the client, clarifying vague requests, identifying the appointment-related nature, asking for transfer permission, and executing the transfer properly. However, she missed a critical step in the protocol by not verifying whether the client was new or existing, which is essential for proper routing of appointment requests. This verification is particularly important as existing clients should be transferred to the scheduling team while new clients would require an intake process. This oversight reduced the overall effectiveness of the call handling.","steps_completed":5,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally and asked how she could help. When the client's request was vague ('speak with the receptionist'), she appropriately asked for more details."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client needed help with scheduling when they mentioned 'complete an appointment,' recognizing this as an appointment-related request."},{"name":"Client Status Verification","completed":false,"details":"Valentina did not verify whether the client was new or existing. For appointment requests, this is a critical step to ensure proper routing."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call to the scheduling team with 'Would you like me to transfer your call to them?'"},{"name":"Transfer Execution","completed":true,"details":"After receiving permission, Valentina correctly transferred the call to the scheduling department using the proper number (+17867056064)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed as the client agreed to the transfer, but Valentina did properly close the interaction by informing the client that the call was being forwarded."}]}	1	{"explanation":"The customer is direct and brief throughout the conversation, focused solely on completing their task of scheduling an appointment. There are no emotional indicators in their messages - no frustration, impatience, or positive expressions. This appears to be a purely functional interaction where the customer recognizes they're interacting with an automated system and is being task-oriented.","key_indicators":["Hi. I need to speak with the, uh, receptionist","I need to","I need to complete an appointment.","Please."]}	\N	83
559	998	2025-05-24 03:24:13.566	\N	\N	\N	\N	\N	\N	t	The caller inquired about a missed call from the number, speaking in Spanish. After being informed it might have been from the reception team, they agreed to be transferred to the front desk department.	neutral	MISSED_CALL	0.9	The caller clearly states 'La llamada perdida de este número?' which translates to 'The missed call from this number?' indicating they are returning a missed call they received from the practice. This is a straightforward MISSED_CALL scenario in Spanish.	Valentina handled this missed call situation perfectly. She demonstrated excellent language adaptability by responding in Spanish when the caller used Spanish, correctly identified the nature of the inquiry, followed the proper protocol for missed calls by offering to transfer to the front desk, obtained permission before transferring, and used the correct transfer number. The interaction was efficient and followed all required steps without unnecessary complications.	1	The expected outcome was to transfer the call to the front desk at +13055175439, which was successfully completed. The assistant recognized the caller's need, offered the transfer in Spanish, and then executed the transfer to the correct number.	1	{"explanation_score":"Valentina handled this missed call situation perfectly. She demonstrated excellent language adaptability by responding in Spanish when the caller used Spanish, correctly identified the nature of the inquiry, followed the proper protocol for missed calls by offering to transfer to the front desk, obtained permission before transferring, and used the correct transfer number. The interaction was efficient and followed all required steps without unnecessary complications.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the caller appropriately, identified herself as representing Always Keep Progressing, and asked how she could help. When the caller responded with just 'Hello?', she confirmed her presence and asked again how she could assist."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the caller was inquiring about a missed call from this number when the caller asked in Spanish 'La llamada perdida de este número?'"},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call to the front desk team, explaining that they were likely the ones who had called, which follows the protocol for missed call situations."},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation from the caller, Valentina correctly used the transferCall function with the appropriate number (+13055175439) for the front desk as specified in the protocol."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed as the caller agreed to the transfer, but Valentina did properly close the interaction by informing the caller that they were being transferred and to stay on the line."}]}	1	{"explanation":"The customer's messages are brief and task-focused. They first check if someone is there, then ask about a missed call in Spanish, and finally agree to being transferred. There are no emotional indicators of either positive or negative sentiment - just direct communication to resolve their query about a missed call.","key_indicators":["Hello?","La llamada perdida de este número?","Ok. Sí, está bien."]}	\N	100
560	999	2025-05-24 03:24:14.087	\N	\N	\N	\N	\N	\N	t	The caller received a call from someone named Priscila at Always Keep Progressing and was calling back. After the caller requested to speak Spanish, they explained they were returning a call, and the agent transferred them to the front desk department.	neutral	MISSED_CALL	0.9	The caller clearly states 'Me estaban llamando de allá. Dice Priscila.' which translates to 'They were calling me from there. It says Priscila.' This indicates they are returning a missed call from someone named Priscila at the practice, which fits perfectly into the MISSED_CALL category.	Valentina handled most aspects of this missed call situation correctly. She appropriately greeted the caller, offered language options, identified the request type as a missed call, and transferred to the correct department. However, she skipped a critical step by not asking for permission before transferring the call, which is explicitly required in the protocol. The transfer itself was executed correctly, and she provided clear information about what was happening. To improve, Valentina should always ask for permission before transferring any call, as specified in the protocol.	1	The expected outcome was to transfer the call to the front desk at +13055175439, which was successfully completed. The assistant correctly identified the need to transfer the call and used the transferCall tool with the exact destination number specified in the expected outcome.	1	{"explanation_score":"Valentina handled most aspects of this missed call situation correctly. She appropriately greeted the caller, offered language options, identified the request type as a missed call, and transferred to the correct department. However, she skipped a critical step by not asking for permission before transferring the call, which is explicitly required in the protocol. The transfer itself was executed correctly, and she provided clear information about what was happening. To improve, Valentina should always ask for permission before transferring any call, as specified in the protocol.","steps_completed":4,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the caller professionally, identified herself as representing Always Keep Progressing, and offered to help. When the caller responded with 'Aló? Hello?', she appropriately offered language options."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified this as a missed call situation when the caller stated 'Me estaban llamando de allá. Dice Priscila' (They were calling me from there. Priscila says)."},{"name":"Transfer Permission","completed":false,"details":"Valentina did not explicitly ask for permission to transfer the call. According to the protocol, she should have said something like 'I see. That may have been from our front desk. Want me to transfer you?' before proceeding with the transfer."},{"name":"Transfer Execution","completed":true,"details":"Valentina correctly transferred the call to the front desk at +13055175439, which is the appropriate number for missed calls according to the protocol."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't necessary as the call was transferred, but Valentina did provide appropriate closure by informing the caller 'I am forwarding your call to the front desk department. Please stay on the line.'"}]}	1	{"explanation":"The customer's messages are brief and purely task-focused. They first check if someone is there, then ask about language preference, and finally explain they were receiving a call from someone named Priscila. There are no emotional indicators in their messages - they are simply trying to communicate basic information.","key_indicators":["¿Aló? Hello?","Spanish?","Me estaban llamando de allá. Dice Priscila."]}	\N	80
561	1000	2025-05-24 03:24:14.614	\N	\N	\N	\N	\N	\N	t	The caller received a missed call from Always Keep Progressing and requested to be transferred to the front desk. The representative acknowledged the request and forwarded the call accordingly.	neutral	MISSED_CALL	0.9	The caller clearly states 'I miss a call from y'all' indicating they are returning a missed call from the practice. This is a straightforward MISSED_CALL scenario with no indication of any other purpose for the call.	Valentina handled this missed call situation excellently, following all required protocols. She properly identified the call type, asked for permission to transfer, and executed the transfer correctly. The only minor improvement could be in her response after the caller said they missed a call - she repeated 'I see' twice, which was slightly redundant. Otherwise, her handling was efficient and professional, providing a seamless experience for the caller who needed to be connected with the front desk.	1	The expected outcome was to transfer the call to the front desk at +13055175439, which was successfully done. The assistant identified that the caller missed a call that was likely from the front desk and offered to transfer them. When the caller agreed, the assistant properly executed the transferCall tool with the correct destination number.	1	{"explanation_score":"Valentina handled this missed call situation excellently, following all required protocols. She properly identified the call type, asked for permission to transfer, and executed the transfer correctly. The only minor improvement could be in her response after the caller said they missed a call - she repeated 'I see' twice, which was slightly redundant. Otherwise, her handling was efficient and professional, providing a seamless experience for the caller who needed to be connected with the front desk.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the caller appropriately and asked how she could help. When the caller's response was unclear ('Mister Colefield'), she politely asked for clarification, which was the correct approach."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that this was a missed call situation when the caller stated 'I don't know. I miss a call from y'all.'"},{"name":"Transfer Permission","completed":true,"details":"Valentina followed protocol by asking 'Want me to transfer you?' before proceeding with the transfer, obtaining proper consent."},{"name":"Transfer Execution","completed":true,"details":"After receiving permission, Valentina correctly used the transferCall function with the appropriate front desk number (+13055175439) as specified in the protocol."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed since the caller agreed to the transfer, but Valentina was prepared to handle this scenario if it had occurred."}]}	1	{"explanation":"The customer is being direct and brief, simply responding to a missed call. There are no emotional indicators of frustration or satisfaction - they're just trying to resolve the situation by getting transferred to the right department. The brevity indicates task-focused communication rather than negative sentiment.","key_indicators":["I don't know. I miss a call from y'all.","Yes."]}	\N	95
562	1001	2025-05-24 03:24:15.137	\N	\N	\N	\N	\N	\N	f	The caller contacted Always Keep Progressing but was cut off mid-sentence while trying to request speaking with someone. The representative asked for more details to properly direct the call, but no further information was provided.	neutral	LOOKING_FOR_SOMEONE	0.6	The caller stated 'I need to speak with the' before being cut off, indicating they were trying to reach a specific person or department. While incomplete, this phrase pattern strongly suggests they're looking to speak with someone specific rather than making an inquiry or appointment request.	Valentina only successfully completed the initial interaction by greeting the caller and asking for more details when the request was vague. However, she failed to recognize that the caller was likely looking for a specific person based on 'I need to speak with the...' and should have identified this as a 'LOOKING_FOR_SOMEONE' request type. According to the protocol, when someone is looking for a specific person, Valentina should offer to transfer them to the front desk at +13055175439. Instead, she asked for more details without recognizing the nature of the request. To improve, Valentina should better recognize partial requests indicating someone is looking for a specific person and follow the protocol for transferring such calls to the front desk.	0.9	The expected outcome was to transfer the caller to the front desk at +13055175439, but no transfer was initiated. The assistant asked for more details but did not complete the transfer as required.	1	{"explanation_score":"Valentina only successfully completed the initial interaction by greeting the caller and asking for more details when the request was vague. However, she failed to recognize that the caller was likely looking for a specific person based on 'I need to speak with the...' and should have identified this as a 'LOOKING_FOR_SOMEONE' request type. According to the protocol, when someone is looking for a specific person, Valentina should offer to transfer them to the front desk at +13055175439. Instead, she asked for more details without recognizing the nature of the request. To improve, Valentina should better recognize partial requests indicating someone is looking for a specific person and follow the protocol for transferring such calls to the front desk.","steps_completed":1,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the caller appropriately, identified the practice as 'Always Keep Progressing', and asked how she could help. When the caller's request was incomplete, she appropriately asked for more details to clarify the request."},{"name":"Request Type","completed":false,"details":"Valentina did not clearly identify that this was a 'LOOKING_FOR_SOMEONE' request type. The caller started to say 'I need to speak with the...' but was cut off, and Valentina asked for more details rather than recognizing this as someone looking for a specific person."},{"name":"Transfer Permission","completed":false,"details":"Valentina did not ask for permission to transfer the call to the front desk, which would be the appropriate action when someone is looking for a specific person."},{"name":"Transfer Execution","completed":false,"details":"No transfer was executed as Valentina did not recognize the request type and therefore did not reach the transfer stage."},{"name":"Alternative Closure","completed":false,"details":"Since the interaction did not reach the transfer stage, there was no alternative closure provided."}]}	1	{"explanation":"The customer's message is brief and incomplete, but doesn't show any clear emotional indicators. They appear to be starting a request to speak with someone but didn't complete their thought. This brevity likely indicates a task-focused approach rather than emotional dissatisfaction.","key_indicators":["Hi. I need to speak with the"]}	\N	20
564	1003	2025-05-24 03:24:16.17	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to cancel their son's therapy appointment. After confirming the caller's request, the representative offered to transfer them to the scheduling department, which the caller accepted.	neutral	APPOINTMENT_ADJUSTMENT	0.9	The caller clearly states 'I need to cancel an appointment for my son's therapy' which is a direct request to cancel an existing appointment. This falls squarely under the APPOINTMENT_ADJUSTMENT category which covers existing clients looking to cancel, reschedule, or confirm appointments.	Valentina handled this appointment adjustment request perfectly, following all required steps in the protocol. She correctly identified the request type, asked for permission to transfer, used the proper transfer number, and provided clear closing instructions to the client. The interaction was efficient, professional, and followed all guidelines for appointment adjustments.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully completed. The assistant recognized the need to transfer the call and used the transferCall tool with the correct destination number.	1	{"explanation_score":"Valentina handled this appointment adjustment request perfectly, following all required steps in the protocol. She correctly identified the request type, asked for permission to transfer, used the proper transfer number, and provided clear closing instructions to the client. The interaction was efficient, professional, and followed all guidelines for appointment adjustments.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally, asked how she could help, and responded appropriately when the client initially just said 'Hello?' by repeating her offer of assistance."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client's request to cancel an appointment for their son's therapy falls under the 'Appointment Adjustments' category that should be handled by the scheduling team."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call with 'Would you like me to transfer your call to them?' which follows the protocol exactly."},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation from the client, Valentina correctly used the transferCall function with the proper scheduling team number (+17867056064) as specified in the instructions."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed since the client agreed to the transfer, but Valentina did properly close the interaction by informing the client that their call was being forwarded and instructing them to stay on the line."}]}	1	{"explanation":"The customer is direct and task-focused, simply stating their need to cancel an appointment and responding briefly to questions. There are no emotional indicators of either positive or negative sentiment. This appears to be a routine service request with no emotional charge.","key_indicators":["Hello?","Hi. I need to cancel an appointment for my son's therapy.","Yes."]}	\N	100
565	1004	2025-05-24 03:24:16.716	\N	\N	\N	\N	\N	\N	f	The caller contacted Always Keep Progressing and requested to be connected to the scheduling department. The representative acknowledged the request and forwarded the call.	neutral	GENERAL_INQUIRY	0.4	The caller only said 'Scheduling, please' which is very minimal information. This could be interpreted as a request to speak with scheduling, but doesn't clearly indicate if they are a new client, existing client wanting to book an appointment, or making an adjustment. Without more context about their specific need, I've classified it as GENERAL_INQUIRY with low confidence. Alternative possibilities include NEW_APPOINTMENT_EXISTING_CLIENT or APPOINTMENT_ADJUSTMENT, but there's insufficient information to determine which is correct.	The assistant's performance was poor. It correctly greeted the client but failed to properly identify the request type, answer any questions, or close the interaction effectively. The assistant should have followed the protocol for 'Appointment Adjustments Only' by confirming if the user wanted to adjust an existing appointment before transferring. The lack of clarification and immediate transfer without offering further assistance significantly lowered the score.	1	The assistant immediately transferred the call without attempting to answer the user's question. The expected outcome required solving the client's questions before closing the interaction, which did not happen.	1	{"explanation_score":"The assistant's performance was poor. It correctly greeted the client but failed to properly identify the request type, answer any questions, or close the interaction effectively. The assistant should have followed the protocol for 'Appointment Adjustments Only' by confirming if the user wanted to adjust an existing appointment before transferring. The lack of clarification and immediate transfer without offering further assistance significantly lowered the score.","steps_completed":1,"total_steps":4,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":false,"details":"The assistant failed to identify the request type correctly. The user said 'Scheduling, please' which should have triggered the 'Appointment Adjustments Only' flow, but instead, it seems to have been treated as a general inquiry without further clarification."},{"name":"Answer Questions","completed":false,"details":"The assistant did not answer any questions directly but immediately transferred the call. It should have confirmed if the user was an existing client or a new client before transferring."},{"name":"Closure","completed":false,"details":"The assistant did not offer any further assistance or close the interaction appropriately. It simply announced the transfer."}]}	1	{"explanation":"The customer's message is brief and purely task-focused, simply requesting 'Scheduling, please.' This directness indicates a neutral, functional interaction rather than an emotional one. The customer is efficiently stating their need without expressing any positive or negative emotion.","key_indicators":["Scheduling, please."]}	\N	40
566	1005	2025-05-24 03:24:17.245	\N	\N	\N	\N	\N	\N	t	The caller attempted to schedule something but was unable to clearly communicate their request, responding with fragmented phrases and "16 percent." After the AI offered to transfer them to the front desk for better assistance, the caller agreed to be transferred.	neutral	MISCALANEOUS	0.9	The caller only says 'Schedule' and then makes unclear statements like 'From this' and 'Fondisse. It's 16 percent.' These statements don't provide enough coherent information to determine what specific service they need. The conversation doesn't contain enough clear information to categorize it into any of the specific call types, making MISCALANEOUS the appropriate classification.	Protocol evaluation skipped for MISCALANEOUS call type.	1	The assistant was unable to understand the user's request and transferred the call to the front desk as per the instructions.	1	{"explanation_score":"Protocol evaluation skipped for MISCALANEOUS call type.","steps_completed":0,"total_steps":0,"steps":[]}	1	{"explanation":"The customer is extremely brief and direct, using minimal words throughout the conversation. They appear to be task-focused rather than emotionally engaged. While their responses are terse, there are no clear indicators of frustration or dissatisfaction that would suggest negative sentiment. They simply agree to being transferred at the end, which indicates they're following the process without emotional reaction.","key_indicators":["Schedule.","From this, From this. From this. Fondisse. It's 16 percent.","From this","Yes, please."]}	\N	0
567	1006	2025-05-24 03:24:17.77	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to schedule an appointment for an existing client. After confirming the caller wanted to schedule for an existing client, the representative transferred the call to the scheduling department.	neutral	NEW_APPOINTMENT_EXISTING_CLIENT	0.8	The caller clearly states they are an 'Existing' client when asked if they're looking to schedule. This indicates they are an existing client looking to book a new appointment, which falls under the NEW_APPOINTMENT_EXISTING_CLIENT category.	The assistant followed the protocol perfectly. The assistant greeted the client, identified the request, verified client status, asked for transfer permission, and executed the transfer successfully. The interaction was handled efficiently and professionally.	1	The user requested scheduling, confirmed they were an existing customer, and the assistant transferred the call to the scheduling team at +17867056064 as requested.	1	{"explanation_score":"The assistant followed the protocol perfectly. The assistant greeted the client, identified the request, verified client status, asked for transfer permission, and executed the transfer successfully. The interaction was handled efficiently and professionally.","steps_completed":6,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as scheduling."},{"name":"Client Status Verification","completed":true,"details":"The assistant asked and confirmed that the client was an existing one."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully transferred the call to the scheduling team at +17867056064."},{"name":"Alternative Closure","completed":true,"details":"The assistant confirmed the transfer."}]}	1	{"explanation":"The user's responses are brief and directly related to the task at hand. There are no indicators of positive or negative emotion. The user seems to be focused on efficiently achieving their goal.","key_indicators":["Scheduling.","Existing","Yes, please."]}	\N	100
568	1008	2025-05-24 03:24:18.615	\N	\N	\N	\N	\N	\N	f	The caller received an email about a disc discharge from occupational therapy and was calling for assistance. The representative offered to transfer the call to the front desk team who could better help with this matter, and the caller agreed to the transfer.	neutral	BILLING	0.9	The caller states they are calling regarding a 'disc discharge from occupational therapy', which directly relates to billing or payment information. No other call types are relevant based on the caller's statement.	The assistant failed to correctly identify the request type, leading to a transfer to the wrong department. While the greeting and transfer execution were technically correct, the misidentification of the request significantly impacted the overall effectiveness. The assistant should have identified the billing inquiry and transferred the call to the billing department instead of the front desk. Improved accuracy in request type identification is crucial.	1	The call was transferred to +13055175439, but the expected outcome was a transfer to +17865410845. Therefore, the expected outcome was not achieved.	1	{"explanation_score":"The assistant failed to correctly identify the request type, leading to a transfer to the wrong department. While the greeting and transfer execution were technically correct, the misidentification of the request significantly impacted the overall effectiveness. The assistant should have identified the billing inquiry and transferred the call to the billing department instead of the front desk. Improved accuracy in request type identification is crucial.","steps_completed":3,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":false,"details":"The assistant misidentified the request. The user was calling about a discharge email related to occupational therapy, which falls under billing or payment-related inquiries, not a general inquiry for the front desk."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the front desk, although it was the wrong department."},{"name":"Transfer Execution","completed":true,"details":"The assistant executed the transfer to the front desk (+13055175439) after receiving permission, but this was the incorrect department."},{"name":"Alternative Closure","completed":false,"details":"The interaction did not reach a point where an alternative closure was needed, as the call was transferred. However, since the transfer was to the wrong department, the closure was not appropriate for the actual request."}]}	1	{"explanation":"The user's messages are brief and directly related to the task at hand. There are no explicit emotional indicators to suggest a positive or negative sentiment. The user is simply stating the reason for their call and agreeing to be transferred.","key_indicators":["I got an email about a disc discharge from occupational therapy, and I was calling regarding that","Please, please feel."]}	\N	40
569	1009	2025-05-24 03:24:19.147	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing with unclear communication, eventually indicating they were an existing client needing scheduling assistance. The representative offered to transfer the call to the scheduling department.	neutral	NEW_APPOINTMENT_EXISTING_CLIENT	0.9	The caller indicated they wanted to schedule something, confirmed they are an existing client, and the assistant clarified if they were looking to schedule an appointment. This strongly suggests the caller is an existing client looking to book a new appointment.	The assistant followed the protocol perfectly. It greeted the client, clarified the request, identified the client as existing, asked for transfer permission, executed the transfer, and provided a closing statement. The assistant handled the unclear initial responses from the user effectively.	1	The call was successfully transferred to +17867056064 as requested in the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly. It greeted the client, clarified the request, identified the client as existing, asked for transfer permission, executed the transfer, and provided a closing statement. The assistant handled the unclear initial responses from the user effectively.","steps_completed":6,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs. It also attempted to clarify the request when the initial input was unclear."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified that the client was looking to book a new appointment after clarifying the user's unclear initial responses."},{"name":"Client Status Verification","completed":true,"details":"The assistant asked and confirmed that the client was an existing one."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team at +17867056064."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closing statement after the transfer was executed."}]}	1	{"explanation":"The customer is extremely brief and direct throughout the conversation, providing minimal one-word responses. This appears to be task-focused communication rather than expressing any particular emotion. There are no clear indicators of frustration, anger, satisfaction or happiness - just direct, minimal engagement typical of someone who recognizes they're interacting with an automated system.","key_indicators":["Blezzly. Yes.","Segualing","Yes.","Existing.","Hello?"]}	\N	100
570	1010	2025-05-24 03:24:19.67	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to handle an appointment-related matter, responding with brief answers. After determining the caller wanted to cancel an appointment, the representative offered to transfer them to the scheduling team.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly stated 'Appointment' and then confirmed they were inquiring about their appointment ('Su appointment'). This clearly indicates they are looking to adjust their appointment, which falls under the APPOINTMENT_ADJUSTMENT category.	The assistant performed well in identifying the request type and executing the transfer. However, it missed a crucial step by not asking for the user's permission before transferring the call. Asking for permission is important for ensuring a positive customer experience. The assistant should be updated to always ask for permission before transferring.	1	The call was successfully transferred to +17867056064 as requested.	1	{"explanation_score":"The assistant performed well in identifying the request type and executing the transfer. However, it missed a crucial step by not asking for the user's permission before transferring the call. Asking for permission is important for ensuring a positive customer experience. The assistant should be updated to always ask for permission before transferring.","steps_completed":3,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment."},{"name":"Transfer Permission","completed":false,"details":"The assistant did not ask for permission before transferring the call. It assumed the user wanted to be transferred."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team."},{"name":"Alternative Closure","completed":false,"details":"This step was not applicable as the call was transferred. However, if the transfer was declined, the assistant did not have the opportunity to close the interaction appropriately."}]}	1	{"explanation":"The user's responses are brief and direct, indicating a task-focused interaction rather than an expression of emotion. There are no explicit indicators of positive or negative sentiment.","key_indicators":["Appointment","Yes. Su appointment."]}	\N	75
571	1011	2025-05-24 03:24:20.198	\N	\N	\N	\N	\N	\N	t	The caller requested to be connected to the scheduling department. The AI representative acknowledged the request and informed the caller they were being forwarded to that department.	neutral	APPOINTMENT_ADJUSTMENT	0.7	The caller specifically asked for the 'Scheduling department' which falls under APPOINTMENT_ADJUSTMENT category. This category covers callers looking to reach the scheduling department in English or Spanish. While the caller didn't specify exactly what they needed from scheduling (cancel, reschedule, or confirm an appointment), the direct request to be connected to scheduling indicates this is the appropriate category.	Valentina correctly greeted the client and executed the transfer to the right department, but she failed to follow critical protocol steps. She did not clarify the specific scheduling need, did not ask for permission before transferring, and immediately transferred the call without following the proper workflow. These are significant protocol violations that could lead to customer frustration if they were transferred without consent or to the wrong department. To improve, Valentina should always clarify vague requests, confirm the specific need (appointment adjustment, cancellation, etc.), and explicitly ask for permission before transferring any call.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully completed. The agent correctly identified the caller's request and used the transferCall tool with the exact destination number specified in the conditions.	1	{"explanation_score":"Valentina correctly greeted the client and executed the transfer to the right department, but she failed to follow critical protocol steps. She did not clarify the specific scheduling need, did not ask for permission before transferring, and immediately transferred the call without following the proper workflow. These are significant protocol violations that could lead to customer frustration if they were transferred without consent or to the wrong department. To improve, Valentina should always clarify vague requests, confirm the specific need (appointment adjustment, cancellation, etc.), and explicitly ask for permission before transferring any call.","steps_completed":2,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally and asked how she could help, which was appropriate for opening the conversation."},{"name":"Request Type","completed":false,"details":"Valentina did not properly identify the request type. When the user said 'Scheduling department,' she should have clarified what type of scheduling need they had before assuming it was an appointment adjustment that required transfer."},{"name":"Transfer Permission","completed":false,"details":"Valentina did not ask for permission to transfer the call. According to the protocol, she should have said something like 'It seems that our scheduling team can assist you with that. Would you like me to transfer your call to them?'"},{"name":"Transfer Execution","completed":true,"details":"Valentina correctly transferred the call to the scheduling team at the right number (+17867056064)."},{"name":"Alternative Closure","completed":false,"details":"This step was not applicable since Valentina proceeded with the transfer, but she should have only done so after getting permission."}]}	1	{"explanation":"The customer is being direct and brief, simply requesting to be connected to the scheduling department without expressing any positive or negative emotions. This appears to be a purely task-focused interaction where the customer is efficiently stating their need without emotional indicators.","key_indicators":["Scheduling department."]}	\N	40
572	1012	2025-05-24 03:24:20.713	\N	\N	\N	\N	\N	\N	f	The caller requested to speak with Martin Ayala but provided no additional details about the purpose of their call despite being asked for more information to direct the call appropriately.	neutral	LOOKING_FOR_SOMEONE	0.9	The caller clearly and repeatedly states they want to speak with a specific person named Martin Ayala. They provide no other context or reason for their call beyond wanting to connect with this individual. This is a straightforward example of the LOOKING_FOR_SOMEONE category.	The assistant started well by greeting the client and identifying the request type. However, it failed to follow the protocol by not asking for permission before transferring and not providing a proper closure. The assistant should have asked if the user wanted to be transferred to the front desk after clarifying the request. A better closure would involve offering further assistance or politely ending the call.	0.3	The user requested to speak with a specific person, Martin Ayala, but the assistant only asked for more details to transfer to the right department. There was no explicit transfer to the front desk number (+13055175439) as specified in the expected outcome conditions. The assistant did not confirm if Martin Ayala was available or in which department he worked.	1	{"explanation_score":"The assistant started well by greeting the client and identifying the request type. However, it failed to follow the protocol by not asking for permission before transferring and not providing a proper closure. The assistant should have asked if the user wanted to be transferred to the front desk after clarifying the request. A better closure would involve offering further assistance or politely ending the call.","steps_completed":2,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified that the caller was looking for a specific person."},{"name":"Transfer Permission","completed":false,"details":"The assistant did not ask for permission to transfer the call to the front desk after clarifying the request. The protocol requires asking for permission before transferring."},{"name":"Transfer Execution","completed":false,"details":"The assistant did not execute the transfer because permission was not obtained."},{"name":"Alternative Closure","completed":false,"details":"The interaction ended abruptly after the user clarified their request. The assistant should have asked for permission to transfer or offered alternative assistance if a transfer was not possible or desired."}]}	1	{"explanation":"The user is direct and brief, indicating a task-focused approach rather than expressing any particular emotion. The user is simply trying to reach a specific person.","key_indicators":["Speak with Martin","Speak with Martin Ayala."]}	\N	50
573	1013	2025-05-24 03:24:21.232	\N	\N	\N	\N	\N	\N	t	The caller requested to cancel an appointment and agreed to be transferred to the scheduling department. The representative from Always Keep Progressing forwarded the call to the appropriate team.	neutral	APPOINTMENT_ADJUSTMENT	1	The patient explicitly stated that they want to 'Cancel appointment?' which falls directly under the definition of APPOINTMENT_ADJUSTMENT.	The assistant followed the protocol perfectly. The interaction was handled efficiently and correctly, from initial greeting to transferring the call to the appropriate department. No improvements are necessary.	1	The user requested to cancel an appointment, the assistant offered to transfer them to the scheduling team, the user agreed, and the call was successfully transferred to the specified number +17867056064.	1	{"explanation_score":"The assistant followed the protocol perfectly. The interaction was handled efficiently and correctly, from initial greeting to transferring the call to the appropriate department. No improvements are necessary.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment (cancellation)."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission before transferring the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team at +17867056064 after receiving permission."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closing statement after the transfer was initiated."}]}	1	{"explanation":"The customer is being direct and brief, simply asking to cancel an appointment and confirming they want to be transferred. There are no emotional indicators in their messages, just task-focused communication typical of someone who recognizes they're interacting with an automated system.","key_indicators":["Cancel appointment?","Yes."]}	\N	100
574	1014	2025-05-24 03:24:21.785	\N	\N	\N	\N	\N	\N	t	The caller named Desmond contacted Always Keep Progressing to cancel a session. After confirming this was their request, the representative transferred the call to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	0.9	The caller clearly states they want to 'Cancel session' which directly falls under the APPOINTMENT_ADJUSTMENT category that covers canceling, rescheduling, or confirming appointments. The request is straightforward and unambiguous.	Valentina handled this appointment adjustment request perfectly. She followed all required steps in the protocol: she greeted the caller professionally, asked for clarification when given minimal information, correctly identified the request type as an appointment adjustment, asked for permission to transfer, and executed the transfer to the correct department using the proper phone number. Her responses were concise and professional throughout the interaction.	1	The user requested to cancel a session, the assistant offered to transfer them to the scheduling team, the user agreed, and the call was successfully transferred to the specified number +17867056064.	1	{"explanation_score":"Valentina handled this appointment adjustment request perfectly. She followed all required steps in the protocol: she greeted the caller professionally, asked for clarification when given minimal information, correctly identified the request type as an appointment adjustment, asked for permission to transfer, and executed the transfer to the correct department using the proper phone number. Her responses were concise and professional throughout the interaction.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally and when the initial response was just a name ('Desmond'), she appropriately asked for more information about what they needed help with."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that 'Cancel session' was an appointment adjustment request that should be handled by the scheduling team."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call to the scheduling team with 'Would you like me to transfer your call to them?'"},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation ('Yes'), Valentina correctly used the transferCall function with the proper scheduling team number (+17867056064)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed since the caller agreed to the transfer, but Valentina was prepared to handle this scenario based on her protocol adherence throughout the conversation."}]}	1	{"explanation":"The customer is extremely brief and direct, providing only their name, requesting to cancel a session, and confirming they want to be transferred. This appears to be purely task-focused communication without emotional indicators. The brevity suggests they recognize they're interacting with an automated system and are being efficient rather than expressing negative sentiment.","key_indicators":["Desmond.","Cancel session.","Yes."]}	\N	100
575	1015	2025-05-24 03:24:22.307	\N	\N	\N	\N	\N	\N	t	The caller, Juan, contacted Always Keep Progressing to cancel an appointment. After initially speaking Spanish, he requested to speak with someone and was transferred to the scheduling department when he confirmed he wanted to cancel his appointment.	neutral	APPOINTMENT_ADJUSTMENT	1	The patient explicitly states, 'I would like to cancel the appointment,' which clearly falls under the appointment adjustment category.	The assistant followed the protocol perfectly. The assistant greeted the client, identified the request type, obtained permission for the transfer, and successfully transferred the call to the scheduling team. No improvements are necessary.	1	The user requested to cancel an appointment, which the assistant identified as requiring the scheduling team. The user confirmed the transfer, and the call was successfully transferred to +17867056064 as per the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly. The assistant greeted the client, identified the request type, obtained permission for the transfer, and successfully transferred the call to the scheduling team. No improvements are necessary.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client, identified the language, and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment (cancellation)."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team at +17867056064 after receiving permission."},{"name":"Alternative Closure","completed":true,"details":"The transfer was successful, so an alternative closure was not needed."}]}	1	{"explanation":"The user's messages are direct and task-focused. There are no explicit emotional indicators to suggest a positive or negative sentiment. The user is simply trying to cancel an appointment and is providing the necessary information to do so.","key_indicators":["Hola, tu soy Juan.","I would like to speak to someone.","I would like to cancel the appointment.","Yes."]}	\N	100
576	1016	2025-05-24 03:24:22.833	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to reschedule an equipment-related appointment. After clarifying their request, the representative offered to transfer them to the scheduling department, which the caller accepted.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly stated they want to reschedule an appointment, which falls directly under the 'APPOINTMENT_ADJUSTMENT' category.	The assistant followed the protocol perfectly, correctly identifying the request type, obtaining permission for the transfer, and executing the transfer successfully. The interaction was handled efficiently and professionally.	1	The user requested to reschedule an appointment, which the assistant correctly identified as a task for the scheduling team. The assistant then transferred the call to the specified number (+17867056064) as per the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly, correctly identifying the request type, obtaining permission for the transfer, and executing the transfer successfully. The interaction was handled efficiently and professionally.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission before transferring the call."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully transferred the call to the scheduling team."},{"name":"Alternative Closure","completed":true,"details":"The assistant closed the interaction appropriately after the transfer."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["With an agent? Equipment.","Reschedule an appointment.","Yes."]}	\N	100
577	1017	2025-05-24 03:24:23.344	\N	\N	\N	\N	\N	\N	t	The caller requested to speak with someone in Spanish. The AI responded in Spanish asking for more information to transfer the call to the appropriate department, and after the caller's brief affirmative response, the AI forwarded the call to the front desk.	neutral	NEW_CLIENT_SPANISH	0.9	The user stated 'Quiero hablar con un Spanish', indicating they want to speak with someone in Spanish, which strongly suggests they are a new client inquiring about services in Spanish. The assistant's follow-up question confirms this interpretation.	The assistant followed the protocol perfectly. The assistant greeted the client, identified the language, asked for more information, confirmed the transfer, and executed the transfer successfully. The assistant also provided a closing statement.	1	The call was successfully transferred to +13055175439 as requested, fulfilling the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly. The assistant greeted the client, identified the language, asked for more information, confirmed the transfer, and executed the transfer successfully. The assistant also provided a closing statement.","steps_completed":6,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Language Identification","completed":true,"details":"The assistant correctly identified the client's language as Spanish and responded in Spanish."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified that the client wanted to speak in Spanish and needed to be transferred."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully transferred the call to the front desk at +13055175439."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closing statement after transferring the call."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused interaction. There are no explicit emotional indicators to suggest a positive or negative sentiment. The user expresses gratitude, but it is brief and likely perfunctory in nature.","key_indicators":["Quiero hablar con un Spanish","Sí. Gracias."]}	\N	100
578	1018	2025-05-24 03:24:23.942	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to adjust an existing appointment. After confirming the caller wanted to modify a current appointment rather than schedule a new one, the representative transferred the call to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly stated they want to adjust their 'current 1' appointment, which clearly falls under appointment adjustments.	The assistant followed the protocol perfectly, correctly identifying the request type, obtaining permission for the transfer, and executing it successfully. The interaction was handled efficiently and professionally.	1	The user requested scheduling assistance for an existing appointment, the assistant confirmed the need for the scheduling team, the user agreed to be transferred, and the call was successfully transferred to +17867056064 as per the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly, correctly identifying the request type, obtaining permission for the transfer, and executing it successfully. The interaction was handled efficiently and professionally.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission before transferring the call."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closing statement after the transfer."}]}	1	{"explanation":"The user's responses are brief and direct, indicating a task-focused interaction rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["Scheduling.","Uh, current 1.","Yes."]}	\N	100
579	1019	2025-05-24 03:24:24.468	\N	\N	\N	\N	\N	\N	t	The caller requested service in Spanish, provided a name (Dabenji Gustave, Giuseafa), and was then forwarded to the front desk.	neutral	NEW_CLIENT_SPANISH	0.9	The caller immediately states "Español," indicating they wish to communicate in Spanish. They then provide a name, which is typical when a new client is trying to register or inquire about services. This strongly suggests a new client inquiry in Spanish.	Valentina correctly identified the Spanish language request and executed the transfer to the appropriate number. However, she failed to properly identify the client's request type, did not ask for permission before transferring, and transferred the call without sufficient information gathering. The assistant should have asked more questions in Spanish to determine the nature of the call before transferring, and should have explained the reason for the transfer to the client. Additionally, the final message was in English after the client had indicated Spanish preference, which is inconsistent with providing good service.	1	The call was successfully transferred to +13055175439 as requested.	1	{"explanation_score":"Valentina correctly identified the Spanish language request and executed the transfer to the appropriate number. However, she failed to properly identify the client's request type, did not ask for permission before transferring, and transferred the call without sufficient information gathering. The assistant should have asked more questions in Spanish to determine the nature of the call before transferring, and should have explained the reason for the transfer to the client. Additionally, the final message was in English after the client had indicated Spanish preference, which is inconsistent with providing good service.","steps_completed":3,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client appropriately with 'Hi, this is Always Keep Progressing. How can I help you today?' which is a professional and warm introduction."},{"name":"Language Identification","completed":true,"details":"Valentina correctly identified that the client wanted to speak Spanish when they said 'Español' and immediately switched to Spanish for the next response."},{"name":"Request Type","completed":false,"details":"Valentina did not clearly identify the request type. After the client responded with what appears to be names, Valentina proceeded directly to transfer without determining if this was a new client seeking therapy services."},{"name":"Transfer Permission","completed":false,"details":"Valentina did not ask for permission before transferring the call. According to the protocol, she should have asked 'May I transfer your call?' before proceeding with the transfer."},{"name":"Transfer Execution","completed":true,"details":"Valentina correctly executed the transfer to the front desk at +13055175439 as required for Spanish-speaking new clients."},{"name":"Alternative Closure","completed":false,"details":"This step was not applicable as Valentina proceeded with the transfer, but she did not properly close the interaction by explaining why the transfer was happening or what to expect next."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. The user is simply providing the information needed to be transferred to the appropriate department.","key_indicators":["Español.","Dabenji Gustave, Giuseafa,"]}	\N	50
580	1020	2025-05-24 03:24:24.995	\N	\N	\N	\N	\N	\N	t	The caller inquired about desk scheduling services and requested to be transferred to the scheduling department. After confirming the caller's request, the representative forwarded the call to the appropriate department.	neutral	APPOINTMENT_ADJUSTMENT	0.7	The caller specifically mentions 'scheduling' multiple times without providing additional context. This indicates they are likely trying to reach the scheduling department for an appointment-related matter, which falls under APPOINTMENT_ADJUSTMENT. While they don't explicitly state they want to book, reschedule or cancel, the repeated reference to 'scheduling' suggests they need assistance with appointment management. The confidence is medium because while scheduling is clearly mentioned, the exact nature of their appointment need isn't specified.	Valentina handled this appointment adjustment request excellently, following all required protocol steps. She properly identified the vague request, asked for clarification, recognized it as a scheduling matter, requested permission to transfer, and executed the transfer correctly. The only minor improvement could be gathering slightly more specific information about the exact scheduling need before transferring, which would have made the handoff more efficient for the scheduling team. Otherwise, this was a textbook example of proper call handling for an appointment adjustment request.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully done. The assistant correctly identified the caller's need for scheduling, offered to transfer them, and then executed the transfer to the exact number specified in the conditions.	1	{"explanation_score":"Valentina handled this appointment adjustment request excellently, following all required protocol steps. She properly identified the vague request, asked for clarification, recognized it as a scheduling matter, requested permission to transfer, and executed the transfer correctly. The only minor improvement could be gathering slightly more specific information about the exact scheduling need before transferring, which would have made the handoff more efficient for the scheduling team. Otherwise, this was a textbook example of proper call handling for an appointment adjustment request.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally, asked how she could help, and when the client's initial request was vague ('What is those desks scheduling'), she appropriately asked for clarification about the specific scheduling need."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client's request was related to scheduling, which falls under appointment adjustments that should be handled by the scheduling team."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call to the scheduling team with 'Would you like me to transfer your call to them?'"},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation from the client, Valentina correctly used the transferCall function with the proper phone number for the scheduling team (+17867056064)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed as the client agreed to the transfer, but Valentina did properly close the interaction by informing the client that the call was being forwarded and to stay on the line."}]}	1	{"explanation":"The customer is being direct and brief throughout the conversation, simply asking about scheduling and confirming they want to be transferred. There are no emotional indicators in their messages, just task-focused communication. This appears to be a straightforward service inquiry without any positive or negative emotional content.","key_indicators":["What is those desks scheduling","Scheduling.","Yes."]}	\N	95
581	1021	2025-05-24 03:24:25.509	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing and requested to speak Spanish. After being asked for more information in Spanish, they requested to be transferred to the scheduling department, and the call was forwarded accordingly.	neutral	APPOINTMENT_ADJUSTMENT	0.7	The caller specifically asks to be connected to the 'departamento de cita' (appointment department) in Spanish. This indicates they have an appointment-related need, which falls under the APPOINTMENT_ADJUSTMENT category. While we don't know the exact nature of their appointment request (scheduling, rescheduling, or confirming), they are clearly seeking the scheduling department for appointment-related matters.	Valentina handled most aspects of this call well, particularly recognizing the Spanish language request and correctly identifying the need to transfer to the scheduling department. The main issue was skipping the step of asking for permission before transferring the call, which is explicitly required in the protocol. While she executed the transfer correctly and provided appropriate closure, obtaining consent before transferring is an important part of the process that ensures the caller is prepared for and agrees to the transfer. For improvement, Valentina should always ask for permission before transferring any call, especially when following a structured protocol.	1	The expected outcome was to transfer the call to scheduling team at +17867056064, which was successfully done. The assistant recognized the caller's request for the scheduling department ('Departamento de cita') and correctly transferred the call to the specified number.	1	{"explanation_score":"Valentina handled most aspects of this call well, particularly recognizing the Spanish language request and correctly identifying the need to transfer to the scheduling department. The main issue was skipping the step of asking for permission before transferring the call, which is explicitly required in the protocol. While she executed the transfer correctly and provided appropriate closure, obtaining consent before transferring is an important part of the process that ensures the caller is prepared for and agrees to the transfer. For improvement, Valentina should always ask for permission before transferring any call, especially when following a structured protocol.","steps_completed":4,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally and asked how she could help. When the client responded in Spanish with a vague request ('Hablar todo'), Valentina appropriately recognized the language and asked for more information in Spanish."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client was requesting the appointment department ('Departamento de cita') which falls under appointment adjustments that should be handled by the scheduling team."},{"name":"Transfer Permission","completed":false,"details":"Valentina did not explicitly ask for permission to transfer the call. According to the protocol, she should have asked something like 'Would you like me to transfer your call to them?' in Spanish before proceeding with the transfer."},{"name":"Transfer Execution","completed":true,"details":"Valentina correctly transferred the call to the scheduling team at the appropriate number (+17867056064)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't applicable as Valentina proceeded with the transfer, but she did provide appropriate closure by informing the caller that she was forwarding the call and instructing them to stay on the line."}]}	1	{"explanation":"The customer is being direct and task-focused, simply requesting to be connected to the scheduling department in Spanish. There are no emotional indicators in their brief messages, just practical communication to achieve their goal of reaching the appropriate department.","key_indicators":["Hablar todo.","Departamento de cita, por favor."]}	\N	80
582	1022	2025-05-24 03:24:26.028	\N	\N	\N	\N	\N	\N	t	The caller had difficulty communicating clearly but eventually requested to be transferred to the front desk. After several attempts to understand the caller's needs, the agent forwarded the call to the front desk department.	neutral	LOOKING_FOR_SOMEONE	0.9	The caller explicitly asks to be transferred to the front desk. This indicates they are likely trying to reach someone or a specific department, which aligns with the 'LOOKING_FOR_SOMEONE' call type.	The assistant performed well in identifying the user's request and executing the transfer. However, it missed the step of explicitly asking for permission before transferring the call, which is a requirement in the protocol. Asking for permission ensures the user is aware and agrees to the transfer. Improving this aspect would lead to a higher score.	1	The user explicitly requested a transfer to the front desk, and the assistant successfully transferred the call to the specified number (+13055175439) as indicated by the tool call and assistant's confirmation.	1	{"explanation_score":"The assistant performed well in identifying the user's request and executing the transfer. However, it missed the step of explicitly asking for permission before transferring the call, which is a requirement in the protocol. Asking for permission ensures the user is aware and agrees to the transfer. Improving this aspect would lead to a higher score.","steps_completed":3,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and attempted to understand their needs, although the initial user input was unclear."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified that the user wanted to be transferred to the front desk after some clarification."},{"name":"Transfer Permission","completed":false,"details":"The assistant did not explicitly ask for permission to transfer the call. While the user did request the transfer, the protocol requires asking for permission first."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the front desk at +13055175439."},{"name":"Alternative Closure","completed":false,"details":"This step is not applicable because the transfer was executed."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. The user's initial messages are unclear, but they eventually clarify their request to be transferred to the front desk. There are no explicit expressions of frustration or satisfaction.","key_indicators":["I say weak on this?","Uh, which front vest?","disk.","I want to check with processed. Front desk. Transfer me to front desk, please."]}	\N	75
583	1023	2025-05-24 03:24:26.542	\N	\N	\N	\N	\N	\N	f	The caller contacted Always Keep Progressing and inquired about office locations. The representative began to provide information about their two office locations, specifically mentioning the Miami Shores Clinic at 101 Suite 312, Miami, Florida 33181.	neutral	GENERAL_INQUIRY	1	The caller is asking for the office location, which is a general question about the practice that can be answered with available information.	The assistant performed well by greeting the client, identifying the request type, and using the knowledge base to answer the question. However, the assistant only provided one location instead of both and failed to properly close the interaction by asking if there was anything else they could help with. The assistant should have provided both locations and closed the interaction properly.	0.6	The assistant provided the office locations, but the user's initial request was ambiguous ('My office'). It's unclear if the assistant fully understood the user's need or if the user was satisfied with the information provided. The conversation ended abruptly without confirmation of resolution.	1	{"explanation_score":"The assistant performed well by greeting the client, identifying the request type, and using the knowledge base to answer the question. However, the assistant only provided one location instead of both and failed to properly close the interaction by asking if there was anything else they could help with. The assistant should have provided both locations and closed the interaction properly.","steps_completed":3,"total_steps":4,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as a general inquiry about the office location."},{"name":"Answer Questions","completed":true,"details":"The assistant used the knowledge base to answer the question about the office location. However, the assistant only provided one location instead of both."},{"name":"Closure","completed":false,"details":"The assistant did not ask if there was anything else they could help with or close the interaction."}]}	1	{"explanation":"The user's message is very brief and direct. This indicates a task-focused approach rather than any particular emotion. There are no indicators of frustration or dissatisfaction.","key_indicators":["My office."]}	\N	75
584	1024	2025-05-24 03:24:27.064	\N	\N	\N	\N	\N	\N	t	The caller requested to be connected to the front desk. After a brief clarification request, the AI confirmed it would forward the call to the front desk department.	neutral	LOOKING_FOR_SOMEONE	0.9	The caller is asking for the 'front desk', indicating they are trying to reach a specific department or person. This aligns with the 'LOOKING_FOR_SOMEONE' call type.	Valentina handled the basic greeting well and correctly transferred the call to the front desk. However, she missed two critical protocol steps: (1) she didn't properly identify this as someone looking for a person/department rather than having a specific request type, and (2) she failed to ask for permission before transferring the call, which is explicitly required in the protocol. These are important steps for ensuring caller consent and maintaining a professional interaction. The transfer itself was executed correctly to the right department.	1	The expected outcome was to transfer the call to the front desk at +13055175439, which was successfully completed. The assistant correctly identified the request and used the transferCall tool with the exact destination number specified in the expected outcome.	1	{"explanation_score":"Valentina handled the basic greeting well and correctly transferred the call to the front desk. However, she missed two critical protocol steps: (1) she didn't properly identify this as someone looking for a person/department rather than having a specific request type, and (2) she failed to ask for permission before transferring the call, which is explicitly required in the protocol. These are important steps for ensuring caller consent and maintaining a professional interaction. The transfer itself was executed correctly to the right department.","steps_completed":3,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the caller professionally and asked how she could help. When the caller gave a vague request ('Front desk'), she appropriately asked for more details to better understand their needs."},{"name":"Request Type","completed":false,"details":"Valentina did not correctly identify that this was a 'LOOKING_FOR_SOMEONE' scenario. When the caller repeated 'Front desk' without elaboration, she should have recognized this as someone looking to speak with the front desk team rather than immediately transferring."},{"name":"Transfer Permission","completed":false,"details":"Valentina did not ask for permission before transferring the call. According to the protocol, she should have said something like 'It seems our front desk team can help with that. May I transfer you?'"},{"name":"Transfer Execution","completed":true,"details":"Valentina correctly transferred the call to the front desk at the appropriate number (+13055175439)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't applicable as the call was transferred, but Valentina did inform the caller that she was forwarding the call to the front desk department, which provided appropriate closure to her part of the interaction."}]}	1	{"explanation":"The user's responses are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. The user is simply trying to reach the front desk and is not expressing any frustration or dissatisfaction.","key_indicators":["Front desk","Front desk."]}	\N	70
585	1025	2025-05-24 03:24:27.607	\N	\N	\N	\N	\N	\N	t	Liz from Sunshine Health Children's Medical Services called Always Keep Progressing to verify patient information for a mutual patient. The AI representative offered to transfer her to the front desk team, which Liz agreed to.	neutral	GENERAL_INQUIRY	0.9	The caller is asking to verify patient information (address, phone number) and confirm if it's okay to share patient details. This falls under a general inquiry to verify information, not a specific request related to appointments, billing, or other defined categories.	The assistant followed the protocol effectively. The greeting was appropriate, the request type was correctly identified, and the call was transferred to the appropriate department. The closure was also handled well, informing the user of the transfer. No improvements are necessary.	1	The assistant correctly identified the need to transfer the call to the front desk to handle the patient information verification request and successfully transferred the call. The client agreed with the transfer.	1	{"explanation_score":"The assistant followed the protocol effectively. The greeting was appropriate, the request type was correctly identified, and the call was transferred to the appropriate department. The closure was also handled well, informing the user of the transfer. No improvements are necessary.","steps_completed":4,"total_steps":4,"steps":[{"name":"Initial Interaction: Greet the client, inquire about their needs, and clarify request details if vague","completed":true,"details":"The assistant greeted the client and clarified the request after some initial back and forth."},{"name":"Request Type: Identify that the request is about a general inquiry about the practice","completed":true,"details":"The assistant correctly identified the request as a general inquiry needing verification of patient information."},{"name":"Answer Questions: Answer the questions with the information available, use the Knowledge Base to answer the question if needed","completed":true,"details":"The assistant did not directly answer the question but correctly identified that the front desk team would be better suited to handle the request and offered a transfer."},{"name":"Closure: Ask if there is anything else we can help with and close the interaction","completed":true,"details":"The assistant confirmed the transfer and informed the user to stay on the line, effectively closing the interaction after fulfilling the request."}]}	1	{"explanation":"The user is direct and task-focused from the beginning. There are no clear indicators of positive or negative emotion. The user is simply trying to verify information.","key_indicators":["Yes. Good afternoon. Uh, who am I calling?","Hello?","Okay. Okay. Yes. My name is Liz, and I'm and I'm calling from Sunshine Health Children's Medical Services, uh, regarding a mutual patient, and we need to verify address, phone number on file, 5 need to know if it's okay for me to give you the patient's name, date of birth, and Medicaid number.","Correct, yes"]}	\N	100
586	1026	2025-05-24 03:24:28.706	\N	\N	\N	\N	\N	\N	t	The caller identified themselves as "Ron, s. Front desk" and requested to be transferred to the front desk department. After confirming this was what they wanted, the representative informed the caller they would be forwarding the call to that department.	neutral	LOOKING_FOR_SOMEONE	1	The caller stated 'Ron, s. Front desk,' indicating they are trying to reach someone specific at the front desk.	The assistant followed the protocol perfectly. The assistant greeted the caller, clarified the request, asked for transfer permission, executed the transfer correctly, and provided a closure statement. No improvements are needed.	1	The user requested to be transferred to the front desk, and the assistant successfully transferred the call to +13055175439 as specified in the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly. The assistant greeted the caller, clarified the request, asked for transfer permission, executed the transfer correctly, and provided a closure statement. No improvements are needed.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified that the caller was looking for a specific person (Ron) and the front desk."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the front desk."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the front desk at +13055175439 after receiving permission."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closure statement after transferring the call."}]}	1	{"explanation":"The user's responses are brief and direct, indicating a task-focused interaction rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["Not yet.","Ron, s. Front desk.","Yes."]}	\N	100
587	1027	2025-05-24 03:24:29.233	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing requesting to speak with the scheduling department. After confirming they wanted to adjust an appointment, the AI forwarded the call to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly stated they wanted to speak with scheduling to adjust an appointment, which falls directly under the 'APPOINTMENT_ADJUSTMENT' category.	The assistant followed the protocol perfectly. The assistant greeted the client, identified the request type, confirmed the need for a transfer, executed the transfer, and closed the interaction appropriately. No improvements are needed.	1	The user requested to speak with scheduling, confirmed they wanted to adjust an appointment, and the call was transferred to +17867056064 as expected.	1	{"explanation_score":"The assistant followed the protocol perfectly. The assistant greeted the client, identified the request type, confirmed the need for a transfer, executed the transfer, and closed the interaction appropriately. No improvements are needed.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for confirmation that the user wanted to adjust an appointment."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully transferred the call to the scheduling team."},{"name":"Alternative Closure","completed":true,"details":"The assistant closed the interaction appropriately by informing the user that they were being transferred."}]}	1	{"explanation":"The user's responses are brief and direct, indicating a task-focused interaction rather than any strong positive or negative emotion. The user is simply confirming information and answering questions to get their call transferred.","key_indicators":["Speak with scheduling.","Yes.","Yes."]}	\N	100
588	1028	2025-05-24 03:24:29.763	\N	\N	\N	\N	\N	\N	f	The caller contacted Always Keep Progressing but provided unclear, fragmented information that seemed to include references to an order, Darwin, chipotle dough, and a receptionist. The conversation was brief and difficult to understand with disconnected phrases.	negative	MISCALANEOUS	0.9	The caller's statements are nonsensical and do not fit into any of the defined call types. The caller is not asking for any specific service or information related to the practice.	Protocol evaluation skipped for MISCALANEOUS call type.	0.9	The assistant likely couldn't understand or assist the user based on the garbled input. The expected outcome was to transfer the call if unable to handle it directly, which would be the appropriate action in this scenario.	1	{"explanation_score":"Protocol evaluation skipped for MISCALANEOUS call type.","steps_completed":0,"total_steps":0,"steps":[]}	1	{"explanation":"The user's message is nonsensical and contains phrases like \\"I can blow up,\\" which indicates frustration or anger. The message is not simply direct; it suggests a negative emotional state.","key_indicators":["Double order, Darwin. Chipotle dough. Reflectionist. Probably only got this. Honey, Receptionist. I can blow up."]}	\N	0
589	1029	2025-05-24 03:24:30.28	\N	\N	\N	\N	\N	\N	t	The caller identified themselves as a receptionist from the front desk and requested a cancellation. The AI representative acknowledged the request and transferred the call to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller stated 'Cancellation,' which clearly indicates they want to cancel an appointment. This falls under the APPOINTMENT_ADJUSTMENT category.	The assistant performed well by identifying the request type and executing the transfer. However, the assistant missed the crucial step of asking for the user's permission before transferring the call, which is important for user experience. Asking for permission would have improved the score.	1	The call was transferred to +17867056064 as requested, fulfilling the condition for the expected outcome.	1	{"explanation_score":"The assistant performed well by identifying the request type and executing the transfer. However, the assistant missed the crucial step of asking for the user's permission before transferring the call, which is important for user experience. Asking for permission would have improved the score.","steps_completed":4,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and asked how they could help."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment (cancellation)."},{"name":"Transfer Permission","completed":false,"details":"The assistant did not ask for permission before transferring the call."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully transferred the call to the scheduling team."},{"name":"Alternative Closure","completed":true,"details":"The assistant informed the user that they were forwarding the call."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. The user is simply stating their role and the purpose of their call.","key_indicators":["Yes, receptionist from desk.","Cancellation."]}	\N	80
590	1030	2025-05-24 03:24:30.788	\N	\N	\N	\N	\N	\N	t	Oscar will not be attending his appointment today because he is not feeling well. The caller, who appears to be Oscar's mother, requested to be transferred to the scheduling department to handle the cancellation.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller is calling to inform that Oscar will not be able to make it to his appointment today because he is not feeling well. This clearly indicates a need to cancel or reschedule the appointment, which falls under the APPOINTMENT_ADJUSTMENT category.	The assistant followed the protocol perfectly. The interaction was handled efficiently and correctly, from initial greeting to transferring the call to the appropriate department. All steps were completed successfully.	1	The assistant transferred the call to +17867056064 as requested, fulfilling the condition for the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly. The interaction was handled efficiently and correctly, from initial greeting to transferring the call to the appropriate department. All steps were completed successfully.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment (cancellation) and that it should be handled by the scheduling team."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team at +17867056064 after receiving permission."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closing statement after the transfer."}]}	1	{"explanation":"The user is direct and task-focused from the beginning, indicating a neutral sentiment. There are no explicit emotional indicators in their messages.","key_indicators":["Hello?","I am calling for Oscar. He had appointment today outside from his mother. He's not feeling well. Will not be make it today.","Yes. You"]}	\N	100
591	1031	2025-05-24 03:24:31.302	\N	\N	\N	\N	\N	\N	f	The caller contacted Always Keep Progressing to make an appointment and identified themselves as a new client, but the call was cut off before they could specify what type of therapy they were seeking.	neutral	NEW_APPOINTMENT_EXISTING_CLIENT	0.9	The caller states, "I need to make an appointment." The assistant asks if they are a new or existing client, and the caller responds "No." This implies they are an existing client, as a new client would likely answer "yes" to that question. Therefore, the call type is NEW_APPOINTMENT_EXISTING_CLIENT.	The assistant started well by greeting the client and identifying the request type. However, a critical error occurred when the assistant misinterpreted the client's 'No' response to the 'new or existing client' question, leading to a breakdown in the conversation flow. The assistant should have clarified the client's status instead of assuming they were a new client. Because of this misinterpretation, the assistant failed to ask for transfer permission or execute a transfer, and the interaction did not reach a proper closure. The assistant needs to be more robust in handling ambiguous or negative responses and should prioritize clarification before proceeding.	0.1	The call did not result in a transfer to the scheduling team. The conversation was still in the initial stages of gathering information from the user.	1	{"explanation_score":"The assistant started well by greeting the client and identifying the request type. However, a critical error occurred when the assistant misinterpreted the client's 'No' response to the 'new or existing client' question, leading to a breakdown in the conversation flow. The assistant should have clarified the client's status instead of assuming they were a new client. Because of this misinterpretation, the assistant failed to ask for transfer permission or execute a transfer, and the interaction did not reach a proper closure. The assistant needs to be more robust in handling ambiguous or negative responses and should prioritize clarification before proceeding.","steps_completed":3,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified that the client was looking to book a new appointment."},{"name":"Client Status Verification","completed":true,"details":"The assistant asked if the client was new or existing. However, the client's response of 'No' was misinterpreted as 'new client'. This is a critical error."},{"name":"Transfer Permission","completed":false,"details":"The assistant did not ask for permission to transfer to the scheduling team because the conversation was interrupted after misinterpreting the client's status."},{"name":"Transfer Execution","completed":false,"details":"The assistant did not execute a transfer because the conversation was interrupted after misinterpreting the client's status."},{"name":"Alternative Closure","completed":false,"details":"The interaction did not reach a closure because the conversation was interrupted after misinterpreting the client's status."}]}	1	{"explanation":"The customer is being direct and brief throughout the conversation, focusing only on their task of making an appointment. There are no emotional indicators in their messages - neither positive nor negative. Their responses are purely functional and task-oriented, which indicates a neutral sentiment.","key_indicators":["You're welcome.","Hello?","I need to make an appointment.","No."]}	\N	40
592	1032	2025-05-24 03:24:31.83	\N	\N	\N	\N	\N	\N	t	The caller requested to be transferred to the scheduling department, and the AI representative from Always Keep Progressing confirmed they would forward the call to that department.	neutral	APPOINTMENT_ADJUSTMENT	0.8	The caller specifically asked to be transferred to the scheduling department. According to the categories, 'APPOINTMENT_ADJUSTMENT' includes 'callers looking to reach the scheduling department in English or Spanish'. This is a clear match for that category, as the caller is directly requesting to speak with scheduling.	Valentina handled most aspects of this call correctly, including the greeting, identifying the request type, and executing the transfer to the correct department. However, she failed to follow the specific protocol requirement to ask for permission before transferring the call. While the client explicitly requested the transfer, the protocol still requires asking 'Would you like me to transfer your call to them?' before proceeding. This is an important step for confirming the caller's intent and maintaining proper call handling procedures. The assistant should always follow the exact protocol steps even when the client's request seems straightforward.	1	The expected outcome was to transfer the call to scheduling team at +17867056064, which was successfully completed. The agent correctly identified the caller's request and used the transferCall tool with the exact destination number specified in the conditions.	1	{"explanation_score":"Valentina handled most aspects of this call correctly, including the greeting, identifying the request type, and executing the transfer to the correct department. However, she failed to follow the specific protocol requirement to ask for permission before transferring the call. While the client explicitly requested the transfer, the protocol still requires asking 'Would you like me to transfer your call to them?' before proceeding. This is an important step for confirming the caller's intent and maintaining proper call handling procedures. The assistant should always follow the exact protocol steps even when the client's request seems straightforward.","steps_completed":4,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally with 'Hi, this is Always Keep Progressing. How can I help you today?' which was an appropriate opening that invited the caller to state their needs."},{"name":"Request Type","completed":true,"details":"The client directly requested to be transferred to the scheduling department, which aligns with appointment adjustment requests. Valentina correctly recognized this as a scheduling matter."},{"name":"Transfer Permission","completed":false,"details":"Valentina did not explicitly ask for permission to transfer the call. According to the protocol, she should have said something like 'It seems that our scheduling team can assist you with that. Would you like me to transfer your call to them?'"},{"name":"Transfer Execution","completed":true,"details":"Valentina correctly transferred the call to the scheduling team at the appropriate number (+17867056064). The transfer was executed successfully."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't necessary as the transfer was executed. Valentina did provide a brief closure statement informing the caller that she was forwarding the call to the scheduling department."}]}	1	{"explanation":"The customer's message is brief, direct, and purely task-focused. They are simply making a straightforward request to be transferred to the scheduling department without expressing any positive or negative emotions. This type of direct, functional communication is typical when users recognize they're interacting with a service system and are focused on accomplishing their task efficiently.","key_indicators":["Can you transfer me to schedule department, please?"]}	\N	80
593	1033	2025-05-24 03:24:32.351	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to inform them that their daughter would be late for therapy due to heavy rain. After requesting to speak with someone, the caller was transferred to the front desk to handle the situation.	neutral	TIME_SENSITIVE	1	The caller stated that their daughter is running late for therapy due to rain, which is a time-sensitive issue.	The assistant followed the protocol perfectly. The assistant greeted the client, identified the time-sensitive nature of the request, obtained permission for the transfer, executed the transfer correctly, and provided a closure statement. No improvements are necessary.	1	The assistant transferred the call to +13055175439 as requested, fulfilling the condition for the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly. The assistant greeted the client, identified the time-sensitive nature of the request, obtained permission for the transfer, executed the transfer correctly, and provided a closure statement. No improvements are necessary.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs. The assistant also clarified the request details when the user initially asked to speak to someone."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as time-sensitive due to the daughter running late for therapy."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the front desk."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the front desk at +13055175439 after receiving confirmation."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closure statement after the transfer was executed."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach. While there's a mention of a stressful situation (daughter running late, rain), the user doesn't express explicit frustration or anger. The responses are short and to the point, suggesting a neutral emotional state.","key_indicators":["Speak to someone, please.","My daughter is running late for therapy. It's raining really hard.","Yes."]}	\N	100
594	1034	2025-05-24 03:24:32.881	\N	\N	\N	\N	\N	\N	t	A parent called to cancel their son's appointment scheduled for Thursday. The representative from Always Keep Progressing offered to transfer the call to the scheduling department, which the caller accepted.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly states they need to cancel their son's appointment, which falls directly under the appointment adjustment category.	The assistant followed the protocol perfectly, correctly identifying the request type, obtaining permission for the transfer, and executing it successfully. The interaction was handled efficiently and professionally.	1	The assistant transferred the call to the scheduling team at +17867056064 as requested by the user and confirmed by the tool call.	1	{"explanation_score":"The assistant followed the protocol perfectly, correctly identifying the request type, obtaining permission for the transfer, and executing it successfully. The interaction was handled efficiently and professionally.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission before transferring the call."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closing statement after the transfer."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["I need to cancel my son's appointment for Thursday.","Yes, please."]}	\N	100
595	1036	2025-05-24 03:24:33.742	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to verify an appointment in Spanish. The representative offered to transfer them to the scheduling department who could help with appointment verification, and proceeded with the call transfer.	neutral	APPOINTMENT_ADJUSTMENT	0.9	The patient stated 'Para verificar una cita', which translates to 'To verify an appointment'. This clearly indicates they are calling about an existing appointment, fitting the 'APPOINTMENT_ADJUSTMENT' category.	The assistant followed the protocol perfectly. The assistant greeted the client, identified the request type, asked for transfer permission, executed the transfer, and provided a closing statement. The assistant also spoke in both English and Spanish.	1	The assistant transferred the call to +17867056064 as requested, fulfilling the condition for the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly. The assistant greeted the client, identified the request type, asked for transfer permission, executed the transfer, and provided a closing statement. The assistant also spoke in both English and Spanish.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully transferred the call to the scheduling team at +17867056064 after receiving confirmation."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closing statement after transferring the call."}]}	1	{"explanation":"The user's responses are brief and direct, indicating a task-focused interaction. There are no explicit emotional indicators to suggest a positive or negative sentiment. The user is simply responding to the assistant's prompts.","key_indicators":["What's it? Para verificar una cita","¿Sí?"]}	\N	100
596	1037	2025-05-24 03:24:34.29	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to confirm their son's appointment scheduled for the following day. The representative offered to transfer the call to the scheduling department, which the caller accepted.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly states they want to confirm their son's appointment for tomorrow. This falls directly under appointment adjustments.	The assistant followed the protocol perfectly. The interaction was handled efficiently and professionally, correctly identifying the request type, obtaining permission for the transfer, and executing the transfer successfully. The closing statement was also appropriate.	1	The user requested to confirm an appointment, the assistant offered to transfer to the scheduling team, the user agreed, and the call was successfully transferred to +17867056064 as per the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly. The interaction was handled efficiently and professionally, correctly identifying the request type, obtaining permission for the transfer, and executing the transfer successfully. The closing statement was also appropriate.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team at +17867056064."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closing statement after the transfer was initiated."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. The user is simply trying to confirm an appointment.","key_indicators":["Hello?","Um, I would like to make feel I would like to confirm my appointment for my son for tomorrow.","Yeah.","Yes."]}	\N	100
597	1038	2025-05-24 03:24:34.831	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing seeking help with scheduling and mentioned being "in the Dixon 1." After confirming the caller wanted assistance with scheduling, the representative offered to transfer the call to the scheduling team, which the caller accepted.	neutral	NEW_APPOINTMENT_EXISTING_CLIENT	0.9	The caller stated 'Scheduling' and then confirmed they were 'just in the Dixon 1', implying they are an existing client looking to schedule a new appointment. The assistant also asked if they were looking to schedule a new appointment or adjust an existing one, further supporting this classification.	The assistant performed well by greeting the client, identifying the request type, asking for transfer permission, and executing the transfer. However, it missed a crucial step: verifying whether the client was new or existing before offering the transfer. This omission impacts the overall score, as it's a key part of the protocol. Addressing this would improve adherence to the protocol.	1	The user requested scheduling assistance, the assistant offered a transfer to the scheduling team, the user agreed, and the call was successfully transferred to +17867056064 as per the expected outcome.	1	{"explanation_score":"The assistant performed well by greeting the client, identifying the request type, asking for transfer permission, and executing the transfer. However, it missed a crucial step: verifying whether the client was new or existing before offering the transfer. This omission impacts the overall score, as it's a key part of the protocol. Addressing this would improve adherence to the protocol.","steps_completed":5,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the client's request related to scheduling."},{"name":"Client Status Verification","completed":false,"details":"The assistant did not ask if the client was new or existing. It should have asked this before offering a transfer."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for and received permission to transfer the call."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team at +17867056064."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closing statement after the transfer."}]}	1	{"explanation":"The user's responses are brief and direct, indicating a task-focused interaction rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["Scheduling.","I'm just in the Dixon 1.","Yeah."]}	\N	80
598	1039	2025-05-24 03:24:35.353	\N	\N	\N	\N	\N	\N	t	The caller requested to be transferred to the Aetna department for rescheduling, mentioning they were still sick. The agent acknowledged the request and forwarded the call to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	0.9	The caller explicitly states they want to 'get a reschedule' which clearly indicates they are looking to adjust an existing appointment.	The assistant performed perfectly in this scenario. It correctly identified the request type, obtained permission for the transfer, and successfully transferred the call to the appropriate department. The initial interaction was a bit rocky due to the user's unclear communication, but the assistant handled it professionally and effectively.	1	The call was successfully transferred to +17867056064 as requested.	1	{"explanation_score":"The assistant performed perfectly in this scenario. It correctly identified the request type, obtained permission for the transfer, and successfully transferred the call to the appropriate department. The initial interaction was a bit rocky due to the user's unclear communication, but the assistant handled it professionally and effectively.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and attempted to understand their needs, although it took a few tries due to the user's unclear initial statements."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment (reschedule) after the user clarified their need."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team at +17867056064 after receiving permission."},{"name":"Alternative Closure","completed":true,"details":"The assistant did not need to use the alternative closure, as the transfer was approved and executed."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach. There are no strong emotional indicators to suggest a positive or negative sentiment. The user is simply trying to communicate their needs and get assistance with rescheduling an appointment.","key_indicators":["Hello? Hello?","Hello? Yes. Good afternoon. Yes. Good afternoon. How you doing?","Good. Yes. Um, I'm still sick, and I can't blame my kids.","Uh, that's either way. I still sick. Yeah. This is the Glaney and Lovin. The body until thick","I would like to get a a reschedule Aetna department. Over there.","Yes."]}	\N	100
599	1040	2025-05-24 03:24:35.866	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing seeking assistance with scheduling and repeatedly emphasized their need for the scheduling department. After confirming they wanted to be transferred, the representative forwarded the call to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	0.6	The caller repeatedly states they want 'Scheduling' and confirms they want to be transferred to the scheduling department. While they don't explicitly state they want to adjust an appointment, their insistence on reaching the scheduling department suggests they have an appointment-related need. The call lacks specific details about being a new client or booking a new appointment, so APPOINTMENT_ADJUSTMENT is the most appropriate category for general scheduling needs.	Valentina handled this appointment adjustment request excellently, following all required protocols. She properly identified the vague request, asked for clarification, correctly determined the need for the scheduling team, requested permission to transfer, and executed the transfer with the correct number. The only minor improvement could be in the initial interaction where she could have more quickly recognized that 'Scheduling' was the department needed rather than asking if it was for a new appointment or adjustment, but this was a very minor issue as she quickly corrected course when the caller continued to request scheduling.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully completed. The assistant recognized the user's request for scheduling, confirmed the transfer, and executed the transferCall tool with the correct phone number.	1	{"explanation_score":"Valentina handled this appointment adjustment request excellently, following all required protocols. She properly identified the vague request, asked for clarification, correctly determined the need for the scheduling team, requested permission to transfer, and executed the transfer with the correct number. The only minor improvement could be in the initial interaction where she could have more quickly recognized that 'Scheduling' was the department needed rather than asking if it was for a new appointment or adjustment, but this was a very minor issue as she quickly corrected course when the caller continued to request scheduling.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the caller professionally and asked how she could help. When the caller gave vague responses ('I think Scheduling' and 'Agent'), she appropriately asked for more details to clarify the request."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the caller needed the scheduling department after the caller repeatedly mentioned 'Scheduling' in their response. She initially tried to determine if it was for a new appointment or adjustment, which was appropriate."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call with 'Would you like me to transfer your call to them?' which follows the protocol exactly."},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation from the caller, Valentina correctly used the transferCall function with the proper phone number for the scheduling team (+17867056064)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed as the caller agreed to the transfer, but Valentina was prepared to handle this scenario based on her protocol adherence throughout the conversation."}]}	1	{"explanation":"The customer is being direct and task-focused, repeatedly stating 'Scheduling' to indicate their need. While there's some potential frustration implied by the repetition, this appears to be more about ensuring their request is understood rather than expressing negative emotion. The brevity of responses ('I think Scheduling', 'Agent', 'Yes') suggests a purely functional interaction without emotional investment.","key_indicators":["I think Scheduling.","Agent.","Scheduling. Scheduling. Scheduling. Scheduling. Scheduling. Scheduling. Scheduling. Scheduling. People","Yes."]}	\N	95
600	1041	2025-05-24 03:24:36.385	\N	\N	\N	\N	\N	\N	t	The caller requested to be transferred to the scheduling department. The AI representative acknowledged the request and forwarded the call to the scheduling team.	neutral	APPOINTMENT_ADJUSTMENT	0.8	The caller clearly stated they 'Need to speak to the scheduling department, please.' This is a direct request to be connected to scheduling, which falls under the APPOINTMENT_ADJUSTMENT category as it covers 'callers looking to reach the scheduling department in English or Spanish.' The request is straightforward and unambiguous.	Valentina handled most aspects of the call correctly, including the greeting, identifying the request type, and executing the transfer to the correct department with the right phone number. However, she failed to follow a critical step in the protocol by not asking for permission before transferring the call. The instructions clearly state 'Before transferring a call, first confirm if the user wants it.' This is an important customer service practice that gives callers agency in the interaction. The assistant also handled the user's initial unclear speech well by focusing on the clear request that followed.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully completed. The assistant correctly identified the caller's request and used the transferCall tool with the exact phone number specified in the conditions.	1	{"explanation_score":"Valentina handled most aspects of the call correctly, including the greeting, identifying the request type, and executing the transfer to the correct department with the right phone number. However, she failed to follow a critical step in the protocol by not asking for permission before transferring the call. The instructions clearly state 'Before transferring a call, first confirm if the user wants it.' This is an important customer service practice that gives callers agency in the interaction. The assistant also handled the user's initial unclear speech well by focusing on the clear request that followed.","steps_completed":4,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client appropriately with 'Hi, this is Always Keep Progressing. How can I help you today?' which was professional and open-ended."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified that the user needed to speak with the scheduling department, which aligns with handling appointment adjustments."},{"name":"Transfer Permission","completed":false,"details":"Valentina failed to ask for permission before transferring the call. According to the protocol, she should have said something like 'Would you like me to transfer your call to them?' and waited for confirmation."},{"name":"Transfer Execution","completed":true,"details":"Valentina correctly transferred the call to the scheduling team at the right number (+17867056064)."},{"name":"Alternative Closure","completed":true,"details":"Not applicable in this case as the transfer was executed, but the assistant did provide a proper closing statement informing the caller about the transfer."}]}	1	{"explanation":"The customer initially seems to be speaking to someone else or thinking out loud with some frustration ('fucking paint a little bit'), but then redirects with 'Leave it' and proceeds to make a straightforward request to be transferred to the scheduling department. This appears to be a task-focused interaction without clear emotional indicators directed at the service.","key_indicators":["Need to speak to the scheduling department, please."]}	\N	80
601	1042	2025-05-24 03:24:36.929	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing with an unclear initial statement, then clarified they wanted to cancel an appointment. After the representative offered to transfer them to the scheduling team, the caller agreed and was forwarded to the appropriate department.	neutral	APPOINTMENT_ADJUSTMENT	1	The user explicitly stated 'Cancel apartment,' which is interpreted as a request to cancel an appointment. The assistant correctly identified this as an appointment adjustment.	Valentina handled this appointment adjustment request perfectly. She correctly identified the client's need despite unclear communication, asked for permission to transfer, used the correct transfer number, and provided a clear closing statement. She demonstrated excellent problem-solving when faced with unclear initial input and followed the protocol exactly as specified.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully completed. The assistant recognized the user's need to cancel an appointment and properly transferred the call to the specified number.	1	{"explanation_score":"Valentina handled this appointment adjustment request perfectly. She correctly identified the client's need despite unclear communication, asked for permission to transfer, used the correct transfer number, and provided a clear closing statement. She demonstrated excellent problem-solving when faced with unclear initial input and followed the protocol exactly as specified.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally, asked how she could help, and when faced with unclear input ('Desert upon its'), she appropriately asked for clarification."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified the client's request as an appointment adjustment when the client said 'Cancel apartment' (likely meaning 'Cancel appointment')."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call to the scheduling team with 'Would you like me to transfer you to our scheduling team to assist with that?'"},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation ('Yeah'), Valentina correctly used the transferCall function with the proper scheduling team number (+17867056064)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed as the client agreed to the transfer, but Valentina did properly close the interaction by informing the client 'I am forwarding your call to the scheduling department. Please stay on the line.'"}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. The user is not showing any signs of frustration or dissatisfaction, but also not expressing any happiness or gratitude.","key_indicators":["Desert upon its","Yes. Cancel apartment.","Yeah."]}	\N	100
602	1043	2025-05-24 03:24:37.46	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to check on their appointment. After a brief exchange, the representative offered to transfer the call to the scheduling department, which the caller accepted.	neutral	APPOINTMENT_ADJUSTMENT	1	The patient is asking to check on their appointment, which falls under appointment adjustments.	The assistant followed the protocol perfectly, correctly identifying the request type, obtaining permission for the transfer, and executing the transfer successfully. The interaction was handled efficiently and professionally.	1	The assistant transferred the call to +17867056064 as requested, fulfilling the condition for the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly, correctly identifying the request type, obtaining permission for the transfer, and executing the transfer successfully. The interaction was handled efficiently and professionally.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission before transferring the call."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team."},{"name":"Alternative Closure","completed":true,"details":"The assistant informed the user that they were forwarding the call."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["Check on my appointment.","Please."]}	\N	100
603	1044	2025-05-24 03:24:37.982	\N	\N	\N	\N	\N	\N	t	The caller requested to cancel an appointment and agreed to be transferred to the scheduling department. The AI representative forwarded the call to the appropriate team.	neutral	APPOINTMENT_ADJUSTMENT	1	The patient explicitly stated they want to 'Cancel appointment,' which falls directly under the definition of APPOINTMENT_ADJUSTMENT.	Valentina handled this appointment cancellation request perfectly, following all required steps in the protocol. She correctly identified the request type as an appointment adjustment, asked for permission to transfer, and executed the transfer to the correct department once permission was granted. Her responses were concise and professional throughout the interaction. There are no areas for improvement in this interaction as all steps were completed correctly and efficiently.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully completed. The assistant recognized the need to transfer the call and used the transferCall tool with the correct destination number.	1	{"explanation_score":"Valentina handled this appointment cancellation request perfectly, following all required steps in the protocol. She correctly identified the request type as an appointment adjustment, asked for permission to transfer, and executed the transfer to the correct department once permission was granted. Her responses were concise and professional throughout the interaction. There are no areas for improvement in this interaction as all steps were completed correctly and efficiently.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the client professionally and asked how she could help, which was appropriate for opening the conversation."},{"name":"Request Type","completed":true,"details":"Valentina correctly identified that the client's request to cancel an appointment falls under appointment adjustments that should be handled by the scheduling team."},{"name":"Transfer Permission","completed":true,"details":"Valentina properly asked for permission to transfer the call to the scheduling team, following protocol exactly as instructed."},{"name":"Transfer Execution","completed":true,"details":"After receiving permission, Valentina correctly executed the transferCall function to the scheduling team at the correct number (+17867056064)."},{"name":"Alternative Closure","completed":true,"details":"This step wasn't needed since the client agreed to the transfer, but Valentina did provide appropriate closure by informing the client that the call was being forwarded and to stay on the line."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["Cancel appointment.","Yes."]}	\N	100
604	1045	2025-05-24 03:24:38.497	\N	\N	\N	\N	\N	\N	t	The caller requested to cancel an appointment and agreed to be transferred to the scheduling department. The representative from Always Keep Progressing forwarded the call to the appropriate team.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly stated they want to 'cancel appointment,' which falls directly under the definition of APPOINTMENT_ADJUSTMENT.	The assistant followed the protocol perfectly, correctly identifying the request type, obtaining permission for the transfer, executing the transfer, and providing a closure message. No improvements are needed.	1	The assistant transferred the call to the scheduling team at +17867056064 as requested, fulfilling the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly, correctly identifying the request type, obtaining permission for the transfer, executing the transfer, and providing a closure message. No improvements are needed.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission before transferring the call."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closure message after the transfer."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["Cancel appointment.","Yes."]}	\N	100
605	1046	2025-05-24 03:24:39.137	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing but provided minimal responses, only saying "Representative," "Castle," and "Yes." After attempting to get more information, the agent transferred the call to the front desk.	neutral	MISCALANEOUS	0.8	The caller only provided very limited information with the words 'Representative' and 'Castle' without clearly stating their purpose or need. There is not enough information to categorize this call into any of the specific categories, as the caller did not express any clear request related to appointments, billing, inquiries, or other defined categories. When a call cannot be clearly categorized due to insufficient information, it falls into the MISCALANEOUS category.	Protocol evaluation skipped for MISCALANEOUS call type.	0.95	The expected outcome was achieved. When the caller requested 'Castle' and confirmed they needed to be transferred, the assistant correctly transferred the call to +13055175439, which is the front desk number specified in the expected outcome conditions.	1	{"explanation_score":"Protocol evaluation skipped for MISCALANEOUS call type.","steps_completed":0,"total_steps":0,"steps":[]}	1	{"explanation":"The customer is being extremely brief and direct, using single-word responses throughout the conversation. This appears to be task-focused communication rather than expressing any particular emotion. They simply want to be transferred to a representative at 'Castle' and confirm the transfer with 'Yes'. There are no indicators of frustration, anger, happiness or any other emotional state.","key_indicators":["Representative.","Castle.","Yes."]}	\N	0
606	1047	2025-05-24 03:24:39.673	\N	\N	\N	\N	\N	\N	f	The caller contacted Always Keep Progressing about scheduling but provided unclear responses. When asked if they were a new or existing client, the caller gave an incomplete statement, and the conversation ended without scheduling an appointment.	neutral	NEW_APPOINTMENT_EXISTING_CLIENT	0.4	The user initially said "schedule" and then responded "yes" when asked if they were looking to schedule a new appointment or adjust an existing one. The assistant then asked if they were a new or existing client. The user did not answer this question directly. Because the user did not confirm they were a new client, and the initial request was to schedule, it is more likely to be a new appointment for an existing client or an appointment adjustment. Given the limited information, I am leaning towards NEW_APPOINTMENT_EXISTING_CLIENT, but APPOINTMENT_ADJUSTMENT is also possible, hence the low confidence.	The assistant started well by greeting the client, identifying the request type, and verifying client status. However, the assistant failed to proceed with the transfer process after the client's ambiguous response. Instead of attempting to clarify further and then offering a transfer, the assistant closed the interaction prematurely. To improve, the assistant should have tried to clarify the client's needs more thoroughly before closing the call.	1	The call did not result in a transfer to the scheduling team. The assistant ended the call without fulfilling the user's request to schedule an appointment.	1	{"explanation_score":"The assistant started well by greeting the client, identifying the request type, and verifying client status. However, the assistant failed to proceed with the transfer process after the client's ambiguous response. Instead of attempting to clarify further and then offering a transfer, the assistant closed the interaction prematurely. To improve, the assistant should have tried to clarify the client's needs more thoroughly before closing the call.","steps_completed":4,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified that the client was looking to schedule an appointment."},{"name":"Client Status Verification","completed":true,"details":"The assistant asked if the client was new or existing."},{"name":"Transfer Permission","completed":false,"details":"The assistant did not ask for permission to transfer to the scheduling team. Instead, after the client's ambiguous response, the assistant asked for more details and then closed the interaction."},{"name":"Transfer Execution","completed":false,"details":"The assistant did not execute a transfer because permission was not obtained."},{"name":"Alternative Closure","completed":true,"details":"The assistant closed the interaction appropriately after the client's ambiguous response and after asking for more details."}]}	1	{"explanation":"The user's responses are brief and somewhat ambiguous, but do not express any clear positive or negative emotion. The user seems to be responding to prompts in a direct, task-focused manner, which indicates a neutral sentiment.","key_indicators":["Schedule","Yes.","But I'm just saying,"]}	\N	60
607	1048	2025-05-24 03:24:40.197	\N	\N	\N	\N	\N	\N	f	The caller contacted Always Keep Progressing but only said "Far Juli" which appeared to be unclear. The representative responded by offering assistance in Spanish, asking for more information to transfer the caller to the appropriate department.	neutral	LOOKING_FOR_SOMEONE	1	The caller is asking for 'Far Juli'. This indicates they are trying to reach a specific person.	The assistant started well by greeting the client and identifying the need for assistance. However, it did not follow the protocol of asking for permission before transferring the call. The assistant correctly identified that the user might need assistance in Spanish. To improve, the assistant should ask for permission to transfer before proceeding with the transfer.	0.1	The call did not result in a transfer to +13055175439. The assistant only asked for more information to transfer the user to the appropriate department.	1	{"explanation_score":"The assistant started well by greeting the client and identifying the need for assistance. However, it did not follow the protocol of asking for permission before transferring the call. The assistant correctly identified that the user might need assistance in Spanish. To improve, the assistant should ask for permission to transfer before proceeding with the transfer.","steps_completed":2,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified that the caller was looking for someone and asked for more information in Spanish, assuming the user was speaking in Spanish."},{"name":"Transfer Permission","completed":false,"details":"The assistant did not ask for permission to transfer to the front desk. Instead, the assistant asked for more information in Spanish."},{"name":"Transfer Execution","completed":false,"details":"The assistant did not execute the transfer because it was waiting for more information."},{"name":"Alternative Closure","completed":false,"details":"The interaction did not reach a point where an alternative closure was needed."}]}	1	{"explanation":"The user's initial response is very brief and direct. This suggests a task-focused approach, which defaults to neutral sentiment. There are no clear emotional indicators present in the user's single message.","key_indicators":["Far Juli."]}	\N	60
608	1050	2025-05-24 03:24:41.053	\N	\N	\N	\N	\N	\N	f	The caller contacted Always Keep Progressing but provided unclear responses, first saying "Schedule" and then mentioning "chicken," without clearly indicating whether they were a new or existing client seeking to schedule a service.	neutral	NEW_APPOINTMENT_EXISTING_CLIENT	0.6	The user initially said "Schedule" and then responded with "And the chicken 1" which is unclear, but the assistant followed up asking if they were a new or existing client. The user did not confirm they were a new client, so it is more likely they are an existing client looking to schedule a new appointment. It could also be APPOINTMENT_ADJUSTMENT, but the initial request was to schedule.	The assistant started well by greeting the client and asking about their needs and client status. However, the conversation stalled due to the user's unclear response. The assistant correctly attempted to clarify the request. The score is reduced because the assistant did not complete the transfer or closure steps due to the unclear response from the user. To improve, the assistant could use more direct clarifying questions or rephrase the question about new or existing client status.	0.1	The call did not result in a transfer to +17867056064. The assistant is still trying to determine the user's needs.	1	{"explanation_score":"The assistant started well by greeting the client and asking about their needs and client status. However, the conversation stalled due to the user's unclear response. The assistant correctly attempted to clarify the request. The score is reduced because the assistant did not complete the transfer or closure steps due to the unclear response from the user. To improve, the assistant could use more direct clarifying questions or rephrase the question about new or existing client status.","steps_completed":2,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":false,"details":"The assistant initially identified the request as 'schedule' but needed clarification due to the user's unclear response."},{"name":"Client Status Verification","completed":true,"details":"The assistant asked if the client was new or existing."},{"name":"Transfer Permission","completed":false,"details":"The assistant did not ask for permission to transfer to the scheduling team because the client's status (new or existing) was not yet determined."},{"name":"Transfer Execution","completed":false,"details":"The assistant did not execute a transfer because the client's status was not yet determined."},{"name":"Alternative Closure","completed":false,"details":"The interaction did not reach a closure because the client's status was not yet determined."}]}	1	{"explanation":"The user's responses are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. The user is likely aware they are interacting with an AI and is providing minimal input to achieve their goal.","key_indicators":["Schedule.","And the chicken 1."]}	\N	60
609	1051	2025-05-24 03:24:41.595	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to adjust an existing appointment. After confirming the caller's need, the representative informed them that the scheduling team could help and forwarded the call to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly stated they wanted to 'adjust an existing one [appointment]'. This clearly falls under the APPOINTMENT_ADJUSTMENT category.	The assistant followed the protocol perfectly, greeting the client, identifying the request type, obtaining transfer permission, executing the transfer, and closing the interaction appropriately. No improvements are necessary.	1	The user requested to be transferred to scheduling, and the assistant successfully transferred the call to the specified number +17867056064, fulfilling the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly, greeting the client, identifying the request type, obtaining transfer permission, executing the transfer, and closing the interaction appropriately. No improvements are necessary.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully transferred the call to the scheduling team at +17867056064."},{"name":"Alternative Closure","completed":true,"details":"The assistant confirmed the transfer and instructed the caller to stay on the line."}]}	1	{"explanation":"The user's responses are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["Scheduling.","Adjust an existing 1.","Yes, please."]}	\N	100
610	1052	2025-05-24 03:24:42.124	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to discuss scheduling matters. After identifying as an existing client, they agreed to be transferred to the scheduling team.	neutral	NEW_APPOINTMENT_EXISTING_CLIENT	1	The caller explicitly stated they wanted to 'schedule' and confirmed they are an existing client. This clearly indicates they are looking to book a new appointment.	The assistant followed the protocol perfectly, greeting the client, identifying the request, verifying client status, obtaining transfer permission, executing the transfer, and closing the interaction appropriately. No improvements are necessary.	1	The user requested to be transferred to the scheduling team, and the assistant successfully transferred the call to +17867056064 as specified in the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly, greeting the client, identifying the request, verifying client status, obtaining transfer permission, executing the transfer, and closing the interaction appropriately. No improvements are necessary.","steps_completed":6,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the client's request to schedule an appointment."},{"name":"Client Status Verification","completed":true,"details":"The assistant asked and confirmed that the client was an existing one."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully transferred the call to the scheduling team at +17867056064."},{"name":"Alternative Closure","completed":true,"details":"The assistant closed the interaction appropriately after the transfer was accepted."}]}	1	{"explanation":"The user's responses are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["Schedule","An existing 1.","Yes."]}	\N	100
611	1053	2025-05-24 03:24:42.661	\N	\N	\N	\N	\N	\N	t	The caller from Oscar inquired about establishing a partnership to offer Always Keep Progressing's services through their home health aid program. They requested to speak with someone about this potential collaboration and were transferred to the front desk.	neutral	GENERAL_INQUIRY_TRANSFER	0.9	The caller is inquiring about a partnership between their home health aid program and AKP's services and is asking to speak with someone who can provide information about this. This is a general inquiry that the initial assistant cannot answer, thus requiring a transfer.	The assistant followed most of the protocol correctly, including greeting the client, identifying the request type, asking for transfer permission, and executing the transfer. However, the assistant missed the step of attempting to answer the question using the knowledge base tool before transferring the call. This omission lowers the overall score. The assistant should be reminded to utilize the knowledge base tool to address inquiries before resorting to a transfer.	1	The user requested information about a partnership and was transferred to the front desk at +13055175439 as requested.	1	{"explanation_score":"The assistant followed most of the protocol correctly, including greeting the client, identifying the request type, asking for transfer permission, and executing the transfer. However, the assistant missed the step of attempting to answer the question using the knowledge base tool before transferring the call. This omission lowers the overall score. The assistant should be reminded to utilize the knowledge base tool to address inquiries before resorting to a transfer.","steps_completed":5,"total_steps":7,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs appropriately."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as a general inquiry regarding a potential partnership."},{"name":"Answer Questions","completed":false,"details":"The assistant did not attempt to answer the question directly before offering a transfer. The assistant should have used the knowledge base tool to see if there was any information about partnerships."},{"name":"Call Knowledge Base","completed":false,"details":"The assistant did not use the knowledge base tool to try and answer the question before transferring."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission before transferring the call."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the call transfer to the front desk."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closing statement after the transfer."}]}	1	{"explanation":"The user is direct and polite but task-focused. There are no strong emotional indicators, so the sentiment is neutral.","key_indicators":["Hello. Good afternoon.","I'm calling from Oscar. I would like to, uh, know information about our partnership.","We offer a home health aid program And we we would like to offer your services. Who can I speak with?","Yes, please."]}	\N	75
612	1054	2025-05-24 03:24:43.177	\N	\N	\N	\N	\N	\N	t	The caller requested to speak with a representative in Spanish. After asking for more information and receiving the same request, the AI offered to transfer the call to the front desk, which the caller confirmed they wanted.	neutral	GENERAL_INQUIRY_TRANSFER	0.4	The caller only says 'Habla con un representante' (Speak with a representative) and 'Habla con representante' without specifying any particular reason for the call. This could be a general inquiry that needs to be transferred since they're specifically asking for a representative rather than stating their need. However, without more context about their specific need, it's difficult to categorize definitively. Could also be MISCALANEOUS since it doesn't clearly fit other categories, or potentially any other category since the caller didn't specify their actual need.	Valentina handled the basic protocol correctly by greeting the caller, asking for permission to transfer, and executing the transfer properly. However, she missed opportunities to gather more information about the nature of the inquiry, which would have helped ensure the caller was directed to the most appropriate department. When the caller simply repeated their request for a representative without providing details, Valentina could have asked more specific questions in Spanish to better understand their needs before defaulting to the front desk transfer. While the transfer itself was handled correctly, the lack of information gathering reduced the effectiveness of the interaction.	1	The expected outcome was achieved as the assistant successfully transferred the call to +13055175439, which matches the required condition for this call type.	1	{"explanation_score":"Valentina handled the basic protocol correctly by greeting the caller, asking for permission to transfer, and executing the transfer properly. However, she missed opportunities to gather more information about the nature of the inquiry, which would have helped ensure the caller was directed to the most appropriate department. When the caller simply repeated their request for a representative without providing details, Valentina could have asked more specific questions in Spanish to better understand their needs before defaulting to the front desk transfer. While the transfer itself was handled correctly, the lack of information gathering reduced the effectiveness of the interaction.","steps_completed":4,"total_steps":7,"steps":[{"name":"Initial Interaction","completed":true,"details":"Valentina greeted the caller professionally and asked how she could help, establishing a good first impression."},{"name":"Request Type","completed":false,"details":"Valentina did not clearly identify the request type. The caller simply asked to speak with a representative in Spanish, but Valentina didn't probe further to understand the specific nature of the inquiry."},{"name":"Answer Questions","completed":false,"details":"There were no specific questions to answer as the caller only requested to speak with a representative without providing details about their inquiry."},{"name":"Call Knowledge Base","completed":false,"details":"Valentina did not use the queryKnowledgeBase tool to attempt to answer any questions before transferring, though this may not have been applicable since no specific question was asked."},{"name":"Transfer Permission","completed":true,"details":"Valentina appropriately asked for permission to transfer the call to the front desk team, following protocol."},{"name":"Transfer Execution","completed":true,"details":"After receiving confirmation from the caller, Valentina correctly used the transferCall function with the appropriate number (+13055175439) for the front desk."},{"name":"Alternative Closure","completed":true,"details":"Valentina properly informed the caller that they were being transferred to the front desk, providing appropriate closure to the interaction."}]}	1	{"explanation":"The customer is being direct and brief throughout the conversation, requesting to speak with a representative in Spanish and then confirming they are still present with a simple 'Yes.' There are no emotional indicators of frustration, anger, or satisfaction - just straightforward requests to be transferred to a human representative.","key_indicators":["Habla con un representante.","Habla con representante.","Yes."]}	\N	75
613	1055	2025-05-24 03:24:43.691	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to reschedule their son's appointment. After the caller explained their need, the representative offered to transfer them to the scheduling department, which the caller accepted.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly states they need to reschedule their son's appointment, which falls directly under appointment adjustments.	The assistant followed the protocol perfectly. The interaction was handled efficiently and professionally, leading to a successful transfer to the scheduling team. All steps were completed as expected.	1	The assistant transferred the call to the scheduling team at +17867056064 as requested.	1	{"explanation_score":"The assistant followed the protocol perfectly. The interaction was handled efficiently and professionally, leading to a successful transfer to the scheduling team. All steps were completed as expected.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission before transferring the call."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team."},{"name":"Alternative Closure","completed":true,"details":"The assistant confirmed the transfer."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. The user simply states their need and then agrees to the transfer.","key_indicators":["I need to reschedule my son's I need to reschedule my son's appointment.","Okay."]}	\N	100
614	1056	2025-05-24 03:24:44.249	\N	\N	\N	\N	\N	\N	t	The caller requested to speak with Monica and when asked for more details, they indicated they wanted a callback. After confirming they wanted to be transferred to the front desk department, the agent forwarded their call.	neutral	LOOKING_FOR_SOMEONE	1	The patient's primary request is to speak with Monica. This clearly falls under the 'LOOKING_FOR_SOMEONE' category.	The assistant followed the protocol perfectly. It greeted the client, identified the request type, asked for transfer permission, executed the transfer successfully, and provided a closure. No improvements are needed.	1	The user requested to be transferred to the front desk, and the assistant successfully transferred the call to +13055175439 as specified in the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly. It greeted the client, identified the request type, asked for transfer permission, executed the transfer successfully, and provided a closure. No improvements are needed.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified that the caller was looking for a specific person and then a callback."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the front desk."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully transferred the call to the front desk at +13055175439 after receiving permission."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closure by forwarding the call to the front desk."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. The user is simply trying to get transferred to the correct person/department. The \\"Yes. Yes, please.\\" is an affirmation of the assistant's suggestion, not necessarily an expression of strong positive sentiment.","key_indicators":["Can I talk to Monica?","Call back.","Yes. Yes, please."]}	\N	100
615	1057	2025-05-24 03:24:44.772	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to cancel their son's appointment for the day. After confirming they had reached the correct organization, the representative offered to transfer them to the scheduling department to handle the cancellation.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly states they want to cancel their son's appointment, which falls directly under appointment adjustments.	The assistant followed the protocol perfectly. The assistant greeted the caller, identified the request type, asked for transfer permission, executed the transfer, and provided a closing statement. No improvements are necessary.	1	The user requested to cancel an appointment, and the assistant offered to transfer them to the scheduling team, which the user accepted. The call was then successfully transferred to +17867056064 as per the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly. The assistant greeted the caller, identified the request type, asked for transfer permission, executed the transfer, and provided a closing statement. No improvements are necessary.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively, even after initial unclear input."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment (cancellation)."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team at +17867056064 after receiving permission."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closing statement after the transfer was initiated."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["Thank Hello?","Is this always keep progressing?","Okay. My I just wanted to cancel my son's appointment today.","Yes."]}	\N	100
616	1058	2025-05-24 03:24:45.379	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to adjust an existing appointment. After confirming the caller needed help with scheduling changes, the representative transferred the call to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly stated they wanted to 'adjust' their schedule, which falls directly under the definition of 'APPOINTMENT_ADJUSTMENT'.	The assistant followed the protocol perfectly. The interaction was smooth, and the assistant correctly identified the request type, obtained permission for the transfer, and executed it successfully. The initial greeting was a bit rocky, but the assistant recovered well.	1	The expected outcome was to transfer the call to the scheduling team at +17867056064, which was successfully completed. The assistant correctly identified the caller's need to adjust a schedule, offered to transfer them, and then executed the transfer to the exact number specified in the conditions.	1	{"explanation_score":"The assistant followed the protocol perfectly. The interaction was smooth, and the assistant correctly identified the request type, obtained permission for the transfer, and executed it successfully. The initial greeting was a bit rocky, but the assistant recovered well.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs, although there was some initial confusion with the connection."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully transferred the call to the scheduling team at +17867056064 after receiving permission."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closing statement after initiating the transfer."}]}	1	{"explanation":"The user's responses are brief and direct, indicating a task-focused interaction rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["Hello?","Adjust","Yeah."]}	\N	100
617	1059	2025-05-24 03:24:45.889	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to cancel an appointment, speaking in Spanish. The representative acknowledged the request and offered to transfer the call to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly stated 'Cancelar una cita' which translates to 'Cancel an appointment'. This clearly indicates a request to adjust an existing appointment.	The assistant followed the protocol perfectly. It greeted the client, clarified the request, identified it as an appointment adjustment, asked for transfer permission, and successfully executed the transfer. The assistant also provided confirmation to the user.	1	The call was successfully transferred to +17867056064 as requested.	1	{"explanation_score":"The assistant followed the protocol perfectly. It greeted the client, clarified the request, identified it as an appointment adjustment, asked for transfer permission, and successfully executed the transfer. The assistant also provided confirmation to the user.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and attempted to clarify the request after an incomplete initial statement."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment (cancellation)."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team in Spanish."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team at +17867056064."},{"name":"Alternative Closure","completed":true,"details":"The assistant confirmed the transfer and announced it to the user."}]}	1	{"explanation":"The user's messages are brief and direct. The user is likely focused on the task of canceling an appointment. There are no explicit emotional indicators to suggest a positive or negative sentiment.","key_indicators":["I'm","Cancelar una cita."]}	\N	100
618	1060	2025-05-24 03:24:46.406	\N	\N	\N	\N	\N	\N	t	The caller requested to cancel their daughter's appointment scheduled for that morning. The AI representative offered to transfer the call to the scheduling department, which the caller accepted.	neutral	APPOINTMENT_ADJUSTMENT	1	The caller explicitly states they want to cancel an appointment for their daughter. This falls directly under the definition of 'APPOINTMENT_ADJUSTMENT'.	The assistant followed the protocol perfectly. The interaction was handled efficiently and correctly, from initial greeting to transferring the call to the appropriate department. All steps were completed successfully.	1	The assistant offered to transfer the call to the scheduling team, the user agreed, and the call was successfully transferred to +17867056064 as per the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly. The interaction was handled efficiently and correctly, from initial greeting to transferring the call to the appropriate department. All steps were completed successfully.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment (cancellation)."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for and received permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team at +17867056064."},{"name":"Alternative Closure","completed":true,"details":"The assistant confirmed the transfer and instructed the user to stay on the line."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["I would like to cancel for my daughter for this morning.","Yes. Please."]}	\N	100
619	1061	2025-05-24 03:24:46.925	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to update their son's insurance information. After confirming the caller's request, the representative informed them that the front desk team could assist with this matter and forwarded their call to that department.	neutral	GENERAL_INQUIRY	0.9	The caller is asking to update their son's insurance information. This is a general inquiry related to patient information and not specifically billing or authorization, so GENERAL_INQUIRY is the most appropriate category.	The assistant initiated the call well but missed opportunities to provide better service. The request type was misidentified, and the assistant did not attempt to answer any questions or offer a proper closure. The assistant should have confirmed the request and asked if there was anything else before transferring the call. The assistant should have categorized the request as an 'Appointment Adjustment' and followed the appropriate protocol.	1	The assistant understood the user's request to update their son's insurance and transferred the call to the front desk, which is the expected procedure. The user confirmed the need for the transfer.	1	{"explanation_score":"The assistant initiated the call well but missed opportunities to provide better service. The request type was misidentified, and the assistant did not attempt to answer any questions or offer a proper closure. The assistant should have confirmed the request and asked if there was anything else before transferring the call. The assistant should have categorized the request as an 'Appointment Adjustment' and followed the appropriate protocol.","steps_completed":1,"total_steps":4,"steps":[{"name":"Initial Interaction: Greet the client, inquire about their needs, and clarify request details if vague","completed":true,"details":"The assistant greeted the client and inquired about their needs. There was a slight interruption, but the assistant recovered and re-asked how they could assist."},{"name":"Request Type: Identify that the request is about a general inquiry about the practice","completed":false,"details":"The assistant correctly identified that the client needed to update insurance information, which falls under general inquiries but should have been categorized as an 'Appointment Adjustment' since it involves updating existing patient information. The assistant should have confirmed the request before transferring."},{"name":"Answer Questions: Answer the questions with the information available, use the Knowledge Base to answer the question if needed","completed":false,"details":"The assistant did not answer any questions directly but instead immediately opted to transfer the call. While updating insurance information is a task handled by the front desk, the assistant could have briefly acknowledged the request and then offered the transfer."},{"name":"Closure: Ask if there is anything else we can help with and close the interaction","completed":false,"details":"The assistant did not ask if there was anything else they could help with before transferring the call. The closure was abrupt."}]}	1	{"explanation":"The user's messages are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. The \\"um\\" suggests a slight hesitation, but not enough to indicate negativity.","key_indicators":["Hi.","I have, um, to update my hello?","Hi.","Can you hear me?","I need to, um, update my son's insurance.","Yes."]}	\N	60
620	1062	2025-05-24 03:24:47.542	\N	\N	\N	\N	\N	\N	t	The caller contacted Always Keep Progressing to schedule an appointment. After identifying as an existing client, they agreed to be transferred to the scheduling department.	neutral	NEW_APPOINTMENT_EXISTING_CLIENT	0.9	The caller stated they wanted to 'schedule' and confirmed they are an existing client. This indicates they are looking to book a new appointment.	The assistant followed the protocol perfectly. The interaction was smooth, and all steps were completed successfully. The assistant greeted the client, identified the request, verified client status, obtained transfer permission, and executed the transfer correctly.	1	The user requested to be transferred to the scheduling team, and the assistant successfully transferred the call to the specified number +17867056064.	1	{"explanation_score":"The assistant followed the protocol perfectly. The interaction was smooth, and all steps were completed successfully. The assistant greeted the client, identified the request, verified client status, obtained transfer permission, and executed the transfer correctly.","steps_completed":5,"total_steps":6,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs effectively."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the client's request to schedule an appointment."},{"name":"Client Status Verification","completed":true,"details":"The assistant asked and confirmed that the client was an existing one."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission to transfer the call to the scheduling team."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully transferred the call to the scheduling team at +17867056064."},{"name":"Alternative Closure","completed":false,"details":"This step was not applicable as the transfer was approved and executed."}]}	1	{"explanation":"The customer is extremely brief and direct, using only one-word responses ('Schedule', 'Existing', 'Yes'). This indicates a task-focused interaction rather than emotional engagement. There are no indicators of either positive or negative emotion - the customer is simply seeking to accomplish a specific task efficiently.","key_indicators":["Schedule.","Existing.","Yes."]}	\N	100
621	1063	2025-05-24 03:24:48.056	\N	\N	\N	\N	\N	\N	t	The caller requested to speak with customer service, specifically about scheduling. After confirming this was their need, the representative informed the caller they would be transferred to the scheduling department.	neutral	APPOINTMENT_ADJUSTMENT	0.9	The caller specifically asked for 'scheduling', indicating they likely need to book, cancel, reschedule, or confirm an appointment. This falls under the APPOINTMENT_ADJUSTMENT category.	The assistant followed the protocol perfectly. The interaction was handled efficiently and correctly, from initial greeting to transferring the call to the appropriate department. All steps were completed successfully.	1	The call was successfully transferred to +17867056064 as requested, fulfilling the expected outcome.	1	{"explanation_score":"The assistant followed the protocol perfectly. The interaction was handled efficiently and correctly, from initial greeting to transferring the call to the appropriate department. All steps were completed successfully.","steps_completed":5,"total_steps":5,"steps":[{"name":"Initial Interaction","completed":true,"details":"The assistant greeted the client and inquired about their needs."},{"name":"Request Type","completed":true,"details":"The assistant correctly identified the request as an appointment adjustment related to scheduling."},{"name":"Transfer Permission","completed":true,"details":"The assistant asked for permission before transferring the call."},{"name":"Transfer Execution","completed":true,"details":"The assistant successfully executed the transfer to the scheduling team at +17867056064."},{"name":"Alternative Closure","completed":true,"details":"The assistant provided a closure statement after the transfer."}]}	1	{"explanation":"The user's responses are brief and direct, indicating a task-focused approach rather than any strong positive or negative emotion. There are no explicit expressions of frustration or satisfaction.","key_indicators":["Customer service.","Scheduling.","Yeah."]}	\N	100
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, name, email, role) FROM stdin;
165	Guest Reviewer	guest.reviewer@example.com	QA_Agent
166	JP	jp@csv.example.com	QA_Agent
167	Producción/Client	producción/client@csv.example.com	QA_Agent
164	Esthefany	esthefany@csv.example.com	QA_Agent
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
d47dc4f8-973e-4190-92be-2d168f3a5608	3d5c8a39443e76a4575d3e8d919ef21ac3279b79266dc29c4f642ee54e7b5ea8	2025-05-23 06:00:26.389177+00	20250523060022_init	\N	\N	2025-05-23 06:00:25.874382+00	1
499270c6-c9c0-4519-b548-1c8f3d5f7c07	7c5d61dfcaf07e246a488b9eb0efd933028cad25c78dd781b2e2e06fbe02f9a4	2025-05-23 18:47:11.739769+00	20250523184707_add_ended_reason_field	\N	\N	2025-05-23 18:47:11.283584+00	1
b46e7cd3-871a-4b22-ad95-ff9c64ff7b46	bd4e64705ee9d8c3d1eb2aac7bd6524604f7b4d5978e6e78a0162e6835ed1de9	2025-05-23 18:54:01.317774+00	20250523185356_separate_human_llm_evaluations	\N	\N	2025-05-23 18:54:00.840904+00	1
7f416ff5-092a-4f03-81a2-61a19b20c768	32eb9e8e780676b2fcb9a8ac014f5a72dc37434bd77ebdbffcc87c64997e68e5	2025-05-23 20:45:26.753785+00	20250523204522_add_detailed_csv_fields	\N	\N	2025-05-23 20:45:26.309187+00	1
06fff607-0f1a-4919-899f-34414ece2539	5077e1c00b98b715e9040958dd8f304edcf10ccc71e3a3e45594f52d7e2d1544	2025-05-24 02:59:23.91207+00	20250524025919_data_ingestion	\N	\N	2025-05-24 02:59:23.460545+00	1
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-05-23 04:48:16
20211116045059	2025-05-23 04:48:18
20211116050929	2025-05-23 04:48:20
20211116051442	2025-05-23 04:48:22
20211116212300	2025-05-23 04:48:25
20211116213355	2025-05-23 04:48:27
20211116213934	2025-05-23 04:48:29
20211116214523	2025-05-23 04:48:32
20211122062447	2025-05-23 04:48:34
20211124070109	2025-05-23 04:48:36
20211202204204	2025-05-23 04:48:38
20211202204605	2025-05-23 04:48:40
20211210212804	2025-05-23 04:48:46
20211228014915	2025-05-23 04:48:48
20220107221237	2025-05-23 04:48:50
20220228202821	2025-05-23 04:48:52
20220312004840	2025-05-23 04:48:54
20220603231003	2025-05-23 04:48:58
20220603232444	2025-05-23 04:49:00
20220615214548	2025-05-23 04:49:02
20220712093339	2025-05-23 04:49:04
20220908172859	2025-05-23 04:49:06
20220916233421	2025-05-23 04:49:08
20230119133233	2025-05-23 04:49:10
20230128025114	2025-05-23 04:49:13
20230128025212	2025-05-23 04:49:15
20230227211149	2025-05-23 04:49:17
20230228184745	2025-05-23 04:49:19
20230308225145	2025-05-23 04:49:21
20230328144023	2025-05-23 04:49:23
20231018144023	2025-05-23 04:49:25
20231204144023	2025-05-23 04:49:29
20231204144024	2025-05-23 04:49:31
20231204144025	2025-05-23 04:49:33
20240108234812	2025-05-23 04:49:35
20240109165339	2025-05-23 04:49:37
20240227174441	2025-05-23 04:49:40
20240311171622	2025-05-23 04:49:43
20240321100241	2025-05-23 04:49:48
20240401105812	2025-05-23 04:49:53
20240418121054	2025-05-23 04:49:56
20240523004032	2025-05-23 04:50:03
20240618124746	2025-05-23 04:50:05
20240801235015	2025-05-23 04:50:07
20240805133720	2025-05-23 04:50:09
20240827160934	2025-05-23 04:50:11
20240919163303	2025-05-23 04:50:14
20240919163305	2025-05-23 04:50:16
20241019105805	2025-05-23 04:50:18
20241030150047	2025-05-23 04:50:26
20241108114728	2025-05-23 04:50:29
20241121104152	2025-05-23 04:50:31
20241130184212	2025-05-23 04:50:33
20241220035512	2025-05-23 04:50:35
20241220123912	2025-05-23 04:50:37
20241224161212	2025-05-23 04:50:39
20250107150512	2025-05-23 04:50:41
20250110162412	2025-05-23 04:50:43
20250123174212	2025-05-23 04:50:45
20250128220012	2025-05-23 04:50:47
20250506224012	2025-05-23 04:50:49
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-05-23 04:48:11.261957
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-05-23 04:48:11.274754
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-05-23 04:48:11.279885
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-05-23 04:48:11.312216
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-05-23 04:48:11.336772
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-05-23 04:48:11.342348
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-05-23 04:48:11.34895
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-05-23 04:48:11.354559
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-05-23 04:48:11.359353
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-05-23 04:48:11.366484
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-05-23 04:48:11.371847
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-05-23 04:48:11.377914
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-05-23 04:48:11.392417
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-05-23 04:48:11.403959
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-05-23 04:48:11.409118
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-05-23 04:48:11.439933
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-05-23 04:48:11.445616
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-05-23 04:48:11.451326
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-05-23 04:48:11.460496
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-05-23 04:48:11.475498
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-05-23 04:48:11.481511
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-05-23 04:48:11.494479
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-05-23 04:48:11.525632
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-05-23 04:48:11.55542
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-05-23 04:48:11.560996
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-05-23 04:48:11.566425
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 2, true);


--
-- Name: Agent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Agent_id_seq"', 15, true);


--
-- Name: Call_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Call_id_seq"', 1064, true);


--
-- Name: Company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Company_id_seq"', 13, true);


--
-- Name: HumanEvaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."HumanEvaluation_id_seq"', 577, true);


--
-- Name: LlmEvaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."LlmEvaluation_id_seq"', 621, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 167, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: Agent Agent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agent"
    ADD CONSTRAINT "Agent_pkey" PRIMARY KEY (id);


--
-- Name: Call Call_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call"
    ADD CONSTRAINT "Call_pkey" PRIMARY KEY (id);


--
-- Name: Company Company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_pkey" PRIMARY KEY (id);


--
-- Name: HumanEvaluation HumanEvaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HumanEvaluation"
    ADD CONSTRAINT "HumanEvaluation_pkey" PRIMARY KEY (id);


--
-- Name: LlmEvaluation LlmEvaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LlmEvaluation"
    ADD CONSTRAINT "LlmEvaluation_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: Agent_external_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Agent_external_id_key" ON public."Agent" USING btree (external_id);


--
-- Name: Call_external_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Call_external_id_key" ON public."Call" USING btree (external_id);


--
-- Name: Company_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Company_name_key" ON public."Company" USING btree (name);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: Agent Agent_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agent"
    ADD CONSTRAINT "Agent_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Call Call_agentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call"
    ADD CONSTRAINT "Call_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES public."Agent"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Call Call_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call"
    ADD CONSTRAINT "Call_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: HumanEvaluation HumanEvaluation_callId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HumanEvaluation"
    ADD CONSTRAINT "HumanEvaluation_callId_fkey" FOREIGN KEY ("callId") REFERENCES public."Call"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: HumanEvaluation HumanEvaluation_evaluatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HumanEvaluation"
    ADD CONSTRAINT "HumanEvaluation_evaluatorId_fkey" FOREIGN KEY ("evaluatorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: LlmEvaluation LlmEvaluation_callId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LlmEvaluation"
    ADD CONSTRAINT "LlmEvaluation_callId_fkey" FOREIGN KEY ("callId") REFERENCES public."Call"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE "Agent"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."Agent" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."Agent" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."Agent" TO service_role;


--
-- Name: SEQUENCE "Agent_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."Agent_id_seq" TO anon;
GRANT ALL ON SEQUENCE public."Agent_id_seq" TO authenticated;
GRANT ALL ON SEQUENCE public."Agent_id_seq" TO service_role;


--
-- Name: TABLE "Call"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."Call" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."Call" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."Call" TO service_role;


--
-- Name: SEQUENCE "Call_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."Call_id_seq" TO anon;
GRANT ALL ON SEQUENCE public."Call_id_seq" TO authenticated;
GRANT ALL ON SEQUENCE public."Call_id_seq" TO service_role;


--
-- Name: TABLE "Company"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."Company" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."Company" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."Company" TO service_role;


--
-- Name: SEQUENCE "Company_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."Company_id_seq" TO anon;
GRANT ALL ON SEQUENCE public."Company_id_seq" TO authenticated;
GRANT ALL ON SEQUENCE public."Company_id_seq" TO service_role;


--
-- Name: TABLE "HumanEvaluation"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."HumanEvaluation" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."HumanEvaluation" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."HumanEvaluation" TO service_role;


--
-- Name: SEQUENCE "HumanEvaluation_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."HumanEvaluation_id_seq" TO anon;
GRANT ALL ON SEQUENCE public."HumanEvaluation_id_seq" TO authenticated;
GRANT ALL ON SEQUENCE public."HumanEvaluation_id_seq" TO service_role;


--
-- Name: TABLE "LlmEvaluation"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."LlmEvaluation" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."LlmEvaluation" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."LlmEvaluation" TO service_role;


--
-- Name: SEQUENCE "LlmEvaluation_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."LlmEvaluation_id_seq" TO anon;
GRANT ALL ON SEQUENCE public."LlmEvaluation_id_seq" TO authenticated;
GRANT ALL ON SEQUENCE public."LlmEvaluation_id_seq" TO service_role;


--
-- Name: TABLE "User"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."User" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."User" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."User" TO service_role;


--
-- Name: SEQUENCE "User_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."User_id_seq" TO anon;
GRANT ALL ON SEQUENCE public."User_id_seq" TO authenticated;
GRANT ALL ON SEQUENCE public."User_id_seq" TO service_role;


--
-- Name: TABLE _prisma_migrations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public._prisma_migrations TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public._prisma_migrations TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public._prisma_migrations TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO postgres;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO postgres;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

