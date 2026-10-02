-- CASE Statements Evaluates the list of conditions and returns a value when first condition is met.

-- Syntax:

-- CASE 
--     WHEN cond1 THEN result1
--     WHEN cond2 THEN result2
-- 	   ELSE default_result
-- END AS alias

-- CASE Expressions allows us to enter a result set when a hardcoded value evaluates to true in an expression.
-- These are mainly applied on the single attribute against a list of static values.

-- Syntax:

-- CASE expression
-- 		WHEN value1 THEN result1
--     	WHEN value2 THEN result2
--     	ELSE default_result
-- END AS alias

-- -------------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS cases;
USE cases;

-- Scenario Based Assignment

-- Scenario 1 - E-Commerce Orders

# SCHEMA 1 - customers


CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50),
customer_type VARCHAR(20)
);

INSERT INTO customers VALUES 
(1,"Rahul","Mumbai","Regular"),
(2,"Priya","Pune","Premium"),
(3,"Amit","Nagpur","Regular"),
(4,"Sneha","Mumbai","Premium"),
(5,"Karan","Pune","Regular"),
(6,"Neha","Nagpur","Premium");

SELECT * FROM customers;

DESCRIBE customers;

# SCHEMA 2 - orders

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
order_value DECIMAL(10,2),
payment_method VARCHAR(20),
order_status VARCHAR(20),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
(101,1,'2026-01-05',5000,"UPI","Delivered"),
(102,2,'2026-01-08',7000,"Card","Delivered"),
(103,1,'2026-01-15',3000,"UPI","Cancelled"),
(104,3,'2026-01-20',9000,"Card","Delivered"),
(105,4,'2026-01-25',4000,"COD","Pending"),
(106,2,'2026-02-03',5000,"UPI","Delivered"),
(107,5,'2026-02-10',8000,"Card","Delivered"),
(108,3,'2026-02-15',6000,"UPI","Returned"),
(109,1,'2026-02-20',7000,"Card","Delivered"),
(110,6,'2026-02-25',5000,"UPI","Delivered"),
(111,4,'2026-03-02',6000,"Card","Delivered"),
(112,5,'2026-03-10',4000,"COD","Pending");

SELECT * FROM orders;

DESCRIBE orders;

-- ---------------------------------------------------------------------

-- 1) Classify order value as High (>=7000), Medium (>=4000 and <7000), or Low (<4000) using searched CASE.

SELECT o.*,
	   CASE 
		   WHEN o.order_value >= 7000 THEN "High"
           WHEN o.order_value >= 4000 AND o.order_value < 7000 THEN "Medium"
           WHEN o.order_value < 4000 THEN "Low"
           ELSE "Incorrect Order Value"
	   END AS order_classification
FROM orders o;

-- 2) Using simple CASE, convert UPI → Digital UPI, Card → Credit/Debit Card, COD → Cash on Delivery

SELECT o.*,
	   CASE o.payment_method
			WHEN "UPI" THEN "Digital UPI" 
            WHEN "Card" THEN "Credit/Debit Card"
			WHEN "COD" THEN "Cash on Delivery"
	        ELSE "Incorrect status"
	   END AS updated_method
FROM orders o;

-- 3) Create a status label: Delivered → Completed, Pending → Open, Cancelled/Returned → Problematic.

SELECT o.*,
	   CASE o.order_status
			WHEN "Delivered" THEN "Completed"
            WHEN "Pending" THEN "Open" 
            WHEN "Cancelled" OR "Returned" THEN "Problematic"
			ELSE "Incorrect status"
	   END AS status
FROM orders o;

-- 4) Calculate total revenue from only Delivered orders using SUM(CASE...).

SELECT SUM(
	CASE WHEN o.order_status = "Delivered"
		 THEN o.order_value
		 ELSE 0
	END
) AS deliveries_sum
FROM orders o;

-- 5) Calculate Delivered, Pending, Cancelled, and Returned value in separate columns.

