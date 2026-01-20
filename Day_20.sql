-- 1.
SELECT COUNT(*) * 0.2 FROM (
	WITH top_20_per AS (
		SELECT *,
			AVG(salary) OVER(PARTITION BY teamID ORDER BY yearID) AS average_salary
		FROM salaries
	)
	SELECT DISTINCT yearID, teamID, average_salary FROM top_20_per
	ORDER BY average_salary DESC
) AS percent_20
LIMIT (SELECT COUNT(*) * 0.2 FROM percent_20);

