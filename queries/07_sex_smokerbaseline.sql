-- sex_smokerbaseline

WITH age_segments AS (
SELECT
    CASE
      WHEN age BETWEEN 18 AND 29 THEN '18-29'
      WHEN age BETWEEN 30 AND 39 THEN '30-39'
      WHEN age BETWEEN 40 AND 49 THEN '40-49'
      ELSE '50+'
    END AS age_band,
    sex,
    smoker,
    charges
  FROM insurance
)

SELECT
  age_band,
  ROUND(AVG(CASE WHEN sex = 'male'   AND smoker = 'yes' THEN charges END), 1) AS avg_male_smoker,
  ROUND(AVG(CASE WHEN sex = 'male'   AND smoker = 'no'  THEN charges END), 1) AS avg_male_nonsmoker,
  ROUND(AVG(CASE WHEN sex = 'female' AND smoker = 'yes' THEN charges END), 1) AS avg_female_smoker,
  ROUND(AVG(CASE WHEN sex = 'female' AND smoker = 'no'  THEN charges END), 1) AS avg_female_nonsmoker,
  COUNT(*) AS cnt_total
FROM age_segments
GROUP BY age_band
ORDER BY age_band
