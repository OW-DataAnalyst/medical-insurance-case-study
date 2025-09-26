
-- smoker baseline with age group
WITH age_segments AS (
  SELECT
    CASE
      WHEN age BETWEEN 18 AND 29 THEN '18-29'
      WHEN age BETWEEN 30 AND 39 THEN '30-39'
      WHEN age BETWEEN 40 AND 49 THEN '40-49'
      ELSE '50+'
    END AS age_band,
    smoker,
    charges
  FROM insurance
)
SELECT
  age_band,
  ROUND(AVG(CASE WHEN smoker = 'yes' THEN charges END), 1) AS avg_smoker,
  ROUND(AVG(CASE WHEN smoker = 'no'  THEN charges END), 1) AS avg_nonsmoker,
  ROUND(
    AVG(CASE WHEN smoker = 'yes' THEN charges END)
    - AVG(CASE WHEN smoker = 'no'  THEN charges END)
  , 1) AS diff_charges,
  ROUND(
    AVG(CASE WHEN smoker = 'yes' THEN charges END)
    / NULLIF(AVG(CASE WHEN smoker = 'no' THEN charges END), 0)
  , 2) AS ratio_smoker_to_nonsmoker
FROM age_segments
GROUP BY age_band
ORDER BY age_band
