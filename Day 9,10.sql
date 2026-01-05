-- Extract the year from all patient arrival dates.
select *, extract(year from arrival_date) as admitted_year
from patients;

-- Calculate the length of stay for each patient (departure_date - arrival_date).
select * , datediff(departure_date, arrival_date) as length_stay from patients;


-- Find all patients who arrived in a specific month.
select * from patients where month(arrival_date) = 4;



/*
Calculate the average length of stay (in days) for each service, 
showing only services where the average stay is more than 7 days. 
Also show the count of patients and order by average stay descending.
*/
select service,
 round(avg(datediff(departure_date, arrival_date)),2) as avg_stay,
 count(name) as total_patients 
 from patients 
 group by service 
 having avg_stay > 7 
 order by avg_stay desc;
 	
    
-- DAY 10  
 
 
 -- Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
select patient_id, satisfaction, case
when satisfaction > 80 then 'High'
when satisfaction > 50 then 'medium'
else 'low' 
end as satisfaction_grade from patients;


-- Label staff roles as 'Medical' or 'Support' based on role type.
select staff_name ,role, 
case 

when role = 'doctor' then 'medical'
else' support'
end as patient_roles
from staff;


-- Create age groups for patients (0-18, 19-40, 41-65, 65+).
select patient_id , age, 
case
when age<=18 then 'teen'
when age>19 and age <=40 then 'adult'
when age> 41 and age<=65 then 'young' 
else 'old'
end as age_groups
from patients;





/*
Create a service performance report showing service name, total patients admitted, 
and a performance category based on the following: 
'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, 
otherwise 'Needs Improvement'. Order by average satisfaction descending.
*/
select service , sum(patients_admitted) as total, 
round(avg(patient_satisfaction),2) as avg_satisfaction,
case
when avg(patient_satisfaction) >=85 then 'excellent'
when avg(patient_satisfaction)>=75 then 'good'
when avg(patient_satisfaction) >= 65 then 'fair'
else 'need improvement' 
end as performance
from services_weekly
group by service
order by avg_satisfaction desc;


