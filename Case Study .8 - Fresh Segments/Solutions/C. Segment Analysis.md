
# 🍊 Case Study #8 - Fresh Segments
## C. Segment Analysis

### 1. Using our filtered dataset by removing the interests with less than 6 monthsworth of data, which are the top 10 and bottom 10 interests which have the largest composition values in any month_year? Only use the  maximum composition value for each interest but you must keep the corresponding month_year.

```sql 
 select 
 month_year ,
 interest_name,
 count(interest_id ) as intersets
 from fresh_segments.interest_metrics  me
 join fresh_segments.interest_map  ma 
 on me.interest_id = ma.id 
 where month_year > 6
 group by month_year ,interest_name
 order by  count(interest_id ) desc 
 limit 10 ;
 ```
 | month_year | interest_name                           | interests |
|------------|-----------------------------------------|-----------|
| 2019-08-01 | Pizza Lovers                            | 2         |
| 2019-04-01 | Pizza Lovers                            | 2         |
| 2019-03-01 | Pizza Lovers                            | 2         |
| 2019-02-01 | Pizza Lovers                            | 2         |
| 2018-12-01 | Luxury Hotel Guests                     | 1         |
| 2018-12-01 | Urban Skateboarding Sneaker Shoppers    | 1         |
| 2018-12-01 | Gym Equipment Owners                    | 1         |
| 2018-12-01 | Big East Fans                           | 1         |
| 2018-12-01 | Golf Enthusiasts                        | 1         |
| 2018-12-01 |

 ```sql
 select month_year ,interest_name,
 count(interest_id ) as intersets
 from fresh_segments.interest_metrics  me
 join fresh_segments.interest_map  ma 
 on me.interest_id = ma.id 
 where month_year > 6
 group by month_year ,interest_name
 order by  count(interest_id ) asc
 limit 10 ;
 ```

 | month_year | interest_name                        | interests |
|------------|-------------------------------------|-----------|
| 2019-08-01 | Identity Theft Protection Researchers | 1         |
| 2019-08-01 | Price Conscious Home Shoppers        | 1         |
| 2019-08-01 | NHL Fans                            | 1         |
| 2019-08-01 | Home Custom Bedroom Decorators       | 1         |
| 2019-08-01 | Coffee Chain Shoppers               | 1         |
| 2019-08-01 | Custom Home Lighting Shoppers        | 1         |
| 2019-08-01 | Land Rover Shoppers                 | 1         |
| 2019-08-01 | Dieters                             | 1         |
| 2019-08-01 | Online Home Decor Shoppers           | 1         |
| 2019-08-01 | Leather Goods Shoppers               | 1         |

 ### 2. Which 5 interests had the lowest average ranking value?

 ```sql
 
select 
	  interest_name,
      avg(ranking) as ranking_value 
 from fresh_segments.interest_metrics  me
 join fresh_segments.interest_map  ma 
 on me.interest_id = ma.id 
 group by interest_id , interest_name 
 order by ranking_value 
 limit 5 ;
```
| Interest Name                  | ranking_value              |
|---------------------------------|--------------------------|
| Winter Apparel Shoppers         | 1.0000                   |
| Fitness Activity Tracker Users  | 4.1111                   |
| Mens Shoe Shoppers              | 5.9286                   |
| Elite Cycling Gear Shoppers     | 7.8000                   |
| Shoe Shoppers                   | 9.3571                   |

### 3. Which 5 interests had the largest standard deviation in their percentile_ranking value? 

```sql
select 
	  interest_name,
      round(stddev(percentile_ranking),2) as std_percentile_ranking_value  
 from fresh_segments.interest_metrics  me
 join fresh_segments.interest_map  ma 
 on me.interest_id = ma.id 
 group by interest_id , interest_name 
 order by std_percentile_ranking_value  desc
 limit 5;
 ``` 

 | Interest Name           | Std Percentile Ranking Value |
|-------------------------|-----------------------------|
| Blockbuster Movie Fans  | 29.19                       |
| Techies                 | 27.55                       |
| Android Fans            | 27.48                       |
| TV Junkies              | 27.16                       |
| Oregon Trip Planners    | 26.87                       |



My Solution for [D.Index Analysis](https://github.com/HarshaliSonawane-128/SQL-Projects/edit/main/Case%20Study%20.8%20-%20Fresh%20Segments/Solutions/D.Index%20Analysis.md)
