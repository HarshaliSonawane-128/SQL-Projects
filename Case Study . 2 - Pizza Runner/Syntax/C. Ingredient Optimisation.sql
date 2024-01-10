select * from pizza_runner.runners;
select * from pizza_runner.runner_orders;
select * from pizza_runner.pizza_toppings;
select * from pizza_runner.pizza_recipes ;
select * from pizza_runner.pizza_names;
select * from pizza_runner.customer_orders;


CREATE TEMPORARY TABLE row_split_pizza_recipes_temp AS
SELECT
    pizza_id,
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(toppings, ',', n.n), ',', -1) AS UNSIGNED) AS topping
FROM pizza_runner.pizza_recipes
JOIN  (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5  
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8) n
ON LENGTH(toppings) - LENGTH(REPLACE(toppings, ',', '')) >= n.n - 1;

select * from row_split_pizza_recipes_temp;


/* 1.What are the standard ingredients for  pizza?*/
CREATE TEMPORARY TABLE ingredients AS
select pizza_name , topping , topping_name 
from pizza_runner.pizza_names  n
join row_split_pizza_recipes_temp r
on n.pizza_id = r.pizza_id 
join pizza_runner.pizza_toppings t
on r.topping = t.topping_id ;

select * from ingredients;

/* 2.What are the standard ingredients for each pizza?*/

SELECT
    pizza_name,
    GROUP_CONCAT(topping_name ORDER BY topping) AS standard_ingredients
FROM  pizza_runner.pizza_names n
JOIN row_split_pizza_recipes_temp r
ON n.pizza_id = r.pizza_id
JOIN pizza_runner.pizza_toppings t 
ON r.topping = t.topping_id
GROUP BY pizza_name;


/* 3.What was the most commonly added extra?*/

ALTER TABLE pizza_runner.customer_orders
ADD COLUMN record_id INT AUTO_INCREMENT PRIMARY KEY;

select * from pizza_runner.customer_orders;

-- Create a new temporary table `order_toppingsBreak`
CREATE TEMPORARY TABLE extrasBreaks AS
SELECT record_id ,
    order_id,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(extras, ',', n.n), ',', -1)) AS extra_id
FROM pizza_runner.customer_orders
JOIN 
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) n
    ON LENGTH(extras) - LENGTH(REPLACE(extras, ',', '')) >= n.n - 1;

select * from extrasBreaks;

select  topping_name , count(*) as extra_count
from extrasBreaks  b
join pizza_runner.pizza_toppings t 
on b.extra_id = t.topping_id 
GROUP BY t.topping_name
ORDER BY COUNT(*) DESC;



/*4.What was the most common exclusion?*/
-- Create a new temporary table `order_exclusionexclusions`
CREATE TEMPORARY TABLE exclusionsBreaks  AS
SELECT 
  record_id ,
    order_id,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(exclusions, ',', n.n), ',', -1)) AS exclusions_id
FROM  pizza_runner.customer_orders
JOIN 
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) n
    ON LENGTH(exclusions) - LENGTH(REPLACE(exclusions, ',', '')) >= n.n - 1;

select * from exclusionsBreaks ;

select topping_name , count(*) as exclusion_count
from exclusionsBreaks   b
join pizza_runner.pizza_toppings t 
on b.exclusions_id = t.topping_id 
GROUP BY t.topping_name
ORDER BY COUNT(*) DESC;

