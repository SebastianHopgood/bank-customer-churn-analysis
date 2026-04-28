-- Analyzes churn rate by balance group to understand how customer financial status relates to churn behavior
-- Includes customer count per segment to ensure results are interpreted with proper context (segment size matters)

SELECT
  balance_group,

  -- Average of churn flag (0/1) represents churn rate per balance segment
  ROUND(AVG(exited), 2) AS churn_rate,

  -- Number of customers in each balance group (helps assess reliability of results)
  COUNT(*) AS customer_count

FROM `named-foundry-494619-d0.customer_churn.customers_cleaned`

-- Group customers based on predefined balance segments (e.g., low, high, no balance)
GROUP BY balance_group

-- Sorts from highest to lowest churn rate to highlight risk segments
ORDER BY churn_rate DESC;
