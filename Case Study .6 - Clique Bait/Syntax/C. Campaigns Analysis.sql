
select * from clique_bait.campaign_identifier;
select * from clique_bait.customer_nodes;
select * from clique_bait.customer_transactions;
select * from clique_bait.event_identifier;
select * from clique_bait.events;
select * from clique_bait.page_hierarchy;
select * from clique_bait.regions ;
select * from clique_bait.users;


CREATE TABLE campaign_summary AS
SELECT
    u.user_id,
    e.visit_id,
    MIN(e.event_time) AS visit_start_time,
    SUM(CASE WHEN i.event_name = 'Page View' THEN 1 ELSE 0 END) AS page_views,
    SUM(CASE WHEN i.event_name = 'Add to Cart' THEN 1 ELSE 0 END) AS cart_adds,
    SUM(CASE WHEN i.event_name = 'Purchase' THEN 1 ELSE 0 END) AS purchase,
    c.campaign_name,
    SUM(CASE WHEN i.event_name = 'Ad Impression' THEN 1 ELSE 0 END) AS impression,
    SUM(CASE WHEN i.event_name = 'Ad Click' THEN 1 ELSE 0 END) AS click,
    GROUP_CONCAT(CASE WHEN i.event_name = 'Add to Cart' THEN ph.page_name ELSE NULL END
                 ORDER BY e.sequence_number ASC SEPARATOR ', ') AS cart_products
FROM clique_bait.events e
 JOIN clique_bait.users u ON e.cookie_id = u.cookie_id
JOIN clique_bait.event_identifier i ON e.event_type = i.event_type
join clique_bait.page_hierarchy ph on e.page_id = ph.page_id 
LEFT JOIN clique_bait.campaign_identifier c ON e.event_time BETWEEN c.start_date AND c.end_date
GROUP BY u.user_id, e.visit_id, c.campaign_name;

select * from campaign_summary;

/*1. calculate Number of users who received impressions during campaign periods */
select count(distinct user_id) as total_user 
from campaign_summary  
where impression = '1'
AND campaign_name IS NOT NULL ;

/* 2.Number of users who received impressions but didn't click on the ad during campaign periods */
select count(distinct user_id) as total_user 
from campaign_summary
where impression = '1' and click = '0' 
 AND campaign_name IS NOT NULL ;
 
/* 3.Number of users who didn't receive impressions during campaign periods */ 
select count(distinct user_id) as total_user 
from campaign_summary  
where impression = '0'
AND campaign_name IS NOT NULL ;

