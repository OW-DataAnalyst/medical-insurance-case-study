-- pareto top 20%

WITH ranked AS (
SELECT
    *,
    CUME_DIST() OVER (ORDER BY charges DESC) AS cum_dist
FROM insurance
),
totals AS (
SELECT
    SUM(charges) AS total_charges
FROM insurance
)
SELECT
  COUNT(*)                                        AS cnt_top20,
  ROUND(AVG(age), 1)                              AS avg_age,
  ROUND(AVG(bmi), 1)                              AS avg_bmi,
  ROUND(AVG(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END) * 100, 1) AS smoker_share_pct,
  ROUND(SUM(charges), 1)                          AS sum_charges_top20,
  ROUND(SUM(charges) / totals.total_charges * 100, 1)   AS pct_total_charges
FROM ranked
CROSS JOIN totals
WHERE cum_dist <= 0.2;
