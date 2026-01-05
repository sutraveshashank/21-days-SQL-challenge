-- CHALLENGE 

/*
Create a trend analysis showing for each service and week: 
week number, patients_admitted, running total of patients admitted (cumulative), 
3-week moving average of patient satisfaction (current week and 2 prior weeks), 
and the difference between current week admissions and the service average. 
Filter for weeks 10-20 only.
*/

SELECT 
	service,
	`week`,
    patients_admitted,
    SUM(patients_admitted) OVER (partition by service ORDER BY `week`) AS running_total_admitted,
    ROUND(AVG(patient_satisfaction) OVER (partition by service ORDER BY `week` ROWS BETWEEN 2 preceding AND current row),2) AS running_avg_sat,
    (patients_admitted - avg(patients_admitted) over (partition by service)) AS diff_from_service_avg 
FROM services_weekly
WHERE `week` BETWEEN 10 AND 20;


-- PRACTICE
-- Calculate running total of patients admitted by week for each service.
SELECT 
	service,
    patients_admitted,
    `week`,
    SUM(patients_admitted) OVER (PARTITION BY service ORDER BY `week`) AS running_total_admitted
FROM services_weekly;

-- Find the moving average of patient satisfaction over 4-week periods.
SELECT 
	`week`,
    patient_satisfaction,
    ROUND(AVG(patient_satisfaction) OVER (ORDER BY `week` ROWS BETWEEN 3 preceding and current row),2)
	AS running_avg_sat
FROM services_weekly;

-- Show cumulative patient refusals by week across all services.
SELECT 
	`week`,
    service,
    patients_refused,
    SUM(patients_refused) OVER (order BY `week` rows unbounded preceding) AS running_total_refused
FROM services_weekly;




