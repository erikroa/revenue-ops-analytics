
-- 1. REVENUE BY SEGMENT
SELECT
  segment,
  COUNT(DISTINCT customer_id)  AS unique_customers,
  COUNT(*)                     AS total_orders,
  ROUND(SUM(sales), 2)         AS gross_revenue,
  ROUND(SUM(profit), 2)        AS total_profit,
  ROUND(AVG(profit_margin_pct), 1) AS avg_margin_pct
FROM revenue_ops.saas_sales_cleaned
GROUP BY segment
ORDER BY gross_revenue DESC;

-- 2. REVENUE BY PRODUCT

SELECT
  product,
  COUNT(*)                     AS total_orders,
  ROUND(SUM(sales), 2)         AS gross_revenue,
  ROUND(SUM(profit), 2)        AS total_profit,
  ROUND(AVG(profit_margin_pct), 1) AS avg_margin_pct,
  ROUND(AVG(discount) * 100, 1)   AS avg_discount_pct
FROM revenue_ops.saas_sales_cleaned
GROUP BY product
ORDER BY gross_revenue DESC;


-- 3. MONTHLY REVENUE TREND

SELECT
  order_year,
  order_month,
  COUNT(*)                 AS total_orders,
  ROUND(SUM(sales), 2)     AS monthly_revenue,
  ROUND(SUM(profit), 2)    AS monthly_profit
FROM revenue_ops.saas_sales_cleaned
GROUP BY order_year, order_month
ORDER BY order_year, order_month;


-- 4. DISCOUNT IMPACT ON MARGIN

SELECT
  discount_tier,
  COUNT(*)                         AS total_deals,
  ROUND(SUM(sales), 2)             AS gross_revenue,
  ROUND(SUM(profit), 2)            AS total_profit,
  ROUND(AVG(profit_margin_pct), 1) AS avg_margin_pct,
  ROUND(SUM(profit) / NULLIF(SUM(sales),