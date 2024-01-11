
# 👕 Case Study #7 - Balanced Tree Clothing Co.
## A. High Level Sales Analysis

###  1. What was the total quantity sold for each products? 
```sql
select product_name , sum(qty) as quantitiy_sold
from balanced_tree.product_details d
join balanced_tree.sales s
on d.product_id = s.prod_id 
group by d.product_name;
```
| Product Name                        | Quantity Sold |
| ----------------------------------- | ------------- |
| Navy Oversized Jeans - Womens       | 7712          |
| White Tee Shirt - Mens              | 7600          |
| White Striped Socks - Mens          | 7310          |
| Pink Fluro Polkadot Socks - Mens    | 7540          |
| Cream Relaxed Jeans - Womens        | 7414          |
| Indigo Rain Jacket - Womens         | 7514          |
| Blue Polo Shirt - Mens              | 7638          |
| Navy Solid Socks - Mens             | 7584          |
| Black Straight Jeans - Womens       | 7572          |
| Khaki Suit Jacket - Womens          | 7504          |
| Grey Fashion Jacket - Womens        | 7752          |
| Teal Button Up Shirt - Mens         | 7292          |


###1.1  What was the total quantity sold for all products? 
```sql
select sum(qty) as quantitiy_sold 
from balanced_tree.sales ;
```
|quantitiy_sold|
|---|
|90432|

### 2. What is the total generated revenue for each products before discounts?
```sql
SELECT SUM(qty * price) AS revenue_before_discounts
FROM balanced_tree.sales;
```

|revenue_before_discounts|
|---|
|2578906|


### 3. What was the total discount amount for all products?
```sql
select sum(qty*price*discount) /100 as total_discount
from balanced_tree.sales ;
```
|total_discount|
|---|
|312458.2800|

My solution for [B. Transaction Analysis.](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.7%20-%20Balanced%20Tree%20Clothing%20Co/Solutions/B.%20Transaction%20Analysis.md)