SELECT
	SUM(CASE WHEN o.order_status = "Delivered" THEN o.order_value ELSE 0 END) AS delivered_value,
	SUM(CASE WHEN o.order_status = "Cancelled" THEN o.order_value ELSE 0 END) AS cancelled_value,
	SUM(CASE WHEN o.order_status = "Pending" THEN o.order_value ELSE 0 END) AS pending_value,
	SUM(CASE WHEN o.order_status = "Returned" THEN o.order_value ELSE 0 END) AS returned_value
FROM orders o;

-- 6) Count Delivered, Pending, Cancelled, and Returned orders using conditional aggregation.

SELECT 
	  COUNT(CASE WHEN o.order_status = "Delivered" THEN 1 END) AS delivered_count,
      COUNT(CASE WHEN o.order_status = "Cancelled" THEN 1 END) AS delivered_Cancelled,
      COUNT(CASE WHEN o.order_status = "Pending" THEN 1 END) AS delivered_Pending,
      COUNT(CASE WHEN o.order_status = "Returned" THEN 1 END) AS delivered_Returned
FROM orders o;

-- 7) For every customer, show total order value and label them VIP (>=12000), Regular (>=7000), or Low Spender.

SELECT o.*,
	   CASE WHEN o.total_value >= 12000 THEN "VIP"
			WHEN o.total_value >= 7000 THEN "Regular"
            ELSE "Low Spender"
	   END AS category
FROM (
	SELECT o.*,
	   SUM(o.order_value) OVER(
			PARTITION BY o.customer_id
       ) AS total_value
	FROM orders o 
) o;

-- 8) Find cities with at least 2 Delivered orders using conditional aggregation and HAVING.

SELECT c.city
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status = "Delivered"
GROUP BY c.city
HAVING COUNT(o.order_status) >= 2;

# OR

SELECT c.city
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(
	CASE WHEN o.order_status = "Delivered" THEN 1
		 ELSE 0
	END 
) >= 2;

-- 9) Create a custom status priority: Pending=1, Delivered=2, Returned=3, Cancelled=4, then sort by priority.

SELECT o.*
FROM (
	SELECT o.*,
		CASE WHEN o.order_status = "Pending" THEN "1"
			WHEN o.order_status = "Delivered" THEN "2"
			WHEN o.order_status = "Returned" THEN "3"
			WHEN o.order_status = "Cancelled" THEN "4"
			ELSE "0"
		END AS custom_status
	FROM orders o
) o
ORDER BY o.custom_status;

-- 10) Create a customer report with total orders, delivered orders, cancelled/returned orders, and a Clean/Review CASE label.

SELECT c.customer_id, c.customer_name,
	  COUNT(order_id) AS total_orders,
	  COUNT(CASE
				WHEN o.order_status = 'Delivered' THEN 1
			END) AS delivered_orders,
      COUNT(CASE 
				WHEN o.order_status IN ('Cancelled','Returned') THEN 1
			END) AS cancelled_returned_orders,
      CASE 
		  WHEN COUNT(CASE 
						 WHEN o.order_status IN ('Returned','Cancelled') THEN 1
					 END) = 0 THEN 'Clean'
		  ELSE 'Review'
		END AS customer_label
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id,c.customer_name;

-- ------------------------------------------------------------------------

# Scenario 2 - Logistics & Delivery

-- 1) SCHEMA - Drivers

CREATE TABLE drivers (
driver_id INT PRIMARY KEY,
driver_name VARCHAR(50),
city VARCHAR(50)
);

INSERT INTO drivers VALUES
(1,'Ramesh','Mumbai'),
(2,'Suresh','Pune'),
(3,'Akash','Nagpur'),
(4,'Vikram','Mumbai'),
(5,'Rohit','Pune'),
(6,'Anil','Nagpur');

SELECT * FROM drivers;

DESCRIBE drivers;

-- 2) SCHEMA - deliveries

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
(201,1,'2026-01-05',4.5,5000,'Delivered'),
(202,2,'2026-01-06',6.0,7000,'Delayed'),
(203,1,'2026-01-10',3.5,4000,'Delivered'),
(204,3,'2026-01-12',5.0,8000,'Delivered'),
(205,4,'2026-01-15',7.0,6000,'Delayed'),
(206,2,'2026-01-18',4.0,5000,'Delivered'),
(207,5,'2026-01-20',5.5,9000,'Delivered'),
(208,3,'2026-01-22',4.0,6000,'Delivered'),
(209,1,'2026-01-25',6.0,7000,'Delayed'),
(210,6,'2026-01-28',3.0,5000,'Delivered'),
(211,4,'2026-02-02',5.5,7000,'Delivered'),
(212,5,'2026-02-05',4.5,6000,'Delayed');

