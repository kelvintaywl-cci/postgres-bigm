ARG POSTGRES_VERSION

FROM library/postgres:${POSTGRES_VERSION}

# declare again, since build-args declared before FROM are flushed afterwards
ARG POSTGRES_VERSION

LABEL maintainer="kelvintaywl"

# Based on https://pgbigm.osdn.jp/pg_bigm_en-1-2.html#install

RUN apt-get update \
    && apt-get install -y curl make gcc "postgresql-server-dev-${POSTGRES_VERSION}" libicu-dev \
    && cd /tmp \
    && curl -L -O https://osdn.net/dl/pgbigm/pg_bigm-1.2-20200228.tar.gz \
    && tar zxfv pg_bigm-1.2-20200228.tar.gz \
    && cd pg_bigm-1.2-20200228 \
    && make USE_PGXS=1 \
    && make USE_PGXS=1 install \
    && sed -i "s/#shared_preload_libraries.+$/shared_preload_libraries = 'pg_bigm'/" /usr/share/postgresql/postgresql.conf.sample \
    && rm -fr /tmp/pg_bigm-1.2-20200228 \
    && apt-get purge -y curl make gcc "postgresql-server-dev-${POSTGRES_VERSION}" libicu-dev \
    && apt-get clean
