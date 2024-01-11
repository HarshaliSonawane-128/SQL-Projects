
select * from clique_bait.campaign_identifier;
select * from clique_bait.customer_nodes;
select * from clique_bait.customer_transactions;
select * from clique_bait.event_identifier;
select * from clique_bait.events;
select * from clique_bait.page_hierarchy;
select * from clique_bait.regions ;
select * from clique_bait.users;

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

select * from product_summary;

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

select * from product_category_summary;
select * from product_summary ;

/* 1.Which product had the most views, cart adds and purchases? */
select * from product_summary 
order by views desc 
limit 1 ;

/* 2.Which product was most likely to be abandoned? */
select * from product_summary 
order by abandoned
limit 1 ;

/* 3.Which product had the highest view to purchase percentage? */ 
select product_name ,
       views , purches ,
       round(100*views / purches ,2) as view_purches_per
from product_summary 
order by view_purches_per desc
limit 1 ;

/* 4.What is the average conversion rate from view to cart add? */
select avg(100*cart_adds / Views) as avg_con_rate
from product_summary;

/* 5.What is the average conversion rate from cart add to purchase? */
select avg(100*cart_adds / purches) as concersion_rate 
from product_summary ;
