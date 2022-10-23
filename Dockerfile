ARG POSTGRES_VERSION=14

FROM library/postgres:${POSTGRES_VERSION}

LABEL maintainer="kelvintaywl"

# Based on https://pgbigm.osdn.jp/pg_bigm_en-1-2.html#install

RUN apt-get update \
    && apt-get install -y curl make gcc postgresql-server-dev-14 libicu-dev \
    && cd /tmp \
    && curl -L -O https://osdn.net/dl/pgbigm/pg_bigm-1.2-20200228.tar.gz \
    && tar zxfv pg_bigm-1.2-20200228.tar.gz \
    && cd pg_bigm-1.2-20200228 \
    && make USE_PGXS=1 \
    && make USE_PGXS=1 install \
    && sed -i "s/#shared_preload_libraries.+$/shared_preload_libraries = 'pg_bigm'/" /usr/share/postgresql/postgresql.conf.sample \
    && rm -fr /tmp/pg_bigm-1.2-20200228 \
    && apt-get purge -y curl make gcc postgresql-server-dev-14 libicu-dev \
    && apt-get clean

