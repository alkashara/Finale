-- init.sql

CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'NewPassword123';

SELECT pg_create_physical_replication_slot('replication_slot');

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'new_database') THEN
        CREATE DATABASE new_database;
    END IF;
END$$;

CREATE TABLE IF NOT EXISTS emails(
    ID SERIAL PRIMARY KEY,
    email VARCHAR (100) NOT NULL
);

CREATE TABLE IF NOT EXISTS phonenums(
    ID SERIAL PRIMARY KEY,
    phonenum VARCHAR (100) NOT NULL
);
