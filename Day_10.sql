-- Null Functions
-- Create a contacts table
CREATE TABLE contacts (
    name VARCHAR(50),
    email VARCHAR(100),
    alt_email VARCHAR(100));

INSERT INTO contacts (name, email, alt_email) VALUES
	('Anna', 'anna@example.com', NULL),
	('Bob', NULL, 'bob.alt@example.com'),
	('Charlie', NULL, NULL),
	('David', 'david@example.com', 'david.alt@example.com');
    
-- Return null values
SELECT *
FROM contacts
WHERE email IS NOT NULL;

-- Return non-null with case statement
SELECT *,
		CASE WHEN email IS NOT NULL THEN email
             ELSE 'no email' END AS contact_em
FROM contacts;

-- Return null values using IF null
SELECT *,
		IFNULL(email, 'no email') AS contact_email
FROM contacts;

-- Return an alternative field using IF NULL
SELECT *,
		IFNULL(email, alt_email) AS contact_email
FROM contacts;

-- Return an alternative field after multiple checks 
SELECT *,
		IFNULL(email, 'no email') AS contact_email,
		IFNULL(email, alt_email) AS contact_email,
        COALESCE(email, alt_email, 'no_email') AS contact_email_coalesce
FROM contacts;


-- Assignment
SELECT product_name, factory, division,
       IFNULL(division, 'Other') AS division_other,
       IFNULL(division, (WITH top_division AS (
							SELECT division, COUNT(*) AS common_division
							FROM products
							GROUP BY 1
							ORDER BY division DESC
							LIMIT 1
							)
							SELECT division
							FROM top_division)) AS division_top
FROM products;

-- Top division
WITH top_division AS (
	SELECT division, COUNT(*) AS common_division
	FROM products
	GROUP BY 1
	ORDER BY division DESC
	LIMIT 1
)
SELECT division
FROM top_division;

-- Data Analysis Applications
CREATE TABLE employee_details (
    region VARCHAR(50),
    employee_name VARCHAR(50),
    salary INTEGER
);

INSERT INTO employee_details (region, employee_name, salary) VALUES
	('East', 'Ava', 85000),
	('East', 'Ava', 85000),
	('East', 'Bob', 72000),
	('East', 'Cat', 59000),
	('West', 'Cat', 63000),
	('West', 'Dan', 85000),
	('West', 'Eve', 72000),
	('West', 'Eve', 75000);

SELECT * 
FROM employee_details;

-- View duplicate employee
SELECT employee_name, COUNT(*) AS dup_count
FROM employee_details
GROUP BY employee_name
HAVING dup_count > 1;

-- View duplicate region + employee
SELECT region, employee_name, COUNT(*) AS dup_count
FROM employee_details
GROUP BY region, employee_name
HAVING dup_count > 1;

-- View fully duplicates
SELECT region, employee_name, salary ,COUNT(*) AS dup_count
FROM employee_details
GROUP BY region, employee_name, salary
HAVING dup_count > 1;

-- Exlude fully duplicates employees
SELECT DISTINCT region, employee_name, salary
FROM employee_details;

-- Exclude partial duplicates
SELECT * FROM (
	SELECT region, employee_name, salary,
		   ROW_NUMBER() OVER(PARTITION BY employee_name ORDER BY salary DESC) AS top_sal
	FROM employee_details
) AS ts
WHERE top_sal = 1;

-- Unique region + employee_name
SELECT * FROM (
	SELECT region, employee_name, salary,
		   ROW_NUMBER() OVER(PARTITION BY region, employee_name ORDER BY salary DESC) AS top_sal
	FROM employee_details
) AS ts
WHERE top_sal = 1;


-- Assignment
-- Fully duplicates
SELECT student_name, COUNT(*) AS dup
FROM students
GROUP BY 1
HAVING dup > 1;

-- Partial duplicates
SELECT id, student_name, email,
	   ROW_NUMBER() OVER(PARTITION BY student_name ORDER BY student_name) AS RN
FROM students;

SELECT * 
FROM students;

WITH de_dup AS (
	SELECT id, student_name, email,
		   ROW_NUMBER() OVER(PARTITION BY student_name ORDER BY id DESC) AS RN
	FROM students
)
SELECT id, student_name, email
FROM de_dup
WHERE RN = 1
