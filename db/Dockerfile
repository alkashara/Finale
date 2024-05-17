FROM postgres:16

# Копируем скрипты инициализации
COPY init.sql /docker-entrypoint-initdb.d/
COPY init-postgres.sh /docker-entrypoint-initdb.d/
COPY init-pg-hba.sh /docker-entrypoint-initdb.d/

# Задаем статические переменные окружения
ENV DB_REPL_USER=replicator 
ENV DB_REPL_PASSWORD=NewPassword123 
ENV POSTGRES_PASSWORD=NewPassword123 

# Создаем директории для архива данных и применяем необходимые разрешения
RUN mkdir -p /oracle/pg_data/archive && \
    chown -R postgres:postgres /oracle/pg_data

# Команда для запуска PostgreSQL в контейнере
CMD ["postgres", "-c", "config_file=/var/lib/postgresql/data/postgresql.conf"]
