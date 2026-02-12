-- ============================================
-- 02: DATA CLEANING & TRANSFORMATION
-- ============================================

CREATE OR REPLACE VIEW revenue_ops.saas_sales_cleaned AS
SELECT
  `Row ID`                          AS row_id,
  `Order ID`                        AS order_id,
  `Order Date`                      AS order_date,
  EXTRACT(YEAR FROM `Order Date`)   AS order_year,
  EXTRACT(MONTH FROM `Order Date`)  AS order_month,
  EXTRACT(QUARTER FROM `Order Date`) AS order_quarter,
  `Contact Name`                    AS contact_name,
  Country                           AS country,
  City                              AS city,
  Region                            AS region,
  Subregion                         AS subregion,
  Customer                          AS customer,
  `Customer ID`                     AS customer_id,
  Industry                          AS industry,
  Segment                           AS segment,
  Product                           AS product,
  License                           AS license,
  Sales                             AS sales,
  Quantity                          AS quantity,
  Discount                          AS discount,
  Profit                            AS profit,

  -- Derived metrics
  ROUND(Sales - Profit, 2)          AS cost,
  ROUND(Profit / NULLIF(Sales, 0) * 100, 2) AS profit_margin_pct,
  ROUND(Sales * (1 - Discount), 2)  AS net_sales,
  CASE
    WHEN Discount = 0 THEN 'No Discount'
    WHEN Discount <= 0.2 THEN 'Low (1-20%)'
    WHEN Discount <= 0.4 THEN 'Medium (21-40%)'
    ELSE 'High (41%+)'
  END AS discount_tier

FROM `revenue_ops.saas_sales`
WHERE Sales IS NOT NULL
  AND `Order Date` IS NOT NULL;
