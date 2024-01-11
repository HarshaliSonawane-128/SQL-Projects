
# 👕 Case Study #7 - Balanced Tree Clothing Co.
## C. Product Analysis

### 1. What are the top 3 products by total revenue before discount?
```sql
select p.product_name ,
      sum(s.qty*s.price) as total_ravenue 
from balanced_tree.product_details p
join balanced_tree.sales s
on p.product_id = s.prod_id 
group by p.product_name
order by sum(s.qty*s.price) desc 
limit 3 ;
```

| Product Name                   | Total Revenue |
|---------------------------------|---------------|
| Blue Polo Shirt - Mens          | 435366        |
| Grey Fashion Jacket - Womens    | 418608        |
| White Tee Shirt - Mens          | 304000        |


### 2.What is the top selling product for each segment?
```sql
select
	  p.segment_name ,
	  p.product_name ,
      sum(s.qty*s.price) as total_ravenue 
from balanced_tree.product_details p
join balanced_tree.sales s
on p.product_id = s.prod_id 
group by  p.segment_name , p.product_name
order by sum(s.qty*s.price) desc  ;
```

| segment_name | product_name                           | total_ravenue |
|--------------|----------------------------------------|---------------|
| Jeans        | Black Straight Jeans - Womens          | 242304        |
| Shirt        | Blue Polo Shirt - Mens                 | 435366        |
| Jeans        | Cream Relaxed Jeans - Womens           | 74140         |
| Jacket       | Grey Fashion Jacket - Womens           | 418608        |
| Jacket       | Indigo Rain Jacket - Womens            | 142766        |
| Jacket       | Khaki Suit Jacket - Womens             | 172592        |
| Jeans        | Navy Oversized Jeans - Womens          | 100256        |
| Socks        | Navy Solid Socks - Mens                | 273024        |
| Socks        | Pink Fluro Polkadot Socks - Mens       | 218660        |
| Shirt        | Teal Button Up Shirt - Mens            | 72920         |
| Socks        | White Striped Socks - Mens             | 124270        |
| Shirt        | White Tee Shirt - Mens                 | 304000        |


###3.What is the total quantity, revenue and discount for each segmnt?
```sql
select
	 p.segment_name ,
      sum(s.qty) as total_quantity,
      sum(s.qty*s.price) as total_ravenue ,
      sum(s.qty*s.price*s.discount) as total_discount
from balanced_tree.product_details p
join balanced_tree.sales s
on p.product_id = s.prod_id 
group by  p.segment_name ;
```
| category_name | total_quantity | total_revenue | total_discount |
|---------------|----------------|---------------|----------------|
| Womens        | 45468          | 1150666       | 13924286       |
| Mens          | 44964          | 1428240       | 17321542       |

### 3.What is the total quantity, revenue and discount for each category ?
```sql 
select
	 p.category_name ,
      sum(s.qty) as total_quantity,
      sum(s.qty*s.price) as total_ravenue ,
      sum(s.qty*s.price*s.discount) as total_discount
from balanced_tree.product_details p
join balanced_tree.sales s
on p.product_id = s.prod_id 
group by  p.category_name ;
```
| segment_name | total_revenue |
|--------------|---------------|
| Shirt        | 812286        |
| Jacket       | 733966        |
| Socks        | 615954        |
| Jeans        | 416700        |

### 4.What is the top selling product for each segment?

```sql
select
	  p.segment_name ,
      sum(s.qty*s.price) as total_ravenue 
from balanced_tree.product_details p
join balanced_tree.sales s
on p.product_id = s.prod_id 
group by  p.segment_name  
order by sum(s.qty*s.price) desc ;
```
| segment_name | total_revenue |
|--------------|---------------|
| Shirt        | 812286        |
| Jacket       | 733966        |
| Socks        | 615954        |
| Jeans        | 416700        |


### 4.What is the top selling product for each segment?
```sql
select
	  p.category_name ,
      sum(s.qty*s.price) as total_ravenue 
from balanced_tree.product_details p
join balanced_tree.sales s
on p.product_id = s.prod_id 
group by  p.category_name  
order by sum(s.qty*s.price) desc 
;
```
| segment_name | total_revenue |
|--------------|---------------|
| Shirt        | 812286        |
| Jacket       | 733966        |
| Socks        | 615954        |
| Jeans        | 416700        |


### 5.What is the percentage split of revenue by product for each segment?
```sql
SELECT 
    p.segment_name,
    p.product_name,
    100 * SUM(s.qty * s.price) / SUM(SUM(s.qty * s.price)) OVER (PARTITION BY p.segment_name) AS segment_product_pct
FROM balanced_tree.product_details p
JOIN balanced_tree.sales s 
ON p.product_id = s.prod_id
GROUP BY p.segment_name, p.product_name;
```
| segment_name | product_name                      | segment_product_pct |
|--------------|----------------------------------|----------------------|
| Jacket       | Indigo Rain Jacket - Womens       | 19.4513              |
| Jacket       | Khaki Suit Jacket - Womens        | 23.5150              |
| Jacket       | Grey Fashion Jacket - Womens      | 57.0337              |
| Jeans        | Navy Oversized Jeans - Womens     | 24.0595              |
| Jeans        | Cream Relaxed Jeans - Womens      | 17.7922              |
| Jeans        | Black Straight Jeans - Womens      | 58.1483              |
| Shirt        | White Tee Shirt - Mens            | 37.4252              |
| Shirt        | Blue Polo Shirt - Mens            | 53.5976              |
| Shirt        | Teal Button Up Shirt - Mens       | 8.9771               |
| Socks        | White Striped Socks - Mens        | 20.1752              |
| Socks        | Pink Fluro Polkadot Socks - Mens  | 35.4994              |
| Socks        | Navy Solid Socks - Mens           | 44.3254              |


