-- Assign a Unique Row Number to Each Product Based on Price Ascending order



SELECT product_id, 
				name,
        price,
        ROW_NUMBER() OVER(ORDER BY price ASC) as row_num
FROM products;



-- Find the second cheapest product using ROW_NUMBER().

SELECT * FROM (
  		SELECT 
  				product_id,
  				name,
  				price,
  				ROW_NUMBER() OVER (ORDER BY price ASC) as price_row_number
  		FROM products
  ) subquery 
  
WHERE price_row_number = 2;

		
-- Retrieve the 5 most expensive products using ROW_NUMBER().

WITH productrank AS (
  SELECT 
  		product_id,
  		name,
  		price,
  		ROW_NUMBER() OVER( ORDER BY price DESC) as product_rank
 	FROM products
) 
SELECT * FROM  productrank
WHERE product_rank = 1;

 
-- Find the latest 2 payments made.

SELECT * FROM (
  	SELECT payment_id,
  					payment_date,
  					order_id,
            ROW_NUMBER() OVER (ORDER BY payment_date DESC) as payment_rank
    FROM payments) subquery1
WHERE payment_rank in (1,2);


-- Rank orders for each customer based on total amount spent.

SELECT customer_id, order_id, total_amount,
				RANK() OVER (PARTITION BY customer_id ORDER BY total_amount DESC) as order_rank
FROM orders;


-- Find the top 3 highest orders for each customer.

SELECT *
FROM ( 
  	SELECT customer_id, order_id, total_amount,
  	      DENSE_RANK() OVER( PARTITION BY customer_id ORDER BY total_amount DESC) as dense_rank
		FROM orders ) t 
  
WHERE dense_rank <= 3;
  

-- What was the previous order amount for each order?

SELECT order_id, order_date, total_amount,
				LAG(total_amount) OVER ( ORDER BY order_date) as previous_amount
FROM orders;










































-- retrieve all customers 

SELECT * FROM customers;

-- Retrieve Only First Name and Last Name of Customers

SELECT first_name, Last_name 
FROM customers;


-- Find Orders with a Total Amount Greater Than 100

SELECT * 
FROM orders 
WHERE total_amount>100;

-- Find Customers Who Registered After January 1, 2024

SELECT * 
FROM customers
WHERE created_at > '2024-01-01';


-- Retrieve All Orders for a Specific Customer (e.g., customer_id = 5)

SELECT * 
FROM orders
WHERE customer_id = 5; 

-- Join Customers and Orders to See Who Placed Which Order

SELECT c.first_name, c.last_name
FROM customers c
JOIN orders o 
ON c.customer_id = o.customer_id;

-- Find Unpaid Orders (No Matching Payment Record)

SELECT 
FROM orders o
JOIN payments p 
ON p.order_id = o.order_id
WHERE payment_Id IS NULL ; 


-- Find Payments Made Using 'Credit Card'

SELECT * 
FROM payments 
Where payment_method = 'Credit Card';


-- Retrieve Unique Payment Methods

SELECT DISTINCT payment_method 
FROM payments; 


-- Find Orders Placed on a Specific Date (e.g., January 15, 2024)


SELECT * 
FROM orders
WHERE order_date =  '2024-01-15';


-- Find Orders Placed Between '2024-01-01' AND '2024-01-31';

SELECT * 
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31';

-- RETRIEVE THE LATEST 5 ORDERS 

SELECT * 
FROM orders
ORDER BY order_date DESC
LIMIT 5;


-- Count the Total Number of Orders

SELECT COUNT(*) AS total_orders FROM orders;

-- Find the Maximum and Minimum Order Amount

SELECT MAX(total_amount) AS max_order, 
			MIN(total_amount) AS min_order
FROM orders; 


-- Find the Average Order Amount

SELECT AVG(total_amount) AS avg_amount
FROM orders;

-- Retrieve Orders Sorted by Total Amount (Highest to Lowest)

SELECT * 
FROM orders
ORDER BY total_amount DESC;

-- Count the Number of Customers Who Registered in 2024

SELECT COUNT(*) AS total_customers
FROM customers
WHERE EXTRACT (YEAR FROM created_at) = 2024;


-- Retrieve the First 10 Customers (Alphabetically by Last Name)

SELECT * FROM customers
ORDER BY last_name ASC
LIMIT 10;

-- Retrieve the Most Recent Payment 

SELECT * 
FROM payments
ORDER BY payment_date DESC
LIMIT 1; 


-- pull up the first and last payment amounts for each payment method?


SELECT payment_id, payment_method,amount,
			FIRST_VALUE(amount) OVER(PARTITION BY payment_method ORDER BY payment_date ASC ) as firt_payment,
      LAST_VALUE(amount) OVER(PARTITION BY payment_method ORDER BY payment_date ASC ) as last_payment
FROM payments;


-- Write a SQL query that divides all orders into 4 quartiles based on order amount.

SELECT order_id, total_amount,
       NTILE(4) OVER (ORDER BY total_amount DESC) AS quartile
FROM orders;

-- 


SELECT customer_id, order_id, total_amount,
       PERCENT_RANK() OVER (PARTITION BY customer_id ORDER BY total_amount DESC) AS percent_rank
FROM orders;




















