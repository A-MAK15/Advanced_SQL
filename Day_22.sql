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

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.a)
-- Team on starting and ending
-- WITH base_starting AS ;
WITH team_start AS (
	SELECT * FROM (
		SELECT p.playerID, nameGiven, debut, teamID AS team_start,
			ROW_NUMBER() OVER(PARTITION BY p.playerID ORDER BY debut ASC) AS RN
		FROM players p
		LEFT JOIN salaries s
		ON p.playerID = s.playerID
	) AS team_started_with
)
SELECT *
FROM team_start
WHERE RN = 1;