### 6.What is the percentage split of revenue by segment for each category?
```sql
SELECT 
    p.category_name,
	p.segment_name,
    100 * SUM(s.qty * s.price) / SUM(SUM(s.qty * s.price)) OVER (PARTITION BY p.category_name) AS segment_category_pct
FROM balanced_tree.product_details p
JOIN balanced_tree.sales s 
ON p.product_id = s.prod_id
GROUP BY p.segment_name, p.category_name;
```
| category_name | segment_name | segment_category_pct |
|---------------|--------------|-----------------------|
| Mens          | Shirt        | 56.8732               |
| Mens          | Socks        | 43.1268               |
| Womens        | Jeans        | 36.2138               |
| Womens        | Jacket       | 63.7862               |

### 7.What is the percentage split of total revenue by category?
```sql
select p.category_name ,
       sum(s.qty*s.price) as total_revenue 
FROM balanced_tree.product_details p
JOIN balanced_tree.sales s 
ON p.product_id = s.prod_id
GROUP BY  p.category_name;
```
| Gender | Count   |
|--------|---------|
| Women  | 1150666 |
| Men    | 1428240 |


### 8. What is the total transaction “penetration” for each product?(hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)
```sql
  WITH product_transations AS (
  SELECT 
    DISTINCT s.prod_id, p.product_name,
    COUNT(DISTINCT s.txn_id) AS product_txn,
    (SELECT COUNT(DISTINCT txn_id) FROM balanced_tree.sales) AS total_txn
FROM balanced_tree.product_details p
JOIN balanced_tree.sales s 
ON p.product_id = s.prod_id
  GROUP BY s.prod_id, p.product_name
)
SELECT 
  *,
  CAST(100.0 * product_txn / total_txn AS decimal(10,2)) AS penetration_pct
FROM product_transations;
```

| SKU    | Product Name                           | Stock | Total Stock | Price  |
|--------|----------------------------------------|-------|-------------|--------|
| 2a2353 | Blue Polo Shirt - Mens                 | 1268  | 2500        | 50.72  |
| 2feb6b | Pink Fluro Polkadot Socks - Mens       | 1258  | 2500        | 50.32  |
| 5d267b | White Tee Shirt - Mens                 | 1268  | 2500        | 50.72  |
| 72f5d4 | Indigo Rain Jacket - Womens            | 1250  | 2500        | 50.00  |
| 9ec847 | Grey Fashion Jacket - Womens           | 1275  | 2500        | 51.00  |
| b9a74d | White Striped Socks - Mens             | 1243  | 2500        | 49.72  |
| c4a632 | Navy Oversized Jeans - Womens          | 1274  | 2500        | 50.96  |
| c8d436 | Teal Button Up Shirt - Mens            | 1242  | 2500        | 49.68  |
| d5e9a6 | Khaki Suit Jacket - Womens             | 1247  | 2500        | 49.88  |
| e31d39 | Cream Relaxed Jeans - Womens           | 1243  | 2500        | 49.72  |
| e83aa3 | Black Straight Jeans - Womens           | 1246  | 2500        | 49.84  |
| f084eb | Navy Solid Socks - Mens                | 1281  | 2500        | 51.24  |


### 9.What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?

-- Count the number of products in each transaction
```sql
WITH products_per_transaction AS (
  SELECT 
    s.txn_id,
    pd.product_id,
    pd.product_name,
    s.qty,
    COUNT(pd.product_id) OVER (PARTITION BY txn_id) AS cnt
  FROM balanced_tree.sales s
  JOIN balanced_tree.product_details pd 
  ON s.prod_id = pd.product_id
),

-- Filter transactions that have the 3 products and group them to a cell
combinations AS (
  SELECT 
    group_concat(product_id, ', ') over (ORDER BY product_id)  AS product_ids,
    group_concat(product_name, ', ') over(ORDER BY product_id) AS product_names
  FROM products_per_transaction
  WHERE cnt = 3
  GROUP BY txn_id
),

-- Count the number of times each combination appears
combination_count AS (
  SELECT 
    product_ids,
    product_names,
    COUNT(*) AS common_combinations
  FROM combinations
  GROUP BY product_ids, product_names
)

-- Filter the most common combinations
SELECT 
    product_ids,
    product_names
FROM combination_count
WHERE common_combinations = (SELECT MAX(common_combinations) 
			     FROM combination_count);
``` 

| product_ids | product_names                                            |
|-------------|----------------------------------------------------------|
| 2a2353      | Blue Polo Shirt - Mens                                  |
| 2feb6b      | Pink Fluro Polkadot Socks - Mens                        |
| c4a632      | Navy Oversized Jeans - Womens                           |
| c8d436      | Teal Button Up Shirt - Mens                             |
| e83aa3      | Black Straight Jeans - Womens                            |
| b9a74d      | White Striped Socks - Mens                               |
| d5e9a6      | Khaki Suit Jacket - Womens                               |
| 5d267b      | White Tee Shirt - Mens                                   |
| e31d39      | Cream Relaxed Jeans - Womens                             |


My solution for [D. Bonus Question.](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.7%20-%20Balanced%20Tree%20Clothing%20Co/Solutions/D.%20Bonus%20Question.md)
