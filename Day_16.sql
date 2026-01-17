SELECT yearID,
	   COUNT(playerID) OVER(ORDER BY yearID ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS num_of_players
FROM schools s
LEFT JOIN  school_details sd
ON s.playerID = s.playerID;
