-- Desceription contains that contains 'family' within it
SELECT *
FROM my_events
WHERE event_desc LIKE '%family%';

-- Description that starts with 'A'
SELECT *
FROM my_events
WHERE event_desc LIKE 'A%';

-- Retiurns letter with three firt anme
SELECT *
FROM students
WHERE student_name LIKE '___ %'; -- the space after the underscores is important

-- Return any record with celebration word in the sentence
SELECT event_desc,
       REGEXP_SUBSTR(event_desc, 'celebration|holiday|festival') AS celebration_word
FROM my_events
WHERE event_desc LIKE '%celebration%'
				OR event_desc LIKE '%festival%'
				OR event_desc LIKE '%holiday%';
                
-- Return words wkth hyphen in them
SELECT event_desc,
	   REGEXP_SUBSTR(event_desc, '[A-Z][a-z]+(-[A-Za-z]+)+') AS hyphen_phrase
FROM my_events;

-- Assignment
WITH new_product_naming AS (
	SELECT product_name,
		   -- EPLACE(product_name, '', ' ')
		   REPLACE(product_name, REGEXP_SUBSTR(product_name, 'Wonka Bar -'), '') AS Wonka_Bar
	FROM products
)
SELECT product_name,
	   CASE WHEN Wonka_Bar IS NULL THEN product_name
	   ELSE Wonka_Bar END AS new_product_name
FROM new_product_naming
