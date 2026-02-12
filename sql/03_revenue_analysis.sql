-- ============================================
-- 03: REVENUE OPERATIONS ANALYSIS
-- ============================================

-- 1. MONTHLY RECURRING REVENUE (MRR) TREND
SELECT
  order_year,
  order_month,
  COUNT(DISTINCT customer_id) AS active_customers,
  COUNT(DISTINCT order_id)    AS total_orders,
  ROUND(SUM(sales), 2)        AS monthly_revenue,
  ROUND(SUM(profit), 2)       AS monthly_profit,
  ROUND(AVG(profit_margin_pct), 1) AS avg_margin_pct
FROM revenue_ops.saas_sales_cleaned
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

-- 2. DISCOUNT IMPACT ON REVENUE (Deal Desk View)
SELECT
  discount_tier,
  COUNT(*) AS total_deals,
  ROUND(SUM(sales), 2) AS gross_revenue,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND(AVG(profit_margin_pct), 1) AS avg_margin_pct,
  ROUND(SUM(profit) / NULLIF(SUM(sales), 0) * 100, 1) AS blended_margin_pct
FROM revenue_ops.saas_sales_cleaned
GROUP BY discount_tier
ORDER BY avg_margin_pct DESC;

-- 3. CUSTOMER LIFETIME VALUE (Top 20 Customers)
SELECT
  customer,
  segment,
  industry,
  COUNT(DISTINCT order_id) AS total_orders,
  ROUND(SUM(sales), 2) AS lifetime_revenue,
  ROUND(SUM(profit), 2) AS lifetime_profit,
  ROUND(AVG(profit_margin_pct), 1) AS avg_margin_pct,
  MIN(order_date) AS first_order,
  MAX(order_date) AS last_order
FROM revenue_ops.saas_sales_cleaned
GROUP BY customer, segment, industry
ORDER BY lifetime_revenue DESC
LIMIT 20;

-- 4. PRODUCT PERFORMANCE & MIX
SELECT
  product,
  COUNT(*) AS deals,
  ROUND(SUM(sales), 2) AS total_revenue,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND(AVG(profit_margin_pct), 1) AS avg_margin_pct,
  ROUND(AVG(discount), 2) AS avg_discount
FROM revenue_ops.saas_sales_cleaned
GROUP BY product
ORDER BY total_revenue DESC;

-- 5. REGIONAL REVENUE BREAKDOWN
SELECT
  region,
  subregion,
  COUNT(DISTINCT customer_id) AS customers,
  ROUND(SUM(sales), 2) AS total_revenue,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND(AVG(profit_margin_pct), 1) AS avg_margin_pct
FROM revenue_ops.saas_sales_cleaned
GROUP BY region, subregion
ORDER BY total_revenue DESC;

-- 6. YoY GROWTH BY SEGMENT
WITH yearly AS (
  SELECT
    segment,
    order_year,
    ROUND(SUM(sales), 2) AS annual_revenue
  FROM revenue_ops.saas_sales_cleaned
  GROUP BY segment, order_year
)
SELECT
  segment,
  order_year,
  annual_revenue,
  LAG(annual_revenue) OVER (PARTITION BY segment ORDER BY order_year) AS prev_year,
  ROUND(
    (annual_revenue - LAG(annual_revenue) OVER (PARTITION BY segment ORDER BY order_year))
    / NULLIF(LAG(annual_revenue) OVER (PARTITION BY segment ORDER BY order_year), 0) * 100,
  1) AS yoy_growth_pct
FROM yearly
ORDER BY segment, order_year;

-- 7. DISCOUNT ABUSE DETECTION
SELECT
  contact_name,
  segment,
  COUNT(*) AS deals,
  ROUND(AVG(discount) * 100, 1) AS avg_discount_pct,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  COUNTIF(profit < 0) AS unprofitable_deals
FROM revenue_ops.saas_sales_cleaned
WHERE discount > 0.2
GROUP BY contact_name, segment
HAVING COUNT(*) >= 5
ORDER BY avg_discount_pct DESC
LIMIT 20;
