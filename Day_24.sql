-- b) Just numbers
WITH base_table AS (
	SELECT teamID, bats FROM players p
	LEFT JOIN salaries s
	ON p.playerID = s.playerID
	WHERE bats IS NOT NULL
),
rightbat AS (
	SELECT teamID, COUNT(*) AS bat_right FROM base_table
	WHERE bats = 'R'
    AND teamID IS NOT NULL
	GROUP BY 1
),
leftbat AS (
	SELECT teamID, COUNT(*) AS bat_left FROM base_table
	WHERE bats = 'L'
    AND teamID IS NOT NULL
	GROUP BY 1
),
bat_both AS (
	SELECT teamID, COUNT(*) AS bat_both FROM base_table
	WHERE bats = 'B'
    AND teamID IS NOT NULL
	GROUP BY 1
)
SELECT bb.teamID, bat_both, bat_left, bat_right FROM bat_both bb
LEFT JOIN leftbat lb
ON bb.teamID = lb.teamID
LEFT JOIN rightbat rb
ON lb.teamID = rb.teamID
ORDER BY bb.teamID


-- c)
