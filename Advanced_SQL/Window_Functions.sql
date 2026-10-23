CREATE DATABASE IF NOT EXISTS windowfunctions;
USE windowfunctions;

CREATE TABLE exam_scores (
    student_id INT,
    student_name VARCHAR(50),
    subject VARCHAR(30),
    marks INT
);

INSERT INTO exam_scores VALUES
(101,'Aarav','Maths',88),
(101,'Aarav','Science',92),
(101,'Aarav','English',85),
(101,'Aarav','History',78),

(102,'Diya','Maths',95),
(102,'Diya','Science',89),
(102,'Diya','English',91),
(102,'Diya','History',84),

(103,'Vivaan','Maths',76),
(103,'Vivaan','Science',81),
(103,'Vivaan','English',79),
(103,'Vivaan','History',73),

(104,'Anaya','Maths',90),
(104,'Anaya','Science',94),
(104,'Anaya','English',88),
(104,'Anaya','History',86),

(105,'Krishna','Maths',68),
(105,'Krishna','Science',74),
(105,'Krishna','English',71),
(105,'Krishna','History',69),

(106,'Ishita','Maths',82),
(106,'Ishita','Science',85),
(106,'Ishita','English',87),
(106,'Ishita','History',80),

(107,'Advait','Maths',97),
(107,'Advait','Science',96),
(107,'Advait','English',93),
(107,'Advait','History',90),

(108,'Myra','Maths',78),
(108,'Myra','Science',83),
(108,'Myra','English',80),
(108,'Myra','History',76),

(109,'Arjun','Maths',85),
(109,'Arjun','Science',88),
(109,'Arjun','English',84),
(109,'Arjun','History',82),

(110,'Sara','Maths',91),
(110,'Sara','Science',87),
(110,'Sara','English',89),
(110,'Sara','History',85);

SELECT * FROM escore;
DESCRIBE escore;

ALTER TABLE exam_scores
RENAME TO escore;


# If we want the sum of each subject total then normally we will use the group by but it will return only few attributes and records

SELECT s.subject AS subject , SUM(s.marks) AS total_marks
FROM escore s
GROUP BY s.subject;

# But if we dont want to modify the table/schema so we will directly use the window function

-- SYNTAX :-  SELECT *,
-- 			  col_name(on which you want to perform aggregation) OVER(PARTITION BY col_name(this is the window on which you have to partition and run the aggregation)) AS window_alias 
-- 			  FROM table AS table_alias;

## AGGREGATE WINDOW FUNCTIONS
    
## 1. SUM()

SELECT *,
	   SUM(s.marks) OVER(PARTITION BY s.subject) AS subject_total
       FROM escore  s;
       
       
## 2. AVG()

	SELECT student_name,
		   AVG(marks) OVER(
				PARTITION BY(subject)
           ) AS avg_marks
	FROM escore;
    
## 3. COUNT()

	SELECT student_name,
		   COUNT(*) OVER(
				PARTITION BY(subject)
			) AS total_student_per_subject
	FROM escore;
       
       
## 4. MIN()

	SELECT student_name, 
		   MIN(marks) OVER(
				PARTITION BY (subject)
            ) AS min_marks
	FROM escore;

## 5. MAX()

	SELECT student_name,
		MAX(marks) OVER (
				PARTITION BY(subject)
        ) AS max_marks
	FROM escore;
    

## 6. Rolling Total

## bank data

-- Eg. Initial Balance - 0

-- 22nd June   		100rs			100rs
-- 28th June   		500rs			600rs
-- 31st June   		500rs			1100rs
-- 05th July   		1000rs			2100rs

# Here based on initial+previous data we are calculating the total current (i.e the rolling total) 

CREATE TABLE bank_transactions (
    transaction_id INT PRIMARY KEY,
    account_holder VARCHAR(50),
    transaction_date DATE,
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2)
);

