
# 🐟 Case Study #6 - Clique Bait
## A. Digital Analysis
### 1. How many users are there?
```sql 
select count(distinct user_id) as user_count
from clique_bait.users;
``` 
|user_count|
|---|
|500|

### 2. How many cookies does each user have on average?

```sql 
with cookie_count as (
select user_id , count(cookie_id) as cookie_count 
from clique_bait.users
group by user_id )

select avg(cookie_count) as avg_cookie_count
from cookie_count;
``` 
|---|
|avg_cookie_count|
|3.5640|

### 3. What is the unique number of visits by all users per month?

```sql 
select month(start_date) as month ,
       count(distinct visit_id) as unique_visit 
from clique_bait.users u
join clique_bait.events  e 
on u.cookie_id = e.cookie_id 
group by month(start_date)
order by month;
```
| month | unique_visit|
|--------|-------|
|   1    |  876  |
|   2    | 1488  |
|   3    |  916  |
|   4    |  248  |
|   5    |   36  |

### 4. What is the number of events for each event type?

```sql
select 
      event_type ,
	  count(*) as no_of_events 
from clique_bait.events 
group by event_type ;
``` 

| event_type | no_of_events |
|------------|--------------|
| 1          | 20928        |
| 2          | 8451         |
| 3          | 1777         |
| 4          | 876          |
| 5          | 702          |


## 5. What is the percentage of visits which have a purchase event?
```sql
select  
       100*count(distinct visit_id)  / (select count(distinct visit_id) from clique_bait.events) as per_event
from clique_bait.event_identifier i
join clique_bait.events e 
on i.event_type = e.event_type
where i.event_name = 'Purchase' ;
```
|per_event|
|---|
|49.8597|


### 7. What are the top 3 pages by number of views?

```sql
select ph.page_name ,
       count(*) as pages_views
from clique_bait.events e
join clique_bait.page_hierarchy  ph 
on e.page_id = ph.page_id 
where e.event_type = 1 
group by ph.page_name
order by pages_views Desc
limit 3 ;
``` 
| Page          | Number of Visits |
|---------------|------------------:|
| All Products  |              3174 |
| Checkout      |              2103 |
| Home Page     |              1782 |



### 8. What are the top 3 products by purchases?
```sql
SELECT 
  ph.product_id,
  ph.page_name,
  ph.product_category,
  COUNT(*) AS purchase_count
FROM clique_bait.events e
JOIN clique_bait.event_identifier ei ON e.event_type = ei.event_type
JOIN clique_bait.page_hierarchy ph ON e.page_id = ph.page_id
WHERE ei.event_name = 'Add to cart'
AND e.visit_id IN (
  SELECT e.visit_id
  FROM clique_bait.events e
  JOIN clique_bait.event_identifier ei ON e.event_type = ei.event_type
  WHERE ei.event_name = 'Purchase')
GROUP BY ph.product_id,	ph.page_name, ph.product_category
ORDER BY purchase_count DESC
limit 3 ;
``` 

| ID | Name    | Category  | Score |
|----|---------|-----------|-------|
| 7  | Lobster | Shellfish | 754   |
| 9  | Oyster  | Shellfish | 726   |
| 8  | Crab    | Shellfish | 719   |

### 9. What is the percentage of visits which view the checkout page but do not have a purchase event?*/

```sql
WITH view_checkout AS (
  SELECT COUNT(e.visit_id) AS cnt
  FROM clique_bait.events e
  JOIN clique_bait.event_identifier ei ON e.event_type = ei.event_type
  JOIN clique_bait.page_hierarchy p ON e.page_id = p.page_id
  WHERE ei.event_name = 'Page View'
    AND p.page_name = 'Checkout'
)

SELECT CAST(100-(100.0 * COUNT(DISTINCT e.visit_id) 
		/ (SELECT cnt FROM view_checkout)) AS decimal(10, 2)) AS pct_view_checkout_not_purchase
FROM clique_bait.events e
JOIN clique_bait.event_identifier ei ON e.event_type = ei.event_type
WHERE ei.event_name = 'Purchase';
```

|pct_view_checkout_not_purchase|
|---|
|15.50|

My solution for B. Product Funnel Analysis.
