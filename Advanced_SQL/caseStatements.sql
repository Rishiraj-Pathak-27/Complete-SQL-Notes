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



