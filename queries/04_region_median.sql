-- Mediana

WITH ranked AS (
SELECT
    region,
    charges,
    ROW_NUMBER() OVER (
		PARTITION BY region
		ORDER BY charges
    ) AS rn,
    COUNT(*) OVER (
		PARTITION BY region
    ) AS cnt
  FROM insurance
)
SELECT
  region,
  ROUND(AVG(charges), 1) AS median_charges
FROM ranked
WHERE
  rn IN (
    FLOOR((cnt + 1) / 2),
    CEIL((cnt + 1) / 2)
  )
GROUP BY region
ORDER BY median_charges DESC
