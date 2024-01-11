
select * from data_mart.weekly_sales;

CREATE TABLE data_mart.clean_weekly_sales AS
SELECT
    week_date ,
	date(week_date) , 
	week(week_date) , 
	month(week_date) ,
	year(week_date),
    region , 
    platform , 
    segment , 
    customer_type , 
    transactions ,
    sales ,
	cASE  
		WHEN RIGHT(segment, 1) = '1' THEN 'Young Adults'
		WHEN RIGHT(segment, 1) = '2' THEN 'Middle Aged'
		WHEN RIGHT(segment, 1) IN ('3', '4') THEN 'Retirees'
		ELSE 'null' END AS age_band,
	case 
		when left(segment , 1 ) = 'C' then 'couples' 
		when left(segment ,1 ) = 'F' then 'Families' 
		else 'null' End as demographic , 
		round( sales/transactions ,  2) as avg_transuction            
FROM data_mart.weekly_sales ;

select * from data_mart.clean_weekly_sales;

 
/* 1.What day of the week is used for each week_date value? */
SELECT DISTINCT dayname(week_date) AS day_of_week
FROM data_mart.clean_weekly_sales;

/* 2. What range of week numbers are missing from the dataset?*/
select distinct week(week_date) as week_number
FROM data_mart.clean_weekly_sales
order by week(week_date) ASC;

-- Missing week numbers: Week 1 to 11 and week 36 to 52

/* 3.How many total transactions were there for each year in the dataset?*/
select year(week_date) as year ,
       sum(transactions) as total_transuaction 
from data_mart.clean_weekly_sales
group by year(week_date);

/* 4.What is the total sales for each region for each month?*/
select region ,
       month(week_date ) as months ,
       monthname(week_date) as month_name ,
        sum(sales) as total_sales 
from  data_mart.clean_weekly_sales
group by region , month(week_date) ,  monthname(week_date);

/* 5.What is the total count of transactions for each platform*/

SELECT platform,
       sum(transactions) AS transactions_count
FROM data_mart.clean_weekly_sales
GROUP BY 1;

/* 6.What is the percentage of sales for Retail vs Shopify for each month?*/
SELECT 
    month(week_date) AS month,
    100 * SUM(CASE WHEN  platform = 'Retail' THEN sales ELSE 0 END) / SUM(sales) AS pct_Retail,
    100 * SUM(CASE WHEN platform = 'Shopify' THEN sales ELSE 0 END) / SUM(sales) AS pct_Shopify
FROM data_mart.clean_weekly_sales 
GROUP BY  month 
order by month ; 

/* 7.What is the percentage of sales by demographic for each year in the dataset?*/
SELECT 
    YEAR(week_date) AS years,
    100 * SUM(CASE WHEN demographic = 'Families' THEN sales ELSE 0 END) / SUM(sales) AS pct_families,
    100 * SUM(CASE WHEN demographic = 'Couples' THEN sales ELSE 0 END) / SUM(sales) AS pct_couples,
    100 * SUM(CASE WHEN demographic  = 'null' THEN sales ELSE 0 END) / SUM(sales) AS pct_unknown
FROM data_mart.clean_weekly_sales
GROUP BY years 
order by years;


/* 8.Which age_band and demographic values contribute the most to Retail sales?*/
select age_band , demographic ,sum(sales) as most_sales  
FROM data_mart.clean_weekly_sales 
where  platform = 'Retail'
GROUP BY 1 ,2 
order by 3 Desc;

/* 9.Can we use the avg_transaction column to find the average transaction size for each year 
    for Retail vs Shopify? If not - how would you calculate it instead?*/
    
    SELECT year(week_date),
       platform,
       ROUND(SUM(sales)/SUM(transactions), 2) AS correct_avg,
       ROUND(AVG(transactions), 2) AS incorrect_avg
FROM data_mart.clean_weekly_sales
GROUP BY 1,
         2;
