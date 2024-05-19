FROM postgres:16

# Устанавливаем необходимые пакеты
RUN apt-get update && \
    apt-get install -y postgresql-client openssh-server sudo

# Настраиваем пользователя postgres
RUN echo 'postgres:postgres' | chpasswd

# Настройка sudo без пароля для пользователя postgres
RUN echo 'postgres ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Создаем необходимые директории и устанавливаем права
RUN mkdir -p /oracle/pg_data/archive /var/lib/postgresql/data /var/lib/postgresql/data/pg_log && \
    chown -R postgres:postgres /oracle/pg_data /var/lib/postgresql /var/run/postgresql && \
    chmod 700 /var/lib/postgresql/data && \
    chmod 700 /var/lib/postgresql/data/pg_log

# Настраиваем SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Копируем и делаем исполняемыми скрипты инициализации
COPY init-postgres.sh /docker-entrypoint-initdb.d/
COPY init-pg-hba.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/*.sh

# Настройки окружения
ENV DB_REPL_USER=replicator
ENV DB_REPL_PASSWORD=NewPassword123
ENV POSTGRES_PASSWORD=NewPassword123

# Открываем порт 22
EXPOSE 22

# Копируем стартовый скрипт и делаем его исполняемым
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Меняем пользователя на postgres
USER postgres

# Указываем точку входа
ENTRYPOINT ["/usr/local/bin/start.sh"]
