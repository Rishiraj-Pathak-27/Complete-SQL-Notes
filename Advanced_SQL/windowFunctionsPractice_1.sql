CREATE DATABASE IF NOT EXISTS analyticalFunctions;
USE analyticalFunctions;-- 

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employees
(employee_id, employee_name, department, salary)
VALUES
(1, 'Rahul', 'IT', 50000),
(2, 'Priya', 'IT', 60000),
(3, 'Amit', 'IT', 55000),
(4, 'Sneha', 'HR', 45000),
(5, 'Karan', 'HR', 50000),
(6, 'Neha', 'HR', 55000),
(7, 'Rohan', 'Sales', 40000),
(8, 'Pooja', 'Sales', 45000),
(9, 'Arjun', 'Sales', 50000);

SELECT * FROM employees;

##########################################

## Practice Questions

-- 1) Display every employee along with the total salary of all employees.

SELECT e.employee_name, e.salary, 
	SUM(salary) OVER() AS total_salary
FROM employees e;

-- 2) Display every employee along with the average salary of the entire company.

SELECT e.employee_name, e.salary, 
	AVG(salary) OVER() AS company_avg_salary
FROM employees e;

-- 3) Display every employee along with the highest salary in the company.

SELECT e.employee_name, e.salary,
	MAX(e.salary) OVER() AS company_max_salary
FROM employees e;

-- 4) Display every employee along with the lowest salary in the company.

SELECT e.employee_name, e.salary,
	MIN(e.salary) OVER() AS company_min_salary
FROM employees e;

-- 5) Department Total Salary

SELECT e.employee_name, e.department, e.salary,
	SUM(e.salary) OVER(PARTITION BY e.department) AS department_total_salary
FROM employees e;

-- 6) Department Average Salary

SELECT e.employee_name, e.department, e.salary,
	AVG(e.salary) OVER(PARTITION BY e.department) AS dpartment_average_salary
FROM employees e;

-- 7) Display every employee along with the highest salary in their department.

SELECT e.employee_name, e.department, e.salary,
	MAX(e.salary) OVER(PARTITION BY e.department) AS max_department_salary
FROM employees e;

-- 8) Salary Difference from Department Average

SELECT e.employee_name,
	   e.department,
       e.salary,
       department_average,
       salary - department_average AS difference
FROM (SELECT e.employee_name,
		e.department,
        e.salary, 
		AVG(e.salary) OVER(PARTITION BY e.department) AS department_average
FROM employees e) e;

-- 9) Salary Difference from Company Average

SELECT e.employee_name,
	   e.department,
       e.salary,
       e.company_average_salary,
       e.salary - e.company_average_salary AS difference
FROM (
SELECT e.employee_name,
	   e.department,
       e.salary,
	AVG(e.salary) OVER() AS company_average_salary
FROM employees e) e;

-- 10) Display every employee and the running total of salary, ordered by salary from lowest to highest.

SELECT e.employee_name, e.salary,
	SUM(e.salary) OVER(ORDER BY e.salary, e.employee_name) AS running_salary
FROM employees e;

-- 11) Display employees ordered by salary from highest to lowest and calculate the running salary total.

SELECT e.employee_name, e.salary,
	SUM(e.salary) OVER(ORDER BY e.salary DESC, e.employee_name DESC) AS running_total
FROM employees e;

-- 12) Display each employee's salary and the running average salary, from lowest salary to highest salary.

SELECT e.employee_name, e.department, e.salary,
	AVG(e.salary) OVER(ORDER BY e.salary, e.employee_name, e.department) AS running_average
FROM employees e;

-- 13) For every employee, show the highest salary encountered so far when employees are ordered by salary ascending.

SELECT e.employee_name, e.department, e.salary,
	MAX(e.salary) OVER(ORDER BY e.salary, e.employee_name, e.department) AS running_max
FROM employees e;

-- 14) For each department, calculate the running salary total ordered by salary ascending.

SELECT e.employee_name, e.department, e.salary,
	SUM(e.salary) OVER(PARTITION BY e.department ORDER BY e.salary) AS running_sum
FROM employees e;

-- 15) Calculate the running average salary within each department.

SELECT e.employee_name, e.department, e.salary,
	AVG(e.salary) OVER(PARTITION BY e.department ORDER BY e.salary) AS running_avg
FROM employees e;

-- 16) Find the highest salary encountered so far within each department.

