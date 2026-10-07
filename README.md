# PL/SQL Assignment One - Sunrise Supermarket

**Student Name:** NKUBITO Solomon Nobel  
**Student ID:** 20252SEN276  
**Database System Used:** Oracle Database / Oracle FreeSQL  

---

## 1. Short Summary
In this assignment, I designed and populated a relational database for Sunrise Supermarket consisting of `customers`, `products`, `orders`, and `order_items`. I wrote SQL queries using INNER/LEFT JOINs, Common Table Expressions (CTEs), and Window Functions (`DENSE_RANK`, `ROW_NUMBER`, `SUM OVER`, `LAG`) to extract business insights regarding sales performance, customer demographics, and ordering frequencies.

---

## 2. Business Scenario
Sunrise Supermarket wants to analyze retail trends to improve inventory management and targeted marketing. Key business objectives include:
- Identifying customer purchasing frequency and top geographical markets.
- Uncovering high-value customers spending above the store average.
- Tracking cumulative revenue over time.
- Measuring customer re-order intervals to improve retention.

---

## 3. How to Run the Code
1. Open Oracle FreeSQL or your preferred Oracle SQL client.
2. Execute `schema_and_data.sql` to build the database tables and insert sample records.
3. Execute `queries.sql` to run all analytical queries.

---

## 4. Query Explanations & Business Interpretations

### A. JOIN Queries
1. **Order Details (INNER JOIN):** Links `orders` and `customers` to map order IDs to customer names and cities.
2. **Order Line Items (JOIN):** Connects `order_items` with `products` to display line item totals and categories.
3. **Customer Activity (LEFT JOIN):** Lists all customers, including those who have never placed an order (e.g., Edward Nygma).
   - *Business Insight:* Inactive customers can be targeted with promotional discount codes to drive initial conversion.

### B. Common Table Expression (CTE) Query
1. **Above-Average Spenders:** Computes each customer's total spend and filters for those exceeding the store's average customer spend.
   - *Business Insight:* Highlights VIP customers for exclusive loyalty reward programs.

### C. Window Functions
1. **Customer Rank (`DENSE_RANK`):** Ranks customers based on total spend without skipping rank values.
2. **Order Sequence (`ROW_NUMBER`):** Numbers orders sequentially per customer to identify repeat buyers.
3. **Cumulative Revenue (`SUM OVER`):** Calculates a running total of daily revenue across all orders.
   - *Business Insight:* Helps management track sales velocity against monthly financial targets.
4. **Order Recency (`LAG`):** Measures the exact number of days between consecutive orders for multi-order customers.
   - *Business Insight:* Identifies the typical re-purchase cycle to optimize automated email reminders.

---

## 5. Challenges & Resolutions
- **Challenge:** Avoiding invalid aggregation errors when calculating average spend across customers with zero orders.
  - **Resolution:** Used `LEFT JOIN` and applied `NVL(..., 0)` to assign zero spend to inactive accounts before calculating averages.
- **Challenge:** Computing date differences between consecutive orders in Oracle PL/SQL.
  - **Resolution:** Leveraged the `LAG()` window function partitioned by `customer_id` and subtracted previous order dates directly.
