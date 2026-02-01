-- Player Analysis
SELECT * FROM players;

-- a) Age Debut
SELECT *, TIMESTAMPDIFF(YEAR, birthDate_converted, debut) AS years
FROM (
	WITH to_date AS (
		SELECT *, CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS birthDate
		FROM players
	)
	SELECT *, CAST(birthDate AS DATE) AS birthDate_converted
	FROM to_date
) AS date_concate;
