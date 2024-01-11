
# 🛒 Case Study .5 - Data Mart
## A. Data Cleansing Steps

- In a single query, perform the following operations and generate a new table in the `data_mart` schema named **`clean_weekly_sales`**:

- Convert the **`week_date`** to a `DATE` format

- Add a `week_number` as the second column for each **`week_date` value**, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc

- Add a **`month_number`** with the calendar month for each `week_date` value as the 3rd column

- Add a **`calendar_year`** column as the 4th column containing either 2018, 2019 or 2020 values

- Add a new column called `age_band`after the original `segment` column using the following mapping on the number inside the `segment` value

| segment | age_band      | 
|---------|---------------|
| 1       | Young Adults  | 
| 2       | Middle Aged   | 
| 3 or 4  | Retirees       | 


- Add a new `demographic` column using the following mapping for the first letter in the `segment` values

| Segment | Demographic |
| ------- | ----------- |
| C       | Couples     |
| F       | Families    |


- Ensure all `null` string values with an "`unknown`" string value in the original `segment` column as well as the new `age_band` and demographic columns
- Generate a new `avg_transaction` column as the sales value divided by `transactions` rounded to 2 decimal places for each record


```sql 
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
```

```sql
select * from data_mart.clean_weekly_sales;
```

| Date    | Date (Formatted) | Week | Month | Year | Region        | Platform | Segment | Status   | SKU  | Revenue   | Profit    | Customer Group | Household Type | Avg. Purchase |
|---------|------------------|------|-------|------|---------------|----------|---------|----------|------|-----------|-----------|-----------------|-----------------|---------------|
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | ASIA          | Retail   | C3      | New      | 120631 | 3656163   | Retirees        | Couples         | 30.31         |
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | ASIA          | Retail   | F1      | New      | 31574  | 996575    | Young Adults    | Families        | 31.56         |
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | USA           | Retail   | null    | Guest    | 529151 | 16509610  | null            | null            | 31.20         |
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | EUROPE        | Retail   | C1      | New      | 4517   | 141942    | Young Adults    | Couples         | 31.42         |
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | AFRICA        | Retail   | C2      | New      | 58046  | 1758388   | Middle Aged     | Couples         | 30.29         |
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | CANADA        | Shopify  | F2      | Existing | 1336   | 243878    | Middle Aged     | Families        | 182.54        |
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | AFRICA        | Shopify  | F3      | Existing | 2514   | 519502    | Retirees        | Families        | 206.64        |
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | ASIA          | Shopify  | F1      | Existing | 2158   | 371417    | Young Adults    | Families        | 172.11        |
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | AFRICA        | Shopify  | F2      | New      | 318    | 49557     | Middle Aged     | Families        | 155.84        |
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | AFRICA        | Retail   | C3      | New      | 111032 | 3888162   | Retirees        | Couples         | 35.02         |
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | USA           | Shopify  | F1      | Existing | 1398   | 260773    | Young Adults    | Families        | 186.53        |
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | OCEANIA       | Shopify  | C2      | Existing | 4661   | 882690    | Middle Aged     | Couples         | 189.38        |
| 31/8/20 | 2031-08-20       | 33   | 8     | 2031 | SOUTH AMERICA | Retail   | C2      | Existing | 1029   | 38762     | Middle Aged     | Couples         | 37.67         |


MY Solution of [B.Data Exploration](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.5%20-%20Data%20Mart/Solution/B.%20Data%20Exploration.md)
