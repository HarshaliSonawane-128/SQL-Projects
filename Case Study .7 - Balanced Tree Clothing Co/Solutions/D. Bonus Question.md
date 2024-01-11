
# 👕 Case Study #7 - Balanced Tree Clothing Co.
## D. Bonus Question
Use a single SQL query to transform the `product_hierarchy` and `product_prices` datasets to the product_details table

```sql 
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
 ```

 | product_id | price | product_name                   | category_id | segment_id | style_id | category_name | segment_name | style_name     |
|------------|-------|--------------------------------|-------------|------------|----------|---------------|--------------|----------------|
| d5e9a6     | 23    | Khaki Suit Jacket - Womens     | 1           | 4          | 10       | Womens        | Jacket       | Khaki Suit     |
| d5e9a6     | 23    | Khaki Suit Jacket - Womens     | 1           | 4          | 10       | Womens        | Jacket       | Khaki Suit     |
| 72f5d4     | 19    | Indigo Rain Jacket - Womens    | 1           | 4          | 11       | Womens        | Jacket       | Indigo Rain    |
| 72f5d4     | 19    | Indigo Rain Jacket - Womens    | 1           | 4          | 11       | Womens        | Jacket       | Indigo Rain    |
| 9ec847     | 54    | Grey Fashion Jacket - Womens   | 1           | 4          | 12       | Womens        | Jacket       | Grey Fashion   |
| 9ec847     | 54    | Grey Fashion Jacket - Womens   | 1           | 4          | 12       | Womens        | Jacket       | Grey Fashion   |
| c4a632     | 13    | Navy Oversized Jeans - Womens  | 1           | 3          | 7        | Womens        | Jeans        | Navy Oversized |
| c4a632     | 13    | Navy Oversized Jeans - Womens  | 1           | 3          | 7        | Womens        | Jeans        | Navy Oversized |
| e83aa3     | 32    | Black Straight Jeans - Womens  | 1           | 3          | 8        | Womens        | Jeans        | Black Straight |
| e83aa3     | 32    | Black Straight Jeans - Womens  | 1           | 3          | 8        | Womens        | Jeans        | Black Straight |
| e31d39     | 10    | Cream Relaxed Jeans - Womens   | 1           | 3          | 9        | Womens        | Jeans        | Cream Relaxed  |
| e31d39     | 10    | Cream Relaxed Jeans - Womens   | 1           | 3          | 9        | Womens        | Jeans        | Cream Relaxed  |
| ...        | ...   | ...                            | ...         | ...        | ...      | ...           | ...          | ...            |
