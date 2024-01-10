select * from pizza_runner.runners;
select * from pizza_runner.runner_orders;
select * from pizza_runner.pizza_toppings;
select * from pizza_runner.pizza_recipes ;
select * from pizza_runner.pizza_names;
select * from pizza_runner.customer_orders;

/* 1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for
       changes - how much money has Pizza Runner made so far if there are no delivery fees?*/
      
select 
CONCAT('$',sum( case when pizza_name = 'Meatlovers' then 12 else 10 end )) as earned_money
from pizza_runner.customer_orders c
join pizza_runner.pizza_names p 
on c.pizza_id = p.pizza_id 
join pizza_runner.runner_orders r
on c.order_id = r.order_id 
where r.cancellation is null ;


/* 2. What if there was an additional $1 charge for any pizza extras? Add cheese is $1 extra */
select 
CONCAT('$',sum( case when pizza_name = 'Meatlovers' and extras is not null then 12 else 10  end )+ 1) as add_charges
from pizza_runner.customer_orders c
join pizza_runner.pizza_names p 
on c.pizza_id = p.pizza_id 
join pizza_runner.runner_orders r
on c.order_id = r.order_id 
where r.cancellation is null ;

/* 3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your
 own data for ratings for each successful customer order between 1 to 5.*/
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

select * from runner_ratings;

/* 4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
customer_id
order_id
runner_id
rating
order_time
pickup_time
Time between order and pickup
Delivery duration
Average speed
Total number of pizzas */ 


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