# Looker Studio Dashboard Configuration

## Dashboard Overview
**Name:** Revenue Operations Analytics
**Data source:** BigQuery - `revenue_ops.saas_sales_cleaned`
**Rows:** 9,994 SaaS transactions

---

## Page 1: Revenue Overview

| Chart | Type | Dimension | Metric |
|---|---|---|---|
| Total Revenue | Scorecard | - | SUM(sales) |
| Total Profit | Scorecard | - | SUM(profit) |
| Total Orders | Scorecard | - | COUNT(order_id) |
| Revenue by Segment | Bar chart | segment | SUM(sales) |
| Revenue by Product | Bar chart | product | SUM(sales) |
| Monthly Revenue Trend | Line chart | order_date (month) | SUM(sales) |

---

## Page 2: Profitability & Discounting

| Chart | Type | Dimension | Metric |
|---|---|---|---|
| Avg Profit Margin | Scorecard | - | AVG(profit_margin_pct) |
| Discount Impact on Margin | Bar chart | discount_tier | AVG(profit_margin_pct) |
| Profit by Region | Bar chart | region | SUM(profit) |
| Unprofitable Deals | Scorecard | - | COUNTIF(profit < 0) |

---

## Key Metrics Defined

| Metric | Formula |
|---|---|
| Profit Margin % | (Profit / Sales) * 100 |
| Net Sales | Sales * (1 - Discount) |
| Cost | Sales - Profit |
| Discount Tier | Bucketed: None / Low / Medium / High |