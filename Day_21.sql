-- Corrections 
-- a) 
SELECT * FROM (
	WITH summed_salary AS (
		SELECT yearID, teamID, SUM(salary) as summed_salary
		FROM salaries
		GROUP BY 1, 2
		ORDER BY teamID
	)
	SELECT teamID, AVG(summed_salary) AS average,
		NTILE(5) OVER(ORDER BY AVG(summed_salary) DESC) AS RN
	FROM summed_salary
	GROUP BY 1
	ORDER BY teamID
) AS top_20
WHERE RN = 1;


-- b)
WITH sum_salary AS (
	SELECT teamID, yearID, SUM(salary) AS total_spend
	FROM salaries
	GROUP BY 1, 2
)
SELECT teamID, yearID,
	SUM(total_spend) OVER(PARTITION BY teamID ORDER BY yearID) AS cumulative_sum
FROM sum_salary;


-- c) 
WITH ranked AS (
	SELECT * ,
		ROW_NUMBER() OVER(PARTITION BY teamID ORDER BY cumulative_sum) AS rn
	FROM (
		WITH sum_salary AS (
			SELECT teamID, yearID, SUM(salary) AS total_spend
			FROM salaries
			GROUP BY 1, 2
		)
		SELECT teamID, yearID,
			SUM(total_spend) OVER(PARTITION BY teamID ORDER BY yearID) AS cumulative_sum
		FROM sum_salary
	) AS cum_sum
	WHERE cumulative_sum > 1000000000
)
SELECT * FROM ranked
WHERE rn = 1
