
select * from retails_sales_.shopping_trends;

select* from retails_sales_.shopping_trends_updated;

/*1.The ratio of male to female customers is about 68:32, using the data the store has on female customers,
what strategy do you recommend the store puts in place to attract more female customers.*/

With total as (
SELECT
	Gender,
	count(`Customer ID`) as client_count

FROM retails_sales_.shopping_trends_updated
Group by 1
Order by 2 desc
)
Select
	sum(case when Gender = 'Male' then client_count else 0 end) count_male,
	sum(case when Gender = 'Female' then client_count else 0 end) count_Female,
	round(sum(case when Gender = 'Male' then client_count else 0 end)/
     (sum(case when Gender = 'Male' then client_count else 0 end)
     + sum(case when Gender = 'Female' then client_count else 0 end)) *100,2) pct_male,

	round(sum(case when Gender = 'Female' then client_count else 0 end)/
     (sum(case when Gender = 'Male' then client_count else 0 end)
     + sum(case when Gender = 'Female' then client_count else 0 end)) *100,2) pct_female
from total
;

-- 2. What Female Age Group do we mostly serve?
select  
case when age between 18 and 31 then '18-31'
      when age between 32 and 45 then '32-45'
      when age between 46 and 59 then '49-59' 
      when age between 60 and 70 then '60-70'
end as age_groups ,
count(`Customer ID`) as client_count 
from retails_sales_.shopping_trends_updated
group by 1
order by 2
desc ;

-- 3. What is the most and least popular category?
select 
category ,
count(`Customer ID`) as client_count 
from retails_sales_.shopping_trends_updated
group by 1
order by 2 ;
 
-- 4. top 20 popular item purches ?
select 
`Item Purchased`, 
count( `Customer ID` ) as item_purchesd 
from retails_sales_.shopping_trends_updated
group by 1 
order by 2 desc 
limit 20 ;

-- 5.Which season has the most purchases?
select 
Season ,
count(`Customer ID`) as Purches_count 
from retails_sales_.shopping_trends_updated
group by Season
order by 2 desc ;

-- 6 .Most popular payment method ?
select 
`Payment Method` ,
count(`Customer ID`) as Purches_count 
from retails_sales_.shopping_trends_updated
group by 1 
order by 2 desc ;

-- 7. Most popular shipping type
select 
	`Shipping Type`,
    count(`Customer ID`) as purchase_count

 from retails_sales_.shopping_trends_updated
group by 1
order by 2 desc;

# -- 8. What is the most popular age group served? Find the most purchased item by that age group

 
 SELECT Case
     when Age between 18 and 31 then '18-31'
     when Age between 32 and 45 then '32-45'
     when Age between 46 and 59 then '46-59'
     when Age between 60 and 70 then '60-70'
	end as age_groups,
    `Item Purchased`,
    -- `Customer ID`,
    count(`Customer ID`) as client_count
FROM retails_sales_.shopping_trends_updated
Group by 1,2
Having age_groups = '46-59'
 Order by 3 desc
# -- )
;

# --9. What is the most popular age group served? Find the most common payment method used by the most popular age group served.

SELECT

Case
     when Age between 18 and 31 then '18-31'
     when Age between 32 and 45 then '32-45'
     when Age between 46 and 59 then '46-59'
     when Age between 60 and 70 then '60-70'
	end as age_groups,
`Payment Method`,
count(`Customer ID`) as no_clients
FROM retails_sales_.shopping_trends_updated
group by 1,2
Having age_groups = '46-59'
Order by 3 desc;

