USE JPMorgan;

# where clause
SELECT * FROM employee_data WHERE emp_id = 3;

#######################################################
# limit clause
SELECT *
FROM employee_data
WHERE monthSalary > 100000
LIMIT 4;

########################################################
# order by claude (asc & des)
SELECT * 
FROM employee_data
ORDER BY monthSalary DESC
LIMIT 3;

SELECT * FROM employee_data;

##########################################################
# group by clause
USE collegeTwo;

SELECT city, count(rollno)
FROM student
GROUP BY city;

SELECT city,name, COUNT(name)
FROM student
GROUP BY city,name;

SELECT city,name, ROUND(AVG(marks))
FROM student
GROUP BY city, name;

# Q.) WAQ to find avg marks in each city in ascending order

SELECT city,name, AVG(marks)
FROM student 
GROUP BY city,name
ORDER BY AVG(marks);

# Q.)

CREATE DATABASE paymentDatabase;

USE paymentDatabase;

CREATE TABLE payment(
customer_id INT PRIMARY KEY,
customer VARCHAR(100),
mode VARCHAR(100),
city VARCHAR(50)
);

INSERT INTO payment (customer_id, customer, mode, city) 
VALUES
(101,"Olivia Barrett", "Netbanking", "Portland"),
(102, "Ethan Sinclair", "Credit Card", "Miami"),
(103, "Maya Hernandiz", "Credit Card", "Seattle"),
(104, "Liam Donovan", "Netbanking", "Denver"),
(105,"Sophia Nguyen", "Credit Card", "New Orleans"),
(106, "Caleb Foster", "Debit Card", "Minneapolis"),
(107, "Ava Patel", "Debit Card", "Phoenix"),
(108, "Lucas Carter", "Netbanking", "Boston"),
(109, "Isabella Martinez", "Netbanking", "Nashville"),
(110, "Jackson Brooks", "Credit Card", "Boston");

SELECT * FROM payment;

SELECT mode, COUNT(mode) 
FROM payment
GROUP BY mode;

##################################################
# having clause

USE collegeTwo;

SELECT * FROM student;

SELECT city, COUNT(rollno)
FROM student
GROUP BY city
HAVING MAX(marks) > 85; 

###########################################################

#Eg.

SELECT name,city, count(rollno), marks
FROM student
WHERE grade IN ('A', 'C')
GROUP BY city, name, marks
HAVING MAX(marks) > 85
ORDER BY marks DESC;


