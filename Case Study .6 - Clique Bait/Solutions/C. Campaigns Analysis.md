# 🐟 Case Study .6 - Clique Bait
## C. Campaigns Analysis

Generate a table that has 1 single row for every unique `visit_id` record and has the following columns:

- `user_id`
- `visit_id`
- `visit_start_time`: the earliest event_time for each visit
- `page_views`: count of page views for each visit
- `art_adds`: count of product cart add events for each visit
- `purchase`: 1/0 flag if a purchase event exists for each visit
- `campaign_name`: map the visit to a campaign if the visit_start_time falls between the start_date and end_date
- `impression`: count of ad impressions for each visit
- `click`: count of ad clicks for each visit

```sql 
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

```

```sql
select * from campaign_summary;
```
3,654 rows in total. The first 5 rows:

| user_id  | visit_id |      visit_start_time           | page_views |cart_adds | purchase|          campaign_name       | impression | click |              cart_products                |
|:---------:|:---------:|:------------------------------:|:--------:|:--------:|:--------:|:-----------------------------:|:--------:|:--------:|:----------------------------------------:|
|     1     |   02a5d5  |      2020-02-26 16:57:26       |    4     |    0     |    0     | Half Off - Treat Your Shellf(ish) |    0     |    0     |                                          |
|     1     |   0826dc  |      2020-02-26 05:58:38       |    1     |    0     |    0     | Half Off - Treat Your Shellf(ish) |    0     |    0     |                                          |
|     1     |   0fc437  |      2020-02-04 17:49:50       |   10     |    6     |    1     | Half Off - Treat Your Shellf(ish) |    1     |    1     | Tuna, Russian Caviar, Black Truffle, Abalone, Crab, Oyster |
|     1     |   30b94d  |      2020-03-15 13:12:54       |    9     |    7     |    1     | Half Off - Treat Your Shellf(ish) |    1     |    1     | Salmon, Kingfish, Tuna, Russian Caviar, Abalone, Lobster, Crab |
|     1     |   4

### 1. calculate Number of users who received impressions during campaign periods */

```sql
select count(distinct user_id) as total_user 
from campaign_summary  
where impression = '1'
AND campaign_name IS NOT NULL ;
```
|total_user|
|---|
|417|

### 2.Number of users who received impressions but didn't click on the ad during campaign periods */

```sql
select count(distinct user_id) as total_user 
from campaign_summary
where impression = '1' and click = '0' 
 AND campaign_name IS NOT NULL ;
 ```

 |total_user|
 |----|
 |127|

 ###  3.Number of users who didn't receive impressions during campaign periods */ 

```sql
select count(distinct user_id) as total_user 
from campaign_summary  
where impression = '0'
AND campaign_name IS NOT NULL ;
```
|total_user|
|---|
|495|


