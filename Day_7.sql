-- Day_7
-- Assignment
SELECT order_id, order_date,
		DATE_ADD(order_date, INTERVAL 2 DAY) AS ship_date
FROM orders
WHERE order_date BETWEEN DATE('2024-04-01') AND DATE('2024-06-30')
ORDER BY order_date;

-- STRING FUNCTIONS
-- Change cases
SELECT event_name, UPPER(event_name), LOWER(event_name)
FROM my_events;

-- Clean event type and find the length of the description
SELECT event_name, event_type,
	   TRIM(event_type) AS event_type_clean,
       event_desc
FROM my_events;

-- Removing exclamation mark and replacing it with and empty string
WITH my_events_clean AS (
	SELECT event_name, event_type,
		   REPLACE(TRIM(event_type), '!', '') AS event_type_clean,
		   event_desc,
		   LENGTH(event_desc) AS desc_len
	FROM my_events
)
SELECT event_name, event_type_clean, event_desc,
	   CONCAT(event_type_clean, ' | ', event_desc) AS full_desc
FROM   my_events_clean;

-- Assignment
WITH cleaned_prducts AS (
	SELECT factory, product_id,
		   REPLACE(CONCAT(factory, '-',product_id), "'", "") AS factory_product
	FROM products
)
SELECT *, REPLACE(factory_product, ' ', '-') AS factory_product_id
FROM cleaned_prducts
ORDER BY factory
