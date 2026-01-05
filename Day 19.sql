-- CHALLENGE

/*
For each service, rank the weeks by patient satisfaction score (highest first). 
Show service, week, patient_satisfaction, patients_admitted, and the rank. 
Include only the top 3 weeks per service.
*/
SELECT *
FROM
(
SELECT service, `week`, patient_satisfaction, patients_admitted,
        RANK() OVER (PARTITION BY service ORDER BY patient_satisfaction DESC) AS rnk_score
FROM services_weekly
) rnk
WHERE rnk_score <= 3
;


-- PRACTICE
-- Rank patients by satisfaction score within each service.
SELECT patient_id, `name`, service, satisfaction,
		RANK() OVER (PARTITION BY service ORDER BY satisfaction DESC) AS rnk_sat,
		DENSE_RANK() OVER (PARTITION BY service ORDER BY satisfaction DESC) AS dns_rnk_sat
FROM patients;


-- 	Assign row numbers to staff ordered by their name.
SELECT staff_id, staff_name, service,
		ROW_NUMBER() OVER (ORDER BY staff_name) AS row_num_name
FROM staff;


-- Rank services by total patients admitted.
SELECT service, 
		SUM(patients_admitted) AS total_patients_admitted,
        RANK() OVER (ORDER BY SUM(patients_admitted) DESC) AS rnk_service
FROM services_weekly
GROUP BY service;
