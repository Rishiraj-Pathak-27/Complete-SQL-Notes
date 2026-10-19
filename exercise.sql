# practice questions to solve on previous learned topics

CREATE DATABASE exerciseDB;

USE exerciseDB;

#Q.)  

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 18),
    gender VARCHAR(10),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    join_date DATE
);

INSERT INTO employees (emp_id, emp_name, age, gender, department, salary, join_date)
VALUES
(1,"Rishiraj", 20, "male", "IT", 100000, '2024-07-15'),
(2,"Amit",25,"male","HR",50000,'2023-02-27'),
(3,"Sheela",30,"female","Sales", 45000, '2022-04-02'),
(4,"Pranay",22,"male","IT",90000, '2024-06-17'),
(5,"Mohit",28,"male","Sales",60000,'2024-10-10'),
(6,"Disha",20,"female","IT",95000,'2024-09-23');

SELECT * FROM employees;

## Clauses

# Display all employees who work in the IT department.

SELECT * FROM employees WHERE department = "IT";

# Show employees whose salary is greater than 50,000.

SELECT * FROM employees WHERE salary > 50000;

# List employees who joined after 2022.

SELECT * FROM employees WHERE join_date > '2022-12-31';

# Display all employees sorted by salary in descending order.

SELECT *
FROM employees
ORDER BY salary DESC;

# Count how many employees are in each department.

SELECT department, COUNT(emp_name)
FROM employees
GROUP BY department;

# Show only those departments where more than 5 employees work.

SELECT department, COUNT(emp_name)
FROM employees
GROUP BY department
HAVING COUNT(emp_name) > 5;

# Find departments where the average salary is above 60,000.

SELECT department, AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;


## Aggregate functions

# Find the total salary paid to all employees.

SELECT SUM(salary)
FROM employees;

# Find the highest salary in the company.

SELECT MAX(salary)
FROM employees;

# Find the lowest age among employees.

SELECT MIN(age)
FROM employees;

# Find the average salary of employees.

SELECT AVG(salary)
FROM employees;

# Count how many employees are in the company.

SELECT COUNT(emp_name)
FROM employees;

# Find the average salary of each department. 

SELECT department, AVG(salary)
FROM employees
GROUP BY department;

## Operators

# Find employees whose salary is between 40,000 and 70,000.

SELECT emp_name
FROM employees
WHERE salary BETWEEN 40000 AND 70000;

# Display employees whose department is IT or HR.

SELECT emp_name, department
FROM employees
WHERE department IN ("IT", "HR")
GROUP BY department, emp_name;

# Find employees whose name starts with 'A'.

SELECT emp_name
FROM employees
WHERE emp_name LIKE 'a%';

# Display employees whose age is not equal to 30.

SELECT emp_name
FROM employees
WHERE age != 30;

# Find employees who do not work in Sales.

SELECT emp_name
FROM employees
WHERE department NOT IN ("Sales");

## Constraints

# Write a table where email must be unique.

CREATE TABLE emp (
email VARCHAR(50) UNIQUE,
salary DECIMAL(10,2) NOT NULL,
age INT CHECK (age >= 18),
emp_id INT PRIMARY KEY
);


## KEYS

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

# Insert one record in departments and two in staff.

INSERT INTO departments VALUES(1044,"IT");

INSERT INTO staff (staff_id, staff_name, dept_id) 
VALUES
(1,"Roshan",1044),
(2,"Veer",1044);

#############################################################

## Update Command

