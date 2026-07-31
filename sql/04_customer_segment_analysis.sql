================================================
Business Question:
Which customer segments drive the most revenue across product categories? 
How does average order value and purchase frequency vary by segment and category combination?

Purpose:
Understanding which segments buy which categories at what value informs targeted clienteling strategy.
Used by client service teams to prioritise outreach and personalise product recommendations by segment.
  
Business Action:
High-value segment and category combinations used to define upgrade targets. 
Low-value combinations reviewed for activation opportunity or deprioritised in outreach planning.
================================================
QUERY
  
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


 ================================================================
 Sample Elite Segment : Revenue and customer reach by category
 ----------------------------------------------------------------
 Category         Revenue  Orders  Custs      AOV  Ord/Cust
 ------------------------------------------------------------------
 Handbags         911,935     157    108   5,808.50    1.45
 Watches          682,213      97     73   7,033.12    1.33
 Ready-to-Wear    624,656     138    107   4,526.49    1.29
 Jewellery        567,225     148    112   3,832.60    1.32
 Shoes            127,618      84     67   1,519.26    1.25
 Accessories       98,325     142    104     692.43    1.37
 Skincare          28,078      43     36     652.97    1.19
 Eyewear           14,526      19     19     764.54    1.00
 Gifting           13,275      24     24     553.11    1.00
 Fragrance         13,241      31     28     427.13    1.11
 Home              12,349      14     13     882.07    1.08
 Makeup            10,800      27     24     400.00    1.13
 ------------------------------------------------------------------
 Total          3,104,241     924      —   3,359.57       —
-- ================================================================
