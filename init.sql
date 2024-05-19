-- Проверка, существует ли пользователь replicator, и создание его, если он не существует
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'replicator') THEN
    CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'NewPassword123';
  END IF;
END $$;

-- Создание слота репликации
SELECT pg_create_physical_replication_slot('replication_slot');

-- Создание базы данных new_database, если она еще не существует
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'new_database') THEN
    CREATE DATABASE new_database;
  END IF;
END $$;

-- Создание таблицы emails, если она еще не существует
CREATE TABLE IF NOT EXISTS emails(
    ID SERIAL PRIMARY KEY,
    email VARCHAR (100) NOT NULL
);

-- Создание таблицы phonenums, если она еще не существует
CREATE TABLE IF NOT EXISTS phonenums(
    ID SERIAL PRIMARY KEY,
    phonenum VARCHAR (100) NOT NULL
);

-- Вставка данных в таблицу emails
INSERT INTO emails (email) VALUES ('test1@test.org'), ('test2@test.dot');

-- Вставка данных в таблицу phonenums
INSERT INTO phonenums (phonenum) VALUES ('89323243456'), ('8 (999) 123 34 45');

-- Создание нового пользователя editor
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'editor') THEN
    CREATE USER editor WITH ENCRYPTED PASSWORD 'EditorPassword123';
  END IF;
END $$;

-- Предоставление всех привилегий на базу данных new_database пользователю editor
GRANT ALL PRIVILEGES ON DATABASE new_database TO editor;

GRANT USAGE, SELECT ON SEQUENCE emails_id_seq TO editor;

GRANT USAGE, SELECT ON SEQUENCE phonenums_id_seq TO editor;

-- Предоставление всех привилегий на все таблицы в схеме public пользователю editor
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO editor;
