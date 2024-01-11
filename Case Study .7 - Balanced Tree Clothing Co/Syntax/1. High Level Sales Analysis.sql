
select * from balanced_tree.product_details;
select * from balanced_tree.product_hierarchy;
select * from balanced_tree.product_prices ;
select * from balanced_tree.sales ;

/* 1. What was the total quantity sold for each products? */
select product_name , sum(qty) as quantitiy_sold
from balanced_tree.product_details d
join balanced_tree.sales s
on d.product_id = s.prod_id 
group by d.product_name;

/* 1.1  What was the total quantity sold for all products? */
select sum(qty) as quantitiy_sold 
from balanced_tree.sales ;

/* 2. What is the total generated revenue for each products before discounts?*/
SELECT SUM(qty * price) AS revenue_before_discounts
FROM balanced_tree.sales;

/* 3. What was the total discount amount for all products?*/
select sum(qty*price*discount) /100 as total_discount
from balanced_tree.sales ;
