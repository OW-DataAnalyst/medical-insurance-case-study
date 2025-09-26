-- top n by risk group

WITH base AS (
SELECT
    *,
    CASE
      WHEN age BETWEEN 18 AND 29 THEN '18-29'
      WHEN age BETWEEN 30 AND 39 THEN '30-39'
      WHEN age BETWEEN 40 AND 49 THEN '40-49'
      ELSE '50+'
    END AS age_band,
    CASE
      WHEN bmi < 18.5 THEN 'Underweight'
      WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal'
      WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
      ELSE 'Obese'
    END AS bmi_cat
FROM insurance
),
risk_groups AS (
SELECT
    CONCAT(smoker, '_', bmi_cat, '_', age_band) AS risk_group,
    age,
    sex,
    bmi,
    smoker,
    charges
FROM base
),
ranked AS (
SELECT
    risk_group,
    age,
    sex,
    bmi,
    smoker,
    charges,
    ROW_NUMBER() OVER (
      PARTITION BY risk_group
      ORDER BY charges DESC
    ) AS rn
FROM risk_groups
)
SELECT
  risk_group,
  age,
  sex,
  bmi,
  smoker,
  charges,
  rn
FROM ranked
WHERE rn <= 3
ORDER BY risk_group, charges DESC;
