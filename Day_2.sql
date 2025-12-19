-- Window functions
-- Basic window function, returns all row numbers
SELECT country, year, happiness_score,
ROW_NUMBER() OVER() AS row_num
FROM happiness_scores
ORDER BY country, year;

-- Returning all row numbers within each window
SELECT country, year, happiness_score,
ROW_NUMBER() OVER(PARTITION BY country ORDER BY happiness_score DESC) AS row_num
FROM happiness_scores
ORDER BY country, row_num;
 

-- Assignment
SELECT customer_id, order_id, order_date, transaction_id,
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY transaction_id ASC) AS transaction_number
FROM orders;


-- ROW_NUMBER, RANK, DENSE_RANK
DROP TABLE baby_girl_names;
 
 CREATE TABLE baby_girl_names (
    name VARCHAR(50),
    babies INT);

INSERT INTO baby_girl_names (name, babies) VALUES
	('Olivia', 99),
	('Emma', 80),
	('Charlotte', 80),
	('Amelia', 75),
	('Sophia', 72),
	('Isabella', 70),
	('Ava', 70),
	('Mia', 64);
 
 SELECT * ,
 ROW_NUMBER() OVER(ORDER BY babies DESC) as b_row_number,
 RANK() OVER(ORDER BY babies DESC) AS b_rank,
 DENSE_RANK() OVER(ORDER BY babies DESC) as b_dense_rank
 FROM baby_girl_names;
 
--  Assignment
SELECT order_id, product_id, units,
-- ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY units DESC)
	   DENSE_RANK() OVER (PARTITION BY order_id ORDER BY units DESC) AS product_rank
FROM orders
ORDER BY order_id, product_rank;
-- ORDER BY order_id DESC, units DESC;
 
 
 -- First values, last_values, and Nth value
 CREATE TABLE baby_names (
    gender VARCHAR(10),
    name VARCHAR(50),
    babies INT);

INSERT INTO baby_names (gender, name, babies) VALUES
	('Female', 'Charlotte', 80),
	('Female', 'Emma', 82),
	('Female', 'Olivia', 99),
	('Male', 'James', 85),
	('Male', 'Liam', 110),
	('Male', 'Noah', 95);
 
-- FIRST VALUE
SELECT * FROM 
(
	SELECT gender, name, babies,
	FIRST_VALUE(name) OVER(PARTITION BY gender ORDER BY babies DESC) AS top_name
	-- NTH_VALUE(name, 2) OVER(PARTITION BY gender ORDER BY babies DESC)
	FROM baby_names
) AS top_names
WHERE name = top_name;
 
-- NTH_VALUE
SELECT * FROM
(
	SELECT gender, name, babies,
-- 	FIRST_VALUE(name) OVER(PARTITION BY gender ORDER BY babies DESC) AS top_name
	NTH_VALUE(name, 2) OVER(PARTITION BY gender ORDER BY babies DESC) AS second_name
	FROM baby_names
) AS second_names
WHERE name = second_name;

-- Assignment
SELECT * FROM
(
	SELECT order_id, product_id, units,
		   NTH_VALUE(units, 2) OVER(PARTITION BY order_id ORDER BY units DESC) AS second_order
	FROM orders
) AS second_orders
WHERE units = second_order
ORDER BY order_id, second_order;

-- LEAD and LAG
-- Return prior year happiness score
SELECT country, year, happiness_score,
       LAG(happiness_score) OVER(PARTITION BY country ORDER BY year) AS prior_happiness_score
FROM happiness_scores;

-- Return the difference
WITH happiness_diff AS
(
	SELECT country, year, happiness_score,
		   LAG(happiness_score) OVER(PARTITION BY country ORDER BY year) AS prior_happiness_score
	FROM happiness_scores
)
SELECT *, (happiness_score - prior_happiness_score) AS change_happiness  FROM happiness_diff;

-- Assignment
SELECT *, (total_units - prior_units) AS diff_units FROM (
	WITH total_units AS (
		SELECT  customer_id, order_id, order_date,SUM(units) AS total_units FROM orders
		-- WHERE customer_id = 11148
		GROUP BY 1,2,3
	)
	SELECT customer_id, order_id, order_date, total_units,
		   LAG(total_units) OVER(PARTITION BY customer_id ORDER BY order_date ASC) AS prior_units
	FROM total_units
) AS difference_units
