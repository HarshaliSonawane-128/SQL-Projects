
select * from clique_bait.campaign_identifier;
select * from clique_bait.customer_nodes;
select * from clique_bait.customer_transactions;
select * from clique_bait.event_identifier;
select * from clique_bait.events;
select * from clique_bait.page_hierarchy;
select * from clique_bait.regions ;
select * from clique_bait.users;


/* 1.How many users are there?*/
select count(distinct user_id) as user_count
from clique_bait.users;

/* 2. How many cookies does each user have on average?*/
with cookie_count as (
select user_id , count(cookie_id) as cookie_count 
from clique_bait.users
group by user_id )

select avg(cookie_count) as avg_cookie_count
from cookie_count;

/* 3. What is the unique number of visits by all users per month?*/
select month(start_date) as month ,
       count(distinct visit_id) as unique_visit 
from clique_bait.users u
join clique_bait.events  e 
on u.cookie_id = e.cookie_id 
group by month(start_date)
order by month;


/* 4.What is the number of events for each event type?*/
select 
      event_type ,
	  count(*) as no_of_events 
from clique_bait.events 
group by event_type ;

/* 5.What is the percentage of visits which have a purchase event?*/
select  
       100*count(distinct visit_id)  / (select count(distinct visit_id) from clique_bait.events) as per_event
from clique_bait.event_identifier i
join clique_bait.events e 
on i.event_type = e.event_type
where i.event_name = 'Purchase' ;


/* 6.What are the top 3 pages by number of views?*/
select ph.page_name ,
       count(*) as pages_views
from clique_bait.events e
join clique_bait.page_hierarchy  ph 
on e.page_id = ph.page_id 
where e.event_type = 1 
group by ph.page_name
order by pages_views Desc
limit 3 ;


/* 7.What is the number of views and cart adds for each product category?*/
select product_category ,
	sum(Case when e.event_type = 1 then 1 else 0 end ) as page_views ,
    sum(case when e.event_type = 2 then 1 else 0 end ) as card_adds 
from clique_bait.events e 
join clique_bait.page_hierarchy ph 
on e.page_id = ph.page_id 
where ph.product_category  is not null
group by ph.product_category
order by page_views DESC ;

/* 8.What are the top 3 products by purchases?*/

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

/*9. What is the percentage of visits which view the checkout page but do not have a purchase event?*/
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


