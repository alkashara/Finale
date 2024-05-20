#!/bin/bash

echo "Running init-pg-hba.sh..."

echo "host all all 0.0.0.0/0 scram-sha-256" >> /var/lib/postgresql/data/pg_hba.conf
echo "host replication replicator 0.0.0.0/0 scram-sha-256" >> /var/lib/postgresql/data/pg_hba.conf
echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf
echo "local all all peer" >> /var/lib/postgresql/data/pg_hba.conf

chmod 600 /var/lib/postgresql/data/pg_hba.conf

echo "init-pg-hba.sh completed."
