-- Analyzes churn rate by number of products used to understand how customer engagement level affects churn behavior
-- Includes customer count per segment to ensure results are interpreted in context (segment size matters)

SELECT
  num_of_products_group,

  -- Average of churn flag (0/1) represents churn rate per product usage group
  ROUND(AVG(exited), 2) AS churn_rate,

  -- Number of customers in each group (important for evaluating reliability of results)
  COUNT(*) AS customer_count

FROM `named-foundry-494619-d0.customer_churn.customers_cleaned`

-- Grouping customers based on number of products used
GROUP BY num_of_products_group

-- Sorting to highlight which engagement level has the highest churn risk
ORDER BY churn_rate DESC
