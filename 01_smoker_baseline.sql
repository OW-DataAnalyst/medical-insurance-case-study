-- Cel: Czy palacze płacą więcej?

SELECT
    -- średnie koszty dla palaczy i niepalących
    ROUND(AVG(CASE WHEN smoker = 'yes' THEN charges END), 1) AS avg_smoker,
    ROUND(AVG(CASE WHEN smoker = 'no'  THEN charges END), 1) AS avg_nonsmoker,
    -- różnica absolutna
    ROUND(
      AVG(CASE WHEN smoker = 'yes' THEN charges END)
      - AVG(CASE WHEN smoker = 'no'  THEN charges END)
    , 1) AS diff_charges,
    -- stosunek (palacze / niepalący) z ochroną przed dzieleniem przez 0
    ROUND(
      AVG(CASE WHEN smoker = 'yes' THEN charges END)
      / NULLIF(AVG(CASE WHEN smoker = 'no'  THEN charges END), 0)
    , 2) AS ratio_smoker_to_nonsmoker
FROM insurance;


