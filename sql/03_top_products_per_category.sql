================================================
Business Question:
Which product leads each category in revenue performance across APAC? 
What is the rank of every product within its category?

Purpose:
Identifies hero products that drive disproportionate revenue within each category. 
Used by commercial and merchandising teams to prioritise stock allocation, boutique training, and client recommendation strategies.

Business Action:
Top product per category highlighted in client advisor training. 
Bottom-ranked products reviewed for assortment rationalisation or promotional activation to improve contribution.
================================================
QUERY
    
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


 ================================================================
 Top 2 products by revenue within each category
 ----------------------------------------------------------------
 Category        Product                    Revenue  Orders     AOV
 --------------------------------------------------------------------
 Watches         Mademoiselle Prive        649,280      66   9,837
                 Boy.Friend                376,607      55   6,847
 Ready-to-Wear   Camellia Brooch Dress     458,643      86   5,333
                 Little Black Dress        298,573      71   4,205
 Handbags        Deauville Tote            310,131      66   4,699
                 Business Affinity         292,023      72   4,056
 Jewellery       Ultra Bracelet            308,971      62   4,983
                 No.5 Necklace             257,440      81   3,178
 Shoes           Ankle Boots               121,783      55   2,214
                 Espadrilles                54,892      58     946
 Accessories     Chain Belt                 68,029      64   1,063
                 Leather Gloves             67,024      92     729
 Skincare        Sublimage Creme            48,888      51     959
                 Sublimage Essence          35,110      51     688
 Fragrance       Bleu de CHANEL 100ml       24,455      45     543
                 Coco Mademoiselle 100ml    22,567      50     451
 Gifting         Holiday Collection         25,750      40     644
                 Festive Makeup Set         20,946      38     551
 Eyewear         Shield                     21,300      26     819
                 Cat Eye                    17,705      24     738
 Home            Crystal Vase               15,029      16     939
                 Porcelain Cup Set          14,445      20     722
 Makeup          CC Cream                   13,171      36     366
                 Mascara Volume              9,317      44     212
 ================================================================
