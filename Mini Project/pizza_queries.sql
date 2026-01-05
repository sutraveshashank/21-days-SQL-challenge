-- 2. List all unique pizza categories
SELECT DISTINCT category
FROM pizza_types;

-- 3. Display pizza_type_id, name, and ingredients, replacing NULL ingredients with "Missing Data". 
-- Show first 5 rows.

SELECT pizza_type_id, `name`, 
		COALESCE(ingredients, "Missing Data") AS ingredients
FROM pizza_types
LIMIT 5;

-- 4. Check for pizzas missing a price
SELECT * FROM pizzas
WHERE price IS NULL;

-- 5. Orders placed on '2015-01-01'
SELECT * 
FROM orders
WHERE `date` = "2015-01-01";

-- 6. List pizzas with price descending.
SELECT `name`, size, price 
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
ORDER BY price DESC;

-- 7. Pizzas sold in sizes 'L' or 'XL'.
SELECT `name`, size, price 
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
WHERE size IN ('L', 'XL');

-- 8. Pizzas priced between $15.00 and $17.00.
SELECT `name`, size, price 
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
WHERE price BETWEEN 15.00 AND 17.00;

-- 9. Pizzas with "Chicken" in the name.
SELECT `name`
FROM pizza_types
WHERE `name` LIKE "%Chicken%";

-- 10. Orders on '2015-02-15' or placed after 8 PM.
SELECT o.order_id, o.`date`, o.`time`, od.quantity ,p.size, p.price, `name`
FROM orders o
LEFT JOIN order_details od
ON o.order_id = od.order_id
LEFT JOIN pizzas p
ON od.pizza_id = p.pizza_id
LEFT JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
WHERE `date` = "2015-02-15" OR hour(`time`) > 20;

-- 11. Total quantity of pizzas sold
SELECT SUM(quantity) AS total_quantity
FROM order_details;

-- 12. Average pizza price
SELECT ROUND(AVG(price),2) AS avg_price
FROM pizzas;

-- 13.Total order value per order
SELECT 
    od.order_id,
    SUM(od.quantity * p.price) AS total_order_value
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
GROUP BY od.order_id
ORDER BY od.order_id;


-- Total quantity sold per pizza category 
SELECT category, SUM(quantity) AS Total_Quantity
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od
ON p.pizza_id = od.pizza_id
GROUP BY category;

-- Categories with more than 5,000 pizzas sold 
SELECT category, SUM(quantity) AS Total_Quantity
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od
ON p.pizza_id = od.pizza_id
GROUP BY category
HAVING Total_Quantity > 5000;


-- Pizzas never ordered
SELECT pt.`name`, pt.category, quantity
FROM pizzas p
LEFT JOIN  order_details od
ON p.pizza_id = od.pizza_id
LEFT JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
WHERE order_id IS NULL;

-- Price differences between different sizes of the same pizza (SELF JOIN).
SELECT pt.`name`, 
		(p2.price - p1.price) AS s_m_diff,
        (p3.price - p2.price) AS m_l_diff,
        (p4.price - p3.price) AS l_xl_diff,
        (p5.price - p4.price) AS xl_xxl_diff
from pizza_types pt
left JOIN pizzas p1
ON pt.pizza_type_id = p1.pizza_type_id  AND p1.size = "S"
left JOIN pizzas p2
ON pt.pizza_type_id = p2.pizza_type_id  AND p2.size = "M"
left JOIN pizzas p3
ON pt.pizza_type_id = p3.pizza_type_id  AND p3.size = "L"
left JOIN pizzas p4
ON pt.pizza_type_id = p4.pizza_type_id  AND p4.size = "XL"
left JOIN pizzas p5
ON pt.pizza_type_id = p5.pizza_type_id  AND p5.size = "XXL"; 

