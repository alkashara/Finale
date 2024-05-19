#!/bin/bash

echo "host all replicator all md5" >> /var/lib/postgresql/data/pg_hba.conf
echo "host replication all all md5" >> /var/lib/postgresql/data/pg_hba.conf

chmod 666 /var/lib/postgresql/data/pg_hba.conf
