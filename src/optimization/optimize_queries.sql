-- Step 1: Create an optimized table for orders with DISTKEY and SORTKEY
-- The DISTKEY is set on customer_id to co-locate data for joins between orders and customers.
-- The SORTKEY is set on order_date to optimize queries involving date ranges.

CREATE TABLE orders_dist
DISTSTYLE KEY
DISTKEY(customer_id)
SORTKEY(order_date)
AS
SELECT * FROM orders;

-- Step 2: Create an optimized table for order_items with DISTKEY and SORTKEY
-- The DISTKEY is set on order_id to co-locate data for joins between orders and order_items.
-- The SORTKEY is set on product_id to optimize product-specific queries.

CREATE TABLE order_items_dist
DISTSTYLE KEY
DISTKEY(order_id)
SORTKEY(product_id)
AS
SELECT * FROM order_items;

-- Step 3: Insert data into the optimized tables
-- This step populates the newly created tables with the data from the original tables.

INSERT INTO orders_dist
SELECT * FROM orders;

INSERT INTO order_items_dist
SELECT * FROM order_items;

-- Step 4: Run ANALYZE to update table statistics
-- This step ensures that the Redshift query planner has up-to-date statistics for the tables,
-- which helps in optimizing query execution.

ANALYZE orders_dist;
ANALYZE order_items_dist;

-- Step 5: Run VACUUM to sort and reclaim space
-- This step ensures that the data is sorted according to the SORTKEY and reclaims storage space.

VACUUM orders_dist;
VACUUM order_items_dist;
