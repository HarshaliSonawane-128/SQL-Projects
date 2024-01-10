select * from pizza_runner.runners;
select * from pizza_runner.runner_orders;
select * from pizza_runner.pizza_toppings;
select * from pizza_runner.pizza_recipes ;
select * from pizza_runner.pizza_names;
select * from pizza_runner.customer_orders;

/* 1. How many pizzas were ordered? */
select count(*) as total_pizza_order 
from pizza_runner.customer_orders ;

/* 2. How many unique customer orders were made? */
select count(distinct order_id ) as unique_order_count
from pizza_runner.customer_orders;

/* 3.How many successful orders were delivered by each runner? */
select runner_id , count(order_id) 
from pizza_runner.runner_orders 
group by runner_id ;

/* 4.How many of each type of pizza was delivered? */

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

/* 5. How many Vegetarian and Meatlovers were ordered by each customer?*/
SELECT 
  customer_id,
  SUM(CASE WHEN pizza_id = 1 THEN 1 ELSE 0 END) AS Meatlovers,
  SUM(CASE WHEN pizza_id = 2 THEN 1 ELSE 0 END) AS Vegetarian
FROM pizza_runner.customer_orders
GROUP BY customer_id;

/* 6. What was the maximum number of pizzas delivered in a single order? */
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

/* 7.For each customer, how many delivered pizzas had at least 1 change and how many had no changes? */
SELECT 
  c.customer_id,
  SUM(CASE WHEN exclusions != '' OR extras != '' THEN 1 ELSE 0 END) AS has_change,
  SUM(CASE WHEN exclusions = '' AND extras = '' THEN 1 ELSE 0 END) AS no_change
FROM pizza_runner.customer_orders c
JOIN pizza_runner.runner_orders r 
ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY c.customer_id;

/* 8.How many pizzas were delivered that had both exclusions and extras? */
select 
sum(case when exclusions is not null and extras is not null then 1 else 0 
    end ) as pizza_count_w_exclusions_extras
from pizza_runner.customer_orders  c 
join pizza_runner.runner_orders  r 
on c.order_id = r.order_id 
where r.distance >= 1 
and c.exclusions <> ' ' and c.extras <> ' ' ;


/* 9.What was the total volume of pizzas ordered for each hour of the day? */
select hour(order_time) as each_hour_order ,
count(order_id) as total_pizza_orderd 
from pizza_runner.customer_orders 
group by each_hour_order
order by each_hour_order;

/* 10.What was the volume of orders for each day of the week? */
select
    DAYNAME(order_time) AS day_of_week,
    COUNT(order_id) AS total_pizza_ordered
FROM
    pizza_runner.customer_orders
GROUP BY
    day_of_week;
