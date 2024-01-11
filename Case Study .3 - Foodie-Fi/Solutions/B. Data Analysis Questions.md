
# 🥑 Case Study #3 - Foodie-Fi
## B. Data Analysis Questions
### 1. How many customers has Foodie-Fi ever had?

```sql
select count(distinct (customer_id) ) as unique_customer
from foodie_fi.subscriptions ;
```

| unique_customer |
|---------|
|1000 |


### 2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value?

```sql 
select month(start_date) as start_of_month, 
       count(*) as distribution_values 
from foodie_fi.plans p
join foodie_fi.subscriptions s 
on p.plan_id = s.plan_id 
where plan_name = 'trial' 
GROUP BY MONTH(s.start_date);
```
| start_of_month | distribution_values |
|----------------|----------------------|
| 8              | 88                   |
| 9              | 87                   |
| 1              | 88                   |
| 12             | 84                   |
| 2              | 68                   |
| 6              | 79                   |
| 11             | 75                   |
| 3              | 94                   |
| 5              | 88                   |
| 7              | 89                   |
| 4              | 81                   |
| 10             | 79                   |

### 3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name?

```sql
select 
     year(s.start_date )as event_year,
     p.plan_name ,
     count(*) as count_event 
from foodie_fi.subscriptions s
join foodie_fi.plans p
on p.plan_id = s.plan_id 
where year(s.start_date) > 2020 
group by year(s.start_date)  , p.plan_name ;
```
| event_year | plan_name     | count_event |
|------------|---------------|-------------|
| 2021       | churn         | 71          |
| 2021       | pro monthly   | 60          |
| 2021       | pro annual    | 63          |
| 2021       | basic monthly | 8           |


### 4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

```sql
select p.plan_name ,
sum( case when p.plan_name = 'churn' then 1 end) as churn_count ,
cast( 100* sum(case when p.plan_name = 'churn' then 1 End ) as float(1)) /
      count(distinct customer_id ) as churn_per
from foodie_fi.plans p
join foodie_fi.subscriptions s 
on p.plan_id = s.plan_id 
where p.plan_name = 'churn' ;
```
| plan_name | churn_count | churn_per |
|-----------|-------------|-----------|
| churn     | 307         | 100       |

### 5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

```sql
with nextplan as 
( select 
   s.customer_id , 
   s.start_date , 
   p.plan_name ,
   lead( p.plan_name) over (partition by  s.customer_id  order by p.plan_id ) as next_plan 
   from foodie_fi.plans p
   join foodie_fi.subscriptions s 
   on p.plan_id = s.plan_id )
   
   select count(*) as churn_after_trial ,
         100*count(*) / count(distinct customer_id) as percentage 
	from nextplan
    where plan_name = 'trial'  and next_plan = 'churn';
```
| churn_after_trial | percentage |
|-------------------|------------|
|        92         |  100.00|


### 6. What is the number and percentage of customer plans after their initial free trial? 

```sql 
with nextplan as 
 (select s.customer_id , 
		p.plan_id , 
		p.plan_name ,
        lead(p.plan_name) over (partition by s.customer_id order by p.plan_id ) as next_plan 
from foodie_fi.plans p
join foodie_fi.subscriptions s 
on p.plan_id = s.plan_id )

select  next_plan , 
        count(*) as customer_plan,
        100* count(*) / sum(distinct(customer_id)) as  customer_percentage 
from nextplan 
where plan_name = 'trial' and next_plan is not null
group by next_plan ;
```

| next_plan      | customer_plan | customer_percentage |
| -------------- | ------------- | ------------------- |
| basic monthly  | 546           | 0.1995              |
| churn          | 92            | 0.1847              |
| pro annual     | 37            | 0.2456              |
| pro monthly    | 325           | 0.2006              |


### 7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?

```sql
with plansDate as 
( select s.customer_id ,
		s.start_date , 
        p.plan_name , 
        p.plan_id ,
		lead(s.start_date ) over( partition by s.customer_id order by s.start_date ) as next_date 
from foodie_fi.plans p
join foodie_fi.subscriptions s 
on p.plan_id = s.plan_id)

select 
   plan_id ,plan_name ,
   count(*) as customers ,
   100*count(*) / count(distinct customer_id) as conversion_rate 
from plansDate 
WHERE (next_date IS NOT NULL AND (start_date < '2020-12-31' AND next_date > '2020-12-31'))
  OR (next_date IS NULL AND start_date < '2020-12-31')
GROUP BY plan_id, plan_name
ORDER BY plan_id;
``` 

| plan_id | plan_name      | customers | conversion_rate |
| ------- | -------------- | --------- | --------------- |
| 0       | trial          | 19        | 100.0000        |
| 1       | basic monthly  | 224       | 100.0000        |
| 2       | pro monthly    | 326       | 100.0000        |
| 3       | pro annual     | 195       | 100.0000        |
| 4       | churn          | 235       | 100.0000        |


### 8. How many customers have upgraded to an annual plan in 2020?

```sql 
select count(Distinct (customer_id) ) as  customer_count 
from foodie_fi.subscriptions s 
join foodie_fi.plans p 
on s.plan_id =p.plan_id 
where plan_name = 'pro annual'   and year(s.start_date) = 2020;
```

|customer_count|
|----|
|	195|

### 9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?

```sql
WITH trialPlan AS (
  SELECT 
    s.customer_id,
    s.start_date AS trial_date
from foodie_fi.subscriptions s 
join foodie_fi.plans p 
on s.plan_id =p.plan_id 
  WHERE p.plan_name = 'trial'
),
annualPlan AS (
  SELECT 
    s.customer_id,
    s.start_date AS annual_date
 from foodie_fi.subscriptions s 
join foodie_fi.plans p 
on s.plan_id =p.plan_id 
  WHERE p.plan_name = 'pro annual'
)

Select AVG(CAST(datediff( annual_date ,trial_date) AS FLOAT)) AS avg_days_to_annual
FROM trialPlan t
JOIN annualPlan a 
ON t.customer_id = a.customer_id;
``` 

|avg_days_to_annual|
|------|
|104.62015503875969| 

### 10. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

```sql
with nextplan as (
select s.customer_id , 
       p.plan_id , 
       p.plan_name ,
       lead(plan_name ) over( partition by customer_id order by start_date ) next_plan,
       year(start_date) 
from foodie_fi.plans  p
join foodie_fi .subscriptions s 
on p.plan_id = s.plan_id 
where year(start_date) = '2020')

select count(*) as downgrade_count 
from nextplan 
where plan_name = 'basic monthly' and next_plan = 'pro annual' ;
``` 

|downgrade_count|
|----|
|	88|
