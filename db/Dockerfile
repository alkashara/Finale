# Dockerfile

FROM postgres:16

# Копирование init.sql в контейнер
COPY init.sql /docker-entrypoint-initdb.d/

# Создание пользователя для репликации
ENV DB_REPL_USER repl_user
ENV DB_REPL_PASSWORD repl_user

# Создание слота репликации
RUN echo "CREATE USER ${DB_REPL_USER} WITH REPLICATION ENCRYPTED PASSWORD '${DB_REPL_PASSWORD}';" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "SELECT pg_create_physical_replication_slot('replication_slot');" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "CREATE TABLE hba (lines text);" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "COPY hba FROM '/var/lib/postgresql/data/pg_hba.conf';" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "INSERT INTO hba (lines) VALUES ('host replication all 0.0.0.0/0 md5');" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "COPY hba TO '/var/lib/postgresql/data/pg_hba.conf';" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "SELECT pg_reload_conf();" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "CREATE TABLE Emails(ID SERIAL PRIMARY KEY, mail_addr VARCHAR(100) NOT NULL);" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "CREATE TABLE Phones(ID SERIAL PRIMARY KEY, phone_num VARCHAR(20) NOT NULL);" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "INSERT INTO Emails (mail_addr) VALUES ('test1@test.org'), ('test2@test.dot');" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "INSERT INTO Phones (phone_num) VALUES ('89323243456'), ('8 (999) 123 34 45');" >> /docker-entrypoint-initdb.d/init.sql

# Экспозинг порта
ARG DB_PORT
EXPOSE $DB_PORT

# Создание директории для архивации WAL-логов и установка прав доступа
RUN mkdir -p /oracle/pg_data/archive && \
    chown -R postgres:postgres /oracle/pg_data

# Запуск PostgreSQL
CMD ["postgres"]
