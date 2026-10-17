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

# 1) Find orders whose total_amount is greater than the average order amount across all orders.

SELECT o.*
FROM orders o
WHERE o.total_amount > (
	SELECT AVG(o1.total_amount) 
	FROM orders o1
);

# 2) Find customers whose total completed spending is greater than the average customer completed spending.

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

# 3) Find products priced above the average product price.

SELECT p.*
FROM products p
WHERE p.unit_price > (
	SELECT AVG(p1.unit_price) 
    FROM products p1
);

# 4) Find the most expensive product.

SELECT p.*
FROM products p
WHERE p.unit_price = (
	SELECT MAX(p1.unit_price)
    FROM products p1
);

# 5) Find all customers who have placed at least one order using a subquery with IN.

SELECT c.customer_id,
       c.customer_name
FROM customers c
WHERE c.customer_id IN (
	SELECT o.customer_id
    FROM orders o
);

# 6) Find customers who have never placed an order using NOT IN.

SELECT c.*
FROM customers c
WHERE c.customer_id NOT IN (
	SELECT o.customer_id
    FROM orders o
);

# 7) Find customers who have placed at least one completed order using EXISTS.

SELECT c.*
FROM customers c
WHERE EXISTS (
	SELECT o.customer_id
    FROM orders o
    WHERE o.customer_id = c.customer_id
          AND o.order_status = 'Delivered'
);

# 8) Find products that have never appeared in order_items using NOT EXISTS.

SELECT p.*
FROM products p
WHERE NOT EXISTS (
	SELECT oi.product_id
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);

# 9) Find orders whose amount is greater than the average order amount for their own customer. Use a correlated subquery.

SELECT o.*
FROM orders o
WHERE o.total_amount > (
	SELECT AVG(o1.total_amount)
    FROM orders o1
    WHERE o1.customer_id = o.customer_id
);

# 10) Find products whose price is greater than the average price of products in the same category.

#	201 	Laptop 						Electronics 	  65000
#   202 	Wireless Mouse  			Electronics       1200
#   203 	Mechanical Keyboard 		Electronics		  3500
#   206 	USB-C Hub					Electronics       2200
#   207 	Noice Cancelling Headphones Electronics		  9000      AVG = 12822.22 
#   208 	Webcam HD					Electronics		  3000		so only prod_id = 201 and 211 will pass
#   211		Monitor 24 Inch				Electronics 	  15000
#   213		Bluetooth Speaker			Electronics		  4500
#   215		Drawing Tablet				Electronics		  12000

SELECT p.*
FROM products p
WHERE p.unit_price > (
	SELECT AVG(p1.unit_price)
    FROM products p1
    WHERE p1.category = p.category
);

# 11) Find customers whose latest order amount is greater than their own average order amount.

-- latest order amount
-- method 1
SELECT o.customer_id,
       o.order_date AS max_order_date,
       o.total_amount AS latest_order_amount
FROM (
	SELECT o1.*,
		   ROW_NUMBER() OVER(
				PARTITION BY o1.customer_id
                ORDER BY o1.order_date DESC
           ) AS rno
	FROM orders o1
) o
WHERE rno = 1;

-- method 2

SELECT o.customer_id,
       o.order_date,
       o.total_amount
FROM orders o
WHERE o.order_date = (
	SELECT MAX(o1.order_date)
    FROM orders o1
    WHERE o1.customer_id = o.customer_id
)
ORDER BY o.customer_id;

-- final query below

SELECT o.*
FROM orders o
WHERE o.order_date = (
	SELECT MAX(o1.order_date)
    FROM orders o1
    WHERE o1.customer_id = o.customer_id
)
AND o.total_amount > (
	SELECT AVG(o2.total_amount)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);

# 12) Find the second-highest product price without using LIMIT/OFFSET.

SELECT p.unit_price AS sec_max_price	
FROM (
	SELECT p1.*,
		   DENSE_RANK() OVER(
				ORDER BY p1.unit_price DESC
           ) AS drnk
	FROM products p1
) p
WHERE p.drnk = 2;

# 13) Find the third-highest distinct order amount.

SELECT o.total_amount AS third_max_order_amount
FROM (
	SELECT o1.*,
		   DENSE_RANK() OVER(
				ORDER BY o1.total_amount DESC
           ) AS drnk
	FROM orders o1
) o
WHERE o.drnk = 3;

# 14) Find customers who have placed more orders than the average number of orders per customer.

SELECT c.customer_id,
       COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > (
	SELECT AVG(order_count)
	FROM (
		SELECT c1.customer_id,
			   COUNT(o1.order_id) AS order_count
		FROM customers c1
        LEFT JOIN orders o1
        ON c1.customer_id = o1.customer_id
        GROUP BY c1.customer_id
    ) o1
);

# 15) Find products whose total sold quantity is greater than the average sold quantity across products.

SELECT p.product_id,
       COALESCE(SUM(oi.quantity),0) AS total_qty
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id
HAVING total_qty > (
	SELECT AVG(oi2.total_qty)
    FROM (
		SELECT p1.product_id,
               COALESCE(SUM(oi1.quantity),0) AS total_qty
		FROM products p1
        LEFT JOIN order_items oi1
        ON p1.product_id = oi1.product_id
        GROUP BY p1.product_id
    ) AS oi2
);

