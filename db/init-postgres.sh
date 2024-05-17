#!/bin/bash

# Создаем файл postgresql.conf
echo "logging_collector = on" >> /var/lib/postgresql/data/postgresql.conf
echo "log_destination = 'stderr'" >> /var/lib/postgresql/data/postgresql.conf
echo "log_statement = 'all'" >> /var/lib/postgresql/data/postgresql.conf
echo "log_directory = 'pg_log'" >> /var/lib/postgresql/data/postgresql.conf

# Даем необходимые разрешения
chmod 666 /var/lib/postgresql/data/postgresql.conf
