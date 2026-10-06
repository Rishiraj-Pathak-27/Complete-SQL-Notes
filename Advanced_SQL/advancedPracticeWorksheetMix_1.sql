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
(101,'Aarav Mehta','Nagpur','Maharashtra','2025-01-12'),
(102,'Diya Sharma','Pune','Maharashtra','2025-02-04'),
(103,'Kabir Patil','Mumbai','Maharashtra','2025-02-20'),
(104,'Anaya Joshi','Nashik','Maharashtra','2025-03-03'),
(105,'Rohan Deshmukh','Nagpur','Maharashtra','2025-03-18'),
(106,'Ishita Kulkarni','Aurangabad','Maharashtra','2025-04-02'),
(107,'Vivaan Rao','Bengaluru','Karnataka','2025-04-15'),
(108,'Meera Shah','Ahmedabad','Gujarat','2025-05-01'),
(109,'Arjun Nair','Kochi','Kerala','2025-05-19'),
(110,'Sara Khan','Hyderabad','Telangana','2025-06-07');

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
(210, 'Desk Lamp', 'Furniture', 1800, 45);

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
(1001, 101, '2025-06-10', 'Delivered', 'UPI', 65000),
(1002, 102, '2025-06-11', 'Delivered', 'Card', 4700),
(1003, 103, '2025-06-12', 'Shipped', 'Card', 17500),
(1004, 101, '2025-06-15', 'Delivered', 'Card', 11600),
(1005, 104, '2025-06-18', 'Cancelled', 'UPI', 8500),
(1006, 105, '2025-06-20', 'Delivered', 'Cash', 14000),
(1007, 106, '2025-06-22', 'Delivered', 'UPI', 2700),
(1008, 107, '2025-06-25', 'Shipped', 'Card', 9000),
(1009, 108, '2025-06-28', 'Delivered', 'UPI', 18000),
(1010, 109, '2025-07-01', 'Processing', 'Card', 3500),
(1011, 110, '2025-07-03', 'Delivered', 'Card', 9200),
(1012, 103, '2025-07-04', 'Delivered', 'UPI', 15500),
(1013, 105, '2025-07-05', 'Cancelled', 'Card', 1200),
(1014, 107, '2025-07-07', 'Delivered', 'UPI', 16800),
(1015, 102, '2025-07-08', 'Delivered', 'Card', 3000);


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
(1011, 202, 1, 200),
(1012, 205, 1, 14000),
(1012, 206, 1, 1500),
(1013, 202, 1, 1200),
(1014, 205, 1, 14000),
(1014, 210, 1, 1800),
(1014, 202, 1, 1000),
(1015, 208, 1, 3000);


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