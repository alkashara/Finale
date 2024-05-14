# Dockerfile

FROM postgres:16


COPY init.sql /docker-entrypoint-initdb.d/

ENV DB_REPL_USER repl_user
ENV DB_REPL_PASSWORD repl_user

RUN echo "host replication all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf
RUN echo "host all repl_user 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf

RUN echo "CREATE USER ${DB_REPL_USER} WITH REPLICATION ENCRYPTED PASSWORD '${DB_REPL_PASSWORD}';" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "SELECT pg_create_physical_replication_slot('replication_slot');" >> /docker-entrypoint-initdb.d/init.sql

ARG DB_PORT
ENV POSTGRES_DB_PORT=${DB_PORT}

RUN mkdir -p /oracle/pg_data/archive && \
    chown -R postgres:postgres /oracle/pg_data
    
CMD ["tail", "-f", "/dev/null"]
