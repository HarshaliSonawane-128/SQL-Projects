

select * from balanced_tree.product_details;
select * from balanced_tree.product_hierarchy;
select * from balanced_tree.product_prices ;
select * from balanced_tree.sales ;

/* 1. What are the top 3 products by total revenue before discount?*/
select p.product_name ,
      sum(s.qty*s.price) as total_ravenue 
from balanced_tree.product_details p
join balanced_tree.sales s
on p.product_id = s.prod_id 
group by p.product_name
order by sum(s.qty*s.price) desc 
limit 3 ;

/* 2.What is the top selling product for each segment?*/
select
	  p.segment_name ,
	  p.product_name ,
      sum(s.qty*s.price) as total_ravenue 
from balanced_tree.product_details p
join balanced_tree.sales s
on p.product_id = s.prod_id 
group by  p.segment_name , p.product_name
order by sum(s.qty*s.price) desc  ;

/* 3.What is the total quantity, revenue and discount for each segmnt?*/
select
	 p.segment_name ,
      sum(s.qty) as total_quantity,
      sum(s.qty*s.price) as total_ravenue ,
      sum(s.qty*s.price*s.discount) as total_discount
from balanced_tree.product_details p
join balanced_tree.sales s
on p.product_id = s.prod_id 
group by  p.segment_name ;

/* 3.What is the total quantity, revenue and discount for each category ?*/
select
	 p.category_name ,
      sum(s.qty) as total_quantity,
      sum(s.qty*s.price) as total_ravenue ,
      sum(s.qty*s.price*s.discount) as total_discount
from balanced_tree.product_details p
join balanced_tree.sales s
on p.product_id = s.prod_id 
group by  p.category_name ;


/* 4.What is the top selling product for each segment?*/
select
	  p.segment_name ,
      sum(s.qty*s.price) as total_ravenue 
from balanced_tree.product_details p
join balanced_tree.sales s
on p.product_id = s.prod_id 
group by  p.segment_name  
order by sum(s.qty*s.price) desc ;


/* 4.What is the top selling product for each segment?*/
select
	  p.category_name ,
      sum(s.qty*s.price) as total_ravenue 
from balanced_tree.product_details p
join balanced_tree.sales s
on p.product_id = s.prod_id 
group by  p.category_name  
order by sum(s.qty*s.price) desc 
;

/* 5.What is the percentage split of revenue by product for each segment?*/
SELECT 
    p.segment_name,
    p.product_name,
    100 * SUM(s.qty * s.price) / SUM(SUM(s.qty * s.price)) OVER (PARTITION BY p.segment_name) AS segment_product_pct
FROM balanced_tree.product_details p
JOIN balanced_tree.sales s 
ON p.product_id = s.prod_id
GROUP BY p.segment_name, p.product_name;

/* 6.What is the percentage split of revenue by segment for each category?*/
SELECT 
    p.category_name,
	p.segment_name,
    100 * SUM(s.qty * s.price) / SUM(SUM(s.qty * s.price)) OVER (PARTITION BY p.category_name) AS segment_category_pct
FROM balanced_tree.product_details p
JOIN balanced_tree.sales s 
ON p.product_id = s.prod_id
GROUP BY p.segment_name, p.category_name;

/* 7.What is the percentage split of total revenue by category?*/
select p.category_name ,
       sum(s.qty*s.price) as total_revenue 
FROM balanced_tree.product_details p
JOIN balanced_tree.sales s 
ON p.product_id = s.prod_id
GROUP BY  p.category_name;


/*8. What is the total transaction “penetration” for each product?
  (hint: penetration = number of transactions where at least 1 quantity of a product
  was purchased divided by total number of transactions)*/
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
  
/* 9.What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?*/

-- Count the number of products in each transaction
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