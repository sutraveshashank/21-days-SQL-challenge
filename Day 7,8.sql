-- Find services that have admitted more than 500 patients in total.
 select service,
 sum(patients_admitted) as patients_admitted 
 from services_weekly  
 group by service 
 having patients_admitted > 500;
 
 
 -- Show services where average patient satisfaction is below 75.
select service, avg(patient_satisfaction) as average
from services_weekly
group by service
having average < 75;


-- List weeks where total staff presence across all services was less than 50.
select week,
 sum(present) as count
 from staff_schedule 
 group by week 
 having count < 50;



/*
Identify services that refused more than 100 patients in total and 
had an average patient satisfaction below 80. 
Show service name, total refused, and average satisfaction.
*/
select service ,
 sum(patients_refused) as total_refused ,
 round(avg(patient_satisfaction),2) as average_satisfaction 
 from services_weekly 
 group by service 
 having total_refused > 100 and average_satisfaction < 80;
 
 
 
 
 -- DAY 8
 
 -- Convert all patient names to uppercase.
select patient_id, upper(name) as uppername from patients;
-- Find the length of each staff member's name.
select staff_name , length(staff_name) as length from staff;


-- Concatenate staff_id and staff_name with a hyphen separator.
select concat(staff_id, '-', staff_name) as patient_id from staff;




/*
Create a patient summary that shows patient_id, full name in uppercase, service in lowercase, 
age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), 
and name length. Only show patients whose name length is greater than 10 characters.
*/

select patient_id, upper(name) as full_name,  lower(service) as Services ,age, 
case 
	when age>=65 then 'Senior' 
	when age>=18 then 'Adult'
	else 'minor'
end as age_category,
length(name) as name_length
from patients
where length(name) > 10;



