CREATE DATABASE IF NOT EXISTS accounts;  # this will execute as no database, named accounts available
CREATE DATABASE IF NOT EXISTS accounts;  # this will give warning as we have already created the database accounts

USE accounts;

SHOW DATABASES;

DROP DATABASE IF EXISTS accounts;  # this will execute as the database accounts is available
DROP DATABASE IF EXISTS accounts;  # this will give warning as we have already deleted the database accounts	