-- 1.Corrections
SELECT ROUND(yearID, -1) AS decade, COUNT(DISTINCT schoolID) AS num_schools
FROM schools
GROUP BY decade
ORDER BY decade;