SELECT e.employee_name, e.department, e.salary,
	MAX(e.salary) OVER(PARTITION BY e.department ORDER BY e.salary DESC) AS running_max
FROM employees e;

-- 17) Calculate running salary based on employee_id order.

SELECT e.employee_id, e.employee_name, e.department, e.salary,
	SUM(e.salary) OVER(ORDER BY e.employee_id) AS running_sum
FROM employees e;

-- 18) Calculate the running salary within each department, but process employees according to employee_id.

SELECT e.employee_id, e.employee_name, e.department, e.salary,
	SUM(e.salary) OVER(PARTITION BY e.department ORDER BY e.employee_id) AS running_sum_dept
FROM employees e;

-- 19) Employee's Percentage of Running Total

SELECT e.employee_name, e.salary, (e.salary / running_salary) * 100 AS percentage
FROM (

SELECT e.employee_name, e.salary,
	SUM(e.salary) OVER(ORDER BY e.salary, e.employee_name) AS running_salary
FROM employees e
) e;

-- 20) Find the running total of sales ordered from highest to lowest.

SELECT e.employee_name, e.salary,
	SUM(e.salary) OVER(ORDER BY e.salary DESC, e.employee_name DESC) AS running_total
FROM employees e;

-- 21) Use of Row_Number() function

SELECT e.*,
	ROW_NUMBER() OVER() AS rn
FROM employees e;

SELECT e.*,
	ROW_NUMBER() OVER(PARTITION BY e.department ORDER BY e.employee_id) AS rn
FROM employees e;

-- fetch first 2 employees from each department

SELECT e.*
FROM (
	SELECT e.*,
		ROW_NUMBER() OVER(PARTITION BY e.department ORDER BY e.employee_id) AS rn
        FROM employees e
    ) e
WHERE e.rn < 3; 

-- 22) Use of RANK() window function 

SELECT e.*,
	RANK() OVER(PARTITION BY e.department ORDER BY e.salary) AS rnk
FROM employees e;

-- top 2 ranks in each department

SELECT e.*
FROM (
SELECT e.*,
	RANK() OVER(PARTITION BY e.department ORDER BY e.salary DESC) AS rnk
FROM employees e
) e
WHERE e.rnk < 3;

-- 23) Use of DENSE_RANK() window function

SELECT e.*,
	RANK() OVER(PARTITION BY e.department ORDER BY e.salary) AS rnk,
    DENSE_RANK() OVER(PARTITION BY e.department ORDER BY e.salary) AS dense_rnk,
    ROW_NUMBER() OVER(PARTITION BY e.department ORDER BY e.salary) AS rn
FROM employees e;

-- assign first 2 records position/rank using dense_rank()

SELECT e.*
FROM (
SELECT e.*,
	DENSE_RANK() OVER(PARTITION BY e.department ORDER BY e.salary) AS dense_rnk
FROM employees e
) e
WHERE e.dense_rnk < 3;

-- 24) Use of LAG () window function

-- way 1
 
SELECT e.*,
	LAG(e.salary) OVER(
		PARTITION BY e.department
		ORDER BY e.salary
    ) AS prev
FROM employees e;

-- way 2 

SELECT e.*,
	LAG(e.salary, 2, 0) OVER(
		PARTITION BY e.department
        ORDER BY e.salary
    ) AS prev
FROM employees e;

-- 25) Use of LEAD() window function

-- way 1

SELECT e.*,
	LEAD(e.salary) OVER(
				PARTITION BY e.department
                ORDER BY e.salary) AS next
FROM employees e;

-- way 2

SELECT e.*,
	LEAD(e.salary, 2, 0) OVER(
						PARTITION BY e.department
                        ORDER BY e.salary 
						) AS next
FROM employees e;

# Combine LAG() & LEAD()

SELECT e.*,
	LAG(e.salary) OVER(
				  PARTITION BY e.department
				  ORDER BY e.salary
				) AS prev,
	LEAD(e.salary) OVER(
				   PARTITION BY e.department
                   ORDER BY e.salary
                ) AS next
FROM employees e;

-- EG. Fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee

