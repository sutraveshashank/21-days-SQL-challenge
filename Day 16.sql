-- PRACTICE

-- Find patients who are in services with above-average staff count.

SELECT *
FROM patients
WHERE service IN (
	SELECT service
	FROM (
			SELECT service, COUNT(*) AS staff_count
			FROM staff
			GROUP BY service
		) AS service_staff
		WHERE staff_count >
			(SELECT AVG(staff_count)
			FROM (
				SELECT service, COUNT(*) AS staff_count
				FROM staff
				GROUP BY service
				) AS avg_calc
			)
	);

-- List staff who work in services that had any week with patient satisfaction below 70.

SELECT DISTINCT s.staff_id, s.staff_name, s.role, s.service
FROM staff AS s
WHERE s.service IN (
    SELECT DISTINCT service
    FROM services_weekly
    WHERE patient_satisfaction < 70
);


-- Show patients from services where total admitted patients exceed 1000.
SELECT *
FROM patients
WHERE service IN(
		select service
		from services_weekly
		group by service
		having sum(patients_admitted) > 1000);






















-- CHALLENGE

SELECT 
    p.patient_id,
    p.`name`,
    p.service,
    p.satisfaction
FROM patients AS p
WHERE p.service IN (
    SELECT DISTINCT service -- select services having patient refused > 0
    FROM services_weekly
    WHERE patients_refused > 0
)
AND p.service IN (
    SELECT service
    FROM (
        SELECT 
            service,
            AVG(patient_satisfaction) AS avg_service_satisfaction -- Average satisfation in every service
        FROM services_weekly
        GROUP BY service
    ) AS svc
    WHERE avg_service_satisfaction < (
        SELECT AVG(patient_satisfaction)  -- -- Average satisfation overall
        FROM services_weekly
    )
);