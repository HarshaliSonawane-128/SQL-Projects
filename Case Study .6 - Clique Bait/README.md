
# 🐟Case Study . 6 - Clique Bait
Clique Bait is not like your regular online seafood store - the founder and CEO Danny, was also a part of a digital data analytics team and wanted to expand his knowledge into the seafood industry!

In this case study - you are required to support Danny’s vision and analyse his dataset and come up with creative solutions to calculate funnel fallout rates for the Clique Bait online store.

![pid](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.6%20-%20Clique%20Bait/6.png)
## 📕 Table of Contents
-  Bussiness Task
- Entity Relationship Diagram
- Case Study Questions
- My Solution
## 🛠️ Bussiness Task
Clique Bait is not like your regular online seafood store - the founder and CEO Danny, was also a part of a digital data analytics team and wanted to expand his knowledge into the seafood industry!

In this case study - you are required to support Danny’s vision and analyse his dataset and come up with creative solutions to calculate funnel fallout rates for the Clique Bait online store.

## 🔐 Entity Relationship Diagram
![wewe](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.6%20-%20Clique%20Bait/ERD-6.png)

## ❓ Case Study Questions

### A. Digital Analysis
View my solution HERE.

Using the available datasets - answer the following questions using a single query for each one:

1. How many users are there?
2. How many cookies does each user have on average?
3. What is the unique number of visits by all users per month?
4. What is the number of events for each event type?
5. What is the percentage of visits which have a purchase event?
6. What is the percentage of visits which view the checkout page but do not have a purchase event?
7. What are the top 3 pages by number of views?
8. What is the number of views and cart adds for each product category?
9. What are the top 3 products by purchases?

---

## B. Product Funnel Analysis
View my solution HERE.

Using a single SQL query - create a new output table which has the following details:

-  How many times was each product viewed?
-  How many times was each product added to cart?
-  How many times was each product added to a cart but not purchased (abandoned)?
-  How many times was each product purchased?

Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.

Use your 2 new output tables - answer the following questions:

1. Which product had the most views, cart adds and purchases?
2. Which product was most likely to be abandoned?
3. Which product had the highest view to purchase percentage?
3. What is the average conversion rate from view to cart add?
4. What is the average conversion rate from cart add to purchase?
--- 
## C. Campaigns Analysis
View my solution HERE.

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

## 🚀 My Solution
- View the complete syntax HERE.
- View the result and explanation HERE.