SELECT e.*,
	LAG(e.salary) OVER(
				  PARTITION BY e.department	
                  ORDER BY e.salary
                  ) AS prev,
	
    CASE 
    
    WHEN e.salary > LAG(e.salary) OVER(
				  PARTITION BY e.department	
                  ORDER BY e.salary
                  ) THEN 'Higher then previous employee salary'
	
	WHEN e.salary < LAG(e.salary) OVER(
				  PARTITION BY e.department	
                  ORDER BY e.salary
                  ) THEN 'Less then previous employee salary'
                  
	WHEN e.salary = LAG(e.salary) OVER(
				  PARTITION BY e.department	
                  ORDER BY e.salary
                  ) THEN 'Equal to previous employee salary'
	END sal_range
    
FROM employees e;

###############################################################################################################

# Department Table

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Sales'),
(4, 'Finance');

# Employees Table

CREATE TABLE emp (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    salary INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO emp
(employee_id, employee_name, department_id, salary)
VALUES
(101, 'Rahul', 1, 50000),
(102, 'Priya', 1, 60000),
(103, 'Amit', 1, 55000),
(104, 'Vikram', 1, 60000),

(105, 'Sneha', 2, 45000),
(106, 'Karan', 2, 50000),
(107, 'Neha', 2, 55000),
(108, 'Riya', 2, 50000),

(109, 'Rohan', 3, 40000),
(110, 'Pooja', 3, 45000),
(111, 'Arjun', 3, 50000),
(112, 'Ankit', 3, 45000),

(113, 'Meera', 4, 55000),
(114, 'Suresh', 4, 65000),
(115, 'Kavya', 4, 60000),
(116, 'Nitin', 4, 65000);

-- QUESTIONS

-- 1) Total salary of the entire company for every employee.

SELECT e.*,
	SUM(e.salary) OVER() AS total_sal
FROM emp e;

-- 2) Average salary of the company for every employee.

SELECT e.*,
	AVG(e.salary) OVER() AS avg_sal
FROM emp e;

-- 3) Total salary of each department.

SELECT e.*,
	SUM(e.salary) OVER(PARTITION BY e.department_id) AS dept_wise_sal
FROM emp e;

-- 4) Average salary of each department.

SELECT e.*,
	AVG(e.salary) OVER(PARTITION BY e.department_id) AS dept_wise_avg
FROM emp e;

-- 5) Running total of company salary, lowest salary first.

SELECT e.*,
	SUM(e.salary) OVER(ORDER BY e.salary, e.employee_id, e.employee_name) AS running_total
FROM emp e;

-- 6) Running total of salary within each department.

SELECT e.*,
	SUM(e.salary) OVER(PARTITION BY e.department_id ORDER BY e.salary, e.employee_id, e.employee_name) AS running_total_dept
FROM emp e;

-- 7) Running average salary within each department.

SELECT e.*,
	AVG(e.salary) OVER(PARTITION BY e.department_id ORDER BY e.salary, e.employee_id, e.employee_name) AS running_avg_dept
FROM emp e;

-- 8) Rank all employees by salary, highest first.

SELECT e.*,
	RANK() OVER(ORDER BY e.salary DESC) AS rnk
FROM emp e;

-- 9) Rank employees within each department.

SELECT e.*,
	RANK() OVER(PARTITION BY e.department_id ORDER BY e.salary DESC) AS rnk
FROM emp e;

-- 10) Dense rank employees within each department.

SELECT e.*,
	DENSE_RANK() OVER(PARTITION BY e.department_id ORDER BY e.salary DESC) AS rnk
FROM emp e;

-- 11) Assign a unique row number within each department.

SELECT e.*,
	ROW_NUMBER() OVER(PARTITION BY e.department_id) AS row_num
FROM emp e;

-- 12) Find the highest-paid employee(s) in each department.

SELECT e.*
FROM (
	SELECT e.*,
		RANK() OVER(PARTITION BY e.department_id ORDER BY e.salary DESC) AS max
	FROM emp e
) e
WHERE e.max < 2;

-- 13) Find the top 2 salary ranks in each department, including ties.

SELECT e.*
FROM (
	SELECT e.*,
		DENSE_RANK() OVER(
			PARTITION BY e.department_id
            ORDER BY e.salary DESC
        ) AS top_2_sal
	FROM emp e
) e
WHERE e.top_2_sal < 3;

-- 14) Create an employee salary report containing:
-- employee_name
-- department
-- salary
-- company_total_salary
-- department_total_salary
-- department_average_salary
-- department_running_salary
-- department_rank

SELECT e.employee_name,
	   d.department_id AS department,
       d.department_name,
       e.salary,
       e.company_total_salary,
       e.department_total_salary,
       e.department_avg_salary,
       e.department_running_salary,
       e.department_rank
