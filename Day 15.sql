-- PRACTICE

-- Join patients, staff, and staff_schedule to show patient service and staff availability.
SELECT p.`name`, p.service, s.staff_name, ss.`week`, ss.present
FROM patients p
JOIN staff s
ON p.service = s.service
JOIN staff_schedule ss
ON s.staff_id = ss.staff_id;

-- Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
SELECT  sw.`week`, sw.service, sw.available_beds, 
		sw.patients_admitted, sw.patient_satisfaction, sw.staff_morale, 
        s.staff_name, ss.present
FROM services_weekly sw
JOIN staff s
ON sw.service = s.service
JOIN staff_schedule ss
ON s.staff_id = ss.staff_id;

-- Create a multi-table report showing patient admissions with staff information.
SELECT p.service ,p.patient_id, p.`name` AS patient_name, 
		p.age, p.arrival_date,  s.staff_id, s.staff_name, s.`role` , ss.`week`, ss.present
FROM patients p
JOIN staff s
ON  p.service = s.service
JOIN staff_schedule ss
ON s.staff_name = ss.staff_name
order by p.service;


-- CHALLENGE

/*
Create a comprehensive service analysis report for week 20 showing: 
service name, total patients admitted that week, total patients refused, average patient satisfaction, 
count of staff assigned to service, and count of staff present that week. 
Order by patients admitted descending.
*/

SELECT sw.service,
		SUM(sw.patients_admitted) AS total_patients_admitted,
        SUM(sw.patients_refused) AS total_patients_refused,
        ROUND(AVG(sw.patient_satisfaction),2) AS avg_patient_satisfaction,
        COUNT(DISTINCT ss.staff_id) AS staff_service_count,
        SUM(ss.present) AS actual_staff_service_present 
FROM services_weekly sw
INNER JOIN staff_schedule ss
ON sw.`week` = ss.`week` AND sw.service = ss.service
WHERE sw.`week` = 20
GROUP BY sw.service
ORDER BY total_patients_admitted DESC;

