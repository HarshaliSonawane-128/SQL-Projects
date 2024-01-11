

select * from fresh_segments.interest_metrics; 
select * from fresh_segments.interest_map; 

/* 1. Using our filtered dataset by removing the interests with less than 6 months
 worth of data, which are the top 10 and bottom 10 interests which have the largest composition values in 
 any month_year? Only use the  maximum composition value for each interest but you must keep the
 corresponding month_year.*/
 
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
 
 select month_year ,interest_name,
 count(interest_id ) as intersets
 from fresh_segments.interest_metrics  me
 join fresh_segments.interest_map  ma 
 on me.interest_id = ma.id 
 where month_year > 6
 group by month_year ,interest_name
 order by  count(interest_id ) asc
 limit 10 ;
 
 /* 2. Which 5 interests had the lowest average ranking value?*/
 
select 
	  interest_name,
      avg(ranking) as ranking_value 
 from fresh_segments.interest_metrics  me
 join fresh_segments.interest_map  ma 
 on me.interest_id = ma.id 
 group by interest_id , interest_name 
 order by ranking_value 
 limit 5 ;

/* 3. Which 5 interests had the largest standard deviation in their percentile_ranking value? */ 

select 
	  interest_name,
      round(stddev(percentile_ranking),2) as std_percentile_ranking_value  
 from fresh_segments.interest_metrics  me
 join fresh_segments.interest_map  ma 
 on me.interest_id = ma.id 
 group by interest_id , interest_name 
 order by std_percentile_ranking_value  desc
 limit 5;
 

