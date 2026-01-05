-- DAY 5

-- Count the total number of patients in the hospital.
select count(*) from patients;


-- Calculate the average satisfaction score of all patients.
select name, avg(satisfaction) as avg_satisfaction 
from patients group by name;


-- Find the minimum and maximum age of patients.
select  min(age) as min, max(age) as max
 from patients ;



/* 
Calculate the total number of patients admitted, total patients refused, and the 
average patient satisfaction across all services and weeks. 
Round the average satisfaction to 2 decimal places.
*/
select sum(patients_admitted) as admitted_patients,
 sum(patients_refused) as refused_patients,
round(avg(patient_satisfaction),2) as avg_ps
 from services_weekly;
 
 
-- DAY 6 
 
 
 -- Count the number of patients by each service.
 select service , count(*) as countservice
 from patients 
 group by service 
 order by countservice desc;
 
 
 
 -- Calculate the average age of patients grouped by service
 select service , avg(age) as avg_age from patients group by service;
 
 
 
 -- Find the total number of staff members per role.
 select role, count(*) as countmembers from staff group by role;
 
 

 
 /*
For each hospital service, calculate the total number of patients admitted, 
total patients refused, and the admission rate (percentage of requests that were admitted). 
Order by admission rate descending.
*/

select service, 
sum(patients_admitted) as total_patients_admitted,
sum(patients_refused) as total_patients_refused, 
round(sum(patients_admitted) / sum(patients_request) * 100, 2) as admission_rate
from services_weekly
group by service
order by admission_rate desc;
 
 
 
 select service,
 sum(patients_admitted) as patients_admitted 
 from services_weekly  
 group by service 
 having patients_admitted > 500;
 
 
 
select service, avg(patient_satisfaction) as average
from services_weekly
group by service
having average < 75;


select week,
 sum(present) as count
 from staff_schedule 
 group by week 
 having count < 50;


select service ,
 sum(patients_refused) as total_refused ,
 round(avg(patient_satisfaction),2) as average_satisfaction 
 from services_weekly 
 group by service 
 having total_refused > 100 and average_satisfaction < 80;
 
 
 
