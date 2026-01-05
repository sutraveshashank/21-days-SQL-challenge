-- DAY 13


-- Join patients and staff based on their common service field (show patient and staff who work in same service).
select name , p.service as p, s.service, s.role
from patients as p
inner join staff_schedule as s
on p.service = s.service;



-- Join services_weekly with staff to show weekly service data with staff information.
select s.staff_name ,w.week
from staff as s
inner join services_weekly as w
on s.service = w.service;

   
-- Create a report showing patient information along with staff assigned to their service.
select p.name,s.role,s.staff_id
from patients as p
inner join staff as s 
on p.service = s.service ;




 /*Create a comprehensive report showing patient_id, patient name, age, service, 
 and the total number of staff members available in their service. 
 Only include patients from services that have more than 5 staff members. 
 Order by number of staff descending, then by patient name. */
 
 
select p.patient_id, p.name, p.age, p.service, 
count(staff_name) as total_staff_members
from patients as p
inner join staff as s on 
p.service =  s.service
group by 1,2 ,3,4 
having total_staff_members >5
order by total_staff_members desc;

