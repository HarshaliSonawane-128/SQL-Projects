# 🍕 Case Study #2 - Pizza Runner

## A. Pizza Metrics 

### Q1. How many pizzas were ordered? 

```SQL 
select count(*) as total_pizza_order 
from pizza_runner.customer_orders ;
``` 
|	total_pizza_order|
|----|
|	14|

## Q.2. How many unique customer orders were made?

```SQL 
select count(distinct order_id ) as unique_order_count
from pizza_runner.customer_orders;
``` 
|unique_order_count|
|---|
|10|

## Q3. How many successful orders were delivered by each runner?

```SQL 
select runner_id , count(order_id) 
from pizza_runner.runner_orders 
group by runner_id ;
``` 
| runner_id | count(order_id) |
|-----------|------------------|
| 1         | 4                |
| 2         | 4                |
| 3         | 2                |


## Q4. How many successful orders were delivered by each runner?

```SQL 
SELECT 
  p.pizza_name,
  COUNT(*) AS deliver_count
FROM pizza_runner.customer_orders c
JOIN pizza_runner.pizza_names p
ON c.pizza_id = p.pizza_id
JOIN pizza_runner.runner_orders r 
  ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY p.pizza_name;

``` 
| pizza_name   | deliver_count |
|--------------|---------------|
| Meatlovers   | 4             |
| Vegetarian   | 2             |



## Q5. How many Vegetarian and Meatlovers were ordered by each customer?

```SQL 
select  c.customer_id , p.pizza_name , count(c.order_id )as total_order
from pizza_runner.customer_orders  c
join pizza_runner.pizza_names   p 
on c.pizza_id = p.pizza_id 
group by c.customer_id , p.pizza_name;
```
| customer_id | Meatlovers | Vegetarian |
|-------------|------------|------------|
| 101         | 2          | 1          |
| 102         | 2          | 1          |
| 103         | 3          | 1          |
| 104         | 3          | 0          |
| 105         | 0          | 1          |

## Q6. What was the maximum number of pizzas delivered in a single order?

```sql 
SELECT MAX(pizza_count) AS max_count
FROM (
  SELECT 
    c.order_id,
    COUNT(c.pizza_id) AS pizza_count
 FROM pizza_runner.customer_orders c
JOIN pizza_runner.runner_orders r 
  ON c.order_id = r.order_id
  WHERE r.cancellation IS NULL
  GROUP BY c.order_id
) tmp;
``` 

|	max_count|
|---|
|	3|

## Q7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

```sql 
SELECT 
  c.customer_id,
  SUM(CASE WHEN exclusions != '' OR extras != '' THEN 1 ELSE 0 END) AS has_change,
  SUM(CASE WHEN exclusions = '' AND extras = '' THEN 1 ELSE 0 END) AS no_change
FROM pizza_runner.customer_orders c
JOIN pizza_runner.runner_orders r 
ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY c.customer_id;

``` 
| customer_id | has_change | no_change |
|-------------|------------|-----------|
| 102         | 0          | 1         |
| 103         | 3          | 0         |
| 104         | 1          | 0         |
| 105         | 1          | 0         |

## Q8. How many pizzas were delivered that had both exclusions and extras? 

```sql 
select 
sum(case when exclusions is not null and extras is not null then 1 else 0 
    end ) as pizza_count_w_exclusions_extras
from pizza_runner.customer_orders  c 
join pizza_runner.runner_orders  r 
on c.order_id = r.order_id 
where r.distance >= 1 
and c.exclusions <> ' ' and c.extras <> ' ' ;
``` 
| pizza_count_w_exclusions_extras |
| ------------------------------- |
| 11                              |

## Q9. What was the total volume of pizzas ordered for each hour of the day?

```sql 
select hour(order_time) as each_hour_order ,
count(order_id) as total_pizza_orderd 
from pizza_runner.customer_orders 
group by each_hour_order
order by each_hour_order;
``` 
| each_hour_order | total_pizza_ordered |
|------------------|---------------------|
| 11               | 1                   |
| 13               | 3                   |
| 18               | 3                   |
| 19               | 1                   |
| 21               | 3                   |
| 23               | 3                   |

## Q10. What was the volume of orders for each day of the week? 

```sql 
select
    DAYNAME(order_time) AS day_of_week,
    COUNT(order_id) AS total_pizza_ordered
FROM
    pizza_runner.customer_orders
GROUP BY
    day_of_week;
``` 
| day_of_week | total_pizza_ordered |
|-------------|---------------------|
| Wednesday   | 5                   |
| Thursday    | 3                   |
| Saturday    | 5                   |
| Friday      | 1                   |


My solution for[ B.Runner and Customer Experience.](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.%202%20-%20Pizza%20Runner/Syntax/Solutions/B.%20Runner%20and%20Customer%20Experience.md.md)
