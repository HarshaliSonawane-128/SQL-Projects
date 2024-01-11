# 🥑 Case Study #3 - Foodie-Fi
## A. Customer Journey

Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey.

```sql 
select s.customer_id ,p. plan_id , p.plan_name , s.start_date , p.price 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id in (1,21,73,87,99,193,290,400)
 order by p.plan_id ;
 
 ```
| customer_id | plan_id | plan_name      | start_date | price |
|-------------|---------|----------------|------------|-------|
| 1           | 0       | trial          | 2020-08-01 | 0.00  |
| 21          | 0       | trial          | 2020-02-04 | 0.00  |
| 73          | 0       | trial          | 2020-03-24 | 0.00  |
| 87          | 0       | trial          | 2020-08-08 | 0.00  |
| 99          | 0       | trial          | 2020-12-05 | 0.00  |
| 193         | 0       | trial          | 2020-05-19 | 0.00  |
| 290         | 0       | trial          | 2020-01-10 | 0.00  |
| 400         | 0       | trial          | 2020-04-27 | 0.00  |
| 1           | 1       | basic monthly  | 2020-08-08 | 9.90  |
| 21          | 1       | basic monthly  | 2020-02-11 | 9.90  |
| 73          | 1       | basic monthly  | 2020-03-31 | 9.90  |
| 193         | 1       | basic monthly  | 2020-05-26 | 9.90  |
| 290         | 1       | basic monthly  | 2020-01-17 | 9.90  |
| 400         | 1       | basic monthly  | 2020-05-04 | 9.90  |
| 21          | 2       | pro monthly    | 2020-06-03 | 19.90 |
| 73          | 2       | pro monthly    | 2020-05-13 | 19.90 |
| 87          | 2       | pro monthly    | 2020-08-15 | 19.90 |
| 193         | 2       | pro monthly    | 2020-09-21 | 19.90 |
| 73          | 3       | pro annual     | 2020-10-13 | 199.00|
| 87          | 3       | pro annual     | 2020-09-15 | 199.00|
| 193         | 3       | pro annual     | 2020-10-21 | 199.00|
| 21          | 4       | churn          | 2020-09-27 |       |
| 99          | 4       | churn          | 2020-12-12 |       |


Customer 1 signed up to 7-day free trial on 01/08/2020. After that time, he/she didn't cancel the subsciption, so the system automatically upgraded it to basic monthly plan on 08/08/2020.

Customer 2 signed up to 7-day free trial on 20/09/2020. After that time, he/she upgraded to pro annual plan on 27/09/2020.

Customer 11 signed up to 7-day free trial on 19/11/2020. After that time, he/she cancelled the subsciption on 26/11/2020.

Customer 13 signed up to 7-day free trial on 15/12/2020. After that time, he/she didn't cancelled the subsciption, so the system automatically upgraded it to basic monthly plan on 22/12/2020. He/she continued using that plan for 2 months. On 29/03/2020 (still in the 3rd month using basic monthly plan), he/she upgraded to pro monthly plan.

Customer 15 signed up to 7-day free trial on 17/03/2020. After that time, he/she didn't cancel the subsciption, so the system automatically upgraded it basic monthly plan on 24/03/2020. He/she then cancelled that plan after 5 days (29/03/2020). He/she was able to use the basic monthly plan until 24/04/2020.

Customer 16 signed up to 7-day free trial on 31/05/2020. After that time, he/she didn't cancel the subsciption, so the system automatically upgraded it to basic monthly plan on 07/06/2020. He/she continued using that plan for 4 months. On 21/10/2020 (still in the 4th month using basic monthly plan), he/she upgraded to pro annual plan.

Customer 18 signed up to 7-day free trial on 06/07/2020. After the trial time, he/she upgraded the subscription to pro monthly plan on 13/07/2020.

Customer 19 signed up to 7-day free trial on 22/06/2020. After that time, he/she upgraded the subscription to pro monthly plan on 29/06/2020. After 2 months using that plan, he/she upgraded to pro annual plan on 29/08/2020.

```sql
 select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 21  ;
 ``` 

