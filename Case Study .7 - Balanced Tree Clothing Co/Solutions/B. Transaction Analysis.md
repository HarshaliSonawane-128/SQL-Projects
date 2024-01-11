# 👕 Case Study #7 - Balanced Tree Clothing Co.
## B. Transaction Analysis


### 1. How many unique transactions were there? 
```sql
select count(distinct txn_id) as unique_transaction
from balanced_tree.sales ;
```
|unique_transaction|
|---|
|2500|

### 2. What is the average unique products purchased in each transaction?
```sql
select avg( product_count) as avg_unique_products 
from ( select txn_id , count(distinct prod_id) as product_count
from balanced_tree.sales
group by txn_id) temp ;
```
|avg_unique_products|
|---|
|6.0380|


### 3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?
```sql
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
```
| pct_25th | pct_50th | pct_75th |
|----------|----------|----------|
| 375.75   | 509.5    | 647      |


### 4. What is the average discount value per transaction?
```sql
select txn_id , 
     avg(discount) as avg_discount 
from balanced_tree.sales 
group by txn_id ;
```
|   txn_id   | avg_discount|
|--------|---------|
| 54f307 | 17.0000 |
| 26cc98 | 21.0000 |
| ef648d | 21.0000 |
| fba96f | 23.0000 |
| 4e9268 | 11.0000 |


### 5. What is the percentage split of all transactions for members vs non-members?
```sql
select 
      100*count(distinct case when member = 't' then txn_id end) /count(distinct txn_id)  as member_pct,
      100*count(distinct case when member = 'f' then txn_id end) /count(distinct txn_id)  as non_members_pct
from balanced_tree.sales ;
```

|member_pct|non_members_pct|
|---|---|
|60.2000|39.8000|

### 6. What is the average revenue for member transactions and non-member transactions?
```sql
with member_revenue as 
 ( select member ,txn_id , sum(qty*price) as revenue
  from balanced_tree.sales 
  group by member , txn_id )
  
  select member , avg(revenue) 
  from member_revenue
  group by member ;
``` 

| member | avg(revenue) |
| ------ | ------------ |
| t      | 1032.5369    |
| f      | 1030.0884    |
