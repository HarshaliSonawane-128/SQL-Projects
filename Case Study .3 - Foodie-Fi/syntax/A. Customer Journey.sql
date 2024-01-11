
select * from foodie_fi.plans;

select * from foodie_fi.subscriptions ;

/*  Based off the 8 sample customers provided in the sample from the subscriptions table,
 write a brief description about each customer’s onboarding journey.*/
 
 select count(distinct(customer_id ) ) as distinct_customers
 from foodie_fi.subscriptions;
 
 -- Selecting the following random customer_id's from the subscriptions table to view their onboarding journey.
 -- Checking the following customer_id's : 1,21,73,87,99,193,290,400
 
 
 select s.customer_id ,p. plan_id , p.plan_name , s.start_date , p.price 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id in (1,21,73,87,99,193,290,400)
 order by p.plan_id ;
 
select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 1  ;
 
 select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 21  ;
 
    select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 73  ;
 
    select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 87  ;
 
     select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 99  ;
 
     select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 193  ;
 
     select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 290  ;
 
     select * 
 from foodie_fi.plans  p
 join foodie_fi.subscriptions s 
 on p.plan_id = s.plan_id 
 where s.customer_id = 400;