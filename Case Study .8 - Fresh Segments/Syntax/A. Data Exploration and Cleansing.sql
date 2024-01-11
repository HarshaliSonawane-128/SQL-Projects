
select * from fresh_segments.interest_metrics;

/* 1. Update the fresh_segments.interest_metrics table by modifying the month_year 
       column to be a date data type with the start of the month*/

ALTER TABLE fresh_segments.interest_metrics
ADD COLUMN temp_date DATE;

UPDATE fresh_segments.interest_metrics
SET temp_date = STR_TO_DATE(month_year, '%d-%m-%Y');

ALTER TABLE fresh_segments.interest_metrics
DROP COLUMN month_year;

ALTER TABLE fresh_segments.interest_metrics
CHANGE COLUMN temp_date month_year DATE;

select * from fresh_segments.interest_metrics;

/* 2. What is count of records in the fresh_segments.interest_metrics for each month_year value sorted in chronological order 
(earliest to latest) with the null values appearing first?*/

select month(month_year) as month ,
       count(*) as records 
from fresh_segments.interest_metrics 
group by month(month_year)
order by month(month_year) asc;


/* 3. What do you think we should do with these null values in the fresh_segments.interest_metrics? */
select fresh_segments.interest_metrics;
where month_year is null ;

/* 4. How many interest_id values exist in the fresh_segments.interest_metrics table but not in the 
       fresh_segments.interest_map table? What about the other way around?*/
       
select count(distinct map.id) as map_id_count,
       count(distinct metrics.interest_id ) as  metrics_id_count,
       sum(case when map.id is null then 1 end) as not_in_metric ,
       sum(case when metrics.interest_id is null then 1 end ) as not_in_map
from fresh_segments.interest_metrics metrics 
join fresh_segments.interest_map map
ON metrics.interest_id = map.id;

/* 5. Summarise the id values in the fresh_segments.interest_map by its total record count in this table *? */
select count(*) as map_id_count
from fresh_segments.interest_map ;

/* 7. What sort of table join should we perform for our analysis and why? 
  Check your logic by checking the rows where interest_id = 21246 in your  joined output and include all 
  columns from fresh_segments.interest_metrics and all columns from 
  fresh_segments.interest_map except from the id column.*/
  
  select * from fresh_segments.interest_map;
  
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

/* 7. Are there any records in your joined table where the month_year value is before the created_at value 
  from the fresh_segments.interest_map table? Do you think these values are valid and why? */
  select * 
  from fresh_segments.interest_map map 
  join fresh_segments.interest_metrics metrics 
  on map.id = metrics.interest_id 
  where metrics.month_year < map.created_at ;
