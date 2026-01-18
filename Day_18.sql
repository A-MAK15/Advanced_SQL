SELECT *,
	SUM(decade_rn) OVER(ORDER BY yearID ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS decade_sum
FROM (
	WITH players AS (
		SELECT DISTINCT playerID, schoolID, yearID,
			ROW_NUMBER() OVER(PARTITION BY playerID ORDER BY yearID) AS RN
		FROM schools
	)
	SELECT *,
		ROW_NUMBER() OVER(ORDER BY yearID) AS decade_rn
	FROM players
) AS players_rn
