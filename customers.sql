WITH orders_by_customer AS (
  SELECT 
    customer_id,
    MIN(created_at) AS first_order_at,
    COUNT(*) AS number_of_orders
  FROM
    `analytics-engineers-club.coffee_shop.orders`
  GROUP BY
    customer_id
)

SELECT
  orders_by_customer.customer_id,
  customers.name,
  customers.email,
  orders_by_customer.first_order_at,
  orders_by_customer.number_of_orders
FROM
  `analytics-engineers-club.coffee_shop.customers` AS customers
LEFT JOIN
  orders_by_customer
ON
  customers.id = orders_by_customer.customer_id
ORDER BY
  orders_by_customer.first_order_at
LIMIT
  5