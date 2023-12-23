select *  from hr_database.employee_survey_data ;
select * from hr_database.general_data ;
select * from hr_database.manager_survey_data ;

/* 1. Retrieve the total number of employees in the dataset.*/
select count(Emp_Name) from hr_database.general_data ;

/*2. List all unique job roles in the dataset.*/
select distinct  jobRole  from hr_database.general_data;

/*3. Find the average age of employees.*/
select avg(age) from hr_database.general_data ;

/*4. Retrieve the names and ages of employees who have worked at the company for more 
than 5 years.*/
select emp_name , age  
from hr_database.general_data
where YearsAtCompany > 5 ;

/*5. Get a count of employees grouped by their department.*/
select department ,count(emp_name) 
from hr_database.general_data
group by Department;

/*6. List employees who have 'High' Job Satisfaction.*/
SELECT e1.Emp_Name, e1.EmployeeID, e2.JobSatisfaction
FROM hr_database.general_data  as e1
JOIN hr_database.employee_survey_data as e2 
ON e1.EmployeeID = e2.EmployeeID
WHERE  e2.JobSatisfaction = 4;

/*7. Find the highest Monthly Income in the dataset.*/
select   max(MonthlyIncome)  
from hr_database.general_data ; 

/*8. List employees who have 'Travel_Rarely' as their BusinessTravel type.*/
select EmployeeID , Emp_Name , BusinessTravel 
from  hr_database.general_data 
where BusinessTravel = 'Travel_Rarely'; 

/*9. Retrieve the distinct MaritalStatus categories in the dataset.*/
select maritalstatus 
from hr_database.general_data 
group by MaritalStatus ;

/*10. Get a list of employees with more than 2 years of work experience but less than 4 years in 
their current role.*/
select EmployeeID , Emp_Name, jobrole , TotalWorkingYears as work_experience 
from hr_database.general_data 
where TotalWorkingYears > 2 and TotalWorkingYears < 4;

/* 11. List employees who have changed their job roles within the company (JobLevel and 
JobRole differ from their previous job).*/
WITH PreviousJobInfo AS (SELECT EmployeeID, JobLevel AS PreviousJobLevel, JobRole AS PreviousJobRole
    FROM hr_database.general_data 
    WHERE EmployeeID IN ( SELECT EmployeeID FROM hr_database.general_data  GROUP BY EmployeeID HAVING COUNT(*) > 1 ) )
SELECT
    current.EmployeeID,
    current.Emp_Name,
    current.JobLevel AS CurrentJobLevel,
    current.JobRole AS CurrentJobRole
FROM hr_database.general_data as current 
JOIN PreviousJobInfo as previous 
ON current.EmployeeID = previous.EmployeeID
WHERE current.JobLevel != previous.PreviousJobLevel OR current.JobRole != previous.PreviousJobRole;


/*12. Find the average distance from home for employees in each department.*/
select avg(Distancefromhome) , Department 
from hr_database.general_data 
group by Department ;

/*13. Retrieve the top 5 employees with the highest MonthlyIncome.*/
select EmployeeID ,Emp_Name,  MonthlyIncome 
from hr_database.general_data
order by MonthlyIncome desc  
limit 5 ;


/*14. Calculate the percentage of employees who have had a promotion in the last year.*/
select  (count(case when yearssincelastpromotion =1 then 1 end)/ count(*) ) *100 as promotionpercentage 
from hr_database.general_data; 

/*15. List the employees with the highest and lowest EnvironmentSatisfaction.*/
SELECT e1.Emp_Name, e1.EmployeeID, e2.EnvironmentSatisfaction
FROM hr_database.general_data  as e1
JOIN hr_database.employee_survey_data as e2 
ON e1.EmployeeID = e2.EmployeeID
WHERE  EnvironmentSatisfaction = (select max(EnvironmentSatisfaction) from hr_database.employee_survey_data )
UNION 
SELECT e1.Emp_Name, e1.EmployeeID, e2.EnvironmentSatisfaction
FROM hr_database.general_data  as e1
JOIN hr_database.employee_survey_data as e2 
ON e1.EmployeeID = e2.EmployeeID
WHERE  EnvironmentSatisfaction = (select min(EnvironmentSatisfaction) from hr_database.employee_survey_data );
 

/*16. Find the employees who have the same JobRole and MaritalStatus.*/
select jobrole , MaritalStatus
 from hr_database.general_data
 where JobRole = MaritalStatus ; 
 
 
/*17. List the employees with the highest TotalWorkingYears who also have a 
PerformanceRating of 4.*/
select EmployeeID ,Emp_Name , TotalWorkingYears , PerformanceRating 
from hr_database.general_data 
left join hr_database.manager_survey_data
using (EmployeeID)
where TotalWorkingYears = (select max(totalWorkingYears) from hr_database.general_data) and PerformanceRating = 4 ;

/*18. Calculate the average Age and JobSatisfaction for each BusinessTravel type.*/
select BusinessTravel, avg(age) , avg(jobsatisfaction) 
from hr_database.employee_survey_data 
Right join hr_database.general_data 
using(EmployeeID)
group by BusinessTravel;

/*19. Retrieve the most common EducationField among employees.*/
select EducationField , count(EducationField) as commonField
from hr_database.general_data 
group by EducationField
Order by commonField desc
limit 1;
 
/*20. List the employees who have worked for the company the longest but haven't had a 
promotion*/
select EmployeeID  , YearsAtCompany ,YearsSinceLastPromotion    
from hr_database.general_data 
where YearsAtCompany = (select max(YearsAtCompany) from hr_database.general_data) and YearsSinceLastPromotion = 0 ;