FROM (
	SELECT e.*,
	SUM(e.salary) OVER() AS company_total_salary,
    
    SUM(e.salary) OVER(
		PARTITION BY e.department_id
	) AS department_total_salary,
    
    AVG(e.salary) OVER(
		PARTITION BY e.department_id
	) AS department_avg_salary,
    
    SUM(e.salary) OVER(
		PARTITION BY e.department_id 
        ORDER BY e.salary, e.employee_id, e.employee_name
	) AS department_running_salary,
    
    RANK() OVER(
		PARTITION BY e.department_id
        ORDER BY e.salary DESC
	) AS department_rank
    FROM emp e
) e
JOIN departments d
ON e.department_id=d.department_id;


#############################################################################################################################
## Scenario based questions

-- Scenario 1


-- Customers Table

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES 
(1, 'Rahul', 'Mumbai'),
(2, 'Priya', 'Pune'),
(3, 'Amit', 'Nagpur'),
(4, 'Sneha', 'Mumbai'),
(5, 'Karan', 'Pune'),
(6, 'Neha', 'Nagpur');

-- Orders Table

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_value DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES 
(101, 1, '2026-01-05', 5000),
(102, 2, '2026-01-08', 7000),
(103, 1, '2026-01-15', 3000),
(104, 3, '2026-01-20', 9000),
(105, 4, '2026-01-25', 4000),
(106, 2, '2026-02-03', 5000),
(107, 5, '2026-02-10', 8000),
(108, 3, '2026-02-15', 6000),
(109, 1, '2026-02-20', 7000),
(110, 6, '2026-02-25', 5000),
(111, 4, '2026-03-02', 6000),
(112, 5, '2026-03-10', 4000);


-- 1) Find every order along with the total amount spent by that customer.

SELECT c.customer_name, o.order_date, o.order_value , o.customer_total_spending AS customer_total_spending
FROM (
	SELECT *,
		SUM(o.order_value) OVER(PARTITION BY o.customer_id) AS customer_total_spending
        FROM orders o
) o
JOIN customers c
ON o.customer_id=c.customer_id;

-- 2) Show every order and the average order value of that customer.

SELECT c.customer_name, o.order_date, o.order_value, o.customer_avg_spending AS customer_avg_spending
FROM (
		SELECT *,
			AVG(o.order_value) OVER(PARTITION BY o.customer_id) AS customer_avg_spending
		FROM orders o
    ) o
JOIN customers c
ON o.customer_id=c.customer_id;

-- 3) For every customer, calculate their running spending based on order date.

SELECT c.customer_name, o.order_date, o.order_value, o.running_spending AS running_spending
FROM (
	SELECT *,
		SUM(o.order_value) OVER(PARTITION BY o.customer_id ORDER BY o.order_date) AS running_spending
		FROM orders o
) o
JOIN customers c
ON o.customer_id=c.customer_id;

-- 4) Rank each customer's orders from highest-value order to lowest-value order.

SELECT c.customer_name, 
	   o.order_date,
       o.order_value,
       o.order_rank AS order_rank
FROM (
		SELECT *,
			RANK() OVER(
				PARTITION BY o.customer_id
				ORDER BY o.order_value DESC
			) AS order_rank
		FROM orders o
) o
JOIN customers c
ON o.customer_id=c.customer_id; 

-- 5) Find the highest-value order for every customer.

SELECT c.customer_name,
	   o.order_date, 
       o.order_value,
       o.max_order_per_customer
FROM (
		SELECT *,
			MAX(o.order_value) OVER(
				PARTITION BY o.customer_id
                ORDER BY o.order_value DESC
			) AS max_order_per_customer
		FROM orders o
) o
JOIN customers c
ON o.customer_id=c.customer_id;


-- 6) Find the top 2 orders of every customer, including ties.

SELECT c.customer_name, o.order_date, o.order_value, o.top_2_cust
FROM (
	SELECT *,
		DENSE_RANK() OVER(
			PARTITION BY o.customer_id
            ORDER BY o.order_value
		) AS top_2_cust
	FROM orders o
) o
JOIN customers c
ON o.customer_id=c.customer_id
WHERE o.top_2_cust <= 2;

-- 7) For every order, calculate its percentage contribution to total company revenue.

