-- PRACTICE

-- Show each patient with their service's average satisfaction as an additional column.
SELECT p.patient_id, p.`name`, p.service, p.satisfaction,
	(SELECT ROUND(AVG(satisfaction),2) FROM patients s 
		WHERE s.service = p.service) AS avg_satisfaction
FROM patients p;

-- Create a derived table of service statistics and query from it.
select dt.service, dt.total_admissions, dt.max_refusal from
(SELECT service, sum(patients_admitted) as total_admissions, max(patients_refused) as max_refusal
FROM services_weekly group by service) AS dt
where dt.total_admissions > 500;

-- Display staff with their service's total patient count as a calculated field.
SELECT s.staff_id, s.staff_name, s.`role`, s.service,
	(SELECT COUNT(*) FROM patients p WHERE s.service = p.service) AS total_patient_count
FROM staff s;


-- CHALLENGE

/*  Create a report showing each service with: service name, total patients admitted,
the difference between their total admissions and the average admissions across all services,
and a rank indicator ('Above Average', 'Average', 'Below Average'). 
Order by total patients admitted descending.  */



SELECT
	s.service,
	s.total_admitted,
CASE WHEN s.total_admitted > avg_admitted THEN 'Above Average'
   WHEN s.total_admitted = avg_admitted THEN 'Average'
   ELSE 'Below Average'
   END AS rank_indicator
FROM 
   (
    SELECT 
    service,
    SUM(patients_admitted) AS total_admitted
   FROM services_weekly
   GROUP BY service) AS s
CROSS JOIN (
     SELECT 
       AVG(patients_admitted) AS avg_admitted
		 FROM services_weekly) AS overall
ORDER BY s.total_admitted DESC;