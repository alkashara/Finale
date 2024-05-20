#!/bin/bash

echo "Running init-postgres.sh..."

# Настройка логирования
echo "logging_collector = on" >> /var/lib/postgresql/data/postgresql.conf
echo "log_destination = 'stderr'" >> /var/lib/postgresql/data/postgresql.conf
echo "log_statement = 'all'" >> /var/lib/postgresql/data/postgresql.conf
echo "log_directory = '/tmp'" >> /var/lib/postgresql/data/postgresql.conf
echo "log_filename = 'pg.log'" >> /var/lib/postgresql/data/postgresql.conf

# Настройка репликации
echo "hot_standby = on" >> /var/lib/postgresql/data/postgresql.conf

# Настройка подключения к основному серверу
echo "primary_conninfo = 'host=db port=5432 user=replicator password=NewPassword123'" >> /var/lib/postgresql/data/postgresql.conf

# Создание файла standby.signal для указания, что это реплика
touch /var/lib/postgresql/data/standby.signal

chmod 666 /var/lib/postgresql/data/postgresql.conf

echo "init-postgres.sh completed."
