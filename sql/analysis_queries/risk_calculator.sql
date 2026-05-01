-- 1. Add new columns to the table to store the calculated risk metrics
ALTER TABLE `named-foundry-494619-d0.customer_churn.customers_cleaned`
ADD COLUMN IF NOT EXISTS risk_group STRING;

ALTER TABLE `named-foundry-494619-d0.customer_churn.customers_cleaned`
ADD COLUMN IF NOT EXISTS risk_score INT64;

-- 2. Update columns with composite risk logic based on EDA findings
UPDATE `named-foundry-494619-d0.customer_churn.customers_cleaned`
SET 
  -- Calculate numerical risk score by assigning 1-2 point for each high-churn factor identified
  risk_score = (
    (CASE WHEN age BETWEEN 40 AND 59 THEN 2 ELSE 0 END) +    -- Middle age demographic risk
    (CASE WHEN age >= 60 THEN 1 ELSE 0 END) +
    (CASE WHEN is_active_member = 0 THEN 1 ELSE 0 END) +     -- Low engagement risk
    (CASE WHEN balance > 100000 THEN 1 ELSE 0 END) +         -- High-value asset risk
    (CASE WHEN geography = 'Germany' THEN 1 ELSE 0 END) +    -- Regional market risk
    (CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) +        -- Demographic trend risk
    (CASE WHEN num_of_products <> 2 THEN 1 ELSE 0 END)       -- Product friction risk
  ),
  -- Segment customers into descriptive risk groups based on their total risk score
  risk_group = CASE 
    WHEN (
      (CASE WHEN age BETWEEN 40 AND 59 THEN 2 ELSE 0 END) +
      (CASE WHEN age >= 60 THEN 1 ELSE 0 END) +
      (CASE WHEN is_active_member = 0 THEN 1 ELSE 0 END) +
      (CASE WHEN balance > 100000 THEN 1 ELSE 0 END) +
      (CASE WHEN geography = 'Germany' THEN 1 ELSE 0 END) +
      (CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) +
      (CASE WHEN num_of_products <> 2 THEN 1 ELSE 0 END)
    ) >= 4 THEN 'Critical Risk'
    WHEN (
      (CASE WHEN age BETWEEN 40 AND 59 THEN 2 ELSE 0 END) +
      (CASE WHEN age >= 60 THEN 1 ELSE 0 END) +
      (CASE WHEN is_active_member = 0 THEN 1 ELSE 0 END) +
      (CASE WHEN balance > 100000 THEN 1 ELSE 0 END) +
      (CASE WHEN geography = 'Germany' THEN 1 ELSE 0 END) +
      (CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) +
      (CASE WHEN num_of_products <> 2 THEN 1 ELSE 0 END)
    ) >= 2 THEN 'Medium Risk'
    ELSE 'Low Risk'
  END
-- WHERE TRUE is required by BigQuery for all UPDATE statements to confirm intention to update the whole table
WHERE TRUE;
