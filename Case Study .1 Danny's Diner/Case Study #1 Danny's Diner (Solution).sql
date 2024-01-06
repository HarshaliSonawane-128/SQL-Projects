select * from dannys_diner.members;
select * from dannys_diner.menu;
select * from dannys_diner.sales;

/* 1. What is the total amount each customer spent at the restaurant?*/

SELECT s.customer_id, SUM(m.price) as total_amount_spend
FROM sales s 
JOIN menu m 
ON s.product_id = m.product_id 
GROUP BY s.customer_id
ORDER BY s.customer_id;


/* 2.How many days has each customer visited the restaurant?*/
SELECT customer_id, 
COUNT(DISTINCT order_date) AS no_of_days
FROM sales 
GROUP BY customer_id ;

/* 3.What was the first item from the menu purchased by each customer?*/

WITH ordered_sales AS (
  SELECT 
    sales.customer_id, 
    sales.order_date, 
    menu.product_name,
    DENSE_RANK() OVER (
      PARTITION BY sales.customer_id 
      ORDER BY sales.order_date) AS ranka
  FROM dannys_diner.sales
  INNER JOIN dannys_diner.menu
    ON sales.product_id = menu.product_id
)

SELECT 
  customer_id, 
  product_name
FROM ordered_sales
WHERE ranka = 1
GROUP BY customer_id, product_name;


/* 4.What is the most purchased item on the menu and how many times was it purchased by all customers?*/

select m.product_name , count(s.product_id) as most_purchesed_item 
   from dannys_diner.sales s 
   inner join dannys_diner.menu m 
   on s.product_id = m.product_id
group by m.product_name 
order by most_purchesed_item  desc
LIMIT 1 ;



/* 5.Which item was the most popular for each customer?*/
WITH most_popular AS (
  SELECT
    s.customer_id,
    m.product_name,
    COUNT(s.product_id) AS order_count,
    DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY COUNT(s.product_id) DESC) AS Rank_by_most_purchases
  FROM
    dannys_diner.sales s
    JOIN dannys_diner.menu m ON s.product_id = m.product_id
  GROUP BY
    s.customer_id, m.product_name
)

SELECT
  customer_id,
  product_name,
  order_count
FROM
  most_popular
  LIMIT 1 ;

/* 6.Which item was purchased first by the customer after they became a member?*/
With join_as_member  as 
( select m.customer_id , s.product_id,
    row_number() over (partition by m.customer_id order by s.order_date ) as row_num
from dannys_diner.sales  s 
join dannys_diner.members  m 
on s.customer_id = m.customer_id 
and s.order_date > m.join_date )

select  customer_id , product_name 
from join_as_member j 
inner join menu m
on j.product_id = m.product_id
where row_num = 1 
order by customer_id ASC ;


/* 7.Which item was purchased just before the customer became a member?*/
with join_member as 
( select m.customer_id ,s.product_id , 
       row_number() OVER (Partition by  m.customer_id  order by s.order_date )as row_num
from dannys_diner.members m
inner join dannys_diner.sales s 
on m.customer_id = s.customer_id and s.order_date < m.join_date )

select customer_id ,product_name 
from join_member j 
join dannys_diner.menu m 
on j.product_id = m.product_id 
where row_num = 1 
order by j.customer_id  ASC;


/* 8.What is the total items and amount spent for each member before they became a member?*/
SELECT 
  sales.customer_id, 
  COUNT(sales.product_id) AS total_items, 
  SUM(menu.price) AS total_sales
FROM dannys_diner.sales
INNER JOIN dannys_diner.members
  ON sales.customer_id = members.customer_id
  AND sales.order_date < members.join_date
INNER JOIN dannys_diner.menu
  ON sales.product_id = menu.product_id
GROUP BY sales.customer_id
ORDER BY sales.customer_id;

/* 9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many
 points would each customer have?*/
 
 with point_cte as (
 select menu.product_id ,
 case 
    when product_id = 1 then price*20 
    else price*10 
    End as points 
from dannys_diner.menu)

select sales.customer_id , sum(points) as total_points 
from dannys_diner.sales
inner join point_cte
on sales.product_id = point_cte.product_id 
group by sales.customer_id
order by sales.customer_id ;
 

/* 10.Recreate the table with: customer_id, order_date, product_name, price, member (Y/N)*/

 SELECT 
  sales.customer_id, 
  sales.order_date,  
  menu.product_name, 
  menu.price,
  CASE
    WHEN members.join_date > sales.order_date THEN 'No'
    WHEN members.join_date <= sales.order_date THEN 'Yes'
    ELSE 'No' END AS member_status
FROM dannys_diner.sales
LEFT JOIN dannys_diner.members
  ON sales.customer_id = members.customer_id
INNER JOIN dannys_diner.menu
  ON sales.product_id = menu.product_id
ORDER BY members.customer_id, sales.order_date;
