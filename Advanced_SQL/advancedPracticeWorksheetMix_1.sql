CREATE DATABASE IF NOT EXISTS eCommDB;
USE eCommDB;

-- SCHEMAS

# 1) customers

CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),
city VARCHAR(50),
state VARCHAR(50),
signup_date DATE
);

-- data

INSERT INTO customers VALUES
(101, 'Aarav Mehta', 'Nagpur', 'Maharashtra', '2025-01-12'),
(102, 'Diya Sharma', 'Pune', 'Maharashtra', '2025-02-04'),
(103, 'Kabir Patil', 'Mumbai', 'Maharashtra', '2025-02-20'),
(104, 'Anaya Joshi', 'Nashik', 'Maharashtra', '2025-03-03'),
(105, 'Rohan Deshmukh', 'Nagpur', 'Maharashtra', '2025-03-18'),
(106, 'Ishita Kulkarni', 'Aurangabad', 'Maharashtra', '2025-04-02'),
(107, 'Vivaan Rao', 'Bengaluru', 'Karnataka', '2025-04-15'),
(108, 'Meera Shah', 'Ahmedabad', 'Gujarat', '2025-05-01'),
(109, 'Arjun Nair', 'Kochi', 'Kerala', '2025-05-19'),
(110, 'Sara Khan', 'Hyderabad', 'Telangana', '2025-06-07'),
(111, 'Neha Verma', 'Delhi', 'Delhi', '2025-06-15'),
(112, 'Aditya Singh', 'Jaipur', 'Rajasthan', '2025-06-20');

# 2) products

CREATE TABLE products (
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50),
unit_price DECIMAL(10,2),
stock_qty INT
);

-- data

INSERT INTO products VALUES
(201, 'Laptop Pro 14', 'Electronics', 65000, 12),
(202, 'Wireless Mouse', 'Electronics', 1200, 60),
(203, 'Mechanical Keyboard', 'Electronics', 3500, 35),
(204, 'Office Chair', 'Furniture', 8500, 18),
(205, 'Standing Desk', 'Furniture', 14000, 10),
(206, 'USB-C Hub', 'Electronics', 2200, 40),
(207, 'Noise Cancelling Headphones', 'Electronics', 9000, 22),
(208, 'Webcam HD', 'Electronics', 3000, 27),
(209, 'Notebook Pack', 'Stationery', 500, 100),
(210, 'Desk Lamp', 'Furniture', 1800, 45),
(211, 'Monitor 24 Inch', 'Electronics', 15000, 16),
(212, 'Ergonomic Footrest', 'Furniture', 2500, 30),
(213, 'Bluetooth Speaker', 'Electronics', 4500, 25),
(214, 'Tablet Stand', 'Accessories', 1800, 40),
(215, 'Drawing Tablet', 'Electronics', 12000, 8);