SELECT c.customer_name,
	   o.order_date,
       o.order_value,
       o.total_company_revenue,
       (o.order_value / o.total_company_revenue) * 100 AS contribution_per_order
FROM (
	SELECT *,
		SUM(o.order_value) OVER() AS total_company_revenue
	FROM orders o
) o
JOIN customers c
ON o.customer_id=c.customer_id;

-- -----------------------------------------------------------------------------------------------

-- Scenario 2

CREATE TABLE drivers (
    driver_id INT PRIMARY KEY,
    driver_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO drivers VALUES 
(1, 'Ramesh', 'Mumbai'),
(2, 'Suresh', 'Pune'),
(3, 'Akash', 'Nagpur'),
(4, 'Vikram', 'Mumbai'),
(5, 'Rohit', 'Pune'),
(6, 'Anil', 'Nagpur');

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    driver_id INT,
    delivery_date DATE,
    delivery_time_hours DECIMAL(5,2),
    delivery_value DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

INSERT INTO deliveries VALUES 
(201, 1, '2026-01-05', 4.5, 5000, 'Delivered'),
(202, 2, '2026-01-06', 6.0, 7000, 'Delayed'),
(203, 1, '2026-01-10', 3.5, 4000, 'Delivered'),
(204, 3, '2026-01-12', 5.0, 8000, 'Delivered'),
(205, 4, '2026-01-15', 7.0, 6000, 'Delayed'),
(206, 2, '2026-01-18', 4.0, 5000, 'Delivered'),
(207, 5, '2026-01-20', 5.5, 9000, 'Delivered'),
(208, 3, '2026-01-22', 4.0, 6000, 'Delivered'),
(209, 1, '2026-01-25', 6.0, 7000, 'Delayed'),
(210, 6, '2026-01-28', 3.0, 5000, 'Delivered'),
(211, 4, '2026-02-02', 5.5, 7000, 'Delivered'),
(212, 5, '2026-02-05', 4.5, 6000, 'Delayed');


## Questions

-- 1) Show every delivery along with the total value delivered by that driver.

SELECT d1.driver_name,
	   d1.city, 
       d2.delivery_date, 
       d2.delivery_time_hours,
       d2.delivery_value,
       d2.status, 
       d2.total_values

FROM (
	SELECT *,
		SUM(d2.delivery_value) OVER() AS total_values
	FROM deliveries d2
) d2
JOIN drivers d1
ON d2.driver_id=d1.driver_id;

-- 2) Show each delivery and the driver's average delivery time.

SELECT *,
	AVG(d.delivery_time_hours) OVER(
		PARTITION BY d.driver_id
	) AS avg_delivery_time
FROM deliveries d;

-- 3) Calculate each driver's running delivery value ordered by delivery_date.

DESCRIBE deliveries;
SELECT d1.driver_name,
	   d2.delivery_date,
       d2.delivery_time_hours,
       d2.delivery_value,
       d2.status,
       d2.running_delivery_value
FROM (
	SELECT *,
		SUM(d2.delivery_value) OVER(
			PARTITION BY d2.driver_id
            ORDER BY d2.delivery_value
            ) AS running_delivery_value
	FROM deliveries d2
) d2
JOIN drivers d1
ON d2.driver_id=d1.driver_id;

-- 4) Rank drivers based on their total delivery value, highest first.

SELECT driver_name, 
	   total_delivery_time,
       RANK() OVER(
			ORDER BY total_delivery_time DESC
	   ) AS rnk
FROM (
	SELECT DISTINCT
		   d1.driver_id,
           d1.driver_name,
           SUM(d2.delivery_value) OVER(
				PARTITION BY d2.driver_id
		   ) AS total_delivery_time
	FROM drivers d1
    JOIN deliveries d2
    ON d1.driver_id=d2.driver_id
) t;

-- 5) Rank each driver's deliveries from fastest to slowest.

SELECT d1.driver_name,
	   d2.delivery_id,
	   d2.delivery_time_hours,
       d2.rnk
FROM (
	SELECT *,
		RANK() OVER(
				PARTITION BY d2.driver_id
                ORDER BY d2.delivery_time_hours
		) AS rnk
	FROM deliveries d2
) d2
JOIN drivers d1
ON d2.driver_id=d1.driver_id;

-- 6) Find each driver's top 2 deliveries by delivery_value. Include ties.

SELECT d1.driver_name,
	   d2.delivery_id,
	   d2.delivery_time_hours,
       d2.delivery_value,
       d2.rnk
