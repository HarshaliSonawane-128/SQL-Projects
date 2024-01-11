

# 📊 Case Study #4 - Data Bank
## A. Customer Nodes Exploration
### 1. How many unique nodes are there on the Data Bank system?
```sql 
select count(distinct(node_id) )
from data_bank.customer_nodes ;
```
| Count of Distinct Node IDs |
|-----------------------------|
|             5               |


### 2. What is the number of nodes per region?

```sql
select region_name , count(node_id) as nodes_per_region 
from data_bank.regions r
join data_bank.customer_nodes n
on r.region_id =n.region_id 
group by region_name;
```
| region_name | nodes_per_region |
|-------------|------------------|
| Africa      | 714              |
| Europe      | 616              |
| Australia   | 770              |
| America     | 735              |
| Asia        | 665              |

### 3. How many customers are allocated to each region?

```sql 
select region_name , count(customer_id) as customer_per_region 
from data_bank.regions r
join data_bank.customer_nodes n
on r.region_id =n.region_id 
group by region_name;
```

| region_name | customer_per_region |
|-------------|----------------------|
| Africa      | 714                  |
| Europe      | 616                  |
| Australia   | 770                  |
| America     | 735                  |
| Asia        | 665                  |

### 4. How many days on average are customers reallocated to a different node?

```sql 
SELECT round(avg(datediff(end_date, start_date)), 2) AS avg_days
FROM data_bank .customer_nodes
WHERE end_date!='9999-12-31';
``` 

|   avg_days   |
|--------------|
|    14.63     |

### My solution for B. Customer Transactions.