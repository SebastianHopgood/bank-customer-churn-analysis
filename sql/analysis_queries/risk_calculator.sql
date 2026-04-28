-- 1. Add new columns to the table to store the calculated risk metrics
ALTER TABLE `named-foundry-494619-d0.customer_churn.customers_cleaned`
ADD COLUMN IF NOT EXISTS risk_group STRING;

ALTER TABLE `named-foundry-494619-d0.customer_churn.customers_cleaned`
ADD COLUMN IF NOT EXISTS risk_score INT64;

-- 2. Update columns with composite risk logic based on EDA findings
UPDATE `named-foundry-494619-d0.customer_churn.customers_cleaned`
SET 
  -- Calculate numerical risk score (0-6) by assigning 1 point for each high-churn factor identified
  risk_score = (
    (CASE WHEN age >= 51 THEN 1 ELSE 0 END) +                   -- Older demographic risk
    (CASE WHEN is_active_member = 0 THEN 1 ELSE 0 END) +        -- Low engagement risk
    (CASE WHEN balance > 100000 THEN 1 ELSE 0 END) +           -- High-value asset risk
    (CASE WHEN geography = 'Germany' THEN 1 ELSE 0 END) +       -- Regional market risk
    (CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) +            -- Demographic trend risk
    (CASE WHEN num_of_products = 1 OR num_of_products >= 4 THEN 1 ELSE 0 END) -- Product friction risk
  ),
  
  -- Segment customers into descriptive risk groups based on their total risk score
  risk_group = CASE 
    WHEN (
      (CASE WHEN age >= 51 THEN 1 ELSE 0 END) +
      (CASE WHEN is_active_member = 0 THEN 1 ELSE 0 END) +
      (CASE WHEN balance > 100000 THEN 1 ELSE 0 END) +
      (CASE WHEN geography = 'Germany' THEN 1 ELSE 0 END) +
      (CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) +
      (CASE WHEN num_of_products = 1 OR num_of_products >= 4 THEN 1 ELSE 0 END)
    ) >= 4 THEN 'Critical Risk'
    WHEN (
      (CASE WHEN age >= 51 THEN 1 ELSE 0 END) +
      (CASE WHEN is_active_member = 0 THEN 1 ELSE 0 END) +
      (CASE WHEN balance > 100000 THEN 1 ELSE 0 END) +
      (CASE WHEN geography = 'Germany' THEN 1 ELSE 0 END) +
      (CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) +
      (CASE WHEN num_of_products = 1 OR num_of_products >= 4 THEN 1 ELSE 0 END)
    ) >= 2 THEN 'Medium Risk'
    ELSE 'Low Risk'
  END
-- WHERE TRUE is required by BigQuery for all UPDATE statements to confirm intention to update the whole table
WHERE TRUE;
