-- 1.
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
) AS players_rn;

-- 2.
WITH top_five AS(
	SELECT schoolID,COUNT(*) AS top_schools
	FROM schools
	GROUP BY 1
)
SELECT name_full FROM top_five tf
LEFT JOIN school_details sd 
ON tf.schoolID = sd.schoolID
ORDER BY top_schools DESC
LIMIT 5;

-- 3. 
WITH top_five AS(
	SELECT schoolID, yearID ,COUNT(*) AS top_schools
	FROM schools
	GROUP BY 1, 2
)
SELECT *,
	   ROW_NUMBER() OVER(ORDER BY top_schools DESC ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS RN
FROM top_five tf
LEFT JOIN school_details sd 
ON tf.schoolID = sd.schoolID
ORDER By yearID 
