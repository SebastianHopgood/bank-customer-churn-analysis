-- Analyzes churn rate by age group to identify whether customer age influences churn behavior
-- Also includes customer count per segment to provide context on segment size and reliability

SELECT
  age_group,

  -- Average of churn flag (0/1) gives churn rate per age group
  ROUND(AVG(exited), 2) AS churn_rate,

  -- Number of customers in each age group (important for interpreting churn reliability)
  COUNT(*) AS customer_count

FROM `named-foundry-494619-d0.customer_churn.customers_cleaned`

-- Grouping customers into age segments for comparison
GROUP BY age_group

-- Sorting to highlight highest churn segments first
ORDER BY churn_rate DESC;
