USE exercisedb;

CREATE TABLE dept_details(
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50)
);

INSERT INTO dept_details VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Operations');

CREATE TABLE emp_details(
emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    salary INT,
    age INT,
    joining_date DATE,
    FOREIGN KEY (dept_id) REFERENCES dept_details(dept_id)
);

INSERT INTO emp_details VALUES
(101, 'Amit', 1, 60000, 30, '2021-06-10'),
(102, 'Sneha', 2, 45000, 28, '2022-01-15'),
(103, 'Rahul', 1, 70000, 35, '2020-03-20'),
(104, 'Anita', 3, 50000, 32, '2019-11-01'),
(105, 'Vikas', 4, 30000, 25, '2023-02-12'),
(106, 'Rohit', 1, 55000, 29, '2021-08-05'),
(107, 'Neha', 2, 40000, 26, '2022-09-30'),
(108, 'Suresh', NULL, 48000, 31, '2020-07-18');


##################(WHERE / ORDER BY / LIMIT)#############################
## Display all employees earning more than 40,000.

SELECT * 
FROM emp_details
WHERE salary > 40000;

## Show employees working in the IT department.

SELECT *
FROM emp_details
WHERE dept_id = (SELECT dept_id FROM dept_details WHERE dept_name = "IT");

## List employee names and salaries sorted by salary descending.

SELECT name, salary
FROM emp_details
ORDER BY salary DESC;

## Display the top 3 highest-paid employees.

SELECT *
FROM emp_details
ORDER BY salary DESC
LIMIT 3;

#############(DISTINCT / BETWEEN / IN / LIKE)#####################

## Display distinct department IDs from Employees.

SELECT DISTINCT dept_id
FROM emp_details;

## Find employees whose salary is between 35,000 and 60,000.

SELECT * 
FROM emp_details
WHERE salary BETWEEN 35000 AND 60000;

## Find employees working in dept_id 1 or 3.

SELECT * 
FROM emp_details
WHERE dept_id IN (1,3);

## Display employees whose name starts with ‘A’.

SELECT *
FROM emp_details
WHERE name LIKE 'A%';

## Display employees whose name contains ‘h’.

SELECT *
FROM emp_details
WHERE name LIKE '%h%';

######################(AGGREGATE FUNCTIONS)############################

## Find the highest salary in the company.

SELECT MAX(salary) AS max_salary
FROM emp_details;

## Find the average salary of all employees.

SELECT AVG(salary) AS avg_salary
FROM emp_details;

## Find the total salary paid to employees older than 30.

SELECT SUM(salary) AS total_salary
FROM emp_details
WHERE age > 30;

####################(GROUP BY & HAVING)############################

## Find the average salary of each department.

SELECT dept_id, AVG(salary) AS avg_salary
FROM emp_details
GROUP BY dept_id;

## Count the number of employees in each department.

SELECT dept_id, COUNT(*) AS total_emp
FROM emp_details
GROUP BY dept_id;

## Display departments where the average salary is greater than 50,000.
SELECT dept_id, AVG(salary) AS avg_salary
FROM emp_details
GROUP BY dept_id
HAVING avg_salary > 50000;

## Show departments having more than 2 employees.

SELECT dept_id, COUNT(*) AS emp
FROM emp_details
GROUP BY dept_id
HAVING emp > 2;

#######################(SUBQUERIES)#############################

## Find employees earning more than the company average salary.

SELECT *
FROM emp_details
WHERE salary > (SELECT AVG(salary) FROM emp_details);

## Find employees earning more than the average salary of their own department.

SELECT *
FROM emp_details e
WHERE salary > (SELECT AVG(salary) FROM emp_details WHERE dept_id=e.dept_id);

###############################################################

CREATE TABLE students (
    student_id INT,
    name VARCHAR(50),
    age INT,
    email VARCHAR(100)
);

INSERT INTO students VALUES
(1, 'Ravi', 20, 'ravi@gmail.com'),
(2, 'Priya', 22, 'priya@gmail.com'),
(3, 'Kunal', 17, 'kunal@gmail.com'),
(4, 'Neha', 21, 'neha@gmail.com');

################(ALTER – ADD COLUMN)##################

## Add a column phone_number of type VARCHAR(10).

ALTER TABLE students
ADD phone_number VARCHAR(10);

SELECT * FROM students;

## Add a column dob of type DATE.

ALTER TABLE students
ADD dob DATE;

SELECT * FROM students;

###################(ALTER – MODIFY / ALTER COLUMN)################

## Change the datatype of phone_number to VARCHAR(15).

ALTER TABLE students
MODIFY phone_number VARCHAR(15);

SELECT * FROM students;

## Modify the age column to NOT NULL.

ALTER TABLE students
MODIFY age INT NOT NULL;

SELECT * FROM students;

## Increase the size of the name column to VARCHAR(100).

ALTER TABLE students
MODIFY name VARCHAR(100);

SELECT * FROM students;

#################(ALTER – ADD CONSTRAINT)#####################

SHOW CREATE TABLE students;

## Add a PRIMARY KEY on student_id.

ALTER TABLE students
ADD PRIMARY KEY(student_id);

SELECT * FROM students;

DESC students;

## Add a UNIQUE constraint on email.

ALTER TABLE students
ADD CONSTRAINT UQ_email UNIQUE (email);

## Add a CHECK constraint to ensure age ≥ 18.

ALTER TABLE students
ADD CONSTRAINT CHECK(age >= 18);

#########################(ALTER – DROP)####################################

## Drop the dob column.

ALTER TABLE students
DROP dob;

SELECT * FROM students;

## Remove the CHECK constraint on age.

ALTER TABLE student
DROP CONSTRAINT student_chk_1;



 

