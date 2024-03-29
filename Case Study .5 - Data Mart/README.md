
# 🛒 Case Study .5 - Data Mart
Data Mart is Danny’s latest venture and after running international operations for his online supermarket that specialises in fresh produce - Danny is asking for your support to analyse his sales performance.

In June 2020 - large scale supply changes were made at Data Mart. All Data Mart products now use sustainable packaging methods in every single step from the farm all the way to the customer. Danny needs your help to quantify the impact of this change on the sales performance for Data Mart and it’s separate business areas.

![pic ](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.5%20-%20Data%20Mart/5.png) 

## 📕 Table of Contents
- Bussiness Task
- Entity Relationship Diagram
- Case Study Questions
- My Solution
## 🛠️ Bussiness Task
Data Mart is an online supermarket that specialises in fresh produce. In June 2020 - large scale supply changes were made at Data Mart. All Data Mart products now use sustainable packaging methods in every single step from the farm all the way to the customer.

Danny needs your help to analyse and quantify the impact of this change on the sales performance for Data Mart and it’s separate business areas. The key business question to answer are the following:

- What was the quantifiable impact of the changes introduced in June 2020?
- Which platform, region, segment and customer types were the most impacted by this change?
- What can we do about future introduction of similar sustainability updates to the business to minimise impact on sales?

## 🔐 Entity Relationship Diagram
![ERD](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.5%20-%20Data%20Mart/ERD-5..png)

## ❓ Case Study Questions

### A. Data Cleansing Steps 
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

## B. Data Exploration
View my solution [HERE.](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.5%20-%20Data%20Mart/Solution/B.%20Data%20Exploration.md)

1. What day of the week is used for each `week_date` value?
2. What range of week numbers are missing from the dataset?
3. How many total transactions were there for each year in the dataset?
4. What is the total sales for each region for each month?
5. What is the total count of transactions for each platform
6. What is the percentage of sales for Retail vs Shopify for each month?
7. What is the percentage of sales by demographic for each year in the dataset?
8. Which `age_band` and `demographic` values contribute the most to Retail sales?
9. Can we use the `avg_transaction` column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?


## 🚀 My Solution
- View the complete syntax [HERE.](https://github.com/HarshaliSonawane-128/SQL-Projects/tree/main/Case%20Study%20.5%20-%20Data%20Mart/syntax)
- View the result and explanation [HERE](https://github.com/HarshaliSonawane-128/SQL-Projects/tree/main/Case%20Study%20.5%20-%20Data%20Mart/Solution)