| ID | Plan            | Price | Users | Status | Start Date   |
|----|-----------------|-------|-------|--------|--------------|
| 0  | trial           | 0.00  | 21    | 0      | 2020-02-04   |
| 1  | basic monthly   | 9.90  | 21    | 1      | 2020-02-11   |
| 2  | pro monthly     | 19.90 | 21    | 2      | 2020-06-03   |
| 4  | churn           |       | 21    | 4      | 2020-09-27   |

### Customer 1
```sql 
select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 1  ;
 ```
| plan_id | plan_name       | price | customer_id | plan_id | start_date |
|---------|-----------------|-------|-------------|---------|------------|
| 0       | trial           | 0.00  | 1           | 0       | 2020-08-01 |
| 1       | basic monthly   | 9.90  | 1           | 1       | 2020-08-08 |

### Customer 21


 ```sql
 select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 21  ;
 ```
 | plan_id | plan_name       | price | customer_id | plan_id | start_date |
|---------|-----------------|-------|-------------|---------|------------|
| 0       | trial           | 0.00  | 21          | 0       | 2020-02-04 |
| 1       | basic monthly   | 9.90  | 21          | 1       | 2020-02-11 |
| 2       | pro monthly     | 19.90 | 21          | 2       | 2020-06-03 |
| 4       | churn           |       | 21          | 4       | 2020-09-27 |

 ### customer_id 73 
 ```sql 
    select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 73  ;
 ```
 | plan_id | plan_name       | price  | customer_id | plan_id | start_date |
|---------|-----------------|--------|-------------|---------|------------|
| 0       | trial           | 0.00   | 73          | 0       | 2020-03-24 |
| 1       | basic monthly   | 9.90   | 73          | 1       | 2020-03-31 |
| 2       | pro monthly     | 19.90  | 73          | 2       | 2020-05-13 |
| 3       | pro annual      | 199.00 | 73          | 3       | 2020-10-13 |

### customer_id 87 
 ```sql
    select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 87  ;
 ```
| plan_id | plan_name       | price  | customer_id | plan_id | start_date |
|---------|-----------------|--------|-------------|---------|------------|
| 0       | trial           | 0.00   | 87          | 0       | 2020-08-08 |
| 2       | pro monthly     | 19.90  | 87          | 2       | 2020-08-15 |
| 3       | pro annual      | 199.00 | 87          | 3       | 2020-09-15 |

### customer_id 99

 ```sql
     select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 99  ;
 ```
 | plan_id | plan_name       | price  | customer_id | plan_id | start_date |
|---------|-----------------|--------|-------------|---------|------------|
| 0       | trial           | 0.00   | 99          | 0       | 2020-12-05 |
| 4       | churn           |        | 99          | 4       | 2020-12-12 |

### customer_id 193 
 ```sql
     select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 193  ;
 ```
| plan_id | plan_name       | price  | customer_id | plan_id | start_date |
|---------|-----------------|--------|-------------|---------|------------|
| 0       | trial           | 0.00   | 193         | 0       | 2020-05-19 |
| 1       | basic monthly   | 9.90   | 193         | 1       | 2020-05-26 |
| 2       | pro monthly     | 19.90  | 193         | 2       | 2020-09-21 |
| 3       | pro annual      | 199.00 | 193         | 3       | 2020-10-21 |

### customer_id 290
 ```sql
     select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 290  ;
 ``` 

 | plan_id | plan_name       | price | customer_id | plan_id | start_date  |
|---------|-----------------|-------|-------------|---------|-------------|
| 0       | trial           | 0.00  | 290         | 0       | 2020-01-10  |
| 1       | basic monthly   | 9.90  | 290         | 1       | 2020-01-17  |
 

 ### customer_id 400 
 ```sql
     select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 400;
 ```
| plan_id | plan_name       | price  | customer_id | plan_id | start_date |
|---------|-----------------|--------|-------------|---------|------------|
| 0       | trial           | 0.00   | 400         | 0       | 2020-04-27 |
| 1       | basic monthly   | 9.90   | 400         | 1       | 2020-05-04 |


##### My solution for[ B. Data Analysis Questions.](https://github.com/HarshaliSonawane-128/SQL-Projects/blob/main/Case%20Study%20.3%20-%20Foodie-Fi/Solutions/B.%20Data%20Analysis%20Questions.md)
