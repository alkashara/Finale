-- Проверка, существует ли пользователь replicator, и создание его, если он не существует
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '{{ DB_REPL_USER }}') THEN
    CREATE USER {{ DB_REPL_USER }} WITH REPLICATION ENCRYPTED PASSWORD '{{ DB_REPL_PASSWORD }}';
  END IF;
END $$;

-- Создание слота репликации
SELECT pg_create_physical_replication_slot('replication_slot');

-- Создание базы данных {{ DB_DATABASE }}, если она еще не существует
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT FROM pg_database WHERE datname = '{{ DB_DATABASE }}') THEN
    CREATE DATABASE {{ DB_DATABASE }};
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

-- Предоставление прав пользователю replicator на чтение и запись в таблицу emails
GRANT SELECT, INSERT ON emails TO {{ DB_REPL_USER }};

-- Предоставление прав пользователю replicator на чтение и запись в таблицу phonenums
GRANT SELECT, INSERT ON phonenums TO {{ DB_REPL_USER }};
