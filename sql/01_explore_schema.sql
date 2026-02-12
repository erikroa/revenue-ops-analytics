-- ============================================
-- 01: DATA EXPLORATION
-- ============================================

SELECT COUNT(*) AS total_rows FROM `revenue_ops.saas_sales`;

SELECT
  MIN(`Order Date`) AS earliest_order,
  MAX(`Order Date`) AS latest_order
FROM `revenue_ops.saas_sales`;

SELECT
  COUNT(DISTINCT `Customer ID`) AS unique_customers,
  COUNT(DISTINCT `Product`) AS unique_products,
  COUNT(DISTINCT `Country`) AS unique_countries,
  COUNT(DISTINCT `Industry`) AS unique_industries,
  COUNT(DISTINCT `Segment`) AS unique_segments
FROM `revenue_ops.saas_sales`;

-- Segment breakdown
SELECT `Segment`, COUNT(*) AS orders, ROUND(SUM(Sales), 2) AS total_sales
FROM `revenue_ops.saas_sales`
GROUP BY `Segment`
ORDER BY total_sales DESC;

-- Check for NULLs in critical columns
SELECT
  COUNTIF(Sales IS NULL) AS null_sales,
  COUNTIF(Profit IS NULL) AS null_profit,
  COUNTIF(`Order Date` IS NULL) AS null_dates,
  COUNTIF(`Customer ID` IS NULL) AS null_customers,
  COUNTIF(Discount IS NULL) AS null_discount
FROM `revenue_ops.saas_sales`;
