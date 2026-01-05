-- CHALLENGE

/*
Create a comprehensive personnel and patient list showing: 
identifier (patient_id or staff_id), full name, type ('Patient' or 'Staff'), and associated service. 
Include only those in 'surgery' or 'emergency' services. Order by type, then service, then name.
*/
SELECT 
	patient_id AS identifier_id,
    `name` AS full_name,
    "Patient" AS `type`, 
    service
FROM patients
WHERE service IN ("emergency", "surgery")
UNION ALL
SELECT 
	staff_id AS identifier_id,
    staff_name AS full_name,
    "Staff" AS `type`,
    service
FROM staff
WHERE service IN ("emergency", "surgery")
ORDER BY `type`, service, full_name;

-- PRACTICE

-- Combine patient names and staff names into a single list.
SELECT `name` AS `names`
FROM patients
UNION ALL
SELECT staff_name
FROM staff;

-- Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
SELECT `name`, IF(satisfaction > 90, "High Satisfaction","") AS satisfaction_score
FROM patients
WHERE satisfaction > 90
UNION ALL
SELECT `name`, IF(satisfaction < 50, "Low Satisfaction","") AS satisfaction_score
FROM patients
WHERE satisfaction < 50;


-- List all unique names from both patients and staff tables.
SELECT `name` AS `names`
FROM patients
UNION
SELECT staff_name
FROM staff;