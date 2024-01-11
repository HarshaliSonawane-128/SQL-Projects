
select * from data_bank.customer_nodes ;
select * from data_bank.customer_transactions ;
select * from data_bank.regions ;
select * from data_bank.runner_ratings;

/* 1. How many unique nodes are there on the Data Bank system?*/
select count(distinct(node_id) )
from data_bank.customer_nodes ;

/* 2. What is the number of nodes per region?*/
select region_name , count(node_id) as nodes_per_region 
from data_bank.regions r
join data_bank.customer_nodes n
on r.region_id =n.region_id 
group by region_name;

/* 3. How many customers are allocated to each region?*/
select region_name , count(customer_id) as customer_per_region 
from data_bank.regions r
join data_bank.customer_nodes n
on r.region_id =n.region_id 
group by region_name;

/* 4. How many days on average are customers reallocated to a different node?*/

SELECT round(avg(datediff(end_date, start_date)), 2) AS avg_days
FROM customer_nodes
WHERE end_date!='9999-12-31';
