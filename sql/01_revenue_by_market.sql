================================================
Business Question:
Which APAC markets generated the highest total revenue and order volume over the analysis period?

Why this matters:
Identifies top-performing markets for commercial investment and underperforming markets that need attention. 
Used by regional leadership to prioritise where to focus sales and activation resources.
  
Business Action:
Markets in the bottom 3 by revenue flagged for commercial review. 
Top market used as benchmark for best-practice sharing across the region.
================================================

SELECT 
    market,
    SUM(revenue)                        AS total_revenue,
    COUNT(DISTINCT order_id)            AS order_count,
    ROUND(AVG(revenue), 2)              AS avg_order_value
FROM retail_transactions
GROUP BY market
HAVING total_revenue > 0
ORDER BY total_revenue DESC;
