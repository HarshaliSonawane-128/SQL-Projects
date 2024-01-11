
select * from balanced_tree.product_details;
select * from balanced_tree.product_hierarchy;
select * from balanced_tree.product_prices ;
select * from balanced_tree.sales ;

/*1. How many unique transactions were there? */
select count(distinct txn_id) as unique_transaction
from balanced_tree.sales ;

/* 2. What is the average unique products purchased in each transaction?*/
select avg( product_count) as avg_unique_products 
from ( select txn_id , count(distinct prod_id) as product_count
from balanced_tree.sales
group by txn_id) temp ;


/* 3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?*/

WITH transaction_revenue AS (
  SELECT 
    txn_id,
    SUM(qty*price) AS revenue
  FROM sales
  GROUP BY txn_id)

SELECT 
  DISTINCT 
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue) OVER () AS pct_25th,
  PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY revenue) OVER () AS pct_50th,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue) OVER () AS pct_75th
FROM transaction_revenue;

/* 4. What is the average discount value per transaction?*/
select txn_id , 
     avg(discount) as avg_discount 
from balanced_tree.sales 
group by txn_id ;

/* 5. What is the percentage split of all transactions for members vs non-members?*/
select 
      100*count(distinct case when member = 't' then txn_id end) /count(distinct txn_id)  as member_pct,
      100*count(distinct case when member = 'f' then txn_id end) /count(distinct txn_id)  as non_members_pct
from balanced_tree.sales ;



/* 6. What is the average revenue for member transactions and non-member transactions?*/
with member_revenue as 
 ( select member ,txn_id , sum(qty*price) as revenue
  from balanced_tree.sales 
  group by member , txn_id )
  
  select member , avg(revenue) 
  from member_revenue
  group by member ;
