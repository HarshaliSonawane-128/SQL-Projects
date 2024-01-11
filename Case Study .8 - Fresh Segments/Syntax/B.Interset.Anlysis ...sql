
select * from fresh_segments.interest_metrics; 
select * from fresh_segments.interest_map; 

/* 1. Which interests have been present in all month_year dates in our dataset? */
select count(month_year) as  unique_month_year_count, 
		count( distinct interest_id) as  unique_interest_id_count
from fresh_segments.interest_metrics;

/* 2.Using this same total_months measure - calculate the cumulative percentage of all records starting at
    14 months - which total_months value passes the 90% cumulative percentage value? */
    
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

/* 3. If we were to remove all interest_id values which are lower than the total_months
  value we found in the previous question - how many total data points would we be removing? */
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
  
  
  /* 4. Does this decision make sense to remove these data points from a business perspective?
  Use an example where there are all 14 months present to a removed interest example for your arguments - 
  think about what it means to have less months present from a segment perspective. */
  
  select min( month_year) AS first_date,
		max(month_year) as last_date
	from fresh_segments.interest_metrics ;
    

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


/* 5. After removing these interests - how many unique interests are there for each month?*/

create table interest_metrics_edited as 
select * 
   from  fresh_segments.interest_metrics
   where interest_id not in ( select interest_id from fresh_segments.interest_metrics
                              where interest_id is not null
                              group by interest_id
                              having count(distinct month_year)<6);

select
  month_year ,
  count(distinct interest_id) as unique_interst 
from interest_metrics_edited 
where month_year is not null
group by month_year order by month_year ;
