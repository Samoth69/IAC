ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO movtrack6_ro;
grant usage on schema public to movtrack6_ro;
grant connect on database movtrack6 to movtrack6_ro;
grant select on all tables in schema public to movtrack6_ro;