INSERT INTO bank_transactions
(transaction_id, account_holder, transaction_date, transaction_type, amount)
VALUES
(1, 'Shubham', '2026-01-01', 'DEPOSIT', 1000.00),
(2, 'Shubham', '2026-01-03', 'WITHDRAW', -200.00),
(3, 'Shubham', '2026-01-05', 'DEPOSIT', 500.00),
(4, 'Shubham', '2026-01-07', 'WITHDRAW', -100.00),
(5, 'Rahul', '2026-01-01', 'DEPOSIT', 2000.00),
(6, 'Rahul', '2026-01-04', 'WITHDRAW', -300.00),
(7, 'Rahul', '2026-01-06', 'DEPOSIT', 400.00);

DESCRIBE bank;
SELECT * FROM bank;

## rolling total using SUM()

SELECT *,
	   SUM(amount) OVER(PARTITION BY account_holder ORDER BY transaction_date) AS current_bal
	   FROM bank;

## 7. ROW_NUMBER()

SELECT ROW_NUMBER() OVER(PARTITION BY student_name) AS row_no,
    student_id, student_name, subject, marks
	FROM escore;
    
############################################

## PRACTICE QUESTIONS

-- Q1. Show each transaction along with the total amount transacted by that account holder.

SELECT transaction_id, account_holder, amount,
	   SUM(amount) OVER(PARTITION BY account_holder) AS total_amount
       FROM bank;
       
-- Q2. Show each transaction along with the average transaction amount for that account holder.

SELECT transaction_id, account_holder, amount,
	AVG(amount) OVER(PARTITION BY account_holder) AS avg_total
    FROM bank;
    
-- Q3. Show each transaction along with the highest transaction amount made by that account holder.

SELECT transaction_id, account_holder, amount,
	MAX(amount) OVER(PARTITION BY account_holder) AS max_total
    FROM bank;

-- Q4. Show each transaction along with the lowest transaction amount made by that account holder.

SELECT transaction_id, account_holder, amount,
	MIN(amount) OVER(PARTITION BY account_holder) AS min_total
    FROM bank;
    
-- Q5. Show the total number of transactions performed by each account holder beside every row.

SELECT transaction_id, account_holder, amount,
	COUNT(*) OVER(PARTITION BY account_holder) AS total_count
    FROM bank;
    
-- Q6. Calculate the running balance for each account holder ordered by transaction date.

SELECT transaction_id, account_holder, amount,
	SUM(amount) OVER(PARTITION BY account_holder ORDER BY transaction_date) AS total_count
    FROM bank;
    
##########################################################################################################################################
    
# Practice Questions

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE
);

INSERT INTO customers (customer_id, customer_name, city, signup_date) VALUES
(1, 'Rohan Sharma', 'Mumbai', '2025-01-15'),
(2, 'Priya Mehta', 'Mumbai', '2025-02-10'),
(3, 'Amit Verma', 'Mumbai', '2025-03-05'),
(4, 'Sneha Patil', 'Pune', '2025-01-20'),
(5, 'Karan Joshi', 'Pune', '2025-02-14'),
(6, 'Neha Kulkarni', 'Pune', '2025-04-01'),
(7, 'Rahul Shah', 'Delhi', '2025-01-08'),
(8, 'Ananya Rao', 'Delhi', '2025-03-18'),
(9, 'Vikram Singh', 'Delhi', '2025-05-12'),
(10, 'Arjun Nair', 'Bangalore', '2025-02-25'),
(11, 'Meera Iyer', 'Bangalore', '2025-03-11'),
(12, 'Aditya Kapoor', 'Bangalore', '2025-04-16'),
(13, 'Ishita Jain', 'Hyderabad', '2025-01-30'),
(14, 'Siddharth Das', 'Hyderabad', '2025-03-22'),
(15, 'Pooja Reddy', 'Hyderabad', '2025-05-01');

CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY,
    warehouse_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO warehouses (warehouse_id, warehouse_name, city) VALUES
