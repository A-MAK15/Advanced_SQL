-- 1.
-- 1. a)
SELECT * FROM (
	WITH top_20_per AS (
		SELECT *,
			AVG(salary) OVER(PARTITION BY teamID ORDER BY yearID) AS average_salary
		FROM salaries
	)
	SELECT DISTINCT yearID, teamID, average_salary FROM top_20_per
	ORDER BY average_salary DESC
) AS percent_20
LIMIT 172;


-- b
SELECT *,
	SUM(salary) OVER(PARTITION BY teamID ORDER BY yearID ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM salaries;SELECT COUNT(*) * 0.2 FROM (
	WITH top_20_per AS (
		SELECT *,
			AVG(salary) OVER(PARTITION BY teamID ORDER BY yearID) AS average_salary
		FROM salaries
	)
	SELECT DISTINCT yearID, teamID, average_salary FROM top_20_per
	ORDER BY average_salary DESC
) AS percent_20
LIMIT (SELECT COUNT(*) * 0.2 FROM percent_20);

-- c) 
WITH surpassed_bllion AS(
	SELECT *,
		SUM(salary) OVER(PARTITION BY teamID ORDER BY yearID ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS cumulative_spending
	FROM salaries
)
SELECT * FROM surpassed_bllion
WHERE cumulative_spending >= 1000000000