CREATE TABLE employees_data (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT CHECK (age >= 18),
    gender VARCHAR(10),
    salary INT,
    department VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

INSERT INTO employees_data VALUES
(101,'Amit',25,'Male',30000,'IT','amit@gmail.com'),
(102,'Neha',28,'Female',45000,'HR','neha@gmail.com'),
(103,'Ravi',35,'Male',60000,'Finance','ravi@gmail.com'),
(104,'Pooja',22,'Female',25000,'IT','pooja@gmail.com'),
(105,'Rahul',40,'Male',80000,'Management','rahul@gmail.com'),
(106,'Sneha',30,'Female',50000,'Finance','sneha@gmail.com');

# Increase salary of all IT employees by 5000.

SET SQL_SAFE_UPDATES = 0;

UPDATE employees_data
SET salary = salary + 5000
WHERE department = "IT";

SELECT * FROM employees_data;

# Change Neha’s department to Finance.

UPDATE employees_data
SET department = "Finance"
WHERE department = "HR";

SELECT * FROM employees_data;

# Increase salary of employees who are older than 30 by 10%.

UPDATE employees_data
SET salary = salary + (salary * 0.10)
WHERE age > 30;

SELECT * FROM employees_data;

# Set salary of Pooja to 28000.

UPDATE employees_data
SET salary = 28000
WHERE name = "Pooja";

SELECT * FROM employees_data;

# Change email of employee with emp_id = 103.

UPDATE employees_data
SET email = "kishanravi@gmail.com"
WHERE emp_id = 103;

SELECT * FROM employees_data;

# Change department of Ravi to Management.

UPDATE employees_data
SET department = "Management"
WHERE name = "Ravi";

SELECT * FROM employees_data;

# Set gender to 'Female' for employee whose name is Sneha.

UPDATE employees_data
SET gender = "Female"
WHERE name = "Sneha";

SELECT * FROM employees_data;

############################################################

## Delete Command

# Delete employee whose emp_id = 104.

DELETE FROM employees_data
WHERE emp_id = 104;

SELECT * FROM employees_data;

# Delete all employees who earn less than 30000.

DELETE FROM employees_data
WHERE salary < 30000;

SELECT * FROM employees_data;

# Delete all Finance employees who earn less than 55000.

DELETE FROM employees_data
WHERE department = "Finance" AND salary < 55000;

SELECT * FROM employees_data;	

##############################################################

## Questions Related to ALTER Command

USE myBusiness;

SELECT * FROM employeesTrack;

## change the name of column from "e_name" to emp_full_name"

ALTER TABLE employeesTrack
CHANGE e_name emp_full_name VARCHAR(100);

## fire all the employees who has salary less than 50000

DELETE FROM employeesTrack
WHERE e_salary <= 50000;

## Delete the columns of the gender

ALTER TABLE employeesTrack
DROP e_gender;

#################################################################

# Create a table Orders with the following:
# order_id (auto-increment, primary key)
# order_date
# total_amount (should allow decimal values)
# order_status (text)
# created_at (date & time)

CREATE TABLE orders(
order_id INT AUTO_INCREMENT PRIMARY KEY,
order_date DATE,
total_amount DECIMAL(10,2),
order_status TEXT,
created_at DATETIME
);

#####################################################

## 
CREATE TABLE Users (
  user_id INT PRIMARY KEY,
  email VARCHAR(100) UNIQUE NOT NULL,
  age INT CHECK (age > 18),
  salary DECIMAL(10,2)
);

INSERT INTO Users VALUES(1,"rishirajraj124@gmail.com",19,25000);
INSERT INTO Users VALUES(2,"sample@gmail.com",20,40000);
INSERT INTO Users VALUES(3,"example@gmail.com",22,10000);

SELECT * FROM Users;

## Write a query to increase salary by 10% for employees whose salary is between 20,000 and 40,000

SET SQL_SAFE_UPDATES = 0;
UPDATE Users
SET salary = salary * 1.10
WHERE salary BETWEEN 20000 AND 40000;

## Find employees who earn more than the average salary.

SELECT *
FROM Users
WHERE salary > (SELECT AVG(salary) FROM Users);

###################################################################

USE exercisedb;

CREATE TABLE EmployeesOne (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    age INT
);

INSERT INTO EmployeesOne VALUES
(1, 'Amit',   'HR',     30000, 25),
(2, 'Neha',   'IT',     60000, 28),
(3, 'Rahul',  'IT',     45000, 32),
(4, 'Pooja',  'Sales',  35000, 26),
(5, 'Ankit',  'HR',     28000, 24),
(6, 'Sneha',  'Sales',  50000, 30),
(7, 'Rohit',  'IT',     70000, 35);


## Display all employees

SELECT * FROM EmployeesOne;

## Show only name and salary.

SELECT name, salary FROM EmployeesOne;

## Find employees whose salary is greater than 40,000.

SELECT name, salary
FROM EmployeesOne
WHERE salary > 40000;

## Find employees whose age is less than 30.

SELECT name 
FROM EmployeesOne
WHERE age < 30;

## Find employees working in the IT department.

SELECT * 
FROM EmployeesOne
WHERE department = "IT";

## Find employees whose salary is between 30,000 and 60,000.

SELECT * 
FROM EmployeesOne
WHERE salary BETWEEN 30000 AND 60000;

## Find employees whose name starts with R.

SELECT *
FROM EmployeesOne
WHERE name LIKE "r%";

## Find employees who are not in the HR department.

SELECT * 
FROM EmployeesOne
WHERE department NOT IN ("HR");

## Display employees ordered by salary (highest first).

SELECT * 
FROM EmployeesOne
ORDER BY salary DESC;

## Display the top 3 highest paid employees.
SELECT * 
FROM EmployeesOne
ORDER BY salary DESC
LIMIT 3;

## Find the total number of employees.

SELECT COUNT(*) AS total_emp
FROM EmployeesOne;

## Find the average salary.

SELECT AVG(salary) AS avg_salary
FROM EmployeesOne;

## Find the maximum salary.

SELECT MAX(salary) AS highest_salary
FROM EmployeesOne;

## Find the minimum age.

SELECT MIN(age) AS lowest_age
FROM EmployeesOne;

## Find average salary of each department.

SELECT department, AVG(salary) AS avg_salary
FROM EmployeesOne
GROUP BY department;

## Count employees in each department.

SELECT department, COUNT(*) AS total_employees
FROM EmployeesOne
GROUP BY department;

## Display departments having more than 2 employees.

SELECT department, COUNT(*) AS total_emp
FROM EmployeesOne
GROUP BY department
HAVING total_emp > 2;

## Find employees who earn more than the average salary.

SELECT *
FROM EmployeesOne
WHERE salary > (SELECT AVG(salary) FROM EmployeesOne);

## Find the employee(s) with the highest salary.

SELECT *
FROM EmployeesOne
ORDER BY salary DESC
LIMIT 1;


## Find employees older than the average age.

SELECT * 
FROM EmployeesOne
WHERE age > (SELECT AVG(age) FROM EmployeesOne);


## Increase salary by 10% for employees in the Sales department.

SET SQL_SAFE_UPDATES = 0;

UPDATE EmployeesOne
SET salary = salary * 1.10
WHERE department = "sales";

SELECT * FROM EmployeesOne;

## Update age to 26 where name = 'Ankit'.

UPDATE EmployeesOne
SET age = 26
WHERE name = "Ankit";

SELECT * FROM EmployeesOne;

## Delete employees whose salary is less than 30,000.

DELETE FROM EmployeesOne
WHERE salary < 30000;

SELECT * FROM EmployeesOne;

## Delete employees from HR department who are younger than 25.

DELETE FROM EmployeesOne
WHERE department = "HR" AND age < 25;

SELECT * FROM EmployeesOne;

#############################################################

USE exercisedb;

CREATE TABLE departmentsOne (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(30) UNIQUE
);

INSERT INTO departmentsOne VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Sales');

CREATE TABLE employeesTwo (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT CHECK (salary > 0),
    age INT CHECK (age >= 18),
    dept_id INT,
    CONSTRAINT fk_dept
    FOREIGN KEY (dept_id) REFERENCES departmentsOne(dept_id)
);


INSERT INTO employeesTwo VALUES
(1, 'Amit',  30000, 25, 1),
(2, 'Neha',  60000, 28, 2),
(3, 'Rahul', 45000, 32, 2),
(4, 'Pooja', 35000, 26, 3),
(5, 'Ankit', 28000, 24, 1),
(6, 'Sneha', 50000, 30, 3),
(7, 'Rohit', 70000, 35, 2);

## Find employees who earn the second highest salary in the company.

SELECT * 
FROM employeesTwo
ORDER BY salary DESC
LIMIT 1,1;


## Delete employees who earn less than the overall average salary.

SET SQL_SAFE_UPDATES = 0;
DELETE FROM employeesTwo
WHERE salary < (SELECT avg_salary FROM (SELECT AVG(salary) AS avg_salary FROM employeesTwo) AS temp );

SELECT * FROM employeesTwo;

## Update salary by 15% for employees earning below the department average

UPDATE employeesTwo
SET salary = salary * 1.15
WHERE salary < (SELECT avg_salary FROM (SELECT AVG(salary) AS avg_salary FROM employeesTwo) AS temp);


# Alter the Employees table to add:
# ON DELETE CASCADE
# ON UPDATE CASCADE

SHOW CREATE TABLE employeesTwo;   # used to table in the table form with all attributes

ALTER TABLE employeesTwo
DROP FOREIGN KEY fk_dept;

ALTER TABLE employeesTwo
ADD FOREIGN KEY(dept_id)
REFERENCES departmentsOne(dept_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

# Delete the IT department 
DELETE FROM departmentsOne
WHERE dept_name = "IT";

SELECT * FROM departmentsOne;
SELECT * FROM employeesTwo;

## Update dept_id = 3 to dept_id = 30.

UPDATE departmentsOne
SET dept_id = 30
WHERE dept_id = 3;

SELECT * FROM departmentsOne;
SELECT * FROM employeesTwo;

# Remove CASCADE and explain the behavior difference.

SHOW CREATE TABLE employeesTwo;

ALTER TABLE employeesTwo
DROP FOREIGN KEY employeesTwo_ibfk_1;

ALTER TABLE employeesTwo
ADD FOREIGN KEY(dept_id)
REFERENCES departmentsOne(dept_id);

## Add a column experience with default value 0.

ALTER TABLE employeesTwo
ADD experience INT DEFAULT 0;

SELECT * FROM employeesTwo;

## Modify salary column to BIGINT.

ALTER TABLE employeesTwo
MODIFY salary BIGINT NOT NULL;

## Add a UNIQUE constraint on (name, dept_id).

ALTER TABLE employeesTwo
MODIFY name VARCHAR(50) UNIQUE;

ALTER TABLE employeesTwo
MODIFY dept_id INT UNIQUE;

## Drop the CHECK constraint on age.

ALTER TABLE employeesTwo
DROP CHECK employeesTwo_chk_2;

## Rename column experience to years_exp.

ALTER TABLE employeesTwo
CHANGE COLUMN experience years_exp INT DEFAULT 0;

SELECT * FROM employeesTwo;

