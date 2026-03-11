SELECT *
FROM patients;


-- task 1 --
SELECT first_name, last_name, gender 
FROM patients WHERE gender = 'M';

-- task 2 -- 
SELECT first_name , last_name FROM patients
WHERE allergies IS NULL;

-- task 3 -- 
SELECT first_name FROM patients
WHERE first_name LIKE 'c%';

-- task 4 --
 SELECT first_name,last_name FROM patients
WHERE weight between 100 AND 120;

-- task 5 -- 
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS null;

-- task 6 -- 
SELECT concat(first_name , ' ' ,last_name) as full_name
FROM patients;

-- task 7 -- 
SELECT p.first_name,p.last_name,pr.province_name FROM patients AS p 
LEFT JOIN province_names AS pr ON p.province_id = pr.province_id;

-- task 8 -- 
SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;

-- task 9 -- 
SELECT first_name,last_name,height
FROM patients
ORDER BY height desc
limit 1 ;

-- task 10 -- 
SELECT * FROM patients
WHERE patient_id IN(1,45,534,879,1000);

-- task 11 -- 
SELECT count(*) AS Total_admissions
FROM admissions;


-- task 12 --
SELECT * FROM admissions
WHERE admission_date = discharge_date;

-- task 13 -- 
SELECT count(*) AS Total_admissions
FROM admissions
WHERE patient_id=579;

-- task 14 -- 
SELECT DISTINCT city FROM patients
WHERE province_id = 'ns';

-- task 15 --
SELECT first_name,last_name,birth_date 
FROM patients
WHERE height > 160 and weight > 70;

-- task 16 --
SELECT DISTINCT YEAR(birth_date) AS birth_year
 FROM patients
 ORDER BY birth_year ASC;

-- task 17 --
 SELECT first_name FROM patients
 GROUP BY first_name
 HAVING count(*) = 1;
 
 -- task 18 -- 
 SELECT patient_id,first_name FROM patients
 WHERE first_name LIKE 's%s'
 AND length(first_name)>= 6;
 
 -- task 19 --
 SELECT p.patient_id,p.first_name,p.last_name FROM patients AS p
 JOIN admissions AS a
 ON p.patient_id = a.patient_id
 WHERE a.diagnosis = 'Dementia';
 
 -- task 20 --
 SELECT first_name FROM patients
 ORDER BY length(first_name) ,first_name ASC;
 
 -- task 21 --
SELECT
SUM(CASE WHEN gender = 'm' THEN 1 ELSE 0 END) AS Male_count,
SUM(CASE WHEN gender = 'f' THEN 1 ELSE 0 END) AS Female_count
FROM patients;
 
  -- task 22 --
SELECT
SUM(CASE WHEN gender = 'm' THEN 1 ELSE 0 END) AS Male_count,
SUM(CASE WHEN gender = 'f' THEN 1 ELSE 0 END) AS Female_count
FROM patients;
  
  -- task 23 -- 
  SELECT * from admissions;
  SELECT patient_id,diagnosis FROM admissions
  GROUP BY patient_id,diagnosis
  HAVING count(*) > 1;
  
  -- task 24 --
  SELECT city,count(*) AS total_patients FROM patients
  GROUP BY city
  ORDER BY total_patients DESC,city ASC;
  
  -- task 25 --
  SELECT first_name,last_name,'patients' AS role FROM patients
  UNION
  SELECT first_name,last_name,'doctors' AS role FROM  doctors;
  
  -- task 26 -- 
SELECT allergies,count(*) AS count FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY  count DESC;

-- task 27 -- 
SELECT first_name,last_name,birth_date FROM patients
WHERE  birth_date BETWEEN '1970-01-01' AND '1970-12-31'
ORDER BY birth_date ASC;

-- task 28 --
SELECT concat(upper(last_name),(','),lower(first_name)) AS FULL_NAME
FROM patients
ORDER BY first_name DESC;

-- task 29 -- 
SELECT province_id, sum(height) AS TOTAL_HEIGHT
 FROM patients
 GROUP BY province_id
 HAVING TOTAL_HEIGHT >=7000;
 
 -- task 30 --
 SELECT max(weight) -min(weight) AS  weight_difference
 FROM patients
 WHERE last_name='Maroni';
 
 -- task 31 --
 SELECT day(admission_date) AS day_of_month,
 count(*) AS Total_Admission
 FROM admissions
 GROUP BY  day_of_month
 ORDER BY Total_Admission DESC;
 
 -- task 32 --
 SELECT floor(weight/10)*10 AS Weight_Group,
 count(*) AS Total_Patients
 FROM patients
 group by weight_group
 ORDER BY weight_group DESC;
 
 -- task 33 -- 
 SELECT patient_id, weight, height,
CASE
WHEN weight / POWER(height/100, 2) >= 30 THEN 1
ELSE 0
END AS isObese
FROM patients;

-- task 34 --
SELECT DISTINCT p.patient_id, p.first_name, p.last_name, d.specialty FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
AND d.first_name = 'Lisa';




 
 
 
 
 





  
 









