================================================
Business Question:
Which APAC markets generated the highest total revenue and order volume over the analysis period?

Purpose:
Identifies top-performing markets for commercial investment and underperforming markets that need attention. 
Used by regional leadership to prioritise where to focus sales and activation resources.
  
Business Action:
Markets in the bottom 3 by revenue flagged for commercial review. 
Top market used as benchmark for best-practice sharing across the region.
================================================
QUERY
  
SELECT 
    market,
    SUM(revenue)                        AS total_revenue,
    COUNT(DISTINCT order_id)            AS order_count,
    ROUND(AVG(revenue), 2)              AS avg_order_value
FROM retail_transactions
GROUP BY market
HAVING total_revenue > 0
ORDER BY total_revenue DESC;


 ================================================================
 Results (8 markets, analysis period)
 ----------------------------------------------------------------
 market      | total_revenue | order_count | avg_order_value
 ------------|---------------|-------------|----------------
 Hong Kong   |  1,251,537.71 |         575 |        2,176.59
 China       |  1,244,479.88 |         627 |        1,984.82
 Korea       |    850,303.96 |         451 |        1,885.37
 Macau       |    763,767.66 |         394 |        1,938.50
 Australia   |    722,478.59 |         315 |        2,293.58
 Singapore   |    590,018.53 |         307 |        1,921.88
 Thailand    |    425,254.42 |         222 |        1,915.56
 Vietnam     |    292,294.06 |         162 |        1,804.28
 ----------------------------------------------------------------
