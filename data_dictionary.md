# Data Dictionary

## retail_transactions.csv
| Column | Description |
|---|---|
| order_id | Unique transaction identifier |
| customer_id | Unique client identifier |
| market | APAC market (SG, AU, CN, HK, MO, KR, VN, TH) |
| segment | Client tier: New, Regular, Elite, VIC |
| channel | Purchase channel: Boutique, Online, Dept Store |
| category | Product category (12 categories) |
| product_name | Specific product purchased |
| purchase_order | Sequence number for this client |
| order_date | Date of transaction |
| quantity | Units purchased |
| revenue | Transaction revenue in SGD |
| entry_category | First category this client ever bought |

## customer_profiles.csv
| Column | Description |
|---|---|
| customer_id | Unique client identifier |
| market | Client home market |
| segment | Client tier at time of analysis |
| entry_category | First product category purchased |