# 3) orders

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
order_status VARCHAR(30),
payment_method VARCHAR(30),
total_amount DECIMAL(12,2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- data

INSERT INTO orders VALUES
(1001, 101, '2025-06-10', 'Delivered',  'UPI', 65000),
(1002, 102, '2025-06-11', 'Delivered',  'Card', 4700),
(1003, 103, '2025-06-12', 'Shipped',    'Card', 17500),
(1004, 101, '2025-06-15', 'Delivered',  'Card', 12400),
(1005, 104, '2025-06-18', 'Cancelled',  'UPI', 8500),
(1006, 105, '2025-06-20', 'Delivered',  'Cash', 14000),
(1007, 106, '2025-06-22', 'Delivered',  'UPI', 2700),
(1008, 107, '2025-06-25', 'Shipped',    'Card', 9000),
(1009, 108, '2025-06-28', 'Delivered',  'UPI', 18100),
(1010, 109, '2025-07-01', 'Processing', 'Card', 3500),
(1011, 110, '2025-07-03', 'Delivered',  'Card', 10200),
(1012, 103, '2025-07-04', 'Delivered',  'UPI', 16200),
(1013, 105, '2025-07-05', 'Cancelled',  'Card', 1200),
(1014, 107, '2025-07-07', 'Delivered',  'UPI', 17000),
(1015, 102, '2025-07-08', 'Delivered',  'Card', 3000),
(1016, 101, '2025-07-10', 'Processing', 'UPI', 4500),
(1017, 110, '2025-07-12', 'Delivered',  'Card', 8000);

# 4) order_items

CREATE TABLE order_items(
order_id INT,
product_id INT,
quantity INT,
line_total DECIMAL(12,2),
PRIMARY KEY(order_id, product_id),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- data 

INSERT INTO order_items VALUES
(1001, 201, 1, 65000),
(1002, 202, 1, 1200),
(1002, 203, 1, 3500),
(1003, 204, 1, 8500),
(1003, 203, 2, 7000),
(1003, 209, 4, 2000),
(1004, 207, 1, 9000),
(1004, 202, 1, 1200),
(1004, 206, 1, 2200),
(1005, 204, 1, 8500),
(1006, 205, 1, 14000),
(1007, 209, 3, 1500),
(1007, 210, 1, 1200),
(1008, 207, 1, 9000),
(1009, 205, 1, 14000),
(1009, 210, 2, 3600),
(1009, 209, 1, 500),
(1010, 203, 1, 3500),
(1011, 207, 1, 9000),
(1011, 202, 1, 1200),
(1012, 205, 1, 14000),
(1012, 206, 1, 2200),
(1013, 202, 1, 1200),
(1014, 205, 1, 14000),
(1014, 210, 1, 1800),
(1014, 202, 1, 1200),
(1015, 208, 1, 3000),
(1016, 213, 1, 4500),
(1017, 213, 1, 4500),
(1017, 203, 1, 3500);

-- SCHEMAS/TABLE Info

SELECT * FROM customers;
DESCRIBE customers;

SELECT * FROM products;
DESCRIBE products;

SELECT * FROM orders;
DESCRIBE orders;

SELECT * FROM order_items;
DESCRIBE order_items;


-- -------------------------------------------------------

-- JOIN's

# 1) Display each order_id, customer_name, order_date and total_amount.

SELECT o.order_id AS order_id,
       c.customer_name AS customer_name,
       o.order_date AS order_date,
       o.total_amount AS total_amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

# 2) Display every customer and the orders they have placed. Include customers who have never placed an order.

SELECT c.customer_name AS customer_name,
       o.order_id AS order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

# 3) Display order_id, customer_name, product_name and quantity for every order item.

SELECT oi.order_id,
	   c.customer_name,
       p.product_name, 
       oi.quantity
FROM order_items oi
JOIN orders o
ON oi.order_id = o.order_id

JOIN customers c
ON o.customer_id = c.customer_id

JOIN products p
ON oi.product_id = p.product_id;

# 4) Show product_name, category, quantity sold and line_total for all order items.

SELECT p.product_name,
       p.category,
       oi.quantity,
       oi.line_total
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id;

# 5) Find all orders placed by customers from Maharashtra.

SELECT o.order_id,
       c.customer_id,
       c.customer_name,
       c.state
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.state = 'Maharashtra';

# 6) Display customer_name, order_id and order_status for all orders that are not cancelled.

SELECT c.customer_name,
       o.order_id,
       o.order_status
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status <> 'Cancelled';

# 7) Find all products that have appeared in at least one order.

SELECT p.product_id,
	   p.product_name
FROM products p
JOIN order_items o
ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(*) >= 1;

# 8) Find products that have never been ordered.

SELECT p.product_id,
       oi.order_id
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;

# 9) Show each customer with their total number of orders, including customers with zero orders.

SELECT c.customer_id,
	   c.customer_name,
       COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

# 10) Show each product with the total quantity sold. Include products with zero sales.

SELECT p.product_id,
       p.product_name,
       p.category,
       SUM(oi.quantity) AS total_quantity_sold,
       COALESCE(SUM(oi.quantity),0) AS total_quantity_sold_zero
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category;

# 11) Find customers who have purchased a product from the Furniture category.

SELECT DISTINCT c.customer_id,
                p.category
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
WHERE p.category = 'Furniture'
GROUP BY c.customer_id, p.category;

# 12) Find customers who have purchased both Electronics and Furniture products.

SELECT c.customer_id
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
WHERE p.category IN ('Electronics','Furniture')
GROUP BY c.customer_id
HAVING COUNT(DISTINCT p.category) = 2;

# 13) Find the top 5 customers by completed order value using joins and aggregation.

SELECT c.customer_id,
	   c.customer_name,
       SUM(o.total_amount) AS total_order_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_order_value DESC
LIMIT 5;

# 14) For each category, calculate total sales generated from its order items. Exclude cancelled orders.

SELECT p.category,
	   SUM(oi.line_total) AS total_sales
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.category;

# 15) Find the order with the highest number of distinct products.

SELECT DISTINCT oi.order_id,
				COUNT(oi.product_id) AS id_count
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY oi.order_id
ORDER BY id_count DESC
LIMIT 1;

# 16) For each order, show order_id, customer_name, number of distinct products, total quantity and total_amount.

SELECT o.order_id,
       c.customer_name,
	   COUNT(DISTINCT oi.product_id) AS distinct_products,
       SUM(oi.quantity) AS total_quantity,
       o.total_amount AS total_amount
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
LEFT JOIN order_items oi
ON o.order_id = oi.order_id
LEFT JOIN products p
ON oi.product_id = p.product_id
GROUP BY o.order_id,c.customer_name,o.total_amount;

# 17) Find customers who placed more than one order.

SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS customer_order_count
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING customer_order_count > 1;

# 18) Find customers whose every order is cancelled or who have no completed order.

SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS cust_order_count
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(CASE
               WHEN o.order_status = 'Delivered' THEN 1
               ELSE 0
		   END) = 0;
           
# 19) Show each state and the number of distinct customers, number of orders, and completed revenue.

SELECT c.state,
       COUNT(DISTINCT c.customer_id) AS distinct_customers,
       COUNT(o.order_id) AS total_orders,
       COALESCE(SUM(CASE
                        WHEN o.order_status = 'Delivered' THEN o.total_amount
                        ELSE 0
					END),0) AS total_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.state;

# 20) Find the product that generated the highest line-item revenue among completed orders.

SELECT p.product_id,
       SUM(CASE 
		       WHEN o.order_status = 'Delivered' THEN oi.line_total
               ELSE 0
		   END) AS total_line_item
FROM order_items oi
JOIN orders o
ON oi.order_id = o.order_id
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_line_item DESC
LIMIT 1;

-- -------------------------------------------------------------------------------

-- SUBQUERY Bases Questions

-- 1) Find orders whose total_amount is greater than the average order amount across all orders.

SELECT o.*
FROM orders o
WHERE o.total_amount > (
	SELECT AVG(o1.total_amount) 
	FROM orders o1
);

-- 2) Find customers whose total completed spending is greater than the average customer completed spending.

