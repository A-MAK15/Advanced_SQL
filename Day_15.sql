-- Final Projects
-- New tables players, salaries, schools, school_details;
SELECT * FROM players;

SELECT * FROM schools;

SELECT * FROM school_details;

SELECT * FROM salaries;

SELECT DISTINCT(yearID) FROM schools s
LEFT JOIN  school_details sd
ON s.playerID = s.playerID
