
# 🛒 Case Study #5 - Data Mart
## B. Data Exploration
##  1.What day of the week is used for each week_date value? 
```sql
SELECT DISTINCT dayname(week_date) AS day_of_week
FROM data_mart.clean_weekly_sales;
```
| Day       |
| --------- |
| Sunday    |
| Monday    |
| Tuesday   |
| Wednesday |
| Thursday  |
| Friday    |
| Saturday  |


## 2.How many total transactions were there for each year in the dataset?

```sql 
select year(week_date) as year ,
       sum(transactions) as total_transuaction 
from data_mart.clean_weekly_sales
group by year(week_date);
``` 

| Year | Value      |
|------|------------|
| 2031 | 15830547   |
| 2024 | 30883453   |
| 2017 | 30832544   |
| 2010 | 30803775   |
| 3    | 44843030   |
| 2027 | 61217283   |
| 2020 | 60429433   |
| 2013 | 61672627   |
| 6    | 61750866   |
| 2029 | 46245052   |
| 2022 | 46168746   |
| 2015 | 45106177   |
| 8    | 452


## 3.What is the total sales for each region for each month?*/

```sql
select region ,
       month(week_date ) as months ,
       monthname(week_date) as month_name ,
        sum(sales) as total_sales 
from  data_mart.clean_weekly_sales
group by region ;
```

| Region         | Day | Month      | Value        |
|----------------|-----|------------|--------------|
| ASIA           | 8   | August     | 1663320609   |
| USA            | 8   | August     | 712002790    |
| EUROPE         | 8   | August     | 122102995    |
| AFRICA         | 8   | August     | 1809596890   |
| CANADA         | 8   | August     | 447073019    |
| OCEANIA        | 8   | August     | 2432313652   |
| SOUTH AMERICA  | 8   | August     | 221166052    |
| AFRICA         | 7   | July       | 1960219710   |
| CANADA         | 7   | July       | 477134947    |
| ...            | ... | ...        | ...          |


### 4.What is the total count of transactions for each platform*/

```sql
SELECT platform,
       sum(transactions) AS transactions_count
FROM data_mart.clean_weekly_sales
GROUP BY 1;
```

| Company | Revenue     |
|---------|-------------|
| Retail  | 1081934227  |
| Shopify | 5925169     |

## 6.What is the percentage of sales for Retail vs Shopify for each month?

```sql
SELECT 
    month(week_date) AS month,
    100 * SUM(CASE WHEN  platform = 'Retail' THEN sales ELSE 0 END) / SUM(sales) AS pct_Retail,
    100 * SUM(CASE WHEN platform = 'Shopify' THEN sales ELSE 0 END) / SUM(sales) AS pct_Shopify
FROM data_mart.clean_weekly_sales 
GROUP BY  month 
order by month ;
``` 

|   | Value 1 | Value 2 |
|---|---------|---------|
| 3 | 97.5403 | 2.4597  |
| 4 | 97.5939 | 2.4061  |
| 5 | 97.3047 | 2.6953  |
| 6 | 97.2713 | 2.7287  |
| 7 | 97.2889 | 2.7111  |
| 8 | 97.0824 | 2.9176  |
| 9 | 97.3754 | 2.6246  |


###  7.What is the percentage of sales by demographic for each year in the dataset?

```sql
SELECT 
    YEAR(week_date) AS years,
    100 * SUM(CASE WHEN demographic = 'Families' THEN sales ELSE 0 END) / SUM(sales) AS pct_families,
    100 * SUM(CASE WHEN demographic = 'Couples' THEN sales ELSE 0 END) / SUM(sales) AS pct_couples,
    100 * SUM(CASE WHEN demographic  = 'null' THEN sales ELSE 0 END) / SUM(sales) AS pct_unknown
FROM data_mart.clean_weekly_sales
GROUP BY years 
order by years;
```

| years | pct_families 1 | pct_couples 2 | pct_unknown 3 |
|------|----------|----------|----------|
| 2010 | 32.4286  | 28.1563  | 39.4151  |
| 2011 | 32.4687  | 27.6265  | 39.9048  |
| 2012 | 32.7024  | 27.1317  | 40.1659  |
| 2013 | 32.6964  | 27.7504  | 39.5531  |
| 2014 | 32.1420  | 26.2448  | 41.6132  |
| 2015 | 32.9020  | 27.7499  | 39.3481  |
| 2016 | 32.1695  | 26.2041  | 41.6264  |
| 2017 | 32.6077  | 28.2801  | 39.1122  |
| 2018 | 32.4748  | 27.9649  | 39.5603  |
| 2019 | 32.7080  | 27.1895  | 40.1025  |
| 2020 | 32.6968  | 27.6960  | 39.6073  |
| 2021 | 32.1426  | 26.4695  | 41.3879  |
| 2022 | 32.5608  | 27.5466  | 39.8925  |
| 2023 | 32.3958  | 27.3717  | 40.2325  |
| 2024 | 32.3958  | 28.4399  | 39.1643  |
| 2025 | 32.0110  | 27.5756  | 40.4134  |
| 2026 | 32.0286  | 26.9571  | 41.0143  |
| 2027 | 32.6184  | 27.7727  | 39.6090  |
| 2028 | 32.2448  | 26.3117  | 41.4435  |
| 2029 | 32.5239  | 27.6628  | 39.8133  |
| 2030 | 31.9808  | 26.9598  | 41.0593  |
| 2031 | 33.0216  | 28.7608  | 38.2176  |

## 8.Which age_band and demographic values contribute the most to Retail sales?*/

```sql
select age_band , demographic ,sum(sales) as most_sales  
FROM data_mart.clean_weekly_sales 
where  platform = 'Retail'
GROUP BY 1 ,2 
order by 3 Desc;
``` 

| age_band      | demographic | most_sales    |
|---------------|-------------|---------------|
| null          | null        | 16067285533   |
| Retirees      | Families    | 6634686916    |
| Retirees      | Couples     | 6370580014    |
| Middle Aged   | Families    | 4354091554    |
| Young Adults  | Couples     | 2602922797    |
| Middle Aged   | Couples     | 1854160330    |
| Young Adults  | Families    | 1770889293    |


###  9.Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?*/
    
```sql 
    SELECT year(week_date),
       platform,
       ROUND(SUM(sales)/SUM(transactions), 2) AS correct_avg,
       ROUND(AVG(transactions), 2) AS incorrect_avg
FROM data_mart.clean_weekly_sales
GROUP BY 1,
         2;
```

| Year(Week_Date) | Platform | Correct_Avg | Incorrect_Avg |
|-----------------|----------|-------------|---------------|
| 2031            | Retail   | 36.30       | 132070.98     |
| 2031            | Shopify  | 184.92      | 958.82        |
| 2024            | Retail   | 36.28       | 128943.65     |
| 2024            | Shopify  | 181.98      | 822.22        |
| 2017            | Retail   | 36.08       | 128731.45     |
| 2017            | Shopify  | 178.85      | 817.05        |
| 2010            | Retail   | 36.20       | 128600.79     |
| 2010            | Shopify  | 179.59      | 826.84        |
| 3               | Shopify  | 185.57      | 688.18        |
| 3               | Retail   | 36.65       | 124924.48     |
| 2027            | Shopify  | 181.91      | 755.02        |
| 2027            | Retail   | 36.45       | 127854.30     |
| 2020            | Retail   | 36.50       | 126208.51     |
| 2020            | Shopify  | 183.95      | 745.64        |
| 2013            | Shopify  | 184.71      | 720.89        |
| 2013            | Retail   | 36.58       | 128843.45     

