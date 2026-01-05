

-- Day 1
select * from patients;

select patient_id, name , age from patients;

select service from patients limit 10;


-- CHALLENGE
select distinct service from patients;

-- DAY 2


-- Find all patients who are older than 60 years.
select name from patients where age > 60;


-- Retrieve all staff members who work in the 'Emergency' service.
select staff_name from staff where service = 'emergency';


-- List all weeks where more than 100 patients requested admission in any service.
select week , patients_request from services_weekly where patients_request > 100;


-- CHALLLENGE

select patient_id, name, age, satisfaction 
from patients 
where service = 'surgery' and satisfaction < 70;