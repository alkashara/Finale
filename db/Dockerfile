FROM postgres:16

COPY init.sql /docker-entrypoint-initdb.d/

RUN mkdir -p /oracle/pg_data/archive && \
    chown -R postgres:postgres /oracle/pg_data

CMD ["postgres"]

