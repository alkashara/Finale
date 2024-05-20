#!/bin/bash

echo "Running init-postgres.sh..."

# Настройка логирования
echo "logging_collector = on" >> /var/lib/postgresql/data/postgresql.conf
echo "log_destination = 'stderr'" >> /var/lib/postgresql/data/postgresql.conf
echo "log_statement = 'all'" >> /var/lib/postgresql/data/postgresql.conf
echo "log_directory = '/tmp'" >> /var/lib/postgresql/data/postgresql.conf
echo "log_filename = 'pg.log'" >> /var/lib/postgresql/data/postgresql.conf

# Настройка репликации
echo "wal_level = replica" >> /var/lib/postgresql/data/postgresql.conf
echo "archive_mode = on" >> /var/lib/postgresql/data/postgresql.conf
echo "archive_command = 'cp %p /oracle/pg_data/archive/%f'" >> /var/lib/postgresql/data/postgresql.conf
echo "max_wal_senders = 10" >> /var/lib/postgresql/data/postgresql.conf
echo "max_replication_slots = 10" >> /var/lib/postgresql/data/postgresql.conf
echo "hot_standby = on" >> /var/lib/postgresql/data/postgresql.conf

# Настройка подключения к основному серверу
echo "primary_conninfo = 'host=db port=5432 user=replicator password=NewPassword123'" >> /var/lib/postgresql/data/postgresql.conf

chmod 600 /var/lib/postgresql/data/postgresql.conf

echo "init-postgres.sh completed."
