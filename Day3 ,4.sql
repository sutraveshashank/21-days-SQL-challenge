-- DAY 3


-- List all patients sorted by age in descending order.
select name, age from patients order by age desc;


-- Show all services_weekly data sorted by week number ascending and patients_request descending.
select * from services_weekly order by 'week', patients_request desc;


-- Display staff members sorted alphabetically by their names.
select * from staff order by staff_name ;



/*
Retrieve the top 5 weeks with the highest patient refusals across all services, 
showing week, service, patients_refused, and patients_request. 
Sort by patients_refused in descending order.
*/
select week, service , patients_refused, patients_request
 from services_weekly 
 order by patients_refused desc 
 limit 5;




-- Day 4


-- display the first 5 patients from the patients table
select name from patients limit 5 ;


 -- show patients from 11-20 using offset
select name from patients limit 10 offset 10;


-- Get the 10 most recent patient admissions based on arrival_date.
select name from patients order by arrival_date desc limit 10;



/*
  Find the 3rd to 7th highest patient satisfaction scores from the patients table, 
 showing patient_id, name, service, and satisfaction. Display only these 5 records.
*/

select patient_id, name, service , satisfaction
 from patients 
 order by satisfaction desc limit 5 offset 2;

