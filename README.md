# Medical-Data-History-SQL-Project
From NULL allergies to BMI calculations — solving 32 real-world medical data problems using advanced MySQL on a live hospital database. Includes JOINs, CASE WHEN, data cleaning &amp; an interactive dashboard built from scratch.

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:028090,100:02C39A&height=200&section=header&text=Medical%20Data%20History&fontSize=48&fontColor=ffffff&fontAlignY=38&desc=Turning%20Raw%20Hospital%20Data%20Into%20Meaningful%20Insights&descAlignY=58&descSize=16" width="100%"/>

<br/>

# 🏥 From Raw Data to Real Answers — A SQL Story

### *32 queries. 3 tables. 1 mission: make hospital data speak.*

<br/>

![SQL](https://img.shields.io/badge/MySQL-Advanced-028090?style=for-the-badge&logo=mysql&logoColor=white)
![Queries](https://img.shields.io/badge/SQL%20Queries-32%20Written-02C39A?style=for-the-badge&logo=databricks&logoColor=white)
![Status](https://img.shields.io/badge/Project-Completed-F7C948?style=for-the-badge&logo=checkmarx&logoColor=black)
![Dashboard](https://img.shields.io/badge/Dashboard-Interactive-FF6B8A?style=for-the-badge&logo=googleanalytics&logoColor=white)

</div>

---

<br/>

## 🧠 The Problem I Was Given

> *"Here's a hospital database. Patients. Admissions. Doctors. Find what matters."*

That was the challenge. No hints. No starter code. Just three tables sitting in a live MySQL database — and 32 real analytical questions that needed answering.

I didn't just write queries. I had to **think like a data analyst** — understand what each question was actually asking, figure out which tables to look at, decide how to connect them, and return results that were clean, accurate, and useful.

This project is the result of that process.

---

<br/>

## 🗄️ The Data I Was Working With

Three interconnected tables. Real hospital records.

```
┌──────────────────────┐          ┌─────────────────────────┐          ┌──────────────────┐
│      PATIENTS        │          │       ADMISSIONS         │          │     DOCTORS      │
│──────────────────────│          │─────────────────────────│          │──────────────────│
│ 🔑 patient_id        │──────────│ 🔗 patient_id            │          │ 🔑 doctor_id     │
│    first_name        │          │    admission_date        │──────────│    first_name    │
│    last_name         │          │    discharge_date        │          │    last_name     │
│    gender            │          │    diagnosis             │          │    specialty     │
│    birth_date        │          │ 🔗 doctor_id             │          └──────────────────┘
│    city              │          └─────────────────────────┘
│    province_id       │
│    allergies         │
│    height / weight   │
└──────────────────────┘
```

> Each table alone tells a partial story. The real insight comes from **connecting them.**

---

<br/>

## ⚡ What I Built & How I Approached It

I broke the 32 questions into layers — starting with the fundamentals, then building up to multi-table logic and advanced computation. Here's how my thinking evolved:

<br/>

### 🔹 Layer 1 — Getting Comfortable With the Data

Before writing a single complex query, I needed to understand what was inside these tables. I started by pulling specific subsets — patients by gender, patients without allergy records, names matching patterns.

*This wasn't just filtering. It was reconnaissance.*

```sql
-- Who has no allergy information recorded?
-- This matters — a NULL here isn't nothing. It's a data gap that affects patient care.
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;
```

I even wrote a data-cleaning query — replacing every NULL allergy entry with `'NKA'` (No Known Allergies), a real clinical standard:

```sql
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;
```

> Small query. Big impact. Clean data is the foundation of every insight that follows.

---

<br/>

### 🔹 Layer 2 — Asking Aggregate Questions

Once I understood the shape of the data, I started asking *how many* and *how much* — the kinds of questions a hospital manager would actually care about.

```sql
-- How many patients were admitted and sent home the same day?
SELECT *
FROM admissions
WHERE DATE(admission_date) = DATE(discharge_date);
```

```sql
-- Which cities have the most patients? Ranked.
SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;
```

```sql
-- Are any patients being repeatedly admitted for the same diagnosis?
-- This could flag chronic conditions or readmission patterns.
SELECT patient_id, diagnosis, COUNT(*) AS times_admitted
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;
```

> Aggregation isn't about numbers — it's about finding the signal in the noise.

---

<br/>

### 🔹 Layer 3 — Connecting Tables to See the Full Picture

Single-table queries only go so far. The real questions require joining — pulling data from multiple tables and matching records correctly.

```sql
-- Give me every patient's name alongside their full province name
-- (not just a 2-letter code — the actual readable name)
SELECT p.first_name, p.last_name, pr.province_name
FROM patients AS p
LEFT JOIN province_names AS pr
  ON p.province_id = pr.province_id;
```

```sql
-- Which patients were diagnosed with Dementia?
-- That information lives in admissions — not in the patients table.
SELECT DISTINCT p.patient_id, p.first_name, p.last_name
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.primary_diagnosis = 'Dementia';
```

```sql
-- Show every person in this hospital system — patient or doctor — in one unified list
SELECT first_name, last_name, 'Patient' AS role FROM patients
UNION ALL
SELECT first_name, last_name, 'Doctor' AS role FROM doctors;
```

> When you JOIN correctly, you stop seeing rows — you start seeing people.

---

<br/>

### 🔹 Layer 4 — Advanced Logic & Real-World Computation

The final layer is where SQL stops being a lookup tool and becomes an **analytical engine.**

```sql
-- Flag every patient as obese or not, based on their actual BMI
-- BMI = weight(kg) / height(m)²
SELECT patient_id, weight, height,
  CASE
    WHEN (weight / POW(height / 100.0, 2)) >= 30 THEN 1
    ELSE 0
  END AS isObese
FROM patients;
```

```sql
-- Group all patients by weight range (100-109 → group 100, 110-119 → group 110...)
-- Then rank by group size to see the most common weight bracket
SELECT (FLOOR(weight / 10) * 10) AS weight_group,
       COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;
```

```sql
-- Three-table join: Find patients diagnosed with Epilepsy
-- AND whose attending doctor's first name is Lisa
-- AND show her specialty
SELECT DISTINCT p.patient_id, p.first_name, p.last_name, d.specialty
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
  AND d.first_name = 'Lisa';
```

> This is where data stops being a spreadsheet and starts being a decision-support tool.

---

<br/>

## 📊 The Dashboard I Built

Writing the queries was only half the work. I also built a **fully interactive dashboard** — pure HTML, no frameworks, no installs — that presents the entire project visually.

**What's inside the dashboard:**

| Section | What it shows |
|---------|--------------|
| 📈 Overview | KPI cards, category distribution charts, SQL clause usage donut |
| 🔍 Query Explorer | Click any query → see description + syntax-highlighted SQL live |
| 📂 Categories | All 5 query categories broken down with bar charts |
| 🗄️ Schema Viewer | Full ER diagram with table relationships |
| 📋 Query Table | All 32 queries filterable by category |

> **No installation needed.** Download and open in any browser.

---

<br/>

## 🛠️ Skills This Project Demonstrates

```
Data Retrieval       →  SELECT, WHERE, DISTINCT, LIMIT, ORDER BY
Data Filtering       →  LIKE, BETWEEN, IN, IS NULL, AND / OR
Data Aggregation     →  COUNT, SUM, MAX, MIN, GROUP BY, HAVING
Table Relationships  →  LEFT JOIN, INNER JOIN, multi-table JOIN, UNION ALL
String Operations    →  CONCAT, UPPER, LOWER, TRIM, CHAR_LENGTH
Date Operations      →  YEAR(), DAY(), DATE(), BETWEEN date ranges
Conditional Logic    →  CASE WHEN / THEN / ELSE / END
Math Functions       →  FLOOR(), POW() — used for real BMI calculation
Data Cleaning        →  UPDATE, SET, handling NULL values
```

---



## 🚀 Run It Yourself

```bash
# To explore the dashboard
→ Download  Medical_Data_History_Dashboard.html
→ Open in Chrome, Edge, or Firefox
→ No setup. No server. Just open and explore.
```

```sql
-- To run the queries on the live database
Host     : projects.datamites.com
Database : project_medical_data_history
Username : dm_team4

-- Open Medical_Data_History.sql in MySQL Workbench
-- Run any query — they are all self-contained and clearly labeled
```

---

<br/>

<div align="center">

## 👤 About Me

**Pon Hariharan . C**

*I enjoy turning messy data into clear answers.*
*SQL is my tool. Curiosity is my method. Insight is the goal.*

📧 ponhariharan325@gmail.com

---


<img src="https://capsule-render.vercel.app/api?type=waving&color=0:02C39A,100:028090&height=120&section=footer" width="100%"/>

</div>
