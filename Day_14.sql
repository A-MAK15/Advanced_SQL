-- Assignment
WITH cummulated AS (
	SELECT *,
		  SUM(total_sales) OVER(PARTITION BY yr ORDER BY mnth) AS cumulative_sum
	FROM (
		WITH total_sale AS (
			SELECT ord.product_id, (units * unit_price) AS order_price, MONTH(order_date) AS mnth, YEAR(order_date) AS yr FROM orders ord
			LEFT JOIN products prd
			ON ord.product_id = prd.product_id
		)
		SELECT yr, mnth, SUM(order_price) AS total_sales
		FROM total_sale
		GROUP BY yr, mnth
	) AS cumulative
)
SELECT *,
	   AVG(total_sales) OVER (PARTITION BY yr ORDER BY mnth ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS six_month_ma
FROM cummulated
