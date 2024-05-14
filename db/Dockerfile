#Dockerfile

FROM postgres:16

# Копирование init.sql в контейнер
COPY init.sql /docker-entrypoint-initdb.d/

# Создание пользователя для репликации
ENV DB_REPL_USER repl_user
ENV DB_REPL_PASSWORD repl_user

# Добавление правила аутентификации в pg_hba.conf
RUN echo "host replication all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf
RUN echo "host all repl_user 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf

# Установка параметра listen_addresses в postgresql.conf
RUN echo "listen_addresses = '*'" >> /var/lib/postgresql/data/postgresql.conf

# Создание слота репликации и другие операции в init.sql
RUN echo "CREATE USER ${DB_REPL_USER} WITH REPLICATION ENCRYPTED PASSWORD '${DB_REPL_PASSWORD}';" >> /docker-entrypoint-initdb.d/in>
    echo "SELECT pg_create_physical_replication_slot('replication_slot');" >> /docker-entrypoint-initdb.d/init.sql

# Экспозинг порта
ARG DB_PORT
ENV POSTGRES_DB_PORT=${DB_PORT}

# Создание директории для архивации WAL-логов и установка прав доступа
RUN mkdir -p /oracle/pg_data/archive && \
    chown -R postgres:postgres /oracle/pg_data

# Запуск PostgreSQL
CMD ["tail", "-f", "/dev/null"]

