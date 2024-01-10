
# Case Study .1 - Danny's Diner

Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

![Danny's Diner](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.1%20Danny's%20Diner/IMG.png)

## 📕Table of Contents
- Bussiness Task 
- Entity Relationship Diagram
- Case Study Questions
- My Solution

## 🛠️ Bussiness Task
Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

## 🔐 Entity Relationship Diagram
![ERD](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.1%20Danny's%20Diner/ERD.png)

## ❓Case Study Questions

1. What is the total amount each customer spent at the restaurant?
2. How many days has each customer visited the restaurant?
4. What was the first item from the menu purchased by  each customer?
5. What is the most purchased item on the menu and how many times was it purchased by all customers?
6. Which item was the most popular for each customer?
Which item was purchased first by the customer after they became a member ?

7. Which item was purchased just before the customer became a member?
8. What is the total items and amount spent for each member before they became a member?
9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

## 🚀 My Solution

View the complete syntax 
[Here](https://github.com/HarshaliSonawane-128/SQL-Projects/tree/main/Case%20Study%20.1%20Danny's%20Diner/Syntax)

- Tool used: MySql 

## Q1. What is the total amount each customer spent at the restaurant?

```sql  
SELECT s.customer_id, SUM(m.price) as total_amount_spend
FROM dannys_diner.sales s 
JOIN dannys_diner.menu m 
ON s.product_id = m.product_id 
GROUP BY s.customer_id
ORDER BY s.customer_id; 
```

| customer_id | total_amount_spend | 
|--- | --- |
| A	| 76 |
|B	| 74 |
|C	| 36 |

## Q2. How many days has each customer visited the restaurant?

```sql 
SELECT customer_id, 
COUNT(DISTINCT order_date) AS no_of_days
FROM dannys_diner.sales 
GROUP BY customer_id ;
```

|customer_id|	no_of_days|
|---|---|
|	A	|4|
|	B	|6|
|	C	|2|

## Q3. What was the first item from the menu purchased by each customer?

```sql 

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
```
|customer_id|product_name|
|---	|--- |
|A	|sushi |
|A	|curry|
|B	|curry|
|C	|ramen|

## Q4. What is the most purchased item on the menu and how many times was it purchased by all customers?

```sql
select m.product_name , count(s.product_id) as most_purchesed_item 
   from dannys_diner.sales s 
   inner join dannys_diner.menu m 
   on s.product_id = m.product_id
group by m.product_name 
order by most_purchesed_item  desc
LIMIT 1 ;
```

|product_name | most_purchesed_item |
|--- |---|
|ramen	|8|

## Q5. Which item was the most popular for each customer?

```sql
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
```
|customer_id|product_name|order_count|
|---|---|---|
|A	|ramen	|3|

## Q6. Which item was purchased first by the customer after they became a member?

```sql
With join_as_member  as 
( select m.customer_id , s.product_id,
    row_number() over (partition by m.customer_id order by s.order_date ) as row_num
from dannys_diner.sales  s 
join dannys_diner.members  m 
on s.customer_id = m.customer_id 
and s.order_date > m.join_date )

select  customer_id , product_name 
from join_as_member j 
inner join dannys_diner.menu m
on j.product_id = m.product_id
where row_num = 1 
order by customer_id ASC ;

```
|customer_id | product_name |
|	---| --- |
|	A|	ramen|
|B	|sushi|

## Q7. Which item was purchased just before the customer became a member?

```sql 
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
```

|customer_id|	product_name|
|---	|---|
|A	|sushi|
|B	|curry|

## Q8. What is the total items and amount spent for each member before they became a member?

```sql
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
```
|customer_id|	total_items|	total_sales|
|---|	---|	---|
|A|	2	|25|
|B|	3	|40|

## Q9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

Note: Only customers who are members receive points when purchasing items

```sql 
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
```

|customer_id	|total_points|
|--- |---| 
|A | 860|
|B	|940|
|C	|360|

## Q. 10.Recreate the table with: customer_id, order_date, product_name, price, member (Yes/No)?

```sql
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
```
| customer_id | order_date | product_name | price | member_status |
|-------------|------------|--------------|-------|---------------|
| C           | 2021-01-01 | ramen        | 12    | No            |
| C           | 2021-01-01 | ramen        | 12    | No            |
| C           | 2021-01-07 | ramen        | 12    | No            |
| A           | 2021-01-01 | sushi        | 10    | No            |
| A           | 2021-01-01 | curry        | 15    | No            |
| A           | 2021-01-07 | curry        | 15    | Yes           |
| A           | 2021-01-10 | ramen        | 12    | Yes           |
| A           | 2021-01-11 | ramen        | 12    | Yes           |
| A           | 2021-01-11 | ramen        | 12    | Yes           |
| B           | 2021-01-01 | curry        | 15    | No            |
| B           | 2021-01-02 | curry        | 15    | No            |
| B           | 2021-01-04 | sushi        | 10    | No            |
| B           | 2021-01-11 | sushi        | 10    | Yes           |
| B           | 2021-01-16 | ramen        | 12    | Yes           |
| B           | 2021-02-01 | ramen        | 12    | Yes           |

