-- SQL operators used with Where Clause.
-- # operators in SQL are used to perform some operations between two operands
USE JPMorgan;

CREATE TABLE employee_data(
emp_id INT PRIMARY KEY,
name VARCHAR(50),
email VARCHAR(50),
monthSalary INT NOT NULL,
designation VARCHAR(100)
);

INSERT INTO employee_data (emp_id, name, email, monthSalary, designation) VALUES
(1,"Rishiraj Pathak", "rishirajraj124@gmail.com", 250000, "software engineer"),
(2, "John LeClu", "john.gmail.com", 150000, "data analyst"),
(3, "Lisa Calley", "lisacalley@gmail.com", 230000, "data analyst"),
(4, "Tony Stark", "tonystark@gmail.com", 200000, "software developer"),
(5, "Tom Cruse", "tomcruse@gmail.com", 75000, "Quality Assurance"),
(6, "Mitchell Powell", "mitchellpowell#gmail.com", "175000", "software sngineer");

SELECT * FROM employee_data;
SELECT * FROM employee_data WHERE monthSalary > 150000;
SELECT * FROM employee_data WHERE monthSalary != 75000;
SELECT * FROM employee_data WHERE monthSalary BETWEEN 100000 AND 200000;
SELECT * FROM employee_data WHERE designation IN ("data analyst", "software engineer");
SELECT * FROM employee_data WHERE designation NOT IN ("Quality Assurance");
SELECT * FROM employee_data 
WHERE designation LIKE 's%';