SELECT * FROM deliveries;

DESCRIBE deliveries;

-- ---------------------------------------------------------------------

-- 1) Classify delivery time as Fast (<4 hours), Normal (4–5.5 hours), or Slow (>5.5 hours).

SELECT d.driver_id,
	   d.delivery_date,
       d.delivery_time_hours,
       d.delivery_value,
       d.status,
	CASE 
		WHEN d.delivery_time_hours < 4 THEN 'Fast'
        WHEN d.delivery_time_hours < 5.5 THEN 'Normal'
        ELSE 'Slow'
	END AS delivery_time_category
FROM deliveries d;

-- 2) Classify delivery value as High (>=7000), Medium (>=5000), or Low (<5000).

SELECT d.*,
	   CASE 
		   WHEN d.delivery_value >= 7000 THEN 'High'
           WHEN d.delivery_value >= 5000 THEN 'Medium'
           ELSE 'Low'
		END value_category
FROM deliveries d;

-- 3) Create a status label: Delayed → Needs Attention; Delivered → On Time; otherwise Unknown.

SELECT d.*,
	   CASE 
		   WHEN d.status = 'Delayed' THEN 'Needs Attention'
           WHEN d.status = 'Delivered' THEN 'On Time'
           ELSE 'Unknown'
		END status_label
FROM deliveries d;

-- 4) Count delayed deliveries for each driver using SUM(CASE...).

SELECT d1.driver_id,
	   d1.driver_name,
       SUM(
			CASE 
                WHEN d2.status = 'Delayed' THEN 1
                ELSE 0
			END 
       ) AS delayed_deliveries
FROM drivers d1
JOIN deliveries d2
ON d1.driver_id = d2.driver_id
GROUP BY d1.driver_id, d1.driver_name;

-- 5) Calculate delayed-delivery percentage for each driver.

SELECT d1.driver_id,
       d1.driver_name,
       d2.total_deliveries,
       d2.delayed_deliveries,
       (d2.delayed_deliveries / d2.total_deliveries) * 100 AS percentage
FROM (
	SELECT d3.driver_id,
			COUNT(CASE
					  WHEN d3.status = 'Delayed' THEN 1
				  END) AS delayed_deliveries,
			COUNT(*) AS total_deliveries
	FROM deliveries d3
    GROUP BY d3.driver_id
) d2
JOIN drivers d1
ON d2.driver_id = d1.driver_id;

-- 6) Calculate total delivery value and delayed delivery value for each city.

SELECT d1.city,
	   SUM(d2.delivery_value) AS total_delivery_value,
	   SUM(CASE
			   WHEN d2.status = 'Delayed' THEN d2.delivery_value
			   ELSE 0
		   END) AS delayed_delivery_value
FROM deliveries d2
JOIN drivers d1
ON d1.driver_id = d2.driver_id
GROUP BY d1.city;

-- 7) Classify drivers from average delivery time: Excellent <=4, Good <=5.5, Needs Improvement >5.5.

SELECT d2.driver_id,
       d2.driver_name,
       d2.avg_delivery_time,
       CASE
		   WHEN d2.avg_delivery_time <= 4 THEN 'Excellent'
           WHEN d2.avg_delivery_time <= 5.5 THEN 'Good'
		   ELSE 'Needs Improvement'
	   END time_tags
FROM (
	 SELECT d1.driver_id,
		    d1.driver_name,
            AVG(d2.delivery_time_hours) AS avg_delivery_time
     FROM drivers d1
     JOIN deliveries d2
     ON d1.driver_id = d2.driver_id
     GROUP BY d1.driver_id,d1.driver_name
) d2;

-- 8) Using CASE inside SUM, calculate Fast-delivery value and Slow-delivery value for each driver.

