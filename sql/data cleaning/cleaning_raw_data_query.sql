
-- Create a cleaned and transformed version of the raw customer dataset
CREATE OR REPLACE TABLE `named-foundry-494619-d0.customer_churn.customers_cleaned` AS

SELECT
  -- Unique customer identifier
  CustomerId AS customer_id,

  -- Core customer attributes
  CreditScore AS credit_score,
  Geography AS geography,
  Gender AS gender,
  Age AS age,
  Tenure AS tenure,
  NumOfProducts AS num_of_products,

  -- Financial metrics (rounded for consistency)
  ROUND(Balance, 1) AS balance,
  ROUND(EstimatedSalary, 1) AS estimated_salary,

  -- Convert binary indicators to INT64 so aggregations can be applied to them
  SAFE_CAST(HasCrCard AS INT64) AS has_credit_card,
  SAFE_CAST(IsActiveMember AS INT64) AS is_active_member,
  SAFE_CAST(Exited AS INT64) AS exited,


-- Age segmentation for customer profiling
CASE
  WHEN Age BETWEEN 18 AND 30 THEN 'Young'
  WHEN Age BETWEEN 31 AND 50 THEN 'Mid-Age'
  ELSE 'Old'
    END AS age_group,

-- Balance segmentation to identify customer value tiers
CASE
  WHEN Balance = 0 THEN 'No Balance'
  WHEN Balance < 50000 THEN 'Low Balance'
  WHEN Balance < 100000 THEN 'Average Balance'
  ELSE 'High Balance'
    END AS balance_group,

-- Tenure segmentation to measure customer loyalty
CASE
  WHEN Tenure BETWEEN 0 AND 2 THEN 'New'
  WHEN Tenure BETWEEN 3 AND 6 THEN 'Mid'
  ELSE 'Long-Term'
    END AS tenure_group,

-- Product usage segmentation to analyze engagement depth
CASE
  WHEN NumOfProducts = 1 THEN '1 Product'
  WHEN NumOfProducts BETWEEN 2 AND 3 THEN '2-3 Products'
  ELSE '4+ Products'
    END AS num_of_products_group

FROM `named-foundry-494619-d0.customer_churn.customers_raw`

-- Remove any records with missing customer IDs
WHERE customerID IS NOT NULL;
