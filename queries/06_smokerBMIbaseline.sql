
-- smokerBMIbaseline
WITH bmi_segments AS (
SELECT
    CASE
      WHEN bmi < 18.5 THEN 'Underweight'
      WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal'
      WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
      ELSE 'Obese'
    END AS bmi_cat,
    smoker,
    charges
FROM insurance
)
SELECT
  bmi_cat,
  ROUND(AVG(CASE WHEN smoker = 'yes' THEN charges END), 1) AS avg_smoker,
  ROUND(AVG(CASE WHEN smoker = 'no'  THEN charges END), 1) AS avg_nonsmoker,
  ROUND(
    AVG(CASE WHEN smoker = 'yes' THEN charges END)
    - AVG(CASE WHEN smoker = 'no'  THEN charges END)
  , 1) AS diff_charges,
  ROUND(
    AVG(CASE WHEN smoker = 'yes' THEN charges END)
    / NULLIF(AVG(CASE WHEN smoker = 'no' THEN charges END), 0)
  , 2) AS ratio_smoker_to_nonsmoker,
  COUNT(*) AS cnt
FROM bmi_segments
GROUP BY bmi_cat
ORDER BY
DENSE_RANK() OVER (ORDER BY avg_smoker DESC)