SELECT d2.driver_id,
	   d2.driver_name,
       SUM(CASE
			   WHEN d1.delivery_time_hours < 4 THEN d1.delivery_value
               ELSE 0
		   END) AS fast_delivery,
           
		SUM(CASE 
				WHEN d1.delivery_time_hours > 5.5 THEN d1.delivery_value
                ELSE 0
			END) AS slow_delivery
FROM drivers d2
JOIN deliveries d1
ON d2.driver_id=d1.driver_id
GROUP BY d2.driver_id,d2.driver_name;

-- 9) Create a custom status priority and sort deliveries by priority, then delivery date.

SELECT d2.*,
	   CASE 
		   WHEN d2.status = 'Delayed' THEN 1
           WHEN d2.status = 'Delivered' THEN 2
           ELSE 3
	   END priority
FROM deliveries d2
ORDER BY priority, delivery_date;

-- 10) Using a subquery or CTE, calculate each driver's total delivery value and label them Top Performer >=14000, Strong >=10000, Developing otherwise.

SELECT d1.driver_id,
	   d1.driver_name,
       d2.total_delivery_value,
       CASE
		   WHEN d2.total_delivery_value >= 14000 THEN 'Top Performer'
           WHEN d2.total_delivery_value >= 10000 THEN 'Strong'
           ELSE 'Developing'
	   END classification
FROM (
	SELECT d3.driver_id,
		SUM(d3.delivery_value) AS total_delivery_value
	FROM deliveries d3
	GROUP BY d3.driver_id
) d2
JOIN drivers d1
ON d1.driver_id = d2.driver_id;

-- -------------------------------------------------------------------------------------------------

# SCENARIO 3 - Warehouse Inventory

-- 1) SCHEMA 1 - Inventory

CREATE TABLE inventory (
inventory_id INT PRIMARY KEY,
warehouse VARCHAR(50),
product VARCHAR(50),
stock INT,
stock_value DECIMAL(12,2),
last_updated DATE
);

INSERT INTO inventory VALUES
(301,'Mumbai','Laptop',20,1200000,'2026-01-05'),
(302,'Mumbai','Phone',50,750000,'2026-01-06'),
(303,'Mumbai','Tablet',30,450000,'2026-01-07'),
(304,'Pune','Laptop',15,900000,'2026-01-08'),
(305,'Pune','Phone',60,900000,'2026-01-09'),
(306,'Pune','Tablet',25,375000,'2026-01-10'),
(307,'Nagpur','Laptop',10,600000,'2026-01-11'),
(308,'Nagpur','Phone',40,600000,'2026-01-12'),
(309,'Nagpur','Tablet',20,300000,'2026-01-13'),
(310,'Mumbai','Monitor',25,500000,'2026-01-14'),
(311,'Pune','Monitor',30,600000,'2026-01-15'),
(312,'Nagpur','Monitor',15,300000,'2026-01-16');

SELECT * FROM inventory;

DESCRIBE inventory;

-- ----------------------------------------------------------------------------

-- 1) Classify stock as Low (<15), Medium (15–30), or High (>30).

SELECT i.*,
	   CASE 
		   WHEN i.stock < 15 THEN 'Low'
           WHEN i.stock < 30 THEN 'Medium'
           ELSE 'High'
	   END stock_classification
FROM inventory i;

-- 2) Classify stock value as Low (<500000), Medium (500000–800000), or High (>800000).

SELECT i.*,
	   CASE
		   WHEN i.stock_value < 500000 THEN 'Low'
           WHEN i.stock_value < 800000 THEN 'Medium'
           ELSE 'High'
	   END stock_value_classification
FROM inventory i;

-- 3) Create stock_action: Low → Reorder, Medium → Monitor, High → No Action.

SELECT i2.*,
	   CASE
		   WHEN i2.stock_classification = 'Low' THEN 'Reorder'
           WHEN i2.stock_classification = 'Medium' THEN 'Monitor'
           ELSE 'No Action'
	   END stock_action
