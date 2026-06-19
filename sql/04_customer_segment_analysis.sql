================================================
Business Question:
Which customer segments drive the most revenue across product categories? 
How does average order value and purchase frequency vary by segment and category combination?

Why this matters:
Understanding which segments buy which categories at what value informs targeted clienteling strategy.
Used by client service teams to prioritise outreach and personalise product recommendations by segment.
  
Business Action:
High-value segment and category combinations used to define upgrade targets. 
Low-value combinations reviewed for activation opportunity or deprioritised in outreach planning.
================================================

SELECT
    t.segment,
    t.category,
    SUM(t.revenue)                      AS total_revenue,
    COUNT(DISTINCT t.order_id)          AS order_count,
    COUNT(DISTINCT t.customer_id)       AS unique_customers,
    ROUND(
        SUM(t.revenue) /
        COUNT(DISTINCT t.order_id), 2
    )                                   AS avg_order_value
FROM retail_transactions t
JOIN customer_profiles c
    ON t.customer_id = c.customer_id
GROUP BY t.segment, t.category
HAVING total_revenue > 1000
ORDER BY t.segment, total_revenue DESC;
