# Amazon Redshift E-commerce Data Analysis Project

## Overview
This project demonstrates the use of Amazon Redshift for analyzing e-commerce data. It covers the end-to-end setup of an Amazon Redshift cluster, integration with AWS services, data ingestion, query optimization, advanced analytics, and insights generation.

## Objectives
1. Analyze e-commerce datasets to generate actionable business insights.
2. Optimize query performance using Amazon Redshift's advanced features.
3. Use Redshift Spectrum to query external datasets stored in AWS S3.
4. Demonstrate the workflow and architecture of the project with detailed steps and advanced features.

## Workflow Diagram
Below is the workflow diagram of the project:

![Workflow Diagram](diagram.png)

## Key Steps

### 1. Setup
- **Amazon S3 Bucket:** E-commerce dataset stored securely in an S3 bucket.
- **IAM Role:** Configured to grant Redshift secure access to the S3 bucket.
- **Redshift Cluster Configuration:**
  - Node Type: `dc2.large`
  - Number of Nodes: `2`
  - Publicly Accessible: Enabled for external client access.

### 2. Amazon Redshift Cluster
- **Cluster Configuration:**
  - Database Name: `ecomdatahw1`
  - Admin Username and Password: Used for secure administrative access.
- **Security Groups:** Configured inbound rules to allow connections from specific IP addresses on port 5439.
- **SQL Client Connection:** SQL Workbench/J was used to establish secure connections to the cluster for query execution.

### 3. Data Preparation and Ingestion
- **Dataset Description:**
  - Includes customer, product, order, and order item details sourced from Kaggle.
  - Data stored in S3 for seamless integration with Redshift.
- **Schema Design:**
  - Tables are organized in a star schema for optimized querying.
  - Tables include `customers`, `products`, `orders`, and `order_items`.
- **Data Loading:**
  - Used the `COPY` command to ingest data from S3 into Redshift.

### 4. Query Optimization
- **DISTKEY and SORTKEY:**
  - `DISTKEY(customer_id)`: Optimized joins between orders and customers.
  - `SORTKEY(order_date)`: Accelerated date-range queries.
- **ANALYZE and VACUUM:**
  - Maintained table performance by updating query statistics and reclaiming storage.

### 5. Advanced Features
- **Materialized Views:**
  - Precomputed and stored query results for faster analytics.
  - Example Query:
    ```sql
    CREATE MATERIALIZED VIEW mv_sales_summary AS
    SELECT p.product_name, COUNT(o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_name;
    ```
- **Redshift Spectrum:**
  - Used to query external data directly from S3 without loading it into Redshift.
  - Example Query:
    ```sql
    CREATE EXTERNAL TABLE spectrum_schema.external_products (
        product_id INT,
        product_name VARCHAR(255),
        category VARCHAR(100),
        price DECIMAL(10, 2)
    )
    STORED AS PARQUET
    LOCATION 's3://ecombuckethw1/products/';
    ```

### 6. Insights Derived
- **Key Queries:**
  - Total Sales per Product:
    ```sql
    SELECT p.product_name, SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_name
    ORDER BY total_sales DESC;
    ```
  - Customer Purchase History:
    ```sql
    SELECT c.customer_id, COUNT(o.order_id) AS total_orders
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
    ORDER BY total_orders DESC;
    ```
- **Derived Insights:**
  - **Top Products:** Highest revenue-generating products identified.
  - **Revenue Distribution:** Country-wise sales revenue breakdown.
  - **Seasonal Trends:** Sales spikes in December and September indicating holiday-driven demand.

## Technologies Used
1. **Amazon Redshift:** Core data warehouse for analytics.
2. **AWS S3:** Storage for raw and external datasets.
3. **IAM:** Secure role-based access control.
4. **SQL Workbench/J:** SQL client for query execution.
5. **Redshift Spectrum:** Real-time analytics on external data.

## Results
This project achieved:
- Identification of high-performing products and customer behaviors.
- Efficient analytics using query optimizations and materialized views.
- Real-time external data analysis with Redshift Spectrum.
- Actionable business insights supporting data-driven decision-making.

## How to Run the Project
1. Set up an Amazon Redshift cluster with access to your S3 bucket.
2. Load data into the cluster using the provided schema and `COPY` commands.
3. Execute the queries provided in the project for insights.
4. Use Redshift Spectrum for external analytics.

---

For more information, refer to the workflow diagram above or contact [Shubham Manisha Naik].
