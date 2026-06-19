================================================
Business Question:
Which product leads each category in revenue performance across APAC? 
What is the rank of every product within its category?

Why this matters:
Identifies hero products that drive disproportionate revenue within each category. 
Used by commercial and merchandising teams to prioritise stock allocation, boutique training, and client recommendation strategies.

Business Action:
Top product per category highlighted in client advisor training. 
Bottom-ranked products reviewed for assortment rationalisation or promotional activation to improve contribution.
================================================

WITH product_revenue AS (
    SELECT
        p.category,
        t.product_name,
        SUM(t.revenue)                  AS total_revenue,
        COUNT(DISTINCT t.order_id)      AS order_count
    FROM retail_transactions t
    JOIN (
        SELECT DISTINCT product_name, category
        FROM retail_transactions
    ) p ON t.product_name = p.product_name
    GROUP BY p.category, t.product_name
),
ranked AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_revenue DESC
        )                               AS rank_in_category
    FROM product_revenue
)
SELECT
    category,
    product_name,
    total_revenue,
    order_count,
    rank_in_category
FROM ranked
WHERE rank_in_category <= 2
ORDER BY category, rank_in_category;
