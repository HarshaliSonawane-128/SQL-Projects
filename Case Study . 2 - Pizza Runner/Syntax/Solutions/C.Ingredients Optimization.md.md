
# 🍕 Case Study #2 - Pizza Runner

## C. Ingredient Optimisation

###Data cleaning
#### 1. Create a new temporary table #row_split_pizza_recipes_temp to separate toppings into multiple rows

```sql 

CREATE TEMPORARY TABLE row_split_pizza_recipes_temp AS
SELECT
    pizza_id,
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(toppings, ',', n.n), ',', -1) AS UNSIGNED) AS topping
FROM pizza_runner.pizza_recipes
JOIN  (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5  
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8) n
ON LENGTH(toppings) - LENGTH(REPLACE(toppings, ',', '')) >= n.n - 1;

```
```sql 
select * from row_split_pizza_recipes_temp;
``` 

| pizza_id | topping |
|----------|---------|
| 3        | 1       |
| 3        | 1       |
| 2        | 4       |
| 1        | 1       |
| 3        | 2       |
| 3        | 2       |
| 2        | 6       |
| 1        | 2       |
| 3        | 3       |
| 3        | 3       |
| 2        | 7       |
| 1        | 3       |
| 3        | 4       |
| 3        | 4       |
| 2        | 9       |
| 1        | 4       |
| 3        | 5       |
| 3        | 5       |
| 2        | 11      |
| 1        | 5       |
| 3        | 6       |
| 3        | 6       |
| 2        | 12      |
| 1        | 6       |
| 3        | 7       |
| 3        | 7       |
| 1        | 8       |
| 3        | 8       |
| 3        | 8       |
| 1        | 10      |


### 2.What are the standard ingredients for  pizza?
```sql 
SELECT
    pizza_name,
    GROUP_CONCAT(topping_name ORDER BY topping) AS standard_ingredients
FROM  pizza_runner.pizza_names n
JOIN row_split_pizza_recipes_temp r
ON n.pizza_id = r.pizza_id
JOIN pizza_runner.pizza_toppings t 
ON r.topping = t.topping_id
GROUP BY pizza_name;
```
| pizza_name | standard_ingredients                                                                                             |
|------------|--------------------------------------------------------------------------------------------------------|
| Meatlovers | Bacon, BBQ Sauce, Beef, Cheese, Chicken, Mushrooms, Pepperoni, Salami                                   |
| Supreme    | Bacon, BBQ Sauce, Beef, Cheese, Chicken, Mushrooms, Onions, Pepperoni                                     |
| Vegetarian | Cheese, Mushrooms, Onions, Peppers, Tomatoes, Tomato Sauce                                               |

###  3.What was the most commonly added extra? 

```sql 
ALTER TABLE pizza_runner.customer_orders
ADD COLUMN record_id INT AUTO_INCREMENT PRIMARY KEY;
``` 
```sql
select * from pizza_runner.customer_orders;
``` 

| order_id | customer_id | pizza_id | exclusions | extras   | order_time            | record_id |
|----------|-------------|----------|------------|----------|-----------------------|-----------|
| 1        | 101         | 1        |            |          | 2020-01-01 18:05:02   | 1         |
| 2        | 101         | 1        |            |          | 2020-01-01 19:00:52   | 2         |
| 3        | 102         | 1        |            |          | 2020-01-02 23:51:23   | 3         |
| 3        | 102         | 2        |            |          | 2020-01-02 23:51:23   | 4         |
| 4        | 103         | 1        | 4          |          | 2020-01-04 13:23:46   | 5         |
| 4        | 103         | 1        | 4          |          | 2020-01-04 13:23:46   | 6         |
| 4        | 103         | 2        | 4          |          | 2020-01-04 13:23:46   | 7         |
| 5        | 104         | 1        |            | 1        | 2020-01-08 21:00:29   | 8         |
| 6        | 101         | 2        |            |          | 2020-01-08 21:03:13   | 9         |
| 7        | 105         | 2        |            | 1        | 2020-01-08 21:20:29   | 10        |
| 8        | 102         | 1        |            |          | 2020-01-09 23:54:33   | 11        |
| 9        | 103         | 1        | 4          | 1, 5     | 2020-01-10 11:22:59   | 12        |
| 10       | 104         | 1        |            |          | 2020-01-11 18:34:49   | 13        |
| 10       | 104         | 1        | 2, 6       | 1, 4     | 2020-01-11 18:34:49   | 14        |

- Create a new temporary table `order_toppingsBreak` 

```sql 
CREATE TEMPORARY TABLE extrasBreaks AS
SELECT record_id ,
    order_id,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(extras, ',', n.n), ',', -1)) AS extra_id
FROM pizza_runner.customer_orders
JOIN 
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) n
    ON LENGTH(extras) - LENGTH(REPLACE(extras, ',', '')) >= n.n - 1;
``` 

```sql 
select * from extrasBreaks;
``` 
| record_id | order_id | extra_id |
|-----------|----------|----------|
| 1         | 1        |          |
| 2         | 2        |          |
| 3         | 3        |          |
| 5         | 4        |          |
| 6         | 4        |          |
| 7         | 4        |          |
| 8         | 5        | 1        |
| 9         | 6        | null     |
| 10        | 7        | 1        |
| 11        | 8        | null     |
| 12        | 9        | 5        |
| 12        | 9        | 1        


* The most commonly added extra

```sql
select topping_name , count(*) as exclusion_count
from exclusionsBreaks   b
join pizza_runner.pizza_toppings t 
on b.exclusions_id = t.topping_id 
GROUP BY t.topping_name
ORDER BY COUNT(*) DESC;
``` 
| topping_name | extra_count |
|--------------|-------------|
| Bacon        | 4           |
| Chicken      | 1           |
| Cheese       | 1           |



## 4.What was the most common exclusion?
 - Create a new temporary table `order_exclusionexclusions`

```SQL 
CREATE TEMPORARY TABLE exclusionsBreaks  AS
SELECT 
  record_id ,
    order_id,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(exclusions, ',', n.n), ',', -1)) AS exclusions_id
FROM  pizza_runner.customer_orders
JOIN 
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) n
    ON LENGTH(exclusions) - LENGTH(REPLACE(exclusions, ',', '')) >= n.n - 1;
``` 
```SQL
select * from exclusionsBreaks ;
``` 
| record_id | order_id | exclusions_id |
|-----------|----------|---------------|
| 1         | 1        |               |
| 2         | 2        |               |
| 3         | 3        |               |
| 4         | 3        |               |
| 5         | 4        | 4             |
| 6         | 4        | 4             |
| 7         | 4        | 4             |
| 8         | 5        | null          |
| 9         | 6        | null          |
| 10        | 7        | null          |
| 11        | 8        | null          |
| 12        | 9        | 4             |
| 13        | 10       | null          |
| 14        | 10       | 6             |
| 14        | 10       | 2             |

-  The most common exclusion
```sql 
select topping_name , count(*) as exclusion_count
from exclusionsBreaks  b
join pizza_runner.pizza_toppings t 
on b.exclusions_id = t.topping_id 
GROUP BY t.topping_name
ORDER BY COUNT(*) DESC;
``` 
| topping_name | exclusion_count |
|--------------|------------------|
| Cheese       | 4                |
| Mushrooms    | 1                |
| BBQ Sauce    | 1                |

My Solution for [D,Price and Ratings ](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.%202%20-%20Pizza%20Runner/Syntax/Solutions/D.%20Pricing%20and%20Ratings.md.md)
