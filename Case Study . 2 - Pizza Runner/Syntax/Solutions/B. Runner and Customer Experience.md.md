
# 🍕 Case Study #2 - Pizza Runner
## B. Runner and Customer Experience

### Q1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

```sql 
select count(runner_id) as sign_up_runners 
     ,week(registration_date) as week_number
from pizza_runner.runners
where registration_date  >=  '2021-01-01'
group by week_number 
order by week_number ;
``` 
| sign_up_runners | week_number |
|-----------------|-------------|
|        2        |      1     |
|        4        |      1      |
|        2        |      2      |

## Q2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

```sql 
SELECT r.runner_id,
      avg(TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)) AS avg_runner_pickup_time       
FROM pizza_runner.runner_orders r
INNER JOIN pizza_runner.customer_orders  c
USING (order_id)
WHERE cancellation IS NULL
group by runner_id ;
``` 

| runner_id | avg_runner_pickup_time |
|-----------|------------------------|
| 1         | 21.0000                |
| 2         | 29.0000                |
| 3         | 10.0000                |

## Q3. Is there any relationship between the number of pizzas and how long the order takes to prepare?

```sql 
WITH order_count_cte AS
  (SELECT r.order_id,
      COUNT(order_id) AS pizzas_order_count,
      avg(TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)) AS pre_time       
FROM pizza_runner.runner_orders r
INNER JOIN pizza_runner.customer_orders  c
USING (order_id)
WHERE cancellation IS NULL
group by order_id) 

SELECT *
FROM order_count_cte ;
``` 
| order_id | pizzas_order_count | pre_time |
|----------|--------------------|----------|
| 3        | 2                  | 21.0000  |
| 4        | 3                  | 29.0000  |
| 5        | 1                  | 10.0000  |

- More pizzas, longer time to prepare.
- 2 pizzas took 6 minutes more to prepare, 3 pizza took 12 minutes more to prepare.
- On average, it took 6 * (number of pizzas - 1) minutes more to prepare the next pizza.

## Q4. What was the average distance travelled for each customer? 
```sql 
select c.customer_id , round(avg(r.distance))
from pizza_runner.customer_orders c
join pizza_runner.runner_orders r 
on c.order_id = r.order_id 
group by c.customer_id  ;
``` 
| customer_id | round(avg(r.distance)) |
|-------------|------------------------|
| 101         | 13                     |
| 102         | 17                     |
| 103         | 18                     |
| 104         | 10                     |
| 105         | 25                     |

## Q5. What was the difference between the longest and shortest delivery times for all orders? 

```sql 

SELECT 
    MAX(TIMESTAMPDIFF(MINUTE, pickup_time, delivery_time)) AS longest_delivery_time,
    MIN(TIMESTAMPDIFF(MINUTE, pickup_time, delivery_time)) AS shortest_delivery_time,
    MAX(TIMESTAMPDIFF(MINUTE, pickup_time, delivery_time)) - MIN(TIMESTAMPDIFF(MINUTE, pickup_time, delivery_time)) AS delivery_time_difference
FROM 
    (SELECT order_id,pickup_time,
		TIMESTAMPADD(MINUTE, CAST(duration AS UNSIGNED), pickup_time) AS delivery_time
        FROM pizza_runner.runner_orders
        WHERE cancellation IS NULL AND pickup_time IS NOT NULL AND duration IS NOT NULL
    ) AS valid_deliveries;
``` 
| longest_delivery_time | shortest_delivery_time | delivery_time_difference |
|------------------------|------------------------|--------------------------|
| 40                     | 15                     | 25                       |

## Q6. What was the average speed for each runner for each delivery and do you notice any trend for these values?

```sql
select runner_id ,
       distance as distance_km , 
       round(duration/60 ,2) as duration_hr , 
       round(distance*60/duration , 2) as average_speed
from pizza_runner.runner_orders
where cancellation is  null
order by runner_id ;
``` 

| runner_id | distance_km | duration_hr | average_speed |
|-----------|-------------|-------------|---------------|
| 1         | 13.4km      | 0.33        | 40.2          |
| 2         | 23.4        | 0.67        | 35.1          |
| 3         | 10          | 0.25        | 40            |

## Q7. What is the successful delivery percentage for each runner? 

```sql 
select runner_id , 
       count(pickup_time) as deliverd_orders ,
       count(*) as total_orders , 
       round(100* count(pickup_time) /count(*) )as delivery_success_percentage
from pizza_runner.runner_orders 
group by runner_id
order by runner_id;
``` 

| runner_id | deliverd_orders | total_orders | delivery_success_percentage |
|-----------|-----------------|--------------|-----------------------------|
| 1         | 4               | 4            | 100                         |
| 2         | 4               | 4            | 100                         |
| 3         | 2               | 2            | 100                         |

My Solution for [C.Ingredients optimization ] (https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.%202%20-%20Pizza%20Runner/Syntax/Solutions/C.Ingredients%20Optimization.md.md)
