-- quartiles profile

WITH quartiles AS (
SELECT
    *,
    NTILE(4) OVER (ORDER BY charges) AS quartile
FROM insurance
)
SELECT
  quartile,
  ROUND(AVG(age), 1) AS avg_age,
  ROUND(AVG(bmi), 1) AS avg_bmi,
  ROUND(
    AVG(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END) * 100
  , 1) AS smoker_share_pct,
  ROUND(AVG(charges), 1) AS avg_charges,
  COUNT(*)         AS cnt
FROM quartiles
GROUP BY quartile
ORDER BY quartile