FROM (SELECT i1.*,
	   CASE 
		   WHEN i1.stock < 15 THEN 'Low' 
           WHEN i1.stock < 30 THEN 'Medium'
           ELSE 'High'
	   END stock_classification
FROM inventory i1 
) i2;

-- 4) For each warehouse, count Low Stock products using SUM(CASE...).

SELECT i1.warehouse,
       SUM(CASE
			   WHEN i1.stock < 15 THEN 1
               ELSE 0
		   END) low_stock_value
FROM inventory i1
GROUP BY i1.warehouse;

-- 5) For each warehouse, calculate stock value belonging to products with stock <20.

SELECT i1.warehouse,
SUM(CASE
		WHEN i1.stock < 20 THEN i1.stock_value
		ELSE 0
	END) AS low_stock_value
FROM inventory i1
GROUP BY i1.warehouse;

-- 6) Calculate each warehouse's total stock value and percentage contributed by Low Stock products.

SELECT i2.warehouse,
	   i2.total_stock_value,
	   (i2.low_stock_value / total_stock_value) * 100 AS contribution
FROM(
	SELECT i1.warehouse,
		SUM(i1.stock_value) AS total_stock_value,
        SUM(CASE
                WHEN i1.stock < 20 THEN i1.stock_value
                ELSE 0
		    END) low_stock_value
	FROM inventory i1
	GROUP BY i1.warehouse
) i2;

-- 7) Using CASE with a window function, label products as Warehouse Risk when stock <20 and stock_value >500000.

SELECT i.warehouse,
	SUM(i.stock_value) OVER(
		PARTITION BY i.warehouse
	) AS stock_value_per_warehouse,
    CASE
		WHEN i.stock < 20 AND i.stock_value > 500000 THEN 'Warehouse Risk'
        ELSE 'Normal'
	END product_health
FROM inventory i;


-- 8) Create a warehouse report with total products, low-stock products, high-stock products, and health: Critical if low-stock count >=2, Watch if =1, Healthy otherwise.

SELECT i.warehouse,
	   i.total_products,
       i.low_stock_product,
       i.high_stock_product,
	   CASE
		   WHEN low_stock_product >= 2 THEN 'Critical'
		   WHEN low_stock_product = 1 THEN 'Watch'
		   ELSE 'Healthy'
	   END health
FROM (
		SELECT warehouse,
			   COUNT(*) AS total_products,
			   SUM(
				   CASE
				       WHEN stock < 20 THEN 1
                       ELSE 0
			       END
               ) low_stock_product,
               SUM(
				   CASE
                       WHEN stock > 50 THEN 1
                       ELSE 0
				   END
			   ) high_stock_product
		FROM inventory
        GROUP BY warehouse
) i;

-- 9) Create custom product priority: Laptop=1, Phone=2, Tablet=3, Monitor=4 and sort within each warehouse.

SELECT i.warehouse,
	   CASE i.product
		    WHEN 'Laptop' THEN 1
            WHEN 'Phone' THEN 2
            WHEN 'Tablet' THEN 3
            WHEN 'Monitor' THEN 4
            ELSE 5
	   END priority
FROM inventory i
ORDER BY warehouse;
       
-- 10) Final inventory challenge: combine CASE, SUM(), AVG(), and a window function to show warehouse, product, stock,
-- stock value, warehouse total value, stock-risk label, and product contribution percentage.

SELECT i.warehouse,
       i.product,
       i.stock,
       i.stock_value,
       i.warehouse_total_value,
       ROUND(i.warehouse_avg_value,2),
       i.stock_risk_label,
       ROUND((i.stock_value / i.warehouse_total_value) * 100,4) AS product_contribution
FROM (
	SELECT i1.warehouse,
		   i1.product,
           i1.stock,
           i1.stock_value,
           
		   SUM(i1.stock_value) OVER w AS warehouse_total_value,
           AVG(i1.stock_value) OVER w AS warehouse_avg_value,
           
           CASE
				WHEN i1.stock < 20 AND i1.stock_value > 500000 THEN 'Warehouse Risk'
				ELSE 'Normal'
			END stock_risk_label
	FROM inventory i1
    WINDOW w AS (PARTITION BY i1.warehouse)
) i;