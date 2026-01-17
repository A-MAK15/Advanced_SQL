-- 2.
WITH top_five AS(
	SELECT schoolID, COUNT(*) AS top_schools
	FROM schools
	GROUP BY 1
)
SELECT * FROM top_five tf
LEFT JOIN school_details sd 
ON tf.schoolID = sd.schoolID
ORDER BY top_schools DESC
LIMIT 5
