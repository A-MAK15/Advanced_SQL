-- Moving Averages
SELECT country, year, happiness_score, 
	   AVG(happiness_score) OVER(PARTITION BY country ORDER BY year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS three_year_ma
FROM happiness_scores;
