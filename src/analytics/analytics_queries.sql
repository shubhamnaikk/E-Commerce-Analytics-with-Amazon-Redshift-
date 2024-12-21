-- Query 1: Total Sales Per Product
SELECT 
    p.product_name, 
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM 
    order_items oi
JOIN 
    products p 
ON 
    oi.product_id = p.product_id
GROUP BY 
    p.product_name
ORDER BY 
    total_sales DESC;

-- Query 2: Total Orders Per Customer
SELECT 
    c.customer_id, 
    COUNT(o.order_id) AS total_orders
FROM 
    customers c
JOIN 
    orders o 
ON 
    c.customer_id = o.customer_id
GROUP BY 
    c.customer_id
ORDER BY 
    total_orders DESC;

-- Query 3: Total Spending Per Customer
SELECT 
    c.customer_id, 
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM 
    customers c
JOIN 
    orders o 
ON 
    c.customer_id = o.customer_id
JOIN 
    order_items oi 
ON 
    o.order_id = oi.order_id
GROUP BY 
    c.customer_id
ORDER BY 
    total_spent DESC;

-- Query 4: Total Quantity Sold Per Product
SELECT 
    p.product_name, 
    SUM(oi.quantity) AS total_quantity_sold
FROM 
    products p
JOIN 
    order_items oi 
ON 
    p.product_id = oi.product_id
GROUP BY 
    p.product_name
ORDER BY 
    total_quantity_sold DESC;

-- Query 5: Total Sales Per Country
SELECT 
    c.country, 
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM 
    customers c
JOIN 
    orders o 
ON 
    c.customer_id = o.customer_id
JOIN 
    order_items oi 
ON 
    o.order_id = oi.order_id
GROUP BY 
    c.country
ORDER BY 
    total_sales DESC;

-- Query 6: Monthly Sales Trends
SELECT 
    DATE_TRUNC('month', o.order_date) AS month, 
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM 
    orders o
JOIN 
    order_items oi 
ON 
    o.order_id = oi.order_id
GROUP BY 
    DATE_TRUNC('month', o.order_date)
ORDER BY 
    month;

-- Query 7: Average Order Value Per Customer
SELECT 
    c.customer_id, 
    AVG(oi.quantity * oi.unit_price) AS avg_order_value
FROM 
    customers c
JOIN 
    orders o 
ON 
    c.customer_id = o.customer_id
JOIN 
    order_items oi 
ON 
    o.order_id = oi.order_id
GROUP BY 
    c.customer_id
ORDER BY 
    avg_order_value DESC;
