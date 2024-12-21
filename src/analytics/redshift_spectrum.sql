-- Step 1: Create an External Schema
-- The external schema links Redshift to the S3 data catalog for querying external data.

CREATE EXTERNAL SCHEMA spectrum_schema
FROM data catalog
DATABASE 'ecomdatahw1'  -- Replace with your database name
IAM_ROLE 'arn:aws:iam::your-account-id:role/YourRedshiftRole';  -- Replace with your IAM role ARN

-- Step 2: Create an External Table
-- The external table defines the structure of the data stored in S3.
-- It is assumed the data is stored in Parquet format.

CREATE EXTERNAL TABLE spectrum_schema.external_products (
    product_id INT,
    product_name VARCHAR(255), -- Replaced STRING with VARCHAR for compatibility
    category VARCHAR(100),     -- Replaced STRING with VARCHAR for compatibility
    price DECIMAL(10, 2)
)
STORED AS PARQUET
LOCATION 's3://your-bucket/external-products/'; -- Replace with your S3 bucket and file path

-- Step 3: Query 1 - Retrieve the Top 5 Products by Category and Price
-- This query fetches the top 5 products from the external table,
-- sorted by category and price in descending order.

SELECT 
    category, 
    product_name, 
    price
FROM 
    spectrum_schema.external_products
ORDER BY 
    category, 
    price DESC
LIMIT 5;

-- Step 4: Query 2 - Calculate the Average Price per Category
-- This query calculates the average price of products for each category
-- to derive pricing insights across categories.

SELECT 
    category, 
    AVG(price) AS average_price
FROM 
    spectrum_schema.external_products
GROUP BY 
    category
ORDER BY 
    average_price DESC;
