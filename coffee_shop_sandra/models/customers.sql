{{ config(
  materialized='table'
) }}

with orders_by_customer AS (
  select 
    customer_id,
    min(created_at) first_order_at,
    count(*) number_of_orders
  from
    `analytics-engineers-club.coffee_shop.orders`
  group by
    customer_id
)

select
  orders_by_customer.customer_id,
  customers.name,
  customers.email,
  orders_by_customer.first_order_at,
  orders_by_customer.number_of_orders
from
  `analytics-engineers-club.coffee_shop.customers` AS customers
left join
  orders_by_customer
on
  customers.id = orders_by_customer.customer_id
order by
  orders_by_customer.first_order_at