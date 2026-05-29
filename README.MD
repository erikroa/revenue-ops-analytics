# Revenue Operations Analytics

A SQL analytics project built on BigQuery demonstrating end-to-end revenue operations analysis, from raw data ingestion to a live Looker Studio dashboard.

**Stack:** BigQuery · SQL · Looker Studio · Google Cloud Platform
**Dataset:** 9,994 SaaS transactions across segments, regions, and products
**Portfolio:** [github.com/erikroa](https://github.com/erikroa)

🔗 **[Live Dashboard](https://lookerstudio.google.com)**

---

## Business Purpose

This project answers five core RevOps questions:

1. Which customer segments and products drive the most revenue and profit?
2. How is revenue trending month over month and year over year?
3. What is the impact of discounting on profit margins?
4. Which regions are over- or underperforming?
5. Where is discount abuse eroding profitability?

---

## Project Structure

revenue-ops-analytics/
├── data/
│   └── saas_sales.csv          # Raw source data (9,994 transactions)
├── sql/
│   ├── 01_explore_schema.sql   # Data exploration and null checks
│   ├── 02_data_cleaning.sql    # CREATE VIEW with derived metrics
│   └── 03_revenue_analysis.sql # 7 revenue analysis queries
├── looker_studio/
│   └── dashboard_config.md     # Dashboard documentation
└── README.md

---

## SQL Methodology

### Step 1 - Exploration (`01_explore_schema.sql`)
Row counts, date ranges, unique dimension counts, segment breakdown, and NULL checks across critical columns.

### Step 2 - Cleaning (`02_data_cleaning.sql`)
Creates `revenue_ops.saas_sales_cleaned` view with:
- Standardized column names
- Extracted date parts (year, month, quarter)
- Derived metrics: cost, profit margin %, net sales, discount tier

### Step 3 - Analysis (`03_revenue_analysis.sql`)
Seven business-focused queries:

| Query | Business Question |
|---|---|
| Revenue by segment | Which segments drive the most value? |
| Revenue by product | Which products are most profitable? |
| Monthly trend | How is revenue growing over time? |
| Discount impact | How does discounting affect margins? |
| Regional breakdown | Where is revenue concentrated? |
| YoY growth by segment | Which segments are accelerating? |
| Discount abuse detection | Where is over-discounting destroying profit? |

---

## Key Finding

Deals with discounts above 40% generate **negative profit margins of -108.9%** on average - destroying $99K in profit across 933 transactions. This is the kind of RevOps red flag that directly informs pricing governance and sales compensation design.

| Discount Tier | Deals | Revenue | Profit | Avg Margin |
|---|---|---|---|---|
| No Discount | 4,798 | $1,087,908 | $320,988 | 34.0% |
| Low (1-20%) | 3,803 | $846,522 | $100,785 | 17.4% |
| Medium (21-40%) | 460 | $234,138 | -$35,817 | -16.7% |
| High (41%+) | 933 | $128,632 | -$99,559 | -108.9% |

---

## Author

**Erik** - Senior CX Operations Manager at Shiftmove · GCP Data Analytics Certified
Transitioning from Customer Success into Revenue Operations & Data Analytics.

[LinkedIn](https://linkedin.com/in/erikroa) · [GitHub](https://github.com/erikroa)
