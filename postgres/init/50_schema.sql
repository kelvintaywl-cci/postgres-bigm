CREATE TABLE pg_tools (tool text, description text);

INSERT INTO pg_tools VALUES ('pg_hint_plan', 'Tool that allows a user to specify an optimizer HINT to PostgreSQL');
INSERT INTO pg_tools VALUES ('pg_dbms_stats', 'Tool that allows a user to stabilize planner statistics in PostgreSQL');
INSERT INTO pg_tools VALUES ('pg_bigm', 'Tool that provides 2-gram full text search capability in PostgreSQL');
INSERT INTO pg_tools VALUES ('pg_trgm', 'Tool that provides 3-gram full text search capability in PostgreSQL');

CREATE INDEX pg_tools_idx ON pg_tools USING gin (description gin_bigm_ops);
CREATE INDEX pg_tools_multi_idx ON pg_tools USING gin (tool gin_bigm_ops, description gin_bigm_ops) WITH (FASTUPDATE = off);
