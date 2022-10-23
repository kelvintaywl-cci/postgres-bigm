# Exploring pg_bigm Postgres extension on CircleCI

This repo is an example of spinning up a Postgres DB container loaded with pg_bigm installed.


```console
# this will spin up a custom Postgres DB (Postgres v14) with pg_bigm installed.
# additionally, we run some SQL for intialization via mounting (see postgres/init/*.sql files)

$ docker-compose up --detach

# you can simply run `docker ps` instead too.
# we want to confirm the Postgres DB is up and exposed at port 5432 on local machine

$ docker ps --filter label=maintainer=kelvintaywl

# NOTE: ensure you have psql installed.

$ psql -h 127.0.0.1 -p 5432 -d wiki -U Free -c "SELECT * FROM pg_tools WHERE description LIKE '%search%';"
Password for user Free: [redacted; see docker-compose.yml file for password]
  tool   |                             description
---------+---------------------------------------------------------------------
 pg_bigm | Tool that provides 2-gram full text search capability in PostgreSQL
 pg_trgm | Tool that provides 3-gram full text search capability in PostgreSQL
(2 rows)
```
