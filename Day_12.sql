-- Pivoting
CREATE TABLE pizza_table (
    category VARCHAR(50),
    crust_type VARCHAR(50),
    pizza_name VARCHAR(100),
    price DECIMAL(5, 2)
);

INSERT INTO pizza_table (category, crust_type, pizza_name, price) VALUES
    ('Chicken', 'Gluten-Free Crust', 'California Chicken', 21.75),
    ('Chicken', 'Thin Crust', 'Chicken Pesto', 20.75),
    ('Classic', 'Standard Crust', 'Greek', 21.50),
    ('Classic', 'Standard Crust', 'Hawaiian', 19.50),
    ('Classic', 'Standard Crust', 'Pepperoni', 18.75),
    ('Supreme', 'Standard Crust', 'Spicy Italian', 22.75),
    ('Veggie', 'Thin Crust', 'Five Cheese', 18.50),
    ('Veggie', 'Thin Crust', 'Margherita', 19.50),
    ('Veggie', 'Gluten-Free Crust', 'Garden Delight', 21.50);

SELECT category,
		SUM(CASE WHEN crust_type = 'Standard Crust' THEN 1 ELSE 0 END) AS standard_crust,
        SUm(CASE WHEN crust_type = 'Gluten-Free Crust' THEN 1 ELSE 0 END) AS gluten_free_crust,
        SUM(CASE WHEN crust_type = 'Thin Crust' THEN 1 ELSE 0 END) AS thin_crust
FROM pizza_table
GROUP BY category;


-- Assignment
SELECT department,
       ROUND(AVG(CASE WHEN grade_level = 9 THEN final_grade END)) AS freshman,
       ROUND(AVG(CASE WHEN grade_level = 10 THEN final_grade END)) AS sophormore,
       ROUND(AVG(CASE WHEN grade_level = 11 THEN final_grade END)) AS junior,
       ROUND(AVG(CASE WHEN grade_level = 12 THEN final_grade END)) AS senior
FROM student_grades sg
LEFT JOIN students s
ON sg.student_id = s.id
GROUP BY department;