FROM (
SELECT *,
	RANK() OVER(
			PARTITION BY d2.driver_id
            ORDER BY d2.delivery_value DESC) AS rnk
    FROM deliveries d2
) d2
JOIN drivers d1
ON d2.driver_id=d1.driver_id
WHERE d2.rnk <= 2;

-- 7) Delivery Time Compared to Driver Average

SELECT d1.driver_name,
       d2.delivery_id,
       d2.delivery_time_hours,
       d2.delivery_avg_time,
       d2.delivery_time_hours - d2.delivery_avg_time AS difference
FROM (
	SELECT *,
		AVG(d2.delivery_time_hours) OVER(
			PARTITION BY d2.driver_id) AS delivery_avg_time
	FROM deliveries d2
) d2
JOIN drivers d1
ON d2.driver_id=d1.driver_id;

-- ----------------------------------------------------------------------------------------------------

-- Scenario 3 (Warehouse Inventory)

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    warehouse VARCHAR(50),
    product VARCHAR(50),
    stock INT,
    stock_value DECIMAL(10,2),
    last_updated DATE
);

INSERT INTO inventory VALUES
(301, 'Mumbai', 'Laptop', 20, 1200000, '2026-01-05'),
(302, 'Mumbai', 'Phone', 50, 750000, '2026-01-06'),
(303, 'Mumbai', 'Tablet', 30, 450000, '2026-01-07'),
(304, 'Pune', 'Laptop', 15, 900000, '2026-01-08'),
(305, 'Pune', 'Phone', 60, 900000, '2026-01-09'),
(306, 'Pune', 'Tablet', 25, 375000, '2026-01-10'),
(307, 'Nagpur', 'Laptop', 10, 600000, '2026-01-11'),
(308, 'Nagpur', 'Phone', 40, 600000, '2026-01-12'),
(309, 'Nagpur', 'Tablet', 20, 300000, '2026-01-13'),
(310, 'Mumbai', 'Monitor', 25, 500000, '2026-01-14'),
(311, 'Pune', 'Monitor', 30, 600000, '2026-01-15'),
(312, 'Nagpur', 'Monitor', 15, 300000, '2026-01-16');

SELECT * FROM inventory;

-- 1) Show each product and the total inventory value of its warehouse.

SELECT i.warehouse,
	   i.stock,
       i.product,
       i.stock_value,
		SUM(i.stock_value) OVER(
			PARTITION BY i.warehouse
        ) AS total_inventory_value
FROM inventory i;

-- 2) Show each product and the average stock of that product across all warehouses.

SELECT i.warehouse,
       i.product,
       i.stock,
       i.stock_value,
	   AVG(i.stock) OVER(
			PARTITION BY i.product
	   ) AS avg_stock
FROM inventory i;
	
-- 3) Rank products within each warehouse based on stock_value, highest first.

SELECT i.warehouse,
	   i.product,
       i.stock,
       i.stock_value,
       RANK() OVER(
			PARTITION BY i.warehouse
            ORDER BY i.stock_value DESC
       ) AS rnk
FROM inventory i;

-- 4) Find the top 2 products in each warehouse by stock_value, including ties.

SELECT i.warehouse,
       i.product,
       i.stock,
       i.stock_value,
       i.top_2_products
FROM (
	SELECT *,
	   RANK() OVER(
			PARTITION BY i.warehouse
            ORDER BY i.stock_value
       ) AS top_2_products
FROM inventory i
) i
WHERE i.top_2_products <= 2;

-- 5) Within each warehouse, calculate running inventory value ordered by last_updated.

SELECT i.warehouse,
	   i.product,
       i.stock,
       i.last_updated,
       i.stock_value,
       SUM(i.stock_value) OVER(
			PARTITION BY i.warehouse
            ORDER BY i.last_updated
       ) AS running_inventory_sum
FROM inventory i;

-- 6) For every product, calculate its percentage contribution to the warehouse's total stock value.

# contribution = stock_value / warehouse_inventory_total_revenue × 100

SELECT i.warehouse,
	   i.product,
       i.stock,
       i.stock_value,
       i.last_updated,
       i.stock_value / i.warehouse_total_stock * 100 AS contribution
FROM (
		SELECT *,
       SUM(i.stock) OVER(
			PARTITION BY i.product
	   ) AS warehouse_total_stock
       FROM inventory i
) i;




       
       



