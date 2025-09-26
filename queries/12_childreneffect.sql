-- children effect 
SELECT
  children,
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
FROM insurance
GROUP BY children
ORDER BY children;
