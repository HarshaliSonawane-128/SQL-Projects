select * from pizza_runner.runners;
select * from pizza_runner.runner_orders;
select * from pizza_runner.pizza_toppings;
select * from pizza_runner.pizza_recipes ;
select * from pizza_runner.pizza_names;
select * from pizza_runner.customer_orders;

/* 1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)*/
select count(runner_id) as sign_up_runners 
     ,week(registration_date) as week_number
from pizza_runner.runners
where registration_date  >=  '2021-01-01'
group by week_number 
order by week_number ;


/* 2.What was the average time in minutes it took for each runner to arrive 
       at the Pizza Runner HQ to pickup the order?*/
SELECT r.runner_id,
      avg(TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)) AS avg_runner_pickup_time       
FROM pizza_runner.runner_orders r
INNER JOIN pizza_runner.customer_orders  c
USING (order_id)
WHERE cancellation IS NULL
group by runner_id ;

/* 3.Is there any relationship between the number of pizzas and how long the order takes to prepare?*/
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

/* 4.What was the average distance travelled for each customer?*/
select c.customer_id , round(avg(r.distance))
from pizza_runner.customer_orders c
join pizza_runner.runner_orders r 
on c.order_id = r.order_id 
group by c.customer_id  ;

/* 5.What was the difference between the longest and shortest delivery times for all orders?*/

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

/* 6. What was the average speed for each runner for each delivery and do you notice any trend for these values?*/
select runner_id ,
       distance as distance_km , 
       round(duration/60 ,2) as duration_hr , 
       round(distance*60/duration , 2) as average_speed
from pizza_runner.runner_orders
where cancellation is  null
order by runner_id ;


/* 7. What is the successful delivery percentage for each runner? */
select runner_id , 
       count(pickup_time) as deliverd_orders ,
       count(*) as total_orders , 
       round(100* count(pickup_time) /count(*) )as delivery_success_percentage
from pizza_runner.runner_orders 
group by runner_id
order by runner_id;



