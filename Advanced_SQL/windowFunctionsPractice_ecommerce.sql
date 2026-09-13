CREATE DATABASE IF NOT EXISTS e_commerce;
USE e_commerce;

# SCHEMA - 1 (customers)

CREATE TABLE customers
(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50)
);

INSERT INTO customers VALUES
(1,"Rahul","Mumbai"),
(2,"Priya","Pune"),
(3,"Amit","Nagpur"),
(4,"Sneha","Mumbai"),
(5,"Karan","Pune"),
(6,"Neha","Nagpur");

# SCHEMA - 2 (orders)

CREATE TABLE orders
(
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
order_value DECIMAL(10,2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUE
(101,1,'2026-01-05',5000),
(102,2,'2026-01-08',7000),
(103,1,'2026-01-15',3000),
(104,3,'2026-01-20',9000),
(105,4,'2026-01-25',4000),
(106,2,'2026-02-03',5000),
(107,5,'2026-02-10',8000),
(108,3,'2026-02-15',6000),
(109,1,'2026-02-20',7000),
(110,6,'2026-02-25',5000),
(111,4,'2026-03-02',6000),
(112,5,'2026-03-10',4000);

SELECT * FROM customers;
SELECT * FROM orders;

DESCRIBE customers;
DESCRIBE orders;

#---------------------------------------------------#

-- QUESTIONS & ANSWERS

-- 1) Show every order with the total amount spent by that customer.

SELECT o.*,
	SUM(o.order_value) OVER(
		PARTITION BY o.customer_id
    ) AS total_spending_per_customer
FROM orders o;

-- 2) Show every order with that customer's average order value.

SELECT o.*,
	AVG(o.order_value) OVER(
		PARTITION BY o.customer_id
    ) AS avg_spending
FROM orders o;

-- 3) For each customer, calculate running spending ordered by order_date.

SELECT o.*,
	SUM(o.order_value) OVER(
		PARTITION BY o.customer_id
        ORDER BY o.order_date
    ) AS running_spending
FROM orders o;

-- 4) Rank each customer's orders from highest value to lowest, including ties.

SELECT o.*,
	RANK() OVER(
		PARTITION BY o.customer_id
        ORDER BY o.order_value DESC
    ) AS rnk
FROM orders o;


-- 5) Find each customer's top 2 orders by value, including ties.

SELECT o.order_id, c.customer_name, o.order_date, o.order_value, o.top_2_rnk
FROM (
SELECT o.*,
	DENSE_RANK() OVER(
		PARTITION BY o.customer_id
        ORDER BY o.order_value DESC
    ) AS top_2_rnk
FROM orders o
) o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE o.top_2_rnk <= 2;

-- 6) For every order, calculate order_value / total company revenue × 100.

SELECT o.*, o.order_value / o.company_revenue * 100
FROM (
SELECT o.*,
	SUM(o.order_value) OVER() AS company_revenue
FROM orders o
) o;

-- 7) Show each customer's total spending and percentage contribution to company revenue.

SELECT o.order_id,
	   c.customer_name,
       o.order_date,
       o.order_value,
       o.cust_total_spending,
       o.total_revenue,
       (o.order_value / o.total_revenue) * 100 AS contribution
FROM (
SELECT o.*,
		SUM(o.order_value) OVER(
			PARTITION BY o.customer_id
	    ) AS cust_total_spending
FROM (
SELECT o.*,
	    SUM(o.order_value) OVER() AS total_revenue
FROM orders o
     ) o
) o
JOIN customers c
ON o.customer_id=c.customer_id;
       




