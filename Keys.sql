# eg of FOREIGN KEYS

CREATE DATABASE IF NOT EXISTS college_data;

USE college_data;

CREATE TABLE IF NOT EXISTS department(
id INT,
dept_name VARCHAR(100) NOT NULL,
PRIMARY KEY(id)
);

INSERT INTO department VALUES
(101,"English"),
(102,"Hindi"),
(103,"Science");

SELECT * FROM department;

# table teacher having FK

CREATE TABLE IF NOT EXISTS teacher(
id INT PRIMARY KEY,
name VARCHAR(50),
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES department(id)
);

INSERT INTO teacher VALUES
(1,"Adam",101),
(2,"Mercy",103),
(3,"Louis",102),
(4,"Bob",101);

SELECT * FROM teacher;


################################################################

## Cascading for FK

CREATE TABLE emp_dept(
emp_id INT PRIMARY KEY,
dept VARCHAR(50),
salary DECIMAL(10,2)
);

INSERT INTO emp_dept
VALUES
(101,"HR",25000),
(102,"IT",50000),
(103,"Finance",75000);

SELECT * FROM emp_dept;

CREATE TABLE emp_name(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(100),
emp_dept_id INT,
FOREIGN KEY (emp_dept_id) REFERENCES emp_dept(emp_id)
ON UPDATE CASCADE
ON DELETE CASCADE
);


INSERT INTO emp_name
VALUES
(101,"Rishiraj",102),
(102,"Adam",101),
(103,"Bob",103),
(104,"Brock",102);

SELECT * FROM emp_name;

SET SQL_SAFE_UPDATES = 0;

UPDATE emp_dept
SET salary = salary + 50000
WHERE dept = "IT";

DELETE FROM emp_dept
WHERE emp_id = 101;

UPDATE emp_dept
SET emp_id = 111
WHERE emp_dept_id = 102;

SET SQL_SAFE_UPDATES = 1;

