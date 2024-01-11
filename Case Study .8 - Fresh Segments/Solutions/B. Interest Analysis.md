
# 🍊 Case Study #8 - Fresh Segments
## B. Interest Analysis

### 1. Which interests have been present in all month_year dates in our dataset? */

```sql
select count(month_year) as  unique_month_year_count, 
		count( distinct interest_id) as  unique_interest_id_count
from fresh_segments.interest_metrics;
```

|  unique_month_year_count   | unique_interest_id_count |
|--------|-------|
| 13079 |  1202 |


### 2.Using this same total_months measure - calculate the cumulative percentage of all records starting at14 months - which total_months value passes the 90% cumulative percentage value? 
```sql
    
WITH interest_months AS (
    SELECT
        interest_id,
        COUNT(DISTINCT month_year) AS total_months
    FROM fresh_segments.interest_metrics
    WHERE interest_id IS NOT NULL
    GROUP BY interest_id
),
interest_count AS (
    SELECT
        total_months,
        COUNT(interest_id) AS interests
    FROM interest_months
    GROUP BY total_months
)
SELECT
    total_months,
    interests,
    100 * SUM(interests) OVER (ORDER BY total_months DESC) / SUM(interests) OVER () AS cumulative_pct
FROM interest_count;
```

|total_months |int | cumulative_pct |
|----------|----------|----------|
|   14     |   480    |  39.9334 |
|   13     |   82     |  46.7554 |
|   12     |   65     |  52.1631 |
|   11     |   94     |  59.9834 |
|   10     |   86     |  67.1381 |
|   9      |   95     |  75.0416 |
|   8      |   67     |  80.6156 |
|   7      |   90     |  88.1032 |
|   6      |   33     |  90.8486 |
|   5      |   38     |  94.0100 |
|   4      |   32     |  96.6722 |
|   3      |   15     |  97.9201 |
|   2      |   12     |  98.9185 |
|   1      |   13     | 100.0000 |


### 3. If we were to remove all interest_id values which are lower than the total_months value we found in the previous question - how many total data points would we be removing? 

```sql 
WITH interest_months AS (
  SELECT
    interest_id,
    COUNT(DISTINCT month_year) AS total_months
  FROM fresh_segments.interest_metrics
  WHERE interest_id IS NOT NULL
  GROUP BY interest_id
)

SELECT 
  COUNT(interest_id) AS interests,
  COUNT(DISTINCT interest_id) AS unique_interests
FROM fresh_segments.interest_metrics
WHERE interest_id IN (
  SELECT interest_id 
  FROM interest_months
  WHERE total_months < 6);
  ```

  |interest|unique_interests|
  |---|---|
  |400|110|
  
### 4. Does this decision make sense to remove these data points from a business perspective?Use an example where there are all 14 months present to a removed interest example for your arguments - think about what it means to have less months present from a segment perspective. 

```sql
  
  select min( month_year) AS first_date,
		max(month_year) as last_date
	from fresh_segments.interest_metrics ;
```
| Start Date   | End Date     |
|--------------|--------------|
| 2018-07-01   | 2019-08-01   |

```sql
SELECT 
  month_year,
  COUNT(DISTINCT interest_id) interest_count,
  MIN(ranking) AS highest_rank,
  MAX(composition) AS composition_max,
  MAX(index_value) AS index_max
FROM fresh_segments.interest_metrics metrics
WHERE interest_id IN (
  SELECT interest_id
  FROM fresh_segments.interest_metrics
  WHERE interest_id IS NOT NULL
  GROUP BY interest_id
  HAVING COUNT(DISTINCT month_year) = 14)
GROUP BY month_year
ORDER BY month_year, highest_rank;
```

| month_year | interest_count | highest_rank | composition_max | index_max |
|------------|-----------------|--------------|------------------|-----------|
| 2018-07-01 | 480             | 1            | 18.82            | 6.19      |

```sql

SELECT 
  month_year,
  COUNT(DISTINCT interest_id) interest_count,
  MIN(ranking) AS highest_rank,
  MAX(composition) AS composition_max,
  MAX(index_value) AS index_max
FROM fresh_segments.interest_metrics metrics
WHERE interest_id IN (
  SELECT interest_id
  FROM fresh_segments.interest_metrics
  WHERE interest_id IS NOT NULL
  GROUP BY interest_id
  HAVING COUNT(DISTINCT month_year) = 1)
GROUP BY month_year
ORDER BY month_year, highest_rank;
```


###  5. After removing these interests - how many unique interests are there for each month?*/
```sql
create table interest_metrics_edited as 
select * 
   from  fresh_segments.interest_metrics
   where interest_id not in ( select interest_id from fresh_segments.interest_metrics
                              where interest_id is not null
                              group by interest_id
                              having count(distinct month_year)<6);
```

```sql

select
  month_year ,
  count(distinct interest_id) as unique_interst 
from interest_metrics_edited 
where month_year is not null
group by month_year order by month_year ;
``` 

| month_year       | unique_interest |
|------------|-------|
| 2018-07-01 | 709   |
| 2018-08-01 | 752   |
| 2018-09-01 | 774   |
| 2018-10-01 | 853   |
| 2018-11-01 | 925   |
| 2018-12-01 | 986   |
| 2019-01-01 | 966   |
| 2019-02-01 | 1072  |
| 2019-03-01 | 1078  |
| 2019-04-01 | 1035  |
| 2019-05-01 | 827   |
| 2019-06-01 | 804   |
| 2019-07-01 | 836   |
| 2019-08-01 | 1062  |

My Solution for [C.Segment Anlysis ](https://github.com/HarshaliSonawane-128/SQL-Projects/edit/main/Case%20Study%20.8%20-%20Fresh%20Segments/Solutions/C.%20Segment%20Analysis.md) 
