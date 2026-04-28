-- Analyzes churn rate by geography to identify whether customer location influences churn behavior
-- Includes customer count per country to provide context and ensure segment reliability

SELECT
  geography,

  -- Average of churn flag (0/1) gives churn rate per country
  ROUND(AVG(exited), 2) AS churn_rate,

  -- Number of customers in each geography (helps interpret how representative results are)
  COUNT(*) AS customer_count

FROM `named-foundry-494619-d0.customer_churn.customers_cleaned`

-- Grouping customers by country/region for comparison
GROUP BY geography

-- Sorting to highlight highest churn regions first
ORDER BY churn_rate DESC;
