-- Analyzes churn rate by gender to determine whether gender has any influence on customer churn behavior
-- Includes customer count per group to provide context and ensure results are not misinterpreted due to imbalance

SELECT
  gender,

  -- Average of churn flag (0/1) gives churn rate per gender group
  ROUND(AVG(exited), 2) AS churn_rate,

  -- Number of customers in each gender group (helps assess reliability of comparison)
  COUNT(*) AS customer_count

FROM `named-foundry-494619-d0.customer_churn.customers_cleaned`

-- Grouping customers by gender for comparison
GROUP BY gender

-- Sorting to highlight which gender group has higher churn rates
ORDER BY churn_rate DESC;
