--a) Same birthday
WITH same_birth_day AS (
	SELECT *, TIMESTAMPDIFF(YEAR, birthDate_converted, debut) AS years
	FROM (
		WITH to_date AS (
			SELECT *, CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS birthDate
			FROM players
		)
		SELECT *, CAST(birthDate AS DATE) AS birthDate_converted
		FROM to_date
	) AS date_concate
)
-- SELECT * FROM same_birth_day
SELECT birthDate_converted, GROUP_CONCAT(nameGiven SEPARATOR ', ')
FROM same_birth_day
WHERE birthDate_converted IS NOT NULL and YEAR (birthDate_converted) BETWEEN 1980 AND 1990
GROUP BY birthDate_converted
HAVING COUNT(nameGiven) > 2
ORDER BY birthDate_converted 
