# Looker Studio Dashboard

## Dashboard Link
[SaaS Revenue Operations Dashboard](https://lookerstudio.google.com/reporting/425bca71-fad7-425a-b274-e64f752a42dc)

## Data Source
- BigQuery View: revenue_ops.saas_sales_cleaned
- 9,994 rows | 2020-01-04 to 2023-12-31

## Charts
1. KPI Scorecards - Customers, Avg Margin %, Total Profit, Total Revenue
2. Monthly Revenue Trend - Time series of SUM(sales) by month
3. Discount Impact on Profit - Bar chart showing profit by discount tier
4. Revenue by Segment - Donut chart (SMB 50.6%, Strategic 30.7%, Enterprise 18.7%)
5. YoY Segment Performance - Table with sales, profit, avg margin by segment/year

## Key Insight
Discounts above 20% destroy profitability:
- No Discount: +320,988 EUR profit (29.5% margin)
- High Discount (41%+): -99,559 EUR loss (-77.4% margin)
- Recommendation: Cap discounts at 20% to protect 135K+ EUR in annual profit
