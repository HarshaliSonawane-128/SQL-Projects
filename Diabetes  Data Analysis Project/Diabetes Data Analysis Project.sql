select * from diabeties_dataanalysis.diabetes_prediction;
alter table diabeties_dataanalysis.diabetes_prediction 
rename column employeeName to Patient_Name ;

/*1. Retrieve the Patient_id and ages of all patients.*/
select patient_id , age from diabeties_dataanalysis.diabetes_prediction;

/*2. Select all female patients who are older than 40.*/
select  Patient_Name , age , gender 
from diabeties_dataanalysis.diabetes_prediction 
where gender = 'Female' and age > 40 ;

/*3. Calculate the average BMI of patients.*/
select avg(bmi) from diabeties_dataanalysis.diabetes_prediction ;

/*4. List patients in descending order of blood glucose levels.*/
select Patient_Name , blood_glucose_level
 from diabeties_dataanalysis.diabetes_prediction 
 order by blood_glucose_level desc;

/*5. Find patients who have hypertension and diabetes.*/
select Patient_Name, hypertension , diabetes 
from diabeties_dataanalysis.diabetes_prediction 
where hypertension = 1 and diabetes = 1 ;

/*6. Determine the number of patients with heart disease.*/
select count(*) as total_HeartDiseasePatient 
from diabeties_dataanalysis.diabetes_prediction 
where heart_disease = 1 ;

/*7. Group patients by smoking history and count how many smokers and nonsmokers there are.*/
select count(Patient_Name) as Total_Pateint , smoking_history 
from diabeties_dataanalysis.diabetes_prediction
group by smoking_history;

/*8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.*/
select patient_ID 
from diabeties_dataanalysis.diabetes_prediction 
where bmi = (select avg(bmi) from diabeties_dataanalysis.diabetes_prediction);

/*9. Find the patient with the highest HbA1c level and the patient with the lowest
HbA1clevel.*/
SELECT
    MAX(HbA1c_level) AS max_HbA1c,
    MIN(HbA1c_level) AS min_HbA1c,
    Patient_id AS max_HbA1c_patient,
    Patient_id AS min_HbA1c_patient
FROM  diabeties_dataanalysis.diabetes_prediction 
group by Patient_id;


/*10. Calculate the age of patients in years (assuming the current date as of now).*/
SELECT EmployeeName, Patient_id , age,  YEAR(CURDATE()) - age AS calculated_age
FROM diabeties_dataanalysis.diabetes_prediction;


/*11. Rank patients by blood glucose level within each gender group.*/
select Patient_Name , patient_id , blood_glucose_level , 
rank() over ( partition by gender) as Rank_Glucose 
 FROM diabeties_dataanalysis.diabetes_prediction;

/*12. Update the smoking history of patients who are older than 50 to "Ex-smoker."*/
update diabeties_dataanalysis.diabetes_prediction
set smoking_history = 'EX-smoker'
where age >50 ;


/*13. Insert a new patient into the database with sample data.*/
INSERT INTO diabeties_dataanalysis.diabetes_prediction (Patient_Name, Patient_id, gender, age, hypertension, heart_disease, smoking_history, bmi, HbA1c_level, blood_glucose_level, diabetes)
VALUES ('John Doe', 'PT1112', 'Male', 55, 1, 0, 'never', 28.5, 6.2, 120, 0);


select * from diabeties_dataanalysis.diabetes_prediction 
where Patient_id = 'PT11112';

/*14. Delete all patients with heart disease from the database.*/
delete from patients
where heart_disese = 'yes';


/*15. Find patients who have hypertension but not diabetes using the EXCEPT operator.*/
select * from patients 
where hypertension ='yes'
except
select * from patients 
where diabeties = 'yes';


/*16. Define a unique constraint on the "patient_id" column to ensure its values are unique.*/
select distinct patient_id from diabeties_dataanalysis.diabetes_prediction ;

/*16. Define a unique constraint on the "patient_id" column to ensure its values are unique.*/
alter table patients
modify column patients_id varchar(50);
alter table patients 
add constraint unique(patient_id);

/*17. Create a view that displays the Patient_ids, ages, and BMI of patients.*/
create view view_Name  as 
select Patient_id , age , bmi 
from diabeties_dataanalysis.diabetes_prediction;

select * from View_Name ;
