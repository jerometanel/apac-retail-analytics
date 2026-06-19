================================================
Business Question:
What is each market's cumulative revenue over time and what percentage of total APAC revenue does each market represent?

Why this matters:
Running totals show how markets compound over time and reveal concentration risk. 
Used in quarterly strategic reviews and annual planning to monitor regional revenue distribution.

Business Action:
Markets below 5% of regional revenue assessed for growth investment or strategic deprioritisation.
Markets above 30% monitored for concentration risk and contingency planning.
================================================

WITH market_monthly AS (
    SELECT
        market,
        strftime('%Y-%m', order_date)   AS year_month,
        SUM(revenue)                    AS monthly_revenue
    FROM retail_transactions
    GROUP BY market, year_month
),
with_running AS (
    SELECT
        market,
        year_month,
        monthly_revenue,
        SUM(monthly_revenue) OVER (
            PARTITION BY market
            ORDER BY year_month
        )                               AS running_total
    FROM market_monthly
),
total_revenue AS (
    SELECT SUM(revenue)                 AS grand_total
    FROM retail_transactions
)
SELECT
    w.market,
    w.year_month,
    w.monthly_revenue,
    w.running_total,
    ROUND(
        w.running_total /
        NULLIF(t.grand_total, 0) * 100, 1
    )                                   AS pct_of_total_revenue
FROM with_running w
CROSS JOIN total_revenue t
ORDER BY w.market, w.year_month;
