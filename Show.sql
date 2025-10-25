SELECT * FROM v_order_summary WHERE status = 'COMPLETED';

-- show customers
SELECT * FROM customer;

-- show product catalog
SELECT product_id, sku, name, price FROM product;

-- show orders and totals
SELECT order_id, customer_id, order_date, status, total_amount FROM `orders`;

-- show order items with computed totals
SELECT * FROM order_item;

SELECT order_id, get_order_total(order_id) AS calculated_total
FROM orders;

SELECT customer_id, get_customer_ltv(customer_id) AS lifetime_value
FROM customer;

CALL add_order(2, '50 Park Street, Kolkata', @new_order_id);
SELECT @new_order_id;

CALL mark_order_paid(1, 2998.00, 'CARD');
