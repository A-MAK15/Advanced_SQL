-- NTILE
SELECT * FROM (
	WITH base_table AS (
		SELECT customer_id, SUM(units * unit_price) AS total_spend FROM orders ord
		LEFT JOIN products pd
		ON ord.product_id = pd.product_id
		-- ORDER BY 1
		GROUP BY 1
	)
	SELECT *,
		NTILE(100) OVER(PARTITION BY customer_id ORDER BY total_spend) AS spend_pct
	FROM base_table
) AS spend_pct
WHERE spend_pct = 1;
