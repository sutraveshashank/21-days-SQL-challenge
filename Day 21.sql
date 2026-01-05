-- CHALLENGE

-- service level metrics
WITH cte_service AS (
	SELECT
		service,
		SUM(patients_admitted) AS total_admission,
		SUM(patients_refused) AS total_refusals,
		ROUND(AVG(patient_satisfaction),2) AS avg_satisfaction
	FROM services_weekly
	GROUP BY service
),
-- staff metrics per service
cte_staff AS (
	SELECT 
    service,
    COUNT(DISTINCT staff_id) AS total_staff,
    ROUND(SUM(present) / COUNT(DISTINCT staff_id), 2) AS avg_weeks_present
FROM staff_schedule
GROUP BY service
),
-- patient demographics
cte_patient AS (
	SELECT 
		service,
		ROUND(AVG(age),2) AS avg_patient_age,
		COUNT(*) as total_patients
	FROM patients
	GROUP BY service
)
SELECT
	csv.service,
    csv.total_admission,
    csv.total_refusals,
    csv.avg_satisfaction,
    csf.total_staff,
    csf.avg_weeks_present,
    cp.avg_patient_age,
	cp.total_patients,
    ROUND((csv.total_admission * 0.3/ NULLIF(csv.total_admission + csv.total_refusals,0)) + (csv.avg_satisfaction * 0.7/100),2)*100
    AS overall_perf_score
FROM cte_service csv
JOIN cte_staff 	csf
ON csv.service = csf.service
JOIN cte_patient cp
ON csf.service = cp.service
ORDER BY overall_perf_score DESC;



-- PRACTICE

-- Create a CTE to calculate service statistics, then query from it.
with cte_service AS(
SELECT 
	service,
	SUM(patients_admitted) AS total_admitted,
    SUM(patients_refused) AS total_refused,
    ROUND(AVG(patient_satisfaction),2) AS avg_sat,
    ROUND(AVG(staff_morale),2) AS avg_staff_morale
FROM services_weekly
GROUP BY service
)
SELECT * FROM cte_service
WHERE avg_sat < 80 AND avg_staff_morale < 80;


-- Use multiple CTEs to break down a complex query into logical steps.
WITH cte_patient AS (
	SELECT
		service,
		COUNT(*) AS total_patients,
		ROUND(AVG(age),2) AS avg_age,
		ROUND(AVG(satisfaction),2) AS avg_satisfaction
	FROM patients
	GROUP BY service
),
cte_staff AS(
	SELECT
		service,
		COUNT(*) AS total_staff
	FROM staff
	GROUP BY service
)
SELECT cp.*, cs.total_staff
FROM cte_patient cp
JOIN cte_staff cs
ON cp.service = cs.service
;

-- Build a CTE for staff utilization and join it with patient data.
  WITH staff_util AS (
    SELECT 
        staff_id,
        staff_name,
        service,
        SUM(present) AS weeks_present,
        COUNT(*) AS total_weeks,
        ROUND(SUM(present) / COUNT(*) * 100, 2) AS utilization_pct
    FROM staff_schedule
    GROUP BY staff_id, staff_name, service
)
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.service,
    p.satisfaction AS patient_satisfaction,
    su.staff_id,
    su.staff_name,
    su.utilization_pct
FROM patients p
JOIN staff_util su 
    ON p.service = su.service
ORDER BY p.service, su.utilization_pct DESC;
 