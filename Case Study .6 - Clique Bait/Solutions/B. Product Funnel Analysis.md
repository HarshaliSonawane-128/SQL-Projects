
# 🐟 Case Study #6 - Clique Bait
## B. Product Funnel Analysis
Using a single SQL query - create a new output table which has the following details:

- How many times was each product viewed?
- How many times was each product added to cart?
- How many times was each product added to a cart but not purchased (abandoned)?
- How many times was each product purchased?
Solution
The output table will look like:

| Column           | Description                                        |
|------------------|----------------------------------------------------|
| product_id       | Id of each product                                 |
| product_name     | Name of each product                               |
| product_category | Category of each product                            |
| views            | Number of times each product viewed                |
| cart_adds        | Number of times each product added to cart          |
| abandoned        | Number of times each product added to cart but not purchased (abandoned) |
| purchases        | Number of times each product purchased             |

```sql 
CREATE TABLE product_summary AS
With Product_info as(
select 
     product_id ,
     page_name as product_name ,
     product_category ,
     sum(case when event_name = 'Page View' then 1 else 0 end) as views ,
     sum(case when event_name = 'Add to Cart' then 1 else 0 end) as cart_adds
from clique_bait.events e
join clique_bait.event_identifier i
on e.event_type = i.event_type 
join clique_bait.page_hierarchy ph
on e.page_id = ph.page_id 
where product_id is not null 
group by 
1,2,3 ),

 product_purchesed as 
( select product_id ,
         page_name as product_name ,
         product_category , 
         count(*) as purches 
from clique_bait.events  e 
join clique_bait.event_identifier i 
on e.event_type = i.event_type 
join clique_bait.page_hierarchy ph 
on e.page_id = ph.page_id 
where i.event_name = 'Add to Cart' and 
						 e.visit_id in (select visit_id 
                         from  clique_bait.events e
                         join   clique_bait.event_identifier  i 
                         ON e.event_type = i.event_type
                         where i.event_name = 'Purchase' )
group by 1,2,3) ,

 product_abandoned as 
(select product_id ,
         page_name as product_name ,
         product_category , 
         count(*) as abandoned 
from clique_bait.events  e 
join clique_bait.event_identifier i 
on e.event_type = i.event_type 
join clique_bait.page_hierarchy ph 
on e.page_id = ph.page_id 
where i.event_name = 'Add to Cart' and 
						 e.visit_id not in (select visit_id 
                         from  clique_bait.events e
                         join   clique_bait.event_identifier  i 
                         ON e.event_type = i.event_type
                         where i.event_name = 'Purchase' )
group by 1,2,3) 

select p.* ,
       pp.purches ,
       a.abandoned 
from product_info p
join product_purchesed pp  on p.product_id = pp.product_id 
join product_abandoned a on  p.product_id = a.product_id ;
``` 

| product_id | product_name      | product_category | views | cart_adds | purchases | abandoned |
|------------|-------------------|-------------------|-------|-----------|-----------|-----------|
| 9          | Oyster            | Shellfish         | 1568  | 943       | 726       | 217       |
| 8          | Crab              | Shellfish         | 1564  | 949       | 719       | 230       |
| 7          | Lobster           | Shellfish         | 1547  | 968       | 754       | 214       |
| 5          | Black Truffle     | Luxury            | 1469  | 924       | 707       | 217       |
| 2          | Kingfish          | Fish              | 1559  | 920       | 707       | 213       |
| 3          | Tuna              | Fish              | 1515  | 931       | 697       | 234       |
| 4          | Russian Caviar    | Luxury            | 1563  | 946       | 697       | 249       |
| 1          | Salmon            | Fish              | 1559  | 938       | 711       | 227       |
| 6          | Abalone           | Shellfish         | 1525  | 932       | 699       | 233       |


Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.