(101, 'Mumbai Central Warehouse', 'Mumbai'),
(102, 'Mumbai East Warehouse', 'Mumbai'),
(103, 'Pune Main Warehouse', 'Pune'),
(104, 'Pune East Warehouse', 'Pune'),
(105, 'Delhi North Warehouse', 'Delhi'),
(106, 'Delhi South Warehouse', 'Delhi'),
(107, 'Bangalore Central Warehouse', 'Bangalore'),
(108, 'Bangalore South Warehouse', 'Bangalore'),
(109, 'Hyderabad Main Warehouse', 'Hyderabad'),
(110, 'Hyderabad East Warehouse', 'Hyderabad');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    warehouse_id INT,
    order_date DATE,
    order_value DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

INSERT INTO orders
(order_id, customer_id, warehouse_id, order_date, order_value) VALUES

-- Mumbai
(1001, 1, 101, '2025-01-05', 5000),
(1002, 1, 101, '2025-02-10', 7000),
(1003, 1, 102, '2025-03-15', 6000),

(1004, 2, 101, '2025-01-12', 8000),
(1005, 2, 102, '2025-02-18', 5000),
(1006, 2, 102, '2025-04-05', 7000),

(1007, 3, 102, '2025-01-20', 4000),
(1008, 3, 101, '2025-03-22', 6000),
(1009, 3, 102, '2025-05-10', 5000),

-- Pune
(1010, 4, 103, '2025-01-08', 9000),
(1011, 4, 103, '2025-02-15', 4000),
(1012, 4, 104, '2025-04-12', 6000),

(1013, 5, 103, '2025-01-25', 7000),
(1014, 5, 104, '2025-03-18', 8000),
(1015, 5, 103, '2025-05-02', 5000),

(1016, 6, 104, '2025-02-05', 3000),
(1017, 6, 103, '2025-03-25', 5000),
(1018, 6, 104, '2025-05-15', 4000),

-- Delhi
(1019, 7, 105, '2025-01-10', 10000),
(1020, 7, 106, '2025-02-20', 7000),
(1021, 7, 105, '2025-04-10', 8000),

(1022, 8, 105, '2025-01-18', 6000),
(1023, 8, 106, '2025-03-12', 9000),
(1024, 8, 105, '2025-05-05', 7000),

(1025, 9, 106, '2025-02-08', 5000),
(1026, 9, 105, '2025-03-28', 6000),
(1027, 9, 106, '2025-05-20', 9000),

-- Bangalore
(1028, 10, 107, '2025-01-14', 11000),
(1029, 10, 108, '2025-03-05', 6000),
(1030, 10, 107, '2025-04-18', 8000),

(1031, 11, 107, '2025-02-10', 7000),
(1032, 11, 108, '2025-03-20', 9000),
(1033, 11, 108, '2025-05-12', 6000),

(1034, 12, 108, '2025-01-22', 5000),
(1035, 12, 107, '2025-04-05', 7000),
(1036, 12, 108, '2025-05-25', 6000),

-- Hyderabad
(1037, 13, 109, '2025-01-16', 8000),
(1038, 13, 109, '2025-02-28', 7000),
(1039, 13, 110, '2025-04-15', 6000),

(1040, 14, 109, '2025-01-30', 6000),
(1041, 14, 110, '2025-03-10', 8000),
(1042, 14, 109, '2025-05-18', 7000),

(1043, 15, 110, '2025-02-12', 5000),
(1044, 15, 109, '2025-03-30', 7000),
(1045, 15, 110, '2025-05-22', 6000);

CREATE TABLE drivers (
    driver_id INT PRIMARY KEY,
    driver_name VARCHAR(50),
    experience_years INT
);

INSERT INTO drivers (driver_id, driver_name, experience_years) VALUES
(201, 'Raj Malhotra', 5),
(202, 'Suresh Yadav', 3),
(203, 'Manoj Kumar', 7),
(204, 'Vivek Rao', 2),
(205, 'Deepak Singh', 6),
(206, 'Nitin Patil', 4),
(207, 'Akash Verma', 8),
(208, 'Harish Gupta', 3);

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    driver_id INT,
    delivery_time_hours DECIMAL(5,2),
    status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

