

select * from balanced_tree.product_details;
select * from balanced_tree.product_hierarchy;
select * from balanced_tree.product_prices ;
select * from balanced_tree.sales ;


SELECT 
  pp.product_id,
  pp.price,
  CONCAT(ph1.level_text, ' ', ph2.level_text, ' - ', ph3.level_text) AS product_name,
  ph2.parent_id AS category_id,
  ph1.parent_id AS segment_id,
  ph1.id AS style_id,
  ph3.level_text AS category_name,
  ph2.level_text AS segment_name,
  ph1.level_text AS style_name
FROM balanced_tree.product_hierarchy ph1
                                         -- self join style level (ph1) with segment level (ph2)
JOIN balanced_tree.product_hierarchy ph2 
ON ph1.parent_id = ph2.id
                                        -- self join segment level (ph2) with category level (ph3)
JOIN balanced_tree.product_hierarchy ph3
ON ph3.id = ph2.parent_id
                                        -- inner join style level (ph1) with table [product_prices] 
JOIN balanced_tree.product_prices pp
 ON ph1.id = pp.id;