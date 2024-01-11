
# 🍊 Case Study #8 - Fresh Segments
## D. Index Analysis
### 1. What is the top 10 interests by the average composition for each month? 

```sql

select 
       month_year , 
       interest_name,
       round(avg(composition),2) as avg_comp
from fresh_segments.interest_metrics  me
join fresh_segments.interest_map ma 
on me.interest_id = ma.id 
group by interest_name,month_year 
limit 10 ;
```

| month_year | interest_name                                   | avg_comp |
|------------|-------------------------------------------------|----------|
| 2018-07-01 | Vacation Rental Accommodation Researchers      | 11.89    |
| 2018-07-01 | Luxury Second Home Owners                       | 9.93     |
| 2018-07-01 | Online Home Decor Shoppers                      | 10.85    |
| 2018-07-01 | Hair Care Shoppers                              | 10.32    |
| 2018-07-01 | Nutrition Conscious Eaters                      | 10.77    |
| 2018-07-01 | Healthy Eaters                                  | 10.82    |
| 2018-07-01 | Luxury Travel Researchers                       | 11.21    |
| 2018-07-01 | Wine Lovers                                    | 10.71    |
| 2018-07-01 | Home Remodelers                                 | 9.71     |
| 2018-07-01 | Home Design and Living Publication Readers      | 10.11    |


### 2. What is the average of the average composition for the top 10 interests for each month? 
```sql
with cte as (
select 
       month_year , 
       interest_name,
       round(avg(composition),2) as avg_comp
from fresh_segments.interest_metrics  me
join fresh_segments.interest_map ma 
on me.interest_id = ma.id 
group by interest_name,month_year 
limit 10 ) 
select avg(avg_comp) from cte;
```
|avg(avg_comp)|
|---|
|	10.632000000000003|