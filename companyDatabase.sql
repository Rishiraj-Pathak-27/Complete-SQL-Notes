# Step1) create database of a company
CREATE DATABASE JPMorgan;

# Step2) create a table name employee and add column name (id,name,salary)
USE JPMorgan;

CREATE TABLE employee ( 
id INT PRIMARY KEY,
name VARCHAR(50),
salary INT NOT NULL
);

# Step3) insert / add data based on column
INSERT INTO employee VALUES(1,"adam",25000);
INSERT INTO employee VALUES(2,"bob",30000);
INSERT INTO employee VALUES(3,"casey",40000);

# Step4) select & view the database
SELECT * FROM employee;