SELECT customer_id,
       customer_name,
       total_spending
       
FROM (
	SELECT c.customer_id,
           c.customer_name,
           SUM(o.total_amount) AS total_spending
	FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Delivered'
    GROUP BY c.customer_id, c.customer_name
) AS customer_totals

WHERE total_spending > (
	SELECT AVG(total_spending) 
    FROM (
		SELECT SUM(o1.total_amount) AS total_spending
        FROM orders o1
        WHERE o1.order_status = 'Delivered'
        GROUP BY o1.customer_id 
    ) AS avg_customer_total
);

-- 3) Find products priced above the average product price.

SELECT p.*
FROM products p
WHERE p.unit_price > (
	SELECT AVG(p1.unit_price) 
    FROM products p1
);

-- 4) Find the most expensive product.

SELECT p.*
FROM products p
WHERE p.unit_price = (
	SELECT MAX(p1.unit_price)
    FROM products p1
);

-- 5) Find all customers who have placed at least one order using a subquery with IN.

SELECT c.customer_id,
       c.customer_name
FROM customers c
WHERE c.customer_id IN (
	SELECT o.customer_id
    FROM orders o
);

-- 6) Find customers who have never placed an order using NOT IN.

SELECT c.*
FROM customers c
WHERE c.customer_id NOT IN (
	SELECT o.customer_id
    FROM orders o
);

-- 7) Find customers who have placed at least one completed order using EXISTS.

SELECT c.*
FROM customers c
WHERE EXISTS (
	SELECT o.customer_id
    FROM orders o
    WHERE o.customer_id = c.customer_id
          AND o.order_status = 'Delivered'
);

-- 8) Find products that have never appeared in order_items using NOT EXISTS.

SELECT p.*
FROM products p
WHERE NOT EXISTS (
	SELECT oi.product_id
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);

-- 9) Find orders whose amount is greater than the average order amount for their own customer. Use a correlated subquery.