# 16) Find the customer(s) who placed the highest-value completed order. 

-- SELECT c.customer_id,
--        MAX(o.total_amount) AS total_cust_amount
-- FROM (
-- 	SELECT c.customer_id,
--        SUM(o.total_amount) AS total_cust_amount
-- FROM customers c
-- LEFT JOIN orders o
-- ON c.customer_id = o.customer_id
-- GROUP BY c.customer_id
-- ) c
-- LEFT JOIN orders o
-- ON c.customer_id = o.customer_id
-- GROUP BY c.customer_id
-- ORDER BY total_cust_amount DESC
-- LIMIT 1;


SELECT c.customer_id,
       c.customer_name,
       o.order_id,
       o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
ORDER BY total_amount DESC
LIMIT 1;

# 17) Find orders that contain the product with the highest unit price.

SELECT oi.order_id, 
       p.product_id,
       p.product_name,
       p.unit_price
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
HAVING unit_price = (
	SELECT MAX(p1.unit_price)
    FROM products p1
);

# 18) Find customers who purchased the most expensive product.

SELECT DISTINCT c.customer_id,
       c.customer_name,
       COALESCE(p.unit_price,0) AS unit_price 
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
HAVING unit_price = (
	SELECT MAX(p1.unit_price)
    FROM products p1
);

# 19) Find categories whose total completed revenue is above the average category revenue.

SELECT p.category,
       SUM(oi.line_total) AS total_revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category
HAVING SUM(oi.line_total) > (
	SELECT AVG(prod.total_revenue)
    FROM (
		SELECT p1.category,
               SUM(oi1.line_total) AS total_revenue
		FROM products p1
        JOIN order_items oi1
        ON p1.product_id = oi1.product_id
        JOIN orders o1
        ON oi1.order_id = o1.order_id
        GROUP BY p1.category
    ) prod
);

# 20) Find the highest-spending customer in each state using a correlated subquery or nested aggregation.

SELECT c.customer_id,
       c.state,
	   COALESCE(SUM(o.total_amount),0) AS total_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.state
HAVING SUM(o.total_amount) = (
	SELECT MAX(cust.total_amount)
    FROM (
		SELECT c1.customer_id,
               c1.state,
               COALESCE(SUM(o1.total_amount),0) AS total_amount
		FROM customers c1
        LEFT JOIN orders o1
        ON c1.customer_id = o1.customer_id
        WHERE c1.state = c.state
        GROUP BY c1.customer_id, c1.state
    ) cust
);

-- -----------------------------------------------------------------------------------

-- CASE STATEMENTS

# 1) Display each product with a stock_status: 'Out of Stock', 'Low Stock' for stock_qty < 15, 'Medium Stock' for 15–30, otherwise 'Healthy Stock'.

SELECT p.*,
       CASE
           WHEN p.stock_qty = 0 THEN 'Out Of Stock'
           WHEN p.stock_qty <= 15 AND p.stock_qty <> 0 THEN 'Low Stock'
           WHEN p.stock_qty <= 30 THEN 'Medium Stock'
           ELSE 'Healthy Stock'
	   END stock_status
FROM products p;

# 2) Classify each order as 'High Value' if total_amount >= 15000, 'Medium Value' if >= 5000, otherwise 'Low Value'.

SELECT o.*,
       CASE
           WHEN o.total_amount >= 15000 THEN 'High Value'
           WHEN o.total_amount >= 5000 THEN 'Medium Value'
           ELSE 'Low Value'
	   END amount_label
FROM orders o;

# 3) Create a payment_type label: UPI, Card, Cash, or Other.

SELECT o.*,
       CASE
		   WHEN o.payment_method = 'UPI' THEN 'UPI'
           WHEN o.payment_method = 'Card' THEN 'Card'
           WHEN o.payment_method = 'Cash' THEN 'Cash'
           ELSE 'Other'
	   END payment_type
FROM orders o;

# 4) Display customer_name and a customer_region label: Maharashtra vs Other State.

SELECT c.customer_name,
       c.state,
	   CASE
           WHEN c.state = 'Maharashtra' THEN 'Maharashtra'
           ELSE 'Other State'
	   END customer_region
FROM customers c;


# 5) For each order, create a revenue_status: Completed, Cancelled, or Pending based on order_status.

SELECT o.*,
       CASE
		   WHEN o.order_status = 'Delivered' THEN 'Completed'
           WHEN o.order_status = 'Cancelled' THEN 'Cancelled'
           ELSE 'Pending'
	   END revenue_status
FROM orders o;

# 6) Calculate an estimated discount: 10% for orders >= 15000, 5% for orders >= 5000, otherwise 0%.

SELECT o.*,
       CASE
		   WHEN o.total_amount >= 15000 THEN '10%'
           WHEN o.total_amount >= 5000 THEN '5%'
           ELSE '0%'
	   END discount
FROM orders o;

# 7) Calculate the final_amount after the estimated discount.

