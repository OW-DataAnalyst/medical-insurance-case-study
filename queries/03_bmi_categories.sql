-- Bmi categories compared to charges

with bmi_stats AS (
select
case
	when bmi < 18.5 then 'Underweight'
	when bmi between 18.5 and 24.9 then 'Normal'
	when bmi between 25 and 29.9 then 'Overweight'
	ELSE 'Obese'
    END AS bmi_cat,
    ROUND(AVG(charges), 1) AS avg_charges,
    COUNT(*)               AS cnt
FROM insurance
GROUP BY bmi_cat
)
SELECT
  bmi_cat,
  avg_charges,
  cnt,
  DENSE_RANK() OVER (ORDER BY avg_charges DESC) AS ranking
FROM bmi_stats
ORDER BY ranking