INSERT INTO deliveries
(delivery_id, order_id, driver_id, delivery_time_hours, status) VALUES

(5001, 1001, 201, 5.0, 'Delivered'),
(5002, 1002, 202, 7.0, 'Delivered'),
(5003, 1003, 201, 6.0, 'Delayed'),

(5004, 1004, 203, 4.0, 'Delivered'),
(5005, 1005, 204, 8.0, 'Delayed'),
(5006, 1006, 203, 5.0, 'Delivered'),

(5007, 1007, 202, 9.0, 'Delayed'),
(5008, 1008, 205, 6.0, 'Delivered'),
(5009, 1009, 202, 7.0, 'Delivered'),

(5010, 1010, 206, 4.0, 'Delivered'),
(5011, 1011, 206, 5.0, 'Delivered'),
(5012, 1012, 207, 6.0, 'Delayed'),

(5013, 1013, 206, 5.0, 'Delivered'),
(5014, 1014, 207, 8.0, 'Delayed'),
(5015, 1015, 206, 4.0, 'Delivered'),

(5016, 1016, 208, 10.0, 'Delayed'),
(5017, 1017, 208, 7.0, 'Delivered'),
(5018, 1018, 207, 6.0, 'Delivered'),

(5019, 1019, 201, 5.0, 'Delivered'),
(5020, 1020, 202, 8.0, 'Delayed'),
(5021, 1021, 201, 6.0, 'Delivered'),

(5022, 1022, 203, 7.0, 'Delivered'),
(5023, 1023, 204, 9.0, 'Delayed'),
(5024, 1024, 203, 6.0, 'Delivered'),

(5025, 1025, 205, 8.0, 'Delayed'),
(5026, 1026, 205, 7.0, 'Delivered'),
(5027, 1027, 204, 10.0, 'Delayed'),

(5028, 1028, 201, 4.0, 'Delivered'),
(5029, 1029, 202, 6.0, 'Delivered'),
(5030, 1030, 201, 5.0, 'Delivered'),

(5031, 1031, 203, 7.0, 'Delayed'),
(5032, 1032, 204, 6.0, 'Delivered'),
(5033, 1033, 203, 8.0, 'Delayed'),

(5034, 1034, 205, 9.0, 'Delayed'),
(5035, 1035, 205, 5.0, 'Delivered'),
(5036, 1036, 206, 6.0, 'Delivered'),

(5037, 1037, 207, 5.0, 'Delivered'),
(5038, 1038, 208, 7.0, 'Delivered'),
(5039, 1039, 207, 8.0, 'Delayed'),

(5040, 1040, 208, 6.0, 'Delivered'),
(5041, 1041, 207, 9.0, 'Delayed'),
(5042, 1042, 208, 7.0, 'Delivered'),

(5043, 1043, 205, 8.0, 'Delayed'),
(5044, 1044, 206, 6.0, 'Delivered'),
(5045, 1045, 205, 7.0, 'Delivered');

SELECT * FROM customers;
SELECT * FROM warehouses;
SELECT * FROM orders;

-- 1) Find each customer's total spending and the overall total revenue of the company in every row.

SELECT customer_id, customer_name, total_spending,
	SUM(total_spending) OVER() AS total_company_revenue
FROM (
SELECT c.customer_id, c.customer_name, SUM(o.order_value) AS total_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name) t;

-- 2) Find each customer's total spending and their percentage contribution to total company revenue.

SELECT customer_id, customer_name, total_spending, (total_spending / company_total_revenue) * 100 AS percentage_of_revenue,
SUM(total_spending) OVER() AS company_total_revenue
FROM (
	SELECT c.customer_id, c.customer_name, SUM(o.order_value) AS total_spending
    FROM customers c
    JOIN orders o
    ON c.customer_id=o.customer_id
    GROUP BY c.customer_id, c.customer_name 
) t;

    
##########################################################################################################################################