-- discount_amount

SELECT o.*,
       CASE
	       WHEN o.total_amount >= 15000 THEN (o.total_amount*0.10)
           WHEN o.total_amount >= 5000 THEN (o.total_amount*0.05)
           ELSE 0
	   END discount_amount
FROM orders o;


-- final_amount

SELECT o.*,
	   (o.total_amount - o.discount_amount) AS final_amount
FROM (
	SELECT o1.*,
           CASE
			   WHEN o1.total_amount >= 15000 THEN (o1.total_amount*0.10)
               WHEN o1.total_amount >= 5000 THEN (o1.total_amount*0.05)
               ELSE 0
		   END discount_amount
	FROM orders o1
) o;

# 8) Count how many orders fall into each order-value band.

SELECT o1.band,
       COUNT(
			CASE
				WHEN o1.band = 'Low Value' THEN 1
                WHEN o1.band = 'Medium Value' THEN 1
                WHEN o1.band = 'High Value' THEN 1
                ELSE 0
		    END
       ) band_count
FROM (
SELECT o.*,
       CASE
		   WHEN o.total_amount <= 5000 THEN 'Low Value'
           WHEN o.total_amount < 15000 THEN 'Medium value'
           ELSE 'High Value'
	   END band
FROM orders o
) o1
GROUP BY o1.band;

# 9) For each customer, classify them as 'New', 'Regular', or 'VIP' based on completed spending: <5000, 5000–14999, >=15000.

SELECT c.customer_id,
	   c.customer_name,
       CASE
		   WHEN SUM(o.total_amount) < 5000 THEN 'New'
           WHEN SUM(o.total_amount) < 15000 THEN 'Regular'
           ELSE 'VIP'
	   END cust_classification
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

# 10) Use CASE inside SUM to calculate completed revenue and cancelled revenue separately in one query.

SELECT 
	   SUM(CASE
			   WHEN o.order_status = 'Delivered' THEN o.total_amount
               ELSE 0
		   END) completed_revenue,
           
		SUM(CASE
				WHEN o.order_status = 'Cancelled' THEN o.total_amount
                ELSE 0
			END) cancelled_revenue
FROM orders o;

# 11) Use CASE inside COUNT to count completed orders and cancelled orders per customer.

SELECT c.customer_id, 
       c.customer_name,
	COUNT(
			CASE
				WHEN o.order_status = 'Delivered' THEN 1
			END) completed_count,
		
	   COUNT(CASE
				 WHEN o.order_status = 'Cancelled' THEN 1
			 END) cancelled_count
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

# 12) Sort products so Electronics appear first, then Furniture, then Stationery, without changing the stored category values.

SELECT p.*,
	   CASE
		   WHEN p.order_category = 1 THEN 'Electronics'
           WHEN p.order_category = 2 THEN 'Furniture'
           WHEN p.order_category = 3 THEN 'Stationery'
	   END order_category_name
FROM (
	SELECT p1.*,
	CASE
		WHEN p1.category = 'Electronics' THEN 1
		WHEN p1.category = 'Furniture' THEN 2
		WHEN p1.category = 'Stationery' THEN 3
	END order_category
    FROM products p1
) p;

-- or simple query below

SELECT p.*
FROM products p
ORDER BY CASE
			  WHEN p.category = 'Electronics' THEN 1
		      WHEN p.category = 'Furniture' THEN 2
			  WHEN p.category = 'Stationery' THEN 3
              ELSE 4
		  END;
          
# 13) Create a delivery_priority label: High for high-value non-cancelled orders, Medium for other non-cancelled orders, Low for cancelled orders.

SELECT o.*,
	   CASE
		   WHEN o.order_status IN ('Delivered', 'Processing', 'Shipped') AND o.total_amount > 15000 THEN 'High'
           WHEN o.order_status IN ('Delivered', 'Processing', 'Shipped') THEN 'Medium'
           WHEN o.order_status = 'Cancelled' THEN 'Low'
           ELSE 'Unknown'
	   END delivery_priority
FROM orders o;

-- OR

SELECT o.*,
	   CASE
		   WHEN o.order_status <> 'Cancelled' AND o.total_amount > 15000 THEN 'High'
           WHEN o.order_status <> 'Cancelled' THEN 'Medium'
           WHEN o.order_status = 'Cancelled' THEN 'Low'
           ELSE 'Unknown'
	   END delivery_priority
FROM orders o;

# 14) For each state, calculate the number of customers with at least one completed order using CASE.

SELECT c.state,
	   COUNT(DISTINCT CASE
			   WHEN o.order_status = 'Delivered' THEN c.customer_id
		   END) completed_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.state
HAVING completed_orders >= 1;

# 15) Calculate a stock_risk score: 3 when stock < 10, 2 when stock is 10–19, 1 when stock is 20–30, 0 otherwise.

SELECT p.*,
	   CASE
		   WHEN p.stock_qty < 10 THEN 3
           WHEN p.stock_qty < 20 THEN 2
           WHEN p.stock_qty <= 30 THEN 1
           ELSE 0
	   END stock_risk_score
FROM products p;