```sql
CREATE TABLE product_category_summary AS
WITH category_info AS (
  SELECT 
    ph.product_category,
    SUM(CASE WHEN ei.event_name = 'Page View' THEN 1 ELSE 0 END) AS views,
    SUM(CASE WHEN ei.event_name = 'Add To Cart' THEN 1 ELSE 0 END) AS cart_adds
  FROM clique_bait.events e
  JOIN clique_bait.event_identifier ei ON e.event_type = ei.event_type
  JOIN clique_bait.page_hierarchy ph ON e.page_id = ph.page_id
  WHERE ph.product_id IS NOT NULL
  GROUP BY ph.product_category 
),
category_abandoned AS (
  SELECT 
    ph.product_category,
    COUNT(*) AS abandoned
  FROM  clique_bait.events e
  JOIN clique_bait.event_identifier ei ON e.event_type = ei.event_type
  JOIN clique_bait.page_hierarchy ph ON e.page_id = ph.page_id
  WHERE ei.event_name = 'Add to cart'
  AND e.visit_id NOT IN (
    SELECT e.visit_id
    FROM clique_bait.events e
    JOIN clique_bait.event_identifier ei ON e.event_type = ei.event_type
    WHERE ei.event_name = 'Purchase')
    GROUP BY ph.product_category
),
category_purchased AS (
  SELECT 
    ph.product_category,
    COUNT(*) AS purchases
  FROM clique_bait.events e
  JOIN clique_bait.event_identifier ei ON e.event_type = ei.event_type
  JOIN clique_bait.page_hierarchy ph ON e.page_id = ph.page_id
  WHERE ei.event_name = 'Add to cart'
  AND e.visit_id IN (
    SELECT e.visit_id
    FROM clique_bait.events e
    JOIN clique_bait.event_identifier ei ON e.event_type = ei.event_type
    WHERE ei.event_name = 'Purchase')
    GROUP BY ph.product_category
)

SELECT 
  ci.*,
  ca.abandoned,
  cp.purchases
FROM category_info ci
JOIN category_abandoned ca ON ci.product_category = ca.product_category
JOIN category_purchased cp ON ci.product_category = cp.product_category;
```

```sql
select * from product_category_summary;
```

| Product Category | Views | Cart Adds | Abandoned | Purchases |
|------------------|-------|-----------|-----------|-----------|
| Fish             | 4633  | 2789      | 674       | 2115      |
| Shellfish        | 6204  | 3792      | 894       | 2898      |
| Luxury           | 3032  | 1870      | 466       | 1404      |


### 1.Which product had the most views, cart adds and purchases? 
```sql
select * from product_summary 
order by views desc 
limit 1 ;
```
| product_id | product_name | product_category | views | cart_adds | purchases | abandoned |
|------------|--------------|------------------|-------|-----------|-----------|-----------|
| 9          | Oyster       | Shellfish        | 1568  | 943       | 726       | 217       |


### 2.Which product was most likely to be abandoned? 
```sql
select * from product_summary 
order by abandoned
limit 1 ;
```

| product_id | product_name | product_category | views | cart_adds | purchases | abandoned |
|------------|--------------|------------------|-------|-----------|-----------|-----------|
| 2          | Kingfish     | Fish             | 1559  | 920       | 707       | 213       |


### 3.Which product had the highest view to purchase percentage? 
```sql
select product_name ,
       views , purches ,
       round(100*views / purches ,2) as view_purches_per
from product_summary 
order by view_purches_per desc
limit 1 ;
```

| Product Name    | Views | Purchases | View-Purchase Ratio |
|-----------------|-------|-----------|---------------------|
| Russian Caviar  | 1563  | 697       | 224.25              |


### 4.What is the average conversion rate from view to cart add? 
```sql
select avg(100*cart_adds / Views) as avg_con_rate
from product_summary;
```
|avg_con_rate|
|----|
|60.9512|

### 5.What is the average conversion rate from cart add to purchase? 
```sql
select avg(100*cart_adds / purches) as concersion_rate 
from product_summary ;
```

|concersion_rate|
|----|
|131.73|

My Solution [C.Campaigns Solution ](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.6%20-%20Clique%20Bait/Solutions/C.%20Campaigns%20Analysis.md)
