================================================
Business Question:
How is each market's revenue trending month on month? 
Which markets are growing and which are declining?

Purpose:
A single revenue number tells you where you are.
MoM growth tells you where you are heading.
Used in weekly commercial reviews to identify markets that need early intervention before end-of-quarter performance misses.

Business Action:
Markets with 3+ consecutive months of decline flagged for urgent commercial review. 
Markets with >10% MoM growth flagged for investment to sustain momentum.
================================================
QUERY
    
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

 ================================================================
 Sample Australia — monthly revenue, 2023 vs 2024
 ----------------------------------------------------------------
 Month |    2023    |    2024    |   YoY
 ------|------------|------------|--------
 Jan   |  58,503.50 |  21,138.80 |  -63.9%
 Feb   |  25,097.90 |  16,276.90 |  -35.1%
 Mar   |  35,414.50 |  40,834.30 |  +15.3%
 Apr   |  16,086.10 |  46,291.20 | +187.8%
 May   |  50,927.90 |  22,641.40 |  -55.5%
 Jun   |  42,433.60 |  35,260.40 |  -16.9%
 Jul   |  30,019.50 |  24,737.00 |  -17.6%
 Aug   |  23,458.00 |  61,115.60 | +160.5%
 Sep   |  22,886.50 |   9,729.41 |  -57.5%
 Oct   |  13,316.40 |  14,005.50 |   +5.2%
 Nov   |  49,561.60 |  11,857.60 |  -76.1%
 Dec   |  14,204.20 |  36,681.00 | +158.2%
 ------|------------|------------|--------
 Total | 381,909.70 | 340,569.11 |  -10.8%
 ================================================================
