================================================
Business Question:
What is each market's cumulative revenue over time and what percentage of total APAC revenue does each market represent?

Purpose:
Running totals show how markets compound over time and reveal concentration risk. 
Used in quarterly strategic reviews and annual planning to monitor regional revenue distribution.

Business Action:
Markets below 5% of regional revenue assessed for growth investment or strategic deprioritisation.
Markets above 30% monitored for concentration risk and contingency planning.
================================================
QUERY
    
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


 ================================================================
 Australia Sample — cumulative revenue, Jan 2023 to Dec 2024
 ----------------------------------------------------------------
 Month     |   Monthly  |  Running   | % of AU | % of APAC
 ----------|------------|------------|---------|----------
 2023-01   |  58,503.50 |  58,503.50 |    8.1% |     1.0%
 2023-02   |  25,097.90 |  83,601.40 |   11.6% |     1.4%
 2023-03   |  35,414.50 | 119,015.90 |   16.5% |     1.9%
 2023-04   |  16,086.10 | 135,102.00 |   18.7% |     2.2%
 2023-05   |  50,927.90 | 186,029.90 |   25.8% |     3.0%
 2023-06   |  42,433.60 | 228,463.50 |   31.6% |     3.7%
 2023-07   |  30,019.50 | 258,483.00 |   35.8% |     4.2%
 2023-08   |  23,458.00 | 281,941.00 |   39.0% |     4.6%
 2023-09   |  22,886.50 | 304,827.50 |   42.2% |     5.0%
 2023-10   |  13,316.40 | 318,143.90 |   44.0% |     5.2%
 2023-11   |  49,561.60 | 367,705.50 |   50.9% |     6.0%
 2023-12   |  14,204.20 | 381,909.70 |   52.9% |     6.2%
 2024-01   |  21,138.80 | 403,048.50 |   55.8% |     6.6%
 2024-02   |  16,276.90 | 419,325.40 |   58.0% |     6.8%
 2024-03   |  40,834.30 | 460,159.70 |   63.7% |     7.5%
 2024-04   |  46,291.20 | 506,450.90 |   70.1% |     8.2%
 2024-05   |  22,641.40 | 529,092.30 |   73.2% |     8.6%
 2024-06   |  35,260.40 | 564,352.70 |   78.1% |     9.2%
 2024-07   |  24,737.00 | 589,089.70 |   81.5% |     9.6%
 2024-08   |  61,115.60 | 650,205.30 |   90.0% |    10.6%
 2024-09   |   9,729.41 | 659,934.71 |   91.3% |    10.7%
 2024-10   |  14,005.50 | 673,940.21 |   93.3% |    11.0%
 2024-11   |  11,857.60 | 685,797.81 |   94.9% |    11.2%
 2024-12   |  36,681.00 | 722,478.81 |  100.0% |    11.8%
 ================================================================
