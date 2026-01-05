-- DAY 11


-- List all unique services in the patients table.
select distinct(service) from patients;


-- Find all unique staff roles in the hospital.
SELECT distinct(role) from staff;


-- Get distinct months from the services_weekly table.	
select distinct(month) from services_weekly; 	



/*
Find all unique combinations of service and event type from the services_weekly table 
where events are not null or none, along with the count of occurrences for each combination. 
Order by count descending.
*/
select service, event, 
count(*) as occurences 
from services_weekly
where (event is not null and event!= 'none') 
group by event ,service
order by occurences desc;

-- DAY 12

-- Find all weeks in services_weekly where no special event occurred.
	select week, str_to_date(concat('2025' , week, 'sunday'), '%X %V %W') AS week_start_date
	FROM services_weekly 
	WHERE (`event` IS NULL) OR (`event` = 'none');


-- Count how many records have null or empty event values.
select count(*) from services_weekly where event = 'null'  or event = 'none';


-- List all services that had at least one week with a special event.

select service, 
count(*) as counts from services_weekly
where event is not null and event != 'none'
group by service
having counts >=1;

    
/*
Analyze the event impact by comparing weeks with events vs weeks without events. 
Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, 
and average staff morale. Order by average patient satisfaction descending.
*/

select 
case 
when (event is not null and event != 'none') then 'with event'
else 'without event '
end as event_status,
count(week) as week_count,
round(avg(patient_satisfaction),2) as avg_satisfaction,
round(avg(staff_morale),2) as avg_staff_morale
from services_weekly 
group by event_status
order by avg_satisfaction desc;

