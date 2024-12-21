CREATE TABLE customers (
    customer_id INT PRIMARY KEY,  -- Customer ID
    country VARCHAR(100)          -- Country of each customer
);

CREATE TABLE products (
    product_id VARCHAR(20) PRIMARY KEY,  -- StockCode used as product_id
    product_name VARCHAR(255),          -- Description used as product_name
    price DECIMAL(10, 2)                -- Price of each product
);

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,   -- Invoice used as order_id
    customer_id INT,                    -- Customer ID
    order_date TIMESTAMP,               -- InvoiceDate used as order_date
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT IDENTITY(1, 1) PRIMARY KEY, -- Auto-incrementing ID for each line item
    order_id VARCHAR(20),                         -- Invoice used as order_id
    product_id VARCHAR(20),                       -- StockCode used as product_id
    quantity INT,                                 -- Quantity of each product
    unit_price DECIMAL(10, 2),                    -- Price used as unit_price
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);