
# 🍕 Case Study #2 - Pizza Runner
## D. Pricing and Ratings
### Q1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?

```sql 
select 
CONCAT('$',sum( case when pizza_name = 'Meatlovers' then 12 else 10 end )) as earned_money
from pizza_runner.customer_orders c
join pizza_runner.pizza_names p 
on c.pizza_id = p.pizza_id 
join pizza_runner.runner_orders r
on c.order_id = r.order_id 
where r.cancellation is null ;
```
|earned_money|
|$68|

### Q2. What if there was an additional $1 charge for any pizza extras? 

```sql
select 
CONCAT('$',sum( case when pizza_name = 'Meatlovers' and extras is not null then 12 else 10  end )+ 1) as add_charges
from pizza_runner.customer_orders c
join pizza_runner.pizza_names p 
on c.pizza_id = p.pizza_id 
join pizza_runner.runner_orders r
on c.order_id = r.order_id 
where r.cancellation is null ;
```

|add_charges|
|---|
|$69|

### Q3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.

```sql 
CREATE TABLE runner_ratings (
    order_id INTEGER,
    rating INTEGER,
    review VARCHAR(100)
);

 INSERT INTO runner_ratings
VALUES ('1', '1', 'Really bad service'),
       ('2', '1', NULL),
       ('3', '4', 'Took too long...'),
       ('4', '1','Runner was lost, Pizza arrived cold' ),
       ('5', '2', 'Good service'),
       ('7', '5', 'It was great, good service and fast'),
       ('8', '2', 'He tossed it on the doorstep, poor service'),
       ('10', '5', 'Delicious!, he delivered it sooner than expected too!');
``` 
```sql
select * from runner_ratings;
```

| order_id | rating | review                                      |
|----------|--------|---------------------------------------------|
| 1        | 1      | Really bad service                          |
| 2        | 1      |                                             |
| 3        | 4      | Took too long...                            |
| 4        | 1      | Runner was lost, Pizza arrived cold         |
| 5        | 2      | Good service                                |
| 7        | 5      | It was great, good service and fast         |
| 8        | 2      | He tossed it on the doorstep, poor service  |
| 10       | 5      | Delicious!, he delivered it sooner than expected too! |
| 1        | 1      | Really bad service                          |
| 2        | 1      |                                             |
| 3        | 4      | Took too long...                            |
| 4        | 1      | Runner was lost, Pizza arrived cold         |
| 5        | 2      | Good service                                |
| 7        | 5      | It was great, good service and fast         |
| 8        | 2      | He tossed it on the doorstep, poor service  |
| 10       | 5      | Delicious!, he delivered it sooner than expected too! |

### Q4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
 - customer_id
- order_id
- runner_id
- rating
- order_time
- pickup_time
- Time between order and pickup
- Delivery duration
- Average speed
- Total number of pizzas

```sql 
SELECT 
  c.customer_id,
  c.order_id,
  r.runner_id,
  c.order_time,
  r.pickup_time,
  TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time) AS mins_difference,
  r.duration,
  ROUND(AVG(r.distance/r.duration*60), 1) AS avg_speed,
  COUNT(c.order_id) AS pizza_count
from pizza_runner.customer_orders c
join pizza_runner.runner_orders r
on c.order_id = r.order_id 
GROUP BY 
  c.customer_id,
  c.order_id,
  r.runner_id,
  c.order_time,
  r.pickup_time, 
  r.duration;
```
| customer_id | order_id | runner_id | order_time            | pickup_time           | mins_difference | duration    | avg_speed | pizza_count |
|-------------|----------|-----------|-----------------------|-----------------------|-----------------|-------------|-----------|-------------|
| 101         | 1        | 1         | 2020-01-01 18:05:02   | 2020-01-01 18:15:34   | 10              | 32 minutes  | 37.5      | 1           |
| 101         | 2        | 1         | 2020-01-01 19:00:52   | 2020-01-01 19:10:54   | 10              | 27 minutes  | 44.4      | 1           |
| 102         | 3        | 1         | 2020-01-02 23:51:23   | 2020-01-03 00:12:37   | 21              | 20 mins     | 40.2      | 2           |
| 103         | 4        | 2         | 2020-01-04 13:23:46   | 2020-01-04 13:53:03   | 29              | 40          | 35.1      | 3           |
| 104         | 5        | 3         | 2020-01-08 21:00:29   | 2020-01-08 21:10:57   | 10              | 15          | 40        | 1           |
| 101         | 6        | 3         | 2020-01-08 21:03:13   | null                  | null            |             |           | 1           |
| 105         | 7        | 2         | 2020-01-08 21:20:29   | 2020-01-08 21:30:45   | 10              | 25mins      | 60        | 1           |
| 102         | 8        | 2         | 2020-01-09 23:54:33   | 2020-01-10 00:15:02   | 20              | 15 minute   | 93.6      | 1           |
| 103         | 9        | 2         | 2020-01-10 11:22:59   | null                  | null            |             |           | 1           |
| 104         | 10       | 1         | 2020-01-11 18:34:49   | 2020-01-11 18:50:20   | 15              | 10minutes   | 60        | 2           |


My solution for [E. Bonus questions.](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.%202%20-%20Pizza%20Runner/Syntax/Solutions/E.%20Bonus%20Questions.md.md)
