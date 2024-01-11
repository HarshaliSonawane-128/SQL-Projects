# 📊 Case Study #4 - Data Bank
## B. Customer Transactions
### 1. What is the unique count and total amount for each transaction type?

```sql 
select  txn_type , 
        count(*) as unique_count , 
        sum(txn_amount) as total_amount
from data_bank.customer_transactions 
group by txn_type ;
``` 

| txn_type   | unique_count | total_amount |
|------------|--------------|--------------|
| deposit    | 2671         | 1359168      |
| withdrawal | 1580         | 793003       |
| purchase   | 1617         | 806537       |

### 2. What is the average total historical deposit counts and amounts for all customers?

```sql 
WITH customerDeposit AS  
( select  
customer_id,
 txn_type , 
        count(*) as dep_count , 
        sum(txn_amount) as dep_total_amount
from data_bank.customer_transactions 
where txn_type = 'deposit' 
group by customer_id, txn_type)


select avg(dep_count) as avg_dep_count ,
       avg(dep_total_amount) as avg_dep_total_amount
from customerDeposit ;
```
| avg_dep_count | avg_dep_total_amount |
|---------------|----------------------|
| 5.3420        | 2718.3360            |


### 3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
```sql
  WITH cte_transaction AS ( 
  select customer_id , 
         month(txn_date) as months ,
         sum( case when txn_type = 'deposit' then 1 else 0 end) as deposite_count ,
         sum( case when txn_type = 'purchase' then 1 else 0 end ) as purches_count ,
		sum( case when txn_type = 'withdrawal' then 1 else 0 end ) as withdrawal_count 
  from data_bank.customer_transactions
  group by customer_id , month(txn_date) ) 
  
  select months , count(customer_id) as customer_count
  from cte_transaction 
  where deposite_count > 1 and  (purches_count = 1 or withdrawal_count =1 ) 
  group by months;
  ```

  | months | customer_count |
|--------|-----------------|
|   1    |      115        |
|   4    |       50        |
|   2    |      108        |
|   3    |      113        |
