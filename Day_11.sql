-- Min/Max filtering
CREATE TABLE sales (
    id INT PRIMARY KEY,
    sales_rep VARCHAR(50),
    date DATE,
    sales INT
);

INSERT INTO sales (id, sales_rep, date, sales) VALUES 
    (1, 'Emma', '2024-08-01', 6),
    (2, 'Emma', '2024-08-02', 17),
    (3, 'Jack', '2024-08-02', 14),
    (4, 'Emma', '2024-08-04', 20),
    (5, 'Jack', '2024-08-05', 5),
    (6, 'Emma', '2024-08-07', 1);


SELECT * 
FROM sales;


-- Goal: Return the most recent sales amount for each sales rep

-- Return the most recent sales date for each sales rep
SELECT sales_rep, MAX(date) AS most_recent_date
FROM sales
GROUP BY 1;

-- Return the most recent sales date for each sales rep + attempt to add on the sales
SELECT sales_rep, MAX(sales) ,MAX(date) AS most_recent_date
FROM sales
GROUP BY 1;

-- Group by approach
WITH rd AS (
	SELECT sales_rep, MAX(date) AS most_recent_date
	FROM sales
	GROUP BY 1
)
SELECT * FROM rd
LEFT JOIN sales s
ON rd.sales_rep = s.sales_rep
AND rd.most_recent_date = s.date;

-- Window function approach
WITH latest AS (
	SELECT sales_rep, date, sales,
		   ROW_NUMBER() OVER(PARTITION BY sales_rep ORDER BY date DESC) AS row_num
	FROM sales
)
SELECT * 
FROM latest
WHERE row_num = 1;

-- Assignment
SELECT *
      -- OVER(PARTITION BY student_name ORDER BY 
FROM students;

WITH grade_ranking AS (
	SELECT id, student_name, final_grade,
		 DENSE_RANK() OVER (PARTITION BY student_name ORDER BY final_grade DESC) AS row_top_grade,
		 class_name
	FROM student_grades sg
	LEFT JOIN students s
	ON sg.student_id = s.id
)
SELECT * 
FROM grade_ranking
WHERE row_top_grade = 1
