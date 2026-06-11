-- Query 1: Top 5 Customers by Spend
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY total_spent DESC
LIMIT 5;

-- Query 2: Monthly Revenue Trend with LAG
WITH MonthlyRevenue AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_amount) AS revenue
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue
FROM MonthlyRevenue;

-- Query 3: Products Never Ordered
SELECT p.name
FROM products p
LEFT JOIN order_items oi ON p.id = oi.product_id
WHERE oi.product_id IS NULL;

-- Query 4: Kolkata VIPs who spent > avg
WITH CustomerSpend AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT c.name, cs.total_spent
FROM customers c
JOIN CustomerSpend cs ON c.id = cs.customer_id
WHERE c.city = 'Kolkata'
AND cs.total_spent > (SELECT AVG(total_spent) FROM CustomerSpend);

-- Query 5: Category Bestsellers using RANK
SELECT category, product_name, total_qty_sold
FROM (
    SELECT 
        p.category,
        p.name AS product_name,
        SUM(oi.quantity) AS total_qty_sold,
        RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity) DESC) AS rnk
    FROM products p
    JOIN order_items oi ON p.id = oi.product_id
    GROUP BY p.category, p.id, p.name
) ranked
WHERE rnk = 1;