#!/bin/bash

# Запускаем SSH сервер
sudo service ssh start

# Ожидаем запуска основного сервера PostgreSQL
until pg_isready -h db; do
  echo "Waiting for main database to start..."
  sleep 2
done

# Выполняем резервное копирование основного сервера
pg_basebackup -h db -D /var/lib/postgresql/data -U replicator -v -P --wal-method=stream --slot=replication_slot

# Устанавливаем владельца и права данных PostgreSQL
sudo chown -R postgres:postgres /var/lib/postgresql/data
sudo chmod 700 /var/lib/postgresql/data

# Устанавливаем права на логи для пользователя postgres
sudo chown -R postgres:postgres /var/lib/postgresql/data/pg_log
sudo chmod 700 /var/lib/postgresql/data/pg_log
sudo chown -R postgres:postgres /tmp
sudo chmod 777 /tmp

# Проверяем, существует ли кластер данных, и создаем его, если не существует
if [ ! -d "/var/lib/postgresql/data/base" ]; then
  echo "Initializing database cluster..."
  initdb -D /var/lib/postgresql/data
fi

# Применяем изменения конфигурации и перезапускаем PostgreSQL
psql -U postgres -c "SELECT pg_reload_conf()"

# Запускаем PostgreSQL
exec postgres -c config_file=/var/lib/postgresql/data/postgresql.conf
