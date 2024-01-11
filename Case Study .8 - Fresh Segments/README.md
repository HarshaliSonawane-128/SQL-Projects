
# 🍊 Case Study #8 - Fresh Segments

Danny created Fresh Segments, a digital marketing agency that helps other businesses analyse trends in online ad click behaviour for their unique customer base.

Clients share their customer lists with the Fresh Segments team who then aggregate interest metrics and generate a single dataset worth of metrics for further analysis. In particular - the composition and rankings for different interests are provided for each client showing the proportion of their customer list who interacted with online assets related to each interest for each month.

Danny has asked for your assistance to analyse aggregated metrics for an example client and provide some high level insights about the customer list and their interests.

1[pic](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.8%20-%20Fresh%20Segments/8.png)

## 📕 Table of Contents
- Bussiness Task
- Entity Relationship Diagram
- Case Study Questions
- My Solution
## 🛠️ Bussiness Task
Fresh Segments is a digital marketing agency that helps other businesses analyse trends in online ad click behaviour for their unique customer base.

Clients share their customer lists with the Fresh Segments team who then aggregate interest metrics and generate a single dataset worth of metrics for further analysis. In particular - the composition and rankings for different interests are provided for each client showing the proportion of their customer list who interacted with online assets related to each interest for each month.

Danny has asked for your assistance to analyse aggregated metrics for an example client and provide some high level insights about the customer list and their interests.

## 🔐 Entity Relationship Diagram


## ❓ Case Study Questions

### A. Data Exploration and Cleansing
View my solution HERE.

1. Update the `fresh_segments.interest_metrics` table by modifying the `month_year` column to be a date data type with the start of the month ?
2. What is count of records in the `fresh_segments.interest_metrics` for each `month_year` value sorted in chronological order (earliest to latest) with the null values appearing first?
3. What do you think we should do with these `null` values in the `fresh_segments.interest_metrics`
4. How many `interest_id` values exist in the `fresh_segments.interest_metrics` table but not in the `fresh_segments.interest_ma`p table? What about the other way around?
5. Summarise the id values in the `fresh_segments`.`interest_map` by its total record count in this table.
6. What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where `interest_id` = `21246` in your joined output and include all columns from fresh_segments.
7. interest_metrics and all columns from `fresh_segments.interest_map` except from the id column.
Are there any records in your joined table where the `month_year` value is before the `created_at` value from the `fresh_segments.interest_map` table? Do you think these values are valid and why?

## B. Interest Analysis
View my solution HERE.

1. Which interests have been present in all `month_year` dates in our dataset?
2. Using this same `total_months` measure - calculate the cumulative percentage of all records starting at 14 months - which `total_months` value passes the 90% cumulative percentage value?
3. If we were to remove all `interest_id` values which are lower than the `total_months` value we found in the previous question - how many total data points would we be removing?
4. Does this decision make sense to remove these data points from a business perspective? Use an example where there are all 14 months present to a removed interest example for your arguments - think about what it means to have less months present from a segment perspective.
5. After removing these interests - how many unique interests are there for each month?

## C. Segment Analysis
View my solution HERE.

1. Using our filtered dataset by removing the interests with less than 6 months worth of data, which are the top 10 and bottom 10 interests which have the largest composition values in any `month_year`?
3. Only use the maximum composition value for each interest but you must keep the corresponding `month_year`.
2. Which 5 interests had the lowest average ranking value?
3. Which 5 interests had the largest standard deviation in their `percentile_ranking` value?
4. For the 5 interests found in the previous question - what was minimum and maximum `percentile_ranking` values for each interest and its corresponding `year_month` value? Can you describe what is happening for these 5 interests?
4. How would you describe our customers in this segment based off their composition and ranking values? What sort of products or services should we show to these customers and what should we avoid?

## D. Index Analysis
View my solution HERE.

The `index_value` is a measure which can be used to reverse calculate the average composition for Fresh Segments’ clients.
Average composition can be calculated by dividing the composition column by the `index_value` column rounded to 2 decimal places.

1. What is the top 10 interests by the average composition for each month?
2 . For all of these top 10 interests - which interest appears the most often?

## 🚀 My Solution
- View the complete syntax HERE.
- View the result and explanation HERE.
