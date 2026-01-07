-- CAST AND CONVERT
CREATE TABLE sample_table (
    id INT,
    str_value CHAR(50)
);

INSERT INTO sample_table (id, str_value) VALUES
	(1, '100.2'),
	(2, '200.4'),
	(3, '300.6');

SELECT id, str_value*2
FROM sample_table;

-- casting example
SELECT id, CAST(str_value AS FLOAT)*2
FROM sample_table;

-- Assignment
SELECT total_spend_bin, COUNT(customer_id) AS num_customers
FROM (
	SELECT o.customer_id, SUM(units * unit_price) AS total_spent,
    FLOOR(SUM(units * unit_price) / 10) * 10  AS total_spend_bin
    FROM orders o
	LEFT JOIN products p
	ON o.product_id = p.product_id
    GROUP BY 1
) AS bin
GROUP BY 1;

-- Datetime functions
SELECT CURRENT_DATE(), CURRENT_TIMESTAMP();

CREATE TABLE my_events (
    event_name VARCHAR(50),
    event_date DATE,
    event_datetime DATETIME,
    event_type VARCHAR(20),
    event_desc TEXT);

INSERT INTO my_events (event_name, event_date, event_datetime, event_type, event_desc) VALUES
('New Year\'s Day', '2025-01-01', '2025-01-01 00:00:00', 'Holiday', 'A global celebration to mark the beginning of the New Year. Festivities often include fireworks, parties, and various cultural traditions as people reflect on the past year and set resolutions for the upcoming one.'),
('Lunar New Year', '2025-01-29', '2025-01-29 10:00:00', 'Holiday', 'A significant cultural event in many Asian countries, the Lunar New Year, also known as the Spring Festival, involves family reunions, feasts, and various rituals to welcome good fortune and happiness for the year ahead.'),
('Persian New Year', '2025-03-20', '2025-03-20 12:00:00', 'Holiday', 'Known as Nowruz, this celebration marks the first day of spring and the beginning of the year in the Persian calendar. It is a time for family gatherings, traditional foods, and cultural rituals to symbolize renewal and rebirth.'),
('Birthday', '2025-05-13', '2025-05-13 18:00:00', ' Personal!', 'A personal celebration marking the anniversary of one\'s birth. This special day often involves gatherings with family and friends, cake, gifts, and reflecting on personal growth and achievements over the past year.'),
('Last Day of School', '2025-06-12', '2025-06-12 15:30:00', ' Personal!', 'The final day of the academic year, celebrated by students and teachers alike. It often includes parties, awards, and a sense of excitement for the upcoming summer break, marking the end of a year of hard work and learning.'),
('Vacation', '2025-08-01', '2025-08-01 08:00:00', ' Personal!', 'A much-anticipated break from daily routines, this vacation period allows individuals and families to relax, travel, and create memories. It is a time for adventure and exploration, often enjoyed with loved ones.'),
('First Day of School', '2025-08-18', '2025-08-18 08:30:00', ' Personal!', 'An exciting and sometimes nerve-wracking day for students, marking the beginning of a new academic year. This day typically involves meeting new teachers, reconnecting with friends, and setting goals for the year ahead.'),
('Halloween', '2025-10-31', '2025-10-31 18:00:00', 'Holiday', 'A festive occasion celebrated with costumes, trick-or-treating, and various spooky activities. Halloween is a time for fun and creativity, where people of all ages dress up and participate in themed events, parties, and community gatherings.'),
('Thanksgiving', '2025-11-27', '2025-11-27 12:00:00', 'Holiday', 'A holiday rooted in gratitude and family, Thanksgiving is celebrated with a large feast that typically includes turkey, stuffing, and various side dishes. It is a time to reflect on the blessings of the year and spend quality time with loved ones.'),
('Christmas', '2025-12-25', '2025-12-25 09:00:00', 'Holiday', 'A major holiday celebrated around the world, Christmas commemorates the birth of Jesus Christ. It is marked by traditions such as gift-giving, festive decorations, and family gatherings, creating a warm and joyous atmosphere during the holiday season.');

WITH dow AS (
	SELECT event_name, event_date, event_datetime,
		   YEAR(event_date) AS event_year,
		   MONTH(event_date) AS event_month,
		   DAYOFWEEK(event_date) AS event_dow
	FROM my_events
)
SELECT	*, CASE WHEN event_dow = 1 THEN 'Sunday'
				WHEN event_dow = 2 THEN 'Monday'
				WHEN event_dow = 3 THEN 'Tuesday'
				WHEN event_dow = 4 THEN 'Wednesday'
				WHEN event_dow = 5 THEN 'Thursday'
				WHEN event_dow = 6 THEN 'Friday'
				WHEN event_dow = 7 THEN 'Saturday'
				ELSE 'Unknown' END AS event_dow_name
FROM	dow;

-- calculate interval
SELECT	event_name, event_date, event_datetime, CURRENT_DATE(),
		DATEDIFF(event_date, CURRENT_DATE()) AS days_until
FROM	my_events;

-- Add / subtract an interval from a datetime value
SELECT	event_name, event_date, event_datetime,
		DATE_ADD(event_datetime, INTERVAL 1 MINUTE) AS plus_one_hour
FROM	my_events;


WITH pm AS (
	SELECT country, population,
		   FLOOR(population / 1000000) AS pop_m
	FROM country_stats
)
SELECT pop_m, COUNT(country) AS num_countries
FROM pm
GROUP BY pop_m
ORDER BY pop_m;
