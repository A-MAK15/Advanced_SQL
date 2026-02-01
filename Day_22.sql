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

------------------------------------------------------------------------------------------------------------------------------------------------------------
--b)
SELECT *, TIMESTAMPDIFF(YEAR, birthDate_converted, debut) AS years_debut ,TIMESTAMPDIFF(YEAR, birthDate_converted, finalGame) AS years_final_game
FROM (
	WITH to_date AS (
		SELECT *, CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS birthDate
		FROM players
	)
	SELECT *, CAST(birthDate AS DATE) AS birthDate_converted
	FROM to_date
) AS date_concate;


-- c)
WITH career AS (
	SELECT *, TIMESTAMPDIFF(YEAR, birthDate_converted, debut) AS years_debut ,TIMESTAMPDIFF(YEAR, birthDate_converted, finalGame) AS years_final_game
	FROM (
		WITH to_date AS (
			SELECT *, CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS birthDate
			FROM players
		)
		SELECT *, CAST(birthDate AS DATE) AS birthDate_converted
		FROM to_date
	) AS date_concate
)
SELECT *, years_final_game - years_debut AS career_length
FROM career
ORDER BY years_final_game - years_debut DESC

