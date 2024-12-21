COPY customers (customer_id, country)
FROM 's3://ecombuckethw1/customers.csv'
IAM_ROLE 'arn:aws:iam::123456789012:role/dummy-role'
CSV
IGNOREHEADER 1;

COPY products (product_id, product_name, price)
FROM 's3://ecombuckethw1/products.csv'
IAM_ROLE 'arn:aws:iam::123456789012:role/dummy-role'
CSV
IGNOREHEADER 1;

COPY orders (order_id, customer_id, order_date)
FROM 's3://ecombuckethw1/orders.csv'
IAM_ROLE 'arn:aws:iam::123456789012:role/dummy-role'
CSV
IGNOREHEADER 1;

COPY order_items (order_id, product_id, quantity, unit_price)
FROM 's3://ecombuckethw1/order_items.csv'
IAM_ROLE 'arn:aws:iam::123456789012:role/dummy-role'
CSV
IGNOREHEADER 1;