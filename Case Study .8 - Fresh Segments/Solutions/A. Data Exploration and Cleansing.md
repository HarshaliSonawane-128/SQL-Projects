# 🍊 Case Study #8 - Fresh Segments
## A. Data Exploration and Cleansing

### 1. Update the `fresh_segments.interest_metrics` table by modifying the `month_year` column to be a date data type with the start of the month*/

```sql 
ALTER TABLE fresh_segments.interest_metrics
ADD COLUMN temp_date DATE;

UPDATE fresh_segments.interest_metrics
SET temp_date = STR_TO_DATE(month_year, '%d-%m-%Y');

ALTER TABLE fresh_segments.interest_metrics
DROP COLUMN month_year;

ALTER TABLE fresh_segments.interest_metrics
CHANGE COLUMN temp_date month_year DATE;
```
```sql

select * from fresh_segments.interest_metrics;
```

| _month | _year | interest_id | composition | index_value | ranking | percentile_ranking | month_year  |
|--------|-------|-------------|-------------|-------------|---------|--------------------|-------------|
| 7      | 2018  | 32486       | 11.89       | 6.19        | 1       | 99.86              | 2018-07-01  |
| 7      | 2018  | 6106        | 9.93        | 5.31        | 2       | 99.73              | 2018-07-01  |
| 7      | 2018  | 18923       | 10.85       | 5.29        | 3       | 99.59              | 2018-07-01  |
| 7      | 2018  | 6344        | 10.32       | 5.1         | 4       | 99.45              | 2018-07-01  |
| 7      | 2018  | 100         | 10.77       | 5.04        | 5       | 99.31              | 2018-07-01  |
| 7      | 2018  | 69          | 10.82       | 5.03        | 6       | 99.18              | 2018-07-01  |
| 7      | 2018  | 79          | 11.21       | 4.97        | 7       | 99.04              | 2018-07-01  |
| 7      | 2018  | 6111        | 10.71       | 4.83        | 8       | 98.9               | 2018-07-01  |
| 7      | 2018  | 6214        | 9.71        | 4.83        | 8       | 98.9               | 2018-07-01  |
| 7      | 2018  | 19422       | 10.11       | 4.81        | 10      | 98.63              | 2018-07-01  |
| 7      | 2018  | 6110        | 11.57       | 4.79        | 11      | 98.49              | 2018-07-01  |


## 2. What is count of records in the `fresh_segments.interest_metrics` for each `month_year` value sorted in chronological order  (earliest to latest) with the null values appearing first?*/
```sql
select month(month_year) as month ,
       count(*) as records 
from fresh_segments.interest_metrics 
group by month(month_year)
order by month(month_year) asc;
```

| month | records  |
|-------|-------|
| 1     | 973   |
| 2     | 1121  |
| 3     | 1136  |
| 4     | 1099  |
| 5     | 857   |
| 6     | 824   |
| 7     | 1593  |
| 8     | 1916  |
| 9     | 780  


### 3. What do you think we should do with these null values in the fresh_segments.interest_metrics? 
```sql
select fresh_segments.interest_metrics;
where month_year is null ;
```

### 4. How many interest_id values exist in the fresh_segments.interest_metrics table but not in the fresh_segments.interest_map table? What about the other way around?*/
```sql       
select count(distinct map.id) as map_id_count,
       count(distinct metrics.interest_id ) as  metrics_id_count,
       sum(case when map.id is null then 1 end) as not_in_metric ,
       sum(case when metrics.interest_id is null then 1 end ) as not_in_map
from fresh_segments.interest_metrics metrics 
join fresh_segments.interest_map map
ON metrics.interest_id = map.id;
```
| map_id_count | metrics_id_count | not_in_metric | not_in_map |
|--------------|------------------|---------------|------------|
| 1202         | 1202             |          null     |   null         |

### 5. Summarise the id values in the fresh_segments.interest_map by its total record count in this table *?

```sql
select count(*) as map_id_count
from fresh_segments.interest_map ;
```
|map_id_count|
|---|
|1209|

### 6. What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where interest_id = 21246 in your  joined output and include all columns from fresh_segments.interest_metrics and all columns from fresh_segments.interest_map except from the id column.*/
  
```sql
  
  select m.* ,
         m.id ,
         m.interest_name ,
         m.interest_summary ,
         m.created_at , 
         m.last_modified 
from fresh_segments.interest_metrics  me 
join fresh_segments.interest_map m 
on me.interest_id = m.id 
where interest_id = 21246;
```
| ID    | Description                       | Start Time             | End Time               |
|-------|-----------------------------------|------------------------|------------------------|
| 21246 | Readers of El Salvadoran Content  | 2018-06-11 17:50:04   | 2018-06-11 17:50:04   |
| 21246 | Readers of El Salvadoran Content  | 2018-06-11 17:50:04   | 2018-06-11 17:50:04   |
| 21246 | Readers of El Salvadoran Content  | 2018-06-11 17:50:04   | 2018-06-11 17:50:04   |
| 21246 | Readers of El Salvadoran Content  | 2018-06-11 17:50:04   | 2018-06-11 17:50:04   |
| 21246 | Readers of El Salvadoran Content  | 2018-06-11 17:50:04   | 2018-06-11 17:50:04   |
| 21246 | Readers of El Salvadoran Content  | 2018-06-11 17:50:04   | 2018-06-11 17:50:04   |
| 21246 | Readers of El Salvadoran Content  | 2018-06-11 17:50:04   | 2018-06-11 17:50:04   |
| 21246 | Readers of El Salvadoran Content  | 2018-06-11 17:50:04   | 2018-06-11 17:50:04   |
| 21246 | Readers of El Salvadoran Content  | 2018-06-11 17:50:04   | 2018-06-11 17:50:04   |
| 21246 | Readers of El Salvadoran Content  | 2018-06-11 17:50:04   | 2018-06-11 17:50:04   |


### 7. Are there any records in your joined table where the month_year value is before the created_at value from the fresh_segments.interest_map table? Do you think these values are valid and why? */

```sql 
  select * 
  from fresh_segments.interest_map map 
  join fresh_segments.interest_metrics metrics 
  on map.id = metrics.interest_id 
  where metrics.month_year < map.created_at ;
```

| id   | interest_name              | interest_summary                                          | created_at          | last_modified       | _month | _year | interest_id | composition | index_value | ranking | percentile_ranking | month_year |
|------|-----------------------------|----------------------------------------------------------|---------------------|---------------------|--------|-------|-------------|-------------|-------------|---------|--------------------|------------|
| 32704| Major Airline Customers    | People visiting sites for major airline brands to plan... | 2018-07-06 14:35:04 | 2018-07-06 14:35:04 | 7      | 2018  | 32704       | 8.04        | 2.27        | 225     | 69.14              | 2018-07-01 |
| 33191| Online Shoppers            | People who spend money online                             | 2018-07-17 10:40:03 | 2018-07-17 10:46:58 | 7      | 2018  | 33191       | 3.99        | 2.11        | 283     | 61.18              | 2018-07-01 |
| 32703| School Supply Shoppers      | Consumers shopping for classroom supplies for K-12 stu... | 2018-07-06 14:35:04 | 2018-07-06 14:35:04 | 7      | 2018  | 32703       | 5.53        | 1.8         | 375     | 48.56              | 2018-07-01 |
| 32701| Womens Equality Advocates   | People visiting sites advocating for women's equal rig... | 2018-07-06 14:35:03 | 2018-07-06 14:35:03 | 7      | 2018  | 32701       | 4.23        | 1.41        | 483     | 33.74              | 2018-07-01 |
