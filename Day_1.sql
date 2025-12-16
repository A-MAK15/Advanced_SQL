use maven_advanced_sql;

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    salary INT,
    manager_id INT
);

INSERT INTO employees (employee_id, employee_name, salary, manager_id) VALUES
	(1, 'Ava', 85000, NULL),
	(2, 'Bob', 72000, 1),
	(3, 'Cat', 59000, 1),
	(4, 'Dan', 85000, 2);

-- Self Join 
-- Employees with the same salary
SELECT e1.employee_id, e1.employee_name, e1.salary, e2.employee_id, e2.employee_name, e2.salary 
FROM employees e1
INNER JOIN employees e2
ON e1.salary = e2.salary
WHERE e1.employee_id > e2.employee_id;

-- Employees with greater slary
SELECT e1.employee_id, e1.employee_name, e1.salary, e2.employee_id, e2.employee_name, e2.salary 
FROM employees e1
INNER JOIN employees e2
ON e1.salary > e2.salary;


-- Employees and Managers
SELECT e1.employee_name, e2.employee_name AS Manager
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id;

-- Assignment
SELECT p1.product_name, p1.unit_price, p2.product_name, p2.unit_price, (p1.unit_price - p2.unit_price) AS price_diff
FROM products p1
INNER JOIN products p2
ON p1.product_id != p2.product_id
WHERE ABS(p1.unit_price - p2.unit_price) < 0.25
ORDER BY price_diff DESC;

-- Union
CREATE TABLE tops (
    id INT,
    item VARCHAR(50)
);

CREATE TABLE sizes (
    id INT,
    size VARCHAR(50)
);

CREATE TABLE outerwear (
    id INT,
    item VARCHAR(50)
);

INSERT INTO tops (id, item) VALUES
	(1, 'T-Shirt'),
	(2, 'Hoodie');

INSERT INTO sizes (id, size) VALUES
	(101, 'Small'),
	(102, 'Medium'),
	(103, 'Large');

INSERT INTO outerwear (id, item) VALUES
	(2, 'Hoodie'),
	(3, 'Jacket'),
	(4, 'Coat');
    
-- View the tables
SELECT * FROM tops
UNION ALL
SELECT * FROM outerwear;
    
-- UNION with different columns
SELECT year, country, happiness_score FROM happiness_scores
UNION
SELECT 2024, country, ladder_score FROM happiness_scores_current;


-- Subquery and CTE
-- In the Select clause
SELECT product_id, product_name, unit_price,
	   (SELECT AVG(unit_price) FROM products) AS avg_unit_price, 
       unit_price - (SELECT AVG(unit_price) FROM products) AS diff_price
FROM products
ORDER BY unit_price DESC;

-- In the From clause
-- Factory and products
SELECT pt.factory, pt.product_name, ft.num_products
FROM   products pt
	   LEFT JOIN (SELECT factory, COUNT(*) AS num_products FROM products GROUP BY 1) AS ft
       ON pt.factory = ft.factory
ORDER BY factory;

  -- The number of products they produce
SELECT factory, COUNT(*) AS num_products FROM products
GROUP BY 1;

-- Any/ All
-- ANY
SELECT * FROM happiness_scores
WHERE happiness_score > 
	  ANY (SELECT ladder_score 
	       FROM   happiness_scores_current);

-- ALL
SELECT * FROM happiness_scores
WHERE happiness_score > 
	  ALL (SELECT ladder_score 
	       FROM   happiness_scores_current);
           
-- Exists
-- All countries happiness scores that exists in the inflation rate table
SELECT * 
FROM happiness_scores h
WHERE EXISTS (
	SELECT i.country_name
    FROM inflation_rates i
    WHERE i.country_name = h.country);
    
-- Assignment
-- Get unit price from Wicked_Choccy's
SELECT unit_price FROM products
WHERE factory = "Wicked Choccy's";

-- Products that are less than products from Wicked Choccy's
SELECT * FROM products 
WHERE unit_price <
	ALL (SELECT unit_price
         FROM products
         WHERE factory = "Wicked Choccy's");

-- SELECT * FROM products;
-- Assignment
WITH orders AS (
	SELECT order_id, SUM(units * unit_price) AS total_amount_spent
	FROM   orders o
		   LEFT JOIN products p
		   ON o.product_id = p.product_id
	GROUP BY 1
	HAVING total_amount_spent > 200
	ORDER BY total_amount_spent DESC
)
SELECT COUNT(*) FROM  orders;

-- Assignment
WITH Products_factory AS (
		SELECT *
		FROM   products pt),
     factory AS (
		SELECT factory, COUNT(*) AS num_products 
        FROM products 
        GROUP BY 1
	)
SELECT pt.factory, product_name, num_products FROM Products_factory pt
LEFT JOIN factory ft
ON pt.factory = ft.factory
ORDER BY pt.factory;

-- Day 2







    




