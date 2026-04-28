-- Calculates churn rate for active members only
-- Purpose: understand whether engagement (being an active member) reduces churn

SELECT
  ROUND(AVG(exited),2) AS member_churn_rate
  FROM `named-foundry-494619-d0.customer_churn.customers_cleaned`
WHERE is_active_member = 1
