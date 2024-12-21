-- Step 1: Create a Materialized View for Sales Summary
-- The materialized view precomputes total orders and total sales per product for faster query execution.

CREATE MATERIALIZED VIEW mv_sales_summary AS
SELECT 
    p.product_name, 
    COUNT(o.order_id) AS total_orders, 
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM 
    order_items oi
JOIN 
    orders o 
ON 
    oi.order_id = o.order_id
JOIN 
    products p 
ON 
    oi.product_id = p.product_id
GROUP BY 
    p.product_name;

-- Step 2: Query Top 5 Products by Total Sales
-- This query retrieves the top 5 products with the highest total sales from the materialized view.

SELECT 
    product_name, 
    total_sales
FROM 
    mv_sales_summary
ORDER BY 
    total_sales DESC
LIMIT 5;

-- Step 3: Query Top 5 Products by Average Order Value
-- This query calculates the average order value (total sales divided by total orders) for each product
-- and retrieves the top 5 products with the highest average order value.

SELECT 
    product_name, 
    total_sales / total_orders AS avg_order_value
FROM 
    mv_sales_summary
ORDER BY 
    avg_order_value DESC
LIMIT 5;
