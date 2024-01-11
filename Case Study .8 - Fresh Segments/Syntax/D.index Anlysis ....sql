/* 1. What is the top 10 interests by the average composition for each month? */

select 
       month_year , 
       interest_name,
       round(avg(composition),2) as avg_comp
from fresh_segments.interest_metrics  me
join fresh_segments.interest_map ma 
on me.interest_id = ma.id 
group by interest_name,month_year 
limit 10 ;

/* 2. What is the average of the average composition for the top 10 interests for each month? */
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