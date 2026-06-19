================================================
Business Question:
How is each market's revenue trending month on month? 
Which markets are growing and which are declining?

Why this matters:
A single revenue number tells you where you are.
MoM growth tells you where you are heading.
Used in weekly commercial reviews to identify markets that need early intervention before end-of-quarter performance misses.

Business Action:
Markets with 3+ consecutive months of decline flagged for urgent commercial review. 
Markets with >10% MoM growth flagged for investment to sustain momentum.
================================================

WITH monthly_revenue AS (
    SELECT
        market,
        strftime('%Y-%m', order_date)       AS year_month,
        SUM(revenue)                        AS total_revenue
    FROM retail_transactions
    GROUP BY market, year_month
),
with_lag AS (
    SELECT
        market,
        year_month,
        total_revenue,
        LAG(total_revenue) OVER (
            PARTITION BY market
            ORDER BY year_month
        )                                   AS prev_month_revenue
    FROM monthly_revenue
)
SELECT
    market,
    year_month,
    total_revenue,
    prev_month_revenue,
    ROUND(
        (total_revenue - prev_month_revenue)
        / prev_month_revenue * 100, 1
    )                                       AS mom_pct_change
FROM with_lag
ORDER BY market, year_month;