CREATE TABLE emp(
eid INT PRIMARY KEY,
ename VARCHAR(20),
dname VARCHAR(50),
salary INT NOT NULL
);

INSERT INTO emp VALUES
(101,"Mohan","Admin", 4000),
(102,"Rajkumar","HR", 3000),
(103,"Akbar","IT", 4000),
(104,"Darwin","Finance", 6500),
(105,"Rohit","HR", 3000),
(106,"Rajesh","Finance", 5000),
(107,"Preet","HR", 7000),
(108,"Maryam","Admin", 4000);

SELECT * FROM emp;

SELECT dname AS dept_name, MAX(salary) AS max_salary_per_dept
FROM emp
GROUP BY dname;

SELECT dname, AVG(salary) AS avg_salary
FROM emp
GROUP BY dname;

-- Simple way using analytical/window function

SELECT *,
	MAX(salary) OVER() AS max_salary_per_dept
FROM emp;

SELECT *,
	MAX(salary) OVER(PARTITION BY dname) AS max_salary_per_dept
FROM emp;

-- both

SELECT *,
		COUNT(*) OVER(PARTITION BY dname) AS total_count,
		MIN(salary) OVER(PARTITION BY dname) AS min,
		MAX(salary) OVER(PARTITION BY dname) AS max,
        SUM(salary) OVER(PARTITION BY dname) AS sum,
        AVG(salary) OVER(PARTITION BY dname) AS avg
FROM emp;

#######################################################################################################

## RANKING BASED WINDOW FUNCTIONS

# 1) ROW_NUMBER()

SELECT e.*,
	ROW_NUMBER() OVER(PARTITION BY dname ORDER BY eid) AS SrNo
FROM emp AS e; 


-- Fetch the first 2 employees from each department to join the company

SELECT * FROM(
SELECT e.*,
	ROW_NUMBER() OVER(PARTITION BY dname ORDER BY eid) AS SrNo
FROM emp AS e) AS x
WHERE x.SrNo < 3;


# 2) RANK()

SELECT e.*,
	RANK() OVER(PARTITION BY e.dname ORDER BY e.salary DESC) AS emp_rank_dept
FROM emp e;
    
DESCRIBE emp;

# 3) DENSE_RANK()

SELECT e.*,
	DENSE_RANK() OVER(PARTITION BY e.dname ORDER BY e.salary) AS dense_rnk
FROM emp e;

-- fetch first 2 ranks from this emp table

SELECT e.*
FROM 
(
	SELECT e.*,
    DENSE_RANK()
	OVER(
		PARTITION BY e.dname
		ORDER BY e.salary
        ) AS dense_rnk
	FROM emp e
) e;

# 4) LAG()

-- 1st way to declare the lag() window function

SELECT e.*,
	LAG(e.salary) OVER() AS prev
FROM emp e;

-- dept wise

SELECT e.*,
	LAG(e.salary) OVER(PARTITION BY e.dname) AS prev
FROM emp e;

-- 2nd way to declare the lag() window function

-- LAG(col_name, how much prev, value to be enter if null)

SELECT e.*,
	LAG(e.salary, 1, 0) OVER(PARTITION BY e.dname ORDER BY e.salary) AS prev
FROM emp e;

# 5) LEAD()

-- 1st way to define LEAD() window function

SELECT e.*,
	LEAD(e.salary) OVER(PARTITION BY e.dname ORDER BY e.salary) AS next
FROM emp e;
    
-- 2nd way to define LEAD() window function

-- LEAD(col_name, how much next, default or any value like null)

SELECT e.*,
	LEAD(e.salary, 1, 0) OVER(PARTITION BY e.dname ORDER BY e.salary) AS next
FROM emp e;

######################################################################################