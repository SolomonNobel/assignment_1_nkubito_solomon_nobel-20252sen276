
SELECT 
    o.order_id,
    c.customer_name,
    c.city,
    o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- 2. List every order item with product name, category, price, and quantity
SELECT 
    oi.order_item_id,
    oi.order_id,
    p.product_name,
    p.category,
    p.price,
    oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_item_id;

-- 3. List all customers and their orders, including customers with no orders
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_id;


WITH CustomerSpend AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        NVL(SUM(oi.quantity * p.price), 0) AS total_spend
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    LEFT JOIN products p ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT 
    customer_id,
    customer_name,
    total_spend
FROM CustomerSpend
WHERE total_spend > (SELECT AVG(total_spend) FROM CustomerSpend)
ORDER BY total_spend DESC;


-- 1. Rank customers by total amount spent
WITH CustomerTotals AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        NVL(SUM(oi.quantity * p.price), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    LEFT JOIN products p ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT 
    customer_id,
    customer_name,
    total_spent,
    DENSE_RANK() OVER (ORDER BY total_spent DESC) AS spend_rank
FROM CustomerTotals;

-- 2. Number each customer's orders in chronological order
SELECT 
    c.customer_name,
    o.order_id,
    o.order_date,
    ROW_NUMBER() OVER (
        PARTITION BY o.customer_id 
        ORDER BY o.order_date ASC, o.order_id ASC
    ) AS customer_order_number
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY c.customer_name, customer_order_number;

-- 3. Running total of revenue over time
WITH DailyRevenue AS (
    SELECT 
        o.order_date,
        SUM(oi.quantity * p.price) AS daily_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY o.order_date
)
SELECT 
    order_date,
    daily_total,
    SUM(daily_total) OVER (
        ORDER BY order_date ASC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_revenue
FROM DailyRevenue
ORDER BY order_date;

-- 4. Days between current and previous order for customers with multiple orders
WITH CustomerOrders AS (
    SELECT 
        c.customer_name,
        o.order_id,
        o.order_date,
        LAG(o.order_date) OVER (
            PARTITION BY o.customer_id 
            ORDER BY o.order_date ASC
        ) AS prev_order_date,
        COUNT(*) OVER (PARTITION BY o.customer_id) AS total_orders_by_cust
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
)
SELECT 
    customer_name,
    order_id,
    order_date,
    prev_order_date,
    ROUND(order_date - prev_order_date) AS days_since_last_order
FROM CustomerOrders
WHERE total_orders_by_cust > 1
ORDER BY customer_name, order_date;
